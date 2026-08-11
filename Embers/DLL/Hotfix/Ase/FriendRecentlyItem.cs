using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendRecentlyItem : LoopListViewItem2
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image headFrame;

	[SerializeField]
	private Image titleTag;

	[SerializeField]
	private GameObject friendTag;

	[SerializeField]
	private Text nameText;

	[SerializeField]
	private Text level;

	[SerializeField]
	private Button addBlacklistBtn;

	[SerializeField]
	private Button funcBtn;

	[SerializeField]
	private TextMeshProUGUI funcBtnText;

	[SerializeField]
	private Button lookInfoBtn;

	private FriendRecentlyItemData viewModel;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private int titleId = -1;

	private Action<long> onChatBtnClick;

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

	public void Init(FriendRecentlyItemData data)
	{
		viewModel = data;
		BindingSet<FriendRecentlyItem, FriendRecentlyItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((FriendRecentlyItemData vm) => vm.PlayerData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).ToExpression((FriendRecentlyItemData vm) => $"HeadAdorn{vm.PlayerData.IconFrame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((FriendRecentlyItem v) => v.TitleId).To((FriendRecentlyItemData vm) => vm.PlayerData.Title);
		bindingSet.Bind(nameText).For((Text v) => v.text).ToExpression((FriendRecentlyItemData vm) => vm.PlayerData.Name);
		bindingSet.Bind(level).For((Text v) => v.text).ToExpression((FriendRecentlyItemData vm) => vm.PlayerData.Level.ToString());
		bindingSet.Bind(friendTag.gameObject).For((GameObject v) => v.activeSelf).To((FriendRecentlyItemData vm) => vm.IsFriend);
		bindingSet.Bind(addBlacklistBtn).For((Button v) => v.onClick).To((FriendRecentlyItemData vm) => vm.AddBlackListCmd);
		bindingSet.Bind(funcBtn).For((Button v) => v.onClick).To((FriendRecentlyItemData vm) => vm.OnFuncBtnClickCmd);
		bindingSet.Bind<TextMeshProUGUI>(funcBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((FriendRecentlyItemData vm) => vm.FuncText);
		bindingSet.Bind(lookInfoBtn).For((Button v) => v.onClick).To((FriendRecentlyItemData vm) => vm.OnLookInfoBtnClick);
		bindingSet.Bind().For((FriendRecentlyItem v) => v.OnChatRequest).To((FriendRecentlyItemData vm) => vm.ChatRst);
		bindingSet.Build();
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (titleTag == null)
		{
			return;
		}
		titleTag.sprite = null;
		Color color = titleTag.color;
		titleTag.color = new Color(color.r, color.g, color.b, 0f);
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
		titleTag.gameObject.SetActive(value: true);
		if (text == "")
		{
			return;
		}
		GameObject gameObject = await GameEntry.Resource.InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(text), titleTag.transform);
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

	private void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}

	public void RefreshData(FriendRecentlyItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}

	public void SetChatFunction(Action<long> action)
	{
		onChatBtnClick = action;
	}

	private void OnChatRequest(object sender, InteractionEventArgs e)
	{
		onChatBtnClick?.Invoke(viewModel.PlayerData.Uid);
	}
}
