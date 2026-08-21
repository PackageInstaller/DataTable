using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示倒计时时间", 0)]
[Category("Render/UI")]
[Description("显示倒计时时间, 进去之后会计时")]
public class ShowTimeTips : FlowNode
{
	public string targetPath = "BattlePop/countdown";

	public string instName = "countdown";

	public string prefabPath = "UI/countdown";

	public string parentPath = "BattlePop";

	public string currentTimeTextPath = "content/timeText";

	public string addTimeTextPath = "content/increaseText";

	public string addStringTpl = "+{0}s";

	public string subStringTpl = "-{0}s";

	public string animatorPath = "content";

	private int currentTime;

	private int maxTime;

	private Transform prefabTrans;

	private Text currentTimeText;

	private Text addTimeText;

	private Animator animatorTimer;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(targetPath);
		writer.Write(instName);
		writer.Write(prefabPath);
		writer.Write(parentPath);
		writer.Write(currentTimeTextPath);
		writer.Write(addTimeTextPath);
		writer.Write(addStringTpl);
		writer.Write(subStringTpl);
		writer.Write(animatorPath);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		targetPath = reader.ReadString();
		instName = reader.ReadString();
		prefabPath = reader.ReadString();
		parentPath = reader.ReadString();
		currentTimeTextPath = reader.ReadString();
		addTimeTextPath = reader.ReadString();
		addStringTpl = reader.ReadString();
		subStringTpl = reader.ReadString();
		animatorPath = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> maxTimeInput = AddValueInput<int>("最大时间(毫秒数)");
		ValueInput<int> currentTimeInput = AddValueInput<int>("当前时间(毫秒数)").SetDefaultAndSerializedValue(-1);
		ValueInput<int> deltaTimeInput = AddValueInput<int>("变化量");
		ValueInput<bool> useTargetColorInpput = AddValueInput<bool>("使用指定颜色");
		ValueInput<Color> colorInput = AddValueInput<Color>("要变成什么色");
		ValueInput<bool> animateInput = AddValueInput<bool>("播放动效");
		ValueInput<string> animtionStateNameInput = AddValueInput<string>("要播放的动画名").SetDefaultAndSerializedValue("countdown");
		AddValueOutput("当前剩余时间", () => maxTime - currentTime);
		AddFlowInput("init", delegate(Flow f)
		{
			currentTime = 0;
			maxTime = maxTimeInput.value;
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
				if (currentTimeText == null)
				{
					currentTimeText = GetComponent<Text>(currentTimeTextPath);
				}
				if (addTimeText == null)
				{
					addTimeText = GetComponent<Text>(addTimeTextPath);
				}
				if (animatorTimer == null)
				{
					animatorTimer = GetComponent<Animator>(animatorPath);
				}
				if (currentTimeText != null)
				{
					int num = maxTime - currentTime;
					currentTimeText.text = GetTime((num > 0) ? num : 0);
				}
				output.Call(f);
			}
		});
		AddFlowInput("tick", delegate(Flow f)
		{
			if (currentTimeInput.value != -1)
			{
				currentTime = currentTimeInput.value;
			}
			else
			{
				currentTime += deltaTimeInput.value;
			}
			int value = maxTimeInput.value;
			bool value2 = useTargetColorInpput.value;
			Color value3 = colorInput.value;
			if (value != maxTime)
			{
				if (addTimeText != null)
				{
					addTimeText.text = GetDeltaString(maxTime, value);
					SetActive(addTimeText.gameObject, flag: true);
				}
				maxTime = value;
			}
			else if (addTimeText != null)
			{
				SetActive(addTimeText.gameObject, flag: false);
			}
			if (currentTimeText != null)
			{
				int num = maxTime - currentTime;
				currentTimeText.text = GetTime((num > 0) ? num : 0);
				if (value2 && currentTimeText.color != value3)
				{
					currentTimeText.color = value3;
				}
				else if (!value2 && currentTimeText.color != Color.white)
				{
					currentTimeText.color = Color.white;
				}
			}
			if (animateInput.value && animatorTimer != null)
			{
				animatorTimer.Play(animtionStateNameInput.value, 0, 0f);
			}
			output.Call(f);
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			if (prefabTrans == null)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.battlePanelGameObject != null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform;
					prefabTrans = transform.Find(targetPath);
				}
			}
			if (prefabTrans != null)
			{
				SetActive(prefabTrans.gameObject, flag: false);
			}
			output.Call(f);
		});
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

	private string GetTime(int miniSecond)
	{
		int num = miniSecond / 1000;
		if (num < CommonString.Timestamp.Length)
		{
			return CommonString.Timestamp[num];
		}
		long num2 = num / 60;
		long num3 = num % 60;
		string text = CommonString.Numbers[num2];
		if (num2 < 10)
		{
			text = "0" + text;
		}
		string text2 = CommonString.Numbers[num3];
		if (num3 < 10)
		{
			text2 = "0" + text2;
		}
		return text + ":" + text2;
	}

	private string GetDeltaString(int last, int current)
	{
		string result = "";
		if (last > current)
		{
			result = string.Format(subStringTpl, (last - current) / 1000);
		}
		if (last < current)
		{
			result = string.Format(addStringTpl, (current - last) / 1000);
		}
		return result;
	}
}
