using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Dead : SkillAdvancedBase
{
	private const string AVG_START = "StoryDialog_DialogStart";

	private const string AVG_END = "StoryDialog_DialogEnd";

	private string dialogID = "ST1207";

	private FP loopTime = 2;

	private bool avgFinish;

	private readonly PlayMonsterTimeline _playTimeline = new PlayMonsterTimeline();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	private void Clear()
	{
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			DoMainLogic();
		}, () =>
		{
			DoMainLogic();
		}, 1);
	}

	private void DoMainLogic()
	{
		AdventureChangeLevelStateEvent adventureChangeLevelStateEvent = AdventureChangeLevelStateEvent.Generate();
		adventureChangeLevelStateEvent.levelState = HotfixEnum.levelState.Success;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureChangeLevelStateEvent);
		_skill?.Clear();
	}

	protected override void OnActorDied(IEvent evt)
	{
		if (_actor != null)
		{
			_ = _actor == (evt as AdventureActorDiedEvent).actor;
		}
	}
}
