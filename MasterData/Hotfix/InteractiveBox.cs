using Nova.Hotfix;
using UnityEngine.Playables;

public class InteractiveBox : InteractiveBase
{
	protected TreasureBoxSpawnPoint.TreasureBoxSpawnInfo _boxSpawnInfo;

	protected bool autoOpen;

	public void InitInteractiveBox(Chest data, TreasureBoxSpawnPoint.TreasureBoxSpawnInfo boxSpawnInfo)
	{
		_boxSpawnInfo = boxSpawnInfo;
		iId = data.Id;
		autoOpen = data.AutoOpen > 0;
		if (!autoOpen)
		{
			_interactiveState = boxSpawnInfo.interactiveState;
			base.initState();
			interCollider.ActiveSelf = true;
		}
		else
		{
			AutoOpen();
		}
	}

	public override string GetInteractiveID()
	{
		if (string.IsNullOrEmpty(_uid))
		{
			_uid = $"{iId}{uid}";
		}
		return _uid;
	}

	public override string GetBoxName()
	{
		return _boxSpawnInfo.name;
	}

	public override bool IsBox()
	{
		return true;
	}

	protected void AutoOpen()
	{
		_interactiveState = InteractiveManager.interactiveState.active0;
		base.initState();
		SetProcessState(InteractiveManager.processState.state1);
	}

	protected override bool initState()
	{
		return true;
	}

	protected override void onPlayableDirComplete()
	{
		bool num = interOperatons.Count > 0 && interOperatons.get_Item(0).isOpen0p();
		base.onPlayableDirComplete();
		if (num)
		{
			_director.extrapolationMode = DirectorWrapMode.Hold;
			SetProcessState(InteractiveManager.processState.destroy, () =>
			{
				AdventureTreasureBoxDespawnEvent adventureTreasureBoxDespawnEvent = AdventureTreasureBoxDespawnEvent.Generate();
				adventureTreasureBoxDespawnEvent.uniqueID = getUID();
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTreasureBoxDespawnEvent);
			});
			if (_actor != null)
			{
				_actor.ExitInteractive();
			}
			showGetItem();
		}
	}

	protected virtual long getUID()
	{
		return _boxSpawnInfo.uniqueID;
	}

	protected override void playAnimation()
	{
		base.playAnimation();
		showGetItem();
	}

	protected virtual void showGetItem()
	{
		if (_actor != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance?.WwiseVoice_Play(_actor.dataID, "chest");
		}
		MonoSingleton<LuaManager>.Instance?.FireEvent("InteractiveBoxGet", _boxSpawnInfo.indexOfMainline, _boxSpawnInfo.isRdmRef, (int)_boxSpawnInfo.boxLv, _boxSpawnInfo.prizeType);
	}

	protected void WwiseEvent(string eventName)
	{
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName);
	}
}
