namespace BilliardGame.Spell;

public class BTMakeAudioNode : BActionNode
{
	public string audioName;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameAudioManager.PlayAudioByName(audioName);
		return BTNodeStatus.Success;
	}
}
