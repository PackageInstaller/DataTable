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
[Description("Set a variable on a script")]
[Name("Set Field", 5)]
[fsMigrateVersions(new Type[] { typeof(SetField_0) })]
public class SetField : ActionTask, IReflectedWrapper, IMigratable<SetField_0>, IMigratable
{
	[SerializeField]
	protected SerializedFieldInfo field;

	[SerializeField]
	protected BBObjectParameter setValue;

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
			return $"{arg}.{targetField.Name} = {setValue}";
		}
	}

	void IMigratable<SetField_0>.Migrate(SetField_0 model)
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
		targetField.SetValue(targetField.IsStatic ? null : base.agent, setValue.value);
		EndAction();
	}

	private void SetTargetField(FieldInfo newField)
	{
		if (newField != null)
		{
			field = new SerializedFieldInfo(newField);
			setValue.SetType(newField.FieldType);
		}
	}
}
