using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeamAttributeView : UGuiView
{
	public class AttributeView : UIView
	{
		private Image icon;

		private GameObject iconActive;

		private List<GameObject> effectList;

		private TeamAttributeViewModel.AttributeData _viewModel;

		public void Init(TeamAttributeViewModel.AttributeData data)
		{
			icon = GetComponent<Image>();
			iconActive = base.transform.Find("Effect").gameObject;
			_viewModel = data;
			BindingSet<AttributeView, TeamAttributeViewModel.AttributeData> bindingSet = this.CreateBindingSet(_viewModel);
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((TeamAttributeViewModel.AttributeData vm) => vm.IconPath)
				.WithConversion("ItemIcon");
			bindingSet.Bind(icon).For((Image v) => v.color).To((TeamAttributeViewModel.AttributeData vm) => vm.Color);
			bindingSet.Bind(iconActive).For((GameObject v) => v.activeSelf).To((TeamAttributeViewModel.AttributeData vm) => vm.AttributeActive);
			bindingSet.Bind(this).For((AttributeView v) => v.ResetEnumEffect).To((TeamAttributeViewModel.AttributeData vm) => vm.RefreshEffectRequest);
			bindingSet.Build();
			AddEffectList();
			ResetEnumEffect();
		}

		private void AddEffectList()
		{
			effectList = new List<GameObject>();
			int length = Enum.GetValues(typeof(HeroAttributeEnum)).Length;
			for (int i = 0; i < length; i++)
			{
				try
				{
					Transform child = iconActive.transform.GetChild(i);
					if (child == null)
					{
						break;
					}
					effectList.Add(child.gameObject);
				}
				catch (Exception)
				{
					break;
				}
			}
		}

		private void ResetEnumEffect(object sende = null, InteractionEventArgs e = null)
		{
			foreach (GameObject effect in effectList)
			{
				effect.gameObject.SetActive(value: false);
			}
			if (_viewModel.EnumIndex <= effectList.Count - 1)
			{
				effectList[_viewModel.EnumIndex].gameObject.SetActive(value: true);
			}
		}
	}

	[SerializeField]
	private Image iconTpl;

	[SerializeField]
	private Transform iconRoot;

	[SerializeField]
	private Button btnOpenDetail;

	private List<AttributeView> attrList = new List<AttributeView>();

	private TeamAttributeViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<TeamAttributeViewModel>(userData);
		BindingSet<TeamAttributeView, TeamAttributeViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(btnOpenDetail).For((Button v) => v.onClick).To((TeamAttributeViewModel vm) => vm.OpenDetailCmd);
		bindingSet.Build();
		for (int num = 0; num < 3; num++)
		{
			Image image = UnityEngine.Object.Instantiate(iconTpl, iconRoot);
			AttributeView attributeView = image.gameObject.AddComponent<AttributeView>();
			attributeView.Init(_viewModel.AttributeDatas[num]);
			image.gameObject.SetActive(value: true);
			attrList.Add(attributeView);
		}
	}

	public void Dispose()
	{
		if (attrList != null)
		{
			for (int num = attrList.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.DestroyImmediate(attrList[num]);
				attrList[num] = null;
			}
			attrList = null;
		}
	}
}
