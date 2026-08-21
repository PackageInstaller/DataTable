using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using ZumaGame;

public class ZumaShooter3D : EventTrigger
{
	private ZumaShootBall shootBall;

	private ZumaShootBall nextShootBall;

	private Transform shootBallTrs;

	private Transform nextShootBallTrs;

	private Transform shootBallNode;

	private GameObject shootBallNodeObj;

	private BallEffctType curBallEffect;

	private BallEffctType nextBallEffect;

	private BallColorType curBallColor;

	private BallColorType nextBallColor;

	private bool isClickShoot;

	private ShooterDir dir;

	private ShooterState shootState;

	public Animator playerAni;

	private GameObject aimNode;

	private Transform aimHead;

	private Transform aimLine;

	private SpriteRenderer aimLineSP;

	private bool isInit;

	private Vector3 rotateEuler = new Vector3(0f, 0f, 0f);

	private Vector3 ballRotateEuler = new Vector3(0f, 0f, 0f);

	private float rotateEulerValue;

	private float giddyValue = 1440f;

	private Dictionary<ShooterDir, Vector3> RotateDirDic = new Dictionary<ShooterDir, Vector3>
	{
		{
			ShooterDir.FRONT,
			new Vector3(50f, -180f, 0f)
		},
		{
			ShooterDir.BACK,
			new Vector3(-50f, 0f, 0f)
		},
		{
			ShooterDir.SIDE_RIGHT,
			new Vector3(0f, 90f, -55f)
		},
		{
			ShooterDir.SIDE_LEFT,
			new Vector3(0f, -90f, 50f)
		}
	};

	private float swapTimes = 0.5f;

	private float swapTimeProgress;

	private bool isSwaping;

	private Vector3 selectBallScale = Vector3.one;

	private Vector3 normalBallScale = Vector3.one * 0.7f;

	private void Awake()
	{
		playerAni = base.transform.Find("playerNode/player").GetComponent<Animator>();
		shootBallNode = base.transform.Find("BallNode");
		shootBallNodeObj = shootBallNode.gameObject;
		shootBallTrs = shootBallNode.Find("ShootBallNode");
		nextShootBallTrs = shootBallNode.Find("NextShootBallNode");
		shootBall = shootBallNode.Find("ShootBallNode/ShootBall").GetComponent<ZumaShootBall>();
		nextShootBall = shootBallNode.Find("NextShootBallNode/NextShootBall").GetComponent<ZumaShootBall>();
		aimNode = shootBallNode.Find("AimNode").gameObject;
		aimHead = aimNode.transform.Find("AimHead").transform;
		aimLine = aimNode.transform.Find("AimLine").transform;
		aimLineSP = aimLine.GetComponent<SpriteRenderer>();
		InitCol();
	}

	private void InitCol()
	{
		ZumaShooterCol component = base.transform.Find("ShootCol").GetComponent<ZumaShooterCol>();
		component.SetClickCallBack(delegate
		{
			ShooterLaunch();
		});
		component.SetDragCallBack(delegate
		{
			RotateShooter();
		});
		component.SetDragEndCallBack(delegate
		{
			RotateEnd();
		});
		ZumaShooterCol component2 = base.transform.Find("ClickCol").GetComponent<ZumaShooterCol>();
		component2.SetClickCallBack(delegate
		{
			SwapBallFunc();
		});
		BoxCollider component3 = component2.transform.GetComponent<BoxCollider>();
		if ((bool)component3)
		{
			component3.enabled = true;
			component3.size = new Vector3(0.4f, 0.5f, 0.5f);
		}
	}

	private void Init()
	{
		if (ZumaCreate.isInit)
		{
			isInit = true;
			ZumaCreate.SpawnShootBallStrategy(out nextBallEffect, out nextBallColor);
			RefrashBallType();
		}
	}

	private void Update()
	{
		if (!isInit)
		{
			Init();
			return;
		}
		if (isClickShoot)
		{
			isClickShoot = false;
			return;
		}
		UpdateBulletShooterSkill();
		CheckStrikeEffect();
		SwapBallAniUpdate();
		CheckShootBallIsExit();
	}

