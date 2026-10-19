using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleBuffNode : LoopScrollBaseItem
{
	public BImage icon;

	public LocalizeStringEvent buffName;

	public TextMeshProUGUI buffDes;

	public ActButton btn;

	public GameObject selected;

	public GameObject dataRoot;

	public GameObject emptyRoot;

	private TempleBuffNodeData _data;

	public TempleBuffNodeData Data => _data;

	public void Init(TempleBuffNodeData data, ImageAssetStation station)
	{
		if (data == null)
		{
			dataRoot?.SetActive(value: false);
			emptyRoot?.SetActive(value: true);
		}
		else if (data != null && data.buffId > 0)
		{
			_data = data;
			station.LoadImage(167, _data.iconId, icon);
			SkillDetailMessageData data2 = CoreUtils.GetData(TableRule.GetSkillGroupLevelData(data.buffId, 1).id, RuntimeConfigs.data.skillDetailMessageDatas);
			if (data2 != null)
			{
				string localizeString = LocalizationUtility.GetLocalizeString("longcommon", data2.detailDescLocal, isSmart: false);
				string text = CustomTagParser.ReplaceText(data2.skillid, localizeString, 1);
				buffDes.text = text;
				buffName.SetReference(LocalizeTable.ShortCommon, data2.nameLocal);
			}
			if (emptyRoot != null)
			{
				emptyRoot.SetActive(value: false);
			}
			SetSelectedState(isSelected: false);
		}
	}

	public void SetSelectedState(bool isSelected)
	{
		if (!(selected == null))
		{
			selected.SetActive(isSelected);
		}
	}

	public void UnInit()
	{
		_data = null;
	}
}
