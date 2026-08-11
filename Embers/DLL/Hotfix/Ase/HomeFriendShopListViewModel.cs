using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HomeFriendShopListViewModel : OptionBase
{
	private long curShopId;

	private bool noFriend;

	private string limitBuyText;

	private List<HomeShopInfoData> shopDatas = new List<HomeShopInfoData>();

	private InteractionRequest refreshRst = new InteractionRequest();

	public string LimitBuyText
	{
		get
		{
			return limitBuyText;
		}
		set
		{
			Set(ref limitBuyText, value, "LimitBuyText");
		}
	}

	public long CurShopId => curShopId;

	public bool NoFriend
	{
		get
		{
			return noFriend;
		}
		set
		{
			Set(ref noFriend, value, "NoFriend");
		}
	}

	public List<HomeShopInfoData> ShopDatas => shopDatas;

	public InteractionRequest RefreshRst => refreshRst;

	public HomeFriendShopListViewModel()
	{
	}

	public HomeFriendShopListViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void Refresh(long shopId, List<HomeShopInfoData> shopDatas)
	{
		curShopId = shopId;
		this.shopDatas = shopDatas;
		NoFriend = shopDatas == null || shopDatas.Count <= 0;
		IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
		int todayBoughtCountInShop = service.GetTodayBoughtCountInShop();
		int todayBuyLimitInShop = service.GetTodayBuyLimitInShop();
		LimitBuyText = $"剩余购买次数：{todayBuyLimitInShop - todayBoughtCountInShop}/{todayBuyLimitInShop}";
		refreshRst.Raise();
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HomeShopListItemData obj2)
		{
			parent?.ItemOnClick(obj2);
			base.IsVisible = false;
		}
		else if (obj is KnapsackItemViewModel obj3)
		{
			parent?.ItemOnClick(obj3);
		}
	}
}
