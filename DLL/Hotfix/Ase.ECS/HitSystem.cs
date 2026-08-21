using System.Collections.Generic;

namespace Ase.ECS;

public class HitSystem : BaseSystem
{
	private Dictionary<int, Dictionary<string, int>> _entityHitConfig = new Dictionary<int, Dictionary<string, int>>();

	protected override bool IsLogicSystem => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		InitHitConfig();
	}

	private void InitHitConfig()
	{
		DREntityHitConfig[] allDataRow = GameEntry.DataTable.GetAllDataRow<DREntityHitConfig>();
		foreach (DREntityHitConfig dREntityHitConfig in allDataRow)
		{
			if (!_entityHitConfig.ContainsKey(dREntityHitConfig.MonsterId))
			{
				_entityHitConfig.Add(dREntityHitConfig.MonsterId, new Dictionary<string, int>());
			}
			for (int j = 0; j < dREntityHitConfig.TreeId1.Count; j++)
			{
				_entityHitConfig[dREntityHitConfig.MonsterId].Add($"{dREntityHitConfig.AttackPower}-{j}", dREntityHitConfig.TreeId1[j]);
			}
		}
	}

	public Dictionary<string, int> GetHitConfig(int actorId)
	{
		if (_entityHitConfig.TryGetValue(actorId, out var value))
		{
			return value;
		}
		return null;
	}
}
