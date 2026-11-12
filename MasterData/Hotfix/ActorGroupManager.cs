using System.Collections.Generic;

public class ActorGroupManager : SceneSingleton<ActorGroupManager>
{
	protected LogManager.Logger _logger;

	protected readonly Stack<AdventureActor.MoveFeatureData> _moveFeatureDatas = new Stack<AdventureActor.MoveFeatureData>(8);

	public Dictionary<string, AdventureEntityGroup> entityGroups { get; } = new Dictionary<string, AdventureEntityGroup>(15);

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("ActorGroupManager");
	}

	protected void Start()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_END", OnLevelStop);
	}

	protected void OnLevelStop(IEvent evt)
	{
		ClearActorGroups();
	}

	public void UpdateActorGroups()
	{
		SceneSingleton<AdventurePlayerController>.Instance.LogicUpdate();
	}

	public void ClearActorGroups()
	{
		entityGroups.Clear();
	}

	public AdventureEntityGroup AddOrGetEntityGroup(string groupID)
	{
		AdventureEntityGroup adventureEntityGroup = QueryEntityGroupByID(groupID);
		if (adventureEntityGroup != null)
		{
			return adventureEntityGroup;
		}
		AdventureEntityGroup adventureEntityGroup2 = new AdventureEntityGroup(groupID);
		entityGroups.Add(groupID, adventureEntityGroup2);
		return adventureEntityGroup2;
	}

	public AdventureEntityGroup QueryEntityGroupByID(string groupID)
	{
		if (string.IsNullOrEmpty(groupID))
		{
			_logger.LogError("组ID为空");
			return null;
		}
		if (!entityGroups.TryGetValue(groupID, out var value))
		{
			return null;
		}
		return value;
	}

	public AdventureActor.MoveFeatureData PopMoveFData()
	{
		if (_moveFeatureDatas.Count <= 0)
		{
			return new AdventureActor.MoveFeatureData();
		}
		return _moveFeatureDatas.Pop();
	}

	public void PushMoveFData(AdventureActor.MoveFeatureData moveData)
	{
		moveData.OnEnd();
		_moveFeatureDatas.Push(moveData);
	}
}
