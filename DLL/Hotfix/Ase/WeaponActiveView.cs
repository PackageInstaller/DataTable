using UnityEngine;

namespace Ase;

public abstract class WeaponActiveView : UGuiView
{
	public class WeaponViewBindDataBase
	{
		private WeaponActiveView view;

		protected int curLayer;

		public int CurLayer
		{
			get
			{
				return curLayer;
			}
			set
			{
				curLayer = value;
				if (view != null)
				{
					view.CurLayer = value;
				}
			}
		}

		public WeaponViewBindDataBase(WeaponActiveView view)
		{
			this.view = view;
		}
	}

	[SerializeField]
	protected WeaponEnum weaponType;

	[SerializeField]
	private GameObject audioGo;

	private int curLayer;

	protected BattleUserViewModel viewModel;

	protected WeaponViewBindDataBase bindData;

	private bool isInit;

	public int CurLayer
	{
		get
		{
			return curLayer;
		}
		set
		{
			curLayer = value;
			OnLayerChange();
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = (BattleUserViewModel)userData;
		bindData = new WeaponViewBindDataBase(this);
	}

	public void WeaponAudio()
	{
		if (!(audioGo == null))
		{
			if (audioGo.activeSelf)
			{
				audioGo.SetActive(value: false);
			}
			audioGo.SetActive(value: true);
		}
	}

	protected virtual void OnLayerChange()
	{
	}

	public void WeaponRefresh(BattleUserViewModel viewModel)
	{
		if (viewModel.IsEmpty)
		{
			return;
		}
		this.viewModel = viewModel;
		base.gameObject.SetActive(weaponType == this.viewModel.HeroData.WeaponEnum);
		if (viewModel.HeroData.WeaponEnum == weaponType)
		{
			if (!isInit)
			{
				OnInitWeaponMechanism();
			}
			else
			{
				RefreshData(this.viewModel);
			}
			OnLayerChange();
		}
	}

	protected virtual void OnInitWeaponMechanism()
	{
		isInit = true;
	}
}
