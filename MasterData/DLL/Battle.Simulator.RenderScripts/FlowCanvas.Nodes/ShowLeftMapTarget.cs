using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示左侧目标", 0)]
[Category("Render/UI")]
[Description("显示左侧目标, 设置会修改全部, 更新只能更新对应的条目, 有字符串相关的gc")]
public class ShowLeftMapTarget : FlowNode
{
	public string targetPath = "ScreenAdjustContainer/LeftTop/Target";

	public string prefabPath = "UI/Target_UI";

	public string parentPath = "ScreenAdjustContainer/LeftTop";

	public string instName = "Target";

	private Transform prefabTrans;

	public string taskGoPath = "task";

	public string taskTextPath = "task/icon_tagging/text";

	private GameObject task1Go;

	private Text taskText;

	public string numberGoPath = "content/number";

	public string numberContentTextPath = "content/number/text";

	public string numberTextPath = "content/number/text/text2";

	public string numberAnimatorPAth = "content/number/icon";

	private GameObject taskNumberGo;

	private Text numberContentText;

	private Text numberText;

	private Animator animatorNumber;

	public string hpGoPath = "content/friendly";

	public string hpContentTextPath = "content/friendly/text";

	public string hpPercentTextPath = "content/friendly/bg2/text2";

	public string hpSliderPath = "content/friendly/bg2";

	public string hpAnimatorPath = "content/friendly/text/icon";

	private GameObject hpGo;

	private Text hpContentText;

	private Text hpPercentText;

	private Slider slider;

	private Animator animatorHp;

	public string timerGoPath = "content/timer_count";

	public string timerContentTextPath = "content/timer_count/text";

	public string timerTextPath = "content/timer_count/text/text2";

	public string timerAnimatorPath = "content/timer_count/icon";

	private GameObject timerGo;

	private Text timerContentText;

	private Text timerText;

	private Animator animatorTimer;

	public string progressGoPath = "content/progress";

	public string progressContentTextPath = "content/progress/text";

	public string progressCurrentTextPath = "content/progress/text/text2";

	public string progressAnimatorPath = "content/progress/icon";

	public string progressTotalTextPath = "content/progress/text/text4";

	private GameObject progressGo;

	private Text progressContentText;

	private Text progressCurrentText;

	private Animator animatorProgress;

	private Text progressTotalText;

