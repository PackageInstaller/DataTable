using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("开关指定战斗UI", 0)]
[Category("Render/UI")]
[Description("隐藏指定战斗UI, 填的是相对路径")]
public class DisableTargetBattleUI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<string>> targetListInput = AddValueInput<List<string>>("要隐藏的UI路径");
		ValueInput<bool> isEnableInput = AddValueInput<bool>("是否显示");
		ValueInput<bool> useProhibitUIInput = AddValueInput<bool>("使用禁用样式的UI替换");
		ValueInput<string> prohibitUIPathInput = AddValueInput<string>("替换的预制体路径").SetDefaultAndSerializedValue("UI/Prohibit_UI");
		ValueInput<List<string>> instNameInput = AddValueInput<List<string>>("实例名");
		ValueInput<BattleUIElementActiveChangeReason> reasonInput = AddValueInput<BattleUIElementActiveChangeReason>("开关原因").SetDefaultAndSerializedValue(BattleUIElementActiveChangeReason.FlowNode);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
			List<string> value = targetListInput.value;
			bool value2 = isEnableInput.value;
			bool value3 = useProhibitUIInput.value;
			string value4 = prohibitUIPathInput.value;
			List<string> value5 = instNameInput.value;
			for (int i = 0; i < value.Count; i++)
			{
				Transform transform = battlePanelGameObject.transform.Find(value[i]);
				if (transform != null)
				{
					IBattleUIElement component = transform.gameObject.GetComponent<IBattleUIElement>();
					if (component != null)
					{
						component.SetActive(value2, reasonInput.value);
					}
					else
					{
						transform.gameObject.SetActive(value2);
					}
					if (value3 && !string.IsNullOrEmpty(value5[i]))
					{
						Transform parent = transform.parent;
						Transform transform2 = parent.Find(value5[i]);
						if (transform2 == null && !value2)
						{
							GameObject gameObject = Asset.InstantiateWithoutCache(value4, parent);
							if (gameObject != null)
							{
								transform2 = gameObject.transform;
								gameObject.name = value5[i];
								RectTransform rectTransform = transform as RectTransform;
								RectTransform obj = transform2 as RectTransform;
								Vector2 vector = (obj.pivot - rectTransform.pivot) * rectTransform.sizeDelta;
								if (rectTransform.childCount > 0)
								{
									vector += (rectTransform.GetChild(0) as RectTransform).anchoredPosition;
								}
								obj.localPosition = rectTransform.localPosition;
								vector.Scale(rectTransform.localScale);
								obj.anchoredPosition += vector;
								obj.localScale = rectTransform.localScale;
							}
						}
						if (transform2 != null)
						{
							transform2.gameObject.SetActive(!value2);
						}
					}
				}
			}
			output.Call(f);
		});
	}
}
