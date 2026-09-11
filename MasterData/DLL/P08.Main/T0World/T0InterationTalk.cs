using System;

namespace T0World;

[Serializable]
public class T0InterationTalk : T0InterationFunctionDataBase
{
	public string voiceName;

	public int voiceRoleID = -1;

	public int talkLabelDelay;

	public bool isNoWait;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		int num = -1;
		if (voiceRoleID > 0)
		{
			num = voiceRoleID;
		}
		else if (behaviour.mAgent is T0CharacterAgent t0CharacterAgent && t0CharacterAgent.CharacterBoard != null)
		{
			num = t0CharacterAgent.CharacterBoard.characterID;
		}
		if (isNoWait)
		{
			LuaHelper.CallFunction("T0WorldStartTalk", behaviour.animator.transform, num, voiceName, talkLabelDelay);
			base.IsFinish = true;
			return;
		}
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		LuaHelper.CallFunction("T0WorldStartTalk", behaviour.animator.transform, num, voiceName, talkLabelDelay, callback);
	}
}
