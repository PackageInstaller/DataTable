using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardItem : UGuiView
{
	[SerializeField]
	private Transform headPos;

	[SerializeField]
	private GameObject newIcon;

	[SerializeField]
	private Image convertImg;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private List<GameObject> bgList;

	private GameObject createObj;

	private DrawCardItemViewModel viewModel;

	public void Init(DrawCardItemViewModel drawCardItemViewModel)
	{
		viewModel = drawCardItemViewModel;
		BindingSet<DrawCardItem, DrawCardItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(newIcon).For((GameObject v) => v.activeSelf).To((DrawCardItemViewModel vm) => vm.IsNew);
		bindingSet.Bind(convertImg).For((Image v) => v.sprite).ToExpression((DrawCardItemViewModel vm) => vm.ConvertImgPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((DrawCardItem v) => v.LoadObj).To((DrawCardItemViewModel vm) => vm.ReLoadObjRequest);
		bindingSet.Build();
		LoadObj();
		bgList[viewModel.Index].SetActive(value: true);
	}

	private async void LoadObj(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel.DrawCardItemInfo.PrefabPath == null || viewModel.DrawCardItemInfo.PrefabPath.Equals(""))
		{
			return;
		}
		string uIItemAsset = AssetUtility.GetUIItemAsset(viewModel.DrawCardItemInfo.PrefabPath);
		createObj = await InstantiateAsync(uIItemAsset, headPos);
		if (!(createObj == null))
		{
			string n = ((viewModel.DrawCardItemInfo.Type == 5) ? "HeadPos" : "DrawCardHeadPos");
			Transform transform = createObj.transform.Find(n);
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

	public void PlayAnimation(string animationName)
	{
		if (animationName.Equals("Convert"))
		{
			if (viewModel.DrawCardItemInfo.ConvertImgPath != "empty" && !viewModel.DrawCardItemInfo.ConvertImgPath.Equals(""))
			{
				animator.SetTrigger(Animator.StringToHash(animationName));
			}
		}
		else if (animationName.Equals("Load"))
		{
			string text = (viewModel.IsNew ? "LoadNew" : "LoadOld");
			animator.SetTrigger(Animator.StringToHash(text));
		}
		else
		{
			animator.SetTrigger(Animator.StringToHash(animationName));
		}
	}

	public void PlayLightAnimation()
	{
		animator.SetTrigger(Animator.StringToHash("Light"));
	}

	public void PlayLoadAnimation()
	{
		string text = (viewModel.DrawCardItemInfo.IsNew ? "LoadNew" : "LoadOld");
		animator.SetTrigger(Animator.StringToHash(text));
	}

	public void LightEvent()
	{
		viewModel.AnimationEndEvent("Light");
	}

	public void LoadEvent()
	{
		viewModel.AnimationEndEvent("Load");
	}

	public void ConvertEvent()
	{
		viewModel.AnimationEndEvent("Convert");
	}

	protected override void OnDestroy()
	{
		if (createObj != null)
		{
			Object.Destroy(createObj);
		}
		base.OnDestroy();
	}
}
