namespace ACT.UI;

public class LoungeRoomSideInfoSubView : SubUIView<LoungeRoomSideInfoSubInputController>
{
	public LoungeMainView Owner { get; private set; }

	public void BindOwner(LoungeMainView owner)
	{
		Owner = owner;
	}
}
