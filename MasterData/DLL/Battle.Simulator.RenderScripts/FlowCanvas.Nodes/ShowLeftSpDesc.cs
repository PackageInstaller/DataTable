using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示左侧特殊描述", 0)]
[Category("Render/UI")]
[Description("显示左侧特殊描述")]
public class ShowLeftSpDesc : FlowNode
{
	public string targetPath = "ScreenAdjustContainer/LeftTop/Target";

	public string prefabPath = "UI/Target_UI";

	public string parentPath = "ScreenAdjustContainer/LeftTop";

	public string instName = "Target";

	private LeftTargetUI com;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		targetPath = reader.ReadString();
		prefabPath = reader.ReadString();
		parentPath = reader.ReadString();
		instName = reader.ReadString();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(targetPath);
		writer.Write(prefabPath);
		writer.Write(parentPath);
		writer.Write(instName);
	}

	private void GetPrefabTrans()
	{
		if (com == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform;
				Transform transform2 = transform.Find(targetPath);
				if (transform2 == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform.Find(parentPath));
					gameObject.name = instName;
					transform2 = gameObject.transform;
				}
				if (transform2 != null)
				{
					com = transform2.GetComponent<LeftTargetUI>();
				}
			}
		}
		if (!(com == null))
		{
			SetActive(com.gameObject, flag: true);
		}
	}

	private void SetActive(GameObject go, bool flag)
	{
		if (go.activeSelf != flag)
		{
			go.SetActive(flag);
		}
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> idInput = AddValueInput<int>("id");
		ValueInput<string> pathInput = AddValueInput<string>("图片路径");
		ValueInput<int> tltleInput = AddValueInput<int>("标题");
		ValueInput<int> contentInput = AddValueInput<int>("内容");
		AddFlowInput("显示", delegate(Flow f)
		{
			GetPrefabTrans();
			if (com != null)
			{
				com.Add(idInput.value, pathInput.value, WorldStateManager.GetTipsContent(tltleInput.value), WorldStateManager.GetTipsContent(contentInput.value));
			}
			f.Call(output);
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			GetPrefabTrans();
			if (com != null)
			{
				com.Remove(idInput.value);
			}
			f.Call(output);
		});
	}
}
