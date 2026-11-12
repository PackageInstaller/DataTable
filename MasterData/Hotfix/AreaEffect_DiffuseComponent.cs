using System;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_扩散")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_DiffuseComponent : AreaEffect_Component
{
	public enum EdgeDiffuseType
	{
		Default,
		SameRatio,
		OnlyLength,
		OnlyWidth
	}

	public enum InnerRadiusDiffuseType
	{
		SyncRadius,
		SameSpeed
	}

	public FP speed = 0;

	public FP interval = 1;

	public FP delayDiffuseTime = 0;

	public FP maxDiffuseTime = 1;

	public bool changeSpeed;

	public FP delay_Change = 0;

	public FP speed_Change = 0;

	public EdgeDiffuseType edgeDiffuseType = EdgeDiffuseType.SameRatio;

	public bool radiusTogether;

	public InnerRadiusDiffuseType innerRadiusDiffuseType;

	protected FP _curDiffuseSpeed;

	protected FP _diffuseTime;

	protected FP _delayDiffuseTime;

	protected FP _maxDiffuseTime;

	protected FP _defaultWidth;

	protected FP _defaultLength;

	protected FP _defaultRadius;

	protected FP _defaultInnerRadius;

	protected override bool ShowCheckTag => false;

	protected override void OnSetup()
	{
		base.OnSetup();
		_curDiffuseSpeed = speed;
		_diffuseTime = interval;
		_delayDiffuseTime = delayDiffuseTime;
		_maxDiffuseTime = maxDiffuseTime;
		_defaultWidth = _context.hitBoxWidth;
		_defaultLength = _context.hitBoxLength;
		_defaultRadius = _context.hitBoxRadius;
		_defaultInnerRadius = _context.hitBoxInnerRadius;
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (_delayDiffuseTime > 0)
		{
			_delayDiffuseTime -= logicDeltaTime;
		}
		else
		{
			if (_maxDiffuseTime <= 0)
			{
				return;
			}
			if (interval > 0)
			{
				_diffuseTime -= logicDeltaTime;
				if (_diffuseTime <= 0)
				{
					switch (_context.hitBoxShape)
					{
					case HitBox.Shape.Rectangle:
						switch (edgeDiffuseType)
						{
						case EdgeDiffuseType.Default:
							_context.hitBoxWidth += _curDiffuseSpeed;
							_context.hitBoxLength += _curDiffuseSpeed;
							break;
						case EdgeDiffuseType.SameRatio:
						{
							FP fP = _curDiffuseSpeed;
							if (_context.hitBoxLength > 0)
							{
								fP = _curDiffuseSpeed * (_context.hitBoxWidth / _context.hitBoxLength);
							}
							_context.hitBoxWidth += fP;
							_context.hitBoxLength += _curDiffuseSpeed;
							break;
						}
						case EdgeDiffuseType.OnlyLength:
							_context.hitBoxLength += _curDiffuseSpeed;
							break;
						case EdgeDiffuseType.OnlyWidth:
							_context.hitBoxWidth += _curDiffuseSpeed;
							break;
						default:
							throw new ArgumentOutOfRangeException();
						}
						break;
					case HitBox.Shape.Circle:
					case HitBox.Shape.Fan:
						if (radiusTogether)
						{
							switch (innerRadiusDiffuseType)
							{
							case InnerRadiusDiffuseType.SyncRadius:
								_context.hitBoxInnerRadius = _context.hitBoxRadius;
								break;
							case InnerRadiusDiffuseType.SameSpeed:
								_context.hitBoxInnerRadius += _curDiffuseSpeed;
								break;
							default:
								throw new ArgumentOutOfRangeException();
							}
							if (_context.hitBoxInnerRadius <= 0)
							{
								_context.hitBoxInnerRadius = 0;
							}
						}
						_context.hitBoxRadius += _curDiffuseSpeed;
						if (_context.hitBoxRadius <= 0)
						{
							_context.hitBoxRadius = 0;
						}
						break;
					default:
						throw new ArgumentOutOfRangeException();
					}
					_diffuseTime = interval;
				}
				if (_context.canBeHit)
				{
					_context.UpdateColliderShape();
				}
			}
			if (changeSpeed && maxDiffuseTime - _maxDiffuseTime >= delay_Change)
			{
				_curDiffuseSpeed = speed_Change;
				if (_curDiffuseSpeed < 0)
				{
					DispatchEvent();
				}
			}
			_maxDiffuseTime -= logicDeltaTime;
			if (_maxDiffuseTime <= logicDeltaTime && _curDiffuseSpeed > 0)
			{
				DispatchEvent();
			}
		}
	}

	private void DispatchEvent()
	{
		AdventureAreaEffectDiffuseEvent adventureAreaEffectDiffuseEvent = AdventureAreaEffectDiffuseEvent.Generate();
		adventureAreaEffectDiffuseEvent.sender = this;
		adventureAreaEffectDiffuseEvent.entityID = Entity.Id;
		adventureAreaEffectDiffuseEvent.iDiffuseMax = true;
		adventureAreaEffectDiffuseEvent.pos = Entity.transform.position;
		adventureAreaEffectDiffuseEvent.hitBoxRadius = _context.hitBoxRadius;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAreaEffectDiffuseEvent);
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		if (!(_context == null))
		{
			_context.hitBoxWidth = _defaultWidth;
			_context.hitBoxLength = _defaultLength;
			_context.hitBoxRadius = _defaultRadius;
			_context.hitBoxInnerRadius = _defaultInnerRadius;
			if (_context.canBeHit)
			{
				_context.UpdateColliderShape();
			}
		}
	}
}
