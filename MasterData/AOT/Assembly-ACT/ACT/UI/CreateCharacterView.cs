using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Error;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Local;
using ACT.Net;
using ACT.Rendering;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using bamboosdk;

namespace ACT.UI;

public class CreateCharacterView : BaseUIView<CreateCharacterViewInputController>
{
	private SexChooseStage m_sexChooseStage;

	private CreateCharacterViewData m_data;

	private GameLoader m_GameLoad;

	private int Gender;

	private bool isValid;

	private bool isSelect;

	private Dictionary<int, SensitiveWord> DicSensitiveWord;

	private bool isBeyondlength;

	private bool m_isChanging;

	private GameObject m_timelineObj;

	private GameObject m_maleTimelineObj;

	private GameObject m_femaleTimelineObj;

	private Camera timelineCamera;

	private GameObject m_mainLightGo;

	private bool m_mainLightWasActive;

	private uint m_createCharacterMusicInstance;

	private bool m_skipNextGenderConfirmSound;

	private bool m_skipNextGenderSelectSound;

	private bool m_skipNextNameConfirmSound;

	private bool m_suppressInputSelectSound;

	private bool m_isConfirmingName;

	[Tooltip("男主锚点到角色视觉中心的世界空间偏移")]
	public Vector3 MaleButtonWorldOffset = new Vector3(0f, 1f, 0f);

	[Tooltip("女主锚点到角色视觉中心的世界空间偏移")]
	public Vector3 FemaleButtonWorldOffset = new Vector3(0f, 1f, 0f);

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	public Animation ViewAnimator;

	public List<GameObject> GamepadObjs;

	public GameObject GoMaleSelect;

	public GameObject GoMaleBlack;

	public ActButton BtnMaleClick;

	public GameObject GoFeMaleSelect;

	public GameObject GoFeMaleBlack;

	public ActButton BtnFeMaleClick;

	public GameObject MaleGoSupperLimit;

	public GameObject FemaleGoSupperLimit;

	public TMP_InputField MaleInputName;

	public TMP_InputField FemaleInputName;

	public ActButton MaleBtnConfirm;

	public ActButton FemaleBtnConfirm;

	public Color isValidColor;

	public Color unValidColor;

	public GameObject TimelineGameObject;

	public PlayableDirector Director;

	public TimelineData startTimelineData;

	public TimelineData toMaleTimelineData;

	public TimelineData maleBackTimelineData;

	public TimelineData maleEndTimelineData;

	public TimelineData toFemaleTimelineData;

	public TimelineData femaleBackTimelineData;

	public TimelineData femaleEndTimelineData;

	public TimelineData cgTimelineData;

	private TMP_InputField m_activeInputField;

	private ActButton m_activeConfirmButton;

