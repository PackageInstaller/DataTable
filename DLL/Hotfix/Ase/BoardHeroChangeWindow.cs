using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BoardHeroChangeWindow : UGuiWindow
{
	[SerializeField]
	private TabToggle tabHero;

	[SerializeField]
	private TabToggle tabBg;

	[SerializeField]
	private LoopGridView heroGridView;

	[SerializeField]
	private BoardChangeItem bgDefaultItem;

	[SerializeField]
	private LoopGridView bgGridView;

	[SerializeField]
	private Transform outerRoot;

	private GameObject _outerBg;

	[SerializeField]
	private Transform innerRoot;

	private GameObject _innerBg;

	[SerializeField]
	private RectTransform spineRoot;

	private GameObject _heroSpine;

	[SerializeField]
	private Button btnSave;

	[SerializeField]
	private GameObject maskGrey;

	[SerializeField]
	private Button btnBack;

	private BoardHeroChangeViewModel _viewModel;

	private string heroAssetPath;

	private string bgAssetPath;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BoardHeroChangeViewModel>();
		BindingSet<BoardHeroChangeWindow, BoardHeroChangeViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((BoardHeroChangeWindow v) => v.OnDismissRequest).To((BoardHeroChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BoardHeroChangeViewModel vm) => vm.Close);
		bindingSet.Bind(btnSave.gameObject).For((GameObject v) => v.activeSelf).To((BoardHeroChangeViewModel vm) => vm.CanSave);
		bindingSet.Bind(maskGrey).For((GameObject v) => v.activeSelf).ToExpression((BoardHeroChangeViewModel vm) => !vm.CanSave);
		bindingSet.Bind().For((BoardHeroChangeWindow v) => RefreshHero).To((BoardHeroChangeViewModel vm) => vm.RefreshHeroRst);
		bindingSet.Bind().For((BoardHeroChangeWindow v) => RefreshBg).To((BoardHeroChangeViewModel vm) => vm.RefreshBgRst);
		bindingSet.Bind(btnSave).For((Button v) => v.onClick).To((BoardHeroChangeViewModel vm) => vm.SaveCmd);
		bindingSet.Build();
		bgDefaultItem.Init(_viewModel.BgDefaultModeItemData);
		heroGridView.InitGridView(_viewModel.ScreenHeroDatas.Count, OnGetHeroItemByIndex);
		bgGridView.InitGridView(_viewModel.ScreenBgDatas.Count, OnGetBgItemByIndex);
		tabHero.AddSelectedAction(OnTabChanged);
		tabBg.AddSelectedAction(OnTabChanged);
		RefreshHero();
		RefreshBg();
	}

	private void OnTabChanged(int index)
	{
		heroGridView.gameObject.SetActive(index == 1);
		bgGridView.gameObject.SetActive(index == 2);
	}

	public void RefreshScrolls()
	{
		heroGridView.SetListItemCount(_viewModel.ScreenHeroDatas.Count);
		heroGridView.RefreshAllShownItem();
		bgGridView.SetListItemCount(_viewModel.ScreenBgDatas.Count);
		bgGridView.RefreshAllShownItem();
	}

	protected LoopGridViewItem OnGetHeroItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= _viewModel.ScreenHeroDatas.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BoardChangeItem");
		if (loopGridViewItem != null)
		{
			BoardChangeItemData data = _viewModel.ScreenHeroDatas[index];
			BoardChangeItem component = loopGridViewItem.GetComponent<BoardChangeItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(data);
			}
			else
			{
				component.RefreshData(data);
			}
		}
		return loopGridViewItem;
	}

	protected LoopGridViewItem OnGetBgItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= _viewModel.ScreenBgDatas.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BoardChangeItem");
		if (loopGridViewItem != null)
		{
			BoardChangeItemData data = _viewModel.ScreenBgDatas[index];
			BoardChangeItem component = loopGridViewItem.GetComponent<BoardChangeItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(data);
			}
			else
			{
				component.RefreshData(data);
			}
		}
		return loopGridViewItem;
	}

	private async void RefreshHero(object sender = null, InteractionEventArgs e = null)
	{
		innerRoot.gameObject.SetActive(_viewModel.CurSelectHeroItemData == null || _viewModel.CurSelectHeroItemData.DrHero.StateType == 0);
		if (_viewModel.CurSelectHeroItemData == null)
		{
			return;
		}
		DRBoardHeroList drHero = _viewModel.CurSelectHeroItemData.DrHero;
		string oldAssetPath = heroAssetPath;
		heroAssetPath = drHero.AssetPath;
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(heroAssetPath), spineRoot);
		if (!(gameObject == null))
		{
			GameObject heroSpine = _heroSpine;
			DisposeHeroSpine(oldAssetPath, heroSpine);
			_heroSpine = gameObject;
			spineRoot.localScale = new Vector3((drHero.Scale.Count > 0) ? drHero.Scale[0] : 1f, (drHero.Scale.Count > 1) ? drHero.Scale[1] : 1f, (drHero.Scale.Count > 2) ? drHero.Scale[2] : 1f);
			spineRoot.anchoredPosition = new Vector2((drHero.Position.Count > 0) ? drHero.Position[0] : 0f, (drHero.Position.Count > 1) ? drHero.Position[1] : 0f);
			SkeletonGraphic component = _heroSpine.transform.GetChild(0).GetComponent<SkeletonGraphic>();
			if ((Object)(object)component != null)
			{
				component.freeze = false;
			}
			StreamerMode.ApplySpineSkin(gameObject);
		}
	}

	private async void RefreshBg(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurSelectBgItemData != null)
		{
			string oldAssetPath = bgAssetPath;
			bgAssetPath = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetBackground(_viewModel.CurSelectBgItemData.Id)
				.AssetPath;
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(bgAssetPath), outerRoot);
			if (!(gameObject == null))
			{
				GameObject outerBg = _outerBg;
				DisposeBg(oldAssetPath, outerBg);
				_outerBg = gameObject;
			}
		}
	}

	private void DisposeHeroSpine(string assetPath, GameObject spineObj)
	{
		if (spineObj != null)
		{
			Object.DestroyImmediate(spineObj);
		}
	}

	private void DisposeBg(string assetPath, GameObject bgObj)
	{
		if (bgObj != null)
		{
			Object.DestroyImmediate(bgObj);
		}
	}

	protected override void OnDismiss()
	{
		DisposeHeroSpine(heroAssetPath, _heroSpine);
		DisposeBg(bgAssetPath, _outerBg);
		base.OnDismiss();
	}
}
