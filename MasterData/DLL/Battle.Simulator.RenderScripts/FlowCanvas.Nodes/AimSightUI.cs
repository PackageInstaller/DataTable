using Packages.BattleSimulator.Simulator.SimulatorUI;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("瞄准功能", 0)]
[Category("Render/UI")]
[Description("瞄准功能")]
public class AimSightUI : FlowNode
{
	public GameObject AimSightGo;

	public GameObject ScriptGo;

	protected override void RegisterPorts()
	{
		ValueInput<string> AimSightPath = AddValueInput<string>("瞄准镜预制体路径");
		ValueInput<string> AimSightScriptPath = AddValueInput<string>("瞄准镜脚本预制体路径");
		ValueInput<string> ScriptPath = AddValueInput<string>("脚本战斗面板加载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<float> distanceInput = AddValueInput<float>("距离").SetDefaultAndSerializedValue(20f);
		ValueInput<string> endPath = AddValueInput<string>("结束特效");
		FlowOutput outPut = AddFlowOutput("瞄准");
		FlowOutput endOut = AddFlowOutput("结束");
		FlowOutput falseOut = AddFlowOutput("error");
		AddFlowInput("瞄准", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				falseOut.Call(f);
			}
			else
			{
				if (AimSightGo == null)
				{
					AimSightGo = Asset.Instantiate(AimSightPath.value);
				}
				else
				{
					AimSightGo.SetActive(value: true);
				}
				if (ScriptGo == null)
				{
					GameObject gameObject = GameObject.Find(ScriptPath.value);
					ScriptGo = Asset.InstantiateWithoutCache(AimSightScriptPath.value, gameObject.transform);
				}
				else
				{
					ScriptGo.SetActive(value: true);
				}
				if (ScriptGo == null || AimSightGo == null)
				{
					falseOut.Call(f);
				}
				else
				{
					AimSightMoveScript aimSightMoveScript = U3DUtil.Get<AimSightMoveScript>(ScriptGo);
					aimSightMoveScript.Init(AimSightGo, distanceInput.value);
					BattleScene battleScene2 = NScene.GetCurrentScene() as BattleScene;
					if (battleScene2 != null)
					{
						GameObject battlePanelGameObject = battleScene2.battlePanelGameObject;
						if (battlePanelGameObject != null)
						{
							BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
							if (component != null)
							{
								component.joystickController.Init(Vector3.zero, 0f, new P08JoystickWithAimSight(aimSightMoveScript));
							}
						}
					}
					outPut.Call(f);
				}
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (AimSightGo != null)
			{
				AimSightGo.SetActive(value: false);
				CommonEffectClipPlayer.PlayEffect(endPath.value, AimSightGo.transform.position, AimSightGo.transform.localScale, Vector3.zero, AimSightGo.transform.forward);
			}
			if (ScriptGo != null)
			{
				ScriptGo.SetActive(value: false);
			}
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject != null)
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component != null)
					{
						component.joystickController.Init(Vector3.zero, 0f, new P08StickControllerGameLogic());
					}
				}
			}
			endOut.Call(f);
		});
	}
}
