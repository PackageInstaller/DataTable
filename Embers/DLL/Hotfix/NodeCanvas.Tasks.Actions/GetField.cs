using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Reflected")]
[Description("Get a variable of a script and save it to the blackboard")]
[Name("Get Field", 6)]
[fsMigrateVersions(new Type[] { typeof(GetField_0) })]
public class GetField : ActionTask, IReflectedWrapper, IMigratable<GetField_0>, IMigratable
{
	[SerializeField]
	protected SerializedFieldInfo field;

	[SerializeField]
	[BlackboardOnly]
	protected BBObjectParameter saveAs;

	private FieldInfo targetField => field;

	public override Type agentType
	{
		get
		{
			if (targetField == null)
			{
				return typeof(Transform);
			}
			if (!targetField.IsStatic)
			{
				return targetField.RTReflectedOrDeclaredType();
			}
			return null;
		}
	}

	protected override string info
	{
		get
		{
			if (field == null)
			{
				return "No Field Selected";
			}
			if (targetField == null)
			{
				return field.AsString().FormatError();
			}
			string arg = (targetField.IsStatic ? targetField.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{saveAs.ToString()} = {arg}.{targetField.Name}";
		}
	}

	void IMigratable<GetField_0>.Migrate(GetField_0 model)
	{
		field = new SerializedFieldInfo(model.targetType?.RTGetField(model.fieldName));
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return field;
	}

	protected override string OnInit()
	{
		if (field == null)
		{
			return "No Field Selected";
		}
		if (targetField == null)
		{
			return field.AsString().FormatError();
		}
		return null;
	}

	protected override void OnExecute()
	{
		saveAs.value = targetField.GetValue(targetField.IsStatic ? null : base.agent);
		EndAction();
	}

	private void SetTargetField(FieldInfo newField)
	{
		if (newField != null)
		{
			field = new SerializedFieldInfo(newField);
			saveAs.SetType(newField.FieldType);
		}
	}
}