	private void CheckShootBallIsExit()
	{
		if (!ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall))
		{
			if (curBallColor != BallColorType.EmptyColor && ZumaCreate.createColorList.IndexOf((int)curBallColor) == -1)
			{
				curBallColor = ZumaCreate.RangeShootBallColor();
				shootBall.RefrashShow(curBallEffect, curBallColor);
			}
			if (nextBallColor != BallColorType.EmptyColor && ZumaCreate.createColorList.IndexOf((int)nextBallColor) == -1)
			{
				nextBallColor = ZumaCreate.RangeShootBallColor();
				nextShootBall.RefrashShow(nextBallEffect, nextBallColor);
			}
		}
	}

	private void RotateShooter()
	{
		Vector3 mousePosition = Input.mousePosition;
		mousePosition.z = Camera.main.transform.position.z;
		Vector3 vector = Camera.main.ScreenToWorldPoint(mousePosition);
		float y = vector.y + base.transform.position.y;
		float x = vector.x + base.transform.position.x;
		float num = Mathf.Atan2(y, x) * 57.29578f;
		ShooterDir shooterDir = dir;
		if (num > 45f && num <= 135f)
		{
			dir = ShooterDir.FRONT;
		}
		else if ((num > 135f && num <= 180f) || (num >= -180f && num < -135f))
		{
			dir = ShooterDir.SIDE_RIGHT;
		}
		else if (num < -45f && num >= -135f)
		{
			dir = ShooterDir.BACK;
		}
		else
		{
			dir = ShooterDir.SIDE_LEFT;
		}
		float num2 = Mathf.Abs(num - rotateEuler.z);
		rotateEuler.z = num;
		shootBallNode.eulerAngles = rotateEuler;
		if ((!(rotateEulerValue < giddyValue) || !(rotateEulerValue + num2 > giddyValue)) && shooterDir != dir)
		{
			_ = rotateEulerValue;
			_ = giddyValue;
		}
		rotateEulerValue += num2;
		shootBallTrs.eulerAngles = Vector3.zero;
		nextShootBallTrs.eulerAngles = Vector3.zero;
		RotatePlayerShowByDir();
	}

	private void RotatePlayerShowByDir()
	{
		Vector3 eulerAngles = RotateDirDic[dir];
		playerAni.transform.eulerAngles = eulerAngles;
	}

	private void RotateEnd()
	{
		rotateEulerValue = 0f;
	}

	private void CalculateAimRay()
	{
		float z = rotateEuler.z;
		Vector3 position = shootBallTrs.position;
		float num = Mathf.Tan(z * (MathF.PI / 180f));
		float num2 = 1f / Mathf.Sqrt(num * num + 1f);
		float y = position.y;
		float x = position.x;
		List<ZumaTrack> trackList = ZumaGameManager.GetInstance().zumaGamePlay.trackList;
		int count = trackList.Count;
		bool flag = false;
		Vector2 a = Vector2.zero;
		float num3 = 999f;
		for (int i = 0; i < count; i++)
		{
			List<ZumaBaseBall> ballSegmentList = trackList[i].ballSegmentList;
			int count2 = ballSegmentList.Count;
			while (count2-- > 0)
			{
				ZumaBaseBall zumaBaseBall = ballSegmentList[count2].Tail;
				do
				{
					int num4 = 1;
					float progress = Mathf.Round(zumaBaseBall.progress);
					Vector2 vector = zumaBaseBall.GetPos(progress);
					bool flag2 = true;
					if (dir == ShooterDir.FRONT)
					{
						if (vector.y > y)
						{
							flag2 = false;
						}
					}
					else if (dir == ShooterDir.BACK)
					{
						if (vector.y < y)
						{
							flag2 = false;
						}
					}
					else if (dir == ShooterDir.SIDE_RIGHT)
					{
						if (vector.x < x)
						{
							flag2 = false;
						}
					}
					else if (dir == ShooterDir.SIDE_LEFT && vector.x > x)
					{
						flag2 = false;
					}
					if (flag2)
					{
						if (Mathf.Abs(num * (vector.x - x) - (vector.y - y)) * num2 <= 0.18f)
						{
							num4--;
							float num5 = Vector3.Distance(vector, position);
							if (num5 < num3)
							{
								num3 = num5;
								flag = true;
								a = vector;
							}
						}
						if (num4 <= 0)
						{
							break;
						}
					}
					zumaBaseBall = zumaBaseBall.Pre;
				}
				while (zumaBaseBall != null);
				if (flag)
				{
					break;
				}
			}
		}
		if (flag)
		{
			int num6 = (int)(Vector2.Distance(a, aimNode.transform.position) * 100f) - 10;
			float num7 = (float)(num6 - num6 % 4) * 0.01f;
			Vector2 size = aimLineSP.size;
			size.y = num7;
			aimLineSP.size = size;
			Vector2 vector2 = aimLine.transform.localPosition;
			vector2.y = 0f - (num7 / 2f - 0.03f);
			aimLine.transform.localPosition = vector2;
			Vector2 vector3 = aimHead.transform.localPosition;
			vector3.y = 0f - num7;
			aimHead.transform.localPosition = vector3;
		}
	}

	private void ChangeShooterStateAnimator(ShooterState state)
	{
		shootState = state;
		if (shootState == ShooterState.IDLE)
		{
			playerAni.Play("zuma_stand");
		}
		else
		{
			playerAni.Play("zuma_fight", 0, 0f);
		}
	}

	private void ShooterLaunch()
	{
		if (ZumaGameManager.GetInstance().isGameStart && ZumaGameManager.GetInstance().isMoveToBegin)
		{
			RotateShooter();
			Shoot();
		}
	}

	private void SwapBallData()
	{
		BallColorType ballColorType = curBallColor;
		BallEffctType ballEffctType = curBallEffect;
		curBallColor = nextBallColor;
		curBallEffect = nextBallEffect;
		nextBallColor = ballColorType;
		nextBallEffect = ballEffctType;
		SwapBegin();
	}

	private void RefrashBallType()
	{
		shootBall.gameObject.SetActive(value: true);
		if (!ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall))
		{
			SwapBallData();
			ZumaCreate.SpawnShootBallStrategy(out nextBallEffect, out nextBallColor);
			shootBall.RefrashShow(curBallEffect, curBallColor);
			nextShootBall.RefrashShow(nextBallEffect, nextBallColor);
		}
	}

	public void RefrashAllBallType()
	{
		if (!ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall))
		{
			ZumaCreate.SpawnShootBallStrategy(out curBallEffect, out curBallColor);
			ZumaCreate.SpawnShootBallStrategy(out nextBallEffect, out nextBallColor);
			shootBall.RefrashShow(curBallEffect, curBallColor);
			nextShootBall.RefrashShow(nextBallEffect, nextBallColor);
		}
	}

	private void Shoot()
	{
		if (shootBall.gameObject.activeSelf)
		{
			ChangeShooterStateAnimator(ShooterState.ATTACK);
			ZumaShootBallManager.Instance.Shoot(shootBall.effectType, shootBall.colorType, shootBallNode, shootBallNode);
			shootBall.gameObject.SetActive(value: false);
			Invoke("RefrashBallType", 0.5f);
			if (ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall))
			{
				AudioManager.Instance.Play("effect", "minigame_activity_3_11", "minigame_activity_3_11_zuma_skill01_shoot", useStream: false);
			}
			else
			{
				ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.ShootBall);
			}
		}
	}

	public void CheckStrikeEffect()
	{
		if (ZumaGameManager.GetInstance().IsMeetTrackEffect(BallEffctType.AIM) || (ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.StopMove) && ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.StopMoveOpenGetAim)))
		{
			aimNode.SetActive(value: true);
			CalculateAimRay();
		}
		else
		{
			aimNode.SetActive(value: false);
		}
	}

	public void SwapBallFunc()
	{
		SwapCurAndNextBall();
		isClickShoot = true;
	}

	private void SwapCurAndNextBall()
	{
		shootBall.RefrashShow(nextBallEffect, nextBallColor);
		nextShootBall.RefrashShow(curBallEffect, curBallColor);
		SwapBallData();
	}

	private void SwapBallAniUpdate()
	{
		if (isSwaping)
		{
			swapTimeProgress += Time.deltaTime;
			if (swapTimeProgress > swapTimes)
			{
				SwapEnd();
			}
		}
	}

	private void SwapBegin()
	{
		shootBallTrs.localScale = selectBallScale;
		nextShootBallTrs.localScale = normalBallScale;
		isSwaping = true;
		swapTimeProgress = 0f;
	}

	private void SwapEnd()
	{
		isSwaping = false;
	}

	public void UpdateBulletShooterSkill()
	{
		bool flag = ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall);
		_ = shootBall.effectType;
		if (shootBall.effectType == BallEffctType.BULLET && !flag)
		{
			shootBall.RefrashShow(curBallEffect, curBallColor);
			nextShootBall.RefrashShow(nextBallEffect, nextBallColor);
		}
		else if (shootBall.effectType != BallEffctType.BULLET && flag)
		{
			shootBall.RefrashShow(BallEffctType.BULLET, BallColorType.EmptyColor);
			nextShootBall.RefrashShow(BallEffctType.BULLET, BallColorType.EmptyColor);
		}
	}
}
