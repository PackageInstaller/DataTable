using Bamboo.ImageCenter;

namespace ACT.UI;

public class MonoBossBuffList : BaseBuffList
{
	public void Init(ImageAssetStation station, EntityBuffIconData data)
	{
		GetObjectPool();
		_station = station;
		_data = data;
		UpdateUIFromEntityData(_data);
	}

	public void UnInit()
	{
		ClearAllBuffUIs();
		ReleaseObjectPool();
		_data = null;
	}
}
