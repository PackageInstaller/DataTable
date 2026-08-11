using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityScrollViewModel : OptionBase
{
	private List<DRBanner> bannerConfigs = new List<DRBanner>();

	private string image1 = "";

	private string image2 = "";

	private string image3 = "";

	private bool showMain = true;

	private InteractionRequest refreshRequest = new InteractionRequest();

	private ISubscription<BannerMessage> _subscription;

	public string Image1
	{
		get
		{
			return image1;
		}
		set
		{
			Set(ref image1, value, "Image1");
		}
	}

	public string Image2
	{
		get
		{
			return image2;
		}
		set
		{
			Set(ref image2, value, "Image2");
		}
	}

	public string Image3
	{
		get
		{
			return image3;
		}
		set
		{
			Set(ref image3, value, "Image3");
		}
	}

	public List<DRBanner> BannerConfigs => bannerConfigs;

	public bool ShowMain
	{
		get
		{
			return showMain;
		}
		set
		{
			Set(ref showMain, value, "ShowMain");
		}
	}

	public InteractionRequest RefreshRequest => refreshRequest;

	public ActivityScrollViewModel()
	{
	}

	public ActivityScrollViewModel(OptionBase parent)
	{
		base.parent = parent;
		_subscription = Singleton<ServiceSystem>.Instance.GetService<IBannerService>().GetMessager().Subscribe<BannerMessage>(OnMessage);
		RefreshBannerData(notifyUi: false);
	}

	private void OnMessage(BannerMessage msg)
	{
		RefreshBannerData();
	}

	public void RefreshBannerData(bool notifyUi = true)
	{
		bannerConfigs.Clear();
		DRBanner[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRBanner>();
		if (allDataRow != null)
		{
			DRBanner[] array = allDataRow;
			foreach (DRBanner dRBanner in array)
			{
				if (!string.IsNullOrEmpty(dRBanner.LittleImg) && BannerService.GetBannerOpenState(dRBanner))
				{
					bannerConfigs.Add(dRBanner);
				}
			}
		}
		bannerConfigs.Sort((DRBanner a, DRBanner b) => a.Sort.CompareTo(b.Sort));
		ShowMain = bannerConfigs.Count > 0;
		if (notifyUi)
		{
			refreshRequest.Raise();
		}
	}

	public void OnBannerClick(DRBanner drBanner)
	{
		parent?.ItemOnClick(drBanner);
	}

	protected override void Dispose(bool disposing)
	{
		_subscription.Dispose();
		_subscription = null;
		base.Dispose(disposing);
	}
}
