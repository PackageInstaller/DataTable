using ACT.Model;

namespace ACT.UI;

public class DeparturePackageViewData : UIViewData, IFacePushViewData
{
	public int bundleId;

	public int subShopId;

	public FacePushSession FacePushSession { get; set; }
}
