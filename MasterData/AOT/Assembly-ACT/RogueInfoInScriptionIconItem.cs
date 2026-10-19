using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class RogueInfoInScriptionIconItem : MonoBehaviour
{
	public BImage imageInScriptionIcon;

	public new LocalizeStringEvent name;

	public GameObject InScriptionLevelRoot;

	public TextMeshProUGUI InScriptionLevel;

	public TextMeshProUGUI InScriptionNewLevel;

	public ActButton BtnClick;

	public void Init(int inScriptionId, ImageAssetStation station, bool needLevel = false)
	{
		Inscription data = CoreUtils.GetData(inScriptionId, RuntimeConfigs.data.inscriptions);
		if (data != null)
		{
			name.StringReference.TableEntryReference = data.name;
			station.LoadImage(189, data.iconAddress, imageInScriptionIcon);
			if (needLevel)
			{
				int inscriptionById = Model<RogueNewModel>.Interface.GetInscriptionById(inScriptionId);
				InScriptionLevel.SetText(inscriptionById.FastToString());
				InScriptionNewLevel.SetText((inscriptionById + 1).FastToString());
			}
			InScriptionLevelRoot.SetActive(needLevel);
		}
	}
}
