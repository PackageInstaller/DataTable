using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using ACT.Config;
using ACT.RichText;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT;

public class SkillGroupCell : MonoBehaviour
{
	public LocalizeStringEvent title;

	public Transform skillSheetRoot;

	public GameObject operateTextPrefab;

	public TextMeshProUGUI skillSheetContainer;

	public LocalizeStringEvent description;

	public TMP_Text descriptionText;

	public RectTransform arrow;

	private Vector3 foldVector3 = new Vector3(1f, -1f, 1f);

	private Vector3 expandVector3 = new Vector3(1f, 1f, 1f);

	private LocalizedString m_LocalizedString = new LocalizedString("longcommon", 0L);

	private Stack<GameObject> m_OperateTextPool = new Stack<GameObject>();

	private Stack<GameObject> m_SkillSheetPool = new Stack<GameObject>();

	private int m_SkillId;

	private int m_SkillGroupId;

	private int level = 1;

	private bool m_IsDetail;

	private int m_InitVersion;

	public void Init(int skillGroupId, SkillDetailMessageData skillMessageId, int curLevel, bool isDetail)
	{
		m_SkillGroupId = skillGroupId;
		m_SkillId = skillMessageId.skillid;
		level = curLevel;
		int initVersion = ++m_InitVersion;
		ClearSkillSheetRoot();
		title.StringReference.TableEntryReference = skillMessageId.nameLocal;
		m_LocalizedString.FallbackState = FallbackBehavior.DontUseFallback;
		m_LocalizedString.TableEntryReference = skillMessageId.commandListDescLocal;
		if (skillMessageId.commandListDescLocal == 0)
		{
			GenSkillSheet(string.Empty);
		}
		else
		{
			AsyncOperationHandle<string> localizedStringAsync = m_LocalizedString.GetLocalizedStringAsync();
			localizedStringAsync.Completed += (AsyncOperationHandle<string> l) =>
			{
				if (initVersion == m_InitVersion)
				{
					GenSkillSheet(l.Result);
				}
			};
		}
		SetDescription(isDetail ? skillMessageId.detailDescLocal : skillMessageId.briefDescLocal);
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		m_InitVersion++;
	}

	private void SetDescription(int descriptionId)
	{
		AsyncOperationHandle<StringTable> tableAsync = LocalizationSettings.StringDatabase.GetTableAsync("longcommon");
		tableAsync.Completed += (AsyncOperationHandle<StringTable> l) =>
		{
			StringTableEntry entry = l.Result.GetEntry(descriptionId);
			if (entry != null)
			{
				entry.IsSmart = false;
				string arg = CustomTagParser.ReplaceText(m_SkillId, entry.GetLocalizedString(), level);
				description.OnUpdateString?.Invoke(arg);
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		};
	}

	private void SetTextAlignment(string text)
	{
		descriptionText.ForceMeshUpdate();
		bool flag = text.Contains("\n");
		bool flag2 = descriptionText.textInfo.lineCount > 1;
		if (flag | flag2)
		{
			descriptionText.alignment = TextAlignmentOptions.Left;
		}
		else
		{
			descriptionText.alignment = TextAlignmentOptions.Top;
		}
	}

	private void ClearSkillSheetRoot()
	{
		for (int num = skillSheetRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = skillSheetRoot.GetChild(num);
			if ((bool)child.GetComponent<TextMeshProUGUI>())
			{
				ReturnSkillSheet(child.gameObject);
			}
			else
			{
				ReturnOperateText(child.gameObject);
			}
		}
	}

	private void GenSkillSheet(string input)
	{
		ClearSkillSheetRoot();
		string[] array = (from x in Regex.Split(input, "((?:<sprite=\\d+>)+)")
			where !string.IsNullOrEmpty(x)
			select x).ToArray();
		foreach (string text in array)
		{
			if (Regex.Match(text, "((?:<sprite=\\d+>)+)").Success)
			{
				GetSkillSheet().text = text;
			}
			else
			{
				GetOperateText().text = text;
			}
		}
	}

	private TextMeshProUGUI GetSkillSheet()
	{
		TextMeshProUGUI textMeshProUGUI = ((m_SkillSheetPool.Count > 0) ? m_SkillSheetPool.Pop().GetComponent<TextMeshProUGUI>() : Object.Instantiate(skillSheetContainer, skillSheetRoot));
		textMeshProUGUI.transform.SetParent(skillSheetRoot);
		textMeshProUGUI.gameObject.SetActive(value: true);
		return textMeshProUGUI;
	}

	private void ReturnSkillSheet(GameObject go)
	{
		go.transform.SetParent(transform);
		go.SetActive(value: false);
		m_SkillSheetPool.Push(go);
	}

	private TextMeshProUGUI GetOperateText()
	{
		GameObject gameObject = ((m_OperateTextPool.Count > 0) ? m_OperateTextPool.Pop() : Object.Instantiate(operateTextPrefab, skillSheetRoot));
		gameObject.transform.SetParent(skillSheetRoot);
		gameObject.gameObject.SetActive(value: true);
		return gameObject.transform.GetChild(0).GetComponent<TextMeshProUGUI>();
	}

	private void ReturnOperateText(GameObject go)
	{
		go.transform.SetParent(transform);
		go.SetActive(value: false);
		m_OperateTextPool.Push(go);
	}

	private void Fold()
	{
		title.gameObject.SetActive(value: true);
		description.gameObject.SetActive(value: false);
		arrow.localScale = foldVector3;
	}

	private void Expand()
	{
		title.gameObject.SetActive(value: true);
		description.gameObject.SetActive(value: true);
		arrow.localScale = expandVector3;
	}

	public void OnValueChanged(bool isOn)
	{
	}
}
