using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ProfileImgItem : LoopGridViewItem
{
	[SerializeField]
	private Image profileImg;

	[SerializeField]
	private Image profileBoderImg;

	[SerializeField]
	private GameObject outLine;

	[SerializeField]
	private GameObject mask;

	[SerializeField]
	private Button button;

	private ProfileImgData viewModel;

	public void Init(ProfileImgData data, UserInfoViewModel data2)
	{
		viewModel = data;
		BindingSet<ProfileImgItem, ProfileImgData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(profileImg).For((Image v) => v.sprite).To((ProfileImgData vm) => vm.ProfileImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind(profileBoderImg).For((Image v) => v.sprite).To((ProfileImgData vm) => vm.ProfileBoder)
			.WithConversion("ItemIcon");
		bindingSet.Bind(mask).For((GameObject v) => v.activeSelf).To((ProfileImgData vm) => vm.IsOwned);
		bindingSet.Bind(outLine).For((GameObject v) => v.activeSelf).To((ProfileImgData vm) => vm.IsSelected);
		bindingSet.Build();
		button.onClick.AddListener(delegate
		{
			if (data2.ChangeType == 0)
			{
				data2.PreviewImg = data.ProfileImg;
			}
			else if (data2.ChangeType == 1)
			{
				data2.PreviewBorder = data.ProfileBoder;
			}
			data2.PreviewName = data.ItemName;
			data2.PreviewDesc = data.ItemDesc;
			data2.IsOwned = data.IsOwned;
			foreach (ProfileImgData profileImg in data2.ProfileImgList)
			{
				profileImg.IsSelected = false;
			}
			foreach (ProfileImgData profileBoder in data2.ProfileBoderList)
			{
				profileBoder.IsSelected = false;
			}
			data.IsSelected = true;
		});
	}
}
