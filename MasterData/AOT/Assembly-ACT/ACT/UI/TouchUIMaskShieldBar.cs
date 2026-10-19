using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMaskShieldBar : TouchUIMaskBase
{
	public GameObject shieldRoot;

	public Image shieldBackFill;

	public Image shieldFrontFill;

	public GameObject shieldFullEffect;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string Show = "Show";

	private const string Break = "Break";

	private const string OverHit = "OverHit";

	private int _characterId = -1;

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_EntityDie, OnMainEntityDieRefreshBloodUI);
	}

	private void Start()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_ShieldChange, OnCharacterShieldChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnRefreshBattleUI);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_ShieldChange, OnCharacterShieldChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnRefreshBattleUI);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_EntityDie, OnMainEntityDieRefreshBloodUI);
	}

	public void OnChangeMainEntity(Entity entityBehave)
	{
		_characterId = entityBehave.GetCompCharacter().characterSource.Id();
		CompAbility compAbility = entityBehave.GetCompAbility();
		float num = (float)compAbility.shield / (float)compAbility.maxHP;
		num = Mathf.Clamp(num, 0f, 1f);
		float num2 = (targetValue = num);
		value = num2;
		UpdateShield(num, compAbility.shield, compAbility.maxShield);
	}

	protected override void Changed()
	{
		shieldFrontFill.fillAmount = targetValue;
	}

	public override void SetValue()
	{
		if (targetValue > value)
		{
			shieldBackFill.fillAmount = value;
			return;
		}
		shieldFrontFill.fillAmount = targetValue;
		shieldBackFill.fillAmount = value;
	}

	private void OnCharacterShieldChange(BaseEventContent content)
	{
		if (!(content is CharacterShieldChangeEvt characterShieldChangeEvt) || characterShieldChangeEvt.characterId != _characterId)
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsAlive())
		{
			CompAbility compAbility = mainEntity.GetCompAbility();
			float num = (float)characterShieldChangeEvt.curShield / (float)compAbility.maxHP;
			num = Mathf.Clamp(num, 0f, 1f);
			float num2 = targetValue;
			targetValue = num;
			if (targetValue > 0f && num2 <= 0f)
			{
				_betterAnimation.GetSequence("Show").Play();
			}
			if (targetValue <= num2 && num >= 1f)
			{
				_betterAnimation.GetSequence("OverHit").Play();
			}
			if (targetValue <= 0f && num2 > 0f)
			{
				_betterAnimation.GetSequence("Break").Play();
			}
			UpdateShield(num, characterShieldChangeEvt.curShield, characterShieldChangeEvt.maxShield);
		}
	}

	private void UpdateShield(float shieldPercent, int curShield, int maxShield)
	{
		shieldFullEffect.SafeSetActive(shieldPercent >= 1f);
		shieldRoot.SafeSetActive(maxShield > 0);
	}

	public void InitMainEntityShield(int newValue)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		OnChangeMainEntity(mainEntity);
	}

	public void OnMainEntityDieRefreshBloodUI(BaseEventContent obj)
	{
		if ((EntityDieEvt)obj != null)
		{
			InitMainEntityShield(MonoECS.instance.mainEntity.GetCompAbility().shield);
		}
	}

	private void OnRefreshBattleUI(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt)
		{
			InitMainEntityShield(MonoECS.instance.mainEntity.GetCompAbility().shield);
		}
	}
}
