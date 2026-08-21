using System.Collections.Generic;

namespace Ase.ECS;

public class KnockDownStateWeightComponent : BaseComponent
{
	private Dictionary<MonsterKnockDownLevelEnum, int> _knockDownStateIdDic;

	private int _minionKnockDownState;

	public int MinionKnockDownState => _minionKnockDownState;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_knockDownStateIdDic = new Dictionary<MonsterKnockDownLevelEnum, int>();
		DRState[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRState>();
		foreach (DRState dRState in allDataRow)
		{
			if (!_knockDownStateIdDic.ContainsKey(dRState.MonsterKnockDownLevelEnum) && dRState.MonsterKnockDownLevelEnum != MonsterKnockDownLevelEnum.None)
			{
				_knockDownStateIdDic.Add(dRState.MonsterKnockDownLevelEnum, dRState.Id);
			}
			if (dRState.IsMinionknockdownState)
			{
				_minionKnockDownState = dRState.Id;
			}
		}
	}

	public int GetKnockDownStateId(MonsterKnockDownLevelEnum level)
	{
		if (_knockDownStateIdDic.TryGetValue(level, out var value))
		{
			return value;
		}
		return 0;
	}
}
