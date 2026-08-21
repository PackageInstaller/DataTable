using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示Tips(延迟关闭)", 0)]
[Category("Render/UI")]
[Description("显示Tips,时间到自动关闭,注意,所有人都用同一个时间")]
public class ShowTipsAutoHide : FlowControlNodeOfRender, IUpdatable
{
	public string prefabPath = "UI/Tips";

	public string instName = "Tips";

	public string targetPath = "BattlePop/Tips";

	public string parentPath = "BattlePop";

	public string textPath = "content/bg/text";

	public bool stopUpdateWhenBattlePause = true;

	private Transform prefabTrans;

	private Text text;

	private WorldStateManager _wordStateMgr;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(instName);
		writer.Write(targetPath);
		writer.Write(parentPath);
		writer.Write(textPath);
		writer.Write(stopUpdateWhenBattlePause);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		instName = reader.ReadString();
		targetPath = reader.ReadString();
		parentPath = reader.ReadString();
		textPath = reader.ReadString();
		stopUpdateWhenBattlePause = reader.ReadBoolean();
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		prefabTrans = null;
		text = null;
		_wordStateMgr = null;
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

	protected override void RegisterPorts()
	{
		ValueInput<string> tipContentInput = AddValueInput<string>("内容", "content");
		ValueInput<float> delayInput = AddValueInput<float>("延迟关闭时长", "delay").SetDefaultAndSerializedValue(1f);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GetComponents();
			if (text == null)
			{
				errorOut.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null)
				{
					errorOut.Call(f);
				}
				else
				{
					_wordStateMgr = battleScene.GetWorldSatetManager();
					if (_wordStateMgr == null)
					{
						errorOut.Call(f);
					}
					else
					{
						text.text = tipContentInput.value;
						float num = delayInput.value;
						if (num <= 0f)
						{
							num = 1f;
						}
						_wordStateMgr.m_battleTipsMaxTime = num;
						_wordStateMgr.m_battleTipsCurrrentTime = 0f;
						_wordStateMgr.m_battleTipsStartUID = base.UID;
						output.Call(f);
					}
				}
			}
		});
	}

	public void Update()
	{
		if ((!BattleScene.isPause || !stopUpdateWhenBattlePause) && _wordStateMgr != null && !string.IsNullOrEmpty(_wordStateMgr.m_battleTipsStartUID) && _wordStateMgr.m_battleTipsStartUID == base.UID)
		{
			_wordStateMgr.m_battleTipsCurrrentTime += Time.deltaTime;
			if (_wordStateMgr.m_battleTipsCurrrentTime > _wordStateMgr.m_battleTipsMaxTime)
			{
				_wordStateMgr.m_battleTipsStartUID = string.Empty;
				HideTip();
			}
		}
	}

	private void HideTip()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && battleScene.battlePanelGameObject != null)
		{
			Transform transform = battleScene.battlePanelGameObject.transform.Find(targetPath);
			if (transform != null)
			{
				transform.gameObject.SetActive(value: false);
			}
		}
	}
}
