using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PanelLockItem : MonoBehaviour
{
	[SerializeField]
	private GameObject unlockGo;

	[SerializeField]
	private LocalizeStringEvent des;

	[SerializeField]
	private TextMeshProUGUI desTxt;

	public void Init(int dataOpen)
	{
		bool active = false;
		desTxt.text = "";
		if (dataOpen != 0)
		{
			MissionGroup data = CoreUtils.GetData(dataOpen, RuntimeConfigs.data.missionGroups);
			if (data != null)
			{
				int[] missionId = data.missionId;
				if (missionId.Length != 0)
				{
					Mission data2 = CoreUtils.GetData(missionId[0], RuntimeConfigs.data.missions);
					if (data2 != null)
					{
						desTxt.text = CustomTagParser.ReplacePreconditionText(data2, data2.number, data2.param);
						active = Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(dataOpen);
					}
				}
				unlockGo.gameObject.SetActive(active);
			}
			else
			{
				transform.gameObject.SetActive(value: false);
			}
		}
		else
		{
			transform.gameObject.SetActive(value: false);
		}
	}
}
