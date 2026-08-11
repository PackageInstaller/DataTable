using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HCSkillDescAutoFitView : MonoBehaviour
{
	public bool showSmall = true;

	public bool hasMax = true;

	public float paddingTop;

	public float paddingBottom;

	public float upgradeText1Height;

	public float upgradeText2Height;

	public float padding;

	public float smallItemTitleHeight;

	public float maxHeight;

	public float nomaxHeight;

	public float textHeightPadding = 4f;

	public float tmpMeasureHeight = 4096f;

	public CanvasGroup cgRoot;

	public ScrollRect scrollRect;

	public ScrollRect scrollRectDesc;

	public RectTransform smallRoot;

	public TextItemView textItemTemplate;

	private List<TextItemView> smallList = new List<TextItemView>();

	public HCTSkillItemView textTemplateFirst;

	public HCTSkillItemView textTemplate;

	public Transform deriveRoot;

	public TextMeshProUGUI descText;

	public TextMeshProUGUI typeNameText;

	private List<HCTSkillItemView> allSkillList = new List<HCTSkillItemView>();

	private bool hasFinishedAuto = true;

	private bool hasFinished = true;

	private int hasUpgrade;

	private int smallIndex;

	private bool max;

	private void Start()
	{
	}

	public void Init(HCTSkillItemViewModel skillItemViewModel, List<string> smallItems, bool max)
	{
		if (scrollRectDesc != null)
		{
			scrollRectDesc.gameObject.SetActive(value: false);
		}
		scrollRect.gameObject.SetActive(value: true);
		if ((Object)(object)typeNameText != null)
		{
			((TMP_Text)typeNameText).text = skillItemViewModel.Data.SkillType;
		}
		this.max = max;
		textTemplateFirst.gameObject.SetActive(value: false);
		textTemplate.gameObject.SetActive(value: false);
		textItemTemplate.gameObject.SetActive(value: false);
		hasFinishedAuto = false;
		hasFinished = false;
		hasUpgrade = 2;
		if (allSkillList.Count == 0)
		{
			HCTSkillItemView component = Object.Instantiate(textTemplateFirst.gameObject, deriveRoot).GetComponent<HCTSkillItemView>();
			allSkillList.Add(component);
			component.Init(skillItemViewModel);
		}
		else
		{
			allSkillList[0].RefreshData(skillItemViewModel);
		}
		allSkillList[0].gameObject.SetActive(value: true);
		List<HCTSkillItemViewModel> skillDerives = skillItemViewModel.GetSkillDerives();
		if (skillDerives.Count < 1)
		{
			for (int i = 1; i < allSkillList.Count; i++)
			{
				allSkillList[i].gameObject.SetActive(value: false);
			}
		}
		else
		{
			for (int j = 0; j < skillDerives.Count; j++)
			{
				if (allSkillList.Count < j + 2)
				{
					HCTSkillItemView component2 = Object.Instantiate(textTemplate.gameObject, deriveRoot).GetComponent<HCTSkillItemView>();
					allSkillList.Add(component2);
					component2.Init(skillDerives[j]);
				}
				else
				{
					allSkillList[j + 1].RefreshData(skillDerives[j]);
				}
				allSkillList[j + 1].gameObject.SetActive(value: true);
			}
			for (int k = skillDerives.Count + 1; k < allSkillList.Count; k++)
			{
				allSkillList[k].gameObject.SetActive(value: false);
			}
		}
		if (!showSmall)
		{
			return;
		}
		smallIndex = smallItems.Count;
		if (smallItems.Count > 0)
		{
			smallRoot.gameObject.SetActive(value: true);
			for (int l = 0; l < smallItems.Count; l++)
			{
				if (smallList.Count > l)
				{
					smallList[l].RefreshData(new TextItemViewModel(null)
					{
						Text1 = smallItems[l]
					});
					continue;
				}
				TextItemView component3 = Object.Instantiate(textItemTemplate.gameObject, deriveRoot).GetComponent<TextItemView>();
				smallList.Add(component3);
				component3.Init(new TextItemViewModel(null)
				{
					Text1 = smallItems[l]
				});
			}
			for (int m = smallItems.Count; m < smallList.Count; m++)
			{
				smallList[m].gameObject.SetActive(value: false);
			}
		}
		else
		{
			for (int n = 0; n < smallList.Count; n++)
			{
				smallList[n].gameObject.SetActive(value: false);
			}
			smallRoot.gameObject.SetActive(value: false);
		}
	}

	public void InitPureDesc(string desc, string typeName, string name)
	{
		((TMP_Text)descText).text = desc?.Replace("\\n", "\n");
		((TMP_Text)typeNameText).text = typeName;
		scrollRectDesc.gameObject.SetActive(value: true);
		float y = RefreshTmpTextHeight(descText);
		scrollRectDesc.content.sizeDelta = new Vector2(scrollRectDesc.content.sizeDelta.x, y);
		scrollRectDesc.normalizedPosition = new Vector2(0f, 1f);
		scrollRect.gameObject.SetActive(value: false);
	}

	private float RefreshTmpTextHeight(TextMeshProUGUI text)
	{
		if ((Object)(object)text == null)
		{
			return 0f;
		}
		RectTransform rectTransform = ((TMP_Text)text).rectTransform;
		ContentSizeFitter component = ((Component)(object)text).GetComponent<ContentSizeFitter>();
		if (component != null && component.verticalFit != ContentSizeFitter.FitMode.Unconstrained)
		{
			component.verticalFit = ContentSizeFitter.FitMode.Unconstrained;
		}
		Canvas.ForceUpdateCanvases();
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		float num = rectTransform.rect.width;
		if (num <= 0f)
		{
			num = ((TMP_Text)text).preferredWidth;
		}
		rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, tmpMeasureHeight);
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		((TMP_Text)text).ForceMeshUpdate(false, false);
		float y = ((TMP_Text)text).GetPreferredValues(((TMP_Text)text).text, num, 0f).y;
		float renderedTextHeight = GetRenderedTextHeight(text);
		float num2 = Mathf.Ceil(Mathf.Max(y, renderedTextHeight) + textHeightPadding);
		rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, num2);
		((TMP_Text)text).ForceMeshUpdate(false, false);
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		return num2;
	}

	private float GetRenderedTextHeight(TextMeshProUGUI text)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		TMP_TextInfo textInfo = ((TMP_Text)text).textInfo;
		if (textInfo == null || textInfo.lineCount <= 0)
		{
			return 0f;
		}
		TMP_LineInfo val = textInfo.lineInfo[0];
		TMP_LineInfo val2 = textInfo.lineInfo[textInfo.lineCount - 1];
		return val.ascender - val2.descender + ((TMP_Text)text).margin.y + ((TMP_Text)text).margin.w;
	}

	private void Update()
	{
		if (hasUpgrade > 1)
		{
			hasUpgrade--;
		}
		else
		{
			if (hasFinished)
			{
				return;
			}
			if (hasFinishedAuto)
			{
				hasFinished = true;
			}
			else if (hasUpgrade == 1)
			{
				hasUpgrade--;
				hasFinishedAuto = true;
				float num = paddingTop;
				for (int i = 0; i < allSkillList.Count; i++)
				{
					if (allSkillList[i].gameObject.activeSelf)
					{
						float num2 = RefreshTmpTextHeight(allSkillList[i].descText);
						allSkillList[i].RectTransform.anchoredPosition = new Vector2(0f, 0f - num);
						num += (allSkillList[i].HasConsumeBar() ? upgradeText1Height : upgradeText2Height);
						num += num2;
					}
				}
				num += paddingBottom;
				hasFinishedAuto = true;
				if (showSmall)
				{
					if (smallIndex > 0)
					{
						smallRoot.anchoredPosition = new Vector2(0f, 0f - num);
						num += smallItemTitleHeight;
					}
					for (int j = 0; j < smallList.Count; j++)
					{
						if (j < smallIndex)
						{
							smallList[j].gameObject.SetActive(value: true);
							float num3 = RefreshTmpTextHeight(smallList[j].text1);
							smallList[j].RectTransform.anchoredPosition = new Vector2(0f, 0f - num);
							num += padding;
							num += num3;
						}
					}
				}
				if (hasMax)
				{
					scrollRect.GetComponent<RectTransform>().sizeDelta = new Vector2(scrollRect.GetComponent<RectTransform>().sizeDelta.x, max ? maxHeight : nomaxHeight);
				}
				scrollRect.content.sizeDelta = new Vector2(scrollRect.content.sizeDelta.x, num);
				scrollRect.content.anchoredPosition = new Vector2(scrollRect.content.anchoredPosition.x, 0f);
			}
			else
			{
				float y = paddingTop + paddingBottom;
				scrollRect.content.sizeDelta = new Vector2(scrollRect.content.sizeDelta.x, y);
				hasFinishedAuto = true;
			}
		}
	}
}
