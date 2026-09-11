using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示Tips", 0)]
[Category("Render/UI")]
[Description("显示Tips")]
public class ShowTips : CallableActionNode<string>
{
	public string prefabPath = "UI/Tips";

	public string instName = "Tips";

	public string targetPath = "BattlePop/Tips";

	public string parentPath = "BattlePop";

	public string textPath = "content/bg/text";

	private Transform prefabTrans;

	private Text text;

	private GameObject uiMain;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(instName);
		writer.Write(targetPath);
		writer.Write(parentPath);
		writer.Write(textPath);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		instName = reader.ReadString();
		targetPath = reader.ReadString();
		parentPath = reader.ReadString();
		textPath = reader.ReadString();
	}

	private void SetActive(GameObject go, bool flag)
	{
		if (go.activeSelf != flag)
		{
			go.SetActive(flag);
		}
	}

	private T GetComponent<T>(string path) where T : Component
	{
		T result = null;
		Transform transform = prefabTrans.Find(path);
		if (transform != null)
		{
			return transform.GetComponent<T>();
		}
		return result;
	}

	private void GetComponents()
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
		if (!(prefabTrans == null))
		{
			SetActive(prefabTrans.gameObject, flag: true);
			if (text == null)
			{
				text = GetComponent<Text>(textPath);
			}
		}
	}

	public override void Invoke(string tipsContent)
	{
		GetComponents();
		if (!(text == null))
		{
			text.text = tipsContent;
		}
	}
}
