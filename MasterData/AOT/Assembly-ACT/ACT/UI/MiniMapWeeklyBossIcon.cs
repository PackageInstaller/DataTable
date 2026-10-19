using ACT.Battle;
using ACT.Config;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class MiniMapWeeklyBossIcon : MiniMapIcon
{
	[SerializeField]
	private GameObject _unlockRoot;

	[SerializeField]
	private GameObject _lockRoot;

	[SerializeField]
	private Animation _animation;

	private int _unlockInteractObjUid;

	private int _unlockFogId;

	private bool _fogUnlock;

	private bool _objUnlock;

	public void Init(MapConfig.BossRoomIconConfigData configData)
	{
		type = MapIconType.WeekBoss;
		_unlockInteractObjUid = configData.unlockInteractObjUid;
		_unlockFogId = configData.unlockFogId;
		_fogUnlock = Model<MapModel>.Interface.UnlockFogHasUnlock(_unlockFogId);
		_objUnlock = MonoECS.instance.ruleManager.SharedGetState(_unlockInteractObjUid) == -2;
		gameObject.SetActive(_fogUnlock);
		UpdateUnlockState();
	}

	private void UpdateUnlockState()
	{
		_unlockRoot.SetActive(_objUnlock);
		_lockRoot.SetActive(!_objUnlock);
	}

	public void OnUnlockFogUnlock(int unlockFogId)
	{
		if (_unlockFogId == unlockFogId && !_fogUnlock)
		{
			gameObject.SetActive(Model<MapModel>.Interface.UnlockFogHasUnlock(_unlockFogId));
		}
	}

	public void OnUnlockInteractObjUnlock(int unlockInteractObjId)
	{
		if (_unlockInteractObjUid == unlockInteractObjId && !_objUnlock && _animation != null)
		{
			_animation.Play("Unlock");
		}
	}
}