	public bool IsStageChanging => m_isChanging;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		GameRenderScene.Set(GameRenderScene.Scene.CreateCharacter);
		PlayCreateCharacterMusic();
		OnGamePadInit();
		OnInputDeviceChange(MonoECS.instance.InputMode);
		m_timelineObj = UnityEngine.Object.Instantiate(TimelineGameObject);
		GameObject gameObject = GameObject.Find("Role_00_02");
		GameObject gameObject2 = GameObject.Find("Role_00_01");
		m_maleTimelineObj = ((gameObject != null) ? gameObject.gameObject : null);
		m_femaleTimelineObj = ((gameObject2 != null) ? gameObject2.gameObject : null);
		Director = m_timelineObj.GetComponent<PlayableDirector>();
		timelineCamera = Director.GetComponentInChildren<Camera>();
		GameUtility.mainCamera.gameObject.SetActive(value: false);
		HideMainLight();
		timelineCamera.GetUniversalAdditionalCameraData().cameraStack.Add(GameUtility.uiCamera);
		m_sexChooseStage = SexChooseStage.Start;
		m_GameLoad = UnityEngine.Object.FindObjectOfType<GameLoader>();
		m_data = (CreateCharacterViewData)uiViewData;
		isValid = false;
		isSelect = false;
		BindConfirmButton(MaleBtnConfirm);
		BindConfirmButton(FemaleBtnConfirm);
		BtnFeMaleClick.SetBtnClick(() =>
		{
			ConfirmGenderByButton(2);
		}, "event:/UI/Interface/CreateCharacter/Clck");
		BtnMaleClick.SetBtnClick(() =>
		{
			ConfirmGenderByButton(1);
		}, "event:/UI/Interface/CreateCharacter/Clck");
		await base.PreInit();
	}

	protected override void Init()
	{
		InitPanel();
		base.Init();
	}

	private void LateUpdate()
	{
		UpdateGenderButtonFollowWorld();
	}

	private void UpdateGenderButtonFollowWorld()
	{
		if (m_sexChooseStage == SexChooseStage.ChooseGender && !(timelineCamera == null))
		{
			SyncGenderButtonToTimeline(BtnMaleClick, m_maleTimelineObj, MaleButtonWorldOffset);
			SyncGenderButtonToTimeline(BtnFeMaleClick, m_femaleTimelineObj, FemaleButtonWorldOffset);
		}
	}

	private void SyncGenderButtonToTimeline(ActButton button, GameObject timelineAnchor, Vector3 worldOffset)
	{
		if (button == null || timelineAnchor == null)
		{
			return;
		}
		RectTransform rectTransform = button.transform as RectTransform;
		if (rectTransform == null)
		{
			return;
		}
		RectTransform rectTransform2 = rectTransform.parent as RectTransform;
		if (rectTransform2 == null)
		{
			return;
		}
		Vector3 position = timelineAnchor.transform.position + worldOffset;
		Vector3 vector = timelineCamera.WorldToViewportPoint(position);
		if (vector.z < 0f)
		{
			return;
		}
		Vector2 screenPoint = new Vector2(vector.x * (float)Screen.width, vector.y * (float)Screen.height);
		Camera cam = null;
		Canvas componentInParent = rectTransform.GetComponentInParent<Canvas>();
		if (componentInParent != null)
		{
			componentInParent = componentInParent.rootCanvas;
			if (componentInParent.renderMode != RenderMode.ScreenSpaceOverlay)
			{
				cam = componentInParent.worldCamera;
			}
		}
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform2, screenPoint, cam, out var localPoint))
		{
			rectTransform.localPosition = new Vector3(localPoint.x, localPoint.y, 0f);
		}
	}

	private void HideMainLight()
	{
		m_mainLightGo = ((GameUtility.mainLight != null) ? GameUtility.mainLight.gameObject : null);
		if (!(m_mainLightGo == null))
		{
			m_mainLightWasActive = m_mainLightGo.activeSelf;
			if (m_mainLightWasActive)
			{
				m_mainLightGo.SetActive(value: false);
			}
		}
	}

	private void RestoreMainLight()
	{
		if (m_mainLightGo != null)
		{
			m_mainLightGo.SetActive(m_mainLightWasActive);
		}
		m_mainLightGo = null;
	}

	protected override void OnInputDeviceChange(DeviceInputMode deviceInputMode)
	{
		TMP_InputField currentInputField = GetCurrentInputField();
		bool flag = currentInputField != null && currentInputField.isFocused;
		if (flag)
		{
			m_suppressInputSelectSound = true;
			currentInputField.DeactivateInputField();
		}
		foreach (GameObject gamepadObj in GamepadObjs)
		{
			gamepadObj.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			ClearGenderActButtonHighlight();
			if (flag)
			{
				currentInputField.ActivateInputField();
				m_suppressInputSelectSound = false;
			}
			return;
		}
		GoMaleSelect.SetActive(value: false);
		GoMaleBlack.SetActive(value: true);
		GoFeMaleSelect.SetActive(value: true);
		GoFeMaleBlack.SetActive(value: false);
		Gender = 2;
		isSelect = true;
		RefreshGenderActButtonHighlight(Gender);
		ReBindBtnPrompt();
		if (flag)
		{
			currentInputField.ActivateInputField();
			m_suppressInputSelectSound = false;
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null))
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			switch (m_sexChooseStage)
			{
			case SexChooseStage.ChooseGender:
				_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
				break;
			case SexChooseStage.Female:
			case SexChooseStage.Male:
				_tipsActions.Add(_allInputPrompt["UI/Back"]);
				break;
			}
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PlayCreateCharacterSound("event:/Common/CreateCharacter/Open");
		ChangeStage(SexChooseStage.ChooseGender);
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public void InitPanel()
	{
		SetupNameInputField(MaleInputName);
		SetupNameInputField(FemaleInputName);
		SyncStageNameWidgets();
	}

	private void BindConfirmButton(ActButton button)
	{
		if (!(button == null))
		{
			button.SetBtnClick(ConfirmNameByButton, "event:/UI/Interface/CreateCharacter/Confirm");
		}
	}

	private void ConfirmGenderByButton(int gender)
	{
		m_skipNextGenderConfirmSound = true;
		m_skipNextGenderSelectSound = true;
		try
		{
			SelectGender(gender);
			OnBtnConfirm();
		}
		finally
		{
			m_skipNextGenderSelectSound = false;
			m_skipNextGenderConfirmSound = false;
		}
	}

	private void ConfirmNameByButton()
	{
		m_skipNextNameConfirmSound = true;
		OnBtnConfirm();
		m_skipNextNameConfirmSound = false;
	}

	private void SetupNameInputField(TMP_InputField inputField)
	{
		if (!(inputField == null))
		{
			inputField.text = "";
			inputField.characterLimit = 0;
			inputField.onValueChanged.RemoveListener(OnNameValueChanged);
			inputField.onValueChanged.AddListener(OnNameValueChanged);
			inputField.onSelect.RemoveListener(OnNameInputSelected);
			inputField.onSelect.AddListener(OnNameInputSelected);
			inputField.onEndEdit.RemoveListener(OnNameEndEdit);
			inputField.onEndEdit.AddListener(OnNameEndEdit);
			inputField.onValidateInput = (TMP_InputField.OnValidateInput)Delegate.Remove(inputField.onValidateInput, new TMP_InputField.OnValidateInput(ValidateChar));
			if (Application.platform != RuntimePlatform.IPhonePlayer && Application.platform != RuntimePlatform.tvOS)
			{
				inputField.onValidateInput = (TMP_InputField.OnValidateInput)Delegate.Combine(inputField.onValidateInput, new TMP_InputField.OnValidateInput(ValidateChar));
			}
			EnsureNameInputCaretOnTop(inputField);
		}
	}

	private void EnsureNameInputCaretOnTop(TMP_InputField inputField)
	{
		if (inputField == null || inputField.textComponent == null)
		{
			return;
		}
		RectTransform rectTransform = inputField.textComponent.rectTransform;
		RectTransform rectTransform2 = rectTransform.parent as RectTransform;
		if (rectTransform2 != null && inputField.textViewport != rectTransform2)
		{
			inputField.textViewport = rectTransform2;
		}
		Transform transform = ((rectTransform2 != null) ? rectTransform2 : rectTransform.parent);
		if (transform == null)
		{
			return;
		}
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (child != null && child.GetComponent<TMP_SelectionCaret>() != null)
			{
				child.SetAsLastSibling();
				break;
			}
		}
	}

	private void OnNameInputSelected(string _)
	{
		EnsureNameInputCaretOnTop(GetCurrentInputField());
		if (!m_suppressInputSelectSound && !m_isChanging && GetCurrentInputField() != null)
		{
			PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Clck");
		}
	}

	private void OnNameValueChanged(string str)
	{
		if (!(GetCurrentInputField() == null))
		{
			CheckNameLength(str);
			ChangeTextColor(isValid: true);
		}
	}

	private void OnNameEndEdit(string _)
	{
		ApplyNameInputSanitization(MaleInputName);
		ApplyNameInputSanitization(FemaleInputName);
	}

	private void ApplyNameInputSanitization(TMP_InputField inputField)
	{
		if (!(inputField == null))
		{
			string text = SanitizeNameInput(inputField.text);
			if (text != inputField.text)
			{
				inputField.text = text;
			}
		}
	}

	private void SyncStageNameWidgets()
	{
		m_activeInputField = GetCurrentInputField();
		m_activeConfirmButton = GetCurrentConfirmButton();
		UpdateSupperLimitView();
		if (!(m_activeInputField == null))
		{
			CheckNameLength(m_activeInputField.text);
			ChangeTextColor(isValid: true);
		}
	}

	private TMP_InputField GetCurrentInputField()
	{
		if (m_sexChooseStage == SexChooseStage.Male)
		{
			return MaleInputName;
		}
		if (m_sexChooseStage == SexChooseStage.Female)
		{
			return FemaleInputName;
		}
		return null;
	}

	private ActButton GetCurrentConfirmButton()
	{
		if (m_sexChooseStage == SexChooseStage.Male)
		{
			return MaleBtnConfirm;
		}
		if (m_sexChooseStage == SexChooseStage.Female)
		{
			return FemaleBtnConfirm;
		}
		return null;
	}

	private string SanitizeNameInput(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder(str.Length);
		for (int i = 0; i < str.Length; i++)
		{
			char c = ValidateChar(str, i, str[i]);
			if (c != '\0')
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	private char ValidateChar(string text, int charIndex, char addedChar)
	{
		if (char.IsWhiteSpace(addedChar))
		{
			return '\0';
		}
		if (IsEmoji(addedChar))
		{
			return '\0';
		}
		return addedChar;
	}

	private bool IsEmoji(char c)
	{
		if (char.IsHighSurrogate(c) || char.IsLowSurrogate(c))
		{
			return true;
		}
		if (c >= 127744 && c <= 129750)
		{
			return true;
		}
		if (c >= '℀' && c <= '➿')
		{
			return true;
		}
		return false;
	}

	private async void ChangeStage(SexChooseStage toStage)
	{
		if (m_isChanging)
		{
			return;
		}
		m_isChanging = true;
		SetTimelineInputBlocked(blocked: true);
		try
		{
			SexChooseStage sexChooseStage = m_sexChooseStage;
			TimelineData timelineData = default;
			if (sexChooseStage == SexChooseStage.Start && toStage == SexChooseStage.ChooseGender)
			{
				timelineData = startTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.ChooseGender && toStage == SexChooseStage.Female)
			{
				timelineData = toFemaleTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.ChooseGender && toStage == SexChooseStage.Male)
			{
				timelineData = toMaleTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.Male && toStage == SexChooseStage.ChooseGender)
			{
				timelineData = maleBackTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.Female && toStage == SexChooseStage.ChooseGender)
			{
				timelineData = femaleBackTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.Male && toStage == SexChooseStage.End)
			{
				timelineData = maleEndTimelineData;
			}
			else if (sexChooseStage == SexChooseStage.Female && toStage == SexChooseStage.End)
			{
				timelineData = femaleEndTimelineData;
			}
			PlayStageChangeSound(sexChooseStage, toStage);
			await PlayTimeline(timelineData);
			if (toStage == SexChooseStage.End)
			{
				await PlayTimeline(cgTimelineData);
				Singleton<LoadManager>.instance.AddLoadingViewOpenCompleteListener(EnterGame);
				Singleton<LoadManager>.instance.StartLoading();
			}
			m_sexChooseStage = toStage;
			if (toStage != SexChooseStage.ChooseGender)
			{
				ClearGenderActButtonHighlight();
			}
		}
		finally
		{
			m_isChanging = false;
			SetTimelineInputBlocked(blocked: false);
			SyncStageNameWidgets();
			ReBindBtnPrompt();
			if (m_sexChooseStage == SexChooseStage.ChooseGender && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				RefreshGenderActButtonHighlight(Gender);
			}
		}
	}

	private void SetTimelineInputBlocked(bool blocked)
	{
		SetButtonInteractable(BtnMaleClick, !blocked);
		SetButtonInteractable(BtnFeMaleClick, !blocked);
		SetButtonInteractable(MaleBtnConfirm, !blocked);
		SetButtonInteractable(FemaleBtnConfirm, !blocked);
		if (MaleInputName != null)
		{
			MaleInputName.interactable = !blocked;
		}
		if (FemaleInputName != null)
		{
			FemaleInputName.interactable = !blocked;
		}
		CreateCharacterViewInputController controller = GetController();
		if (controller != null)
		{
			if (blocked)
			{
				controller.Deactivate();
			}
			else
			{
				controller.Activate();
			}
			RefreshConfirmInputActionState();
		}
	}

	private static void SetButtonInteractable(ActButton button, bool interactable)
	{
		if (button != null)
		{
			button.Interactable(interactable);
		}
	}

	private async UniTask PlayTimeline(TimelineData timelineData)
	{
		if (!string.IsNullOrEmpty(timelineData.beforeAnimationName))
		{
			ViewAnimator.Play(timelineData.beforeAnimationName);
		}
		bool stoppedNaturally;
		if (timelineData.timeline != null && Director != null)
		{
			double duration = timelineData.timeline.duration;
			stoppedNaturally = false;
			DirectorUpdateMode previousUpdateMode = Director.timeUpdateMode;
			Director.stopped += OnDirectorStopped;
			try
			{
				Director.playableAsset = timelineData.timeline;
				Director.extrapolationMode = DirectorWrapMode.Hold;
				Director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
				Director.time = 0.0;
				Director.Evaluate();
				Director.Play();
				await UniTask.Yield(PlayerLoopTiming.Update);
				while (Director != null && !stoppedNaturally && Director.time < duration - 0.0001)
				{
					EnsureDirectorPlaying();
					await UniTask.Yield(PlayerLoopTiming.Update);
				}
				if (Director != null)
				{
					Director.time = duration;
					Director.Evaluate();
					if (Director.state == UnityEngine.Playables.PlayState.Playing)
					{
						Director.Pause();
					}
				}
			}
			finally
			{
				if (Director != null)
				{
					Director.stopped -= OnDirectorStopped;
					Director.timeUpdateMode = previousUpdateMode;
				}
			}
		}
		if (!string.IsNullOrEmpty(timelineData.afterAnimationName))
		{
			ViewAnimator.Play(timelineData.afterAnimationName);
		}
		void OnDirectorStopped(PlayableDirector _)
		{
			stoppedNaturally = true;
		}
	}

	private void EnsureDirectorPlaying()
	{
		if (Director == null)
		{
			return;
		}
		if (Director.playableGraph.IsValid())
		{
			Playable rootPlayable = Director.playableGraph.GetRootPlayable(0);
			if (rootPlayable.IsValid() && rootPlayable.GetSpeed() < 0.001)
			{
				rootPlayable.SetSpeed(1.0);
			}
		}
		if (Director.state == UnityEngine.Playables.PlayState.Paused)
		{
			Director.Resume();
		}
		else if (Director.state != UnityEngine.Playables.PlayState.Playing)
		{
			Director.Play();
		}
	}

	private void PlayStageChangeSound(SexChooseStage curStage, SexChooseStage toStage)
	{
		if (curStage == SexChooseStage.ChooseGender && (toStage == SexChooseStage.Male || toStage == SexChooseStage.Female))
		{
			PlayCreateCharacterSound("event:/Common/CreateCharacter/Near");
		}
		else if ((curStage == SexChooseStage.Male || curStage == SexChooseStage.Female) && toStage == SexChooseStage.ChooseGender)
		{
			PlayCreateCharacterSound("event:/Common/CreateCharacter/Far");
		}
		else if ((curStage == SexChooseStage.Male || curStage == SexChooseStage.Female) && toStage == SexChooseStage.End)
		{
			PlayCreateCharacterSound("event:/Common/CreateCharacter/Close");
		}
	}

	private static void PlayCreateCharacterSound(string sound)
	{
		if (!string.IsNullOrEmpty(sound))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(sound);
		}
	}

	private void PlayCreateCharacterMusic()
	{
		if (m_createCharacterMusicInstance == 0)
		{
			m_createCharacterMusicInstance = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Mus/Scene/CreateCharacter/CreateCharacter");
		}
	}

	private void StopCreateCharacterMusic()
	{
		if (m_createCharacterMusicInstance != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(m_createCharacterMusicInstance);
			m_createCharacterMusicInstance = 0u;
		}
	}

	public void ActivateInputField()
	{
		if (m_isChanging || (m_sexChooseStage != SexChooseStage.Female && m_sexChooseStage != SexChooseStage.Male))
		{
			return;
		}
		TMP_InputField currentInputField = GetCurrentInputField();
		if (currentInputField == null)
		{
			return;
		}
		PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Clck");
		m_suppressInputSelectSound = true;
		try
		{
			currentInputField.DeactivateInputField();
			currentInputField.ActivateInputField();
		}
		finally
		{
			m_suppressInputSelectSound = false;
		}
	}

	private void DeactivateCurrentInputField()
	{
		TMP_InputField currentInputField = GetCurrentInputField();
		if (currentInputField != null && currentInputField.isFocused)
		{
			currentInputField.DeactivateInputField();
		}
	}

	public void SelectGender(int gender)
	{
		if (m_sexChooseStage != SexChooseStage.ChooseGender || m_isChanging)
		{
			return;
		}
		if (gender == Gender)
		{
			isSelect = true;
			RefreshGenderActButtonHighlight(gender);
			return;
		}
		GoMaleSelect.SetActive(gender == 1);
		GoMaleBlack.SetActive(gender != 1);
		GoFeMaleSelect.SetActive(gender == 2);
		GoFeMaleBlack.SetActive(gender != 2);
		Gender = gender;
		isSelect = true;
		if (!m_skipNextGenderSelectSound)
		{
			PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Clck");
		}
		RefreshGenderActButtonHighlight(gender);
	}

	private void RefreshGenderActButtonHighlight(int gender)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && m_sexChooseStage == SexChooseStage.ChooseGender && EventSystemHelper.Available)
		{
			ActButton actButton = ((gender == 1) ? BtnMaleClick : BtnFeMaleClick);
			ActButton actButton2 = ((gender == 1) ? BtnFeMaleClick : BtnMaleClick);
			PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared);
			if (actButton2 != null)
			{
				ExecuteEvents.Execute(actButton2.gameObject, eventData, ExecuteEvents.pointerExitHandler);
			}
			if (actButton != null)
			{
				ExecuteEvents.Execute(actButton.gameObject, eventData, ExecuteEvents.pointerEnterHandler);
				EventSystemHelper.SetSelectedGameObject(actButton.gameObject);
			}
		}
	}

	private void ClearGenderActButtonHighlight()
	{
		if (EventSystemHelper.Available)
		{
			PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared);
			if (BtnMaleClick != null)
			{
				ExecuteEvents.Execute(BtnMaleClick.gameObject, eventData, ExecuteEvents.pointerExitHandler);
			}
			if (BtnFeMaleClick != null)
			{
				ExecuteEvents.Execute(BtnFeMaleClick.gameObject, eventData, ExecuteEvents.pointerExitHandler);
			}
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	public void OnBtnConfirm()
	{
		if (m_isChanging)
		{
			return;
		}
		switch (m_sexChooseStage)
		{
		case SexChooseStage.ChooseGender:
			if (!isSelect)
			{
				GameUtility.OpenToolTip(1509);
				break;
			}
			if (!m_skipNextGenderConfirmSound)
			{
				PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Clck");
			}
			if (Gender == 1)
			{
				ChangeStage(SexChooseStage.Male);
			}
			else if (Gender == 2)
			{
				ChangeStage(SexChooseStage.Female);
			}
			break;
		case SexChooseStage.Female:
		case SexChooseStage.Male:
			if (!m_skipNextNameConfirmSound)
			{
				PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Confirm");
			}
			ConfirmName();
			break;
		}
	}

	public void OnBtnCancel()
	{
		if (!m_isChanging)
		{
			SexChooseStage sexChooseStage = m_sexChooseStage;
			if ((uint)(sexChooseStage - 2) <= 1u)
			{
				PlayCreateCharacterSound("event:/UI/Interface/CreateCharacter/Clck");
				ClearCurrentInputText();
				ChangeStage(SexChooseStage.ChooseGender);
			}
		}
	}

	private void ClearCurrentInputText()
	{
		TMP_InputField currentInputField = GetCurrentInputField();
		if (currentInputField != null)
		{
			currentInputField.text = "";
		}
	}

	private void ConfirmName()
	{
		if (isBeyondlength)
		{
			return;
		}
		TMP_InputField currentInputField = GetCurrentInputField();
		if (currentInputField == null)
		{
			return;
		}
		string StrName = SanitizeNameInput(currentInputField.text);
		if (StrName != currentInputField.text)
		{
			currentInputField.text = StrName;
		}
		bool flag = Singleton<SensitiveWordManager>.instance._Trie.Check(StrName);
		int gender = Gender;
		string localizeString = LocalizationUtility.GetLocalizeString("Common", (gender == 1) ? 1490 : 1491);
		if (!string.IsNullOrEmpty(StrName))
		{
			if (!flag)
			{
				IList<object> list = new List<object>();
				list.Add(StrName);
				list.Add(localizeString);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LOGINTIPS, new LoginTipsViewData
				{
					OnConfirm = () =>
					{
						StopCreateCharacterMusic();
						ConfirmNameAfterNetworkCheck(StrName, gender).Forget();
					},
					Titletexts = new string[1] { LocalizationUtility.GetLocalizeString("Common", 1489, list) },
					audioOpenSound = "event:/UI/Interface/CreateCharacter/Window_Open",
					audioCloseSound = "event:/UI/Interface/CreateCharacter/Window_Close",
					audioConfirmSound = "event:/UI/Interface/CreateCharacter/Confirm",
					audioCancelSound = "event:/UI/Interface/CreateCharacter/Clck"
				});
			}
			else
			{
				NameViolation();
			}
		}
		else
		{
			GameUtility.OpenToolTip(1508);
		}
	}

	private async UniTask ConfirmNameAfterNetworkCheck(string strName, int gender)
	{
		if (m_isConfirmingName)
		{
			return;
		}
		m_isConfirmingName = true;
		try
		{
			if (Singleton<NetManager>.instance.IsConnected || await ReconnectBeforeCreateCharacter())
			{
				await SendCreateCharacterAsync(strName, gender);
			}
		}
		finally
		{
			m_isConfirmingName = false;
		}
	}

	private async UniTask<bool> ReconnectBeforeCreateCharacter()
	{
		_ = 1;
		try
		{
			Singleton<GameState>.instance.SetGameServerState(GameServerState.Connecting);
			MonoECS.instance.RemoveNetworkListener();
			Singleton<NetManager>.instance.Disconnect();
			LoginAck la = await LoginUtility.ConnectLoginServer();
			G.service.SetNetState(IGameService.NetState.Reconnet);
			await LoginUtility.ConnectGameServerWithGateFallback(la);
			Singleton<GameState>.instance.SetGameServerState(GameServerState.Connected);
			Singleton<NetManager>.instance.MarkOnline();
			MonoECS.instance.AddNetworkdListener();
			return Singleton<NetManager>.instance.IsConnected;
		}
		catch (Exception ex)
		{
			Singleton<NetManager>.instance.Disconnect();
			Singleton<GameState>.instance.SetGameServerState(GameServerState.Disconnected);
			ShowCreateCharacterReconnectError(ex);
			return false;
		}
	}

	private void ShowCreateCharacterReconnectError(Exception ex)
	{
		if (ex is LuminErrorException exception)
		{
			if (LoginUtility.IsLastSessionExpiredError(exception))
			{
				LuminError.Handle(exception, new ErrorHandleOptions(ErrorPresentation.None));
				return;
			}
			LuminError.Handle(exception, new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, RuntimeVersionCheck.IsVersionError(exception) ? new Action(RuntimeVersionCheck.RestartGame) : null));
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogException(ex);
		}
	}

	private async UniTask SendCreateCharacterAsync(string strName, int gender)
	{
		CreateUserReq createUserReq = new CreateUserReq();
		createUserReq.NickName = strName;
		createUserReq.Gender = gender;
		IMessage message = await Singleton<NetManager>.instance.RequestAsync(createUserReq);
		if (message is CreateUserAck ack)
		{
			HandleCreateCharacterAck(ack, strName);
			return;
		}
		if (message is ErrorAck { CodeType: >0 } errorAck)
		{
			LuminError.Handle(errorAck);
			return;
		}
		bool flag = !Singleton<NetManager>.instance.IsConnected;
		if (flag)
		{
			flag = await ReconnectBeforeCreateCharacter();
		}
		if (flag && !LoginUtility.EnterGameAck.IsNewUser)
		{
			CompleteCreateCharacter(LoginUtility.EnterGameAck.Info, strName);
		}
	}

	private void HandleCreateCharacterAck(CreateUserAck ack, string strName)
	{
		if (ack.IsValidName)
		{
			CompleteCreateCharacter(ack.Info, strName);
		}
		else
		{
			NameViolation();
		}
	}

	private void CompleteCreateCharacter(DetailUserInfo info, string strName)
	{
		m_data.info.roleCreateTime = TimeManager.TimeStampToDateTime(m_data.eTs, inMilli: true).ToString("yyyy-MM-dd HH:mm:ss.fff");
		m_data.info.roleName = strName;
		BamBooSdk.getInstance().createRole(m_data.info);
		G.detailUserInfo = info;
		G.localPlayer.Profile = info.Profile;
		ChangeStage(SexChooseStage.End);
	}

	private void NameViolation()
	{
		GameUtility.OpenToolTip(1486);
		ChangeTextColor(isValid: false);
	}

	private void CheckNameLength(string StrName)
	{
		int num = UIUtility.StrLength(StrName);
		int[] nickNameLengthLimit = RuntimeConfigs.data.game.nickNameLengthLimit;
		GameObject currentSupperLimit = GetCurrentSupperLimit();
		if (currentSupperLimit != null)
		{
			currentSupperLimit.SetActive(num > nickNameLengthLimit[1]);
		}
		ActButton currentConfirmButton = GetCurrentConfirmButton();
		if (currentConfirmButton != null)
		{
			currentConfirmButton.Interactable(num > 0 && num <= nickNameLengthLimit[1]);
		}
		isBeyondlength = num > nickNameLengthLimit[1];
		RefreshConfirmInputActionState();
	}

	private void RefreshConfirmInputActionState()
	{
		if (GetInputBindingController() != null)
		{
			bool value = false;
			if (m_sexChooseStage == SexChooseStage.Male || m_sexChooseStage == SexChooseStage.Female)
			{
				ActButton currentConfirmButton = GetCurrentConfirmButton();
				value = currentConfirmButton == null || !currentConfirmButton.interactable;
			}
			Singleton<GameInputActionManager>.instance.SetActionDisabled("UI/Confirm", value);
		}
	}

	private GameObject GetCurrentSupperLimit()
	{
		if (m_sexChooseStage == SexChooseStage.Male)
		{
			return MaleGoSupperLimit;
		}
		if (m_sexChooseStage == SexChooseStage.Female)
		{
			return FemaleGoSupperLimit;
		}
		return null;
	}

	private void UpdateSupperLimitView()
	{
		if (MaleGoSupperLimit != null)
		{
			MaleGoSupperLimit.SetActive(value: false);
		}
		if (FemaleGoSupperLimit != null)
		{
			FemaleGoSupperLimit.SetActive(value: false);
		}
	}

	private void ChangeTextColor(bool isValid)
	{
		if (isValid != this.isValid)
		{
			this.isValid = isValid;
			TMP_InputField currentInputField = GetCurrentInputField();
			if (currentInputField != null && currentInputField.textComponent != null)
			{
				currentInputField.textComponent.color = (isValid ? isValidColor : unValidColor);
			}
		}
	}

	public bool CheckIsValidByName(string Name)
	{
		foreach (KeyValuePair<int, SensitiveWord> item in DicSensitiveWord)
		{
			if (Name.Equals(item.Value.sensitiveWordDetection))
			{
				return false;
			}
		}
		return true;
	}

	private void EnterGame()
	{
		m_GameLoad.GameStartWithOutUI();
		TrackLoginEvt evt = EventTrackSolver.Instance.GetEvt<TrackLoginEvt>();
		EventTrackSolver.Instance.Dispatch(evt);
		TimeManager.ServerTime.SetEnterGameStamp();
		Singleton<LoadManager>.instance.RemoveLoadingViewOpenCompleteListener(EnterGame);
		Close();
	}

	protected override void UnInit()
	{
		if (GetInputBindingController() != null)
		{
			Singleton<GameInputActionManager>.instance.SetActionDisabled("UI/Confirm", value: false);
		}
		base.UnInit();
		StopCreateCharacterMusic();
		UnityEngine.Object.Destroy(m_timelineObj);
		GameUtility.mainCamera?.gameObject.SetActive(value: true);
		RestoreMainLight();
		timelineCamera.GetUniversalAdditionalCameraData().cameraStack.Remove(GameUtility.uiCamera);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
