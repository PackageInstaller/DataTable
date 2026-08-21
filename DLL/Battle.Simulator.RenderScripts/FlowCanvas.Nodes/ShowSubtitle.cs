using System;
using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示字幕", 0)]
[Category("Render/UI")]
[Description("显示字幕, 会实例化在Battlepanel下面, 要播放语音的话, 传进去的内容是无效的, 会直接取语音表里读\n如果要取agent的名字的话, 传进去的内容必须是可以格式化的")]
public class ShowSubtitle : FlowNode
{
	public string prefabPath = "Widget/System/Story/subtitle";

	public string instName = "subtitle";

	public string targetPath = "BattlePop/subtitle";

	public string parentPath = "BattlePop";

	private Transform prefabTrans;

	public string contentPath = "content/bg/text";

	private Text contentText;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		prefabPath = reader.ReadString();
		instName = reader.ReadString();
		targetPath = reader.ReadString();
		parentPath = reader.ReadString();
		contentPath = reader.ReadString();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(prefabPath);
		writer.Write(instName);
		writer.Write(targetPath);
		writer.Write(parentPath);
		writer.Write(contentPath);
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
		if (contentText == null && prefabTrans != null)
		{
			contentText = GetComponent<Text>(contentPath);
		}
	}

	private AgentManager GetAgentManager()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetAgentManager();
	}

	private int PlayVoice(int agentID, int voiceID, string content)
	{
		int num = 0;
		if (ConfigHelper.GetInstance().TryGetConfig<RoleVoice>(voiceID, out var config))
		{
			ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(config.AudioID, out var config2);
			AudioManager.Instance.Play("voice", config2.CueSheet, config2.CueName, config2.UseStream);
			num = AudioManager.Instance.GetCueInfoLength("voice", config2.CueSheet, config2.CueName, useStream: true);
			if (contentText != null)
			{
				string text = string.Format(content, "", config.Content);
				contentText.text = text;
				if (num == 0)
				{
					num = (int)((float)text.Length / 40f * 1000f);
					num = Math.Max(num, 3000);
					num = Math.Min(num, 18000);
				}
			}
		}
		return num;
	}

	private void UseAgentName(int agentID, string content)
	{
		AgentManager agentManager = GetAgentManager();
		if (agentManager != null)
		{
			NAgent agent = agentManager.GetAgent(agentID);
			if (!(agent == null) && ConfigHelper.GetInstance().TryGetConfig<charactor_param>(agent.AgentConfigID, out var config) && contentText != null)
			{
				contentText.text = string.Format(content, WorldStateManager.GetSystemTableI18N(config.Name));
			}
		}
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<bool> voiceInput = AddValueInput<bool>("播放语音");
		ValueInput<int> voiceIDInput = AddValueInput<int>("语音ID");
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		ValueInput<bool> agentNameInput = AddValueInput<bool>("使用agent的名字");
		ValueInput<string> contentInput = AddValueInput<string>("内容");
		int length = 0;
		AddValueOutput("时长", () => length);
		AddFlowInput("显示", delegate(Flow f)
		{
			GetPrefab();
			if (prefabTrans != null)
			{
				prefabTrans.gameObject.SetActive(value: true);
			}
			string text = contentInput.value.Replace("#{nickname}#", (NScene.GetCurrentScene() as BattleScene)?.nickName);
			if (voiceInput.value)
			{
				length = PlayVoice(agentIDInput.value, voiceIDInput.value, text);
			}
			else if (agentNameInput.value)
			{
				UseAgentName(agentIDInput.value, text);
			}
			else if (contentText != null)
			{
				contentText.text = text;
			}
			output.Call(f);
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			GetPrefab();
			if (prefabTrans != null)
			{
				prefabTrans.gameObject.SetActive(value: false);
			}
			output.Call(f);
		});
	}
}
