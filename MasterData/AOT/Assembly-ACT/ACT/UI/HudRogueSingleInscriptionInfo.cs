using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Runtime.Model;
using UnityEngine;

namespace ACT.UI;

public class HudRogueSingleInscriptionInfo : MonoBehaviour
{
	public RogueInfoInScriptionIconItem Item;

	public Transform TfSynergy;

	public GameObject InfoSynergyPrefab;

	private void Start()
	{
	}

	public void Init(int id)
	{
		SetInscriptionsInfo(id);
	}

	private void SetInscriptionsInfo(int id)
	{
		if (TfSynergy.childCount > 0)
		{
			TfSynergy.DestroyChildren();
		}
		CoreUtils.GetData(id, RuntimeConfigs.data.inscriptions);
		Item.Init(id, Model<RogueNewModel>.Interface.RogueStation);
		List<Synergy> synergysByInscriptionId = Model<RogueNewModel>.Interface.GetSynergysByInscriptionId(id);
		for (int i = 0; i < synergysByInscriptionId.Count; i++)
		{
			UIUtility.AddWidget<RogueBagSynergyDesItem>(TfSynergy, InfoSynergyPrefab).Init(synergysByInscriptionId[i]);
		}
	}

	private void Update()
	{
	}
}