	public string animtionStateName = "1";

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		targetPath = reader.ReadString();
		prefabPath = reader.ReadString();
		parentPath = reader.ReadString();
		instName = reader.ReadString();
		taskGoPath = reader.ReadString();
		taskTextPath = reader.ReadString();
		numberGoPath = reader.ReadString();
		numberContentTextPath = reader.ReadString();
		numberTextPath = reader.ReadString();
		numberAnimatorPAth = reader.ReadString();
		hpGoPath = reader.ReadString();
		hpContentTextPath = reader.ReadString();
		hpSliderPath = reader.ReadString();
		hpAnimatorPath = reader.ReadString();
		timerGoPath = reader.ReadString();
		timerContentTextPath = reader.ReadString();
		timerTextPath = reader.ReadString();
		timerAnimatorPath = reader.ReadString();
		progressGoPath = reader.ReadString();
		progressContentTextPath = reader.ReadString();
		progressCurrentTextPath = reader.ReadString();
		progressAnimatorPath = reader.ReadString();
		progressTotalTextPath = reader.ReadString();
		animtionStateName = reader.ReadString();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(targetPath);
		writer.Write(prefabPath);
		writer.Write(parentPath);
		writer.Write(instName);
		writer.Write(taskGoPath);
		writer.Write(taskTextPath);
		writer.Write(numberGoPath);
		writer.Write(numberContentTextPath);
		writer.Write(numberTextPath);
		writer.Write(numberAnimatorPAth);
		writer.Write(hpGoPath);
		writer.Write(hpContentTextPath);
		writer.Write(hpSliderPath);
		writer.Write(hpAnimatorPath);
		writer.Write(timerGoPath);
		writer.Write(timerContentTextPath);
		writer.Write(timerTextPath);
		writer.Write(timerAnimatorPath);
		writer.Write(progressGoPath);
		writer.Write(progressContentTextPath);
		writer.Write(progressCurrentTextPath);
		writer.Write(progressAnimatorPath);
		writer.Write(progressTotalTextPath);
		writer.Write(animtionStateName);
	}

	protected override void RegisterPorts()
	{
		ValueInput<bool> showTarget1Input = AddValueInput<bool>("显示目标");
		ValueInput<string> target1Input = AddValueInput<string>("目标内容");
		ValueInput<bool> showTarget2Input = AddValueInput<bool>("显示目标2");
		ValueInput<bool> showTarget2Content1Input = AddValueInput<bool>("显示目标2内容1");
		ValueInput<string> target2Content1Input = AddValueInput<string>("目标2内容1");
		ValueInput<bool> showTarget2Content2Input = AddValueInput<bool>("显示目标2内容2");
		ValueInput<int> target2Content2Input = AddValueInput<int>("目标2内容2");
		ValueInput<bool> showTarget3Input = AddValueInput<bool>("显示血量");
		ValueInput<string> target3Content1Input = AddValueInput<string>("血量描述");
		ValueInput<float> target3Content3Input = AddValueInput<float>("血量百分比(0~1)");
		ValueInput<bool> showTimerInput = AddValueInput<bool>("显示时间");
		ValueInput<string> timerContentInput = AddValueInput<string>("时间描述");
		ValueInput<int> timeInput = AddValueInput<int>("时间(毫秒数)");
		ValueInput<bool> showProgressInput = AddValueInput<bool>("显示进度");
		ValueInput<string> progressContentInput = AddValueInput<string>("进度描述");
		ValueInput<int> progressCurrentInput = AddValueInput<int>("当前进度");
		ValueInput<int> progressTotalInput = AddValueInput<int>("总进度");
		ValueInput<bool> animateInput = AddValueInput<bool>("播放动效");
		ValueInput<bool> useTargetColorInput = AddValueInput<bool>("使用指定颜色");
		ValueInput<Color> colorInput = AddValueInput<Color>("指定颜色");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("设置", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateTarget();
			UpdateTarget2();
			UpdateHp();
			UpdateTimer();
			UpdateProgress();
			output.Call(f);
		});
		AddFlowInput("更新目标", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateTarget();
			output.Call(f);
		});
		AddFlowInput("关闭目标", delegate(Flow f)
		{
			if (task1Go != null)
			{
				SetActive(task1Go, flag: false);
			}
			output.Call(f);
		});
		AddFlowInput("更新目标2", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateTarget2();
			output.Call(f);
		});
		AddFlowInput("关闭目标2", delegate(Flow f)
		{
			if (taskNumberGo != null)
			{
				SetActive(taskNumberGo, flag: false);
			}
			output.Call(f);
		});
		AddFlowInput("更新血量", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateHp();
			output.Call(f);
		});
		AddFlowInput("关闭血量", delegate(Flow f)
		{
			if (hpGo != null)
			{
				SetActive(hpGo, flag: false);
			}
			output.Call(f);
		});
		AddFlowInput("更新时间", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateTimer();
			output.Call(f);
		});
		AddFlowInput("关闭时间", delegate(Flow f)
		{
			if (timerGo != null)
			{
				SetActive(timerGo, flag: false);
			}
			output.Call(f);
		});
		AddFlowInput("更新进度", delegate(Flow f)
		{
			GetPrefabTrans();
			UpdateProgress();
			output.Call(f);
		});
		AddFlowInput("关闭进度", delegate(Flow f)
		{
			if (progressGo != null)
			{
				SetActive(progressGo, flag: false);
			}
			output.Call(f);
		});
		void UpdateHp()
		{
			if (hpGo != null)
			{
				if (showTarget3Input.value)
				{
					SetActive(hpGo, flag: true);
					SetTextContent(hpContentText, target3Content1Input.value);
					float value = target3Content3Input.value;
					SetTextContent(hpPercentText, CommonString.Numbers[(int)(value * 100f)]);
					if (slider != null)
					{
						slider.value = value;
					}
					if (animateInput.value && animatorHp != null)
					{
						animatorHp.Play(animtionStateName, 0, 0f);
					}
					LayoutRebuilder.ForceRebuildLayoutImmediate(hpGo.transform.parent as RectTransform);
					LayoutRebuilder.ForceRebuildLayoutImmediate(hpGo.transform.parent as RectTransform);
				}
				else
				{
					SetActive(hpGo, flag: false);
				}
			}
		}
		void UpdateProgress()
		{
			if (progressGo != null)
			{
				if (showProgressInput.value)
				{
					SetActive(progressGo, flag: true);
					SetTextContent(progressContentText, progressContentInput.value);
					SetTextContent(progressCurrentText, CommonString.Numbers[progressCurrentInput.value]);
					SetTextContent(progressTotalText, CommonString.Numbers[progressTotalInput.value]);
					if (animateInput.value && animatorProgress != null)
					{
						animatorProgress.Play(animtionStateName, 0, 0f);
					}
					if (progressCurrentText != null)
					{
						if (useTargetColorInput.value)
						{
							progressCurrentText.color = colorInput.value;
						}
						else
						{
							progressCurrentText.color = Color.white;
						}
					}
					LayoutRebuilder.ForceRebuildLayoutImmediate(progressGo.transform.parent as RectTransform);
					LayoutRebuilder.ForceRebuildLayoutImmediate(progressGo.transform.parent as RectTransform);
				}
				else
				{
					SetActive(progressGo, flag: false);
				}
			}
		}
		void UpdateTarget()
		{
			if (task1Go != null)
			{
				if (showTarget1Input.value)
				{
					SetActive(task1Go, flag: true);
					if (taskText != null)
					{
						taskText.text = target1Input.value;
					}
				}
				else
				{
					SetActive(task1Go, flag: false);
				}
			}
		}
		void UpdateTarget2()
		{
			if (taskNumberGo != null)
			{
				if (showTarget2Input.value)
				{
					SetActive(taskNumberGo, flag: true);
					if (showTarget2Content1Input.value)
					{
						SetTextContent(numberContentText, target2Content1Input.value);
					}
					else
					{
						SetTextContent(numberContentText, "");
					}
					if (showTarget2Content2Input.value)
					{
						SetTextContent(numberText, CommonString.GetNumbers(target2Content2Input.value));
					}
					else
					{
						SetTextContent(numberText, "");
					}
					if (animateInput.value && animatorNumber != null)
					{
						animatorNumber.Play(animtionStateName, 0, 0f);
					}
					if (numberText != null)
					{
						if (useTargetColorInput.value)
						{
							numberText.color = colorInput.value;
						}
						else
						{
							numberText.color = Color.white;
						}
					}
					LayoutRebuilder.ForceRebuildLayoutImmediate(taskNumberGo.transform.parent as RectTransform);
					LayoutRebuilder.ForceRebuildLayoutImmediate(taskNumberGo.transform.parent as RectTransform);
				}
				else
				{
					SetActive(taskNumberGo, flag: false);
				}
			}
		}
		void UpdateTimer()
		{
			if (timerGo != null)
			{
				if (showTimerInput.value)
				{
					SetActive(timerGo, flag: true);
					SetTextContent(timerContentText, timerContentInput.value);
					SetTextContent(timerText, GetTime(timeInput.value));
					if (animateInput.value && animatorTimer != null)
					{
						animatorTimer.Play(animtionStateName, 0, 0f);
					}
					if (timerText != null)
					{
						if (useTargetColorInput.value)
						{
							timerText.color = colorInput.value;
						}
						else
						{
							timerText.color = Color.white;
						}
					}
					LayoutRebuilder.ForceRebuildLayoutImmediate(timerGo.transform.parent as RectTransform);
					LayoutRebuilder.ForceRebuildLayoutImmediate(timerGo.transform.parent as RectTransform);
				}
				else
				{
					SetActive(timerGo, flag: false);
				}
			}
		}
	}

	private void GetPrefabTrans()
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
			if (task1Go == null)
			{
				task1Go = GetGameObject(taskGoPath);
			}
			if (taskText == null)
			{
				taskText = GetComponent<Text>(taskTextPath);
			}
			if (taskNumberGo == null)
			{
				taskNumberGo = GetGameObject(numberGoPath);
			}
			if (numberContentText == null)
			{
				numberContentText = GetComponent<Text>(numberContentTextPath);
			}
			if (numberText == null)
			{
				numberText = GetComponent<Text>(numberTextPath);
			}
			if (animatorNumber == null)
			{
				animatorNumber = GetComponent<Animator>(numberAnimatorPAth);
			}
			if (hpGo == null)
			{
				hpGo = GetGameObject(hpGoPath);
			}
			if (hpContentText == null)
			{
				hpContentText = GetComponent<Text>(hpContentTextPath);
			}
			if (hpPercentText == null)
			{
				hpPercentText = GetComponent<Text>(hpPercentTextPath);
			}
			if (slider == null)
			{
				slider = GetComponent<Slider>(hpSliderPath);
			}
			if (animatorHp == null)
			{
				animatorHp = GetComponent<Animator>(hpAnimatorPath);
			}
			if (timerGo == null)
			{
				timerGo = GetGameObject(timerGoPath);
			}
			if (timerContentText == null)
			{
				timerContentText = GetComponent<Text>(timerContentTextPath);
			}
			if (timerText == null)
			{
				timerText = GetComponent<Text>(timerTextPath);
			}
			if (animatorTimer == null)
			{
				animatorTimer = GetComponent<Animator>(timerAnimatorPath);
			}
			if (progressGo == null)
			{
				progressGo = GetGameObject(progressGoPath);
			}
			if (progressContentText == null)
			{
				progressContentText = GetComponent<Text>(progressContentTextPath);
			}
			if (progressCurrentText == null)
			{
				progressCurrentText = GetComponent<Text>(progressCurrentTextPath);
			}
			if (progressTotalText == null)
			{
				progressTotalText = GetComponent<Text>(progressTotalTextPath);
			}
			if (animatorProgress == null)
			{
				animatorProgress = GetComponent<Animator>(progressAnimatorPath);
			}
		}
	}

	private void SetActive(GameObject go, bool flag)
	{
		if (go.activeSelf != flag)
		{
			go.SetActive(flag);
		}
	}

	private void SetTextContent(Text text, string content)
	{
		if (text != null)
		{
			text.text = content;
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

	private GameObject GetGameObject(string path)
	{
		GameObject result = null;
		Transform transform = prefabTrans.Find(path);
		if (transform != null)
		{
			result = transform.gameObject;
		}
		return result;
	}

	private string GetTime(int miniSecond)
	{
		int num = miniSecond / 1000;
		string empty = string.Empty;
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
}
