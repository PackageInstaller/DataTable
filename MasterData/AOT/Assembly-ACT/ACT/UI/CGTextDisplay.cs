using System.Collections.Generic;
using ACT.Config;
using ACT.Game;
using ACT.Model;
using ACT.Sound;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CGTextDisplay : MonoBehaviour
{
	[Header("底部单行")]
	[SerializeField]
	private GameObject bottomSingleRoot;

	[SerializeField]
	private LocalizeStringEvent bottomSingleText;

	[Header("底部双行")]
	[SerializeField]
	private GameObject bottomDoubleRoot;

	[SerializeField]
	private LocalizeStringEvent bottomDoubleLine1;

	[SerializeField]
	private LocalizeStringEvent bottomDoubleLine2;

	[Header("顶部单行")]
	[SerializeField]
	private GameObject topSingleRoot;

	[SerializeField]
	private LocalizeStringEvent topSingleText;

	private void Update()
	{
		if (!gameObject.activeInHierarchy)
		{
			return;
		}
		CGModule cGModule = Model<CGModule>.Interface;
		if (cGModule == null)
		{
			HideAll();
			return;
		}
		IReadOnlyDictionary<int, DialogueCG> activeTexts = cGModule.ActiveTexts;
		if (activeTexts == null || activeTexts.Count == 0)
		{
			HideAll();
		}
		else
		{
			Show(activeTexts);
		}
	}

	public void Show(IReadOnlyDictionary<int, DialogueCG> textInfos)
	{
		if (textInfos == null || textInfos.Count == 0)
		{
			HideAll();
			return;
		}
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = G.detailUserInfo.Brief.Gender == 1;
		foreach (KeyValuePair<int, DialogueCG> textInfo in textInfos)
		{
			DialogueCG value = textInfo.Value;
			if (value != null)
			{
				int contentId = ((flag4 && value.maleContent1 != 0) ? value.maleContent1 : value.content1);
				int content2Id = ((flag4 && value.maleContent2 != 0) ? value.maleContent2 : value.content2);
				switch (value.type)
				{
				case 1:
					ShowBottomSingle(contentId);
					flag = true;
					break;
				case 2:
					ShowBottomDouble(contentId, content2Id);
					flag2 = true;
					break;
				case 3:
					ShowTopSingle(contentId);
					flag3 = true;
					break;
				}
			}
		}
		if (!flag)
		{
			Hide(1);
		}
		if (!flag2)
		{
			Hide(2);
		}
		if (!flag3)
		{
			Hide(3);
		}
	}

	public void Hide(int type)
	{
		switch (type)
		{
		case 1:
			if (bottomSingleRoot != null)
			{
				bottomSingleRoot.SetActive(value: false);
			}
			break;
		case 2:
			if (bottomDoubleRoot != null)
			{
				bottomDoubleRoot.SetActive(value: false);
			}
			break;
		case 3:
			if (topSingleRoot != null)
			{
				topSingleRoot.SetActive(value: false);
			}
			break;
		}
	}

	public void HideAll()
	{
		if (bottomSingleRoot != null)
		{
			bottomSingleRoot.SetActive(value: false);
		}
		if (bottomDoubleRoot != null)
		{
			bottomDoubleRoot.SetActive(value: false);
		}
		if (topSingleRoot != null)
		{
			topSingleRoot.SetActive(value: false);
		}
	}

	private void ShowBottomSingle(int contentId)
	{
		if (!(bottomSingleRoot == null) && !(bottomSingleText == null))
		{
			bottomSingleRoot.SetActive(value: true);
			bottomSingleText.StringReference.TableEntryReference = contentId;
		}
	}

	private void ShowBottomDouble(int contentId, int content2Id)
	{
		if (!(bottomDoubleRoot == null))
		{
			bottomDoubleRoot.SetActive(value: true);
			if (bottomDoubleLine1 != null)
			{
				bottomDoubleLine1.StringReference.TableEntryReference = contentId;
			}
			if (bottomDoubleLine2 != null)
			{
				bottomDoubleLine2.StringReference.TableEntryReference = content2Id;
			}
		}
	}

	private void ShowTopSingle(int contentId)
	{
		if (!(topSingleRoot == null) && !(topSingleText == null))
		{
			topSingleRoot.SetActive(value: true);
			topSingleText.StringReference.TableEntryReference = contentId;
		}
	}
}
