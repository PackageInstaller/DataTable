using System;
using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Composites")]
[Description("KiifSwitch 自定义连线条件，在连线处添加条件，Default选项为条件都不满足才会执行，若有俩Default 只会执行前面的Default (float值精准度 <= 0.01)")]
[Icon("IndexSwitcher", false, "")]
[Color("b3ff7f")]
public class KiifSwitch : BTComposite
{
	public enum CaseSelectionMode
	{
		IntBase,
		FloatBase,
		StringBase,
		HeroSkillType
	}

	public CaseSelectionMode selectionMode = CaseSelectionMode.FloatBase;

	[ShowIf("selectionMode", 0)]
	public BBParameter<int> intCase;

	[ShowIf("selectionMode", 1)]
	public BBParameter<float> floatCase;

	[ShowIf("selectionMode", 2)]
	public BBParameter<string> stringCase;

	[ShowIf("selectionMode", 3)]
	public BBParameter<HeroSkillTypeEnum> skillCase;

	private Connection connection;

	private bool isExecuteDefault = true;

	private float error = 0.01f;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.outConnections.Count == 0)
		{
			return Status.Optional;
		}
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			if (CheckCondition(base.outConnections[i], ref connection))
			{
				isExecuteDefault = false;
				base.status = base.outConnections[i].Execute(agent, blackboard);
			}
			else
			{
				base.outConnections[i].Reset();
			}
		}
		if (isExecuteDefault)
		{
			if (connection == null)
			{
				return Status.Failure;
			}
			base.status = connection.Execute(agent, blackboard);
		}
		return base.status;
	}

	private bool CheckCondition(Connection connection, ref Connection defaultConnect)
	{
		if (connection.IsDefault)
		{
			defaultConnect = connection;
		}
		else
		{
			if (string.IsNullOrEmpty(connection.condition))
			{
				return false;
			}
			if (selectionMode == CaseSelectionMode.IntBase)
			{
				return int.Parse(connection.condition) == intCase.value;
			}
			if (selectionMode == CaseSelectionMode.FloatBase)
			{
				return Math.Abs(float.Parse(connection.condition) - floatCase.value) <= error;
			}
			if (selectionMode == CaseSelectionMode.StringBase)
			{
				return string.Equals(connection.condition, stringCase.value);
			}
			if (selectionMode == CaseSelectionMode.HeroSkillType)
			{
				return string.Equals(connection.condition, skillCase?.value.ToString());
			}
		}
		return false;
	}
}
