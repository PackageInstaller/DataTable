using ACT.Core;
using ACT.Model;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class FavorabilityUnlockItem : LoopScrollBaseItem
{
	[SerializeField]
	private LocalizeStringEvent _unlockEntryText;

	[SerializeField]
	private LocalizeStringEvent _detailsText;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		UnlockEntry unlockEntry = Model<FavorabilityModel>.Interface.UnlockEntries[idx];
		switch (unlockEntry.Type)
		{
		case UnlockEntryType.Drama:
		{
			_unlockEntryText.SetTable("Common");
			_unlockEntryText.StringReference.TableEntryReference = 2355L;
			if (RuntimeConfigs.data.loungeStorys.TryGetValue(unlockEntry.EntryId, out var value))
			{
				_detailsText.SetTable("longcommon");
				_detailsText.StringReference.TableEntryReference = value.storyText;
			}
			break;
		}
		case UnlockEntryType.Point:
			_unlockEntryText.SetTable("Common");
			_unlockEntryText.StringReference.TableEntryReference = 2356L;
			break;
		case UnlockEntryType.Story:
			_unlockEntryText.SetTable("Common");
			_unlockEntryText.StringReference.TableEntryReference = 2357L;
			break;
		case UnlockEntryType.Audio:
			_unlockEntryText.SetTable("Common");
			_unlockEntryText.StringReference.TableEntryReference = 2358L;
			break;
		}
	}
}
