public class QWCharacterPlayAnimAction : QWAgentAction
{
	public string animName;

	public float crossFade;

	public bool forceReplay;

	public QWCharacterPlayAnimAction()
		: base(E_Type.PlayAnim)
	{
	}

	public override void Reset()
	{
		base.Reset();
		animName = "";
		crossFade = 0f;
		forceReplay = false;
	}
}
