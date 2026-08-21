using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerLoadingView : UGuiView
{
	public Transform headPos;

	private GameObject roleImgObj;

	[SerializeField]
	private Image cardFrame;

	public Text playerName;

	public TextMeshProUGUI progressText;

	public List<Color> progressColor;

	private PlayerLoadingViewModel viewModel;

	private string curSpinePath;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<PlayerLoadingViewModel>(userData);
		BindingSet<PlayerLoadingView, PlayerLoadingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(playerName).For((Text v) => v.text).ToExpression((PlayerLoadingViewModel vm) => vm.TeamMember.Name);
		bindingSet.Bind(playerName).For((Text v) => v.color).ToExpression((PlayerLoadingViewModel vm) => vm.TeamMember.IsSelf ? Color.white : playerName.color);
		bindingSet.Bind<TextMeshProUGUI>(progressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PlayerLoadingViewModel vm) => $"{vm.Progress}%");
		bindingSet.Bind<TextMeshProUGUI>(progressText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((PlayerLoadingViewModel vm) => (vm.Progress == 100) ? progressColor[0] : progressColor[1]);
		if (cardFrame != null)
		{
			bindingSet.Bind(cardFrame.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerLoadingViewModel vm) => !string.IsNullOrEmpty(vm.CardFrame));
			bindingSet.Bind(cardFrame).For((Image v) => v.sprite).To((PlayerLoadingViewModel vm) => vm.CardFrame)
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
		RefreshHeroFg(null, null);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<PlayerLoadingViewModel>(userData);
		this.SetDataContext(userData);
	}

	protected virtual async void RefreshHeroFg(object sender, InteractionEventArgs e)
	{
		if (roleImgObj != null)
		{
			UnityEngine.Object.Destroy(roleImgObj);
			roleImgObj = null;
		}
		curSpinePath = AssetUtility.GetUIItemAsset(viewModel.TeamMember.HeroModel.Original);
		GameObject gameObject = (roleImgObj = await InstantiateAsync(curSpinePath, headPos));
		UIUtilly.SpineMatchRectHelper(roleImgObj, headPos, overwrite: false);
		Transform transform = gameObject.transform.Find("HeadPos");
		if (transform != null && gameObject != null)
		{
			Vector2 anchoredPosition = transform.GetComponent<RectTransform>().anchoredPosition;
			gameObject.GetComponent<Transform>().SetLocalPositionX(0f - anchoredPosition.x);
			gameObject.GetComponent<Transform>().SetLocalPositionY(0f - anchoredPosition.y);
		}
		StreamerMode.ApplySpineSkin(gameObject);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (roleImgObj != null)
		{
			UnityEngine.Object.Destroy(roleImgObj);
			roleImgObj = null;
		}
	}
}
