using System.Collections.Generic;
using TrueSync;

public class AdventureActorCustomEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public string eventName;

	public int eventHashCode;

	public List<int> intParamList;

	public List<string> stringParamList;

	public List<TSVector2> tsVector2ParamList;

	public bool boolParam;

	public FP fpParam;

	public int intParam;

	public LogicEntity target;

	public static AdventureActorCustomEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorCustomEvent>("ACTOR_CUSTOM_EVENT");
	}

	public AdventureActorCustomEvent()
		: base("ACTOR_CUSTOM_EVENT")
	{
	}

	public override void Clear()
	{
		actor = null;
		eventName = null;
		eventHashCode = 0;
		intParamList?.Clear();
		stringParamList?.Clear();
		tsVector2ParamList?.Clear();
		boolParam = false;
		fpParam = 0;
		intParam = 0;
		target = null;
	}
}
