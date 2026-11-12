using AIScript.Utils;
using TrueSync;

namespace AIScript.PassiveSkill;

public class Skill_LightingChain_OnAttack : SkillAdvancedBase
{
	private readonly int _hitDamageId = 5014611;

	private readonly string _hitFxPath = "Actor/Character/11701/FX/fx_11701_bullet_atk_1";

	private readonly int _hitDamageId_for_secend = 5014601;

	private readonly string _hitFxPath_for_secend = "Actor/Character/11701/FX/fx_11701_bullet_atk_1";

	private readonly FP _doubleHitInterval = 0.5;

	private readonly FP _linkHitInterval = 0.2;

	private readonly FP _linkCheckRange = 4;

	private readonly int _maxLinkTime = 5;

	private readonly FP _maxCoolingTime = 3;

	private readonly FP _executeRate = 0.3;

	private static readonly int _targetTag = CommonHelper.StringToHash("");

	private Skill_LightingChain _lightingChain;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		_lightingChain?.OnFinish();
		_lightingChain?.Clear();
		_lightingChain = null;
	}

	private void OnDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from != _actor) && (_targetTag != 0 || ((AdventureActor)adventureActorReceiveDamageEvent.to).CheckTag(_targetTag)) && adventureActorReceiveDamageEvent.hitDamageId != _hitDamageId && adventureActorReceiveDamageEvent.hitDamageId != _hitDamageId_for_secend)
		{
			if (_lightingChain == null)
			{
				_lightingChain = new Skill_LightingChain(_actor, _hitDamageId, _hitFxPath, _hitDamageId_for_secend, _hitFxPath_for_secend, _doubleHitInterval, _linkHitInterval, _linkCheckRange, _maxLinkTime, _maxCoolingTime, _executeRate);
			}
			_lightingChain.Start(adventureActorReceiveDamageEvent.to as AdventureActor);
		}
	}
}
