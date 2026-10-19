namespace ACT.Model;

public class TextLibraryData
{
	public int contentId;

	public int belongGroupId;

	public int belongParentId;

	public bool isRead;

	public long unLockTime;

	public TextLibraryData(int contentId, int belongGroupId, int belongParentId, bool isRead, long unLockTime)
	{
		this.contentId = contentId;
		this.belongGroupId = belongGroupId;
		this.belongParentId = belongParentId;
		this.isRead = isRead;
		this.unLockTime = unLockTime;
	}
}
