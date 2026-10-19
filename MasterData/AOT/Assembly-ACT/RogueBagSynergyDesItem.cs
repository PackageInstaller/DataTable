using System.Collections.Generic;
using ACT.Config;
using ACT.Model;
using ACT.Utility;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class RogueBagSynergyDesItem : MonoBehaviour
{
	public LocalizeStringEvent TextSynergyDes;

	public GameObject Activate;

	public GameObject UnActivate;

	public Color activeColor;

	public Color UnactiveColor;

	private void Start()
	{
	}

	public void Init(Synergy data)
	{
		int inscriptionById = Model<RogueNewModel>.Interface.GetInscriptionById(data.inscriptionId);
		int threshold = data.threshold;
		IList<object> list = new List<object>();
		list.Add(data.threshold);
		list.Add(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data.description));
		TextSynergyDes.GetComponent<TextMeshProUGUI>().text = LocalizationUtility.GetLocalizeString("Common", 2522, list);
		SetState(inscriptionById >= threshold);
	}

	private void SetState(bool active)
	{
		if ((bool)Activate)
		{
			Activate.SetActive(active);
			UnActivate.SetActive(!active);
			TextSynergyDes.GetComponent<TextMeshProUGUI>().color = (active ? activeColor : UnactiveColor);
		}
	}

	private void Update()
	{
	}
}
