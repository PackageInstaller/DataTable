using ACT.Config;
using ACT.Core;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CultivateTypeTitle : MonoBehaviour
{
	public LocalizeStringEvent title;

	public Transform childRoot;

	public void SetRaidTypeTile(int raidType)
	{
		RaidTypeDes data = CoreUtils.GetData(raidType, RuntimeConfigs.data.raidTypeDess);
		if (data != null)
		{
			title.SetTable("shortcommon");
			title.StringReference.TableEntryReference = data.typeDes;
		}
	}
}
