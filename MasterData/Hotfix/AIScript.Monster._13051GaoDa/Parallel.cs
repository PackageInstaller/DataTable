using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._13051GaoDa;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.GaoDa_001;

	private static readonly List<int> killTeammateIndex_1 = new List<int> { 1, 2 };

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.GaoDa_002;

	private static readonly int checkHitTag_2 = CommonHelper.StringToHash("UltraLaser");

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.GaoDa_003;

	private bool _achievementTypeFinish_1;

	private List<int> _teammateDead_1;

	private bool _achievementTypeFinish_2;

	private bool _achievementTypeFinish_3;

	private bool _canFinishAchievementType_3;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.GaoDa_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.GaoDa_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.GaoDa_003);
		_canFinishAchievementType_3 = true;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is MonsterAdventureActor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor)
		{
			if (!_achievementTypeFinish_2 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, checkHitTag_2))
			{
				_achievementTypeFinish_2 = SetAchievementState(HotfixEnum.questCompleteCondClient.GaoDa_002);
			}
			if (!_achievementTypeFinish_3 && _canFinishAchievementType_3)
			{
				_canFinishAchievementType_3 = adventureActorReceiveDamageEvent.damageToShieldAndHp <= 0;
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (!(adventureActorDiedEvent.actor is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (adventureActorDiedEvent.killer != _actor && !_achievementTypeFinish_1)
		{
			for (int i = 0; i < killTeammateIndex_1.Count; i++)
			{
				int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, killTeammateIndex_1.get_Item(i));
				List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
				MonsterAdventureActor monsterAdventureActor2 = ((list.Count > 0) ? (list.get_Item(0) as MonsterAdventureActor) : null);
				if (monsterAdventureActor2 == monsterAdventureActor)
				{
					if (_teammateDead_1 != null)
					{
						_teammateDead_1.Add(monsterAdventureActor2.dataID);
						break;
					}
					_teammateDead_1 = new List<int> { monsterAdventureActor2.dataID };
					break;
				}
			}
		}
		if (!(adventureActorDiedEvent.actor == _actor))
		{
			return;
		}
		if (!_achievementTypeFinish_1)
		{
			List<int> teammateDead_ = _teammateDead_1;
			if (teammateDead_ != null && teammateDead_.Count > 0 && _teammateDead_1.Count == killTeammateIndex_1.Count)
			{
				_achievementTypeFinish_1 = SetAchievementState(HotfixEnum.questCompleteCondClient.GaoDa_001);
			}
		}
		if (!_achievementTypeFinish_3 && _canFinishAchievementType_3)
		{
			SetAchievementState(HotfixEnum.questCompleteCondClient.GaoDa_003);
		}
	}

	private bool SetAchievementState(HotfixEnum.questCompleteCondClient achievementType)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType))
		{
			return true;
		}
		ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(achievementType);
		return ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_teammateDead_1?.Clear();
		_canFinishAchievementType_3 = false;
	}
}
