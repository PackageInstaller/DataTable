#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GunActiveView : WeaponActiveView
{
	public class GunViewBindData : WeaponViewBindDataBase
	{
		protected GunActiveView gunView;

		public float Threshold
		{
			get
			{
				return 0f;
			}
			set
			{
				gunView.Threshold = value;
			}
		}

		public float BulletCount
		{
			get
			{
				return 0f;
			}
			set
			{
				if (gunView.BulletCount != value)
				{
					gunView.BulletCount = value;
				}
			}
		}

		public bool ShowBulletList
		{
			get
			{
				return false;
			}
			set
			{
				gunView.bulletRoot.SetActive(value);
			}
		}

		public GunViewBindData(WeaponActiveView view)
			: base(view)
		{
			gunView = view as GunActiveView;
		}
	}

	[SerializeField]
	private float bulletPadding;

	[SerializeField]
	private GameObject bulletTemp;

	[SerializeField]
	private RectTransform bulletBar;

	private List<BulletSquare> bulletList = new List<BulletSquare>();

	[SerializeField]
	private Image slider1;

	[SerializeField]
	private Image slider1_1;

	[SerializeField]
	private Image slider2;

	[SerializeField]
	private Image slider2_1;

	[SerializeField]
	private Image slider3;

	[SerializeField]
	private Image slider3_1;

	[SerializeField]
	private RectTransform normalThbar;

	[SerializeField]
	private RectTransform fullHeatThbar;

	[SerializeField]
	private RectTransform barParent;

	private float threshold;

	private float bulletCount;

	private int _bulletCountMax;

	private int _bulletCountCur;

	[SerializeField]
	private GameObject textRoot;

	[SerializeField]
	private GameObject reloadRoot;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private TextMeshProUGUI text2;

	[SerializeField]
	private TextMeshProUGUI maxText;

	[SerializeField]
	private TextMeshProUGUI maxText2;

	[SerializeField]
	private GameObject overHearEffect;

	[SerializeField]
	private GameObject bulletRoot;

	private WeaponMechanismGunViewModel gunViewModel;

	protected GunViewBindData gunBindData;

	private bool fullHeatBarState;

	[SerializeField]
	private Animation fullHeatBarAni;

	public float Threshold
	{
		get
		{
			return threshold;
		}
		set
		{
			threshold = value;
			float x = barParent.sizeDelta.x * threshold;
			normalThbar.anchoredPosition = new Vector2(x, normalThbar.anchoredPosition.y);
			fullHeatThbar.anchoredPosition = new Vector2(x, fullHeatThbar.anchoredPosition.y);
		}
	}

	public float BulletCount
	{
		get
		{
			return bulletCount;
		}
		set
		{
			bulletCount = gunViewModel.GunBulletCountCur;
			int gunBulletCountMax = gunViewModel.GunBulletCountMax;
			if (gunBulletCountMax <= 0)
			{
				return;
			}
			_ = (bulletBar.sizeDelta.x - bulletPadding * (float)(gunBulletCountMax - 1)) / (float)gunBulletCountMax;
			for (int i = bulletList.Count; i < gunBulletCountMax; i++)
			{
				GameObject gameObject = Object.Instantiate(bulletTemp, bulletBar);
				if (gameObject == null)
				{
					Log.Error("创建子弹块模板失败！");
					return;
				}
				BulletSquare component = gameObject.GetComponent<BulletSquare>();
				bulletList.Add(component);
			}
			for (int j = 0; j < gunBulletCountMax; j++)
			{
				if ((float)gunViewModel.GunBulletList.Count < bulletCount)
				{
					bulletList[j].SetBulletType(GetBulletType(WeaponGunBulletType.Normal));
				}
				else if ((float)j < bulletCount)
				{
					bulletList[j].SetBulletType(GetBulletType(gunViewModel.GunBulletList[j].BulletType));
				}
				else
				{
					bulletList[j].SetBulletType(GetBulletType(WeaponGunBulletType.None));
				}
				bulletList[j].gameObject.SetActive(value: true);
			}
			for (int k = gunBulletCountMax; k < bulletList.Count; k++)
			{
				bulletList[k].gameObject.SetActive(value: false);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		gunBindData = new GunViewBindData(this);
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		gunViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismGunViewModel;
		BindingSet<GunActiveView, WeaponMechanismGunViewModel> bindingSet = this.CreateBindingSet(gunViewModel);
		bindingSet.Bind(gunBindData).For((GunViewBindData v) => v.Threshold).To((WeaponMechanismGunViewModel vm) => vm.ThresholdFill);
		bindingSet.Bind(gunBindData).For((GunViewBindData v) => v.ShowBulletList).To((WeaponMechanismGunViewModel vm) => vm.ShowBullet);
		bindingSet.Build();
	}

	private void LateUpdate()
	{
		WeaponMechanismGunViewModel weaponMechanismGunViewModel = gunViewModel;
		if (slider1.fillAmount != weaponMechanismGunViewModel.HeroHeatFill)
		{
			slider1.fillAmount = weaponMechanismGunViewModel.HeroHeatFill;
			slider1_1.fillAmount = weaponMechanismGunViewModel.HeroHeatFill;
			slider2.fillAmount = weaponMechanismGunViewModel.HeroHeatFill;
			slider2_1.fillAmount = weaponMechanismGunViewModel.HeroHeatFill;
		}
		bool flag = weaponMechanismGunViewModel.GunState == WeaponMechanismGun.GunState.Normal;
		if (slider1.gameObject.activeSelf != flag)
		{
			slider1.gameObject.SetActive(flag);
		}
		bool flag2 = weaponMechanismGunViewModel.GunState == WeaponMechanismGun.GunState.FullHeat;
		if (slider2.gameObject.activeSelf != flag2)
		{
			slider2.gameObject.SetActive(flag2);
		}
		bool flag3 = weaponMechanismGunViewModel.GunState == WeaponMechanismGun.GunState.OverHear;
		if (slider3.gameObject.activeSelf != flag3)
		{
			slider3.gameObject.SetActive(flag3);
			if (flag3)
			{
				slider3.fillAmount = 1f;
				slider3_1.fillAmount = 1f;
			}
		}
		else if (slider3.gameObject.activeSelf)
		{
			slider3.fillAmount = weaponMechanismGunViewModel.OverHearFill;
			slider3_1.fillAmount = weaponMechanismGunViewModel.OverHearFill;
		}
		if (overHearEffect.activeSelf != flag3)
		{
			overHearEffect.SetActive(flag3);
		}
		bool flag4 = gunViewModel.HeroHeatFill > 0f && gunViewModel.HeroHeatFill >= gunViewModel.ThresholdFill;
		if (normalThbar.gameObject.activeSelf != (!flag3 && !flag4))
		{
			normalThbar.gameObject.SetActive(!flag3 && !flag4);
		}
		if (fullHeatBarState != (!flag3 & flag4))
		{
			fullHeatThbar.gameObject.SetActive(value: true);
			fullHeatBarState = !flag3 & flag4;
			if (fullHeatBarState)
			{
				fullHeatBarAni.Play("light_enter");
				WeaponAudio();
			}
			else
			{
				fullHeatBarAni.Play("light_out");
			}
		}
		if (weaponMechanismGunViewModel.IsUpdateBullet)
		{
			_bulletCountCur = weaponMechanismGunViewModel.GunBulletCountCur;
			((TMP_Text)text).SetText(ZString.Format("{0}", _bulletCountCur), true);
			((TMP_Text)text2).SetText(ZString.Format("{0}", _bulletCountCur), true);
			BulletCount = weaponMechanismGunViewModel.GunBulletCountCur;
			weaponMechanismGunViewModel.IsUpdateBullet = false;
		}
		if (_bulletCountMax != weaponMechanismGunViewModel.GunBulletCountMax)
		{
			_bulletCountMax = weaponMechanismGunViewModel.GunBulletCountMax;
			((TMP_Text)maxText).SetText(ZString.Format("/{0}", _bulletCountMax), true);
			((TMP_Text)maxText2).SetText(ZString.Format("/{0}", _bulletCountMax), true);
			BulletCount = _bulletCountMax;
		}
		bool flag5 = weaponMechanismGunViewModel.GunBulletCountCur >= 0 && weaponMechanismGunViewModel.Reloading == 0f;
		if (textRoot.activeSelf != flag5)
		{
			textRoot.SetActive(flag5);
			if (flag5)
			{
				((TMP_Text)text).transform.localScale = Vector3.zero;
				((TMP_Text)text2).transform.localScale = Vector3.zero;
			}
		}
		bool flag6 = weaponMechanismGunViewModel.Reloading > 0f && weaponMechanismGunViewModel.WeaponEnum == weaponType;
		if (reloadRoot.activeSelf != flag6)
		{
			reloadRoot.SetActive(flag6);
		}
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		gunViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismGunViewModel;
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	private int GetBulletType(WeaponGunBulletType bulletType)
	{
		switch (bulletType)
		{
		case WeaponGunBulletType.None:
			return -1;
		case WeaponGunBulletType.Normal:
			return 0;
		case WeaponGunBulletType.SpecialBullet1:
			return 1;
		case WeaponGunBulletType.SpecialBullet2:
			return 2;
		case WeaponGunBulletType.SpecialBullet3:
			return 3;
		case WeaponGunBulletType.SpecialBullet4:
			return 4;
		default:
			Log.Error("子弹颜色配置异常");
			return -1;
		}
	}
}
