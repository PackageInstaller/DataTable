using System;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameEnemy : BilliardGameBehaviorBase
{
	public int enemyID;

	private const float arrowRadius = 0.7f;

	public GameObject shootPredictGo;

	public GameObject circlePredictGo;

	[HideInInspector]
	public GameObject attackPredictGo;

	private GameObject attackEffectGo;

	private SpriteRenderer attackPredicSprite;

	[HideInInspector]
	public GameObject chargedPredictGo;

	private GameObject chargedEffectGo;

	[HideInInspector]
	public Collider2D col;

	[HideInInspector]
	public BilliardGameEffect effect;

	protected SkeletonAnimation roleSpine;

	private Spine.AnimationState.TrackEntryDelegate roleAnimCompleteHandler;

	private Spine.AnimationState.TrackEntryDelegate roleAnimEndHandler;

	public Transform barPosTrs;

	[HideInInspector]
	public Transform buffPredictTrs;

	public void Awake()
	{
		Init();
	}

	public override void Init()
	{
		base.Init();
		roleSpine = GetComponent<SkeletonAnimation>();
		if (roleSpine != null)
		{
			roleAnimCompleteHandler = delegate
			{
				roleSpine.AnimationState.SetAnimation(0, "idle", loop: false);
			};
			roleSpine.AnimationState.Complete += roleAnimCompleteHandler;
		}
		col = GetComponent<Collider2D>();
		attackPredictGo = base.transform.Find("billiardEnemyBase/PredictAttack").gameObject;
		chargedPredictGo = base.transform.Find("billiardEnemyBase/PredictCharge").gameObject;
		if (!BilliardGameDataManager.IsBallGame())
		{
			attackPredictGo.SetActive(value: false);
			chargedPredictGo.SetActive(value: false);
			attackPredicSprite = attackPredictGo.GetComponent<SpriteRenderer>();
			attackPredicSprite.enabled = false;
			attackEffectGo = attackPredictGo.transform.Find("monster_charge_2").gameObject;
			chargedEffectGo = chargedPredictGo.transform.Find("monster_charge_1").gameObject;
			buffPredictTrs = base.transform.Find("billiardEnemyBase/PredictAttack");
		}
	}

	public override void Dispose()
	{
		base.Dispose();
		if (roleSpine != null)
		{
			roleSpine.AnimationState.Complete -= roleAnimCompleteHandler;
			roleSpine.AnimationState.End -= roleAnimEndHandler;
		}
	}

	public void ChangeAniState(string stateName, bool isLoop, Action callback = null)
	{
		if (null == roleSpine)
		{
			return;
		}
		roleSpine.AnimationState.SetAnimation(0, stateName, isLoop);
		roleSpine.AnimationState.End -= roleAnimEndHandler;
		if (callback == null)
		{
			return;
		}
		roleAnimEndHandler = delegate
		{
			if (roleSpine.AnimationName == stateName)
			{
				callback();
			}
		};
		roleSpine.AnimationState.End += roleAnimEndHandler;
	}

	public void BeforeAttackPredictShoot(Vector3 dir, int num, int bulletAngle)
	{
		shootPredictGo.SetActive(value: true);
		circlePredictGo.SetActive(value: false);
		float num2 = Vector3.SignedAngle(Vector3.up, -dir, Vector3.forward);
		Vector3 vector = new Vector3(0.7f * Mathf.Cos((num2 + 270f) * MathF.PI / 180f), 0.7f * Mathf.Sin((num2 + 270f) * MathF.PI / 180f));
		shootPredictGo.transform.localEulerAngles = new Vector3(0f, 0f, num2 - 90f);
		shootPredictGo.transform.position = vector + base.transform.position;
	}

	public void BeforeAttackPredictAoe(float radius)
	{
		shootPredictGo.SetActive(value: false);
		circlePredictGo.SetActive(value: true);
		circlePredictGo.transform.localScale = new Vector3(radius / 2.3f, radius / 2.3f, 1f);
	}

	public void ClearAttackPredict()
	{
		shootPredictGo.SetActive(value: false);
		circlePredictGo.SetActive(value: false);
	}

	public void ShowPredictZone()
	{
		attackPredictGo.SetActive(value: true);
	}

	public void ShowCirclePredictZone(float radius)
	{
		attackPredictGo.SetActive(value: true);
	}

	public bool HidePredict()
	{
		bool activeSelf = attackPredictGo.activeSelf;
		attackPredictGo.SetActive(value: false);
		return activeSelf;
	}

	public void ShowChargedPredict(int chargedNum)
	{
		if (chargedNum <= 0)
		{
			attackPredictGo.SetActive(value: false);
			chargedPredictGo.SetActive(value: false);
		}
		else if (chargedNum <= 1)
		{
			attackPredictGo.SetActive(value: true);
			chargedPredictGo.SetActive(value: false);
			attackEffectGo.SetActive(value: true);
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				attackEffectGo.SetActive(value: false);
				attackPredicSprite.enabled = true;
			}, 1f, 1);
		}
		else
		{
			attackPredictGo.SetActive(value: false);
			chargedPredictGo.SetActive(value: true);
			chargedEffectGo.SetActive(value: true);
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				chargedEffectGo.SetActive(value: false);
			}, 1f, 1);
		}
	}

	public Collider2D GetEnemyCol()
	{
		return col;
	}
}
