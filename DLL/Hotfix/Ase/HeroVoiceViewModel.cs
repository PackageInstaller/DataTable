using System.Collections.Generic;
using FMOD.Studio;
using GameFramework.Runtime;
using Sirenix.Utilities;

namespace Ase;

public class HeroVoiceViewModel : OptionBase
{
	private HeroModel _heroModel;

	private TabItemData tabDataTouch;

	private TabItemData tabDataBattle;

	private float playingLeftTime;

	private string voiceText;

	private string cvText;

	private List<KeyValuePair<DRVoice, bool>> voiceDatas = new List<KeyValuePair<DRVoice, bool>>();

	private InteractionRequest onVoiceDataChanged = new InteractionRequest();

	private HeroVoiceItemData _curItemData;

	private VoiceGroup voiceGroup;

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		set
		{
			Set(ref _heroModel, value, "HeroModel");
		}
	}

	public TabItemData TabDataTouch => tabDataTouch;

	public TabItemData TabDataBattle => tabDataBattle;

	public List<KeyValuePair<DRVoice, bool>> VoiceDatas => voiceDatas;

	public float PlayingLeftTime
	{
		get
		{
			return playingLeftTime;
		}
		set
		{
			Set(ref playingLeftTime, value, "PlayingLeftTime");
		}
	}

	public string VoiceText
	{
		get
		{
			return voiceText;
		}
		set
		{
			Set(ref voiceText, value, "VoiceText");
		}
	}

	public string CvText
	{
		get
		{
			return cvText;
		}
		set
		{
			Set(ref cvText, value, "CvText");
		}
	}

	public InteractionRequest OnVoiceDataChanged => onVoiceDataChanged;

	public HeroVoiceViewModel()
	{
	}

	public HeroVoiceViewModel(OptionBase parent, HeroModel heroModel)
	{
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.HeroBook);
		base.parent = parent;
		HeroModel = heroModel;
		CvText = heroModel.CvNames;
		tabDataTouch = new TabItemData(this, 1);
		tabDataBattle = new TabItemData(this, 2);
		tabDataTouch.IsSelected = true;
		tabDataBattle.IsSelected = false;
		RefreshVoiceDatas(tabDataTouch.TabIndex);
		tabDataTouch.Red = CheckRed(tabDataTouch.TabIndex);
		tabDataBattle.Red = CheckRed(tabDataBattle.TabIndex);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			tabDataTouch.IsSelected = tabDataTouch.TabIndex == tabItemData.TabIndex;
			tabDataBattle.IsSelected = tabDataBattle.TabIndex == tabItemData.TabIndex;
			if (tabDataTouch.IsSelected)
			{
				ClearRedPoint(tabDataBattle.TabIndex);
				tabDataBattle.Red = false;
			}
			else
			{
				ClearRedPoint(tabDataTouch.TabIndex);
				tabDataTouch.Red = false;
			}
			RefreshVoiceDatas(tabItemData.TabIndex);
			parent?.ItemOnClick(this);
		}
		else if (obj is HeroVoiceItemData itemData)
		{
			OnVoiceItemClick(itemData);
		}
	}

	private void RefreshVoiceDatas(int tabIndex)
	{
		DRVoice[] dataRows = GameEntry.DataTable.GetDataRows((DRVoice p) => p.ObjectId.Equals(HeroModel.Id) && p.VoiceEnum.Equals(tabIndex));
		voiceDatas.Clear();
		dataRows?.ForEach(delegate(DRVoice p)
		{
			voiceDatas.Add(new KeyValuePair<DRVoice, bool>(p, GetVoiceUnLockState(p)));
		});
		voiceDatas.Sort((KeyValuePair<DRVoice, bool> a, KeyValuePair<DRVoice, bool> b) => (!a.Value.Equals(b.Value)) ? (-a.Value.CompareTo(b.Value)) : a.Key.Id.CompareTo(b.Key.Id));
		onVoiceDataChanged.Raise();
	}

	public void ClearRedPoint()
	{
		if (tabDataBattle.Red)
		{
			ClearRedPoint(tabDataBattle.TabIndex);
			tabDataBattle.Red = false;
		}
		if (tabDataTouch.Red)
		{
			ClearRedPoint(tabDataTouch.TabIndex);
			tabDataTouch.Red = false;
		}
	}

	private void ClearRedPoint(int tabIndex)
	{
		DRVoice[] dataRows = GameEntry.DataTable.GetDataRows((DRVoice p) => p.ObjectId.Equals(HeroModel.Id) && p.VoiceEnum.Equals(tabIndex));
		IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
		List<RedPointSave> redPoint = service.GetRedPoint(RedPointLocalSaveKeys.HeroVoiceClick);
		voiceDatas.Clear();
		DRVoice[] array = dataRows;
		foreach (DRVoice drVoice in array)
		{
			voiceDatas.Add(new KeyValuePair<DRVoice, bool>(drVoice, GetVoiceUnLockState(drVoice)));
			redPoint.RemoveAll((RedPointSave p) => p.keyId.Equals(drVoice.Id));
			redPoint.Add(new RedPointSave
			{
				keyId = drVoice.Id,
				param1 = 0,
				isNew = false
			});
			service.SaveRedPoint(redPoint, RedPointLocalSaveKeys.HeroVoiceClick);
		}
		voiceDatas.Sort((KeyValuePair<DRVoice, bool> a, KeyValuePair<DRVoice, bool> b) => (!a.Value.Equals(b.Value)) ? (-a.Value.CompareTo(b.Value)) : a.Key.Id.CompareTo(b.Key.Id));
		onVoiceDataChanged.Raise();
	}

	private bool GetVoiceUnLockState(DRVoice drVoice)
	{
		return HeroModel.GetVoiceOpenState(drVoice);
	}

	private void OnVoiceItemClick(HeroVoiceItemData itemData)
	{
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		_curItemData?.SetSelected(selected: false);
		_curItemData = itemData;
		_curItemData?.SetSelected(selected: true);
		if (itemData?.DrVoice != null)
		{
			DRVoice drVoice = itemData.DrVoice;
			voiceGroup.Stop();
			voiceGroup.Play(drVoice.VoiceId, 0, 1f, AudioHelper.GetParameterListByConfigData(drVoice.Config, drVoice.ConfigNum));
			EventInstance curVoice = voiceGroup.GetCurVoice();
			EventDescription val = default(EventDescription);
			((EventInstance)(ref curVoice)).getDescription(ref val);
			int num = default(int);
			((EventDescription)(ref val)).getLength(ref num);
			PlayingLeftTime = (float)num / 1000f;
			VoiceText = drVoice.Desc;
			IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
			List<RedPointSave> redPoint = service.GetRedPoint(RedPointLocalSaveKeys.HeroVoiceClick);
			redPoint.RemoveAll((RedPointSave p) => p.keyId.Equals(drVoice.Id));
			redPoint.Add(new RedPointSave
			{
				keyId = drVoice.Id,
				param1 = 0,
				isNew = false
			});
			service.SaveRedPoint(redPoint, RedPointLocalSaveKeys.HeroVoiceClick);
			itemData.SetRed(red: false);
			parent?.ItemOnClick(this);
		}
	}

	public void StopVoice()
	{
		voiceGroup.Stop();
	}

	private bool CheckRed(int tabIndex)
	{
		List<RedPointSave> redPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint(RedPointLocalSaveKeys.HeroVoiceClick);
		DRVoice[] dataRows = GameEntry.DataTable.GetDataRows((DRVoice p) => p.ObjectId.Equals(HeroModel.Id) && p.VoiceEnum.Equals(tabIndex));
		List<KeyValuePair<DRVoice, bool>> allVoiceDataList = new List<KeyValuePair<DRVoice, bool>>();
		dataRows?.ForEach(delegate(DRVoice p)
		{
			allVoiceDataList.Add(new KeyValuePair<DRVoice, bool>(p, GetVoiceUnLockState(p)));
		});
		foreach (KeyValuePair<DRVoice, bool> voiceDataDic in allVoiceDataList)
		{
			if (voiceDataDic.Value && !redPoint.Exists((RedPointSave p) => p.keyId.Equals(voiceDataDic.Key.Id) && !p.isNew))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckRed()
	{
		bool flag = CheckRed(tabDataBattle.TabIndex);
		tabDataBattle.Red = flag;
		bool flag2 = CheckRed(tabDataTouch.TabIndex);
		tabDataTouch.Red = flag2;
		return flag | flag2;
	}

	public override void Dispose()
	{
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.HeroBook, stopVoice: true);
		voiceGroup = null;
		base.Dispose();
	}
}
