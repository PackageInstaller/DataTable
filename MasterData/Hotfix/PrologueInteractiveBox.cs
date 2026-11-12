using Nova.Hotfix;

public class PrologueInteractiveBox : InteractiveBox
{
	private long uniqueID;

	public void initInteractiveBox(Chest data, InteractiveManager.interactiveState interactiveState, long uuid)
	{
		uniqueID = uuid;
		iId = data.Id;
		autoOpen = data.AutoOpen > 0;
		if (!autoOpen)
		{
			_interactiveState = interactiveState;
			base.initState();
			interCollider.ActiveSelf = true;
		}
		else
		{
			AutoOpen();
		}
	}

	protected override long getUID()
	{
		return uniqueID;
	}

	public override string GetBoxName()
	{
		return "";
	}

	protected override void showGetItem()
	{
		if (_actor != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance?.WwiseVoice_Play(_actor.dataID, "chest");
		}
		MonoSingleton<LuaManager>.Instance?.FireEvent("InteractiveBoxGet", iId);
	}
}
