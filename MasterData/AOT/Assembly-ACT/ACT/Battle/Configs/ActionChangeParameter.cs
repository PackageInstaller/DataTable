using System.Collections.Generic;
using ACT.EventTrack;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改动画状态机参数", "Action", new string[] { "change", "parameter" })]
public class ActionChangeParameter : ConfigAction
{
	public enum CalcEnum
	{
		set,
		add,
		mul
	}

	[Tooltip("?????")]
	public bool isAnimator;

	public bool isEffect;

	[Space]
	[Space]
	public string name;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public ConfigFunction<float> floatFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public int defaultInt;

	public ConfigFunction<float> intFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public bool defaultBool;

	private float realFloat;

	private int realInt;

	public CalcEnum calcEnum;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (type == ConfigAnimParameterType.Float)
		{
			realFloat = ((floatFunction != null) ? floatFunction.Return(memory) : defaultFloat);
		}
		else if (type == ConfigAnimParameterType.Int)
		{
			realInt = ((intFunction != null) ? ((int)intFunction.Return(memory)) : defaultInt);
		}
		TrackFSMChangeEvt evt = EventTrackSolver.Instance.GetEvt<TrackFSMChangeEvt>();
		evt.entity = entity;
		evt.stateName = name;
		EventTrackSolver.Instance.Dispatch(evt);
		if (isAnimator)
		{
			if (!isEffect)
			{
				Animator componentInChildren = entity.GetRoot().GetComponentInChildren<Animator>();
				SetParameter(componentInChildren);
				return;
			}
			if (memory.ability != null)
			{
				ApplyEffectAnimatorParameters(memory.ability.attachEffects);
			}
			if (entity.TryGetCompEffect(out CompEffect component) && component.myEffects != null)
			{
				ApplyEffectAnimatorParameters(component.myEffects);
			}
			return;
		}
		switch (type)
		{
		case ConfigAnimParameterType.Float:
			switch (calcEnum)
			{
			case CalcEnum.set:
				entity.SetFloat(name, realFloat);
				break;
			case CalcEnum.add:
				entity.SetFloat(name, realFloat + entity.GetMotionFloat(name));
				break;
			case CalcEnum.mul:
				entity.SetFloat(name, realFloat * entity.GetMotionFloat(name));
				break;
			}
			break;
		case ConfigAnimParameterType.Int:
			switch (calcEnum)
			{
			case CalcEnum.set:
				entity.SetInt(name, realInt);
				break;
			case CalcEnum.add:
				entity.SetInt(name, realInt + (int)entity.GetMotionInt(name));
				break;
			case CalcEnum.mul:
				entity.SetInt(name, realInt * (int)entity.GetMotionInt(name));
				break;
			}
			break;
		case ConfigAnimParameterType.Bool:
			entity.SetBool(name, defaultBool);
			break;
		case ConfigAnimParameterType.Trigger:
			entity.SetTrigger(name);
			break;
		}
	}

	private void ApplyEffectAnimatorParameters(List<EffectRuntimeItem> effects)
	{
		if (effects == null)
		{
			return;
		}
		for (int i = 0; i < effects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = effects[i];
			if (effectRuntimeItem?.scripts == null)
			{
				continue;
			}
			MonoEffect[] scripts = effectRuntimeItem.scripts;
			for (int j = 0; j < scripts.Length; j++)
			{
				if (scripts[j] is MonoAnimatorEffect monoAnimatorEffect)
				{
					SetParameter(monoAnimatorEffect.ani);
				}
			}
		}
	}

	private void SetParameter(Animator anim)
	{
		if (anim == null)
		{
			return;
		}
		switch (type)
		{
		case ConfigAnimParameterType.Float:
			switch (calcEnum)
			{
			case CalcEnum.set:
				anim.SetFloat(name, realFloat);
				break;
			case CalcEnum.add:
				anim.SetFloat(name, realFloat + anim.GetFloat(name));
				break;
			case CalcEnum.mul:
				anim.SetFloat(name, realFloat * anim.GetFloat(name));
				break;
			}
			break;
		case ConfigAnimParameterType.Int:
			switch (calcEnum)
			{
			case CalcEnum.set:
				anim.SetInteger(name, realInt);
				break;
			case CalcEnum.add:
				anim.SetInteger(name, realInt + anim.GetInteger(name));
				break;
			case CalcEnum.mul:
				anim.SetInteger(name, realInt * anim.GetInteger(name));
				break;
			}
			break;
		case ConfigAnimParameterType.Bool:
			anim.SetBool(name, defaultBool);
			break;
		case ConfigAnimParameterType.Trigger:
			anim.SetTrigger(name);
			break;
		}
	}
}
