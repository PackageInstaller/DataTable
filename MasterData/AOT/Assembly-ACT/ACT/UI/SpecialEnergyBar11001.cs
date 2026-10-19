using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar11001 : SpecialEnergyBar
{
	[SerializeField]
	private Image _energyFill;

	[SerializeField]
	private TextMeshProUGUI _energyText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string Normal = "Normal";

	private const string Fill = "Fill";

	private const string ExModeEnter = "ExModeEnter";

	private const string OverLoop = "OverLoop";

	private const string AbilityFillBuffName = "Role_10_01_BladeSigils";

	private const string ExModeParam = "ExMode";

	private bool b_ExMode;

	private bool b_EnergyFill;

	private float lastDuration;

	private bool overLooped;

	private bool _waitResetOverLooped;

	private int _resetOverLoopedFrame;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		lastDuration = 0f;
		b_EnergyFill = RefreshBuff(entity);
		b_ExMode = RefreshExMode(entity);
		if (b_EnergyFill && !b_ExMode)
		{
			_betterAnimation.GetSequence("Normal").Play();
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_10_01_BladeSigils")
		{
			b_EnergyFill = false;
			_energyFill.fillAmount = 0f;
			overLooped = false;
			if (!RefreshExMode(abilityRemoveEvt.originalOwner, isRemove: true))
			{
				_betterAnimation.GetSequence("Normal").Play();
			}
		}
	}

	public override void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
		if (abilityStackChangeEvt.abilityName == "Role_10_01_BladeSigils")
		{
			int curStack = abilityStackChangeEvt.curStack;
			int maxStack = abilityStackChangeEvt.maxStack;
			if (curStack >= maxStack)
			{
				_betterAnimation.GetSequence("Fill").Play();
			}
			RefreshBuffBar(curStack, maxStack);
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (!(abilityDurationChangeEvt.abilityName == "Role_10_01_BladeSigils"))
		{
			return;
		}
		if (abilityDurationChangeEvt.curDuration <= 4f && !overLooped)
		{
			overLooped = true;
			_betterAnimation.GetSequence("OverLoop").Play();
		}
		if (abilityDurationChangeEvt.curDuration > lastDuration && lastDuration <= 4f)
		{
			overLooped = false;
			if (!RefreshExMode(abilityDurationChangeEvt.entity))
			{
				_betterAnimation.GetSequence("Normal").Play();
			}
			_energyFill.color = new Color(1f, 1f, 1f, 1f);
		}
		lastDuration = abilityDurationChangeEvt.curDuration;
	}

	public override void OnBoolParamChange(MotionBoolParamChangeEvt evt)
	{
		if (evt.name == "ExMode")
		{
			b_ExMode = evt.value;
			if (evt.value)
			{
				_waitResetOverLooped = false;
				_betterAnimation.GetSequence("ExModeEnter").Play();
			}
			else
			{
				_betterAnimation.GetSequence("Normal").Play();
				_waitResetOverLooped = true;
				_resetOverLoopedFrame = Time.frameCount + 1;
			}
		}
	}

	private void Update()
	{
		if (_waitResetOverLooped && Time.frameCount >= _resetOverLoopedFrame)
		{
			_waitResetOverLooped = false;
			if (!b_ExMode)
			{
				overLooped = false;
			}
		}
	}

	private bool RefreshBuff(Entity entity)
	{
		Ability abilityByName = entity.GetCompAbility().GetAbilityByName("Role_10_01_BladeSigils");
		if (abilityByName != null)
		{
			int stack = abilityByName.stack;
			int maxStack = abilityByName.maxStack;
			b_EnergyFill = stack >= maxStack;
			RefreshBuffBar(stack, maxStack);
		}
		else
		{
			RefreshBuffBar(0, 1);
		}
		return b_EnergyFill;
	}

	private void RefreshBuffBar(int curStack, int maxStack)
	{
		_energyFill.fillAmount = (float)curStack / (float)maxStack;
		if (curStack == 0)
		{
			_energyText.SetText(string.Empty);
		}
		else
		{
			_energyText.SetText("{0:0}", curStack);
		}
	}

	private bool RefreshExMode(Entity entity, bool isRemove = false)
	{
		CompMotion compMotion = entity.GetCompMotion();
		if (compMotion == null)
		{
			return b_ExMode;
		}
		if (compMotion.parameters.TryGetValue("ExMode", out var value))
		{
			b_ExMode = value.defaultBool;
		}
		if (b_ExMode && !isRemove)
		{
			_betterAnimation.GetSequence("ExModeEnter").Play();
		}
		return b_ExMode;
	}
}
