using GameFramework.Runtime;

namespace Ase;

public class MapItemIconMessager : MessageBase
{
	public LevelSaveService.MapItemViewData Data;

	public bool ChangePos;

	public MapItemIconMessager(object sender, LevelSaveService.MapItemViewData Data)
		: base(sender)
	{
		this.Data = Data;
	}
}
