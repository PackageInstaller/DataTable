using System.Collections.Generic;
using Ase;
using Ase.ECS;

public class AchievementSystem : BaseSystem, IObserverHandler
{
	private Dictionary<BattleObserverEventEnum, AchievementProcessor> _achievementActionDataDic;

	private List<Achievement> _settlementAchievementDic;

	protected override bool IsLogicSystem => false;

	public Dictionary<BattleObserverEventEnum, AchievementProcessor> AchievementActionDataDic => _achievementActionDataDic;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_achievementActionDataDic = new Dictionary<BattleObserverEventEnum, AchievementProcessor>();
		_settlementAchievementDic = new List<Achievement>();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.Any, this);
	}

	public void OnNotify(IObserverParams param)
	{
		_achievementActionDataDic.TryGetValue(param.ObserverEventType, out var value);
		if (value != null)
		{
			value.Processor(param);
			value.VerityAchievement();
		}
	}

	public void InitAchievementAction(List<AchievementMedal> achievementMedalList)
	{
		if (achievementMedalList == null)
		{
			return;
		}
		for (int i = 0; i < achievementMedalList.Count; i++)
		{
			AchievementMedal achievementMedal = achievementMedalList[i];
			if (!_achievementActionDataDic.TryGetValue(achievementMedal.BattleObserverEventEnum, out var value))
			{
				value = GenerateProcessor(achievementMedal.BattleObserverEventEnum);
				if (value == null)
				{
					break;
				}
				_achievementActionDataDic.Add(achievementMedal.BattleObserverEventEnum, value);
			}
			Achievement achievement = value.RegisterAchievementMedal(achievementMedal);
			if (achievement is SettlementAchievement)
			{
				_settlementAchievementDic.Add(achievement);
			}
		}
	}

	public void CreateAchievementAction(AchievementMedal achievementMedal)
	{
		if (!_achievementActionDataDic.TryGetValue(achievementMedal.BattleObserverEventEnum, out var value))
		{
			value = GenerateProcessor(achievementMedal.BattleObserverEventEnum);
			if (value == null)
			{
				return;
			}
			_achievementActionDataDic.Add(achievementMedal.BattleObserverEventEnum, value);
		}
		value.RegisterAchievementMedal(achievementMedal);
	}

	public void DoubleVerityAchievement(Dictionary<int, int> conditionParams)
	{
		for (int i = 0; i < _settlementAchievementDic.Count; i++)
		{
			_settlementAchievementDic[i].DoubleVerityAchievement(conditionParams);
		}
	}

	private AchievementProcessor GenerateProcessor(BattleObserverEventEnum battleObserverEventEnum)
	{
		return battleObserverEventEnum switch
		{
			BattleObserverEventEnum.InteractiveSuccess => new InteractiveAchievementProcessor(), 
			BattleObserverEventEnum.ReleaseSkill => new SkillAchievementProcessor(), 
			BattleObserverEventEnum.Hit => new HitAchievementProcessor(), 
			BattleObserverEventEnum.ChangeState => new StateAchievementProcessor(), 
			BattleObserverEventEnum.ExcuteBuff => new BuffAchievementProcessor(), 
			BattleObserverEventEnum.RescueSuccess => new RescueSuccessProcessor(), 
			BattleObserverEventEnum.Recover => new TreatmentProcessor(), 
			_ => null, 
		};
	}

	public void ClearData()
	{
		_achievementActionDataDic?.Clear();
		_settlementAchievementDic?.Clear();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (AchievementProcessor value in _achievementActionDataDic.Values)
		{
			value.Clear();
		}
		_achievementActionDataDic.Clear();
		_achievementActionDataDic = null;
	}
}
