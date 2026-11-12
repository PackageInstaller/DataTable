using UnityEngine;

public class AkWeaponHitSwitch : MonoBehaviour
{
	[Space]
	public string _attackWiseEvent;

	[Space]
	public string _wiseSwitchG;

	public string _wiseSwitch;

	public string _attackWwiseSwitchG;

	public string _attackWwiseSwitch;

	public string _wiseShieldSwitchG;

	public string _wiseShieldSwitch;

	private ActorShield _shield;

	private void Awake()
	{
	}

	public void ToPostEvent(AkWeaponHitSwitch attackS, LogicEntity _entity)
	{
		if (attackS == null)
		{
			return;
		}
		if (_entity is AdventureActor adventureActor)
		{
			if ((object)_shield == null)
			{
				_shield = adventureActor.actorShield;
			}
			if (adventureActor is MonsterAdventureActor && (adventureActor.isInvincible || adventureActor.damageImmunity) && !string.IsNullOrEmpty(attackS._attackWiseEvent) && !string.IsNullOrEmpty(_wiseSwitchG))
			{
				MonoSingleton<WwiseAudioManager>.Instance.SetSwicth(attackS._attackWwiseSwitchG, attackS._attackWwiseSwitch, gameObject);
				MonoSingleton<WwiseAudioManager>.Instance.SetSwicth("materialType_impact", "shieldBuff", gameObject);
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound(attackS._attackWiseEvent, gameObject);
				return;
			}
		}
		if (_shield != null && _shield.shiledValue > 0 && !string.IsNullOrEmpty(attackS._attackWiseEvent) && !string.IsNullOrEmpty(_wiseShieldSwitchG))
		{
			MonoSingleton<WwiseAudioManager>.Instance.SetSwicth(attackS._attackWwiseSwitchG, attackS._attackWwiseSwitch, gameObject);
			MonoSingleton<WwiseAudioManager>.Instance.SetSwicth(_wiseShieldSwitchG, _wiseShieldSwitch, gameObject);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(attackS._attackWiseEvent, gameObject);
		}
		else if (!string.IsNullOrEmpty(attackS._attackWiseEvent) && !string.IsNullOrEmpty(_wiseSwitchG))
		{
			MonoSingleton<WwiseAudioManager>.Instance.SetSwicth(attackS._attackWwiseSwitchG, attackS._attackWwiseSwitch, gameObject);
			MonoSingleton<WwiseAudioManager>.Instance.SetSwicth(_wiseSwitchG, _wiseSwitch, gameObject);
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(attackS._attackWiseEvent, gameObject);
		}
	}
}
