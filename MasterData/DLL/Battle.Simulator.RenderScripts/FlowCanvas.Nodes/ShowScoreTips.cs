using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示计分", 0)]
[Category("Render/UI")]
[Description("显示计分, 进去之后会开始计分")]
public class ShowScoreTips : FlowNode
{
	public string targetPath = "BattlePop/countScore";

	public string instName = "countScore";

	public string prefabPath = "UI/BattleTips/Target_UI_Content_Number_barrage";

	public string parentPath = "BattlePop";

	public string currentScoreTextPath = "Barrage/none/textnumber";

	public string addScoreTextPath = "Barrage/text01";

	public string addStringTpl = "+{0}";

	public string subStringTpl = "-{0}";

	public string animatorPath = "Barrage";

	private Transform prefabTrans;

	private Text currentScoreText;

	private Text addScoreText;

	private Animator scoreAnimator;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(targetPath);
		writer.Write(instName);
		writer.Write(prefabPath);
		writer.Write(parentPath);
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
		addStringTpl = reader.ReadString();
		subStringTpl = reader.ReadString();
		animatorPath = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> currentScoreInput = AddValueInput<int>("当前分数", "currentScore");
		ValueInput<int> deltaScoreInput = AddValueInput<int>("变化量", "delta");
		ValueInput<bool> useTargetColorInput = AddValueInput<bool>("当前分数使用指定颜色", "useTargetColor");
		ValueInput<Color> colorInput = AddValueInput<Color>("当前分数要变成什么色", "color");
		ValueInput<bool> animateInput = AddValueInput<bool>("播放动效", "animate");
		ValueInput<string> animationStateNameInput = AddValueInput<string>("要播放的动画名", "animationStateName");
		ValueInput<Color> addScoreColor = AddValueInput<Color>("加分颜色", "addScoreColor").SetDefaultAndSerializedValue(Color.green);
		ValueInput<Color> subScoreColor = AddValueInput<Color>("减分颜色", "subScoreColor").SetDefaultAndSerializedValue(Color.red);
		FlowOutput output = AddFlowOutput("");
		AddValueOutput("当前分数", "currentScore", () => currentScoreInput.value);
		AddFlowInput("初始化", "init", delegate(Flow f)
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
				if (currentScoreText == null)
				{
					currentScoreText = GetComponent<Text>(currentScoreTextPath);
				}
				if (addScoreText == null)
				{
					addScoreText = GetComponent<Text>(addScoreTextPath);
				}
				if (addScoreText != null)
				{
					SetActive(addScoreText.gameObject, flag: false);
				}
				if (scoreAnimator == null)
				{
					scoreAnimator = GetComponent<Animator>(animatorPath);
				}
				if (currentScoreText != null)
				{
					currentScoreText.text = CommonString.GetNumbers((currentScoreInput.value > 0) ? currentScoreInput.value : 0);
				}
				output.Call(f);
			}
		});
		AddFlowInput("Tick", "tick", delegate(Flow f)
		{
			if (deltaScoreInput.value != 0)
			{
				addScoreText.text = GetDeltaString(deltaScoreInput.value);
				SetActive(addScoreText.gameObject, flag: true);
				if (deltaScoreInput.value > 0)
				{
					addScoreText.color = addScoreColor.value;
				}
				if (deltaScoreInput.value < 0)
				{
					addScoreText.color = subScoreColor.value;
				}
			}
			bool value = useTargetColorInput.value;
			Color value2 = colorInput.value;
			if (currentScoreText != null)
			{
				currentScoreText.text = CommonString.GetNumbers((currentScoreInput.value > 0) ? currentScoreInput.value : 0);
				if (value && currentScoreText.color != value2)
				{
					currentScoreText.color = value2;
				}
				else if (!value && currentScoreText.color != Color.white)
				{
					currentScoreText.color = Color.white;
				}
			}
			if (animateInput.value && scoreAnimator != null)
			{
				scoreAnimator.Play(animationStateNameInput.value, 0, 0f);
			}
			output.Call(f);
		});
		AddFlowInput("关闭", "close", delegate(Flow f)
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

	private string GetDeltaString(int delta)
	{
		string result = "";
		if (delta < 0)
		{
			result = CommonString.GetNumbers(delta);
		}
		if (delta > 0)
		{
			result = string.Format(addStringTpl, delta);
		}
		if (delta == 0)
		{
			result = "";
		}
		return result;
	}
}
