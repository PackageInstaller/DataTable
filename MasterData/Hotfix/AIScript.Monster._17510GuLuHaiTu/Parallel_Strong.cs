#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Parallel_Strong : AIScript.Monster.Template.Parallel
{
	public struct TempMultiShootParams
	{
		public HitBox.Shape shape;

		public string bulletAlias;

		public AdventureWeapon.MultipleShootStyle multipleShootStyle;

		public bool alignShoot;

		public FP alignShootDelay;

		public int bulletCount;

		public FP duration;

		public TSVector2 shootPosition;

		public FP shootPositionY;

		public TSVector2 multiShootDirection;

		public FP bulletDirectionOffset;

		public AimType aimType;

		public BulletDirectionType bulletDirectionType;

		public TSVector2 targetPosition;

		public LogicEntity target;

		public FP angle;

		public FP width;

		public FP length;

		public FP radius;

		public FP innerRadius;
	}

	private string logicTag = "updateIndex";

	private int triggerCount_EN = 2;

	private int triggerCount_H = 2;

	private int dequeueCount_EN = 3;

	private int dequeueCount_H = 3;

	private FP interval_EN = 3;

	private FP interval_H = 3;

	public string Tag_Earse = "Easy";

	public string Tag_Normal = "Normal";

	public string Tag_Hard = "Hard";

	private Dictionary<int, TSVector2> floorPOS = new Dictionary<int, TSVector2>
	{
		{
			0,
			new TSVector2(-8, 8)
		},
		{
			1,
			new TSVector2(0, 8)
		},
		{
			2,
			new TSVector2(8, 8)
		},
		{
			3,
			new TSVector2(-8, 0)
		},
		{
			4,
			new TSVector2(0, 0)
		},
		{
			5,
			new TSVector2(8, 0)
		},
		{
			6,
			new TSVector2(-8, -8)
		},
		{
			7,
			new TSVector2(0, -8)
		},
		{
			8,
			new TSVector2(8, -8)
		}
	};

	private Dictionary<int, TSVector2> safeFloor = new Dictionary<int, TSVector2>();

	private Queue<int> dangerousFloor = new Queue<int>();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private int castTime;

	private List<PlayFX> _playFXList = new List<PlayFX>();

	private int waveCount;

	private bool needTryShootAgain;

	private int onceShootSuccessCount;

	private bool tryShootAgainFinish;

	private TempMultiShootParams tShootParams;

	private FP tryAnglePerStep = 10;

	private int tryShootTimes;

	private int currentTryShootTimes;

	private RequestDefaultState shootReq;

	private readonly List<long> _bulletIdList = new List<long>(10);

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		_actor.logicVariable.SetLogicTagDicIntTSVector2Value("safeFloor", safeFloor);
		_actor.logicVariable.SetLogicTagValue(logicTag, -1);
		CoroutineNode item = StartCoroutine(UpdateSafeAndDangerousFloor());
		corList.Add(item);
		foreach (KeyValuePair<int, TSVector2> floorPO in floorPOS)
		{
			safeFloor.Add(floorPO.Key, new TSVector2(floorPO.Value.x, floorPO.Value.y));
		}
		castTime = 0;
		waveCount = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		safeFloor.Clear();
		dangerousFloor.Clear();
		for (int i = 0; i < corList.Count; i++)
		{
			StopCoroutine(corList.get_Item(i));
		}
		corList.Clear();
		for (int j = 0; j < _playFXList.Count; j++)
		{
			if (_playFXList.get_Item(j).isPlaying && _playFXList.get_Item(j).isLoop)
			{
				_playFXList.get_Item(j).Stop();
			}
			_playFXList.get_Item(j).Clear();
		}
	}

	private IEnumerator UpdateSafeAndDangerousFloor()
	{
		while (true)
		{
			int num = _actor.logicVariable.GetLogicTagValue(logicTag).AsInt();
			if (num != -1)
			{
				for (int i = 0; i < 3; i++)
				{
					int num2 = num + i * 3;
					if (safeFloor.ContainsKey(num2))
					{
						safeFloor.Remove(num2);
					}
					dangerousFloor.Enqueue(num2);
				}
				NovaLogger.Debug("咕噜海兔.并行脚本.危险地板数量为" + dangerousFloor.Count);
				_actor.logicVariable.SetLogicTagValue(logicTag, -1);
				int num3;
				int dequeueCount;
				FP fP;
				if ((_actor as MonsterAdventureActor).monsterInfo.Tag1.Equals(Tag_Hard))
				{
					num3 = triggerCount_H;
					dequeueCount = dequeueCount_H;
					fP = interval_H;
				}
				else
				{
					num3 = triggerCount_EN;
					dequeueCount = dequeueCount_EN;
					fP = interval_EN;
				}
				string[] array = new string[6]
				{
					"咕噜海兔.并行脚本.怪物标签为EN.危险地板元素为",
					num3.ToString(),
					",单次修复地板数量为",
					dequeueCount.ToString(),
					", 间隔:",
					null
				};
				FP fP2 = fP;
				array[5] = fP2.ToString();
				NovaLogger.Debug(string.Concat(array));
				if (dangerousFloor.Count > num3)
				{
					yield return _actor.WaitTime(fP);
					if (dequeueCount <= dangerousFloor.Count)
					{
						for (int j = 0; j < dequeueCount; j++)
						{
							int key = dangerousFloor.Dequeue();
							if (floorPOS.TryGetValue(key, out var value) && !safeFloor.ContainsKey(key))
							{
								safeFloor.Add(key, value);
							}
						}
					}
					else
					{
						NovaLogger.Debug("咕噜海兔.并行脚本.离队数量异常");
					}
					_actor.logicVariable.ToggleLogicTag("IsCloneUpdatePos", value: true);
				}
			}
			yield return null;
		}
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (adventureActorCustomEvent.eventName.Equals("HorizontalWave"))
		{
			int num = ((TSRandom.Range(0, 100) < 50) ? 1 : (-1));
			TSVector2 forward = TSVector2.left * num;
			TSVector2 item = new TSVector2(num * 8, 8);
			TSVector2 item2 = new TSVector2(num * 8, 0);
			TSVector2 item3 = new TSVector2(num * 8, -8);
			List<TSVector2> list = new List<TSVector2> { item, item2, item3 };
			if (monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Earse) || monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Normal))
			{
				List<int> list2 = new List<int> { 0, 1, 2 };
				int index = TSRandom.instance.Next(0, list2.Count);
				int index2 = list2.get_Item(index);
				list2.RemoveAt(index);
				CoroutineNode item4 = StartCoroutine(WaveAttack(list.get_Item(index2), forward, 0));
				corList.Add(item4);
				int index3 = TSRandom.instance.Next(0, list2.Count);
				int index4 = list2.get_Item(index3);
				item4 = StartCoroutine(WaveAttack(list.get_Item(index4), forward, 1));
				corList.Add(item4);
			}
			else if (monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Hard))
			{
				CoroutineNode item5 = StartCoroutine(WaveAttack(list.get_Item(0), forward, 0));
				corList.Add(item5);
				item5 = StartCoroutine(WaveAttack(list.get_Item(1), forward, 1));
				corList.Add(item5);
				item5 = StartCoroutine(WaveAttack(list.get_Item(2), forward, 2));
				corList.Add(item5);
			}
		}
		else if (adventureActorCustomEvent.eventName.Equals("VerticalWave"))
		{
			TSVector2 tSVector = new TSVector2(8, 8);
			TSVector2 tSVector2 = new TSVector2(-8, 8);
			if (monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Hard))
			{
				CoroutineNode item6 = StartCoroutine(WaveAttack(tSVector, TSVector2.down, 0));
				corList.Add(item6);
				item6 = StartCoroutine(WaveAttack(tSVector2, TSVector2.down, 1));
				corList.Add(item6);
			}
			else if (monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Earse) || monsterAdventureActor.monsterInfo.Tag1.Equals(Tag_Normal))
			{
				castTime++;
				FP fP = TSMath.Abs(tSVector.x - _actor.tsTransform.Position.x);
				FP fP2 = TSMath.Abs(tSVector2.x - _actor.tsTransform.Position.x);
				TSVector2 tSVector3 = ((fP > fP2) ? tSVector : tSVector2);
				TSVector2 tSVector4 = ((fP <= fP2) ? tSVector : tSVector2);
				TSVector2 beginPOS = ((castTime % 2 == 0) ? tSVector4 : tSVector3);
				CoroutineNode item7 = StartCoroutine(WaveAttack(beginPOS, TSVector2.down, 0));
				corList.Add(item7);
			}
		}
	}

	protected IEnumerator WaveAttack(TSVector2 beginPOS, TSVector2 forward, int waveIndex)
	{
		CommonUtils_MonsterAPI.PlayWwiseSound(_actor, "mon_17510_skywater_warning");
		List<TSVector2> warningFxPos = new List<TSVector2>();
		warningFxPos.AddRange(GetWarningFxPos(beginPOS, forward));
		List<long> warningFxID = new List<long>();
		for (int i = 0; i < warningFxPos.Count; i++)
		{
			warningFxID.Add(PlayEffect("fx_m17510_loop_Skill05_warning", 1.5f, 0.7, warningFxPos.get_Item(i), CommonUtils_MonsterAPI.GetTSVectToAngle(forward, 0)));
			yield return _actor.WaitTime(0.5f);
		}
		CoroutineNode item = StartCoroutine(FishJumpIn(beginPOS, forward));
		corList.Add(item);
		yield return _actor.WaitTime(0.3f);
		if (warningFxID != null && warningFxID.Count > 0)
		{
			for (int j = 0; j < warningFxID.Count; j++)
			{
				StopEffect(warningFxID.get_Item(j));
			}
		}
		_actor.logicVariable.ToggleLogicTag("AcitonFinish", value: true);
		TSVector2 shootPOS = TransLocalPosToWorldPos(beginPOS, forward, new TSVector2(0, -4.5));
		PlayEffect("fx_m17510_loop_Skill2_wave_bullet_start", 1f, 0.7, shootPOS, GetTSVectToAngle(forward, 0));
		yield return _actor.WaitTime(0.2f);
		RectangleMultipleShoot("GuLuHaiTu_WaveBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, awaitShootCompletion: true, 1, 0, shootPOS, 0.7, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 24, 0);
		yield return _actor.WaitTime(0.1f);
		item = StartCoroutine(FishMove(beginPOS, forward, waveIndex));
		corList.Add(item);
		yield return _actor.WaitTime(1);
		warningFxPos.Clear();
		warningFxID.Clear();
	}

	protected IEnumerator FishMove(TSVector2 initialPOS, TSVector2 forward, int waveIndex)
	{
		FP waitTime = 0.2;
		TSVector2 tSVector = new TSVector2(0, 0.7);
		TSVector2 tSVector2 = new TSVector2(0, -1.3);
		TSVector2 positionOffset = ((waveIndex % 2 == 0) ? tSVector : tSVector2);
		TSVector2 spawnPosition = TransLocalPosToWorldPos(initialPOS, forward, positionOffset);
		CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, 1, spawnPosition, forward, 10);
		yield return _actor.WaitTime(waitTime);
		_ = (FP)0.2;
		spawnPosition = TransLocalPosToWorldPos(initialPOS, forward, new TSVector2(0 + positionOffset.x, 17 * waitTime + positionOffset.y));
		CoroutineNode item = StartCoroutine(SummonFish(spawnPosition, forward));
		corList.Add(item);
	}

	protected IEnumerator SummonFish(TSVector2 csPOS, TSVector2 forward)
	{
		FP waititmg = 0.1;
		CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, 2, new TSVector2(csPOS.x, csPOS.y + 2.25), forward, 10);
		yield return _actor.WaitTime(waititmg);
		csPOS = TransLocalPosToWorldPos(csPOS, forward, new TSVector2(0, 17 * waititmg));
		CommonUtils_MonsterAPI.SummonTeammate(GetMonsterCloner() as MonsterAdventureActor, 2, new TSVector2(csPOS.x, csPOS.y - 2.25), forward, 10);
	}

	protected IEnumerator FishJumpIn(TSVector2 initialPOS, TSVector2 forward)
	{
		FP randomValue = GetRandomValue(-2, 2);
		FP randomValue2 = GetRandomValue(-2, 2);
		TSVector2 position = TransLocalPosToWorldPos(initialPOS, forward, new TSVector2(-2, -8 + randomValue));
		TSVector2 spawnDown = TransLocalPosToWorldPos(initialPOS, forward, new TSVector2(2, -8 + randomValue2));
		PlayEffect("fx_m17510_base_Skill03_fish_down", 1f, default, position);
		yield return _actor.WaitTime(0.07f);
		PlayEffect("fx_m17510_base_Skill03_fish_down", 1f, default, spawnDown);
	}

	private List<TSVector2> GetWarningFxPos(TSVector2 beginPOS, TSVector2 forward)
	{
		List<TSVector2> list = new List<TSVector2>();
		TSVector2 tSVector = beginPOS;
		for (int i = 0; i < 3; i++)
		{
			list.Add(tSVector);
			TSVector2 tSVector2 = tSVector;
			NovaLogger.Debug("咕噜海兔.通用API.预警位置" + tSVector2.ToString());
			tSVector = TransLocalPosToWorldPos(tSVector, forward, new TSVector2(0, 8));
		}
		return list;
	}

	protected AdventureActor GetMonsterCloner()
	{
		if (_actor is MonsterCloneAdventureActor monsterCloneAdventureActor)
		{
			return monsterCloneAdventureActor.summoner;
		}
		return _actor;
	}

	protected long PlayEffect(string fxAlias, float playbackSpeed = 1f, FP fxPositionY = default(FP), TSVector2 position = default(TSVector2), FP angle = default(FP), float spawnSize = 1f, bool actorScale = false)
	{
		PlayFX playFX = GeneratePlayFX();
		playFX.Play(spawnRotation: Quaternion.Euler(0f, 0f - (float)angle, 0f), actor: _actor, fxAlias: fxAlias, playbackSpeed: playbackSpeed, fxPositionY: fxPositionY, position: position, parent: null, spawnSize: spawnSize, actorScale: actorScale);
		return playFX.GetFxPlayerToken();
	}

	private PlayFX GeneratePlayFX()
	{
		PlayFX playFX = null;
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == 0L)
			{
				playFX = _playFXList.get_Item(i);
				break;
			}
		}
		if (playFX == null)
		{
			playFX = new PlayFX();
			_playFXList.Add(playFX);
		}
		return playFX;
	}

	protected void StopEffect(long id, bool stopSubFx = false)
	{
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == id)
			{
				if (stopSubFx)
				{
					_playFXList.get_Item(i).StopSubFx();
				}
				_playFXList.get_Item(i).Stop();
				_playFXList.get_Item(i).Clear();
				break;
			}
		}
	}

	protected TSVector2 TransLocalPosToWorldPos(TSVector2 csOrigin, TSVector2 csForward, TSVector2 relativePoint)
	{
		return CommonUtils_MonsterAPI.TransLocalPosToWorldPos(csOrigin, csForward, relativePoint);
	}

	protected FP GetRandomValue(FP minValue, FP maxValue, bool isInt = false)
	{
		return CommonUtils_MonsterAPI.GetRandomValue(minValue, maxValue, isInt);
	}

	protected FP GetTSVectToAngle(TSVector2 value, FP angle)
	{
		return CommonUtils_MonsterAPI.GetTSVectToAngle(value, angle);
	}

	protected void RectangleMultipleShoot(string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, bool awaitShootCompletion, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, FP width, FP length, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null)
	{
		MultipleShoot(HitBox.Shape.Rectangle, bulletAlias, multipleShootStyle, alignShoot, alignShootDelay, bulletCount, duration, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target, 0, width, length, 0, 0);
	}

	private void MultipleShoot(HitBox.Shape shape, string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, FP angle, FP width, FP length, FP radius, FP innerRadius, bool isTryShootAgain = false)
	{
		if (string.IsNullOrEmpty(bulletAlias) || bulletCount <= 0)
		{
			return;
		}
		GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, bulletAlias);
		if (bulletByAlias == null)
		{
			NovaLogger.Error(_actor.name + "子弹资源不存在：" + bulletAlias);
			return;
		}
		if (multiShootDirection.Equals(TSVector2.zero) || multiShootDirection.Equals(default))
		{
			multiShootDirection = _actor.tsTransform.Forward;
		}
		needTryShootAgain = (shape == HitBox.Shape.Circle || shape == HitBox.Shape.Fan) && bulletByAlias.GetComponent<AdventureProjectile>() != null;
		onceShootSuccessCount = 0;
		if (!isTryShootAgain && needTryShootAgain)
		{
			tryShootAgainFinish = false;
			currentTryShootTimes = 0;
			switch (shape)
			{
			case HitBox.Shape.Circle:
				tryShootTimes = (int)(long)(360 / tryAnglePerStep);
				break;
			case HitBox.Shape.Fan:
				tryShootTimes = (int)(long)(angle / tryAnglePerStep);
				break;
			}
			tShootParams = new TempMultiShootParams
			{
				shape = shape,
				bulletAlias = bulletAlias,
				multipleShootStyle = multipleShootStyle,
				alignShoot = alignShoot,
				alignShootDelay = alignShootDelay,
				bulletCount = bulletCount,
				duration = duration,
				shootPosition = shootPosition,
				shootPositionY = shootPositionY,
				multiShootDirection = multiShootDirection,
				bulletDirectionOffset = bulletDirectionOffset,
				aimType = aimType,
				bulletDirectionType = bulletDirectionType,
				targetPosition = targetPosition,
				target = target,
				angle = angle,
				width = width,
				length = length,
				radius = radius,
				innerRadius = innerRadius
			};
		}
		if (shootReq == null)
		{
			shootReq = new RequestDefaultState();
		}
		shootReq.Reset();
		if (duration > 0f)
		{
			CoroutineNode item = StartCoroutine(_actor.shootBehaviour.MultipleShoot(shape, bulletByAlias, bulletCount, width, length, angle, radius, innerRadius, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, multipleShootStyle, duration, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, ShootFinish, useRef: false, OnShootBulletBorn));
			corList.Add(item);
			return;
		}
		int num = _actor.shootBehaviour.QueryMultipleShootWaveCount(shape, multipleShootStyle, bulletCount);
		int waveIndex = 0;
		while (waveIndex < num)
		{
			_actor.shootBehaviour.MultipleShoot(shape, bulletByAlias, bulletCount, width, length, angle, radius, innerRadius, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, multipleShootStyle, ref waveIndex, 0f, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, OnShootBulletBorn);
		}
		ShootFinish();
	}

	private void OnShootBulletBorn(long bulletId)
	{
		if (bulletId > 0)
		{
			onceShootSuccessCount++;
			_bulletIdList.Add(bulletId);
		}
	}

	private IEnumerator _waitShoot(BaseNormalStatus normalStatus)
	{
		if (shootReq != null)
		{
			while (shootReq.defalutStatus != normalStatus)
			{
				yield return null;
			}
		}
	}

	private void ShootFinish()
	{
		if (needTryShootAgain && !tryShootAgainFinish && onceShootSuccessCount <= 0)
		{
			TSVector2 multiShootDirection = TSVector2.Rotate(tShootParams.multiShootDirection, tryAnglePerStep);
			currentTryShootTimes++;
			if (currentTryShootTimes >= tryShootTimes)
			{
				tryShootAgainFinish = true;
			}
			tShootParams.multiShootDirection = multiShootDirection;
			MultipleShoot(tShootParams.shape, tShootParams.bulletAlias, tShootParams.multipleShootStyle, tShootParams.alignShoot, tShootParams.alignShootDelay, tShootParams.bulletCount, tShootParams.duration, tShootParams.shootPosition, tShootParams.shootPositionY, tShootParams.multiShootDirection, tShootParams.bulletDirectionOffset, tShootParams.aimType, tShootParams.bulletDirectionType, tShootParams.targetPosition, tShootParams.target, tShootParams.angle, tShootParams.width, tShootParams.length, tShootParams.radius, tShootParams.innerRadius, isTryShootAgain: true);
		}
		else
		{
			shootReq.defalutStatus = BaseNormalStatus.Complete;
		}
	}

	private void ClearShoot()
	{
		_bulletIdList?.Clear();
	}
}
