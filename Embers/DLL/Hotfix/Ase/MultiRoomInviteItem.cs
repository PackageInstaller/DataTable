using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomInviteItem : UGuiView
{
	[SerializeField]
	private Image gamerImg;

	[SerializeField]
	private Image gamerFrame;

	[SerializeField]
	private Image gamerTitle;

	[SerializeField]
	private TextMeshProUGUI gamerLv;

	[SerializeField]
	private Text gameName;

	[SerializeField]
	private TextMeshProUGUI state;

	[SerializeField]
	private Image stateColor;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button btn;

	private MultiRoomInviteItemData _viewModel;

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

	public void Init(MultiRoomInviteItemData data)
	{
		_viewModel = data;
		BindingSet<MultiRoomInviteItem, MultiRoomInviteItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(gameName).For((Text v) => v.text).To((MultiRoomInviteItemData vm) => vm.GamerName);
		bindingSet.Bind(gamerImg).For((Image v) => v.sprite).ToExpression((MultiRoomInviteItemData vm) => $"{vm.GamerImgId}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(gamerFrame).For((Image v) => v.sprite).ToExpression((MultiRoomInviteItemData vm) => $"HeadAdorn{vm.GamerFrameId}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((MultiRoomInviteItem v) => v.TitleId).To((MultiRoomInviteItemData vm) => vm.GamerTitleId);
		bindingSet.Bind<TextMeshProUGUI>(gamerLv).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomInviteItemData vm) => vm.GamerLv);
		bindingSet.Bind<TextMeshProUGUI>(state).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomInviteItemData vm) => vm.State);
		bindingSet.Bind(stateColor).For((Image v) => v.color).To((MultiRoomInviteItemData vm) => vm.StateColor);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((MultiRoomInviteItemData vm) => vm.IsSelected);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((MultiRoomInviteItemData vm) => vm.OnClick);
		bindingSet.Build();
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (gamerTitle == null)
		{
			return;
		}
		gamerTitle.sprite = null;
		Color color = gamerTitle.color;
		gamerTitle.color = new Color(color.r, color.g, color.b, 0f);
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
		gamerTitle.gameObject.SetActive(value: true);
		if (text == "")
		{
			return;
		}
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(text), gamerTitle.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
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

	public void RefreshData(MultiRoomInviteItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
