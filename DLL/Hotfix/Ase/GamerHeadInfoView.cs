using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GamerHeadInfoView : MonoBehaviour
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private Text roleName;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private Image title;

	[SerializeField]
	private Button addFriend;

	[SerializeField]
	private GameObject addFriendObj;

	private GamerHeadInfoViewModel _viewModel;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private int titleId = -1;

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

	public void Init(GamerHeadInfoViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<GamerHeadInfoView, GamerHeadInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((GamerHeadInfoViewModel vm) => $"{vm.Icon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(frame).For((Image v) => v.sprite).ToExpression((GamerHeadInfoViewModel vm) => $"HeadAdorn{vm.Frame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((GamerHeadInfoView v) => v.TitleId).To((GamerHeadInfoViewModel vm) => vm.Title);
		bindingSet.Bind(roleName).For((Text v) => v.text).To((GamerHeadInfoViewModel vm) => vm.RoleName);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GamerHeadInfoViewModel vm) => vm.Level);
		bindingSet.Bind(addFriendObj).For((GameObject v) => v.activeSelf).ToExpression((GamerHeadInfoViewModel vm) => !vm.IsFriend);
		bindingSet.Bind(addFriend).For((Button v) => v.onClick).To((GamerHeadInfoViewModel vm) => vm.AddFriendCmd);
		bindingSet.Build();
	}

	public void Refresh(GamerHeadInfoViewModel viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
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
		string text;
		if (titleId == 0)
		{
			text = "Title/UserTitle0";
		}
		else
		{
			DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(titleId);
			if (dataRow == null || string.IsNullOrEmpty(dataRow.Icon))
			{
				return;
			}
			text = dataRow.Icon;
		}
		title.gameObject.SetActive(value: true);
		if (text == "")
		{
			return;
		}
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(text), title.transform);
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

	private void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}
}
