using System;
using ControllerExSpace;
using Pinball.Runtime;
using UnityEngine;

namespace Pinball;

public class NormalBlock : BallPolygon
{
	private int initHp;

	private ParticleSystem effectHealPs;

	private int convertRemainTime;

	public int affectTriggerCount;

	public int remainAffectTriggerCount;

	public int affectTriggerDamage;

	public int protectedTriggerCount;

	private BlockBuffType currentBuffs;

	public NormalBlock(int uniqueId, GameObject go, Vector2 runtimePos, int remain, PolygonType pType, BlockPathData pathData, PolygonType convertType)
		: base(uniqueId, go, runtimePos, remain, pType)
	{
		vertexCount = 4;
		vertex = new Vector2[vertexCount];
		normal = new Vector2[vertexCount];
		vertex[0] = new Vector2(runtimePos.x - 0.5f, runtimePos.y + 0.5f);
		vertex[1] = new Vector2(runtimePos.x + 0.5f, runtimePos.y + 0.5f);
		vertex[2] = new Vector2(runtimePos.x + 0.5f, runtimePos.y - 0.5f);
		vertex[3] = new Vector2(runtimePos.x - 0.5f, runtimePos.y - 0.5f);
		normal[0] = Vector2.up;
		normal[1] = Vector2.right;
		normal[2] = Vector2.down;
		normal[3] = Vector2.left;
		initHp = remain;
		base.convertType = convertType;
		convertRemainTime = 0;
		if (pathData != null && pathData.pathPoints.Count < 2)
		{
			InitMovePath(pathData);
		}
		else
		{
			ResetMove();
		}
		if (go != null)
		{
			BindEffectPs();
			EnterAnim();
			ResetEffect();
		}
	}

	public override void Release()
	{
		base.Release();
		effectHealPs = null;
		affectPs = null;
		affectingPs = null;
		affectedPs = null;
		currentBuffs = BlockBuffType.None;
		protectedTriggerCount = 0;
		affectTriggerCount = 0;
		remainAffectTriggerCount = 0;
	}

	public override BallPolygon Clone()
	{
		NormalBlock normalBlock;
		if (go == null)
		{
			normalBlock = new NormalBlock(uniqueId, null, Vector2.zero, initHp, pType, pathData, convertType);
			normalBlock.protectedTriggerCount = protectedTriggerCount;
			normalBlock.affectTriggerCount = affectTriggerCount;
			normalBlock.affectTriggerDamage = affectTriggerDamage;
			normalBlock.remainAffectTriggerCount = remainAffectTriggerCount;
		}
		else
		{
			normalBlock = new NormalBlock(uniqueId, null, GetLocalPosition(), initHp, pType, pathData, convertType);
			normalBlock.protectedTriggerCount = protectedTriggerCount;
			normalBlock.affectTriggerDamage = affectTriggerDamage;
			normalBlock.remainAffectTriggerCount = remainAffectTriggerCount;
		}
		return normalBlock;
	}

	public void ResetEffect()
	{
		protectEffectGo.SetActive(value: false);
		affectedEffectGo.SetActive(value: false);
		affectEffectGo.SetActive(value: false);
		effectSelectGo.SetActive(value: false);
	}

	public override void AdjustVerticesAndNormals()
	{
		Vector2 vector = mLocalPosition;
		vertex[0] = new Vector2(vector.x - 0.5f, vector.y + 0.5f);
		vertex[1] = new Vector2(vector.x + 0.5f, vector.y + 0.5f);
		vertex[2] = new Vector2(vector.x + 0.5f, vector.y - 0.5f);
		vertex[3] = new Vector2(vector.x - 0.5f, vector.y - 0.5f);
	}

