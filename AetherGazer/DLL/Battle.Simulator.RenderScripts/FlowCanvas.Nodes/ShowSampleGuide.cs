using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示简单的指引", 0)]
[Category("Render/UI")]
[Description("显示简单的指引")]
public class ShowSampleGuide : FlowNode, IUpdatable
{
	private GameObject textPanel;

	private Text contentText;

	private Image headIcon;

	private Text nameText;

	private GuideHighlightMask maskComponent;

	public Color color;

	private GameObject uiEffect;

	private Button attackBtn;

	public float minTime = 1f;

	public float maxTime = 6f;

	private float runningTime;

	private bool startCount;

	private bool addedListener;

	private FlowOutput output;

	private Flow flow;

	private GameObject btnToHide;

	public string attackPath = "BattleButtons/Melee";

	public Vector2 offsetSize = new Vector2(70f, 70f);

	public string path = "Widget/System/GuideNewUI/GuideNewUI";

	public string uiGoName = "GuideUI";

	public string iconPath = "icon";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<Color>().Serialize(ref writer, color, options);
		writer.Write(minTime);
		writer.Write(maxTime);
		writer.Write(attackPath);
		options.Resolver.GetFormatter<Vector2>().Serialize(ref writer, offsetSize, options);
		writer.Write(path);
		writer.Write(iconPath);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		color = options.Resolver.GetFormatter<Color>().Deserialize(ref reader, options);
		minTime = reader.ReadSingle();
		maxTime = reader.ReadSingle();
		attackPath = reader.ReadString();
		offsetSize = options.Resolver.GetFormatter<Vector2>().Deserialize(ref reader, options);
		path = reader.ReadString();
		iconPath = reader.ReadString();
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		startCount = false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goGuideInput = AddValueInput<GameObject>("指引预制体");
		GameObject goGuide = null;
		AddValueOutput("预制体", () => goGuide);
		ValueInput<string> tipsInput = AddValueInput<string>("要显示的提示");
		ValueInput<Vector2> tipsPositionInput = AddValueInput<Vector2>("提示的位置");
		ValueInput<string> tipsHeadIconInput = AddValueInput<string>("提示人物头像");
		ValueInput<string> tipsCharNameInput = AddValueInput<string>("提示人物名称");
		ValueInput<string> uiPathInput = AddValueInput<string>("UI路径");
		ValueInput<int> styleInput = AddValueInput<int>("形状");
		output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goGuide = goGuideInput.value;
			GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
			if (goGuide == null)
			{
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
				if (textPanel == null || contentText == null || headIcon == null || nameText == null)
				{
					Transform transform2 = goGuide.transform.Find("TextPanel");
					textPanel = transform2.gameObject;
					contentText = transform2.Find("Scroll View/Viewport/Content/contextText").GetComponent<Text>();
					headIcon = transform2.Find("profile/Image/head").GetComponent<Image>();
					nameText = transform2.Find("nameText").GetComponent<Text>();
				}
				if (maskComponent == null)
				{
					Transform transform3 = goGuide.transform.Find("mask (1)");
					maskComponent = transform3.GetComponent<GuideHighlightMask>();
				}
				if (btnToHide == null)
				{
					Transform transform4 = battlePanelGameObject.transform.Find(attackPath);
					btnToHide = transform4.gameObject;
				}
				if (attackBtn == null)
				{
					Transform transform5 = textPanel.transform.Find("btnEx");
					GameObject gameObject = null;
					if (transform5 == null)
					{
						gameObject = Object.Instantiate(btnToHide, textPanel.transform, worldPositionStays: true);
						Object.Destroy(gameObject.GetComponent<P08AttackButton>());
						gameObject.name = "btnEx";
					}
					else
					{
						gameObject = transform5.gameObject;
					}
					attackBtn = U3DUtil.Get<Button>(gameObject);
				}
				if (uiEffect == null)
				{
					Transform transform6 = goGuide.transform.Find("动效");
					if (transform6 == null)
					{
						uiEffect = Asset.InstantiateWithoutCache("Widget/System/GuideNewUI/Skill_Tips", goGuide.transform);
						uiEffect.name = "动效";
					}
					else
					{
						uiEffect = transform6.gameObject;
					}
					uiEffect.SetActive(value: false);
				}
				goGuide.transform.Find("holdMask").SetActive(bActive: false);
				textPanel.SetActive(value: true);
				textPanel.transform.localPosition = tipsPositionInput.value;
				contentText.text = tipsInput.value;
				string value = tipsHeadIconInput.value;
				string value2 = tipsCharNameInput.value;
				if (!string.IsNullOrEmpty(value) && !string.IsNullOrEmpty(value2))
				{
					nameText.text = value2;
					headIcon.sprite = AtlasManager.GetSpriteWithoutAtlas(value);
				}
				RectTransform rectTransform = (RectTransform)attackBtn.transform;
				attackBtn.gameObject.SetActive(value: true);
				btnToHide.SetActive(value: false);
				rectTransform.position = btnToHide.transform.position;
				Image component = rectTransform.Find(iconPath).GetComponent<Image>();
				component.sprite = AtlasManager.GetSprite("Atlas/Guide", "rect_next");
				rectTransform = component.transform as RectTransform;
				RectTransform obj = uiEffect.transform as RectTransform;
				Vector2 vector = (obj.pivot - rectTransform.pivot) * rectTransform.sizeDelta;
				obj.position = rectTransform.position;
				obj.anchoredPosition += vector;
				obj.localScale = Vector3.one;
				Vector3 lossyScale = rectTransform.lossyScale;
				Vector3 lossyScale2 = obj.lossyScale;
				obj.localScale = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
				uiEffect.SetActive(value: true);
				maskComponent.gameObject.SetActive(value: true);
				maskComponent.style = styleInput.value;
				maskComponent.color = color;
				rectTransform = battlePanelGameObject.transform.Find(uiPathInput.value) as RectTransform;
				maskComponent.target = rectTransform;
				RectTransform obj2 = goGuide.transform.Find("buttonMask") as RectTransform;
				obj2.gameObject.SetActive(value: true);
				obj2.GetComponent<Image>().raycastTarget = false;
				obj2.pivot = rectTransform.pivot;
				obj2.sizeDelta = rectTransform.sizeDelta + offsetSize;
				obj2.position = rectTransform.position;
				obj2.anchoredPosition += new Vector2(offsetSize.x * (rectTransform.pivot.x - 0.5f), offsetSize.y * (rectTransform.pivot.y - 0.5f));
				obj2.localScale = Vector3.one;
				lossyScale = rectTransform.lossyScale;
				lossyScale2 = obj2.lossyScale;
				obj2.localScale = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
				startCount = true;
				flow = f;
				runningTime = 0f;
			}
		});
	}

	public void Exit()
	{
		btnToHide.SetActive(value: true);
		startCount = false;
		runningTime = 0f;
		addedListener = false;
		attackBtn.gameObject.SetActive(value: false);
		attackBtn.onClick.RemoveAllListeners();
		flow.Call(output);
	}

	public void Update()
	{
		if (!startCount)
		{
			return;
		}
		runningTime += Time.deltaTime;
		if (runningTime > minTime && !addedListener)
		{
			addedListener = true;
			if (attackBtn.onClick.GetPersistentEventCount() == 0)
			{
				attackBtn.onClick.AddListener(delegate
				{
					Exit();
				});
			}
		}
		if (runningTime > maxTime)
		{
			Exit();
		}
	}
}
