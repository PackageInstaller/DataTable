using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Runtime.Model;
using UnityEngine;

namespace ACT.UI;

public class HudRogueTwoInscriptionInfo : MonoBehaviour
{
	public RogueInfoInScriptionIconItem FirstItem;

	public Transform FirstTfSynergy;

	public GameObject FirstInfoSynergyPrefab;

	public RogueInfoInScriptionIconItem SecondItem;

	public Transform SecondTfSynergy;

	public GameObject SecondInfoSynergyPrefab;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void Init(int[] insriptions)
	{
		SetInscriptionsInfo(insriptions[0], FirstTfSynergy, FirstItem, FirstInfoSynergyPrefab);
		SetInscriptionsInfo(insriptions[1], SecondTfSynergy, SecondItem, SecondInfoSynergyPrefab);
	}

	private void SetInscriptionsInfo(int id, Transform tfSynergy, RogueInfoInScriptionIconItem item, GameObject infoSynergyPrefab)
	{
		if (tfSynergy.childCount > 0)
		{
			tfSynergy.DestroyChildren();
		}
		CoreUtils.GetData(id, RuntimeConfigs.data.inscriptions);
		item.Init(id, Model<RogueNewModel>.Interface.RogueStation);
		List<Synergy> synergysByInscriptionId = Model<RogueNewModel>.Interface.GetSynergysByInscriptionId(id);
		for (int i = 0; i < synergysByInscriptionId.Count; i++)
		{
			UIUtility.AddWidget<RogueBagSynergyDesItem>(tfSynergy, infoSynergyPrefab).Init(synergysByInscriptionId[i]);
		}
	}
}
