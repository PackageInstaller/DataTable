namespace Ase.ECS;

public class BuffEffectEntity : EffectEntity
{
	private BuffEffectData _buffEffectData;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_buffEffectData = effectData as BuffEffectData;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
	}

	public void OnBuffDispose(Buff buff)
	{
		if (effectData.disposeType == -1)
		{
			if (_isTimeDelayDispose)
			{
				SetDuration(0f);
			}
			else
			{
				DoEntityDead();
			}
		}
	}

	public override bool IgnoreTimeScale()
	{
		if (!base.IgnoreTimeScale())
		{
			return _buffEffectData.BuffIgnoreTimeScale;
		}
		return true;
	}
}
