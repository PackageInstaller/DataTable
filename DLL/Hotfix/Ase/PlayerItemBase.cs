using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerItemBase : UGuiView
{
	[SerializeField]
	protected Image headIcon;

	[SerializeField]
	protected Image headFrame;

	[SerializeField]
	protected Image title;

	[SerializeField]
	protected Text playerName;

	[SerializeField]
	protected TextMeshProUGUI level;

	[SerializeField]
	protected TextMeshProUGUI state;

	private PlayerItemBaseData _viewModel;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private int titleId;

	public int TitleId
	{
		get
		{
			return titleId;
		}
		set
		{
			if (titleId != value)
			{
				titleId = value;
				RefreshTitlePrefab().Forget();
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<PlayerItemBaseData>(userData);
		BindingSet<PlayerItemBase, PlayerItemBaseData> bindingSet = this.CreateBindingSet(_viewModel);
		if (headIcon != null)
		{
			bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((PlayerItemBaseData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (headFrame != null)
		{
			bindingSet.Bind(headFrame).For((Image v) => v.sprite).To((PlayerItemBaseData vm) => vm.HeadFrame)
				.WithConversion("ItemIcon");
		}
		if (title != null)
		{
			bindingSet.Bind(this).For((PlayerItemBase v) => v.TitleId).To((PlayerItemBaseData vm) => vm.TitleId);
		}
		if (playerName != null)
		{
			bindingSet.Bind(playerName).For((Text v) => v.text).To((PlayerItemBaseData vm) => vm.Name);
		}
		if ((UnityEngine.Object)(object)level != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerItemBaseData vm) => vm.Level);
		}
		if ((UnityEngine.Object)(object)state != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(state).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerItemBaseData vm) => vm.State);
		}
		bindingSet.Build();
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (title == null)
		{
			return;
		}
		title.sprite = null;
		Color color = title.color;
		title.color = new Color(color.r, color.g, color.b, 0f);
		if (titleId == 0)
		{
			return;
		}
		DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(titleId);
		if (dataRow == null || string.IsNullOrEmpty(dataRow.Icon))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(dataRow.Icon), title.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
			titlePrefabGo.transform.localScale = Vector3.one;
			titlePrefabGo.transform.localRotation = Quaternion.identity;
		}
	}

	private void ClearTitlePrefab()
	{
		if (titlePrefabGo != null)
		{
			UnityEngine.Object.Destroy(titlePrefabGo);
			titlePrefabGo = null;
		}
	}

	protected override void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
		base.OnDestroy();
	}
}
