using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class BloodBottleStyle : UniqStyleBase
{
	[Header("Top")]
	public GameObject useCountRoot;

	public TMP_Text useCountNumber;

	public StartList slotList;

	[Header("Middle")]
	public TMP_Text bloodBottleDes;

	public List<BottleMaterialCell> bottleMatCells;

	[Header("Bottom")]
	public GameObject teamEquipRoot;

	public LocalizeStringEvent teamEquipText;

	public override void Reset()
	{
		foreach (BottleMaterialCell bottleMatCell in bottleMatCells)
		{
			bottleMatCell.gameObject.SetActive(value: false);
		}
	}

	public override void Release()
	{
	}
}
