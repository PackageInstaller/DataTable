using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class StoryPopTipViewModel : ViewModelBase
{
	private string nameText;

	private string tipText;

	private string headIconName;

	private float exitDuration;

	private InteractionRequest onPopupTipShow;

	private InteractionRequest onPopupTipHide;

	private InteractionRequest onPopupTipRest;

	private Queue<DRPopupTip> _popupTips;

	private float showTimeLength;

	private float waitTimeLength;

	private float hideTimeLength;

	private float showTime;

	private int tipType;

	private int maxVisibleCharacters;

	private int popupState;

	private bool nextFlag;

	private bool isPlaying;

	private TextMeshProUGUI _textCustom;

	private CancellationTokenSource _cts;

	private List<DRBankGroup> _bankGroups;

	private List<string> _banks;

	private EventInstance _voiceInstance;

	public string NameText
	{
		get
		{
			return nameText;
		}
		set
		{
			Set(ref nameText, value, "NameText");
		}
	}

	public string TipText
	{
		get
		{
			return tipText;
		}
		set
		{
			Set(ref tipText, value, "TipText");
		}
	}

	public int MaxVisibleCharacters
	{
		get
		{
			return maxVisibleCharacters;
		}
		set
		{
			Set<int>(ref maxVisibleCharacters, value, "MaxVisibleCharacters");
		}
	}

	public string HeadIconName
	{
		get
		{
			return headIconName;
		}
		set
		{
			Set(ref headIconName, value, "HeadIconName");
		}
	}

	public float ExitDuration
	{
		get
		{
			return exitDuration;
		}
		set
		{
			Set(ref exitDuration, value, "ExitDuration");
		}
	}

	public IInteractionRequest OnPopupTipShow => onPopupTipShow;

	public IInteractionRequest OnPopupTipHide => onPopupTipHide;

	public IInteractionRequest OnPopupTipRest => onPopupTipRest;

	public StoryPopTipViewModel()
	{
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		_popupTips = new Queue<DRPopupTip>();
		showTimeLength = 1f;
		waitTimeLength = 1f;
		hideTimeLength = 1f;
		showTime = 1f;
		_bankGroups = new List<DRBankGroup>();
		_banks = new List<string>();
		_voiceInstance = new EventInstance(IntPtr.Zero);
		base._002Ector();
		onPopupTipShow = new InteractionRequest(this);
		onPopupTipHide = new InteractionRequest(this);
		onPopupTipRest = new InteractionRequest(this);
	}

	public bool GetIsPlaying()
	{
		return isPlaying;
	}

	public void StartPopTip(int queueId)
	{
		DRPopupTipQueue dataRow = GameEntry.DataTable.GetDataRow<DRPopupTipQueue>(queueId);
		if (dataRow == null)
		{
			return;
		}
		StopPopTip();
		InitBankGroupsData(dataRow.BankGroups);
		foreach (int group in dataRow.GroupList)
		{
			DRPopupTip dataRow2 = GameEntry.DataTable.GetDataRow<DRPopupTip>(group);
			if (dataRow2 == null)
			{
				Toast.ShowError($"弹窗读表报错:{queueId}-{group}");
			}
			else
			{
				_popupTips.Enqueue(dataRow2);
			}
		}
		nextFlag = true;
		isPlaying = true;
	}

	public void PopupUpdate()
	{
		if (popupState == 0)
		{
			if (nextFlag && _popupTips.Count > 0)
			{
				DRPopupTip dRPopupTip = _popupTips.Dequeue();
				NameText = StoryUtility.ReplaceUsersName(dRPopupTip.Name);
				if (string.IsNullOrEmpty(dRPopupTip.IconUrl))
				{
					HeadIconName = string.Empty;
				}
				else
				{
					HeadIconName = "Head/" + StoryUtility.GetCharacterPortrait(dRPopupTip.IconUrl) + ".png";
				}
				showTimeLength = ((dRPopupTip.Frames == 0f) ? 1f : dRPopupTip.Frames);
				waitTimeLength = dRPopupTip.WaitTime;
				hideTimeLength = dRPopupTip.Fadeout;
				ExitDuration = dRPopupTip.Fadeout;
				tipType = dRPopupTip.Type;
				if (tipType == 0)
				{
					TipText = StoryUtility.ReplaceUsersName(dRPopupTip.Text);
					showTime = 0f;
					MaxVisibleCharacters = ((TMP_Text)_textCustom).textInfo.characterCount;
				}
				else if (tipType == 1)
				{
					MaxVisibleCharacters = 0;
					showTime = 0f;
					TipText = StoryUtility.ReplaceUsersName(dRPopupTip.Text);
				}
				else if (tipType == 2)
				{
					TipText += StoryUtility.ReplaceUsersName(dRPopupTip.Text);
				}
				else if (tipType == 3)
				{
					TipText = TipText + "\n" + StoryUtility.ReplaceUsersName(dRPopupTip.Text);
				}
				nextFlag = false;
				popupState = 1;
				PlayVoice(dRPopupTip.VoiceId);
				onPopupTipShow.Raise();
			}
		}
		else if (popupState == 1)
		{
			if ((UnityEngine.Object)(object)_textCustom == null)
			{
				popupState = 2;
				return;
			}
			if (showTime >= showTimeLength)
			{
				popupState = 2;
				MaxVisibleCharacters = ((TMP_Text)_textCustom).textInfo.characterCount;
				return;
			}
			showTime += Time.deltaTime;
			if (tipType > 0)
			{
				MaxVisibleCharacters = Mathf.FloorToInt(showTime / showTimeLength * (float)((TMP_Text)_textCustom).textInfo.characterCount);
			}
		}
		else if (popupState == 2)
		{
			if (waitTimeLength <= 0f)
			{
				if (hideTimeLength == 0f)
				{
					OnPlayEnd();
					return;
				}
				popupState = 3;
				onPopupTipHide.Raise();
			}
			else
			{
				waitTimeLength -= Time.deltaTime;
			}
		}
		else if (popupState == 3)
		{
			if (hideTimeLength <= 0f)
			{
				OnPlayEnd();
			}
			else
			{
				hideTimeLength -= Time.deltaTime;
			}
		}
	}

	public void OnPlayEnd()
	{
		popupState = 0;
		nextFlag = true;
		if (_popupTips.Count <= 0)
		{
			onPopupTipRest.Raise();
			isPlaying = false;
		}
		StopVoice();
	}

	public void StopPopTip()
	{
		onPopupTipRest.Raise();
		_popupTips.Clear();
		popupState = 0;
		CancelLoadAndStopAllVoice();
	}

	public void SetBind(TextMeshProUGUI textCustom)
	{
		_textCustom = textCustom;
	}

	private void InitBankGroupsData(List<int> bankGroupIds)
	{
		try
		{
			_cts = new CancellationTokenSource();
			if (bankGroupIds == null || bankGroupIds.Count == 0)
			{
				return;
			}
			_bankGroups = new List<DRBankGroup>();
			_banks = new List<string>();
			foreach (int bankGroupId in bankGroupIds)
			{
				DRBankGroup dataRow = GameEntry.DataTable.GetDataRow<DRBankGroup>(bankGroupId);
				if (dataRow == null)
				{
					continue;
				}
				_bankGroups.Add(dataRow);
				foreach (string bank in dataRow.Banks)
				{
					string musicAsset = AssetUtility.GetMusicAsset(bank);
					if (!_banks.Contains(musicAsset))
					{
						_banks.Add(musicAsset);
					}
				}
			}
			LoadBankGroups().Forget();
		}
		catch (Exception)
		{
		}
	}

	private async UniTask LoadBankGroups()
	{
		if (_bankGroups == null || _bankGroups.Count == 0 || _banks == null || _banks.Count == 0)
		{
			return;
		}
		foreach (DRBankGroup bankGroup in _bankGroups)
		{
			_cts.Token.ThrowIfCancellationRequested();
			await AudioHelper.LoadBanksByGroup(bankGroup);
		}
	}

	private void UnloadBankGroups()
	{
		if (_bankGroups == null || _bankGroups.Count == 0)
		{
			return;
		}
		_banks.Clear();
		_banks = null;
		foreach (DRBankGroup bankGroup in _bankGroups)
		{
			AudioHelper.UnloadBankByGroup(bankGroup);
		}
		_bankGroups.Clear();
		_bankGroups = null;
	}

	private void PlayVoice(int voiceId)
	{
		PlayVoiceAsync(voiceId).Forget();
	}

	private async UniTask PlayVoiceAsync(int voiceId)
	{
		StopVoice();
		await Singleton<AudioSystem>.Instance.HasBanksLoaded(_banks, _cts);
		_cts.Token.ThrowIfCancellationRequested();
		_voiceInstance = Singleton<AudioSystem>.Instance.CreateInstance(voiceId);
		if (((EventInstance)(ref _voiceInstance)).isValid())
		{
			((EventInstance)(ref _voiceInstance)).start();
		}
	}

	private void StopVoice()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		if (((EventInstance)(ref _voiceInstance)).isValid())
		{
			((EventInstance)(ref _voiceInstance)).stop((STOP_MODE)1);
		}
	}

	private void CancelLoadAndStopAllVoice()
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		if (_cts != null)
		{
			_cts.Cancel();
			_cts.Dispose();
			_cts = null;
		}
		if (((EventInstance)(ref _voiceInstance)).isValid())
		{
			((EventInstance)(ref _voiceInstance)).stop((STOP_MODE)1);
		}
		UnloadBankGroups();
	}
}
