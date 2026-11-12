using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_播放特效")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_PlayFxComponent : AreaEffect_Component
{
	public bool loopPlayMode;

	public List<GameObject> fxPrefabList;

	public FP loopPlayDelay = 0;

	public FP loopPlayInterval = 0;

	public FP loopPlaySpeed = 1;

	public bool triggerPlayMode;

	public GameObject triggerFxPrefab;

	public TargetFilterCriteriaInfo triggerCriteriaInfo;

	public bool triggerEnter;

	public bool triggerExit;

	public FP triggerPlayInterval = 0;

	public FP triggerPlaySpeed = 1;

	private int _loopPlayTimes;

	private FP _loopPlayDelay;

	private FP _loopPlayInterval;

	private FP _triggerPlayInterval;

	protected override bool ShowCheckTag => false;

	protected override void OnSetup()
	{
		base.OnSetup();
		_loopPlayTimes = 0;
		_loopPlayDelay = loopPlayDelay;
		_loopPlayInterval = 0;
		_triggerPlayInterval = 0;
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (loopPlayMode)
		{
			if (_loopPlayDelay > 0)
			{
				_loopPlayDelay -= logicDeltaTime;
			}
			else if (_loopPlayInterval > 0)
			{
				_loopPlayInterval -= logicDeltaTime;
			}
			else
			{
				GameObject loopPlayModeFx = GetLoopPlayModeFx();
				if (loopPlayModeFx != null)
				{
					AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(loopPlayModeFx, (_context.logicTimeScale * loopPlaySpeed).AsFloat(), _context.cTrans.position, _context.cTrans.transform.rotation, _context.transform.localScale.x);
					adventureFXPlayer.Bind(gameObject);
					adventureFXPlayer.useCustomInheritOptions = true;
				}
				_loopPlayInterval = loopPlayInterval;
				_loopPlayTimes++;
			}
		}
		if (triggerPlayMode && _triggerPlayInterval > 0)
		{
			_triggerPlayInterval -= logicDeltaTime;
		}
	}

	private GameObject GetLoopPlayModeFx()
	{
		if (fxPrefabList != null && fxPrefabList.Count > 0)
		{
			int index = Math.Clamp(_loopPlayTimes, 0, fxPrefabList.Count - 1);
			return fxPrefabList.get_Item(index);
		}
		return null;
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		CheckTriggerPlay(triggerEnter, entity);
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		CheckTriggerPlay(triggerExit, entity);
	}

	private void CheckTriggerPlay(bool triggerType, LogicEntity target)
	{
		if (triggerPlayMode && !(_triggerPlayInterval > 0) && triggerType && target is AdventureActor target2 && _context.CheckTarget(target2, triggerCriteriaInfo))
		{
			if (triggerFxPrefab != null)
			{
				FP fP = _context.logicTimeScale * triggerPlaySpeed;
				AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(triggerFxPrefab, fP.AsFloat(), _context.cTrans.position, _context.cTrans.transform.rotation, _context.transform.localScale.x);
				adventureFXPlayer.Bind(gameObject);
				adventureFXPlayer.useCustomInheritOptions = true;
			}
			_triggerPlayInterval = triggerPlayInterval;
		}
	}
}
