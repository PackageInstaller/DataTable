using ControllerExSpace;
using Pinball.Runtime;
using UnityEngine;

namespace Pinball;

public abstract class BallPolygon
{
	protected int uniqueId;

	protected GameObject go;

	protected PolygonType pType;

	protected PolygonType convertType;

	protected int remainHp;

	protected float moveProgress;

	protected int currentPathIndex;

	protected bool isMovingBack;

	protected BlockPathData pathData;

	protected SpriteRenderer iconSr;

	protected TextMesh hpText;

	protected TextMesh outline;

	protected GameObject protectEffectGo;

	protected GameObject affectEffectGo;

	protected GameObject affectedEffectGo;

	protected ParticleSystem affectPs;

	protected ParticleSystem affectingPs;

	protected ParticleSystem affectingToaffecedPs;

	protected ParticleSystem affectedPs;

	protected GameObject effectSelectGo;

	protected ParticleSystem effectHitPs;

	protected ParticleSystem effectChangePs;

	protected ParticleSystem effectBreakPs;

	protected ParticleSystem effectTailPs;

	protected ParticleSystem effectBirthPs;

	private Transform effectTailTrs;

	protected int breakTimer;

	private float breakCurveSeconds;

	private float breakCurveDuration = 0.8f;

	private Vector3 curvePoint1;

	private Vector3 curvePoint2;

	private Vector3 curvePoint3;

	private Vector3 curvePoint4;

	public int vertexCount;

	protected Vector2[] vertex;

	protected Vector2[] normal;

	protected ControllerExCollection uiProtectControllerEx;

	protected ControllerEx curProtectControllerEx;

	protected float[] param;

	protected Vector2 mLocalPosition;

	protected Vector2 mPosition;

	public int removeBuffTrigger;

	public BlockPathData GetPathData()
	{
		return pathData;
	}

	public PolygonType GetConvertType()
	{
		return convertType;
	}

	public BallPolygon(int uniqueId, GameObject go, Vector2 pos, int remain, PolygonType type)
	{
		this.uniqueId = uniqueId;
		this.go = go;
		pType = type;
		remainHp = remain;
		mLocalPosition = pos;
		mPosition = mLocalPosition;
	}

	public virtual void Release()
	{
		if (go != null)
		{
			BlockPool.Instance.ReturnBlock(go);
			go = null;
		}
		protectEffectGo = null;
		affectEffectGo = null;
		affectedEffectGo = null;
		effectSelectGo = null;
		effectHitPs = null;
		effectChangePs = null;
		effectBreakPs = null;
		effectTailPs = null;
		effectBirthPs = null;
		affectPs = null;
		affectingPs = null;
		affectingToaffecedPs = null;
		affectedPs = null;
		uiProtectControllerEx = null;
		iconSr = null;
		pathData = null;
	}

	public virtual void AdjustVerticesAndNormals()
	{
	}

	public abstract float CheckCollision(Vector2 ballPosition, Vector2 ballVelocity, float ballRadius, out Vector2 newPosition, out Vector2 newVelocity);

	public abstract void OnCollision(Ball ball);

	public abstract int OnRoundAfter();

	protected virtual void BindEffectPs()
	{
		if (!(go == null))
		{
			iconSr = go.transform.Find("Icon").GetComponent<SpriteRenderer>();
			protectEffectGo = go.transform.Find("protect").gameObject;
			affectEffectGo = go.transform.Find("affect/affect_01").gameObject;
			affectedEffectGo = go.transform.Find("affect/affect_02").gameObject;
			effectSelectGo = go.transform.Find("EffectBlockselect").gameObject;
			effectHitPs = go.transform.Find("EffectBlocklight/light").GetComponent<ParticleSystem>();
			effectChangePs = go.transform.Find("EffectBlockchange/di1").GetComponent<ParticleSystem>();
			effectBreakPs = go.transform.Find("EffectBlockboom/di_glo").GetComponent<ParticleSystem>();
			effectTailPs = go.transform.Find("EffectDieparticle/shizi").GetComponent<ParticleSystem>();
			effectBirthPs = go.transform.Find("EffectBlockBirth/di1").GetComponent<ParticleSystem>();
			affectPs = go.transform.Find("affect/EffectBlockInfect/glow_di").GetComponent<ParticleSystem>();
			affectingPs = go.transform.Find("affect/EffectBlockInfect2/xuesi").GetComponent<ParticleSystem>();
			affectingToaffecedPs = go.transform.Find("affect/EffectBlockInfect3/glow_di").GetComponent<ParticleSystem>();
			affectedPs = go.transform.Find("affect/EffectBlockInfect4/di_glo").GetComponent<ParticleSystem>();
			uiProtectControllerEx = go.transform.Find("protect").GetComponent<ControllerExCollection>();
			effectChangePs.Stop();
			effectBreakPs.Stop();
			effectTailPs.Stop();
			effectBirthPs.Stop();
			affectPs.Stop();
			affectingPs.Stop();
			affectedPs.Stop();
			affectingToaffecedPs.Stop();
		}
	}

