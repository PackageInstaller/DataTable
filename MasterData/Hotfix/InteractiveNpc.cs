using Nova.Hotfix;
using UnityEngine;
using UnityEngine.Playables;

public class InteractiveNpc : InteractiveBase
{
	public int _npcID;

	protected NPCConfig npcConfig;

	public NPCSkin npcSkin;

	protected override void OnActive()
	{
		EnableLogicUpdate();
		if (interConfig == null)
		{
			interConfig = Singleton<HotfixDataController>.Instance.GetInteractiveAction(dataId);
		}
		regestListener(active: true);
		iId = (int)Id;
		Singleton<InteractiveManager>.Instance.AddInteractiveObj(this);
		initState();
		if (!interCollider.ActiveSelf)
		{
			interCollider.ActiveSelf = true;
		}
	}

	protected override bool initState()
	{
		if (npcConfig == null)
		{
			npcConfig = Singleton<HotfixDataController>.Instance.GetNPCConfig(_npcID);
		}
		return base.initState();
	}

	protected override bool iSwich()
	{
		return true;
	}

	protected override void onPlayableDirComplete()
	{
		base.onPlayableDirComplete();
		if (interOperatons.Count > 0 && interOperatons.get_Item(0).isNpcOp())
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("InteractiveNpc", _npcID, GetInteractiveID());
		}
	}

	public void SyncPosition(Vector3 position)
	{
		interCollider.SyncPosition(position);
		npcConfig = Singleton<HotfixDataController>.Instance.GetNPCConfig(_npcID);
		if (npcSkin != null)
		{
			interConfig = Singleton<HotfixDataController>.Instance.GetInteractiveAction(npcSkin.InteractiveActionId);
		}
	}

	public override bool getUIActiveState()
	{
		if (base.getUIActiveState())
		{
			if (npcSkin == null)
			{
				return true;
			}
			return npcSkin.InteractiveAction;
		}
		return false;
	}

	public void setNpcState()
	{
		if (npcConfig == null)
		{
			npcConfig = Singleton<HotfixDataController>.Instance.GetNPCConfig(_npcID);
		}
		if (npcConfig != null)
		{
			interOperatons.Clear();
			SetProcessState(InteractiveManager.processState.deactive);
		}
		if (npcConfig != null)
		{
			_director.extrapolationMode = DirectorWrapMode.Hold;
			SetProcessState(InteractiveManager.processState.destroy, () =>
			{
				gameObject.SetActive(value: false);
			});
		}
	}
}
