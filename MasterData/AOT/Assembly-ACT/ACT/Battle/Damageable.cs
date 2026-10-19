using ACT.Battle.Configs;
using Fundamental;

namespace ACT.Battle;

public class Damageable : LuminSerializedMonoBehaviour
{
	public IDamageable damageable;

	public IResetBehave resetBehave;

	public void OnDamage(ActionMemory actionMemory)
	{
		if (damageable != null)
		{
			Singleton<DamageableManager>.instance.Register(this);
			damageable.Do(actionMemory);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public void OnResetBehave()
	{
		if (resetBehave != null)
		{
			resetBehave.Reset();
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void OnDestroy()
	{
		if (Singleton<DamageableManager>.HasInstance())
		{
			Singleton<DamageableManager>.instance.Unregister(this);
		}
	}
}
