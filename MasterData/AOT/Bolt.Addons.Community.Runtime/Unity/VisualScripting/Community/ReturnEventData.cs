namespace Unity.VisualScripting.Community;

[RenamedFrom("Lasm.UAlive.ReturnEventData")]
[RenamedFrom("Lasm.BoltExtensions.ReturnEventData")]
[RenamedFrom("Bolt.Addons.Community.ReturnEvents.ReturnEventData")]
public class ReturnEventData
{
	public ReturnEventArg args;

	public ReturnEventData(ReturnEventArg args)
	{
		this.args = args;
	}
}
