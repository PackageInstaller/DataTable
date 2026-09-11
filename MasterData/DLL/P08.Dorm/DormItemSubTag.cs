[QuickOptions(new string[] { "restaurant.itemType", "restaurant.itemGroup" })]
public class DormItemSubTag : DormItemSubTagBase
{
	public string value;

	internal override object Value => value;
}
