using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendBlackListItem : LoopListViewItem2
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image headFrame;

	[SerializeField]
	private Image titleTag;

	[SerializeField]
	private Text nameText;

	[SerializeField]
	private Text level;

	[SerializeField]
	private Button lookInfoBtn;

	[SerializeField]
	private Button removeBtn;

	private FriendBlackListItemData viewModel;

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

	public void Init(FriendBlackListItemData data)
	{
		viewModel = data;
		BindingSet<FriendBlackListItem, FriendBlackListItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((FriendBlackListItemData vm) => vm.PlayerData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).ToExpression((FriendBlackListItemData vm) => $"HeadAdorn{vm.PlayerData.IconFrame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((FriendBlackListItem v) => v.TitleId).To((FriendBlackListItemData vm) => vm.PlayerData.Title);
		bindingSet.Bind(nameText).For((Text v) => v.text).ToExpression((FriendBlackListItemData vm) => vm.PlayerData.Name);
		bindingSet.Bind(level).For((Text v) => v.text).ToExpression((FriendBlackListItemData vm) => vm.PlayerData.Level.ToString());
		bindingSet.Bind(lookInfoBtn).For((Button v) => v.onClick).To((FriendBlackListItemData vm) => vm.OnLookInfoBtnClick);
		bindingSet.Bind(removeBtn).For((Button v) => v.onClick).To((FriendBlackListItemData vm) => vm.RemoveFromBlackList);
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
				Object.Destroy(gameObject);
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
			Object.Destroy(titlePrefabGo);
			titlePrefabGo = null;
		}
	}

	private void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}

	public void RefreshData(FriendBlackListItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
