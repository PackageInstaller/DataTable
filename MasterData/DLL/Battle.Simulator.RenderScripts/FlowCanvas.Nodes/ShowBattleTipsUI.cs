using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示图文提示", 0)]
[Category("Render/UI")]
[Description("显示图文提示, 会实例化在Battlepanel下面, 内容写在battletips那张表里")]
public class ShowBattleTipsUI : FlowNode
{
	public string prefabPath = "UI/BattleTipsUI";

	public string instName = "BattleTipsUI";

	private BattleTipsUI battleTipsUI;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(instName);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		instName = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> titleInput = AddValueInput<int>("标题");
		ValueInput<List<int>> contentInput = AddValueInput<List<int>>("内容");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				if (battleTipsUI == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(instName);
					if (transform == null)
					{
						GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, battleScene.battlePanelGameObject.transform);
						if (gameObject != null)
						{
							gameObject.name = instName;
							transform = gameObject.transform;
						}
					}
					if (transform != null)
					{
						battleTipsUI = transform.GetComponent<BattleTipsUI>();
					}
				}
				if (battleTipsUI == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					List<string> contents = battleTipsUI.contents;
					List<int> value = contentInput.value;
					if (contents == null || value == null || value.Count == 0)
					{
						errorOutput.Call(f);
					}
					else if (battleTipsUI.buttonHide == null)
					{
						errorOutput.Call(f);
					}
					else
					{
						contents.Clear();
						for (int i = 0; i < value.Count; i++)
						{
							contents.Add(WorldStateManager.GetTipsContent(value[i]));
						}
						battleTipsUI.SetContent(contents, WorldStateManager.GetTipsContent(titleInput.value));
						battleTipsUI.gameObject.SetActive(value: true);
						battleTipsUI.buttonHide.onClick.RemoveAllListeners();
						battleTipsUI.buttonHide.onClick.AddListener(delegate
						{
							battleTipsUI.gameObject.SetActive(value: false);
							f.Call(output);
						});
					}
				}
			}
		});
	}
}
