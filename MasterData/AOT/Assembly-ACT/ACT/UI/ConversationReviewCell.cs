using ACT.Sound.Management;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ConversationReviewCell : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
{
	public GameObject nameRoot;

	public GameObject diban_player;

	public GameObject diban_other;

	public TextMeshProUGUI name_text;

	public TextMeshProUGUI content_text;

	public GameObject circle;

	public Toggle tog_PlayAudio;

	public Animator tog_PlayAudioAnimator;

	public OperateBtnPrompt playTip;

	private int m_StoryGroupId;

	private int m_VoiceIndex;

	private long m_VoiceId;

	private bool m_HaveVoice;

	private void Awake()
	{
		tog_PlayAudio.onValueChanged.AddListener(OnToggleValueChanged);
	}

	private void OnDisable()
	{
		tog_PlayAudio.isOn = false;
	}

	public void Init(int dialogueGroupId, bool isPlayer, bool haveName, string nameText, bool haveContent, string contentText, Color contentColor, bool haveVoice, long voiceId, int voceIndex)
	{
		diban_player.SetActive(isPlayer);
		diban_other.SetActive(!isPlayer);
		nameRoot.SetActive(haveName);
		name_text.text = nameText;
		content_text.text = contentText;
		content_text.gameObject.SetActive(haveContent);
		content_text.color = contentColor;
		tog_PlayAudio.gameObject.SetActive(haveVoice);
		m_StoryGroupId = dialogueGroupId;
		m_VoiceIndex = voceIndex;
		m_VoiceId = voiceId;
		m_HaveVoice = haveVoice;
		circle.SetActive(!haveVoice);
	}

	private async void OnToggleValueChanged(bool newValue)
	{
		if (newValue)
		{
			tog_PlayAudioAnimator.SetBool("IsOn", value: true);
			if (m_HaveVoice)
			{
				RefreshTipText(playing: true);
				await Singleton<DramaVoiceManager>.instance.PlayVoiceEventAsync($"event:/Vo/CN/Dialogue/{m_VoiceId}", null, $"{m_StoryGroupId}", m_VoiceIndex).SuppressCancellationThrow();
				tog_PlayAudio.isOn = false;
			}
		}
		else
		{
			tog_PlayAudioAnimator.SetBool("IsOn", value: false);
			if (m_HaveVoice)
			{
				RefreshTipText(playing: false);
				Singleton<DramaVoiceManager>.instance.StopCurrentVoice();
			}
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		tog_PlayAudio?.OnSubmit(eventData);
	}

	public void OnSelect(BaseEventData eventData)
	{
		playTip.gameObject.SetActive(m_HaveVoice);
		RefreshTipText(tog_PlayAudio.isOn);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		playTip?.gameObject.SetActive(value: false);
	}

	private void RefreshTipText(bool playing)
	{
		playTip.SetText(playing ? "暂停" : "播放");
	}
}
