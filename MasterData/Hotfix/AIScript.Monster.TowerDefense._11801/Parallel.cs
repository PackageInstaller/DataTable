using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense._11801;

public class Parallel : TowerCharacterParalletBase
{
	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1180107] = 42 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
