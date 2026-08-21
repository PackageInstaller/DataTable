using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GlovesItem : MonoBehaviour
{
	public Image angerFill1;

	public Image angerFill2;

	public GameObject angerEffect1;

	public GameObject angerEffect2;

	public Transform energyRoot;

	public GlovesEnergyItem energyBar;

	public List<GlovesEnergyItem> energyBarList;

	[SerializeField]
	private GlovesActiveView parentView;

	private int energyBarCount;

	private float energyCur;

	private int energyMax;

	private int energyEach;

	private float angerCur;

	public int EnergyBarCount
	{
		get
		{
			return energyBarCount;
		}
		set
		{
			energyBarCount = value;
			energyBarList.Clear();
			int childCount = energyRoot.childCount;
			for (int i = 0; i < childCount; i++)
			{
				if (energyBarCount > i)
				{
					energyRoot.GetChild(i).gameObject.SetActive(value: true);
				}
				else
				{
					energyRoot.GetChild(i).gameObject.SetActive(value: false);
				}
				GlovesEnergyItem component = energyRoot.GetChild(i).GetComponent<GlovesEnergyItem>();
				if (component != null)
				{
					energyBarList.Add(component);
				}
			}
			for (int j = childCount; j < energyBarCount; j++)
			{
				GlovesEnergyItem component2 = Object.Instantiate(energyBar.gameObject, energyRoot).GetComponent<GlovesEnergyItem>();
				if (component2 != null)
				{
					component2.SetVal(0f);
					energyBarList.Add(component2);
				}
			}
		}
	}

	public float EnergyCur
	{
		get
		{
			return energyCur;
		}
		set
		{
			energyCur = value;
			if (energyEach == 0)
			{
				energyEach = 1;
			}
			int num = (int)(energyCur / (float)energyEach);
			for (int i = 0; i < energyBarList.Count; i++)
			{
				if (i + 1 <= num && energyBarList[i].SetVal(1f) && parentView != null)
				{
					parentView.WeaponAudio();
				}
			}
			float num2 = energyCur - (float)(num * energyEach);
			if (energyBarList.Count > num)
			{
				energyBarList[num].SetVal((float)((double)num2 * 1.0 / (double)energyEach));
				for (int j = num + 1; j < energyBarList.Count; j++)
				{
					energyBarList[j].SetVal(0f);
				}
			}
		}
	}

	public int EnergyEach
	{
		get
		{
			return energyEach;
		}
		set
		{
			energyEach = value;
		}
	}

	public float AngerCur
	{
		get
		{
			return angerCur;
		}
		set
		{
			angerCur = value;
			float fillAmount = ((value <= 0.5f) ? (value * 2f) : 1f);
			float fillAmount2 = ((value > 0.5f) ? ((value - 0.5f) * 2f) : 0f);
			AngerShow(fillAmount, angerFill1, value >= 0.5f, angerEffect1);
			AngerShow(fillAmount2, angerFill2, value >= 1f, angerEffect2);
		}
	}

	private void AngerShow(float fillAmount, Image fillImage, bool showEffect, GameObject effectGo)
	{
		fillImage.fillAmount = fillAmount;
		if (effectGo.activeSelf != showEffect)
		{
			effectGo.SetActive(showEffect);
		}
		if (fillImage.enabled == showEffect)
		{
			fillImage.enabled = !showEffect;
		}
	}
}
