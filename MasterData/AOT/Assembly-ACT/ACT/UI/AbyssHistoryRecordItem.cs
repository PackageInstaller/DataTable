using ACT.Core;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssHistoryRecordItem : LoopScrollBaseItem
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private LocalizeStringEvent _title;

	[SerializeField]
	private AbyssCharacter _character;

	[SerializeField]
	private LocalizeStringEvent _characterName;

	[SerializeField]
	private TextMeshProUGUI _count;

	public CanvasGroup CanvasGroup;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
	}

	public void RefreshUI(AbyssReportData abyssReportData)
	{
		_title.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
		_title.StringReference.TableEntryReference = GetTitleByReportType(abyssReportData.Type);
		_count.SetText("{0:0}", abyssReportData.Count);
		if (abyssReportData.CharacterId <= 0)
		{
			_character.gameObject.SetActive(value: false);
			_characterName.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
			_characterName.StringReference.TableEntryReference = 194L;
		}
		else
		{
			_character.gameObject.SetActive(value: true);
			_character.RefreshUI(abyssReportData.CharacterId);
			_characterName.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
			_characterName.StringReference.TableEntryReference = RuntimeConfigs.data.entityDatas[abyssReportData.CharacterId].nameLocal;
		}
	}

	private int GetTitleByReportType(AbyssReportType abyssReportType)
	{
		return abyssReportType switch
		{
			AbyssReportType.BloodBottle => 2872, 
			AbyssReportType.Ultimate => 2873, 
			AbyssReportType.Dodge => 2874, 
			AbyssReportType.Damage => 2875, 
			_ => 0, 
		};
	}

	public void PlayAnimation()
	{
		_betterAnimation.GetSequence("Show").Play();
	}
}
