using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameMapNpcWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private RectTransform spine;

	[SerializeField]
	private Image mapBg;

	[SerializeField]
	private LoopListView2 mapNpcList;

	[SerializeField]
	private TextMeshProUGUI npcName;

	[SerializeField]
	private TextMeshProUGUI npcDesc;

	private string npcImgPath = "";

	private string mapImgPath = "";

	private GameMapNpcViewModel viewModel;

	private GameObject spineObj;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameMapNpcViewModel>();
		BindingSet<GameMapNpcWindow, GameMapNpcViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameMapNpcViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((GameMapNpcWindow v) => v.OpenUguiWindow).To((GameMapNpcViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameMapNpcWindow v) => v.CloseWindow).To((GameMapNpcViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(npcName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMapNpcViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(npcDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMapNpcViewModel vm) => vm.Desc);
		bindingSet.Bind(this).For((GameMapNpcWindow v) => v.LoadSpine).To((GameMapNpcViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		mapNpcList.InitListView(viewModel.NpcDataList.Count, OnGetNpcItemByIndex);
		LoadSpine();
		LoadMap();
	}

	private async void LoadMap()
	{
		mapImgPath = AssetUtility.GetStoryImageSprite(viewModel.ImgPath + ".png");
		Image image = mapBg;
		image.sprite = await LoadSpriteAsync(mapImgPath, "Story");
	}

	private async void LoadSpine(object sender = null, InteractionEventArgs e = null)
	{
		if (spineObj != null)
		{
			UnityEngine.Object.Destroy(spineObj);
		}
		npcImgPath = AssetUtility.GetStorySpine($"{viewModel.CurNpc.ID}");
		GameObject gameObject = await InstantiateAsync(npcImgPath, spine, "Story");
		if (gameObject != null)
		{
			spineObj = gameObject;
			spineObj.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
		}
	}

	private LoopListViewItem2 OnGetNpcItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.NpcDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("NpcItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.NpcDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.NpcDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (spineObj != null)
		{
			UnityEngine.Object.Destroy(spineObj);
		}
		Dismiss();
	}
}
