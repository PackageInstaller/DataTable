using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("激活QTE额外按钮", 0)]
[Category("Render/UI")]
[Description("激活QTE射击按钮,预制体上需要挂载QTEShootScript组件(脚本)")]
public class QTEExButtonUI : FlowNode
{
	private GameObject go;

	protected override void RegisterPorts()
	{
		ValueInput<ButtonType> ButtonTypeInput = AddValueInput<ButtonType>("按钮类型");
		ValueInput<string> atlasNameInput = AddValueInput<string>("图集名");
		ValueInput<string> imageNameInput = AddValueInput<string>("图片名");
		ValueInput<string> QTEPathInput = AddValueInput<string>("预制体路径");
		ValueInput<string> QTEOnPathInput = AddValueInput<string>("挂载路径").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel/ScreenAdjustContainer/TeamPanel");
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
				go.GetComponent<QteExButton>().Init(ButtonTypeInput.value, atlasNameInput.value, imageNameInput.value);
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
