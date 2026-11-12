#define LOG_ERROR
using System.Collections.Generic;

public class DormFurObjStateMgr
{
	private DormFurObj owner;

	private Dictionary<DormFurObj.DormFurObjState, IDormFurObjFSM> fsmDic;

	private IDormFurObjFSM curFSM;

	public DormFurObj.DormFurObjState State
	{
		get
		{
			if (curFSM != null)
			{
				return (DormFurObj.DormFurObjState)curFSM.State;
			}
			return DormFurObj.DormFurObjState.None;
		}
	}

	public DormFurObjStateMgr(DormFurObj owner)
	{
		this.owner = owner;
	}

	public void Register(DormFurObj.DormFurObjState state)
	{
		if (fsmDic == null)
		{
			fsmDic = new Dictionary<DormFurObj.DormFurObjState, IDormFurObjFSM>();
		}
		if (!fsmDic.TryGetValue(state, out var _))
		{
			switch (state)
			{
			case DormFurObj.DormFurObjState.None:
				fsmDic.Add(state, new DormFurObjFSM(owner, (int)state));
				break;
			case DormFurObj.DormFurObjState.Idle:
				fsmDic.Add(state, new DormFurObjFSM_Idle(owner, (int)state));
				break;
			case DormFurObj.DormFurObjState.Interactive:
				fsmDic.Add(state, new DormFurObjFSM_Interactive(owner, (int)state));
				break;
			case DormFurObj.DormFurObjState.Decorate:
				fsmDic.Add(state, new DormFurObjFSM_Decorate(owner, (int)state));
				break;
			default:
				NovaLogger.Error($"错误的后宅家具状态类型:{state}");
				break;
			}
		}
		else
		{
			NovaLogger.Error($"重复注册已有的后宅家具状态类型:{state}");
		}
	}

	public IDormFurObjFSM GetFSM(DormFurObj.DormFurObjState state)
	{
		if (fsmDic == null)
		{
			return null;
		}
		if (!fsmDic.TryGetValue(state, out var value))
		{
			return null;
		}
		return value;
	}

	public void UnRegister(DormFurObj.DormFurObjState state)
	{
		IDormFurObjFSM value;
		if (fsmDic == null)
		{
			NovaLogger.Error("后宅家具状态机为空!");
		}
		else if (!fsmDic.TryGetValue(state, out value))
		{
			NovaLogger.Error($"后宅家具状态机不包含状态:{state}!");
		}
		else
		{
			fsmDic.Remove(state);
		}
	}

	public void Switch(DormFurObj.DormFurObjState state, object data = null)
	{
		if (!fsmDic.TryGetValue(state, out var value))
		{
			NovaLogger.Error($"后宅家具{owner.name}不包含该状态机:{state}");
			return;
		}
		if (curFSM != null)
		{
			if (state == (DormFurObj.DormFurObjState)curFSM.State)
			{
				NovaLogger.Error($"后宅家具{owner.name}重复进入状态机:{state}");
				return;
			}
			curFSM.OnExit();
		}
		curFSM = value;
		value.OnEnter(data);
	}

	public void Update()
	{
		curFSM?.OnUpdate();
	}

	public void LateUpdate()
	{
		curFSM?.OnLateUpdate();
	}
}
