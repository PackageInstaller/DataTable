using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示常驻提示", 0)]
[Category("Render/UI")]
[Description("显示常驻提示,如果有非默认预制体需要有TipsPanelUI组件")]
public class GetScoreBattleTips : FlowNode
{
	public string prefabPath = "UI/TipsBattleTaskUI";

	public string instName = "TipsBattleTaskUI";

	public string targetPath = "ScreenAdjustContainer/TipsBattleTaskUI";

	public string parentPath = "ScreenAdjustContainer";

	private Transform prefabTrans;

	private TipsPanelUI uI;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		instName = reader.ReadString();
		targetPath = reader.ReadString();
		parentPath = reader.ReadString();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(instName);
		writer.Write(targetPath);
		writer.Write(parentPath);
	}

	private void GetPrefab()
	{
		if (prefabTrans == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform;
				prefabTrans = transform.Find(targetPath);
				if (prefabTrans == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform.Find(parentPath));
					gameObject.name = instName;
					prefabTrans = gameObject.transform;
				}
			}
		}
		if (prefabTrans != null)
		{
			uI = prefabTrans.GetComponent<TipsPanelUI>();
		}
	}

	private string GetTips(int id)
	{
		return WorldStateManager.GetTipsContent(id);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("TitleId");
		ValueInput<List<int>> contextInput = AddValueInput<List<int>>("contextIDs");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("in", delegate(Flow f)
		{
			GetPrefab();
			if (prefabTrans == null)
			{
				errorOut.Call(f);
			}
			else
			{
				prefabTrans.gameObject.SetActive(value: true);
				List<string> list = new List<string>();
				List<int> value = contextInput.value;
				for (int i = 0; i < value.Count; i++)
				{
					list.Add(GetTips(value[i]));
				}
				uI.Init(GetTips(idInput.value), list);
				output.Call(f);
			}
		});
		AddFlowInput("hide", delegate(Flow f)
		{
			if (prefabTrans != null)
			{
				prefabTrans.gameObject.SetActive(value: false);
			}
			output.Call(f);
		});
	}
}
