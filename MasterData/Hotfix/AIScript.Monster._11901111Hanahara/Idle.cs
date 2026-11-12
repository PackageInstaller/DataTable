namespace AIScript.Monster._11901111Hanahara;

public class Idle : AIBase
{
	public void OnStart()
	{
		_actor.Action(makeThreatAlert: false);
	}
}
