using ACT.Model;

namespace ACT.UI;

public class NewbieLoginViewData : UIViewData, IFacePushViewData
{
	public int activityId;

	public FacePushSession FacePushSession { get; set; }
}
