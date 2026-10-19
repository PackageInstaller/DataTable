using System;
using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class Skill
{
	private const float CdThreshold = 0.1f;

	public SkillConfig config;

	private int _characterId;

	private float m_NowCd;

	private int m_NowCount;

	private float m_Cd;

	private float m_TempMaxCd;

	private SkillCountModifierCollection _skillCountModifierCollection;

	public int CharacterId => _characterId;

	public Entity Entity { get; private set; }

	public string Name => config.name;

	public float ConfigCd => config.CD;

	public float Cd => m_Cd;

	public bool NeedSync => config.needSync;

	public float AddCount => (_skillCountModifierCollection != null) ? _skillCountModifierCollection.GetModifiedValue(config.addCount) : config.addCount;

	public int MaxCount
	{
		get
		{
			if (_skillCountModifierCollection == null)
			{
				return config.maxCount;
			}
			return _skillCountModifierCollection.GetModifiedValue(config.maxCount);
		}
	}

	public int NowCount => m_NowCount;

	public float NowCd => m_NowCd;

	public bool AffectByCDR => config.affectByCDR;

	public bool InColdDown => NowCount < config.maxCount;

	public event Action onChanged;

	public event Action<Skill, int> onCountChanged;

	public void SetSkillCd(float cd, bool exceeds)
	{
		if (!exceeds && cd > Cd)
		{
			m_TempMaxCd = cd;
		}
		if (cd != m_NowCd)
		{
			if (cd > 0f && NowCount == MaxCount)
			{
				SetSkillCount(NowCount - 1);
			}
			if (cd <= 0f)
			{
				m_TempMaxCd = 0f;
			}
			m_NowCd = cd;
			onChanged?.Invoke();
			DispatchSkillCdChangeEvent(Name, NowCount, config.maxCount, m_NowCd, (m_TempMaxCd == 0f) ? Cd : m_TempMaxCd);
		}
	}

	public void SetSkillCount(int count)
	{
		if (count != m_NowCount)
		{
			int nowCount = m_NowCount;
			onCountChanged?.Invoke(this, count);
			DispatchSkillCountChangeEvent(Name, m_NowCount, count, MaxCount);
			m_NowCount = count;
			count = Mathf.Clamp(count, 0, MaxCount);
			if ((count < nowCount && config.whenUseResetCD) || (count < MaxCount && NowCd <= 0f))
			{
				m_TempMaxCd = 0f;
				SetSkillCd(Cd, exceeds: false);
			}
			else if (count == MaxCount)
			{
				SetSkillCd(0f, exceeds: false);
			}
			onChanged?.Invoke();
		}
	}

	public void SetMaxCd(float maxCd)
	{
		float a = ((config.CD == 0f) ? 0f : 0.1f);
		m_Cd = Mathf.Max(a, maxCd);
	}

	public Skill(Entity eb, SkillConfig skillConfig, float nowCd, int nowCount, Action<Skill, int> onCountChange = null)
	{
		_characterId = (eb.IsCharacter() ? eb.GetCompCharacter().characterSource.Id() : (-1));
		Entity = eb;
		config = skillConfig;
		_skillCountModifierCollection = new SkillCountModifierCollection();
		SetMaxCd(skillConfig.CD * (1f - eb.GetCompAbility().GetProperty(206u).value));
		SetSkillCount(nowCount);
		SetSkillCd(nowCd, exceeds: false);
		if (onCountChange != null)
		{
			onCountChanged += onCountChange;
		}
	}

	public void Reset()
	{
		onChanged = null;
		onCountChanged = null;
	}

	private void DispatchSkillCdChangeEvent(string skillName, int nowCount, int maxCount, float nowCd, float configCd)
	{
		SkillCdChangeEvt evt = Singleton<EventManager>.instance.GetEvt<SkillCdChangeEvt>();
		evt.eb = Entity;
		evt.cdName = skillName;
		evt.nowCount = nowCount;
		evt.maxCount = maxCount;
		evt.nowCd = nowCd;
		evt.configCd = configCd;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Skill_CdChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void DispatchSkillCountChangeEvent(string skillName, int preCount, int nowCount, int maxCount)
	{
		SkillCountChangeEvt evt = Singleton<EventManager>.instance.GetEvt<SkillCountChangeEvt>();
		evt.eb = Entity;
		evt.countBindSkillName = skillName;
		evt.preCount = preCount;
		evt.nowCount = nowCount;
		evt.maxCount = maxCount;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Skill_CountChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void AddSkillCountModifier(string abName, int addValue)
	{
		_skillCountModifierCollection.Add(abName, addValue);
		ReconcileAndDispatch();
	}

	public void RemoveSkillCountModifier(string abName)
	{
		_skillCountModifierCollection.Remove(abName);
		ReconcileAndDispatch();
	}

	private void ReconcileAndDispatch()
	{
		if (m_NowCount > MaxCount)
		{
			SetSkillCount(MaxCount);
		}
		DispatchSkillCountChangeEvent(Name, NowCount, NowCount, MaxCount);
	}
}
