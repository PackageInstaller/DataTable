using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;

namespace Ase;

public class HeroGiftViewModel : OptionBase
{
	private float windowMaskLeftTime;

	private float levelUpTweenDuration;

	private bool isTweening;

	private HeroModel _heroModel;

	private string _voiceText;

	private string _heroName;

	private long _expMax;

	private long _expCurrent;

	private long _expMaxDisplay;

	private long _expDisplay;

	private int _levelMax;

	private int _levelCurrent;

	private int _levelDisplay;

	private string _levelDescDisplay;

	private HeroGiftItemData _curGiftItemData;

	private List<HeroGiftItemData> giftDatas = new List<HeroGiftItemData>();

	private SimpleCommand sendGiftCmd;

	private InteractionRequest giftItemListChanged = new InteractionRequest();

	private float tipsTime = 3f;

	public float TipsTime
	{
		get
		{
			return tipsTime;
		}
		set
		{
			tipsTime = value;
		}
	}

	public HeroModel HeroModel => _heroModel;

	public HeroGiftItemData CurGiftItemData => _curGiftItemData;

	public string VoiceText
	{
		get
		{
			return _voiceText;
		}
		set
		{
			Set(ref _voiceText, value, "VoiceText");
		}
	}

	public string HeroName
	{
		get
		{
			return _heroName;
		}
		set
		{
			Set(ref _heroName, value, "HeroName");
		}
	}

	public int LevelMax
	{
		get
		{
			return _levelMax;
		}
		set
		{
			Set(ref _levelMax, value, "LevelMax");
		}
	}

	public int LevelDisplay
	{
		get
		{
			return _levelDisplay;
		}
		set
		{
			Set(ref _levelDisplay, value, "LevelDisplay");
			DRTrust dataRow = GameEntry.DataTable.GetDataRow<DRTrust>(value);
			if (dataRow != null)
			{
				LevelDescDisplay = dataRow.Name;
			}
		}
	}

	public int LevelCurrent
	{
		get
		{
			return _levelCurrent;
		}
		set
		{
			Set(ref _levelCurrent, value, "LevelCurrent");
		}
	}

	public long ExpMax
	{
		get
		{
			return _expMax;
		}
		set
		{
			Set(ref _expMax, value, "ExpMax");
		}
	}

	public long ExpCurrent
	{
		get
		{
			return _expCurrent;
		}
		set
		{
			Set(ref _expCurrent, value, "ExpCurrent");
		}
	}

	public long ExpMaxDisplay
	{
		get
		{
			return _expMaxDisplay;
		}
		set
		{
			Set(ref _expMaxDisplay, value, "ExpMaxDisplay");
		}
	}

	public long ExpDisplay
	{
		get
		{
			return _expDisplay;
		}
		set
		{
			Set(ref _expDisplay, value, "ExpDisplay");
		}
	}

	public string LevelDescDisplay
	{
		get
		{
			return _levelDescDisplay;
		}
		set
		{
			Set(ref _levelDescDisplay, value, "LevelDescDisplay");
		}
	}

	public bool IsTweening
	{
		get
		{
			return isTweening;
		}
		set
		{
			Set(ref isTweening, value, "IsTweening");
		}
	}

	public float LevelUpTweenDuration
	{
		get
		{
			return levelUpTweenDuration;
		}
		set
		{
			levelUpTweenDuration = value;
		}
	}

	public float WindowMaskLeftTime
	{
		get
		{
			return windowMaskLeftTime;
		}
		set
		{
			Set(ref windowMaskLeftTime, value, "WindowMaskLeftTime");
		}
	}

	public List<HeroGiftItemData> GiftDatas => giftDatas;

	public SimpleCommand SendGiftCmd => sendGiftCmd;

	public InteractionRequest GiftItemListChanged => giftItemListChanged;

	public HeroGiftViewModel()
	{
	}

