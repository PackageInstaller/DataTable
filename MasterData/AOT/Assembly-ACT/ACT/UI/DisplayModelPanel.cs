namespace ACT.UI;

public class DisplayModelPanel : CharacterRightBase
{
	protected override void Init()
	{
	}

	public override void UnLoad()
	{
		base.UnLoad();
		gameObject.SetActive(value: false);
	}

	public override void AddEventListener()
	{
		base.AddEventListener();
	}

	public override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}
}
