using System.Collections.Generic;
using Lockstep.Core;
using UnityEngine;

namespace Ase.ECS;

public class AnimatorComponent : BaseComponent
{
	private Animator[] animatorArray;

	private float[] animatorSpeed;

	private Animator _animator;

	private float defaultSpeed;

	private bool _isAnimatorNull = true;

	private Dictionary<string, object> _animatorDefaultParam = new Dictionary<string, object>();

	private float animatorFixSpeed = 1f;

	private GameObject _rootAnimator;

	private int _disPlayFps;

	public float AnimatorFixSpeed => animatorFixSpeed;

	public Animator Animator => _animator;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_rootAnimator = mBaseEntity.GetComponent<EntityBoneComponent>()?.GetBoneRoot("root")?.gameObject;
	}

	public void RegisterAnimator(Animator anim)
	{
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Expected I4, but got Unknown
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Invalid comparison between Unknown and I4
		if ((Object)(object)anim == null || (Object)(object)anim.runtimeAnimatorController == null)
		{
			return;
		}
		animatorFixSpeed = 1f;
		_animator = anim;
		defaultSpeed = anim.speed;
		_isAnimatorNull = (Object)(object)_animator == null;
		_animatorDefaultParam.Clear();
		AnimatorControllerParameter[] parameters = _animator.parameters;
		foreach (AnimatorControllerParameter val in parameters)
		{
			AnimatorControllerParameterType type = val.type;
			switch (type - 1)
			{
			case 3:
				_animatorDefaultParam.Add(val.name, val.defaultBool);
				continue;
			case 0:
				_animatorDefaultParam.Add(val.name, val.defaultFloat);
				continue;
			case 2:
				_animatorDefaultParam.Add(val.name, val.defaultInt);
				continue;
			case 1:
				continue;
			}
			if ((int)type == 9)
			{
				_animatorDefaultParam.Add(val.name, 0);
			}
		}
		if ((Object)(object)_animator != null)
		{
			_animator.Rebind();
		}
	}

	public void RegisterChildAnimator(Animator[] animators)
	{
		animatorArray = animators;
		animatorSpeed = new float[animatorArray.Length];
		for (int i = 0; i < animatorArray.Length; i++)
		{
			animatorSpeed[i] = animatorArray[i].speed;
		}
	}

	public override void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(isFrozen, isFrozenLogic);
		SetAnimatorSpeed(mBaseEntity.FinalSpeed);
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.speed = mBaseEntity.FinalSpeed * defaultSpeed * animatorFixSpeed;
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		SetAnimatorSpeed(0f);
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.speed = 0f;
		}
	}

	public override void OnResume()
	{
		base.OnResume();
		SetAnimatorSpeed(mBaseEntity.FinalSpeed);
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.speed = mBaseEntity.FinalSpeed * defaultSpeed * animatorFixSpeed;
		}
	}

	public override void OnGameSpeedChanged(float gameSpeed)
	{
		base.OnGameSpeedChanged(gameSpeed);
		SetAnimatorSpeed(mBaseEntity.FinalSpeed);
		if (!((Object)(object)_animator == null) && mBaseEntity != null)
		{
			_animator.speed = mBaseEntity.FinalSpeed * defaultSpeed * animatorFixSpeed;
		}
	}

	private void SetAnimatorSpeed(float speed)
	{
		if (animatorArray == null)
		{
			return;
		}
		for (int i = 0; i < animatorArray.Length; i++)
		{
			if ((Object)(object)animatorArray[i] != null)
			{
				animatorArray[i].speed = animatorSpeed[i] * speed * animatorFixSpeed;
			}
		}
	}

	public void SetAnimatorFixSpeed(float speed = 1f)
	{
		animatorFixSpeed = speed;
		SetAnimatorSpeed(mBaseEntity.FinalSpeed);
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.speed = mBaseEntity.FinalSpeed * defaultSpeed * animatorFixSpeed;
		}
	}

	public int GetStateHash(int layerIndex = 0, bool isShort = false)
	{
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		if (_isAnimatorNull || (Object)(object)_animator == null)
		{
			return 0;
		}
		AnimatorStateInfo currentAnimatorStateInfo = _animator.GetCurrentAnimatorStateInfo(layerIndex);
		if (!isShort)
		{
			return ((AnimatorStateInfo)(ref currentAnimatorStateInfo)).fullPathHash;
		}
		return ((AnimatorStateInfo)(ref currentAnimatorStateInfo)).shortNameHash;
	}

	public AnimationClip GetCurAnimatorClipInfo()
	{
		if ((Object)(object)_animator.runtimeAnimatorController == null)
		{
			return null;
		}
		AnimatorClipInfo[] currentAnimatorClipInfo = _animator.GetCurrentAnimatorClipInfo(0);
		if (currentAnimatorClipInfo.Length != 0)
		{
			return ((AnimatorClipInfo)(ref currentAnimatorClipInfo[0])).clip;
		}
		return null;
	}

	public void PlayAnimation(string animation, int layer = -1, float normalizedTime = float.NegativeInfinity)
	{
		int animationHashCode = Animator.StringToHash(animation);
		PlayAnimation(animationHashCode, layer, normalizedTime);
	}

	public void PlayCrossFadeAnimation(string animation, int layer = -1, float normalizedTransitionDuration = 0.2f, float normalizedTimeOffset = 0f)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.CrossFade(animation, normalizedTransitionDuration, layer, normalizedTimeOffset);
		}
	}

	public void PlayCrossFadeAnimationFixedTime(string animation, float time = 0f, int layer = -1, float normalizedTimeOffset = 0f)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.CrossFadeInFixedTime(animation, time, layer, normalizedTimeOffset);
		}
	}

	private void PlayAnimation(int animationHashCode, int layer = -1, float normalizedTime = float.NegativeInfinity)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.Play(animationHashCode, layer, normalizedTime);
		}
	}

	public void PlayAnimation(AnimationClip clip, float time)
	{
		if (!((Object)(object)clip == null) && !(_rootAnimator == null))
		{
			clip.SampleAnimation(_rootAnimator, time);
		}
	}

	public void SetInteger(string paramKey, int paramValue)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetInteger(paramKey, paramValue);
		}
	}

	public void SetFloat(string paramKey, float paramValue)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetFloat(paramKey, paramValue);
		}
	}

	public void SetBool(string paramKey, bool paramValue)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetBool(paramKey, paramValue);
		}
	}

	public void SetTrigger(string triggerName)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetTrigger(triggerName);
		}
	}

	public void SetInteger(int hash, int value)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetInteger(hash, value);
		}
	}

	public void SetBool(int hash, bool value)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetBool(hash, value);
		}
	}

	public void SetFloat(int hash, float value)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetFloat(hash, value);
		}
	}

	public void SetTrigger(int hash)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetTrigger(hash);
		}
	}

	public void SetLayersWeight(int layerValue, float weight)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.SetLayerWeight(layerValue, weight);
		}
	}

	public void SetSpeed(float speed)
	{
		if (!_isAnimatorNull && !((Object)(object)_animator == null))
		{
			_animator.speed = speed;
		}
	}

	public float GetLayerWeight(int layerValue)
	{
		if (_isAnimatorNull || (Object)(object)_animator == null)
		{
			return 0f;
		}
		return _animator.GetLayerWeight(layerValue);
	}

	public void ResetAnimatorDefaultParam()
	{
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Expected I4, but got Unknown
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Invalid comparison between Unknown and I4
		if (_isAnimatorNull || (Object)(object)_animator == null)
		{
			return;
		}
		AnimatorControllerParameter[] parameters = _animator.parameters;
		foreach (AnimatorControllerParameter val in parameters)
		{
			if (!_animatorDefaultParam.ContainsKey(val.name))
			{
				continue;
			}
			AnimatorControllerParameterType type = val.type;
			switch (type - 1)
			{
			case 3:
				_animator.SetBool(val.name, _animatorDefaultParam[val.name].ToBool());
				continue;
			case 0:
				_animator.SetFloat(val.name, _animatorDefaultParam[val.name].ToFloat());
				continue;
			case 2:
				_animator.SetInteger(val.name, _animatorDefaultParam[val.name].ToInt());
				continue;
			case 1:
				continue;
			}
			if ((int)type == 9)
			{
				_animator.ResetTrigger(val.name);
			}
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		base.Entity.GetSystem<FrameFrozenSystem>()?.StateBreakEntityFrozenFrame(base.Entity, isStateBreak: false);
	}

	public override void OnDispose()
	{
		if ((Object)(object)_animator != null)
		{
			_animator.speed = defaultSpeed;
			_animator = null;
		}
		if (animatorArray != null)
		{
			SetAnimatorSpeed(1f);
		}
		animatorFixSpeed = 1f;
		_isAnimatorNull = true;
		_animatorDefaultParam.Clear();
		_animatorDefaultParam = null;
		base.OnDispose();
	}
}
