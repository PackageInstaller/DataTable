using ACT.Model;

namespace ACT.UI;

public class MonthCardRewardViewData : UIViewData, IFacePushViewData
{
	public int monthlyPassId;

	public FacePushSession FacePushSession { get; set; }
}
