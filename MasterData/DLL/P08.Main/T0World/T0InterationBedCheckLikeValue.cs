using System;

namespace T0World;

[Serializable]
public class T0InterationBedCheckLikeValue : T0InterationConditionBaseData
{
	public int checkMeetValue = 100;

	public bool checkIsFirstArrive = true;

	public override bool CheckIsArriveCondition()
	{
		if (checkIsFirstArrive)
		{
			if (T0BedGame.bedGame.CheckIsMeetLikeFirstArrive(checkMeetValue))
			{
				return true;
			}
		}
		else if (T0BedGame.bedGame.CheckIsMeetLikeValue(checkMeetValue))
		{
			return true;
		}
		return false;
	}
}
