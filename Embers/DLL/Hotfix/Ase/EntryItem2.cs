using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryItem2 : UGuiView
{
	[SerializeField]
	private Button button;

	[SerializeField]
	private GameObject selfObj;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private TextMeshProUGUI emptyText;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryLevel;

	[SerializeField]
	private TextMeshProUGUI entryDetail;

	[SerializeField]
	private GameObject isSelected;

	[SerializeField]
	private Button button2;

	[SerializeField]
	private Animation animation;

	[SerializeField]
	private UIParticlePlayer uiParticlePlayer;

	private EntryItemData2 viewModel;

	private Action<EntryItem2> action;

	public EntryItemData2 ViewModel => viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<EntryItemData2>(userData);
		BindingSet<EntryItem2, EntryItemData2> bindingSet = this.CreateBindingSet(viewModel);
		if (emptyObj != null)
		{
			bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((EntryItemData2 vm) => vm.IsEmpty);
		}
		if (selfObj != null)
		{
			bindingSet.Bind(selfObj).For((GameObject v) => v.activeSelf).ToExpression((EntryItemData2 vm) => !vm.IsEmpty);
		}
		if (button != null)
		{
			button.onClick.AddListener(delegate
			{
				action?.Invoke(this);
			});
			bindingSet.Bind(button).For((Button v) => v.onClick).To((EntryItemData2 vm) => vm.OpenPanelRequest);
			bindingSet.Bind(this).For((EntryItem2 v) => v.OnShowPanel).To((EntryItemData2 vm) => vm.OpenEntryPanelRequest);
		}
		if (button2 != null)
		{
			bindingSet.Bind(button2).For((Button v) => v.onClick).To((EntryItemData2 vm) => vm.OnClickExBtn);
			bindingSet.Bind(button2).For((Button v) => v.interactable).ToExpression((EntryItemData2 vm) => !vm.IsEmpty);
		}
		if (isSelected != null)
		{
			bindingSet.Bind(isSelected).For((GameObject v) => v.activeSelf).To((EntryItemData2 vm) => vm.IsSelected);
		}
		if (entryIcon != null)
		{
			bindingSet.Bind(entryIcon).For((Image v) => v.sprite).ToExpression((EntryItemData2 vm) => vm.EntryIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)entryName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData2 vm) => vm.EntryName);
		}
		if ((UnityEngine.Object)(object)entryLevel != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData2 vm) => vm.EntryLevel);
		}
		if ((UnityEngine.Object)(object)entryDetail != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryDetail).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData2 vm) => vm.EntryDetail);
		}
		if ((UnityEngine.Object)(object)emptyText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(emptyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryItemData2 vm) => vm.EmptyText);
		}
		bindingSet.Bind(this).For((EntryItem2 v) => v.PlayAnimation).To((EntryItemData2 vm) => vm.PlayAnimationRequest);
		bindingSet.Bind(this).For((EntryItem2 v) => v.PlayUIParticle).To((EntryItemData2 vm) => vm.PlayUIParticleRequest);
		bindingSet.Bind(this).For((EntryItem2 v) => v.HideUIParticle).To((EntryItemData2 vm) => vm.HideUIParticleRequest);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<EntryItemData2>(userData);
		this.SetDataContext(userData);
	}

	public void RefreshEntryItemData(EntryItemData2 data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}

	public void SetOnClickAction(Action<EntryItem2> action)
	{
		this.action = action;
	}

	public void OnShowPanel(object sender, InteractionEventArgs e)
	{
		viewModel.OnShowEntryPanel(this);
	}

	public void PlayAnimation(object sender, InteractionEventArgs e)
	{
		if (!((UnityEngine.Object)(object)animation == null))
		{
			animation.Stop();
			animation.Play();
		}
	}

	public void PlayUIParticle(object sender, InteractionEventArgs e)
	{
		if (uiParticlePlayer != null)
		{
			uiParticlePlayer.Play();
		}
	}

	public void HideUIParticle(object sender, InteractionEventArgs e)
	{
		if (uiParticlePlayer != null)
		{
			uiParticlePlayer.Hide();
		}
	}
}
