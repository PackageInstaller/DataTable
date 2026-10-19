using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.MultiPlayer;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class DamageNumber : MonoBehaviour
{
	public DmgNumStyle[] dmgTypes;

	public GameObject[] dmgObjects;

	private Dictionary<DmgNumStyle, Animation> m_DmgAnimationDic = new Dictionary<DmgNumStyle, Animation>();

	private bool m_Running;

	private DamageNumberConfig m_Config;

	private Vector3 worldPos;

	private Dictionary<DmgNumStyle, DamageNumberStyle> _styles;

	private DamageNumberStyle _styleNumber;

	private DmgNumStyle _currentActiveStyle;

	private Animation _currentAnimation;

	private bool _hasActiveStyle;

	private void Awake()
	{
		_styles = new Dictionary<DmgNumStyle, DamageNumberStyle>();
		for (int i = 0; i < dmgTypes.Length; i++)
		{
			DamageNumberStyle component = dmgObjects[i].GetComponent<DamageNumberStyle>();
			if (!(component == null))
			{
				_styles[dmgTypes[i]] = component;
				m_DmgAnimationDic[dmgTypes[i]] = dmgObjects[i].GetComponent<Animation>();
			}
		}
	}

	public bool Evaluate(float dt)
	{
		return m_Running;
	}

	public void LateUpdate()
	{
		transform.position = WorldToScreenPoint(worldPos);
	}

	public void OnSpawn(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		m_Running = true;
		m_Config = config;
		worldPos = GetDamageNumberPosition(config, cmd);
		transform.localScale = new Vector3(config.mobileSize, config.mobileSize, 1f);
		if (config.entityScale.TryGetValue(cmd.entityType, out var value))
		{
			transform.localScale *= value;
		}
		transform.position = WorldToScreenPoint(worldPos);
		InitStyle(cmd);
	}

	public void OnDespawn()
	{
		m_Running = false;
		_currentAnimation?.Stop();
		_currentAnimation?.Rewind();
	}

	private void InitStyle(CmdDamageNumber cmd)
	{
		DmgNumStyle dmgNumStyle = GetDmgNumStyle(cmd);
		if (!_hasActiveStyle || _currentActiveStyle != dmgNumStyle)
		{
			if (_hasActiveStyle && _styles.TryGetValue(_currentActiveStyle, out var value))
			{
				value.gameObject.SetActive(value: false);
			}
			if (_styles.TryGetValue(dmgNumStyle, out var value2))
			{
				value2.gameObject.SetActive(value: true);
				_styleNumber = value2;
			}
			_currentActiveStyle = dmgNumStyle;
			_hasActiveStyle = true;
		}
		else
		{
			_styleNumber = _styles[dmgNumStyle];
		}
		if (_styleNumber == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"伤害数字找不到style 配置{dmgNumStyle}");
			}
			return;
		}
		if (_styleNumber == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"伤害数字找不到style配置{dmgNumStyle}");
			}
			return;
		}
		_styleNumber.Init(cmd, m_Config);
		_currentAnimation = null;
		if (m_DmgAnimationDic.TryGetValue(dmgNumStyle, out _currentAnimation) && m_Config.TryGetStyleAnimation(dmgNumStyle, out var _))
		{
			_currentAnimation.Play();
		}
	}

	private void Update()
	{
		if (m_Running && _currentAnimation != null && !_currentAnimation.isPlaying)
		{
			m_Running = false;
		}
	}

	private DmgNumStyle GetDmgNumStyle(CmdDamageNumber damageNumber)
	{
		return damageNumber.damageFeature switch
		{
			DamageFeature.Damage => (damageNumber.entityType != EntityType.Character) ? (damageNumber.critical ? DmgNumStyle.Critical : DmgNumStyle.Normal) : DmgNumStyle.Normal, 
			DamageFeature.Heal => DmgNumStyle.Heal, 
			DamageFeature.HpRemoval => DmgNumStyle.Normal, 
			DamageFeature.Sacrifice => DmgNumStyle.Sacrifice, 
			DamageFeature.Dot => damageNumber.critical ? DmgNumStyle.DotCritical : DmgNumStyle.Dot, 
			DamageFeature.Manner => (damageNumber.entityType != EntityType.Character) ? (damageNumber.critical ? DmgNumStyle.Critical : DmgNumStyle.Manner) : DmgNumStyle.Normal, 
			DamageFeature.Sprint => DmgNumStyle.Sprint, 
			DamageFeature.Resistance => DmgNumStyle.Resistance, 
			DamageFeature.Block => DmgNumStyle.Block, 
			DamageFeature.Deflect => DmgNumStyle.Deflect, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	private Vector3 GetRandomWorldPos(Vector3 pos, bool isLeft)
	{
		float num = UnityEngine.Random.Range(0f, m_Config.randomOffsetX);
		float y = UnityEngine.Random.Range(0f - m_Config.randomOffsetY, m_Config.randomOffsetY);
		if (isLeft)
		{
			num = 0f - num;
		}
		Vector3 vector = new Vector3(num, y, 0f);
		return pos + vector;
	}

	public Vector3 GetDamageNumberPosition(DamageNumberConfig config, CmdDamageNumber cmd)
	{
		MonsterWeigtType type = cmd.monsterWeigtType;
		if (cmd.damageFeature == DamageFeature.Dot)
		{
			Vector3 pos = cmd.entityPos + new Vector3(0f, cmd.entitySize.y, 0f);
			return config.deBuffPositionConfig.GetPosition(pos, cmd.faceLeft);
		}
		if (cmd.damageFeature == DamageFeature.Heal)
		{
			Vector3 entityPos = cmd.entityPos;
			return config.buffPositionConfig.GetPosition(entityPos, cmd.faceLeft);
		}
		if (cmd.entityType == EntityType.Character)
		{
			type = MonsterWeigtType.Normal;
		}
		if (cmd.useMonsterType && config.TryGetNormalPositionConfigs(type, out var config2))
		{
			Vector3 pos2 = cmd.entityPos + new Vector3(cmd.faceLeft ? (0f - cmd.entitySize.x) : cmd.entitySize.x, cmd.entitySize.y, 0f);
			return config2.GetPosition(pos2, cmd.faceLeft);
		}
		return GetRandomWorldPos(cmd.pos, cmd.faceLeft);
	}

	private static Vector3 WorldToScreenPoint(Vector3 worldPos)
	{
		Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(worldPos);
		RectTransformUtility.ScreenPointToWorldPointInRectangle(GameUtility.uiCanvas.GetComponent<RectTransform>(), new Vector2(vector.x, vector.y), GameUtility.uiCamera, out var worldPoint);
		return worldPoint;
	}
}