	public abstract BallPolygon Clone();

	public abstract void TriggerPolygonEffect();

	public abstract void TriggerPolygonEffect(Ball ball);

	public abstract void TriggerPolygonCallBackEffect();

	public void ShowSelectEffect(bool show)
	{
		if (effectSelectGo != null)
		{
			effectSelectGo.SetActive(show);
		}
	}

	public Vector2 GetLocalPosition()
	{
		return mLocalPosition;
	}

	public Vector2 GetPosition()
	{
		if (go != null)
		{
			return go.transform.position;
		}
		return mPosition;
	}

	public virtual void InitMovePath(BlockPathData pathData)
	{
		if (pathData != null && pathData.pathPoints != null && pathData.pathPoints.Count >= 2)
		{
			this.pathData = pathData.Clone();
			moveProgress = 0f;
			currentPathIndex = 0;
			isMovingBack = false;
		}
	}

	public virtual void UpdatePosition(Vector2 pos)
	{
		if (!(go == null))
		{
			go.transform.localPosition = pos;
			mLocalPosition = pos;
			AdjustVerticesAndNormals();
		}
	}

	private void HandleEndBehavior()
	{
		switch (pathData.endBehavior)
		{
		case PathEndBehavior.Return:
			isMovingBack = !isMovingBack;
			break;
		case PathEndBehavior.Teleport:
			currentPathIndex = 0;
			isMovingBack = false;
			break;
		case PathEndBehavior.Stop:
			break;
		}
	}

	public virtual void UpdateMove(float deltaTime)
	{
		if (pathData == null || pathData.pathPoints == null || pathData.pathPoints.Count < 2)
		{
			return;
		}
		float num = deltaTime;
		while (num > 0f)
		{
			Vector2 a = (isMovingBack ? pathData.pathPoints[currentPathIndex + 1] : pathData.pathPoints[currentPathIndex]);
			Vector2 b = (isMovingBack ? pathData.pathPoints[currentPathIndex] : pathData.pathPoints[currentPathIndex + 1]);
			float num2 = Vector2.Distance(a, b);
			if (num2 <= 0f)
			{
				return;
			}
			float num3 = pathData.speed * num;
			float num4 = (1f - moveProgress) * num2;
			if (num3 >= num4)
			{
				float num5 = num4 / pathData.speed;
				num -= num5;
				if (isMovingBack)
				{
					if (currentPathIndex <= 0)
					{
						HandleEndBehavior();
						if (isMovingBack)
						{
							return;
						}
						currentPathIndex = 0;
					}
					else
					{
						currentPathIndex--;
					}
				}
				else if (currentPathIndex >= pathData.pathPoints.Count - 2)
				{
					HandleEndBehavior();
					if (!isMovingBack)
					{
						return;
					}
					currentPathIndex = pathData.pathPoints.Count - 2;
				}
				else
				{
					currentPathIndex++;
				}
				moveProgress = 0f;
			}
			else
			{
				moveProgress += num3 / num2;
				num = 0f;
			}
		}
		Vector2 vector = Vector2.Lerp(isMovingBack ? pathData.pathPoints[currentPathIndex + 1] : pathData.pathPoints[currentPathIndex], isMovingBack ? pathData.pathPoints[currentPathIndex] : pathData.pathPoints[currentPathIndex + 1], moveProgress);
		go.transform.localPosition = vector;
		mLocalPosition = vector;
		mPosition = vector;
		AdjustVerticesAndNormals();
	}

	public virtual void ResetMove()
	{
		moveProgress = 0f;
		currentPathIndex = 0;
		isMovingBack = false;
	}

	public PolygonType GetPType()
	{
		return pType;
	}

	protected void EnterAnim()
	{
		if (convertType == PolygonType.protect)
		{
			go.transform.Find("EffectBlockIce/glow").GetComponent<ParticleSystem>().Play();
		}
		else
		{
			effectBirthPs.Play();
		}
	}

	protected void BreakAnim(bool playerBreak)
	{
		if (!playerBreak)
		{
			return;
		}
		if ((removeBuffTrigger & 1) != 0)
		{
			removeBuffTrigger &= -2;
		}
		else if (effectBreakPs != null && effectTailPs != null)
		{
			effectBreakPs.Play();
			effectTailPs.Play();
		}
		breakTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (go != null && !PinballGameManager.Instance.GMPause)
			{
				BlockPool.Instance.ReturnBlock(go);
				go = null;
			}
			FuncTimerManager.inst.RemoveFuncTimer(breakTimer);
		}, 0.33f, 1);
	}

	public bool HasGameObject()
	{
		return go != null;
	}

	public Vector2[] GetVertex()
	{
		return vertex;
	}

	public Vector2[] GetNormal()
	{
		return normal;
	}

	public int GetRemainHp()
	{
		return remainHp;
	}

	public int GetUniqueId()
	{
		return uniqueId;
	}
}
