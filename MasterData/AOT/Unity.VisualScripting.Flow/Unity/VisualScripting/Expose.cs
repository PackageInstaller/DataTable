using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

[SpecialUnit]
public sealed class Expose : Unit, IAotStubbable
{
	[TypeFilter(new Type[] { }, Enums = false)]
	[Serialize]
	[Inspectable]
	public Type type { get; set; }

	[Inspectable]
	[InspectorToggleLeft]
	[Serialize]
	[UnitHeaderInspectable("Instance")]
	public bool instance { get; set; } = true;

	[Serialize]
	[UnitHeaderInspectable("Static")]
	[InspectorToggleLeft]
	[Inspectable]
	public bool @static { get; set; } = true;

	[NullMeansSelf]
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput target { get; private set; }

	[DoNotSerialize]
	public Dictionary<ValueOutput, Member> members { get; private set; }

	public override bool canDefine => type != null;

	public Expose()
	{
	}

	public Expose(Type type)
	{
		this.type = type;
	}

	public override IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		if (members == null)
		{
			yield break;
		}
		foreach (Member value in members.Values)
		{
			if (value != null && value.isReflected)
			{
				yield return value.info;
			}
		}
	}

	protected override void Definition()
	{
		members = new Dictionary<ValueOutput, Member>();
		bool flag = false;
		foreach (Member member in from m in (from m in type.GetMembers()
				where m is FieldInfo || m is PropertyInfo
				select m.ToManipulator(type)).DistinctBy((Member m) => m.name).Where(Include)
			orderby (!m.requiresTarget) ? 1 : 0, m.order
			select m)
		{
			ValueOutput valueOutput = ValueOutput(member.type, member.name, (Flow flow) => GetValue(flow, member));
			if (member.isPredictable)
			{
				valueOutput.Predictable();
			}
			members.Add(valueOutput, member);
			if (member.requiresTarget)
			{
				flag = true;
			}
		}
		if (!flag)
		{
			return;
		}
		target = ValueInput(type, "target").NullMeansSelf();
		target.SetDefaultValue(type.PseudoDefault());
		foreach (ValueOutput key in members.Keys)
		{
			if (members[key].requiresTarget)
			{
				Requirement(target, key);
			}
		}
	}

	private bool Include(Member member)
	{
		if (!instance && member.requiresTarget)
		{
			return false;
		}
		if (!@static && !member.requiresTarget)
		{
			return false;
		}
		if (!member.isPubliclyGettable)
		{
			return false;
		}
		if (member.info.HasAttribute<ObsoleteAttribute>())
		{
			return false;
		}
		if (member.isIndexer)
		{
			return false;
		}
		if (member.name == "runInEditMode" && member.declaringType == typeof(MonoBehaviour))
		{
			return false;
		}
		return true;
	}

	private object GetValue(Flow flow, Member member)
	{
		object obj = (member.requiresTarget ? flow.GetValue(target, member.targetType) : null);
		return member.Get(obj);
	}
}
