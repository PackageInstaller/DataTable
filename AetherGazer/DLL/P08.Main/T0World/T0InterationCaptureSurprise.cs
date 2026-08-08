using System;

namespace T0World;

[Serializable]
public class T0InterationCaptureSurprise : T0InterationConditionBaseData
{
	public override bool CheckIsArriveCondition()
	{
		if (onlyOne && T0WorldScene.Scene.dataContext.CheckIsHaveKey(GetHashCode().ToString()))
		{
			return false;
		}
		bool num = T0WorldScene.Scene.dataContext.CheckIsHaveKey("CaptureSurpriseBeginState");
		bool flag = T0WorldScene.Scene.dataContext.CheckIsHaveKey("captureSurpriseEndStateKey");
		if (num && !flag)
		{
			T0WorldScene.Scene.dataContext.RecordCount("captureSurpriseEndStateKey");
			return true;
		}
		return false;
	}
}
