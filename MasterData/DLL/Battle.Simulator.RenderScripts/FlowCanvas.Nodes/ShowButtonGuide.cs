using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示按键说明", 0)]
[Category("Render/UI")]
[Description("显示按键说明, 说明方位 (0:上, 1:下, 2:左, 3:右)")]
public class ShowButtonGuide : FlowNode
{
	public enum TipsDirection
	{
		Up,
		Bottom,
		Left,
		Right
	}

	public string guidePrefabPath = "Widget/System/GuideNewUI/FightGuideUI";

	public float boardSize = -10f;

	public string rectPath = "buttonMask";

	public string textPath = "buttonMask/TextPanel/contextText";

	public string textPanelPath = "buttonMask/TextPanel";

	public string instName = "FightGuideUI";

	public Vector2 buttonMaskBoader = new Vector2(40f, 60f);

	private GameObject fightGuideUI;

	private Transform buttonMask;

	private Transform textPanel;

	private Text text;

	private PassEventUI button;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		guidePrefabPath = reader.ReadString();
		boardSize = reader.ReadSingle();
		rectPath = reader.ReadString();
		textPath = reader.ReadString();
		textPanelPath = reader.ReadString();
		instName = reader.ReadString();
		buttonMaskBoader = options.Resolver.GetFormatter<Vector2>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(guidePrefabPath);
		writer.Write(boardSize);
		writer.Write(rectPath);
		writer.Write(textPath);
		writer.Write(textPanelPath);
		writer.Write(instName);
		options.Resolver.GetFormatter<Vector2>().Serialize(ref writer, buttonMaskBoader, options);
	}

	private static void SetDirectionIcon(RectTransform icon, float rotateDegree, Vector2 anchor)
	{
		icon.localRotation = Quaternion.Euler(0f, 0f, rotateDegree);
		icon.anchorMin = anchor;
		icon.anchorMax = anchor;
		icon.anchoredPosition = Vector2.zero;
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("预制体", () => fightGuideUI);
		ValueInput<string> uiPathInput = AddValueInput<string>("要指引的UI路径");
		ValueInput<bool> showTextPanelInput = AddValueInput<bool>("显示文本框").SetDefaultAndSerializedValue(v: true);
		ValueInput<Vector2> textPanelSizeInput = AddValueInput<Vector2>("文本框大小").SetDefaultAndSerializedValue(new Vector2(316f, 120f));
		ValueInput<string> tipsInput = AddValueInput<string>("说明内容");
		ValueInput<int> tipsDirectionInput = AddValueInput<int>("说明方位");
		ValueInput<bool> actionInput = AddValueInput<bool>("是否响应点击").SetDefaultAndSerializedValue(v: true);
		ValueInput<Vector2> touchSizeOffsetInput = AddValueInput<Vector2>("响应区域调整");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject battlepanel = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
			if (fightGuideUI == null)
			{
				Transform transform = battlepanel.transform.Find(instName);
				if (transform == null)
				{
					fightGuideUI = Asset.InstantiateWithoutCache(guidePrefabPath, battlepanel.transform);
					if (fightGuideUI == null)
					{
						fightGuideUI.name = instName;
					}
				}
				else
				{
					fightGuideUI = transform.gameObject;
				}
			}
			if (fightGuideUI == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (buttonMask == null)
				{
					buttonMask = fightGuideUI.transform.Find(rectPath);
				}
				if (buttonMask == null)
				{
					errorOut.Call(f);
				}
				else
				{
					if (textPanel == null)
					{
						textPanel = fightGuideUI.transform.Find(textPanelPath);
					}
					if (textPanel == null)
					{
						errorOut.Call(f);
					}
					else
					{
						if (text == null)
						{
							Transform transform2 = fightGuideUI.transform.Find(textPath);
							if (transform2 != null)
							{
								text = transform2.GetComponent<Text>();
							}
						}
						if (text == null)
						{
							errorOut.Call(f);
						}
						else
						{
							if (button == null)
							{
								button = buttonMask.GetComponent<PassEventUI>();
							}
							if (button == null)
							{
								errorOut.Call(f);
							}
							else
							{
								text.text = tipsInput.value;
								(textPanel as RectTransform).sizeDelta = textPanelSizeInput.value;
								Transform transform3 = battlepanel.transform.Find(uiPathInput.value);
								Vector2 vector = ((buttonMask as RectTransform).pivot - (transform3 as RectTransform).pivot) * (transform3 as RectTransform).sizeDelta;
								(buttonMask as RectTransform).position = (transform3 as RectTransform).position;
								(buttonMask as RectTransform).anchoredPosition += vector;
								(buttonMask as RectTransform).sizeDelta = (transform3 as RectTransform).sizeDelta + buttonMaskBoader;
								(buttonMask as RectTransform).localScale = Vector3.one;
								Vector3 lossyScale = (transform3 as RectTransform).lossyScale;
								Vector3 lossyScale2 = (buttonMask as RectTransform).lossyScale;
								(buttonMask as RectTransform).localScale = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
								button.SetTarget(transform3 as RectTransform);
								(textPanel as RectTransform).localScale = new Vector3(lossyScale2.x / lossyScale.x, lossyScale2.y / lossyScale.y, lossyScale2.z / lossyScale.z);
								Vector2 vector2 = Vector2.zero;
								Vector2 sizeDelta = (buttonMask as RectTransform).sizeDelta;
								Vector2 vector3 = Vector2.Scale((textPanel as RectTransform).sizeDelta, new Vector2(lossyScale2.x / lossyScale.x, lossyScale2.y / lossyScale.y));
								switch ((TipsDirection)tipsDirectionInput.value)
								{
								case TipsDirection.Up:
									vector2 = new Vector2(0f, (sizeDelta.y + vector3.y) * 0.5f - boardSize);
									break;
								case TipsDirection.Bottom:
									vector2 = new Vector2(0f, (0f - (sizeDelta.y + vector3.y)) * 0.5f + boardSize);
									break;
								case TipsDirection.Left:
									vector2 = new Vector2((0f - (sizeDelta.x + vector3.x)) * 0.5f + boardSize, 0f);
									break;
								case TipsDirection.Right:
									vector2 = new Vector2((sizeDelta.x + vector3.x) * 0.5f - boardSize, 0f);
									break;
								}
								textPanel.localPosition = vector2;
								buttonMask.gameObject.SetActive(value: true);
								if (actionInput.value)
								{
									Action action = delegate
									{
										button.action = null;
										buttonMask.gameObject.SetActive(value: false);
										fightGuideUI.transform.parent = battlepanel.transform;
										output.Call(f);
									};
									button.action = action;
									button.touchSizeOffset = touchSizeOffsetInput.value;
								}
								if (showTextPanelInput.value)
								{
									textPanel.gameObject.SetActive(value: true);
								}
								else
								{
									textPanel.gameObject.SetActive(value: false);
								}
							}
						}
					}
				}
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			if (fightGuideUI == null)
			{
				errorOut.Call(f);
			}
			else
			{
				fightGuideUI.transform.parent = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform;
				buttonMask.gameObject.SetActive(value: false);
			}
		});
	}
}
