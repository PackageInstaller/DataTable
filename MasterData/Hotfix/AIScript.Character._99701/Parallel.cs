namespace AIScript.Character._99701;

public class Parallel : AIBase
{
	protected bool _attachFx;

	protected readonly string _fxStr = "fx_zero_energy";

	public void OnEnable()
	{
	}

	public void OnDisable()
	{
		if (_attachFx)
		{
			_actor.StopFX(_fxStr);
		}
	}

	public void OnUpdate()
	{
		if (!_attachFx)
		{
			if (_actor.buffComponent != null && _actor.buffComponent.CheckBuffByBuffID(99701))
			{
				_attachFx = true;
				_actor.PlayFX(_fxStr);
			}
		}
		else if (_actor.buffComponent != null && !_actor.buffComponent.CheckBuffByBuffID(99701))
		{
			_attachFx = false;
			_actor.StopFX(_fxStr);
		}
	}
}
