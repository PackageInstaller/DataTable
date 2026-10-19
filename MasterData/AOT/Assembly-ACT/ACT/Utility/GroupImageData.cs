using ACT.Config;

namespace ACT.Utility;

public class GroupImageData
{
	private int _groupId;

	private int _imageId;

	public int GroupId => _groupId;

	public int ImageId => _imageId;

	public GroupImageData(int groupId, int imageId)
	{
		_groupId = groupId;
		_imageId = imageId;
	}

	public GroupImageData(GroupImageConfig config)
	{
		_groupId = config.groupId;
		_imageId = config.imageId;
	}
}
