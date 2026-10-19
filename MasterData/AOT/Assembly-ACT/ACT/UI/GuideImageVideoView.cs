using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class GuideImageVideoView : BaseUIView<GuideImageVideoViewInputController>
{
	private int Type;

	private GuideImageVideoViewData m_data;

	[SerializeReference]
	protected Button nextPage;

	[SerializeReference]
	protected Button lastPage;

	public LocalizeStringEvent titleLocalize;

	[SerializeReference]
	protected LocalizeStringEvent textLocalize;

	[SerializeReference]
	protected ActButton closeBtn;

	[SerializeReference]
	protected ActIndexGroup indexGroup;

	[SerializeReference]
	protected GameObject tip;

	[SerializeReference]
	protected BetterAnimation countDownAnimation;

	[SerializeReference]
	protected BImage image;

	[SerializeReference]
	protected GameObject ImageRoot;

	[SerializeReference]
	protected VideoPlayerRawImage videoImage;

	[SerializeReference]
	protected GameObject VideoRoot;

	[SerializeField]
	private TutorialReward rewardTip;

	public ScrollRect desScrollRect;

	public CanvasGroup bottomPrompt;

	public OperateBtnPrompt confirmCloseBtnPrompt;

	public OperateBtnPrompt rightScrollBtnPrompt;

	public OperateBtnPrompt lastPageBtnPrompt;

	public OperateBtnPrompt nextPageBtnPrompt;

	public float scrollSpeed = 2f;

	protected List<int> _contentIdList = new List<int>();

	private List<int> _describeIdList = new List<int>();

	private Dictionary<string, object> _tmpVariables;

	private const int NOTREWARDTIP = 2281;

	private const int ALLREADYREWARDTIP = 2282;

	private int _curPage = -1;

	private int _lastPage = -1;

	private bool _reachLastPage;

	private bool _countdownFinish;

	private bool _rightCanScroll;

	private float _rightStickInput;

	private bool tutorialAlreadyRead
	{
		get
		{
			if (RuntimeConfigs.data.guideTutorials.ContainsKey(m_data.tutorialId))
			{
				return Model<TutorialModel>.Interface.TutorialIsUnRead(m_data.tutorialId);
			}
			return false;
		}
	}

	protected bool OnePage => _lastPage == 0;

	public bool ReachLastPage
	{
		get
		{
			return _reachLastPage;
		}
		set
		{
			if (_reachLastPage != value)
			{
				_reachLastPage = value;
			}
		}
	}

	private bool CanFinish
	{
		get
		{
			if (OnePage)
			{
				return _countdownFinish;
			}
			return ReachLastPage;
		}
	}

	protected DeviceInputMode _curInputModel => MonoECS.instance.InputMode;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UINextPage, ShowNextPage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UIPrePage, ShowPrePage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UIClosePage, CLosePage);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UINextPage, ShowNextPage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UIPrePage, ShowPrePage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UIClosePage, CLosePage);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as GuideImageVideoViewData;
		_tmpVariables = DictionaryPool<string, object>.Get();
		nextPage.SetBtnClick(ShowNextPage);
		lastPage.SetBtnClick(ShowLastPage);
		closeBtn.SetBtnClick(Close);
	}

	protected override void Init()
	{
		base.Init();
		_curPage = -1;
		RefreshView();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window_Direct");
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		DictionaryPool<string, object>.Release(_tmpVariables);
		indexGroup.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		if (_reachLastPage)
		{
			StepFinish();
			GuideTutorialAward evt = Singleton<EventManager>.instance.GetEvt<GuideTutorialAward>();
			evt.RewardTutorialId = m_data.tutorialId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ReqRewardTutorial, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			base.Close();
		}
	}

	protected void StartCountDown()
	{
		countDownAnimation.GetSequence("CountDown").OnComplete((AnimationBuilder _) =>
		{
			_countdownFinish = true;
		}).Play();
	}

	protected void InitData(int guideTableId)
	{
		_contentIdList.Clear();
		_describeIdList.Clear();
		_lastPage = -1;
		GuideTutorial data = CoreUtils.GetData(guideTableId, RuntimeConfigs.data.guideTutorials);
		if (data != null)
		{
			titleLocalize.SetTable(LocalizeTable.ShortCommon);
			titleLocalize.StringReference.TableEntryReference = data.tutorialTitle;
			Type = data.multimediaType;
			int[] array = _curInputModel switch
			{
				DeviceInputMode.Gamepad => data.pictureidHandy, 
				DeviceInputMode.KeyboardAndMouse => data.pictureidPC, 
				DeviceInputMode.TouchScreen => data.pictureid, 
				_ => null, 
			};
			if (array == null || array.Length <= 0)
			{
				array = data.pictureid;
			}
			int[] array2 = _curInputModel switch
			{
				DeviceInputMode.Gamepad => data.tutorialDescHandy, 
				DeviceInputMode.KeyboardAndMouse => data.tutorialDescPC, 
				DeviceInputMode.TouchScreen => data.tutorialDesc, 
				_ => null, 
			};
			if (array2 == null || array2.Length <= 0)
			{
				array2 = data.tutorialDesc;
			}
			_lastPage = array.Length - 1;
			ReachLastPage = false;
			_countdownFinish = !OnePage;
			_contentIdList.AddRange(array);
			_describeIdList.AddRange(array2);
			indexGroup.Init(_lastPage + 1);
		}
	}

	protected void ShowByIndex(int index)
	{
		if (index >= 0 && index <= _lastPage)
		{
			_curPage = index;
			ReachLastPage = _curPage == _lastPage;
			RefreshDescribe();
			Canvas.ForceUpdateCanvases();
			lastPage.gameObject.SetActive(_curPage > 0);
			nextPage.gameObject.SetActive(_curPage < _lastPage);
			indexGroup.SetToIndex(index);
			ImageRoot.SetActive(Type == 1);
			VideoRoot.SetActive(Type == 2);
			if (Type == 1)
			{
				Station.LoadImage(101, _contentIdList[index], image);
			}
			else if (Type == 2)
			{
				videoImage.PlayVideo(_contentIdList[index]);
			}
			if (ReachLastPage && RuntimeConfigs.data.guideTutorials.TryGetValue(m_data.tutorialId, out var _))
			{
				ReadGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<ReadGuideTutorial>();
				evt.ReadTutorialId = m_data.tutorialId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ReadTutorial, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			UpdateBtnPromptActive();
		}
	}

	public void ShowNextPage()
	{
		if (_curPage < _lastPage)
		{
			ShowByIndex(_curPage + 1);
		}
	}

	private void ShowNextPage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUINextPageEvt)
		{
			ShowNextPage();
		}
	}

	public void ShowLastPage()
	{
		if (_curPage > 0)
		{
			ShowByIndex(_curPage - 1);
		}
	}

	private void ShowPrePage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUIPrePageEvt)
		{
			ShowLastPage();
		}
	}

	private void StepFinish()
	{
		if (CanFinish)
		{
			GuideStepFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideStepFinishEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_StepFinish, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void CLosePage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUIClosePage)
		{
			StepFinish();
		}
	}

	public void RefreshDescribe()
	{
		_tmpVariables.Clear();
		textLocalize.StringReference.TableEntryReference = 0L;
		if (_curPage < 0 || _curPage >= _describeIdList.Count)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		GuideTutorialDes data = CoreUtils.GetData(_describeIdList[_curPage], RuntimeConfigs.data.guideTutorialDess);
		if (data == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		for (int i = 0; i < data.actionPrompt.Length; i++)
		{
			string bindingAction = data.actionPrompt[i];
			if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(bindingAction, out var bindingKeyName))
			{
				if (!string.IsNullOrEmpty(bindingKeyName))
				{
					bindingKeyName = bindingKeyName.Replace("/", "_");
					if (MonoECS.instance.GetPromptIconDevice() is DualShockGamepad)
					{
						bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
					}
					_tmpVariables[i.FastToString()] = bindingKeyName;
				}
				else if (!LuminApplication.LogEnabled)
				{
				}
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		textLocalize.SetTable("longcommon");
		if (_tmpVariables.Count > 0)
		{
			Model<GuideTipModel>.Interface.SetVariablesWithoutCache(textLocalize, _tmpVariables);
		}
		textLocalize.StringReference.TableEntryReference = data.tutorialTitle;
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			base.OnInputDeviceChange(type);
			RefreshView(_curPage);
		}
	}

	private void Update()
	{
		ExecuteRightStickScroll();
	}

	public void OnRightStickScroll(Vector2 value)
	{
		_rightStickInput = (_rightCanScroll ? value.y : 0f);
	}

	private void ExecuteRightStickScroll()
	{
		if (_rightCanScroll)
		{
			float num = desScrollRect?.verticalNormalizedPosition ?? 0f;
			num += _rightStickInput * scrollSpeed * Time.unscaledDeltaTime;
			if (desScrollRect != null)
			{
				desScrollRect.verticalNormalizedPosition = Mathf.Clamp01(num);
			}
		}
	}

	private void UpdateBtnPromptActive()
	{
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		bottomPrompt.alpha = ((inputMode == DeviceInputMode.Gamepad) ? 1 : 0);
		_rightCanScroll = inputMode == DeviceInputMode.Gamepad && CanRightScroll();
		rightScrollBtnPrompt.SetVisible(_rightCanScroll);
		UpdateCloseUiActive();
	}

	private bool CanRightScroll()
	{
		if (desScrollRect != null && desScrollRect.content != null && desScrollRect.viewport != null)
		{
			return desScrollRect.content.rect.height > desScrollRect.viewport.rect.height;
		}
		return false;
	}

	private void UpdateCloseUiActive()
	{
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		tip.SetActive(!_reachLastPage);
		closeBtn.gameObject.SetActive(_reachLastPage && inputMode != DeviceInputMode.Gamepad);
		confirmCloseBtnPrompt.SetVisible(_reachLastPage);
	}

	private void RefreshView(int curPage = 0)
	{
		InitData(m_data.tutorialId);
		curPage = Mathf.Clamp(curPage, 0, _lastPage);
		ShowByIndex(curPage);
		if (OnePage)
		{
			StartCountDown();
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			_rightCanScroll = CanRightScroll();
		}
	}
}
