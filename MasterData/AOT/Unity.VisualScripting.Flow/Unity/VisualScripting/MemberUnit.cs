using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[SpecialUnit]
public abstract class MemberUnit : Unit, IAotStubbable
{
	[MemberFilter(Fields = true, Properties = true, Methods = true, Constructors = true)]
	[Serialize]
	public Member member { get; set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput target { get; private set; }

	public override bool canDefine => member != null;

	protected MemberUnit()
	{
	}

	protected MemberUnit(Member member)
		: this()
	{
		this.member = member;
	}

	protected override void Definition()
	{
		member.EnsureReflected();
		if (!IsMemberValid(member))
		{
			throw new NotSupportedException("The member type is not valid for this unit.");
		}
		if (member.requiresTarget)
		{
			target = ValueInput(member.targetType, "target");
			target.SetDefaultValue(member.targetType.PseudoDefault());
			if (typeof(UnityEngine.Object).IsAssignableFrom(member.targetType))
			{
				target.NullMeansSelf();
			}
		}
	}

	protected abstract bool IsMemberValid(Member member);

	public override void Prewarm()
	{
		if (member != null && member.isReflected)
		{
			member.Prewarm();
		}
	}

	public override IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		if (member != null && member.isReflected)
		{
			yield return member.info;
		}
	}
}
