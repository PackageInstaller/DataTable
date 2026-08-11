using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyRankItemView : UGuiView
{
	public bool empty;

	public TextMeshProUGUI score;

	public Text playerName;

	public Image icon;

	public Image iconFrame;

	public Image iconTitle;

	public GameObject c1;

	public GameObject c2;

	public GameObject c3;

	private CopyRankItemViewModel viewModel;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private string titlePrefabPath;

	public string TitlePrefabPath
	{
		get
		{
			return titlePrefabPath;
		}
		set
		{
			titlePrefabPath = value;
			RefreshTitlePrefab().Forget();
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyRankItemViewModel>(userData);
		RefreshBadgeState();
		BindingSet<CopyRankItemView, CopyRankItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(c1).For((GameObject v) => v.activeSelf).ToExpression((CopyRankItemViewModel vm) => vm.Index == 1);
		bindingSet.Bind(c2).For((GameObject v) => v.activeSelf).ToExpression((CopyRankItemViewModel vm) => vm.Index == 2);
		bindingSet.Bind(c3).For((GameObject v) => v.activeSelf).ToExpression((CopyRankItemViewModel vm) => vm.Index == 3);
		if (!empty)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((CopyRankItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(iconFrame).For((Image v) => v.sprite).ToExpression((CopyRankItemViewModel vm) => $"HeadAdorn{vm.IconFrame}")
				.WithConversion("ItemIcon");
			bindingSet.Bind(this).For((CopyRankItemView v) => v.TitlePrefabPath).To((CopyRankItemViewModel vm) => vm.TitlePrefabPath);
			bindingSet.Bind<TextMeshProUGUI>(score).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyRankItemViewModel vm) => vm.Score);
			bindingSet.Bind(playerName).For((Text v) => v.text).To((CopyRankItemViewModel vm) => vm.PlayerName);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyRankItemViewModel>(userData);
		this.SetDataContext(viewModel);
		RefreshBadgeState();
	}

	private void RefreshBadgeState()
	{
		int num = viewModel?.Index ?? 0;
		if (c1 != null)
		{
			c1.SetActive(num == 1);
		}
		if (c2 != null)
		{
			c2.SetActive(num == 2);
		}
		if (c3 != null)
		{
			c3.SetActive(num == 3);
		}
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (iconTitle == null)
		{
			return;
		}
		iconTitle.sprite = null;
		Color color = iconTitle.color;
		iconTitle.color = new Color(color.r, color.g, color.b, 0f);
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(TitlePrefabPath), iconTitle.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
			titlePrefabGo.transform.localScale = Vector3.one;
			titlePrefabGo.transform.localPosition = Vector3.zero;
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

	private new void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}
}
