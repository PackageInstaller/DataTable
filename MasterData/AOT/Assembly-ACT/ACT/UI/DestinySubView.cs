using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class DestinySubView : SubUIView<CharacterDestinySubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	[Serializable]
	public class CustomDestinyConfig
	{
		public int characterId;

		public YooAssetReference destinySubBiewAssetID;
	}

	[SerializeField]
	private BetterAnimation anim;

	[SerializeField]
	private BImage _destinyEnterIcon;

	public List<CustomDestinyConfig> customDestinyConfigs;

	[SerializeField]
	private Transform customDestinyRoot;

	[SerializeField]
	private GameObject commonGroyBg;

	[SerializeField]
	private SwitchDestinyPanel switchDestinyPanel;

	[SerializeField]
	private DestinyButtonComponent destinyButtom;

	public YooAssetReference defultDestinySubViewAssetID;

	[SerializeField]
	private GameObject parentBackBtn;

	[SerializeField]
	private ActButton destinyBackBtn;

	[SerializeField]
	private CommonCoinComponent _destinyTapeCost;

	[SerializeField]
	private GameObject _rightTopGamepadRoot;

	private CustomDestiny curDestiny;

	private ImageAssetStation _station;

	private Dictionary<int, List<GameObject>> everyStageShows = new Dictionary<int, List<GameObject>>();

	private bool _afterAnimation;

	private const int MaxDestinyCount = 6;

	private const int HalfDestinyCount = 3;

	private int _characterId;

	private Character curCharacter;

	private bool characterIsLocal;

	private DestinySubViewBase.DestinyInfo[] _commonDestiny;

	private DestinySubViewBase.DestinyInfo[] _extraDestiny;

	private int _cachedActiveDestinyCount;

	private int _hasCostItemNum;

	private RepeatedField<int> _finalSyncDestiny;

	private Dictionary<string, float> _rgbEnableSettings = new Dictionary<string, float>();

	private Dictionary<string, Vector4> _rgbColorSettings = new Dictionary<string, Vector4>();

	private StringBuilder _sb;

	private uint _destinyMaxBGM;

	private int _destinyMaxBGMVersion;

	private bool _destinyViewShowing;

	private ContinuousNavigateData _curNavigateData;

	public CharacterView CharacterView { get; private set; }

	public SwitchDestinyPanel destinySwitchWindow => switchDestinyPanel;

	public int Depth => 2;

	public ICharacterSubView lastSubView { get; set; }

	public bool FreezeCharacterOSA => true;

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Destiny;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	private void GetCustomDestiny()
	{
		foreach (CustomDestinyConfig customDestinyConfig in customDestinyConfigs)
		{
			if (customDestinyConfig.characterId == _characterId)
			{
				DoCreateDestiny(customDestinyConfig.destinySubBiewAssetID);
				return;
			}
		}
		DoCreateDestiny(defultDestinySubViewAssetID);
		void DoCreateDestiny(YooAssetReference reference)
		{
			curDestiny = new CustomDestiny();
			curDestiny.currentReferrenceAssetID = reference;
			curDestiny.handler = AssetStationManager.BattleStation.LoadAsync<GameObject>(reference);
			curDestiny.handler.Completed += OnHandleComplate;
		}
	}

	private void OnHandleComplate(AssetLoadHandle handle)
	{
		try
		{
			GameObject gameObject = handle.AsGameObject();
			if (!(gameObject == null))
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, customDestinyRoot);
				curDestiny.destiny = gameObject2.GetComponent<DestinySubViewBase>();
				InitDestinyView();
			}
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("handle 加载失败 " + handle.AssetID);
			}
			throw;
		}
	}

	private void InitDestinyView()
	{
		curDestiny.destiny.InitEveryStageShows(ref everyStageShows);
		curDestiny.destiny.InitDestinyInfo();
		ResetDestinyPanel();
		curDestiny.destiny.gameObject.SetActive(value: true);
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		_destinyViewShowing = true;
		_destinyMaxBGMVersion++;
		AfterAnimation = false;
		_station = station;
		station.LoadImage(152, characterId, _destinyEnterIcon);
		CharacterView characterView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER) as CharacterView;
		parentBackBtn.SetActive(value: false);
		destinyBackBtn.gameObject.SetActive(value: true);
		if (characterView != null)
		{
			destinyBackBtn.SetBtnClick(characterView.CloseSubView);
		}
		_sb = new StringBuilder();
		_characterId = characterId;
		_hasCostItemNum = G.localPlayer.Inventory.GetItemCount(CoreUtils.GetData(characterId * 10 + 1, RuntimeConfigs.data.characterConstellationDatas).costItemId);
		SceneStatus sceneStatus = MonoECS.instance.sceneStatus;
		characterIsLocal = sceneStatus == SceneStatus.Abyss || sceneStatus == SceneStatus.Temple;
		curCharacter = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		_destinyTapeCost.gameObject.SetActive(curCharacter != null && !curCharacter.IsTrailCharacter);
		_rightTopGamepadRoot.gameObject.SetActive(curCharacter != null && !curCharacter.IsTrailCharacter && MonoECS.instance.IsGamePadMode());
		_finalSyncDestiny = new RepeatedField<int>();
		GetCustomDestiny();
		gameObject.SetActive(value: true);
		int itemId = Model<DestinyModel>.Interface.characterDestinyCost[characterId];
		_destinyTapeCost.Station = station;
		_destinyTapeCost.InitData(itemId, isBagItem: true);
		int itemCount = G.localPlayer.Inventory.GetItemCount(itemId);
		_destinyTapeCost.Init(itemCount);
		anim?.GetSequence("Show").OnAnimationPlay((AnimationBuilder _) =>
		{
			PlayOpenViewSound();
		}).OnComplete((AnimationBuilder a) =>
		{
			AfterAnimation = true;
		})
			.Play();
		FocusIn();
	}

	public void Hide()
	{
		FocusOut();
		anim?.GetSequence("Hide").OnComplete((AnimationBuilder a) =>
		{
			AfterAnimation = false;
		}).Play();
		AfterAnimation = false;
		_destinyViewShowing = false;
		_destinyMaxBGMVersion++;
		StopDestinyMaxBGM();
		parentBackBtn.SetActive(value: true);
		destinyBackBtn.gameObject.SetActive(value: false);
		HideSwitchPanel(0);
		ReleaseView(_characterId);
		gameObject.SetActive(value: false);
		_curNavigateData?.Reset();
	}

	private void SyncFinalDestinyIds(Action OnNtfCallBack)
	{
		_finalSyncDestiny.Clear();
		DestinySubViewBase.DestinyInfo[] commonDestiny = _commonDestiny;
		foreach (DestinySubViewBase.DestinyInfo destinyInfo in commonDestiny)
		{
			if (destinyInfo.Active)
			{
				_finalSyncDestiny.Add(destinyInfo.Id);
			}
		}
		Model<DestinyModel>.Interface.CharacterDestinyActiveCount[_characterId] = _finalSyncDestiny.Count;
		commonDestiny = _extraDestiny;
		foreach (DestinySubViewBase.DestinyInfo destinyInfo2 in commonDestiny)
		{
			if (destinyInfo2.Active)
			{
				_finalSyncDestiny.Add(destinyInfo2.Id);
			}
		}
		G.service.CharacterUpdateConstellation(_characterId, _finalSyncDestiny, (bool b, int num) =>
		{
			if (b)
			{
				OnNtfCallBack?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("更新命座失败");
			}
		});
	}

	public void ResetDestinyPanel()
	{
		_commonDestiny = new DestinySubViewBase.DestinyInfo[6];
		for (int i = 0; i < 6; i++)
		{
			int num = _characterId * 10 + i + 1;
			bool destinyActive = curCharacter.GetDestinyActive(num);
			_commonDestiny[i] = new DestinySubViewBase.DestinyInfo(num, destinyActive, i);
		}
		_extraDestiny = new DestinySubViewBase.DestinyInfo[2];
		_extraDestiny[0] = new DestinySubViewBase.DestinyInfo(_characterId * 10 + 7, curCharacter.GetActiveDestinyCount() >= 3, 0);
		_extraDestiny[1] = new DestinySubViewBase.DestinyInfo(_characterId * 10 + 8, curCharacter.GetActiveDestinyCount() >= 6, 1);
		UpdateCachedActiveCount();
		int costId = Model<DestinyModel>.Interface.characterDestinyCost[_characterId];
		destinyButtom.RegisterDestinyBtn(this, curCharacter, ShowSwitchPanel, _cachedActiveDestinyCount, _station, costId, _destinyMaxBGMVersion);
		UpdateDisPlay();
		UpdateExtraDestinyDisPlay();
		InitRGBColor();
		SetMaterialRGB();
		RefreshDestinyOtherItemState();
		if (_cachedActiveDestinyCount >= 6 && curDestiny.destiny.anim != null)
		{
			curDestiny.destiny.anim.SetBool("IsFullDestiny", value: true);
		}
		ControlDestinyMaxBGM(_cachedActiveDestinyCount >= 6);
	}

	private void ReleaseView(int characterId)
	{
		if (curDestiny != null)
		{
			SetPlaySpineAnimation(play: false);
			if (curDestiny.destiny != null && curDestiny.destiny.gameObject != null)
			{
				curDestiny.destiny.gameObject.SetActive(value: false);
			}
			OnRelease();
		}
	}

	private void OnRelease()
	{
		if (everyStageShows != null)
		{
			everyStageShows.Clear();
		}
		_commonDestiny = null;
		_extraDestiny = null;
		_rgbEnableSettings.Clear();
		_rgbColorSettings.Clear();
		if (curDestiny != null)
		{
			_ = curDestiny.handler;
			curDestiny.handler.Completed -= OnHandleComplate;
			AssetStationManager.BattleStation.Release(curDestiny.handler);
			if (curDestiny.destiny != null && curDestiny.destiny.gameObject != null)
			{
				UnityEngine.Object.Destroy(curDestiny.destiny.gameObject);
			}
			curDestiny = null;
		}
	}

	private void OnDestroy()
	{
	}

	private void UpdateCompAbility(int targetDestinyId, bool isActive)
	{
		Character curCharacterByCharacterId = CharacterDataHelper.GetCurCharacterByCharacterId(_characterId);
		if (EntityHelper.TryGetBattleEntityByCharacter(curCharacterByCharacterId, out var entity))
		{
			CompAbility compAbility = entity.GetCompAbility();
			if (isActive)
			{
				compAbility.OnDestinyActive(targetDestinyId, curCharacterByCharacterId);
			}
			else
			{
				compAbility.OnDestinyDeActive(targetDestinyId, curCharacterByCharacterId);
			}
			int num = _characterId * 10 + 7;
			int num2 = _characterId * 10 + 8;
			MapField<int, bool> destinyEnableMap = curCharacterByCharacterId.GetDestinyEnableMap();
			if (!destinyEnableMap.TryGetValue(num, out var value))
			{
				compAbility.OnDestinyDeActive(num, curCharacterByCharacterId);
			}
			else
			{
				compAbility.OnDestinyActive(num, curCharacterByCharacterId);
			}
			if (!destinyEnableMap.TryGetValue(num2, out value))
			{
				compAbility.OnDestinyDeActive(num2, curCharacterByCharacterId);
			}
			else
			{
				compAbility.OnDestinyActive(num2, curCharacterByCharacterId);
			}
		}
	}

	private void UpdateCachedActiveCount()
	{
		_cachedActiveDestinyCount = _commonDestiny.Count((DestinySubViewBase.DestinyInfo x) => x.Active);
	}

	private void RefreshDestinyOtherItemState()
	{
		for (int i = 0; i < _commonDestiny.Length; i++)
		{
			if (!everyStageShows.ContainsKey(i))
			{
				continue;
			}
			DestinySubViewBase.DestinyInfo destinyInfo = _commonDestiny[i];
			foreach (GameObject item in everyStageShows[i])
			{
				item.SetActive(destinyInfo.Active);
			}
		}
		for (int j = 0; j < _extraDestiny.Length; j++)
		{
			int key = 6 + j;
			if (!everyStageShows.ContainsKey(key))
			{
				continue;
			}
			DestinySubViewBase.DestinyInfo destinyInfo2 = _extraDestiny[j];
			foreach (GameObject item2 in everyStageShows[key])
			{
				if (destinyInfo2.Active && !item2.activeSelf)
				{
					item2.SetActive(value: true);
				}
				else if (!destinyInfo2.Active && item2.activeSelf)
				{
					item2.SetActive(value: false);
				}
			}
		}
	}

	private void SetMaterialRGB()
	{
		_rgbEnableSettings.Clear();
		bool active = _commonDestiny[0].Active;
		bool active2 = _commonDestiny[1].Active;
		bool active3 = _commonDestiny[2].Active;
		_rgbEnableSettings["_Order1Enable"] = (active ? 1 : 0);
		_rgbEnableSettings["_Order2Enable"] = (active2 ? 1 : 0);
		_rgbEnableSettings["_Order3Enable"] = (active3 ? 1 : 0);
		foreach (KeyValuePair<string, float> rgbEnableSetting in _rgbEnableSettings)
		{
			curDestiny.destiny.spineCharacter.material.SetFloat(rgbEnableSetting.Key, rgbEnableSetting.Value);
		}
		foreach (Image rgbChangesMat in curDestiny.destiny.rgbChangesMats)
		{
			foreach (KeyValuePair<string, float> rgbEnableSetting2 in _rgbEnableSettings)
			{
				rgbChangesMat.material.SetFloat(rgbEnableSetting2.Key, rgbEnableSetting2.Value);
			}
		}
	}

	private void InitRGBColor()
	{
		CharacterConstellationRgb data = CoreUtils.GetData(_characterId, RuntimeConfigs.data.characterConstellationRgbs);
		if (data == null)
		{
			return;
		}
		_rgbColorSettings.Clear();
		_rgbColorSettings["_OrderColor100"] = new Vector4(data.RgbFirstFloat[0], data.RgbFirstFloat[1], data.RgbFirstFloat[2], 1f);
		_rgbColorSettings["_OrderColor110"] = new Vector4(data.RgbFirstSecondFloat[0], data.RgbFirstSecondFloat[1], data.RgbFirstSecondFloat[2], 1f);
		_rgbColorSettings["_OrderColor101"] = new Vector4(data.RgbFirstThirdFloat[0], data.RgbFirstThirdFloat[1], data.RgbFirstThirdFloat[2], 1f);
		_rgbColorSettings["_OrderColor010"] = new Vector4(data.RgbSecondFloat[0], data.RgbSecondFloat[1], data.RgbSecondFloat[2], 1f);
		_rgbColorSettings["_OrderColor011"] = new Vector4(data.RgbSecondThirdFloat[0], data.RgbSecondThirdFloat[1], data.RgbSecondThirdFloat[2], 1f);
		_rgbColorSettings["_OrderColor001"] = new Vector4(data.RgbThirdFloat[0], data.RgbThirdFloat[1], data.RgbThirdFloat[2], 1f);
		foreach (KeyValuePair<string, Vector4> rgbColorSetting in _rgbColorSettings)
		{
			curDestiny.destiny.spineCharacter.material.SetVector(rgbColorSetting.Key, rgbColorSetting.Value);
		}
		foreach (Image rgbChangesMat in curDestiny.destiny.rgbChangesMats)
		{
			foreach (KeyValuePair<string, Vector4> rgbColorSetting2 in _rgbColorSettings)
			{
				rgbChangesMat.material.SetVector(rgbColorSetting2.Key, rgbColorSetting2.Value);
			}
		}
	}

	private void ShowSwitchPanel(int destinyId, bool isCommon)
	{
		if (curDestiny.destiny.currentSelectedDestinyId != destinyId)
		{
			if (curDestiny.destiny.currentSelectedDestinyId != -1 && curDestiny.destiny.currentSelectedDestinyId != destinyId)
			{
				CloseCurrentSelectedBtn();
			}
			curDestiny.destiny.currentSelectedDestinyId = destinyId;
			CharacterConstellationData data = CoreUtils.GetData(destinyId, RuntimeConfigs.data.characterConstellationDatas);
			DestinySubViewBase.DestinyInfo destinyInfo = (isCommon ? _commonDestiny.First((DestinySubViewBase.DestinyInfo x) => x.Id == destinyId) : _extraDestiny.First((DestinySubViewBase.DestinyInfo x) => x.Id == destinyId));
			switchDestinyPanel?.Init(data, destinyInfo.Active, isCommon, _hasCostItemNum, _cachedActiveDestinyCount, curCharacter.IsTrailCharacter, SwitchDestinyState, HideSwitchPanel, _sb);
			destinyButtom.SetBtnPromptsBoardActive(active: false);
		}
	}

	public void HideSwitchPanel(int destinyId)
	{
		switchDestinyPanel.UnInit();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			destinyButtom.SetInputSelectDesBtn(destinyButtom.curSelectDestinyIndex);
		}
		else
		{
			CloseCurrentSelectedBtn();
		}
		curDestiny.destiny.currentSelectedDestinyId = -1;
		destinyButtom.SetBtnPromptsBoardActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void CloseCurrentSelectedBtn()
	{
		if (curDestiny.destiny.currentSelectedDestinyId == -1)
		{
			return;
		}
		if (CoreUtils.GetData(curDestiny.destiny.currentSelectedDestinyId, RuntimeConfigs.data.characterConstellationDatas).constellationLevel <= 6)
		{
			DestinySubViewBase.DestinyInfo destinyInfo = _commonDestiny.First((DestinySubViewBase.DestinyInfo x) => x.Id == curDestiny.destiny.currentSelectedDestinyId);
			destinyButtom.DestinyBtns[destinyInfo.Index].SetSelectState(active: false);
		}
		else
		{
			DestinySubViewBase.DestinyInfo destinyInfo2 = _extraDestiny.First((DestinySubViewBase.DestinyInfo x) => x.Id == curDestiny.destiny.currentSelectedDestinyId);
			destinyButtom.ExtraDestinyComps[destinyInfo2.Index].SetSelectState(active: false);
		}
	}

	private bool SwitchDestinyState(int destinyId, bool _active)
	{
		DestinySubViewBase.DestinyInfo destinyInfo = _commonDestiny.FirstOrDefault((DestinySubViewBase.DestinyInfo x) => x.Id == destinyId);
		if (destinyInfo == null)
		{
			return false;
		}
		if (!_active)
		{
			return DeActiveDestiny(destinyInfo);
		}
		return ActiveDestiny(destinyInfo);
	}

	private bool ActiveDestiny(DestinySubViewBase.DestinyInfo destiny)
	{
		if (_hasCostItemNum < 1)
		{
			return false;
		}
		_hasCostItemNum--;
		destiny.SetActive(active: true);
		destinyButtom.DestinyBtns[destiny.Index].SetActive(active: true);
		for (int i = 0; i < 6; i++)
		{
			destinyButtom.DestinyBtns[i].UpdateAnim(_commonDestiny[i].Active, _hasCostItemNum >= 1);
		}
		UpdateCachedActiveCount();
		UpdateDisPlay();
		UpdateExtraDestinyDisPlay();
		SetMaterialRGB();
		RefreshDestinyOtherItemState();
		UpdateAnim();
		SyncFinalDestinyIds(() =>
		{
			UpdateButtomDisPlay(_cachedActiveDestinyCount, active: true);
			UpdateCompAbility(destiny.Id, isActive: true);
		});
		return true;
	}

	private bool DeActiveDestiny(DestinySubViewBase.DestinyInfo destiny)
	{
		_hasCostItemNum++;
		destiny.SetActive(active: false);
		destinyButtom.DestinyBtns[destiny.Index].SetActive(active: false);
		for (int i = 0; i < 6; i++)
		{
			destinyButtom.DestinyBtns[i].UpdateAnim(_commonDestiny[i].Active, _hasCostItemNum >= 1);
		}
		int beforeActiveIndex = _cachedActiveDestinyCount;
		UpdateCachedActiveCount();
		UpdateDisPlay();
		UpdateExtraDestinyDisPlay();
		SetMaterialRGB();
		RefreshDestinyOtherItemState();
		UpdateAnim();
		SyncFinalDestinyIds(() =>
		{
			UpdateButtomDisPlay(beforeActiveIndex, active: false);
			UpdateCompAbility(destiny.Id, isActive: false);
		});
		return true;
	}

	private void UpdateAnim()
	{
		if (!(curDestiny.destiny.anim == null))
		{
			if (_cachedActiveDestinyCount >= 6 && curDestiny.destiny.anim != null)
			{
				curDestiny.destiny.anim.SetBool("IsFullDestiny", value: true);
			}
			else
			{
				curDestiny.destiny.anim.SetBool("IsFullDestiny", value: false);
			}
		}
	}

	private void UpdateButtomDisPlay(int activeIndex, bool active)
	{
		destinyButtom.UpdateDisPlay(activeIndex, _cachedActiveDestinyCount, active);
	}

	private void UpdateDisPlay()
	{
		SetPlaySpineAnimation(_cachedActiveDestinyCount >= 3);
	}

	private void UpdateExtraDestinyDisPlay()
	{
		_extraDestiny[0].SetActive(_cachedActiveDestinyCount >= 3);
		_extraDestiny[1].SetActive(_cachedActiveDestinyCount >= 6);
	}

	public bool GetDestinyActiveStage(int stage)
	{
		for (int i = 0; i < stage; i++)
		{
			if (!_commonDestiny[i].Active)
			{
				return false;
			}
		}
		return true;
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
	}

	public void SetPlaySpineAnimation(bool play)
	{
		if (curDestiny != null && curDestiny.destiny != null)
		{
			curDestiny.destiny.ControlSpineAnimation(play);
		}
	}

	public void PlayOpenViewSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/Into");
	}

	public void ControlDestinyMaxBGM(bool destinyIsMax)
	{
		ControlDestinyMaxBGM(destinyIsMax, _destinyMaxBGMVersion);
	}

	public void ControlDestinyMaxBGM(bool destinyIsMax, int destinyMaxBGMVersion)
	{
		if (destinyMaxBGMVersion != _destinyMaxBGMVersion)
		{
			return;
		}
		if (destinyIsMax)
		{
			if (_destinyViewShowing)
			{
				_destinyMaxBGM = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/TapeUnit");
			}
		}
		else
		{
			StopDestinyMaxBGM();
		}
	}

	private void StopDestinyMaxBGM()
	{
		if (_destinyMaxBGM != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_destinyMaxBGM);
			_destinyMaxBGM = 0u;
		}
	}

	public void Navigate(Vector2 value)
	{
		if ((object)destinyButtom == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("命座Buttom组件为空");
			}
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		bool flag = switchDestinyPanel?.IsFocused ?? false;
		switch (dir)
		{
		case MoveDirection.Left:
			destinyButtom.SetInputSelectDesBtn(destinyButtom.curSelectDestinyIndex - 1);
			if (flag)
			{
				destinyButtom.ClickInputOpenSwitchDestinyPanel();
			}
			break;
		case MoveDirection.Right:
			destinyButtom.SetInputSelectDesBtn(destinyButtom.curSelectDestinyIndex + 1);
			if (flag)
			{
				destinyButtom.ClickInputOpenSwitchDestinyPanel();
			}
			break;
		}
	}

	public void Confirm()
	{
		if ((object)destinyButtom == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("命座Buttom组件为空");
			}
		}
		else if (destinyButtom.curSelectDestinyIndex != -1)
		{
			destinyButtom.ClickInputOpenSwitchDestinyPanel();
		}
	}

	public void OnDeviceChange(DeviceInputMode curMode)
	{
		destinyButtom.OnDeviceChange(curMode);
	}

	public void RightStickPressed()
	{
		if (_destinyTapeCost != null && _destinyTapeCost.gameObject.activeInHierarchy)
		{
			_destinyTapeCost.InputClick();
		}
	}
}
