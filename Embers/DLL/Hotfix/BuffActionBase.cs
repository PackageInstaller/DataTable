using System.Collections.Generic;
using Ase;
using GameFramework;

public class BuffActionBase : IReference
{
	protected BuffActionTypeEnum actionType;

	public virtual void OnInit(Buff buff, List<float> actionParams)
	{
		actionType = BuffActionTypeEnum.None;
	}

	public virtual void OnReset(Buff buff)
	{
	}

	public virtual void OnExcute(Buff buff)
	{
	}

	public virtual bool ContainsAction(BuffActionTypeEnum buffActionType)
	{
		return actionType == buffActionType;
	}

	public static BuffActionBase GetBuffAction(BuffActionTypeEnum actionType)
	{
		return actionType switch
		{
			BuffActionTypeEnum.LayerChangedEffect => ReferencePool.Acquire<BuffActionLayerChangedEffect>(), 
			BuffActionTypeEnum.LayerModifyEffect => ReferencePool.Acquire<BuffActionLayerModifyEffect>(), 
			_ => new BuffActionBase(), 
		};
	}

	public virtual void Clear()
	{
	}
}
