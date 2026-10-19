using ACT.Model;
using UnityEngine;

namespace ACT.Config.Action;

public class SetGuideDefaultSelectCharacter : GuideStepAction
{
	[SerializeField]
	private int _characterId;

	public override void Execute(GuideStepData data)
	{
		Model<TeamModel>.Interface.SetGuideDefaultSelectCharacter(_characterId);
	}
}
