using System.Collections.Generic;
using ACT.Utility;
using Fundamental;

namespace ACT.Battle;

public class DamageableManager : Singleton<DamageableManager>
{
	private List<Damageable> _damageables;

	public void Register(Damageable damageable)
	{
		if (_damageables != null && !(damageable == null))
		{
			_damageables.TryAdd(damageable);
		}
	}

	public void Unregister(Damageable damageable)
	{
		if (_damageables != null && !(damageable == null))
		{
			_damageables.TryRemove(damageable);
		}
	}

	public void ResetAll()
	{
		if (_damageables == null)
		{
			return;
		}
		foreach (Damageable damageable in _damageables)
		{
			if (damageable != null)
			{
				damageable.OnResetBehave();
			}
		}
		_damageables.Clear();
	}

	public override void Init()
	{
		_damageables = ListPool<Damageable>.Get();
	}

	public override void UnInit()
	{
		if (_damageables != null)
		{
			_damageables.Clear();
			ListPool<Damageable>.Release(_damageables);
			_damageables = null;
		}
	}
}
