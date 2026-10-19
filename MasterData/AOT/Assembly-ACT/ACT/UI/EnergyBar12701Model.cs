using ACT.Model;

namespace ACT.UI;

public class EnergyBar12701Model : Model<EnergyBar12701Model>
{
	private bool _reduce;

	public bool Reduce => _reduce;

	public void SetReduceState(bool reduce)
	{
		_reduce = reduce;
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}
}
