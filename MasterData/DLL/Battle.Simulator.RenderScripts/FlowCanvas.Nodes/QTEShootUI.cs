using Config;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("激活QTE射击按钮", 0)]
[Category("Render/UI")]
[Description("激活QTE射击按钮,预制体上需要挂载QTEShootScript组件(脚本)")]
public class QTEShootUI : FlowNode
{
	private GameObject go;

	protected override void RegisterPorts()
	{
		ValueInput<string> QTEPathInput = AddValueInput<string>("预制体路径");
		ValueInput<string> QTEOnPathInput = AddValueInput<string>("挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel/ScreenAdjustContainer/TeamPanel");
		ValueInput<TargetCampType> TargetCampInput = AddValueInput<TargetCampType>("目标阵营");
		ValueInput<bool> StandbyOpenInput = AddValueInput<bool>("是否开启QTE可使用特效");
		ValueInput<string> StandbyEffectPathInput = AddValueInput<string>("待机特效");
		ValueInput<string> OutLockEffectPathInput = AddValueInput<string>("解锁特效");
		ValueInput<string> EffectPathInput = AddValueInput<string>("屏幕内特效");
		ValueInput<string> OutSideEffectPathInput = AddValueInput<string>("屏幕外特效");
		ValueInput<bool> IsCDShowInput = AddValueInput<bool>("CD中是否显示");
		ValueInput<bool> IsOnlyLockInput = AddValueInput<bool>("是否只攻击锁定敌人(本地玩家锁定)");
		FlowOutput Output = AddFlowOutput("");
		FlowOutput falseOut = AddFlowOutput("错误");
		AddValueOutput("预制体", () => go);
		AddFlowInput("激活", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				falseOut.Call(f);
			}
			else
			{
				if (go == null)
				{
					GameObject gameObject = GameObject.Find(QTEOnPathInput.value);
					go = Asset.InstantiateWithoutCache(QTEPathInput.value, gameObject.transform);
				}
				else
				{
					go.SetActive(value: true);
				}
				go.GetComponent<Button>();
				go.GetComponent<QTEShootScript>().Init(TargetCampInput.value, EffectPathInput.value, OutSideEffectPathInput.value, IsCDShowInput.value, IsOnlyLockInput.value, StandbyOpenInput.value, StandbyEffectPathInput.value, OutLockEffectPathInput.value);
				Output.Call(f);
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (go != null)
			{
				go.SetActive(value: false);
				Output.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddFlowInput("销毁", delegate
		{
			if (go != null)
			{
				PooledAsset.DestroyOrReturn(go);
				go = null;
			}
		});
	}
}
