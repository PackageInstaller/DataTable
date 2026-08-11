#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleUserInfoView : UGuiView
{
	public Color color1;

	public Color color2;

	public Color color3;

	[SerializeField]
	private BattleUserView p1View;

	private BattleUserView p2View;

	private BattleUserView p3View;

	[SerializeField]
	private List<BattleUserView> teammateViews;

	[SerializeField]
	private List<TouchLayoutPos> pos;

	private BattleUserInfoViewModel viewModel;

	public BattleTeamRecuseView RecuseTeamer1;

	public BattleTeamRecuseView RecuseTeamer2;

	public BattleTeamRecuseView RecuseSelf;

	public List<Image> rebornIcons;

	public GameObject rebornRoot;

	private int rebornTimes;

	public int RebornTimes
	{
		get
		{
			return rebornTimes;
		}
		set
		{
			rebornTimes = value;
			SetRebornIconTimes();
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = (BattleUserInfoViewModel)userData;
		BindingSet<BattleUserInfoView, BattleUserInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleUserInfoView v) => v.OnChangeHero).To((BattleUserInfoViewModel vm) => vm.ChangeHeroRequest);
		bindingSet.Bind(this).For((BattleUserInfoView v) => v.RebornTimes).To((BattleUserInfoViewModel vm) => vm.RebornTimes);
		bindingSet.Bind(this).For((BattleUserInfoView v) => v.OnDismissRequest).To((BattleUserInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		if (teammateViews.Count < 4)
		{
			Log.Error("队友界面配置异常！");
			return;
		}
		p1View.Init(viewModel.GetBattleUser(1));
		GameObject gameObject = teammateViews[0].transform.parent.gameObject;
		GameObject obj = teammateViews[2].transform.parent.gameObject;
		gameObject.SetActive(viewModel.IsSingleGame);
		obj.SetActive(!viewModel.IsSingleGame);
		if (viewModel.IsSingleGame)
		{
			p2View = teammateViews[0];
			p3View = teammateViews[1];
		}
		else
		{
			p2View = teammateViews[2];
			p3View = teammateViews[3];
		}
		p2View.Init(viewModel.GetBattleUser(2));
		p3View.Init(viewModel.GetBattleUser(3));
		RecuseTeamer1.Init(viewModel.GetBattleUser(2));
		RecuseTeamer2.Init(viewModel.GetBattleUser(3));
		RecuseSelf.Init(viewModel.GetBattleUser(1));
	}

	private void OnDismissRequest(object sender, InteractionEventArgs e)
	{
		this.ClearAllBindings();
	}

	public void RefreshLayout(TouchLayout layout)
	{
		for (int i = 0; i < pos.Count; i++)
		{
			TouchLayoutPos config = layout.GetConfig(pos[i].touchType);
			if (config == null)
			{
				pos[i].root.gameObject.SetActive(value: false);
			}
			else
			{
				pos[i].root.anchoredPosition = config.root.anchoredPosition;
			}
		}
	}

	private void OnChangeHero(object sender, InteractionEventArgs e)
	{
		p1View.RefreshData(viewModel.GetBattleUser(1));
		RecuseSelf.RefreshData(viewModel.GetBattleUser(1));
		BattleUserViewModel battleUser = viewModel.GetBattleUser(2);
		BattleUserViewModel battleUser2 = viewModel.GetBattleUser(3);
		if (battleUser != null)
		{
			p2View.RefreshData(battleUser);
			RecuseTeamer1.RefreshData(battleUser);
		}
		if (battleUser2 != null)
		{
			p3View.RefreshData(battleUser2);
			RecuseTeamer2.RefreshData(battleUser2);
		}
	}

	public void RefreshData(BattleUserInfoViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private void SetRebornIconTimes()
	{
		for (int i = 0; i < rebornIcons.Count; i++)
		{
			if (i < RebornTimes)
			{
				rebornIcons[i].gameObject.SetActive(value: true);
			}
			else
			{
				rebornIcons[i].gameObject.SetActive(value: false);
			}
		}
	}
}
