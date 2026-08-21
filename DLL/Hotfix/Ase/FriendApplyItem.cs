using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendApplyItem : LoopListViewItem2
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
	private Text verifyMsgText;

	[SerializeField]
	private Button acceptBtn;

	[SerializeField]
	private Button refuseBtn;

	[SerializeField]
	private Button lookInfoBtn;

	private PlayerData _playerData;

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

	public void Init(PlayerData data)
	{
		_playerData = data;
		BindingSet<FriendApplyItem, PlayerData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PlayerData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).ToExpression((PlayerData vm) => $"HeadAdorn{vm.IconFrame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(this).For((FriendApplyItem v) => v.TitleId).To((PlayerData vm) => vm.Title);
		bindingSet.Bind(nameText).For((Text v) => v.text).To((PlayerData vm) => vm.Name);
		bindingSet.Bind(level).For((Text v) => v.text).To((PlayerData vm) => vm.Level);
		bindingSet.Bind(verifyMsgText).For((Text v) => v.text).ToExpression((PlayerData vm) => string.IsNullOrEmpty(vm.VerifyMessage) ? "无" : vm.VerifyMessage);
		bindingSet.Build();
		acceptBtn.onClick.AddListener(Accept);
		refuseBtn.onClick.AddListener(Refuse);
		lookInfoBtn.onClick.AddListener(LookInfo);
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

	public void Refresh(PlayerData data)
	{
		_playerData = data;
		this.SetDataContext(data);
	}

	private async void Accept()
	{
		if (_playerData != null)
		{
			Loading loading = await Loading.Show();
			await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().ReplyFriendRequest(_playerData.Uid, reply: true);
			loading.Dispose();
		}
	}

	private async void Refuse()
	{
		if (_playerData != null)
		{
			Loading loading = await Loading.Show();
			await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().ReplyFriendRequest(_playerData.Uid, reply: false);
			loading.Dispose();
		}
	}

	private void LookInfo()
	{
		if (_playerData != null)
		{
			FriendViewModel friendViewModel = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel();
			friendViewModel.OpenPlayerInfoRequest.Raise(new PlayerInfoViewModel(friendViewModel, _playerData, isSelf: false));
		}
	}
}
