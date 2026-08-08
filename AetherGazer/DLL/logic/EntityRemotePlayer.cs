using Entitas;

[Sim]
public class EntityRemotePlayer : IComponent
{
	public int mNetID;

	public int mLocalEntityID;

	public bool mIsLocalPlayer;
}
