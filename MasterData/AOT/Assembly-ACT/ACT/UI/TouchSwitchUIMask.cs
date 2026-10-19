using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchSwitchUIMask : MonoBehaviour
{
	public Animator animator;

	public Image cdProgress;

	public TextMeshProUGUI cdText;

	public BImage headIcon;

	public Image hpIcon;

	public Image redHpIcon;

	public GameObject select;

	public GameObject lowHpEffect;

	public Material onCharacterDieMat;

	public BImage switchSkillImage;

	public GameObject ultraRoot;

	public BImage ultraImageFill;

	public BImage ultraImage;

	public Image ultraEffectImage;

	public ParticleSystem[] ultraParticleSystem;

	public Color[] characterUltraColors;

	public CanvasGroup bloodBarCanvasGroup;

	public CanvasGroup ultraRootCanvasGroup;

	public OperateBtnPrompt btnPrompt;

	[Header("角色头像root")]
	public GameObject root;

	[Header("血量fillAmount的最低值")]
	[Range(0.1f, 1f)]
	public float hpPercent = 0.1f;

	[Header("教学点击需要换人特效")]
	public GameObject demonstrateEffect;

	[Header("是否为试用角色root")]
	public GameObject trialRoot;

	private const string DEATH = "death";

	private const string BACKIN = "backIn";

	private const string ULTRAFILLED = "UltraFilled";

	private const string SELECTED = "Selected";

	private const string SWITCHSKILL = "switchSkill";

	private const string CHANGE = "change";

	private const string LEVELUP = "levelUp";

	private const string SWITCHSKILLEFFECT = "switchSkillEffect";

	private const string LOWHPEFFECT = "lowHpEffect";

	private const string DISPLAYABLE = "displayable";

	private const string EMPTY = "empty";

	private int _seatId;

	private int _characterId;

	private uint _compId;

	private EntityCharacterData _characterData;

	private float m_Hp;

	private float m_Energy;

	private float m_Ultra;

	private float _assistCost;

	public int characterId => _characterId;

	private float hpValue
	{
		get
		{
			return m_Hp;
		}
		set
		{
			m_Hp = value;
			SetHpValue(value);
		}
	}

	private float energyValue
	{
		get
		{
			return m_Energy;
		}
		set
		{
			m_Energy = value;
			SetEnergyValue(value);
		}
	}

	private float ultraValue
	{
		get
		{
			return m_Ultra;
		}
		set
		{
			m_Ultra = value;
			SetUltraValue(value);
		}
	}

	private void SetUltraValue(float value)
	{
		if (ultraImageFill != null && ultraImageFill.icon != null)
		{
			ultraImageFill.icon.fillAmount = value;
		}
	}

	private void SetChangeCDDisplay(float remainingCD, float totalCD)
	{
		float num = Mathf.Max(0f, remainingCD);
		Image image = cdProgress;
		float fillAmount;
		if (num > 0f)
		{
			fillAmount = ((totalCD > 0f) ? Mathf.Clamp01(num / totalCD) : 1f);
		}
		else
		{
			fillAmount = 0f;
		}
		image.fillAmount = fillAmount;
		if ((bool)cdText)
		{
			cdText.gameObject.SetActive(num > 0f);
			UpdateHeadIconLightness(headIcon.icon, (num > 0f) ? 0.65f : 1f);
			if (cdText.gameObject.activeSelf)
			{
				cdText.SetText("{0:0.0}", Mathf.Ceil(num * 10f) / 10f);
			}
		}
	}

	private void SetHpValue(float value)
	{
		hpIcon.fillAmount = value;
		redHpIcon.fillAmount = value;
		if (hpIcon.fillAmount != 0f)
		{
			hpIcon.fillAmount = Mathf.Clamp(hpIcon.fillAmount, hpPercent, hpIcon.fillAmount);
		}
		if (redHpIcon.fillAmount != 0f)
		{
			redHpIcon.fillAmount = Mathf.Clamp(redHpIcon.fillAmount, hpPercent, redHpIcon.fillAmount);
		}
	}

	private void SetEnergyValue(float value)
	{
	}

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AssistVal_Change, OnAssistValChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Assist_AssistBack, OnAssistBack);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AssistVal_Change, OnAssistValChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Assist_AssistBack, OnAssistBack);
	}

	public void Init(int seatId, int characterId, uint compId, bool btnPromptShow)
	{
		_seatId = seatId;
		_characterId = characterId;
		_compId = compId;
		_characterData = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		Color[] array = characterUltraColors;
		if (array != null && array.Length > 0 && _characterData != null)
		{
			ultraEffectImage.color = characterUltraColors[_characterData.mannerType - 1];
			ParticleSystem[] array2 = ultraParticleSystem;
			foreach (ParticleSystem particleSystem in array2)
			{
				if (!(particleSystem == null))
				{
					ParticleSystem.MainModule main = particleSystem.main;
					main.startColor = characterUltraColors[_characterData.mannerType - 1];
				}
			}
		}
		headIcon.icon.material = null;
		UpdateHeadIconLightness(headIcon.icon, 1f);
		SetBtnPromptActive(btnPromptShow);
		if (bloodBarCanvasGroup != null)
		{
			bloodBarCanvasGroup.alpha = 1f;
		}
		if (ultraRootCanvasGroup != null)
		{
			ultraRootCanvasGroup.alpha = 1f;
		}
	}

	public void UnInit()
	{
		_seatId = -1;
		_characterId = 0;
		_compId = 0u;
		_characterData = null;
	}

	private void OnAssistValChange(BaseEventContent eventContent)
	{
		if (eventContent is AssistValChangeEvt)
		{
			SetSwitchSkillEffect();
		}
	}

	private void OnAssistBack(BaseEventContent eventContent)
	{
		if (eventContent is AssistBackEvt assistBackEvt)
		{
			_ = _characterId;
			_ = assistBackEvt.lastCharacterId;
		}
	}

	public void SetSwitchSkillEffect()
	{
		if (MonoECS.instance.MainEntityCharacterId == _characterId)
		{
			SetSwitchSkillCDEffectAni(value: false);
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		Entity entity = MonoECS.instance.localPlayer.IdOfTeamCharacter(_characterId);
		if (mainEntity == null || entity == null || !mainEntity.TryGetCompAbility(out CompAbility component) || !entity.TryGetCompAbility(out CompAbility component2))
		{
			SetSwitchSkillCDEffectAni(value: false);
			return;
		}
		float num = component.AssistValue / component2.AssistCost;
		bool flag = MonoECS.instance.sceneStatus == SceneStatus.Rogue;
		SetSwitchSkillCDEffectAni(num >= 1f && !flag);
	}

	public void SetCharacterCD(Entity entity)
	{
		if (entity.IsAlive() && MonoECS.instance.localPlayer.GetSwitchIndex(entity) != -1 && entity.TryGetCompBehave(out CompBehave component))
		{
			SetChangeCDDisplay(component.ChangeCD, component.ChangeCDTotal);
		}
		else
		{
			SetChangeCDDisplay(0f, 0f);
		}
	}

	public void InitAssist(float assistCost)
	{
		_assistCost = assistCost;
	}

	public void SetHpValue(Entity entity, float bloodWarnPercent, float value)
	{
		hpValue = value;
		if (entity.IsAlive())
		{
			SetLowHpEffectAni(hpValue < bloodWarnPercent);
			if ((bool)redHpIcon)
			{
				redHpIcon.gameObject.SetActive(hpValue < bloodWarnPercent);
			}
			if ((bool)hpIcon)
			{
				hpIcon.gameObject.SetActive(hpValue >= bloodWarnPercent);
			}
		}
		else
		{
			hpIcon.gameObject.SetActive(value: false);
			redHpIcon.gameObject.SetActive(value: false);
		}
	}

	public void SetEnergyValue(Entity entity)
	{
		energyValue = entity.GetCompAbility().CurNormalEnergyPercent;
	}

	public void RefreshUltra()
	{
		Entity entity = MonoECS.instance.localPlayer.IdOfTeamCharacter(_characterId);
		if (entity.IsAlive())
		{
			CompCharacter compCharacter = entity.GetCompCharacter();
			EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[compCharacter.characterSource.Id()];
			float a = (ultraValue = entity.GetCompAbility().CurrentUltimateSkillValue / entityCharacterData.skillEnergy);
			if (Mathf.Approximately(a, 1f))
			{
				this.GetImageStation().LoadImage(145, RuntimeConfigs.data.entityDatas[compCharacter.characterSource.Id()].element, ultraImage);
				SetUltra();
			}
			else if (Mathf.Approximately(a, 0f))
			{
				this.GetImageStation().LoadImage(145, 0, ultraImage);
			}
			else
			{
				this.GetImageStation().LoadImage(145, 0, ultraImage);
				animator.SetBool("UltraFilled", value: false);
			}
			this.GetImageStation().LoadImage(145, RuntimeConfigs.data.entityDatas[compCharacter.characterSource.Id()].element, ultraImageFill);
			ultraImageFill.icon.type = Image.Type.Filled;
			ultraImageFill.icon.fillMethod = Image.FillMethod.Vertical;
		}
	}

	public void SetSelect(bool active)
	{
	}

	public void InitNoCharacter(int id)
	{
		headIcon.icon.gameObject.SetActive(value: false);
		select.gameObject.SetActive(value: false);
		SetChangeCDDisplay(0f, 0f);
		ultraValue = 0f;
		ultraRoot.SetActive(value: false);
		SetLowHpEffectAni(value: false);
		SetSwitchSkillCDEffectAni(value: false);
	}

	public void SetUltra()
	{
		animator.SetBool("UltraFilled", value: true);
	}

	public void SetAniDeath()
	{
		SetLowHpEffectAni(value: false);
		SetSwitchSkillCDEffectAni(value: false);
		animator.SetBool("death", value: true);
		ultraRoot.SetActive(value: false);
		animator.SetBool("UltraFilled", value: false);
		btnPrompt?.SetEnableState(enable: false);
		UpdateHeadIconLightness(headIcon.icon, 0.65f);
		headIcon.icon.material = onCharacterDieMat;
	}

	public void SetAniSwitchSkill()
	{
		animator.SetTrigger("switchSkill");
	}

	public void SetAniChange()
	{
		animator.SetTrigger("change");
	}

	public void SetAniBackIn()
	{
		animator.SetTrigger("backIn");
		RefreshUltra();
	}

	public void SetToNormal()
	{
		animator.SetBool("death", value: false);
		btnPrompt?.SetEnableState(enable: true);
		ultraRoot.SetActive(value: true);
	}

	public void SetAniLevelUp()
	{
		animator.SetTrigger("levelUp");
	}

	public void SetSwitchSkillCDEffectAni(bool value)
	{
		animator.SetBool("switchSkillEffect", value);
	}

	public void SetLowHpEffectAni(bool value)
	{
	}

	public void SetDisplayable(bool value)
	{
		animator.SetBool("displayable", value);
	}

	public void SetAniEmpty(bool value)
	{
		animator.SetBool("empty", value);
		if (value)
		{
			SetLowHpEffectAni(value: false);
			SetSwitchSkillCDEffectAni(value: false);
			SetChangeCDDisplay(0f, 0f);
			ultraValue = 0f;
			ultraRoot.SetActive(value: false);
			animator.SetBool("UltraFilled", value: false);
		}
	}

	public void SetRogueUltra()
	{
		ultraValue = 0f;
		if (bloodBarCanvasGroup != null)
		{
			bloodBarCanvasGroup.alpha = 0f;
		}
		if (ultraRootCanvasGroup != null)
		{
			ultraRootCanvasGroup.alpha = 0f;
		}
	}

	public void RestTriggers()
	{
		if (!(animator == null) && !(animator.gameObject == null))
		{
			animator.Rebind();
			animator.ResetTrigger("change");
			animator.ResetTrigger("backIn");
			animator.ResetTrigger("switchSkill");
			animator.ResetTrigger("levelUp");
			animator.SetBool("Selected", value: false);
		}
	}

	private void UpdateHeadIconLightness(Image headIcon, float vValue)
	{
		Color.RGBToHSV(headIcon.color, out var H, out var S, out var V);
		V = vValue;
		Color color = Color.HSVToRGB(H, S, V);
		color.a = headIcon.color.a;
		headIcon.color = color;
	}

	public void SetBtnPromptActive(bool active)
	{
		btnPrompt.SetVisible(active);
	}
}
