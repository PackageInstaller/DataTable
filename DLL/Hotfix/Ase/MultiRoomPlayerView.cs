#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomPlayerView : UGuiView
{
	[SerializeField]
	private Text playerName;

	[SerializeField]
	private Image heroAttribute;

	[SerializeField]
	private Image heroAttribute2;

	[SerializeField]
	private Image heroDestinyIcon;

	[SerializeField]
	private GameObject playerIdentityObj;

	[SerializeField]
	private TextMeshProUGUI playerNum;

	[SerializeField]
	private TextMeshProUGUI playerLv;

	[SerializeField]
	private TextMeshProUGUI playerLvFix;

	[SerializeField]
	private GameObject playerLvFixBg;

	[SerializeField]
	private Transform headPos;

	[SerializeField]
	private GameObject inviteImgObj;

	[SerializeField]
	private Button inviteBtn;

	[SerializeField]
	private Button changeHeroBtn;

	[SerializeField]
	private GameObject infoObj;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private Image heroState;

	[SerializeField]
	private Image heroRarity;

	[SerializeField]
	private GameObject functionObj;

	[SerializeField]
	private Button btnOpenFunctionList;

	[SerializeField]
	private Image cardFrame;

	private GameObject curHeroObj;

	private string objPath = "";

	private MultiRoomPlayerViewModel _viewModel;

	[SerializeField]
	private TeamBPConfigView teamBpConfigView;

	[SerializeField]
	private GameObject teamBpConfig;

	public void Init(MultiRoomPlayerViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<MultiRoomPlayerView, MultiRoomPlayerViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(infoObj).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => !vm.IsEmpty);
		bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((MultiRoomPlayerViewModel vm) => vm.IsEmpty);
		bindingSet.Bind(inviteImgObj).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => !vm.IsMatch);
		bindingSet.Bind(inviteBtn).For((Button v) => v.onClick).To((MultiRoomPlayerViewModel vm) => vm.InviteGamer);
		bindingSet.Bind(changeHeroBtn).For((Button v) => v.onClick).To((MultiRoomPlayerViewModel vm) => vm.ChangeHero);
		bindingSet.Bind(playerName).For((Text v) => v.text).To((MultiRoomPlayerViewModel vm) => vm.GamerName);
		bindingSet.Bind(heroAttribute).For((Image v) => v.sprite).ToExpression((MultiRoomPlayerViewModel vm) => $"hero_attr_{(int)vm.HeroModel.Attribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroAttribute2).For((Image v) => v.sprite).ToExpression((MultiRoomPlayerViewModel vm) => $"hero_attr_{(int)vm.HeroModel.Attribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroDestinyIcon).For((Image v) => v.sprite).ToExpression((MultiRoomPlayerViewModel vm) => $"Hero_Seat_{vm.HeroModel.DestinyLevel}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(playerIdentityObj).For((GameObject v) => v.activeSelf).To((MultiRoomPlayerViewModel vm) => vm.IsCaption);
		bindingSet.Bind<TextMeshProUGUI>(playerNum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomPlayerViewModel vm) => vm.PlayerIdentity);
		bindingSet.Bind<TextMeshProUGUI>(playerLv).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomPlayerViewModel vm) => $"lv.{vm.HeroModel.Level}");
		bindingSet.Bind(((Component)(object)playerLv).gameObject).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => vm.LevelFix <= 0);
		bindingSet.Bind(playerLvFixBg).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => vm.LevelFix > 0);
		bindingSet.Bind(((Component)(object)playerLvFix).gameObject).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => vm.LevelFix > 0);
		bindingSet.Bind<TextMeshProUGUI>(playerLvFix).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MultiRoomPlayerViewModel vm) => $"lv.{vm.LevelFix}");
		bindingSet.Bind(heroState).For((Image v) => v.sprite).ToExpression((MultiRoomPlayerViewModel vm) => $"BattleState_{vm.State}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(heroRarity).For((Image v) => v.sprite).ToExpression((MultiRoomPlayerViewModel vm) => $"MultiRoom_Rarity_{vm.HeroModel.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((MultiRoomPlayerView v) => v.RefreshPlayerView).To((MultiRoomPlayerViewModel vm) => vm.RefreshHeroRequest);
		bindingSet.Bind(functionObj).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => !vm.IsSelf && !vm.IsEmpty);
		bindingSet.Bind(btnOpenFunctionList).For((Button v) => v.onClick).To((MultiRoomPlayerViewModel vm) => vm.OpenFunctionList);
		bindingSet.Bind(teamBpConfig).For((GameObject v) => v.activeSelf).To((MultiRoomPlayerViewModel vm) => vm.ShowTeamBPConfig);
		if (cardFrame != null)
		{
			bindingSet.Bind(cardFrame.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomPlayerViewModel vm) => !string.IsNullOrEmpty(vm.CardFrame));
			bindingSet.Bind(cardFrame).For((Image v) => v.sprite).To((MultiRoomPlayerViewModel vm) => vm.CardFrame)
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
		LoadHero();
		InitBattlePropConfig();
		viewModel.FunctionPos = new Vector2(base.gameObject.GetComponent<RectTransform>().anchoredPosition.x, base.gameObject.GetComponent<RectTransform>().anchoredPosition.y / 2f);
	}

	private void InitBattlePropConfig()
	{
		RefreshBattlePropConfig();
	}

	public void RefreshBattlePropConfig()
	{
		teamBpConfigView.RefreshData(_viewModel.TeamBpConfigViewModel);
	}

	public void RefreshPlayerView(object sender, InteractionEventArgs e)
	{
		this.SetDataContext(_viewModel);
		LoadHero();
	}

	public override void RefreshData(object userData)
	{
		_viewModel = GetUserData<MultiRoomPlayerViewModel>(userData);
		this.SetDataContext(userData);
	}

	private async void LoadHero()
	{
		if (curHeroObj != null)
		{
			curHeroObj.SetActive(value: false);
		}
		string objPathTemp = AssetUtility.GetUIItemAsset(_viewModel.HeroModel.Original);
		GameObject gameObject = await InstantiateAsync(objPathTemp, headPos);
		if (gameObject == null)
		{
			Log.Error("找不到预制体路径 " + _viewModel.HeroModel.Original);
			return;
		}
		if (curHeroObj != null)
		{
			UnityEngine.Object.Destroy(curHeroObj);
		}
		objPath = objPathTemp;
		curHeroObj = gameObject;
		UIUtilly.SpineMatchRectHelper(curHeroObj, headPos, overwrite: false);
		Transform transform = curHeroObj.transform.Find("HeadPos");
		if (transform != null && curHeroObj != null)
		{
			Vector2 anchoredPosition = transform.GetComponent<RectTransform>().anchoredPosition;
			curHeroObj.GetComponent<Transform>().SetLocalPositionX(0f - anchoredPosition.x);
			curHeroObj.GetComponent<Transform>().SetLocalPositionY(0f - anchoredPosition.y);
			SkeletonGraphic val = curHeroObj.transform.GetChild(0)?.GetComponent<SkeletonGraphic>();
			if ((UnityEngine.Object)(object)val != null)
			{
				((Graphic)(object)val).raycastTarget = false;
			}
		}
		StreamerMode.ApplySpineSkin(gameObject);
		curHeroObj.SetActive(value: true);
	}

	protected override void OnDestroy()
	{
		if (curHeroObj != null)
		{
			UnityEngine.Object.Destroy(curHeroObj);
		}
		base.OnDestroy();
	}
}
