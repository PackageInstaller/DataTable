using System.Threading;
using ACT.Core;
using ACT.Event;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class BGMState : DialogueState
{
	public bool muteBGM;

	private AudioEventReference m_BgmEvt;

	private bool m_BgmDirty;

	private bool m_CurrentIsScreenMuteSnapShot;

	private void ApplyImmediate()
	{
		if (!m_BgmDirty)
		{
			return;
		}
		m_BgmDirty = false;
		Singleton<BGMManager>.instance.ClearBGM(BGMType.AVG);
		if (!m_BgmEvt.IsNull())
		{
			if (muteBGM && !m_CurrentIsScreenMuteSnapShot)
			{
				m_CurrentIsScreenMuteSnapShot = true;
				GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
				evt.IsInState = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAVGPlayStateChange, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			Singleton<BGMManager>.instance.SetBGM(BGMType.AVG, m_BgmEvt.GetEventPath());
		}
	}

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		ApplyImmediate();
		return UniTask.CompletedTask;
	}

	public void ChangeBgm(int bgmId, bool skipping = false)
	{
		AudioEventReference bgmEvt = m_BgmEvt;
		switch (bgmId)
		{
		case -1:
			bgmEvt = default;
			break;
		default:
		{
			RuntimeConfigs.data.dialogueBGMDatas.TryGetValue(bgmId, out var value);
			bgmEvt = new AudioEventReference(value?.key);
			break;
		}
		case 0:
			break;
		}
		bool flag = m_BgmEvt.GetEventPath() == bgmEvt.GetEventPath();
		m_BgmEvt = bgmEvt;
		if (!flag)
		{
			m_BgmDirty = true;
			if (!skipping)
			{
				ApplyImmediate();
			}
		}
	}

	public void ClearBgm()
	{
		if (m_BgmEvt != default(AudioEventReference))
		{
			m_BgmDirty = true;
			m_BgmEvt = default;
		}
		ApplyImmediate();
		if (m_CurrentIsScreenMuteSnapShot)
		{
			m_CurrentIsScreenMuteSnapShot = false;
			GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
			evt.IsInState = false;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAVGPlayStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
