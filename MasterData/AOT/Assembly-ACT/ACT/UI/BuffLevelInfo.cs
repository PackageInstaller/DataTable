using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.UI;

public class BuffLevelInfo : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent m_LevelText;

	[SerializeField]
	private LocalizeStringEvent m_BuffInfo;

	public void Init(int level, EquipFeatureData equipFeatureData)
	{
		m_LevelText.StringReference.GetVariable<int>("0").Value = level;
		SkillGroupLevelData data = CoreUtils.GetData(TableRule.GetSkillGroupLevelId(equipFeatureData.skillGroupData, level), RuntimeConfigs.data.skillGroupLevelDatas);
		if (data == null)
		{
			return;
		}
		SkillDetailMessageData messageData = CoreUtils.GetData(data.skillDes.FirstOrDefault(), RuntimeConfigs.data.skillDetailMessageDatas);
		if (messageData == null)
		{
			return;
		}
		AsyncOperationHandle<StringTable> tableAsync = LocalizationSettings.StringDatabase.GetTableAsync("longcommon");
		tableAsync.Completed += (AsyncOperationHandle<StringTable> l) =>
		{
			StringTableEntry entry = l.Result.GetEntry(messageData.briefDescLocal);
			if (entry != null)
			{
				entry.IsSmart = false;
				string arg = CustomTagParser.ReplaceText(messageData.skillid, entry.GetLocalizedString(), level);
				m_BuffInfo.OnUpdateString?.Invoke(arg);
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		};
	}

	public void Init(int level, int equipFeatureId)
	{
		Init(level, CoreUtils.GetData(equipFeatureId, RuntimeConfigs.data.equipFeatureDatas));
	}
}
