using ACT.Event;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class BossInfoComp : BaseUIComponent, IUIFrameElement
{
	public GameObject bossInfoPrefab;

	private BossInfoUI _bossInfo;

	public void Initialize()
	{
		bool haveBossHatred = Model<BattleMainModel>.Interface.haveBossHatred;
		AddBossHatredEvt curBossHatredEvt = Model<BattleMainModel>.Interface.curBossHatredEvt;
		if (haveBossHatred && curBossHatredEvt != null)
		{
			OnBossAddHatred(curBossHatredEvt);
		}
	}

	public void OnBossAddHatred(BaseEventContent eventData)
	{
		if (eventData is AddBossHatredEvt evt)
		{
			if (_bossInfo != null && _bossInfo.CanHandle(evt))
			{
				_bossInfo.ApplyBossInfo(evt, Station);
				return;
			}
			ResetBossInfo();
			_bossInfo = Object.Instantiate(bossInfoPrefab, transform).GetComponent<BossInfoUI>();
			_bossInfo.ApplyBossInfo(evt, Station);
		}
	}

	public void UnloadBossBloodBar()
	{
		ResetBossInfo();
	}

	private void ResetBossInfo()
	{
		if (!(_bossInfo == null))
		{
			_bossInfo.OnBossRemoveHatred();
			_bossInfo = null;
		}
	}
}