	public override float CheckCollision(Vector2 ballPosition, Vector2 ballVelocity, float ballRadius, out Vector2 newPosition, out Vector2 newVelocity)
	{
		float num = 560000f;
		newPosition = ballPosition;
		newVelocity = ballVelocity;
		Vector2 vector = Vector2.zero;
		bool flag = false;
		for (int i = 0; i < vertexCount; i++)
		{
			Vector2 lineStart = vertex[i];
			Vector2 lineEnd = vertex[(i + 1) % vertexCount];
			Vector2 vector2 = normal[i];
			float num2 = PinballKinematicLib.CalculateCollision(ballPosition, ballVelocity, ballRadius, lineStart, lineEnd, vector2, out var resPos, out var resVel);
			if (!(num2 <= 0f))
			{
				if (!flag || num2 < num - 1E-06f)
				{
					num = num2;
					newPosition = resPos;
					newVelocity = resVel;
					vector = vector2;
					flag = true;
				}
				else if (Mathf.Abs(num2 - num) <= 1E-06f)
				{
					vector += vector2;
				}
			}
		}
		if (!flag)
		{
			return 560000f;
		}
		if (vector.sqrMagnitude > 1E-08f)
		{
			Vector2 normalized = vector.normalized;
			Vector2 reflect = ballVelocity - 2f * Vector2.Dot(ballVelocity, normalized) * normalized;
			CheckAndApplyAxialJitter(ref reflect, normalized);
			if (reflect.magnitude < 0.02f)
			{
				reflect = reflect.normalized * 0.02f;
			}
			if (GetConvertType() == PolygonType.portal)
			{
				reflect = ballVelocity;
			}
			newVelocity = reflect;
		}
		return num;
	}

	private static void CheckAndApplyAxialJitter(ref Vector2 reflect, Vector2 normal)
	{
		float num = Mathf.Abs(Vector2.Angle(reflect.normalized, Vector2.right));
		bool num2 = num >= 88f && num <= 92f;
		bool flag = num <= 2f || num >= 178f;
		if (num2 | flag)
		{
			float magnitude = reflect.magnitude;
			float num3 = ((UnityEngine.Random.value > 0.5f) ? 1f : (-1f));
			float f = 5f * num3 * (MathF.PI / 180f);
			float num4 = Mathf.Cos(f);
			float num5 = Mathf.Sin(f);
			reflect = new Vector2(reflect.x * num4 - reflect.y * num5, reflect.x * num5 + reflect.y * num4).normalized * magnitude;
		}
	}

	public override void OnCollision(Ball ball)
	{
		PlayCollsionSoundEffect();
		int changeHp = -1;
		CheckProtectBuff(changeHp);
		CheckExplosionBuff();
		TriggerStaticPolygonEffect(ball);
		if (remainHp <= 0)
		{
			PinballGameManager.Instance.BreakBlockTimes++;
			CheckConvert();
			TriggerPolygonEffect();
			TriggerPolygonEffect(ball);
			BreakAnim(playerBreak: true);
			PinballGameManager.Instance.AddUIDToRemoveList(uniqueId);
		}
		else if (pType != PolygonType.wall)
		{
			PlayHitAni();
		}
	}

