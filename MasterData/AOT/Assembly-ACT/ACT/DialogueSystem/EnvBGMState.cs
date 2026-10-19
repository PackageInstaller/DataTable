using System.Threading;
using ACT.Core;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class EnvBGMState : DialogueState
{
	private AudioEventReference m_EnvBgmEvt;

	private bool m_BgmDirty;

	private uint m_EnvBgmInstance;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		ApplyImmediate();
		return UniTask.CompletedTask;
	}

	private void ApplyImmediate()
	{
		if (m_BgmDirty)
		{
			m_BgmDirty = false;
			if (m_EnvBgmInstance != 0)
			{
				Singleton<GameManager>.instance.audioManager.Stop(m_EnvBgmInstance);
				m_EnvBgmInstance = 0u;
			}
			if (!m_EnvBgmEvt.IsNull())
			{
				m_EnvBgmInstance = Singleton<GameManager>.instance.audioManager.PlaySound(m_EnvBgmEvt);
			}
		}
	}

	public void ChangeBgm(int bgmId, bool skipping)
	{
		AudioEventReference envBgmEvt = m_EnvBgmEvt;
		switch (bgmId)
		{
		case -1:
			envBgmEvt = default;
			break;
		default:
		{
			RuntimeConfigs.data.dialogueEnvBGMDatas.TryGetValue(bgmId, out var value);
			envBgmEvt = new AudioEventReference(value?.key);
			break;
		}
		case 0:
			break;
		}
		bool flag = m_EnvBgmEvt.GetEventPath() == envBgmEvt.GetEventPath();
		m_EnvBgmEvt = envBgmEvt;
		if (!flag)
		{
			m_BgmDirty = true;
			if (!skipping)
			{
				ApplyImmediate();
			}
		}
	}

	public void ClearEnvBgm()
	{
		if (m_EnvBgmEvt != default(AudioEventReference))
		{
			m_BgmDirty = true;
			m_EnvBgmEvt = default;
		}
		ApplyImmediate();
	}
}
