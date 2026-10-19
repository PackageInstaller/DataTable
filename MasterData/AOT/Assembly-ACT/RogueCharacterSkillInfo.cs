using ACT;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

public class RogueCharacterSkillInfo : MonoBehaviour
{
	public LocalizeStringEvent SkillInfoGroupTextName;

	public TextMeshProUGUI TextCd;

	public Transform TfDesc;

	public GameObject SkillDesc;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void SetDescription(int SkillGroupId, RogueAssistCharacter characterdata)
	{
		SkillGroupData data = CoreUtils.GetData(SkillGroupId, RuntimeConfigs.data.skillGroupDatas);
		if (data == null)
		{
			return;
		}
		SkillInfoGroupTextName.SetTable(LocalizeTable.ShortCommon);
		TextMeshProUGUI textCd = TextCd;
		int skillCd = characterdata.skillCd;
		textCd.SetText(skillCd.ToString());
		SkillInfoGroupTextName.StringReference.TableEntryReference = data.skillSetLocal;
		int level = characterdata.tier;
		SkillGroupLevelData data2 = CoreUtils.GetData(data.GetSkillGroupLevelId(1), RuntimeConfigs.data.skillGroupLevelDatas);
		if (TfDesc.childCount > 0)
		{
			TfDesc.DestroyChildren();
		}
		for (int i = 0; i < data2.skillDes.Length; i++)
		{
			LocalizeStringEvent descitem = UIUtility.AddWidget<LocalizeStringEvent>(TfDesc, SkillDesc.gameObject);
			descitem.gameObject.SetActive(value: true);
			SkillDetailMessageData messageInfo = CoreUtils.GetData(data2.skillDes[i], RuntimeConfigs.data.skillDetailMessageDatas);
			AsyncOperationHandle<StringTable> tableAsync = LocalizationSettings.StringDatabase.GetTableAsync("longcommon");
			tableAsync.Completed += (AsyncOperationHandle<StringTable> l) =>
			{
				StringTableEntry entry = l.Result.GetEntry(messageInfo.detailDescLocal);
				if (entry != null)
				{
					entry.IsSmart = false;
					string arg = CustomTagParser.ReplaceText(messageInfo.skillid, entry.GetLocalizedString(), level);
					descitem.OnUpdateString?.Invoke(arg);
				}
				else
				{
					_ = LuminApplication.LogEnabled;
				}
			};
		}
	}
}
