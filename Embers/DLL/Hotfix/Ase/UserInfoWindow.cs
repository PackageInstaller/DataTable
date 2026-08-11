using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UserInfoWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI uid;

	[SerializeField]
	private TextMeshProUGUI expText;

	[SerializeField]
	private Image expFill;

	[SerializeField]
	private Image userProfileImg;

	[SerializeField]
	private Image userBorderImg;

	[SerializeField]
	private Text userName;

	[SerializeField]
	private Button btnChangeNamePanel;

	[SerializeField]
	private Button btnOpenChangePanel;

	[SerializeField]
	private Text userLevel;

	[SerializeField]
	private Text userGuild;

	[SerializeField]
	private Text userDescInput;

	[SerializeField]
	private Text normalLevelAchieved;

	[SerializeField]
	private Text difficultLevelAchieved;

	[SerializeField]
	private Text bestLevel;

	[SerializeField]
	private Text createDate;

	[SerializeField]
	private Text bestRank;

	[SerializeField]
	private Text curRank;

	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private GameObject changePanel;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private Image previewImg;

	[SerializeField]
	private Image previewBoder;

	[SerializeField]
	private TextMeshProUGUI previewName;

	[SerializeField]
	private Text previewDesc;

	[SerializeField]
	private Button btnChangeImg;

	[SerializeField]
	private Button btnOpenChangeBorder;

	[SerializeField]
	private Button btnOpenChangeImg;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private LoopGridView profileImgList;

	[SerializeField]
	private LoopGridView profileBorderlist;

	[SerializeField]
	private GameObject ChangeNamePanel;

	[SerializeField]
	private Text ChangeNameInput;

	[SerializeField]
	private Button BtnChangeName;

	[SerializeField]
	private GameObject ErrorText;

	[SerializeField]
	private Button btnBack3;

	private UserInfoViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<UserInfoViewModel>();
		BindingSet<UserInfoWindow, UserInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(uid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UserInfoViewModel vm) => vm.UserUid);
		bindingSet.Bind<TextMeshProUGUI>(expText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UserInfoViewModel vm) => vm.UserExp);
		bindingSet.Bind(expFill).For((Image v) => v.fillAmount).To((UserInfoViewModel vm) => vm.UserExpFillAmount);
		bindingSet.Bind(userProfileImg).For((Image v) => v.sprite).To((UserInfoViewModel vm) => vm.Avatar)
			.WithConversion("ItemIcon");
		bindingSet.Bind(userBorderImg).For((Image v) => v.sprite).To((UserInfoViewModel vm) => vm.Border)
			.WithConversion("ItemIcon");
		bindingSet.Bind(userName).For((Text v) => v.text).To((UserInfoViewModel vm) => vm.UserName);
		bindingSet.Bind(userLevel).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.CurLevel.ToString());
		bindingSet.Bind(userGuild).For((Text v) => v.text).To((UserInfoViewModel vm) => vm.GuildName);
		bindingSet.Bind(userDescInput).For((Text v) => v.text).To((UserInfoViewModel vm) => vm.UserDesc);
		bindingSet.Bind(normalLevelAchieved).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.NormalLevelAchieved.ToString());
		bindingSet.Bind(difficultLevelAchieved).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.DifficltLevelAchieved.ToString());
		bindingSet.Bind(bestLevel).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.BestLevel.ToString());
		bindingSet.Bind(createDate).For((Text v) => v.text).To((UserInfoViewModel vm) => vm.CreateDate);
		bindingSet.Bind(bestRank).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.BestRank.ToString());
		bindingSet.Bind(curRank).For((Text v) => v.text).ToExpression((UserInfoViewModel vm) => vm.CurRank.ToString());
		bindingSet.Bind(previewImg).For((Image v) => v.sprite).To((UserInfoViewModel vm) => vm.PreviewImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind(previewBoder).For((Image v) => v.sprite).To((UserInfoViewModel vm) => vm.PreviewBorder)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(previewName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UserInfoViewModel vm) => vm.PreviewName);
		bindingSet.Bind(previewDesc).For((Text v) => v.text).To((UserInfoViewModel vm) => vm.PreviewDesc);
		bindingSet.Build();
		btnOpenChangePanel.onClick.AddListener(OpenChangePanel);
		btnBack1.onClick.AddListener(delegate
		{
			Dismiss();
		});
		btnBack2.onClick.AddListener(HideChangePanel);
		btnBack3.onClick.AddListener(HideChangeNamePanel);
		btnChangeNamePanel.onClick.AddListener(OpenChangeNamePanel);
		btnOpenChangeBorder.onClick.AddListener(ChangeToProfileBorder);
		btnOpenChangeImg.onClick.AddListener(ChangeToProfileImg);
		btnChangeImg.onClick.AddListener(ChangeToPreview);
		BtnChangeName.onClick.AddListener(changeName);
		profileImgList.InitGridView(viewModel.ProfileImgList.Count, OnGetProfileImgItemByIndex);
		profileBorderlist.InitGridView(viewModel.ProfileBoderList.Count, OnGetProfileBorderByIndex);
	}

	public void OpenChangePanel()
	{
		changePanel.SetActive(value: true);
	}

	public void HideChangePanel()
	{
		changePanel.SetActive(value: false);
	}

	public void ChangeToPreview()
	{
		if (!viewModel.IsOwned)
		{
			if (viewModel.ChangeType == 0)
			{
				userProfileImg.sprite = previewImg.sprite;
			}
			else if (viewModel.ChangeType == 1)
			{
				userBorderImg.sprite = previewBoder.sprite;
			}
		}
	}

	public void ChangeToProfileImg()
	{
		((TMP_Text)title).text = "头像";
		viewModel.ChangeType = 0;
		profileBorderlist.gameObject.SetActive(value: false);
		profileImgList.gameObject.SetActive(value: true);
	}

	public void ChangeToProfileBorder()
	{
		((TMP_Text)title).text = "头像框";
		viewModel.ChangeType = 1;
		profileImgList.gameObject.SetActive(value: false);
		profileBorderlist.gameObject.SetActive(value: true);
	}

	public void OpenChangeNamePanel()
	{
		ChangeNamePanel.SetActive(value: true);
	}

	public void HideChangeNamePanel()
	{
		ChangeNamePanel.SetActive(value: false);
	}

	public void changeName()
	{
		userName.text = ChangeNameInput.text;
	}

	private LoopGridViewItem OnGetProfileImgItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		if (viewModel.ProfileImgList[index] == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = profileImgList.NewListViewItem("ProfileImgItem");
		ProfileImgItem component = loopGridViewItem.GetComponent<ProfileImgItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
		}
		component.Init(viewModel.ProfileImgList[index], viewModel);
		return loopGridViewItem;
	}

	private LoopGridViewItem OnGetProfileBorderByIndex(LoopGridView arg1, int index, int row, int column)
	{
		if (viewModel.ProfileBoderList[index] == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = profileBorderlist.NewListViewItem("ProfileImgItem");
		ProfileImgItem component = loopGridViewItem.GetComponent<ProfileImgItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
		}
		component.Init(viewModel.ProfileBoderList[index], viewModel);
		return loopGridViewItem;
	}
}
