using System;
using System.Collections.Generic;
using BilliardGame.Spell;
using LuaInterface;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameBall : BilliardGameBehaviorBase
{
	protected Vector3 shootInfo;

	protected Dictionary<int, float> lastSpeedChangeByThreshold;

	private const float arrowRadius = 0.65f;

	protected const float ballRadius = 0.6f;

	private const float lineMaxLen = 1.5f;

	protected const float SPEED_SCALE = 0.1f;

	private const string ICON_PATH = "TextureConfig/Activity_SummerPub/BilliardGame/Map/BilliardGame_{0}";

	private BilliardGameEventTrigger eventTrigger;

	protected Rigidbody2D rb;

	protected Collider2D col;

	protected bool readyShoot;

	[SerializeField]
	protected Transform hintTrs;

	protected BilliardGameEffect hintEffect;

	[SerializeField]
	private Transform cancelTrs;

	[SerializeField]
	private Transform chooseTrs;

	[SerializeField]
	private SpriteRenderer icon;

	[SerializeField]
	private SpriteRenderer sightLineRenderer;

	[SerializeField]
	private SpriteRenderer sightPointRenderer;

	[SerializeField]
	private SpriteRenderer sightArrowRenderer;

	public float speedRatio = 1f;

	public Dictionary<int, int> speedChangeBuffDic;

	protected float normalDrag = 0.4f;

	protected float dragUpSpeed = 8f;

	protected float upDrag = 1.2f;

	protected float criticalSpeed = 0.5f;

	protected List<Collider2D> ignoreColList_;

	protected bool isIgnoreEnemyCollision;

	protected HashSet<Collider2D> hitColliderList;

	protected List<Collider2D> removeList = new List<Collider2D>();

	protected Collider2D[] overlapResults = new Collider2D[32];

	protected int lastOverlapCount;

	protected Vector3 lastPosition;

	protected RaycastHit2D[] castResults = new RaycastHit2D[32];

	protected BilliardGameEntityBase nowPlayer;

	public BilliardGameEventTrigger EventTrigger => eventTrigger;

	public bool isShooting { get; protected set; }

	public void Awake()
	{
		Init();
	}

	public void FixedUpdate()
	{
		if (isShooting)
		{
			CheckVelocityChangeBuff();
			if (isIgnoreEnemyCollision)
			{
				OnIgnoreEnemyCollision();
			}
			else
			{
				RefreshIgnoreList();
			}
		}
		if (rb.velocity.magnitude < dragUpSpeed)
		{
			rb.drag = upDrag;
		}
		else
		{
			rb.drag = normalDrag;
		}
		if (!(rb.velocity.magnitude < criticalSpeed))
		{
			return;
		}
		if (!isShooting && !readyShoot)
		{
			rb.velocity = Vector2.zero;
		}
		else if (readyShoot)
		{
			readyShoot = false;
			isShooting = true;
			rb.velocity = shootInfo;
			if (isIgnoreEnemyCollision)
			{
				lastPosition = base.transform.position;
				lastOverlapCount = Physics2D.OverlapCircleNonAlloc(base.transform.position, 0.6f, overlapResults);
				CheckPererateEnter();
			}
		}
		else if (BilliardGameLogicManager.Instance.turnState == TurnState.PlayerAttackPhase)
		{
			rb.mass = BilliardGameLogicManager.Instance.defaultMass;
			isShooting = false;
			rb.velocity = Vector2.zero;
			ReSetIngoreCollision();
		}
	}

	public void OnDestroy()
	{
	}

	public override void Init()
	{
		ignoreColList_ = new List<Collider2D>();
		hitColliderList = new HashSet<Collider2D>();
		lastSpeedChangeByThreshold = new Dictionary<int, float>();
		isShooting = false;
		rb = GetComponent<Rigidbody2D>();
		col = GetComponent<Collider2D>();
		eventTrigger = GetComponent<BilliardGameEventTrigger>();
		eventTrigger.SetClickCallBack(delegate(Vector3 p)
		{
			ClickAim(p);
		});
		eventTrigger.SetDragBeginCallBack(delegate(Vector3 p)
		{
			DragBeginAim(p);
		});
		eventTrigger.SetDragCallBack(delegate(Vector3 p, bool b)
		{
			DragAim(p, b);
		});
		eventTrigger.SetDragEndCallBack(delegate(Vector3 p, bool b)
		{
			DragEndAim(p, b);
		});
		if (null == cancelTrs)
		{
			cancelTrs = base.transform.Find("billiardPlayerBase/cancel");
		}
		if (null == chooseTrs)
		{
			chooseTrs = base.transform.Find("billiardPlayerBase/choose");
		}
		object[] array = LuaHelper.CallFunction("GetBilliardGameCriticalSpeed");
		if (array != null && array.Length != 0)
		{
			object[] array2 = (array[0] as LuaTable).ToArray();
			normalDrag = (float)(double)array2[0];
			dragUpSpeed = (float)(double)array2[1];
			upDrag = (float)(double)array2[2];
			criticalSpeed = (float)(double)array2[3];
		}
		rb.mass = BilliardGameLogicManager.Instance.defaultMass;
	}

	public Collider2D GetPlayerCol()
	{
		return col;
	}

	public void SetDrag(float drag)
	{
	}

	public void SetIcon(string iconName)
	{
		string spritePath = (BilliardGameDataManager.IsBallGame() ? $"TextureConfig/Activity_SummerPub/BilliardGame/Map/BilliardGame_{iconName}" : iconName);
		AtlasManager.GetSpriteWithoutAtlas(icon, spritePath);
	}

	public void SelectBall(bool isSelect)
	{
		chooseTrs.SetActive(isSelect);
		BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_stretch");
	}

	public void CancelBall(bool isCancel)
	{
		cancelTrs.SetActive(isCancel);
		BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_cancel");
	}

	public void HintBall(bool isHint)
	{
		if (isHint && null == hintEffect)
		{
			hintEffect = BilliardGameLogicManager.Instance.MakeEffectGo("TongYong/nya_pinball_tongyong_caozuotixing_1", hintTrs.gameObject, 1f);
		}
		if (!isHint && null != hintEffect)
		{
			hintEffect.Die();
			hintEffect = null;
		}
	}

	public virtual void ShootBall(Vector3 dir, float force)
	{
		InitNowPlayer();
		CheckIgnoreCollision();
		CheckIsStuck();
		HideShootPre();
		readyShoot = true;
		rb.mass = BilliardGameLogicManager.Instance.shootingMass;
		dir = Vector3.Normalize(dir);
		shootInfo = dir * force * speedRatio * 0.1f;
		lastSpeedChangeByThreshold.Clear();
		speedRatio = 1f;
		BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_shoot");
	}

	protected void RefreshIgnoreList()
	{
		for (int num = ignoreColList_.Count - 1; num >= 0; num--)
		{
			Collider2D collider2D = ignoreColList_[num];
			if (!(null == collider2D))
			{
				int contacts = rb.GetContacts(overlapResults);
				bool flag = true;
				for (int i = 0; i < contacts; i++)
				{
					if (collider2D == overlapResults[i])
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					ignoreColList_.Remove(collider2D);
					Physics2D.IgnoreCollision(col, collider2D, ignore: false);
				}
			}
		}
	}

	public virtual void InitNowPlayer()
	{
		List<EntityPlayer> allEntityPlayer = BilliardGameLogicManager.Instance.GetAllEntityPlayer();
		nowPlayer = allEntityPlayer.Find((EntityPlayer p) => p.entityID == base.entityID);
		isIgnoreEnemyCollision = (nowPlayer as EntityPlayer).isIgnoreEnemyCollision;
		speedChangeBuffDic = (nowPlayer as EntityPlayer).SpeedChangeBuff;
		if (lastSpeedChangeByThreshold == null)
		{
			lastSpeedChangeByThreshold = new Dictionary<int, float>();
		}
	}

	public virtual void CheckIgnoreCollision()
	{
		foreach (EntityPlayer item in BilliardGameLogicManager.Instance.GetAllEntityPlayer())
		{
			if (item.entityID != base.entityID)
			{
				Collider2D playerCol = item.logic.GetPlayerCol();
				ignoreColList_.Add(playerCol);
				Physics2D.IgnoreCollision(col, playerCol, isIgnoreEnemyCollision);
			}
		}
		foreach (EntityEnemy allEnemyEntity in BilliardGameLogicManager.Instance.GetAllEnemyEntityList())
		{
			Collider2D enemyCol = allEnemyEntity.logic.GetEnemyCol();
			ignoreColList_.Add(enemyCol);
			Physics2D.IgnoreCollision(col, enemyCol, isIgnoreEnemyCollision);
		}
	}

	private void CheckIsStuck()
	{
		if (isIgnoreEnemyCollision)
		{
			return;
		}
		int contacts = rb.GetContacts(overlapResults);
		if (contacts < 4)
		{
			return;
		}
		Debug.Log($"卡墙脱离测试用:看到这条log说明触发了卡墙脱离,当前重叠碰撞体数:{contacts}");
		for (int i = 0; i < contacts; i++)
		{
			Collider2D collider2D = overlapResults[i];
			if (collider2D != null && collider2D.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component) && (component is BilliardGameEnemy || component is BilliardGameMechanism))
			{
				Physics2D.IgnoreCollision(col, collider2D);
				ignoreColList_.Add(collider2D);
			}
		}
	}

	public void HideShootPre()
	{
		sightLineRenderer.gameObject.SetActive(value: false);
		sightPointRenderer.gameObject.SetActive(value: false);
		sightArrowRenderer.gameObject.SetActive(value: false);
	}

	public void ChangeVelocity(float ratio)
	{
		rb.velocity *= ratio;
	}

	public void ChangeVelocityNum(float num)
	{
		rb.velocity += rb.velocity.normalized * num;
	}

	protected void CheckVelocityChangeBuff()
	{
		if (speedChangeBuffDic == null || speedChangeBuffDic.Count == 0)
		{
			return;
		}
		float num = rb.velocity.magnitude - shootInfo.magnitude;
		bool flag = true;
		foreach (int key2 in speedChangeBuffDic.Keys)
		{
			float b = 0f;
			if (lastSpeedChangeByThreshold != null && lastSpeedChangeByThreshold.TryGetValue(key2, out var value))
			{
				b = value;
			}
			if (!Mathf.Approximately(num, b))
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in speedChangeBuffDic)
		{
			int key = item.Key;
			float oldSpeedChange = 0f;
			if (lastSpeedChangeByThreshold != null && lastSpeedChangeByThreshold.TryGetValue(key, out var value2))
			{
				oldSpeedChange = value2;
			}
			int speedBuffTriggerTimes = GetSpeedBuffTriggerTimes(oldSpeedChange, num, key);
			if (speedBuffTriggerTimes <= 0)
			{
				continue;
			}
			BTEnv buff = nowPlayer.GetBuff(item.Value);
			for (int i = 0; i < speedBuffTriggerTimes; i++)
			{
				if (buff != null)
				{
					buff.Run();
				}
				else
				{
					BilliardGameSpellManager.Instance.CastBuff(item.Value, nowPlayer);
				}
			}
			lastSpeedChangeByThreshold[key] = num;
		}
	}

	private int GetSpeedBuffTriggerTimes(float oldSpeedChange, float newSpeedChange, int threshold)
	{
		if (threshold == 0)
		{
			return 0;
		}
		if (threshold > 0)
		{
			int b = Mathf.FloorToInt(oldSpeedChange / (float)threshold);
			int num = Mathf.FloorToInt(newSpeedChange / (float)threshold);
			b = Mathf.Max(0, b);
			return Mathf.Max(0, num - b);
		}
		int num2 = -threshold;
		int b2 = Mathf.FloorToInt((0f - oldSpeedChange) / (float)num2);
		int num3 = Mathf.FloorToInt((0f - newSpeedChange) / (float)num2);
		b2 = Mathf.Max(0, b2);
		return Mathf.Max(0, num3 - b2);
	}

	public bool CheckRest()
	{
		if (rb.velocity.magnitude < 0.0001f && !isShooting)
		{
			return !readyShoot;
		}
		return false;
	}

	public void DoMove(Vector3 dir, float force)
	{
		rb.velocity += (Vector2)(dir * force);
	}

	private void ClickAim(Vector3 pointer)
	{
		BilliardGameLogicManager.Instance.OnClick(base.entityID);
	}

	private void DragBeginAim(Vector3 pointer)
	{
		BilliardGameLogicManager.Instance.OnBeginDrag(this, base.transform, base.entityID);
	}

	private void DragAim(Vector3 pointer, bool isCancel)
	{
		BilliardGameLogicManager.Instance.OnDrag(base.transform, pointer, isCancel, DragAimCallback);
	}

	private void DragEndAim(Vector3 pointer, bool isCancel)
	{
		BilliardGameLogicManager.Instance.OnEndDrag(this, base.entityID, isCancel);
	}

	private void DragAimCallback(Vector3 dir, Vector3 pointer, bool isCancel, float rate)
	{
		CancelBall(isCancel);
		sightLineRenderer.gameObject.SetActive(!isCancel);
		sightPointRenderer.gameObject.SetActive(!isCancel);
		sightArrowRenderer.gameObject.SetActive(!isCancel);
		if (!isCancel)
		{
			UpdateSightLine(dir, pointer, rate);
		}
	}

	public void UpdateSightLine(Vector3 dir, Vector3 pointer, float forceRate)
	{
		float num = Vector3.SignedAngle(Vector3.left, -dir, Vector3.forward);
		float num2 = dir.magnitude - 0.6f;
		if (num2 > 0f)
		{
			sightLineRenderer.size = new Vector2(Mathf.Min(num2, 1.5f), 0.3f);
			Vector3 vector = new Vector3((0f - Mathf.Min(num2 / 2f + 0.6f, 1.5f)) * Mathf.Cos(num * MathF.PI / 180f), (0f - Mathf.Min(num2 / 2f + 0.6f, 1.5f)) * Mathf.Sin(num * MathF.PI / 180f));
			sightLineRenderer.transform.position = vector + base.transform.position;
		}
		sightLineRenderer.transform.localEulerAngles = new Vector3(0f, 0f, num);
		Vector3 vector2 = new Vector3(0.65f * Mathf.Cos(num * MathF.PI / 180f), 0.65f * Mathf.Sin(num * MathF.PI / 180f));
		sightArrowRenderer.transform.localEulerAngles = new Vector3(0f, 0f, num);
		sightArrowRenderer.transform.position = vector2 + base.transform.position;
		sightPointRenderer.transform.position = pointer;
	}

	protected void OnIgnoreEnemyCollision()
	{
		Vector3 position = base.transform.position;
		Vector3 vector = position - lastPosition;
		float magnitude = vector.magnitude;
		lastOverlapCount = Physics2D.OverlapCircleNonAlloc(position, 0.6f, overlapResults);
		if (magnitude > 0.0001f)
		{
			int num = Physics2D.CircleCastNonAlloc(lastPosition, 0.6f, vector / magnitude, castResults, magnitude);
			for (int i = 0; i < num; i++)
			{
				Collider2D collider = castResults[i].collider;
				if (collider == null)
				{
					continue;
				}
				bool flag = false;
				for (int j = 0; j < lastOverlapCount; j++)
				{
					if (overlapResults[j] == collider)
					{
						flag = true;
						break;
					}
				}
				if (!flag && !hitColliderList.Contains(collider))
				{
					OnHighSpeedPenetrate(collider);
				}
			}
		}
		CheckPererateExit();
		CheckPererateEnter();
		lastPosition = position;
	}

	public virtual void OnHighSpeedPenetrate(Collider2D othercol)
	{
		othercol.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
		if (component != null && component is BilliardGameEnemy)
		{
			BilliardGameLogicManager.Instance.CameraShake();
			BilliardGameLogicManager.Instance.DoHitEnemy(base.entityID, component.entityID);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit02");
			BilliardGameLogicManager.Instance.DoPenetrateEnemy(base.entityID, component.entityID);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit02");
		}
	}

	public virtual void CheckPererateExit()
	{
		removeList.Clear();
		foreach (Collider2D hitCollider in hitColliderList)
		{
			bool flag = false;
			for (int i = 0; i < lastOverlapCount; i++)
			{
				if (overlapResults[i] == hitCollider)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				removeList.Add(hitCollider);
			}
		}
		foreach (Collider2D remove in removeList)
		{
			if (remove != null)
			{
				hitColliderList.Remove(remove);
				remove.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
				if (component is BilliardGameEnemy)
				{
					BilliardGameLogicManager.Instance.DoPenetrateEnemy(base.entityID, component.entityID);
					BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit02");
				}
			}
		}
	}

	public virtual void CheckPererateEnter()
	{
		for (int i = 0; i < lastOverlapCount; i++)
		{
			Collider2D collider2D = overlapResults[i];
			if (collider2D != null && !hitColliderList.Contains(collider2D))
			{
				collider2D.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
				if (component != null && component is BilliardGameEnemy)
				{
					hitColliderList.Add(collider2D);
					BilliardGameLogicManager.Instance.CameraShake();
					BilliardGameLogicManager.Instance.DoHitEnemy(base.entityID, component.entityID);
					BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit02");
				}
			}
		}
	}

	public void ReSetIngoreCollision()
	{
		foreach (Collider2D item in ignoreColList_)
		{
			if (item != null)
			{
				Physics2D.IgnoreCollision(item, col, ignore: false);
			}
		}
	}

	public void NotifyTeleport()
	{
		lastPosition = base.transform.position;
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		if (BilliardGameLogicManager.Instance.IsOver || collision == null || BilliardGameLogicManager.Instance.turnState != TurnState.PlayerAttackPhase)
		{
			return;
		}
		collision.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
		if (component != null)
		{
			if (component is BilliardGameBall && !(component is BilliardGamePhysicalBullet))
			{
				BilliardGameLogicManager.Instance.DoHitTeammate(base.entityID, component.entityID);
				BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_pengzhuang_1", collision.contacts[0].point, 1f);
				BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit01");
			}
			if (component is BilliardGameEnemy)
			{
				BilliardGameLogicManager.Instance.CameraShake();
				BilliardGameLogicManager.Instance.DoHitEnemy(base.entityID, component.entityID);
				BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_pengzhuang_2", collision.contacts[0].point, 1f);
				BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit02");
			}
			if (component is BilliardGameMechanism)
			{
				BilliardGameLogicManager.Instance.DoHitMechanism(base.entityID, component.entityID);
				BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_pengzhuang_1", collision.contacts[0].point, 1f);
				BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit01");
			}
		}
		else
		{
			BilliardGameLogicManager.Instance.effectMgr.AddWorldEffect("TongYong/nya_pinball_tongyong_pengzhuang_1", collision.contacts[0].point, 1f);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_hit01");
		}
	}

	private void OnTriggerEnter2D(Collider2D collision)
	{
		if (!BilliardGameLogicManager.Instance.IsOver && !(collision == null) && BilliardGameLogicManager.Instance.turnState == TurnState.PlayerAttackPhase && collision.transform.TryGetComponent<BilliardGameMechanism>(out var component))
		{
			BilliardGameLogicManager.Instance.DoHitMechanism(base.entityID, component.entityID);
		}
	}
}
