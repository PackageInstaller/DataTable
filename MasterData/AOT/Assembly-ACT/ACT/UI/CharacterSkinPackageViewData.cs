using ACT.Model;

namespace ACT.UI;

public class CharacterSkinPackageViewData : UIViewData, IFacePushViewData
{
	public int skinShopId;

	public int subShopId;

	public FacePushSession FacePushSession { get; set; }
}
