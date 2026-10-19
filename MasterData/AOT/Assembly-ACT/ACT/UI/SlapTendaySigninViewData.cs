using ACT.Model;

namespace ACT.UI;

public class SlapTendaySigninViewData : UIViewData, IFacePushViewData
{
	public int activityId;

	public FacePushSession FacePushSession { get; set; }
}
