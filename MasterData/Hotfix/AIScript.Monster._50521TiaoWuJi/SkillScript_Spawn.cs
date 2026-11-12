using AdventureBehaviour;

namespace AIScript.Monster._50521TiaoWuJi;

public class SkillScript_Spawn : SkillAdvancedBase
{
	public void OnStart()
	{
		_actor.Hide();
		PlayMonsterTimeline playMonsterTimeline = new PlayMonsterTimeline();
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		playMonsterTimeline.Play(_actor, () =>
		{
			_actor.Visible();
			_skill?.Clear();
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		});
	}
}
