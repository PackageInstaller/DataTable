#define LOG_ERROR
using System.Collections;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_释放额外区域效果")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_GenerateAreaEffectComponent : AreaEffect_Component
{
	public GameObject areaEffectPrefab;

	public TSVector2 genPositionOffset;

	public FP genRotationOffset;

	public bool genBegin;

	public FP genBeginDelay;

	public bool genEveryWhile;

	public FP genInterval;

	public bool genFinish;

	[Space]
	public bool genEnter;

	public FP genEnterDelay;

	public bool genExit;

	public FP genExitDelay;

	public TargetFilterCriteriaInfo criteriaInfo;

	[Space]
	public bool finishGen;

	private CoroutineNode _genAreaEffectCor_Begin;

	private CoroutineNode _genAreaEffectCor_EveryWhile;

	private CoroutineNode _genAreaEffectCor_Enter;

	private CoroutineNode _genAreaEffectCor_Exit;

	protected override bool ShowCheckTag
	{
		get
		{
			if (!genEnter)
			{
				return genExit;
			}
			return true;
		}
	}

	protected override void OnStartLogic()
	{
		base.OnStartLogic();
		if (genBegin)
		{
			if (genBeginDelay > 0)
			{
				_genAreaEffectCor_Begin = _context.StartLogicCoroutine(DelayGenAreaEffectCor(genBeginDelay));
			}
			else
			{
				PlayAreaEffect();
			}
		}
		if (genEveryWhile)
		{
			if (genInterval > 0)
			{
				_genAreaEffectCor_EveryWhile = _context.StartLogicCoroutine(IntervalGenAreaEffectCor(genInterval));
			}
			else
			{
				NovaLogger.Error($"释放额外区域效果释放间隔时间配置有误,当前值:{genInterval}");
			}
		}
	}

	private IEnumerator DelayGenAreaEffectCor(FP delayTime)
	{
		FP lastDelayTime = delayTime;
		while (lastDelayTime > 0)
		{
			lastDelayTime -= _context.LogicDeltaTime;
			yield return null;
		}
		PlayAreaEffect();
	}

	private IEnumerator IntervalGenAreaEffectCor(FP intervalTime)
	{
		FP interval = intervalTime;
		while (interval > 0)
		{
			interval -= _context.LogicDeltaTime;
			if (interval <= 0)
			{
				PlayAreaEffect();
				interval += intervalTime;
			}
			yield return null;
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		if (genFinish)
		{
			PlayAreaEffect();
		}
		if (_genAreaEffectCor_Begin != null)
		{
			_context.StopLogicCoroutine(_genAreaEffectCor_Begin);
		}
		_genAreaEffectCor_Begin = null;
		if (_genAreaEffectCor_EveryWhile != null)
		{
			_context.StopLogicCoroutine(_genAreaEffectCor_EveryWhile);
		}
		_genAreaEffectCor_EveryWhile = null;
		if (_genAreaEffectCor_Enter != null)
		{
			_context.StopLogicCoroutine(_genAreaEffectCor_Enter);
		}
		_genAreaEffectCor_Enter = null;
		if (_genAreaEffectCor_Exit != null)
		{
			_context.StopLogicCoroutine(_genAreaEffectCor_Exit);
		}
		_genAreaEffectCor_Exit = null;
	}

	protected void PlayAreaEffect()
	{
		if (!(areaEffectPrefab == null))
		{
			TSVector2 tSVector = _context.tsTransform.Position + _context.tsTransform.Left * genPositionOffset.x + _context.tsTransform.Forward * genPositionOffset.y;
			Vector3 spawnPosition = new Vector3(tSVector.x.AsFloat(), _context.transform.position.y, tSVector.y.AsFloat());
			FP fP = _context.tsTransform.Rotation + genRotationOffset;
			Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)fP, 0f);
			SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(_owner, areaEffectPrefab, spawnPosition, spawnRotation);
			if (finishGen)
			{
				FinishAreaEffect = true;
			}
		}
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (genEnter && _context.CheckTarget(entity, criteriaInfo))
		{
			if (genEnterDelay > 0)
			{
				_genAreaEffectCor_Enter = _context.StartLogicCoroutine(DelayGenAreaEffectCor(genEnterDelay));
			}
			else
			{
				PlayAreaEffect();
			}
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		if (genExit && _context.CheckTarget(entity, criteriaInfo))
		{
			if (genExitDelay > 0)
			{
				_genAreaEffectCor_Exit = _context.StartLogicCoroutine(DelayGenAreaEffectCor(genExitDelay));
			}
			else
			{
				PlayAreaEffect();
			}
		}
	}
}
