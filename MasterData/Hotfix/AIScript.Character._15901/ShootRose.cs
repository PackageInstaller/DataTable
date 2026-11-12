using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class ShootRose
{
	public ParallelScript_Support aiBase;

	public AdventureActor _actor;

	public long uid;

	private Dictionary<int, long> dicAllArea = new Dictionary<int, long>();

	private List<AdventureBulletBase> bulletList = new List<AdventureBulletBase>();

	private Dictionary<int, RoseInfo> dicCache = new Dictionary<int, RoseInfo>();

	private CoroutineNode corCast;

	private int castCount;

	private bool castAll;

	private bool isBoss;

	public int RoseCount;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		foreach (AdventureBulletBase bullet in bulletList)
		{
			if (bullet != null && !bullet.isFinished)
			{
				bullet.Kill();
			}
		}
		foreach (KeyValuePair<int, long> item in dicAllArea)
		{
			ILRuntimeAPI.StopAreaEffect(item.Value);
		}
		bulletList.Clear();
		dicAllArea.Clear();
		dicCache.Clear();
		if (corCast != null)
		{
			_actor.StopLogicCoroutine(corCast);
			corCast = null;
		}
		aiBase = null;
		_actor = null;
	}

	public void Shoot(ParallelScript_Support ai, AdventureActor owner)
	{
		RoseCount = 0;
		_actor = owner;
		aiBase = ai;
		OnEnable();
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget != null && assistantAttackTarget is MonsterAdventureActor entity && entity.IsBossMonster())
		{
			isBoss = true;
		}
		else
		{
			isBoss = false;
		}
		corCast = owner.StartLogicCoroutine(DoCastAgentia(), runImmediately: true);
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (_actor != null && adventureBulletFinishEvent.owner != null && adventureBulletFinishEvent.owner.Id == _actor.Id)
		{
			OnBulletFinish(adventureBulletFinishEvent);
		}
	}

	private void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
		if (evt.bulletHashCode == Conifg_Support.bullutTag_A || evt.bulletHashCode == Conifg_Support.bullutTag_B)
		{
			AdventureBulletBase adventureBulletBase = evt.sender as AdventureBulletBase;
			if (adventureBulletBase != null && evt.finishReason != BulletFinishReason.Kill && adventureBulletBase.tagUid == uid)
			{
				CommonUtils.TryParseStringParamToInt(adventureBulletBase.weaponTag, out var intValue);
				RoseInfo roseInfo = new RoseInfo();
				roseInfo.pos = adventureBulletBase.tsTransform.Position;
				roseInfo.isA = evt.bulletHashCode == Conifg_Support.bullutTag_A;
				roseInfo.isDirty = false;
				dicCache.Add(intValue, roseInfo);
				castCount++;
				castAll = castCount >= 7;
			}
		}
	}

	private IEnumerator DoCastAgentia()
	{
		castAll = false;
		castCount = 0;
		HashSet<int> hashRandom = new HashSet<int>();
		if (GetPerk(aiBase.perkId_23))
		{
			var (item, item2, item3) = Random3();
			hashRandom.Add(item);
			hashRandom.Add(item2);
			hashRandom.Add(item3);
		}
		else
		{
			int item4 = TSRandom.Range(0, 7);
			hashRandom.Add(item4);
		}
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Forward * Conifg_Support.offset_start;
		TSVector2 tSVector2 = _actor.tsTransform.Position + _actor.tsTransform.Forward * (isBoss ? Conifg_Support.offset_end_boss : Conifg_Support.offset_end_normal);
		FP fP = (isBoss ? Conifg_Support.bulletSpd_boss : Conifg_Support.bulletSpd_normal);
		FP fP2 = (tSVector2 - tSVector).magnitude / fP;
		for (int i = 0; i < 7; i++)
		{
			FP degrees = Conifg_Support.startAngle + _actor.tsTransform.Rotation + (i - 1) * 60;
			TSVector2 tSVector3 = TSVector2.Rotate(TSVector2.up, degrees);
			TSVector2 tSVector4 = tSVector2 + ((i == 0) ? TSVector2.zero : (tSVector3 * Conifg_Support.radius));
			tSVector3 = (tSVector4 - tSVector).normalized;
			_ = (tSVector4 - tSVector).magnitude;
			string bulletAlias = (hashRandom.Contains(i) ? Conifg_Support.bulletKey_B : Conifg_Support.bulletKey_A);
			FP fP3 = TSVector2.Distance(tSVector, tSVector4);
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, fP3, tSVector3, tSVector, 4);
			adventureBulletBase.weaponTag = $"{i}";
			adventureBulletBase.tagUid = uid;
			adventureBulletBase.velocitySpeed = fP3 / fP2;
			(adventureBulletBase as AdventureProjectile).CustomMinJumpDuration = fP2;
			bulletList.Add(adventureBulletBase);
		}
		while (!castAll)
		{
			yield return null;
		}
		if (GetPerk(aiBase.perkId_23))
		{
			foreach (KeyValuePair<int, RoseInfo> item5 in dicCache.Where((KeyValuePair<int, RoseInfo> keyValuePair) => hashRandom.Contains(keyValuePair.Key)).ToList())
			{
				int key = item5.Key;
				if (key == 0)
				{
					for (int num = 1; num < 7; num++)
					{
						DoDirty(0, num);
					}
					continue;
				}
				int num2 = 6;
				int num3 = key - 1;
				int to = (num3 - 1 + num2) % num2 + 1;
				int to2 = (num3 + 1) % num2 + 1;
				int to3 = 0;
				DoDirty(key, to);
				DoDirty(key, to2);
				DoDirty(key, to3);
			}
		}
		foreach (KeyValuePair<int, RoseInfo> item6 in dicCache)
		{
			RoseInfo value = item6.Value;
			int index = item6.Key;
			string fxAlias;
			if (value.isA)
			{
				if (value.isDirty)
				{
					fxAlias = aiBase.areaEffect_B_23;
				}
				else
				{
					fxAlias = (GetPerk(aiBase.perkId_22) ? aiBase.areaEffect_A_22 : Conifg_Support.areaEffect_A);
					RoseCount++;
				}
			}
			else
			{
				fxAlias = Conifg_Support.areaEffect_B;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, value.pos, value.dir.GetAngle(), null, null, (AreaEffectEntity entity) =>
			{
				if (GetPerk(aiBase.perkId_24))
				{
					if (!GetPerk(aiBase.perkId_22) || !entity.areaTag.Equals(Conifg_Support.areaTag_A))
					{
						entity.ModifyLeftTime(aiBase.leftTime_24);
					}
					AreaEffect_PlayFxComponent component = entity.GetComponent<AreaEffect_PlayFxComponent>();
					if (component != null)
					{
						if (entity.areaTag == Conifg_Support.areaTag_A || entity.areaTag == Conifg_Support.areaTag_B)
						{
							component.loopPlaySpeed = Conifg_Support.fxPlaySpeed_P24_AB;
						}
						if (GetPerk(aiBase.perkId_22))
						{
							if (entity.areaTag == Conifg_Support.areaTag_A)
							{
								component.loopPlaySpeed = Conifg_Support.fxPlaySpeed_P22_24_A;
							}
							else if (entity.areaTag == Conifg_Support.areaTag_B)
							{
								component.loopPlaySpeed = Conifg_Support.fxPlaySpeed_P22_24_B;
							}
						}
					}
				}
				dicAllArea.Add(index, entity.Id);
			});
		}
	}

	private void DoDirty(int from, int to)
	{
		dicCache.TryGetValue(from, out var value);
		dicCache.TryGetValue(to, out var value2);
		if (value != null && value2 != null && !value2.isDirty && value2.isA)
		{
			value2.isDirty = true;
			value2.dir = value2.pos - value.pos;
		}
	}

	private (int first, int second, int third) Random3()
	{
		List<int> list = new List<int> { 0, 1, 2, 3, 4, 5, 6 };
		int index = TSRandom.instance.Next(0, list.Count);
		int item = list.get_Item(index);
		list.RemoveAt(index);
		int index2 = TSRandom.instance.Next(0, list.Count);
		int item2 = list.get_Item(index2);
		list.RemoveAt(index2);
		int index3 = TSRandom.instance.Next(0, list.Count);
		int item3 = list.get_Item(index3);
		list.RemoveAt(index3);
		return (first: item, second: item2, third: item3);
	}

	private bool GetPerk(int perkId)
	{
		return aiBase.GetPerkByShoot(perkId);
	}

	public void Finish()
	{
		OnDisable();
	}
}
