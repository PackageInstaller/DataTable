using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

public class RogueReplaceInscriptionItem : MonoBehaviour
{
	public BImage ImageInscriptionIcon;

	public TextMeshProUGUI TextInscriptionNum;

	private List<int> _temporaryBags = new List<int>();

	public Color NormalColor;

	public Color AddColor;

	public Color SubColor;

	private void Start()
	{
	}

	public void Init(int inscriptionId, int Count, ImageAssetStation station)
	{
		Inscription inscription = RuntimeConfigs.data.inscriptions[inscriptionId];
		if (inscription != null)
		{
			station.LoadImage(189, inscription.iconAddress, ImageInscriptionIcon);
		}
	}

	public void RefreshCount(int oldCount, int newCount)
	{
		TextInscriptionNum.SetText("{0:0}", newCount);
		TextInscriptionNum.color = GetNumColor(oldCount, newCount);
	}

	private Color GetNumColor(int oldCount, int newCount)
	{
		if (oldCount == newCount)
		{
			return NormalColor;
		}
		if (newCount > oldCount)
		{
			return AddColor;
		}
		return SubColor;
	}

	private void Update()
	{
	}
}
