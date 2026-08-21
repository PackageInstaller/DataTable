using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示文本剧情", 0)]
[Category("Render/UI")]
[Description("显示文本剧情定制节点")]
public class ShowTextUI : FlowNode
{
	private GameObject goGuide;

	private GameObject textPanel;

	private Text titleText;

	private Text contentText;

	private Button arrow;

	public string path = "UI/Guide/BigTextUI";

	public string uiGoName = "BigTextUI";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(path);
		writer.Write(uiGoName);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		path = reader.ReadString();
		uiGoName = reader.ReadString();
	}

	public override void OnGraphStarted()
	{
		goGuide = null;
		textPanel = null;
		titleText = null;
		contentText = null;
		arrow = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goGuideInput = AddValueInput<GameObject>("指引预制体");
		AddValueOutput("预制体", () => goGuide);
		ValueInput<string> titleInput = AddValueInput<string>("标题");
		ValueInput<string> tipsInput = AddValueInput<string>("要显示的提示");
		ValueInput<Vector2> tipsPositionInput = AddValueInput<Vector2>("提示的位置").SetDefaultAndSerializedValue(Vector2.zero);
		ValueInput<int> TitleFontSizeInput = AddValueInput<int>("标题大小").SetDefaultAndSerializedValue(40);
		ValueInput<int> FontSizeInput = AddValueInput<int>("字体大小").SetDefaultAndSerializedValue(28);
		FlowOutput output = AddFlowOutput("");
		FlowOutput hideOut = AddFlowOutput("隐藏");
		AddFlowInput("显示", delegate(Flow f)
		{
			bool flag = goGuide != goGuideInput.value;
			goGuide = goGuideInput.value;
			if (goGuide == null)
			{
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				Transform transform = battlePanelGameObject.transform.Find(uiGoName);
				if (transform == null)
				{
					goGuide = Asset.InstantiateWithoutCache(path, battlePanelGameObject.transform);
					goGuide.name = uiGoName;
				}
				else
				{
					goGuide = transform.gameObject;
				}
			}
			if (goGuide == null)
			{
				Debug.LogError("指引预制体位空, 显示指引节点出错了");
				output.Call(f);
			}
			else
			{
				goGuide.SetActive(value: true);
				if (flag || textPanel == null || contentText == null || arrow == null || titleText == null)
				{
					Transform transform2 = goGuide.transform.Find("TextPanel");
					textPanel = transform2.gameObject;
					contentText = transform2.FindChildDeep("contextText").GetComponent<Text>();
					titleText = transform2.Find("title").GetComponent<Text>();
					arrow = transform2.Find("btnSkip").GetComponent<Button>();
				}
				contentText.fontSize = FontSizeInput.value;
				titleText.fontSize = TitleFontSizeInput.value;
				textPanel.SetActive(value: true);
				textPanel.transform.localPosition = tipsPositionInput.value;
				titleText.text = titleInput.value;
				contentText.text = tipsInput.value;
				UnityAction action = null;
				arrow.gameObject.SetActive(value: true);
				action = delegate
				{
					arrow.onClick.RemoveListener(action);
					goGuide.SetActive(value: false);
					output.Call(f);
				};
				arrow.onClick.AddListener(action);
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (goGuide != null)
			{
				goGuide.SetActive(value: false);
			}
			hideOut.Call(f);
		});
	}
}
