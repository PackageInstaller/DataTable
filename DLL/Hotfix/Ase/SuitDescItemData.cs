using GameFramework.Runtime;

namespace Ase;

public class SuitDescItemData : ViewModelBase
{
	private string _suitName;

	private string _suitDesc;

	public string SuitName => _suitName;

	public string SuitDesc => _suitDesc;

	public SuitDescItemData(DREntry drEntry)
	{
	}
}
