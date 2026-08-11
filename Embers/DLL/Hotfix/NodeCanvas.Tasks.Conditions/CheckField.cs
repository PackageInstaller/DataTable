using System;
using System.Reflection;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Field", 8)]
[Category("✫ Reflected")]
[Description("Check a field on a script and return if it's equal or not to a value")]
[fsMigrateVersions(new Type[] { typeof(CheckField_0) })]
public class CheckField : ConditionTask, IReflectedWrapper, IMigratable<CheckField_0>, IMigratable
{
	[SerializeField]
	protected BBObjectParameter checkValue;

	[SerializeField]
	protected CompareMethod comparison;

	[SerializeField]
	protected SerializedFieldInfo field;

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
			string text = (targetField.IsStatic ? targetField.RTReflectedOrDeclaredType().FriendlyName() : base.agentInfo);
			return $"{text}.{targetField.Name}{OperationTools.GetCompareString(comparison)}{checkValue}";
		}
	}

	void IMigratable<CheckField_0>.Migrate(CheckField_0 model)
	{
		try
		{
			field = new SerializedFieldInfo(model.targetType?.RTGetField(model.fieldName));
		}
		finally
		{
			checkValue = new BBObjectParameter(model.checkValue);
		}
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

	protected override bool OnCheck()
	{
		if (checkValue.varType == typeof(float))
		{
			return OperationTools.Compare((float)targetField.GetValue(base.agent), (float)checkValue.value, comparison, 0.05f);
		}
		if (checkValue.varType == typeof(int))
		{
			return OperationTools.Compare((int)targetField.GetValue(base.agent), (int)checkValue.value, comparison);
		}
		return ObjectUtils.AnyEquals(targetField.GetValue(base.agent), checkValue.value);
	}

	private void SetTargetField(FieldInfo newField)
	{
		if (newField != null)
		{
			field = new SerializedFieldInfo(newField);
			checkValue.SetType(newField.FieldType);
			comparison = CompareMethod.EqualTo;
		}
	}
}
