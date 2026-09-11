using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示本轮成就", 0)]
[Category("Render/UI")]
[Description("显示本轮成就, 一条一条弹出当前成就")]
public class ShowCurrentAchievement : FlowNode
{
	private AchievementPanel achievementPanel;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		achievementPanel = null;
	}

	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		FlowOutput closeOut = AddFlowOutput("关闭界面");
		ValueInput<string> pathInput = AddValueInput<string>("GameObject路径").SetDefaultAndSerializedValue("BattlePop/OnlineTower_Achievement");
		ValueInput<string> titleInput = AddValueInput<string>("标题");
		ValueInput<string> timeInput = AddValueInput<string>("时间显示");
		ValueInput<int> stageInput = AddValueInput<int>("完成的波次成就id");
		ValueInput<int> stageTimeInput = AddValueInput<int>("完成的时间成就id");
		FlowOutput ptOut = AddFlowOutput("加PT");
		int pt = 0;
		AddValueOutput("每个成就数值", () => pt);
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				if (achievementPanel == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						return;
					}
					achievementPanel = transform.GetComponent<AchievementPanel>();
					achievementPanel.close.onClick.AddListener(delegate
					{
						closeOut.Call(f);
					});
				}
				if (achievementPanel == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
					if (worldStateManager != null && worldStateManager.data != null)
					{
						List<int> currentAchievement = worldStateManager.data.currentAchievement;
						currentAchievement.Sort(delegate(int x, int y)
						{
							battle_achievement config2 = ConfigHelper.GetInstance().GetConfig<battle_achievement>(x);
							battle_achievement config3 = ConfigHelper.GetInstance().GetConfig<battle_achievement>(y);
							return config2.Priority.CompareTo(config3.Priority);
						});
						achievementPanel.Init(titleInput.value, timeInput.value, stageInput.value, stageTimeInput.value);
						achievementPanel.gameObject.SetActive(value: true);
						battle_achievement config = ConfigHelper.GetInstance().GetConfig<battle_achievement>(stageInput.value);
						pt = config.Reward;
						ptOut.Call(f);
						config = ConfigHelper.GetInstance().GetConfig<battle_achievement>(stageTimeInput.value);
						pt = config.Reward;
						ptOut.Call(f);
						for (int num = 0; num < currentAchievement.Count; num++)
						{
							config = ConfigHelper.GetInstance().GetConfig<battle_achievement>(currentAchievement[num]);
							pt = config.Reward;
							ptOut.Call(f);
						}
						flowOut.Call(f);
					}
				}
			}
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				if (achievementPanel == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						return;
					}
					achievementPanel = transform.GetComponent<AchievementPanel>();
					achievementPanel.close.onClick.AddListener(delegate
					{
						closeOut.Call(f);
					});
				}
				if (achievementPanel == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					achievementPanel.gameObject.SetActive(value: false);
					closeOut.Call(f);
				}
			}
		});
	}
}
