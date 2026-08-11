using Ase.ECS;
using Cysharp.Threading.Tasks;

namespace Ase;

public class BattleInfoSystem : BaseSystem
{
	private int _battleTime;

	private int _battleTimeConfig;

	private float tempTime;

	private float _battleTimeDelayTime;

	private bool _battleTimeDelay;

	private float _globalBattleTime;

	private bool _startBattle;

	public int BattleTime => _battleTime;

	protected override bool IsLogicSystem => true;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_globalBattleTime = 0f;
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		_battleTimeConfig = world.BattleConfig.BattleTime;
		_battleTime = _battleTimeConfig;
		return true;
	}

	public void SetBattleTimeDelay(float time)
	{
		_battleTimeDelay = true;
		_battleTimeDelayTime = time + _globalBattleTime;
	}

	public void SetBattleTimeConfig(int time)
	{
		_battleTime = time;
		_battleTimeConfig = time;
	}

	public void Reset()
	{
		_battleTime = _battleTimeConfig;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		_globalBattleTime += deltaTime;
		if (_battleTimeDelay && _battleTimeDelayTime <= _globalBattleTime)
		{
			_battleTimeDelay = false;
			_startBattle = true;
		}
		if (_startBattle)
		{
			tempTime += deltaTime;
			if (tempTime >= 1f)
			{
				tempTime--;
				_battleTime--;
			}
			if (_battleTime <= 0)
			{
				TimeOver();
				_startBattle = false;
			}
		}
	}

	public int GetBattleTime()
	{
		return _battleTimeConfig - _battleTime;
	}

	private void TimeOver()
	{
		world.GameSettlement(GameSettlementType.TimeOver);
	}
}
