public class RemoteMember
{
	public int mEntityID;

	public long mNetID;

	public MemberPosition mEntityPosition;

	public RoleData roleData;

	public bool IsLocalMember(long localNetID)
	{
		if (mNetID == 0L)
		{
			return mEntityPosition == MemberPosition.First;
		}
		return mNetID == localNetID;
	}
}
