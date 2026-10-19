using ACT.Model;
using UnityEngine;

namespace ACT.Config.Action;

public class SetGuideDefaultSelectAddCharacterBtn : GuideStepAction
{
	[SerializeField]
	private int _index;

	public override void Execute(GuideStepData data)
	{
		Model<TeamModel>.Interface.SetGuideDefaultSelectAddCharacterBtn(_index);
	}
}
