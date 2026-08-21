using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LanceActiveView : WeaponActiveView
{
	[SerializeField]
	private Image heroCourageFillImage1;

	[SerializeField]
	private Image heroCourageFillImage2;

	[SerializeField]
	private Image heroCourageFillImage2_1;

	[SerializeField]
	private GameObject heroMightShow;

	[SerializeField]
	private Animator heroMightAnimator;

	[SerializeField]
	private GameObject segmentObj;

	[SerializeField]
	private Transform segmentParent;

	[SerializeField]
	private float segmentWidth = 270f;

	private List<LanceActiveSegment> segmentLists = new List<LanceActiveSegment>(5);

	protected WeaponMechanismLanceViewModel lanceViewModel;

	private Ase.ECS.PropertyData heroCourageData;

	private Ase.ECS.PropertyData heroMightData;

	private Ase.ECS.PropertyData eachHCNoMightHideData;

	private float heroCourageFill;

	private float heroCourageMax;

	private float heroMightFill;

	private float heroMightMax;

	private float heroMightCur;

	private float eachHCNoMightCur;

	private bool curShowHeroMight;

	private int segmentShowCount;

	private float segmentHeroCourage;

	private int heroCourageUIState;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		heroCourageFillImage2.enabled = false;
		heroCourageFillImage2_1.enabled = false;
		heroMightShow.SetActive(value: false);
		lanceViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismLanceViewModel;
		UpdateProertyData();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		lanceViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismLanceViewModel;
		UpdateProertyData();
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	private void UpdateProertyData()
	{
		lanceViewModel.Property.TryGetValue("HeroCourage", out heroCourageData);
		lanceViewModel.Property.TryGetValue("HeroMight", out heroMightData);
		lanceViewModel.Property.TryGetValue("EachHeroCourageNoMightHide", out eachHCNoMightHideData);
	}

	private void LateUpdate()
	{
		if (lanceViewModel == null || !lanceViewModel.InitFinish)
		{
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if (heroCourageData != null && heroCourageData.MaxValue != 0f)
		{
			float num = heroCourageData.CurValue / heroCourageData.MaxValue;
			if (num != heroCourageFill)
			{
				heroCourageFill = num;
				heroCourageFillImage1.fillAmount = heroCourageFill;
				heroCourageFillImage2.fillAmount = heroCourageFill;
				heroCourageFillImage2_1.fillAmount = heroCourageFill;
				flag2 = true;
			}
			if (heroCourageMax != heroCourageData.MaxValue)
			{
				heroCourageMax = heroCourageData.MaxValue;
				flag = true;
			}
		}
		if (lanceViewModel.segmentCount != segmentShowCount || lanceViewModel.segmentNum != segmentHeroCourage)
		{
			segmentShowCount = lanceViewModel.segmentCount;
			segmentHeroCourage = lanceViewModel.segmentNum;
			flag = true;
		}
		if (flag)
		{
			UpdateSegment();
		}
		if (heroMightData != null && heroMightData.MaxValue != 0f)
		{
			if (heroMightCur != heroMightData.CurValue)
			{
				heroMightCur = heroMightData.CurValue;
				flag2 = true;
			}
			bool flag3 = heroMightData.CurValue == 1f;
			if (curShowHeroMight != flag3)
			{
				if (flag3)
				{
					heroMightShow.SetActive(flag3);
					heroMightAnimator.SetBool("Out", false);
					WeaponAudio();
				}
				else
				{
					heroMightAnimator.SetBool("Out", true);
				}
				curShowHeroMight = flag3;
			}
		}
		if (eachHCNoMightCur != eachHCNoMightHideData.CurValue)
		{
			eachHCNoMightCur = eachHCNoMightHideData.CurValue;
			flag2 = true;
		}
		if (flag2)
		{
			UpdateSegmentTypeShow();
		}
		UpdateCourageUI();
	}

	private void UpdateCourageUI()
	{
		if (heroMightData == null)
		{
			return;
		}
		bool flag = heroMightCur == 1f && segmentShowCount > 0 && heroCourageData.CurValue >= segmentHeroCourage;
		if (heroCourageUIState == 0)
		{
			if (flag && heroCourageUIState != 1)
			{
				heroCourageUIState = 1;
				HeroCourageUIUpdate();
			}
		}
		else if (heroCourageUIState == 1 && !flag && heroCourageUIState != 0)
		{
			heroCourageUIState = 0;
			HeroCourageUIUpdate();
		}
	}

	private void HeroCourageUIUpdate()
	{
		bool flag = heroCourageUIState == 1;
		if (heroCourageFillImage2.enabled != flag)
		{
			heroCourageFillImage2.enabled = flag;
		}
		if (heroCourageFillImage2_1.enabled != flag)
		{
			heroCourageFillImage2_1.enabled = flag;
		}
	}

	private void UpdateSegmentTypeShow()
	{
		if (heroMightCur == 0f)
		{
			for (int i = 0; i < segmentShowCount; i++)
			{
				if (eachHCNoMightHideData.CurValue == 1f)
				{
					segmentLists[i].NoSegmentShow();
				}
				else if (eachHCNoMightHideData.CurValue == 0f)
				{
					segmentLists[i].SetSegmentShow(showLong: false);
				}
			}
		}
		else if (heroMightCur == 1f)
		{
			for (int j = 0; j < segmentShowCount; j++)
			{
				segmentLists[j].SetSegmentShow(heroCourageData.CurValue >= segmentHeroCourage * (float)(j + 1));
			}
		}
	}

	private void UpdateSegment()
	{
		if (segmentLists.Count < segmentShowCount)
		{
			for (int i = segmentLists.Count; i <= segmentShowCount; i++)
			{
				LanceActiveSegment component = Object.Instantiate(segmentObj, segmentParent).GetComponent<LanceActiveSegment>();
				segmentLists.Add(component);
			}
		}
		for (int j = 0; j < segmentLists.Count; j++)
		{
			if (segmentShowCount - 1 >= j)
			{
				segmentLists[j].gameObject.SetActive(value: true);
				segmentLists[j].transform.localPosition = Vector3.right * ((float)(j + 1) * segmentHeroCourage / heroCourageMax * segmentWidth - segmentWidth / 2f);
			}
			else
			{
				segmentLists[j].gameObject.SetActive(value: false);
			}
		}
	}

	private void DestorySegment()
	{
		if (segmentLists == null)
		{
			return;
		}
		for (int i = 0; i < segmentLists.Count; i++)
		{
			if (segmentLists[i] != null)
			{
				Object.Destroy(segmentLists[i]);
			}
		}
		segmentLists = null;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		DestorySegment();
	}
}
