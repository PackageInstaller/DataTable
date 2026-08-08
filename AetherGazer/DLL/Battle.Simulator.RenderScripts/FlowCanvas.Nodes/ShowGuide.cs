using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示指引", 0)]
[Category("Render/UI")]
[Description("显示新手指引定制节点, 退出方式目前没有生效, 0立即退出, 1指定按钮继续, 2对话继续, 3空白处继续")]
public class ShowGuide : FlowNode
{
	private GameObject textPanel;

	private Text contentText;

	private Image headIcon;

	private Text nameText;

	private Button arrow;

	private GuideHighlightMask maskComponent;

	private Image maskImage;

	private Button textPanelButton;

	private Button maskButton;

	private GameObject uiEffect;

	private PassEventUI targetMaskButton;

	public Color color;

	public string path = "Widget/System/GuideNewUI/GuideNewUI";

	public string uiGoName = "GuideUI";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(path);
		writer.Write(uiGoName);
		options.Resolver.GetFormatter<Color>().Serialize(ref writer, color, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		path = reader.ReadString();
		uiGoName = reader.ReadString();
		color = options.Resolver.GetFormatter<Color>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goGuideInput = AddValueInput<GameObject>("指引预制体");
		GameObject goGuide = null;
		AddValueOutput("预制体", () => goGuide);
		ValueInput<bool> showTipsInput = AddValueInput<bool>("是否显示提示");
		ValueInput<string> tipsInput = AddValueInput<string>("要显示的提示");
		ValueInput<string> tipsHeadIconInput = AddValueInput<string>("提示人物头像");
		ValueInput<string> tipsCharNameInput = AddValueInput<string>("提示人物名称");
		ValueInput<bool> showMaskUIInput = AddValueInput<bool>("是否蒙住按钮");
		ValueInput<string> uiPathInput = AddValueInput<string>("UI路径");
		ValueInput<int> styleInput = AddValueInput<int>("形状");
		ValueInput<bool> outStyleInput = AddValueInput<bool>("是否立即退出节点");
		ValueInput<bool> textPanelToContinueInput = AddValueInput<bool>("true对话处继续,false指定按钮继续");
		ValueInput<bool> maskToContinueInput = AddValueInput<bool>("点击空白处继续");
		ValueInput<Vector2> tipsPositionInput = AddValueInput<Vector2>("提示的位置");
		FlowOutput output = AddFlowOutput("");
		FlowOutput neverout = AddFlowOutput("出不去的组合");
		AddFlowInput("显示", delegate(Flow f)
		{
			bool gamepad = GamepadManager.Instance.IsRuntime();
			if (gamepad)
			{
				GamepadManager.Instance.SetIsRuntime(flag: false);
			}
			bool flag = false;
			goGuide = goGuideInput.value;
			if (goGuide == null)
			{
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				Transform transform = battlePanelGameObject.transform.Find(uiGoName);
				if (transform == null)
				{
					goGuide = Asset.InstantiateWithoutCache(path, battlePanelGameObject.transform);
					goGuide.name = uiGoName;
					transform = goGuide.transform;
					for (int i = 0; i < transform.childCount; i++)
					{
						transform.GetChild(i).gameObject.SetActive(value: false);
					}
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
				if (textPanel == null || contentText == null || headIcon == null || nameText == null || arrow == null)
				{
					Transform transform2 = goGuide.transform.Find("TextPanel");
					textPanel = transform2.gameObject;
					contentText = transform2.Find("Scroll View/Viewport/Content/contextText").GetComponent<Text>();
					headIcon = transform2.Find("profile/Image/head").GetComponent<Image>();
					nameText = transform2.Find("nameText").GetComponent<Text>();
					arrow = transform2.Find("btnSkip").GetComponent<Button>();
				}
				if (textPanelButton == null)
				{
					textPanelButton = U3DUtil.Get<Button>(textPanel);
				}
				if (maskComponent == null || maskImage == null)
				{
					Transform transform3 = goGuide.transform.Find("mask (1)");
					maskComponent = transform3.GetComponent<GuideHighlightMask>();
					Transform transform4 = goGuide.transform.Find("mask");
					maskImage = transform4.GetComponent<Image>();
				}
				if (targetMaskButton == null)
				{
					GameObject gameObject = goGuide.transform.Find("maskUI").gameObject;
					targetMaskButton = U3DUtil.Get<PassEventUI>(gameObject);
					targetMaskButton.GetComponent<Image>().raycastTarget = false;
				}
				if (uiEffect == null)
				{
					Transform transform5 = goGuide.transform.Find("动效");
					if (transform5 == null)
					{
						uiEffect = Asset.InstantiateWithoutCache("Widget/System/GuideNewUI/Skill_Tips", goGuide.transform);
						uiEffect.name = "动效";
					}
					else
					{
						uiEffect = transform5.gameObject;
					}
					uiEffect.SetActive(value: false);
				}
				if (maskButton == null)
				{
					Transform transform6 = goGuide.transform.Find("mask");
					maskButton = U3DUtil.Get<Button>(transform6.gameObject);
				}
				bool value = outStyleInput.value;
				int num = 0;
				num = ((!value) ? ((!textPanelToContinueInput.value) ? 1 : (maskToContinueInput.value ? 3 : 2)) : 0);
				if (showTipsInput.value)
				{
					textPanel.SetActive(value: true);
					textPanel.transform.localPosition = tipsPositionInput.value;
					contentText.text = tipsInput.value;
					if (num == 2)
					{
						textPanelButton.gameObject.SetActive(value: true);
						UnityAction action = null;
						arrow.gameObject.SetActive(value: true);
						if (flag)
						{
							Debug.LogError("output 多次调用");
						}
						flag = true;
						action = delegate
						{
							if (gamepad)
							{
								GamepadManager.Instance.SetIsRuntime(flag: true);
							}
							textPanelButton.onClick.RemoveListener(action);
							textPanelButton.gameObject.SetActive(value: false);
							output.Call(f);
						};
						textPanelButton.onClick.AddListener(action);
						maskImage.gameObject.SetActive(!showMaskUIInput.value);
					}
					else
					{
						maskImage.gameObject.SetActive(value: false);
						arrow.gameObject.SetActive(value: false);
					}
					string value2 = tipsHeadIconInput.value;
					string value3 = tipsCharNameInput.value;
					if (!string.IsNullOrEmpty(value2) && !string.IsNullOrEmpty(value3))
					{
						nameText.text = value3;
						headIcon.sprite = AtlasManager.GetSpriteWithoutAtlas(value2);
					}
				}
				else
				{
					textPanel.SetActive(value: false);
				}
				if (showMaskUIInput.value)
				{
					maskComponent.gameObject.SetActive(value: true);
					maskComponent.style = styleInput.value;
					GameObject battlePanelGameObject2 = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
					Transform transform7 = battlePanelGameObject2.transform;
					if (maskComponent.style != 0)
					{
						transform7 = battlePanelGameObject2.transform.Find(uiPathInput.value);
						maskComponent.color = color;
						maskComponent.target = (RectTransform)transform7;
						maskComponent.DoUpdate();
					}
					if (num == 1)
					{
						RectTransform rectTransform = (RectTransform)transform7;
						RectTransform obj = uiEffect.transform as RectTransform;
						Vector2 vector = (obj.pivot - rectTransform.pivot) * rectTransform.sizeDelta;
						obj.position = rectTransform.position;
						obj.anchoredPosition += vector;
						obj.localScale = Vector3.one;
						Vector3 lossyScale = rectTransform.lossyScale;
						Vector3 lossyScale2 = obj.lossyScale;
						obj.localScale = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
						uiEffect.SetActive(value: true);
						RectTransform buttonMask = targetMaskButton.GetComponent<RectTransform>();
						buttonMask.pivot = rectTransform.pivot;
						buttonMask.sizeDelta = rectTransform.sizeDelta;
						buttonMask.position = rectTransform.position;
						buttonMask.localScale = Vector3.one;
						lossyScale2 = buttonMask.lossyScale;
						buttonMask.localScale = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
						buttonMask.gameObject.SetActive(value: true);
						if (flag)
						{
							Debug.LogError("output 多次调用");
						}
						flag = true;
						targetMaskButton.action = delegate
						{
							if (gamepad)
							{
								GamepadManager.Instance.SetIsRuntime(flag: true);
							}
							targetMaskButton.action = null;
							buttonMask.gameObject.SetActive(value: false);
							output.Call(f);
						};
					}
				}
				else
				{
					maskComponent.gameObject.SetActive(value: false);
				}
				if (num == 3)
				{
					maskButton.gameObject.SetActive(value: true);
					UnityAction action2 = null;
					action2 = delegate
					{
						if (gamepad)
						{
							GamepadManager.Instance.SetIsRuntime(flag: true);
						}
						maskButton.onClick.RemoveListener(action2);
						maskButton.gameObject.SetActive(value: false);
						output.Call(f);
					};
					if (flag)
					{
						Debug.LogError("output 多次调用");
					}
					flag = true;
					maskButton.onClick.AddListener(action2);
				}
				if (num == 0)
				{
					if (gamepad)
					{
						GamepadManager.Instance.SetIsRuntime(flag: true);
					}
					if (flag)
					{
						Debug.LogError("output 多次调用");
					}
					flag = true;
					output.Call(f);
				}
				if (!flag)
				{
					if (gamepad)
					{
						GamepadManager.Instance.SetIsRuntime(flag: true);
					}
					neverout.Call(f);
				}
			}
		});
	}
}
