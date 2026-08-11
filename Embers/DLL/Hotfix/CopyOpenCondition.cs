using System;
using Ase;

[Serializable]
public class CopyOpenCondition : ParadoxParamterConditionBase
{
	public CheckType CheckType;

	public int CheckValue;

	public override bool SatisfyCondition(object data)
	{
		if (!(data is SceneSystem sceneSystem))
		{
			return false;
		}
		TaskSystem system = sceneSystem.GetSystem<TaskSystem>();
		if (system == null)
		{
			return false;
		}
		int currentCopyOpen = system.GetCurrentCopyOpen();
		switch (CheckType)
		{
		case CheckType.Equal:
			if (currentCopyOpen == CheckValue)
			{
				return true;
			}
			break;
		case CheckType.Greater:
			if (currentCopyOpen > CheckValue)
			{
				return true;
			}
			break;
		case CheckType.Less:
			if (currentCopyOpen < CheckValue)
			{
				return true;
			}
			break;
		case CheckType.GreaterEqual:
			if (currentCopyOpen >= CheckValue)
			{
				return true;
			}
			break;
		case CheckType.LessEqual:
			if (currentCopyOpen <= CheckValue)
			{
				return true;
			}
			break;
		}
		return false;
	}
}
