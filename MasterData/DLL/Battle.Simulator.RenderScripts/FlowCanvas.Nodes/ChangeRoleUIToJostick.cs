using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更换角色UI为摇杆", 0)]
[Category("Render/UI")]
[Description("更换角色技能按钮为子摇杆\n 定制特效路径:Effect/tongyong/fx_aim_indicator")]
public class ChangeRoleUIToJostick : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> battlePanelVar = AddValueInput<GameObject>("战斗UI", "battlePanelVar");
		ValueInput<int> buttonIndexVar = AddValueInput<int>("技能按钮索引(0-2)", "buttonIndexVar");
		ValueInput<int> sourceTimelineIDVar = AddValueInput<int>("来源技能", "sourceTimelineIDVar");
		ValueInput<float> DamageIndicatorRangeVar = AddValueInput<float>("落点伤害半径", "damageIndicatorRangeVar").SetDefaultAndSerializedValue(0.5f);
		ValueInput<bool> LockEnemyVar = AddValueInput<bool>("锁定敌对", "LockEnemyVar").SetDefaultAndSerializedValue(v: true);
		ValueInput<string> rangeIndicatorPrefabPathVar = AddValueInput<string>("定制特效", "rangeIndicatorPrefabPathVar").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<string> pathInput = AddValueInput<string>("子摇杆路径").SetDefaultAndSerializedValue("UI/BattlePanelEffect/AbilityButtonSubJoystick");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject gameObject = battlePanelVar.value;
			if (gameObject == null)
			{
				gameObject = BattleUI.GetBattleUI().gameObject;
				if (gameObject == null)
				{
					error.Call(f);
					return;
				}
			}
			P08AttackButton[] componentsInChildren = gameObject.GetComponentsInChildren<P08AttackButton>(includeInactive: true);
			P08AttackButton p08AttackButton = null;
			P08AttackButton[] array = componentsInChildren;
			foreach (P08AttackButton p08AttackButton2 in array)
			{
				if (p08AttackButton2.buttonType == (ButtonType)buttonIndexVar.GetValue())
				{
					p08AttackButton = p08AttackButton2;
				}
			}
			if (p08AttackButton != null)
			{
				SubStickController subStickController = p08AttackButton.ChangeType2SubJoystick(pathInput.value);
				if (subStickController != null)
				{
					subStickController.SourceTimelineID = sourceTimelineIDVar.GetValue();
					public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(sourceTimelineIDVar.GetValue());
					AbilityRangeIndicator config2 = ConfigHelper.GetInstance().GetConfig<AbilityRangeIndicator>(sourceTimelineIDVar.GetValue());
					if (config != null && config2 != null)
					{
						subStickController.RangeIndicatorRadius = (float)config.Range / 1000f;
						subStickController.DamageIndicatorRadius = DamageIndicatorRangeVar.GetValue();
						subStickController.IsLockEnemy = LockEnemyVar.GetValue();
						subStickController.RangeIndicatorPrefabPath = rangeIndicatorPrefabPathVar.GetValue();
					}
				}
			}
			output.Call(f);
		});
	}
}