	public HeroGiftViewModel(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		LevelMax = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetMaxFeelingLevel();
		sendGiftCmd = new SimpleCommand(SendGift);
		SetHeroData(heroModel);
		RefreshGiftData();
	}

	private void RefreshGiftData()
	{
		giftDatas.Clear();
		(Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetDisplayProps().FindAll((KnapsackPropData p) => p.UseType.Contains(12)) ?? new List<KnapsackPropData>()).ForEach(delegate(KnapsackPropData p)
		{
			giftDatas.Add(new HeroGiftItemData(this, _heroModel, p));
		});
		giftDatas.Sort((HeroGiftItemData a, HeroGiftItemData b) => -a.PropData.GetRarity().CompareTo(b.PropData.GetRarity()) * 10 - a.PropData.Id.CompareTo(b.PropData.Id));
	}

	private void SetHeroData(HeroModel heroModel)
	{
		_heroModel = heroModel;
		HeroName = heroModel.Name;
		LevelCurrent = heroModel.FeelingLevel;
		DRTrust dataRow = GameEntry.DataTable.GetDataRow<DRTrust>(LevelCurrent + 1);
		if (dataRow == null)
		{
			ExpMax = GameEntry.DataTable.GetDataRow<DRTrust>(LevelCurrent)?.TrustValue ?? 0;
			ExpCurrent = ExpMax;
		}
		else
		{
			ExpMax = dataRow.TrustValue;
			ExpCurrent = Math.Min(heroModel.FeelingExp, ExpMax);
		}
		ResetGiftSelect();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HeroGiftItemData useGiftData)
		{
			SetUseGiftData(useGiftData);
		}
	}

	private void SetUseGiftData(HeroGiftItemData giftItemData)
	{
		if (giftItemData.UseCount <= 0)
		{
			ResetGiftSelect();
			return;
		}
		DRTrust[] dataRows = GameEntry.DataTable.GetDataRows((DRTrust p) => p.Id > _heroModel.FeelingLevel);
		if (dataRows == null || dataRows.Length == 0)
		{
			ResetGiftSelect();
			return;
		}
		if (_curGiftItemData != null && !_curGiftItemData.PropData.Id.Equals(giftItemData.PropData.Id))
		{
			ResetGiftSelect();
		}
		_curGiftItemData = giftItemData;
		long num = giftItemData.UseCount * giftItemData.TotalEx1 + _heroModel.FeelingExp;
		int levelDisplay = _heroModel.FeelingLevel;
		DRTrust[] array = dataRows;
		foreach (DRTrust dRTrust in array)
		{
			if (num < dRTrust.TrustValue)
			{
				break;
			}
			num -= dRTrust.TrustValue;
			levelDisplay = dRTrust.Id;
		}
		LevelDisplay = levelDisplay;
		DRTrust dataRow = GameEntry.DataTable.GetDataRow<DRTrust>(LevelDisplay + 1);
		if (dataRow == null)
		{
			ExpMaxDisplay = GameEntry.DataTable.GetDataRow<DRTrust>(LevelDisplay)?.TrustValue ?? 0;
			ExpDisplay = ExpMaxDisplay;
		}
		else
		{
			ExpMaxDisplay = dataRow.TrustValue;
			ExpDisplay = Math.Min(num, ExpMaxDisplay);
		}
	}

	private void ResetGiftSelect()
	{
		_curGiftItemData?.CancelUse();
		_curGiftItemData = null;
		LevelDisplay = LevelCurrent;
		ExpMaxDisplay = ExpMax;
		ExpDisplay = ExpCurrent;
	}

	private void SendGift()
	{
		if (_curGiftItemData == null)
		{
			Toast.ShowInfo("请先选择一种礼物！");
			return;
		}
		sendGiftCmd.Enabled = false;
		parent?.ItemOnClick(new OptionArg(this, "SendGift"));
	}

	public async void OnSendGiftFinished(bool success, int giftId, int oldFeelingLevel = 0)
	{
		ResetGiftSelect();
		if (success)
		{
			int voiceType = (_heroModel.FavorGift.Contains(giftId) ? 10 : 9);
			VoiceText = GameEntry.DataTable.GetDataRow((DRVoice p) => p.ObjectId.Equals(_heroModel.Id) && p.Type.Equals(voiceType))?.Desc ?? string.Empty;
			HeroModel hero = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(_heroModel.Id);
			StartFeelingUpTween(hero.FeelingLevel, hero.FeelingExp);
			RefreshGiftData();
			giftItemListChanged.Raise();
			if (oldFeelingLevel < hero.FeelingLevel)
			{
				DRVoice[] dataRows = GameEntry.DataTable.GetDataRows((DRVoice p) => p.ObjectId == hero.Id && p.LockType == 1 && p.LockNum > oldFeelingLevel && p.LockNum <= hero.FeelingLevel);
				DRHeroStory[] dataRows2 = GameEntry.DataTable.GetDataRows((DRHeroStory p) => p.HeroId == hero.Id && p.OpenType == 2 && p.OpenNum > oldFeelingLevel && p.OpenNum <= hero.FeelingLevel);
				bool num = dataRows != null && dataRows.Length != 0;
				bool newStoryOpen = dataRows2 != null && dataRows2.Length != 0;
				if (num)
				{
					ToastDropdown.Show(GameEntry.UI.GetUIGroup("POPUP"), "解锁新语音", TipsTime, string.Empty, null, null);
				}
				if (num & newStoryOpen)
				{
					await Task.Delay(1000);
				}
				if (newStoryOpen)
				{
					ToastDropdown.Show(GameEntry.UI.GetUIGroup("POPUP"), "解锁新故事", TipsTime, string.Empty, null, null);
				}
			}
		}
		sendGiftCmd.Enabled = true;
	}

	private void StartFeelingUpTween(int targetLevel, long targetExp)
	{
		IsTweening = true;
		float num = 0f;
		long num2 = 0L;
		Sequence s = DOTween.Sequence();
		for (int i = LevelCurrent; i <= targetLevel; i++)
		{
			if (i < targetLevel)
			{
				num2 = GameEntry.DataTable.GetDataRow<DRTrust>(i + 1)?.TrustValue ?? 0;
				num += levelUpTweenDuration;
				s.Append(DOTween.To(() => ExpCurrent, delegate(long x)
				{
					ExpCurrent = x;
				}, num2, levelUpTweenDuration)).OnUpdate(delegate
				{
					ExpDisplay = ExpCurrent;
				}).SetEase(Ease.Linear);
				s.InsertCallback(num, delegate
				{
					LevelCurrent++;
					LevelDisplay = LevelCurrent;
					DRTrust dataRow = GameEntry.DataTable.GetDataRow<DRTrust>(LevelCurrent + 1);
					if (dataRow == null)
					{
						DRTrust dataRow2 = GameEntry.DataTable.GetDataRow<DRTrust>(LevelCurrent);
						ExpMax = dataRow2.TrustValue;
						ExpMaxDisplay = ExpMax;
						ExpCurrent = dataRow2.TrustValue;
						ExpDisplay = ExpCurrent;
						IsTweening = false;
					}
					else
					{
						ExpCurrent = 0L;
						ExpMax = dataRow.TrustValue;
						ExpMaxDisplay = ExpMax;
					}
				});
			}
			else if (targetLevel < LevelMax)
			{
				num2 = targetExp;
				num += levelUpTweenDuration;
				s.Append(DOTween.To(() => ExpCurrent, delegate(long x)
				{
					ExpCurrent = x;
				}, num2, levelUpTweenDuration)).OnUpdate(delegate
				{
					ExpDisplay = ExpCurrent;
				}).OnComplete(delegate
				{
					IsTweening = false;
				});
			}
		}
		WindowMaskLeftTime = num;
	}
}
