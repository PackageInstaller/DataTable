public class PlayHitEffectData : IFramePooledObject
{
	public int CasterID;

	public int DefenseID;

	public int TimelineID;

	public string EffectPath;

	public bool IsLockRotaion;

	public void OnEnterPool()
	{
		CasterID = 0;
		DefenseID = 0;
		TimelineID = 0;
		EffectPath = string.Empty;
		IsLockRotaion = false;
	}
}
