using UnityEngine;

namespace Ase.ECS;

public class HeroAngerComponent : BaseComponent
{
	private float _heroAngerLifeTime;

	private float _heroAngerReduceSpeed;

	private float _angerReduceTimeRatio;

	private float _angerReduceSpeedRatio;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_heroAngerLifeTime = GetData<float>("HeroAngerReduceTime");
		_heroAngerReduceSpeed = GetData<int>("HeroAngerReduceSpeed");
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (!mBaseEntity.GetProperty("HeroAngerSwitch").FloatEquals(0f))
		{
			_angerReduceTimeRatio = mBaseEntity.GetProperty("HeroAngerReduceTimeRatio");
			float intervalTimer = mBaseEntity.GetWorld().IntervalTimer;
			_heroAngerLifeTime = Mathf.Clamp(_heroAngerLifeTime - intervalTimer * _angerReduceTimeRatio, 0f, _heroAngerLifeTime);
			if (_heroAngerLifeTime <= 0f)
			{
				_angerReduceSpeedRatio = mBaseEntity.GetProperty("HeroAngerReduceSpeedRatio");
				mBaseEntity.ChangeProperty("HeroAnger", (0f - _heroAngerReduceSpeed) * _angerReduceSpeedRatio);
				RefreshHeroAngerLifeTime();
			}
		}
	}

	public void RefreshHeroAngerLifeTime()
	{
		_heroAngerLifeTime = GetData<float>("HeroAngerReduceTime");
	}
}
