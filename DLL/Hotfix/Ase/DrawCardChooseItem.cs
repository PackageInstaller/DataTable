using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardChooseItem : UGuiView
{
	[SerializeField]
	private Transform headPos;

	[SerializeField]
	private Button chooseBtn;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private Image mask;

	[SerializeField]
	private Image light;

	[SerializeField]
	private GameObject drakObj;

	[SerializeField]
	private List<Sprite> frameList;

	[SerializeField]
	private List<Sprite> frameMaskList;

	[SerializeField]
	private List<Sprite> lightList;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Image typeImg;

	[SerializeField]
	private TextMeshProUGUI typeName;

	[SerializeField]
	private TextMeshProUGUI itemNameText;

	[SerializeField]
	private LoopListView2 tagItemList;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private float originX;

	[SerializeField]
	private Vector2 amplifySize;

	[SerializeField]
	private Vector2 originSize;

	[SerializeField]
	private Vector2 maskAmplifySize;

	[SerializeField]
	private Vector2 originMaskAmplifySize;

	[SerializeField]
	private float leftX1;

	[SerializeField]
	private float leftX2;

	[SerializeField]
	private float rightX1;

	[SerializeField]
	private float rightX2;

	[SerializeField]
	private float moveTime = 2f;

	[SerializeField]
	private float scaleTime = 1f;

	[SerializeField]
	private GameObject maskObj;

	private DrawCardChooseItemViewModel viewModel;

	private GameObject createObj;

	public void Init(DrawCardChooseItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DrawCardChooseItem, DrawCardChooseItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(chooseBtn).For((Button v) => v.onClick).To((DrawCardChooseItemViewModel vm) => vm.Select);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((DrawCardChooseItemViewModel vm) => vm.Confirm);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((DrawCardChooseItemViewModel vm) => vm.IsSelected);
		bindingSet.Bind<TextMeshProUGUI>(itemNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardChooseItemViewModel vm) => vm.ItemName);
		bindingSet.Bind(typeImg).For((Image v) => v.sprite).ToExpression((DrawCardChooseItemViewModel vm) => vm.TypeImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(typeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardChooseItemViewModel vm) => vm.TypeName);
		bindingSet.Bind(drakObj).For((GameObject v) => v.activeSelf).ToExpression((DrawCardChooseItemViewModel vm) => vm.ShowDark);
		bindingSet.Bind().For((DrawCardChooseItem v) => v.RefreshSize).To((DrawCardChooseItemViewModel vm) => vm.RefreshSizeRequest);
		bindingSet.Build();
		LoadFrame();
		LoadObj();
		tagItemList.InitListView(viewModel.DrawCardTagItemDataList.Count, OnGetTagItemByIndex);
	}

	private void LoadFrame()
	{
		frame.sprite = frameList[viewModel.Index];
		mask.sprite = frameMaskList[viewModel.Index];
		if (light != null)
		{
			light.sprite = lightList[viewModel.Index];
		}
	}

	private async void LoadObj()
	{
		createObj = await InstantiateAsync(AssetUtility.GetUIItemAsset(viewModel.ObjPath), headPos);
		if (!(createObj == null))
		{
			Transform transform = createObj.transform.Find("HeadPos");
			if (transform != null)
			{
				float x = transform.GetComponent<RectTransform>().anchoredPosition.x;
				float y = transform.GetComponent<RectTransform>().anchoredPosition.y;
				createObj.GetComponent<Transform>().SetLocalPositionX(0f - x);
				createObj.GetComponent<Transform>().SetLocalPositionY(0f - y);
			}
			StreamerMode.ApplySpineSkin(createObj);
			UIStarGroup componentInChildren = createObj.GetComponentInChildren<UIStarGroup>();
			if (componentInChildren != null)
			{
				componentInChildren.CurCount = 1;
			}
		}
	}

	private void RefreshSize(object sender, InteractionEventArgs e)
	{
		string moveAction = viewModel.MoveAction;
		if (moveAction.Equals("Amplify"))
		{
			AmplifySize();
		}
		else if (moveAction.Equals("Left1"))
		{
			Move(leftX1);
		}
		else if (moveAction.Equals("Left2"))
		{
			Move(leftX2);
		}
		else if (moveAction.Equals("Right1"))
		{
			Move(rightX1);
		}
		else if (moveAction.Equals("Right2"))
		{
			Move(rightX2);
		}
	}

	private void AmplifySize()
	{
		DOTween.Sequence().Append(base.transform.GetComponent<RectTransform>().DOScale(amplifySize, scaleTime));
		DOTween.Sequence().Append(mask.GetComponent<RectTransform>().DOScale(maskAmplifySize, scaleTime));
		DOTween.Sequence().Append(base.transform.GetComponent<RectTransform>().DOLocalMoveX(originX, moveTime));
		Animation component = base.gameObject.GetComponent<Animation>();
		if (component != null)
		{
			component.Play();
		}
	}

	private void Move(float x)
	{
		Animation component = base.gameObject.GetComponent<Animation>();
		if (component != null)
		{
			component.Stop();
		}
		DOTween.Sequence().Append(base.transform.GetComponent<RectTransform>().DOScale(originMaskAmplifySize, scaleTime));
		DOTween.Sequence().Append(mask.GetComponent<RectTransform>().DOScale(originMaskAmplifySize, scaleTime));
		DOTween.Sequence().Append(base.transform.GetComponent<RectTransform>().DOLocalMoveX(x, moveTime));
	}

	private LoopListViewItem2 OnGetTagItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DrawCardTagItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TagItem");
		if (loopListViewItem != null)
		{
			DrawCardTagItem component = loopListViewItem.GetComponent<DrawCardTagItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DrawCardTagItemDataList[index]);
			}
			else
			{
				component.RefreshTag(viewModel.DrawCardTagItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		if (createObj != null)
		{
			UnityEngine.Object.Destroy(createObj);
		}
		base.OnDestroy();
	}
}