	public void PlayCollsionSoundEffect()
	{
		string cueName = "minigame_activity_4_6_marble_basic";
		bool flag = false;
		if (HasBuff(BlockBuffType.protect))
		{
			cueName = "minigame_activity_4_6_marble_protect";
			flag = true;
		}
		else if (HasBuff(BlockBuffType.affect))
		{
			cueName = "minigame_activity_4_6_marble_color01";
			flag = true;
		}
		else if (HasBuff(BlockBuffType.protect))
		{
			cueName = "minigame_activity_4_6_marble_color02";
			flag = true;
		}
		if (!flag)
		{
			if (convertType == PolygonType.resetBlock)
			{
				cueName = "minigame_activity_4_6_marble_reset";
			}
			else if (convertType == PolygonType.healthBlock)
			{
				cueName = "minigame_activity_4_6_marble_heal";
			}
			else if (convertType == PolygonType.explosion)
			{
				cueName = "minigame_activity_4_6_marble_bomb";
			}
			else if (convertType == PolygonType.spare)
			{
				cueName = "minigame_activity_4_6_marble_split";
			}
			else if (convertType == PolygonType.skillBlock)
			{
				cueName = "minigame_activity_4_6_marble_add";
			}
			else if (convertType == PolygonType.wall)
			{
				cueName = "minigame_activity_4_6_marble_hinder";
			}
			else if (convertType == PolygonType.portal)
			{
				cueName = "minigame_activity_4_6_marble_portal";
			}
			else if (convertType == PolygonType.word)
			{
				cueName = "minigame_activity_4_6_marble_debate01";
			}
			else if (convertType == PolygonType.highValueWord)
			{
				cueName = "minigame_activity_4_6_marble_debate02";
			}
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_6", cueName, useStream: false);
	}

	public void CheckConvert()
	{
	}

	public void PlayHitAni()
	{
		if (convertType != PolygonType.portal)
		{
			effectHitPs.Play();
		}
	}

	public override void TriggerPolygonEffect()
	{
		if (convertType == PolygonType.skillBlock)
		{
			PinballGameManager.Instance.turnBasedGame.OnSkillBlockBreak();
		}
		else if (convertType == PolygonType.healthBlock)
		{
			PinballGameManager.Instance.turnBasedGame.OnHealthBlockBreak();
		}
		else if (convertType == PolygonType.gainBallItem)
		{
			PinballGameManager.Instance.AddNewBall(show: false, BallType.normalBall);
		}
		else if (convertType == PolygonType.damageBlock)
		{
			PinballGameManager.Instance.UpdatePlayerHitNumber(1, isDamageType: true);
		}
	}

	public override void TriggerPolygonEffect(Ball ball)
	{
	}

	public void TriggerStaticPolygonEffect(Ball ball)
	{
		if (convertType == PolygonType.portal && (!PinballGameManager.Instance.portalCDDic.ContainsKey(uniqueId) || !(PinballGameManager.Instance.portalCDDic[uniqueId] > 0f)))
		{
			PinballGameManager.Instance.EnterPortal(go.transform.position, ball);
		}
	}

	public override void TriggerPolygonCallBackEffect()
	{
		if (PinballGameManager.Instance.IsRemovedUID(uniqueId))
		{
			return;
		}
		if (convertType == PolygonType.resetBlock)
		{
			PinballGameManager.Instance.OnResetBlockBreak();
		}
		else if (convertType == PolygonType.spare)
		{
			PinballGameManager.Instance.SpareBall(go.transform.position);
		}
		else if (convertType == PolygonType.explosion)
		{
			PinballGameManager.Instance.ExplosionInCircle(go.transform.localPosition);
			go.transform.Find("EffectBlockBaozha/chongji").GetComponent<ParticleSystem>().Play();
		}
		else if (PinballGameManager.Instance.isDebateStage && GetConvertType() == PolygonType.word)
		{
			PinballGameManager.Instance.turnBasedGame.HitDebateBlock(go.transform.position);
		}
		else if (PinballGameManager.Instance.isDebateStage && GetConvertType() == PolygonType.highValueWord)
		{
			PinballGameManager.Instance.turnBasedGame.HitHighValueDebateBlock(go.transform.position);
		}
		if (HasBuff(BlockBuffType.affect))
		{
			PinballGameManager.Instance.turnBasedGame.HitPlayer(affectTriggerDamage, isThump: false, isMultiTrigger: true);
			PinballGameManager.Instance.affectHitDamage += affectTriggerDamage;
			if (!PinballGameManager.Instance.turnBasedGame.effectHitAniPlayed)
			{
				PinballGameManager.Instance.turnBasedGame.PlayerAnimAndEffect("hit");
				PinballGameManager.Instance.turnBasedGame.effectHitAniPlayed = true;
			}
		}
	}

	public void CheckProtectBuff(int changeHp)
	{
		if (HasBuff(BlockBuffType.protect) && protectedTriggerCount > 0)
		{
			protectedTriggerCount--;
			if (protectedTriggerCount <= 0)
			{
				RemoveBuff(BlockBuffType.protect);
				protectEffectGo.SetActive(value: false);
				if (pType == PolygonType.protect)
				{
					remainHp = 0;
				}
				removeBuffTrigger &= -2;
			}
			go.transform.Find("EffectBlockIceBreak/chongji").GetComponent<ParticleSystem>().Play();
			curProtectControllerEx.SetSelectedState(protectedTriggerCount.ToString());
		}
		else
		{
			remainHp += changeHp;
		}
	}

	public void CheckExplosionBuff()
	{
		if (PinballGameManager.Instance.explosionBuffRemainCount > 0)
		{
			go.transform.Find("EffectBlockBaozha/chongji").GetComponent<ParticleSystem>().Play();
		}
	}

	public override int OnRoundAfter()
	{
		if (PinballGameManager.Instance.activeBlocks.ContainsKey(uniqueId) && remainHp > 0 && convertType == PolygonType.recoveryBlock)
		{
			effectHealPs.Play();
			remainHp += PinballGameManager.Instance.GetRecoveryBlockValue();
		}
		if (HasBuff(BlockBuffType.affect))
		{
			remainAffectTriggerCount--;
			if (remainAffectTriggerCount <= 0)
			{
				PinballGameManager.Instance.OnAffectBlockTriger(GetLocalPosition(), new float[4] { 0f, 0f, affectTriggerCount, affectTriggerDamage });
				remainAffectTriggerCount = affectTriggerCount;
			}
			affectedEffectGo.SetActive(value: true);
		}
		if (convertRemainTime > 0)
		{
			convertRemainTime--;
			if (convertRemainTime <= 0 && convertType != pType)
			{
				convertType = pType;
				GameObject block = BlockPool.Instance.GetBlock(pType);
				_ = pType;
				if (block == null)
				{
					Debug.LogError("从对象池中获取色块失败Type:" + pType);
					return 0;
				}
				block.transform.localPosition = go.transform.localPosition;
				block.name = go.name;
				go.SetActive(value: false);
				UnityEngine.Object.Destroy(go);
				go = block;
				BindEffectPs();
				effectChangePs.Play();
			}
		}
		return 0;
	}

	protected override void BindEffectPs()
	{
		if (!(go == null))
		{
			base.BindEffectPs();
			if (convertType == PolygonType.recoveryBlock)
			{
				effectHealPs = go.transform.Find("EffectRecovery/di1").GetComponent<ParticleSystem>();
				effectHealPs.Stop();
			}
		}
	}

	public void ChangeToTargerRemainHp(int target)
	{
		remainHp = target;
	}

	public void ChangeRemainHp(int detla)
	{
		CheckProtectBuff(detla);
		if (remainHp <= 0)
		{
			PinballGameManager.Instance.BreakBlockTimes++;
			go.SetActive(value: false);
			PinballGameManager.Instance.AddUIDToRemoveList(uniqueId);
		}
	}

	public void ConvertBlkType(PolygonType newType, int time, float[] param = null)
	{
		convertRemainTime = time;
		if (newType == convertType)
		{
			return;
		}
		convertType = newType;
		base.param = param;
		Sprite sprite = null;
		GameObject block = BlockPool.Instance.GetBlock(newType);
		if (block == null)
		{
			Debug.LogError($"Failed to get block from pool: {newType}");
			return;
		}
		block.transform.localPosition = go.transform.localPosition;
		block.name = go.name;
		go.SetActive(value: false);
		UnityEngine.Object.Destroy(go);
		go = block;
		BindEffectPs();
		if (sprite != null)
		{
			iconSr.sprite = sprite;
		}
		PlayChangeAni();
	}

	public void PlayChangeAni()
	{
	}

	public void ExplosionTriggerWithoutBall()
	{
		int changeHp = -1;
		CheckProtectBuff(changeHp);
		if (remainHp <= 0)
		{
			PinballGameManager.Instance.BreakBlockTimes++;
			CheckConvert();
			TriggerPolygonEffect();
			BreakAnim(playerBreak: true);
			PinballGameManager.Instance.AddUIDToRemoveList(uniqueId);
		}
		else
		{
			PlayHitAni();
		}
	}

	public void AddBuff(BlockBuffType buffType)
	{
		currentBuffs |= buffType;
	}

	public bool HasBuff(BlockBuffType buffType)
	{
		return (currentBuffs & buffType) != 0;
	}

	public void RemoveBuff(BlockBuffType buffType)
	{
		currentBuffs &= ~buffType;
		removeBuffTrigger |= (int)buffType;
	}

	public void SetBuffWithCount(BlockBuffType buffType, float[] param = null, bool notTriggerThisRound = false)
	{
		AddBuff(buffType);
		switch (buffType)
		{
		case BlockBuffType.protect:
			go.transform.Find("EffectBlockIce/glow").GetComponent<ParticleSystem>().Play();
			protectedTriggerCount = (int)param[3];
			protectEffectGo.SetActive(value: true);
			uiProtectControllerEx.GetController("protect").SetSelectedState(protectedTriggerCount.ToString());
			curProtectControllerEx = uiProtectControllerEx.transform.GetChild(protectedTriggerCount - 1).GetComponent<ControllerExCollection>().GetController("count");
			curProtectControllerEx.SetSelectedState(protectedTriggerCount.ToString());
			break;
		case BlockBuffType.affect:
			base.param = param;
			affectTriggerDamage = (int)param[3];
			affectTriggerCount = (int)param[2];
			remainAffectTriggerCount = affectTriggerCount;
			affectPs.Play();
			affectedPs.Play();
			affectedEffectGo.SetActive(value: true);
			break;
		}
	}

	public BlockBuffType GetCurrentBuffs()
	{
		return currentBuffs;
	}
}
