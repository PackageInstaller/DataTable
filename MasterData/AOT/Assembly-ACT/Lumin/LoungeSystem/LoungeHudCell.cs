using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace Lumin.LoungeSystem;

public class LoungeHudCell : MonoBehaviour
{
	[Header("UI组件引用")]
	public GameObject characterHud;

	public GameObject showCharacterTips;

	public GameObject showCharacterChat;

	public GameObject showBothInteract;

	public GameObject pointHud;

	public TextMeshProUGUI pointText;

	public ActButton pointButton;

	public LocalizeStringEvent pointReference;

	[Header("手柄选中态Handle-点位")]
	public GameObject pointSelectHandle;

	[Header("手柄选中态Handle-有角色")]
	public GameObject characterSelectHandle;

	[Header("动画")]
	[SerializeField]
	private BetterAnimation hudAnimator;

	private LoungePoint _currentData;

	private Transform _characterSelectTargetTransform;

	private RectTransform _characterSelectHandleRectTransform;

	private RectTransform _rectTransform;

	private Vector2 _characterSelectHandleDefaultAnchoredPosition;

	private bool _hasCachedCharacterSelectHandleDefaultAnchoredPosition;

	private Vector2 _lockedCharacterSelectHandleHudRootPosition;

	private bool _hasLockedCharacterSelectHandleHudRootPosition;

	private Transform _targetTransform;

	public LoungePoint CurrentData => _currentData;

	public bool isEmptyPoint
	{
		get
		{
			LoungePoint currentData = _currentData;
			if (currentData == null)
			{
				return false;
			}
			return currentData.character.Count == 0;
		}
	}

	public int CharacterId { get; private set; }

	public float CharacterHudHeightOffset { get; private set; }

	public Transform TargetHudTransform => _targetTransform;

	public Transform CharacterSelectTargetTransform => _characterSelectTargetTransform;

	public RectTransform RectTransform
	{
		get
		{
			if (_rectTransform == null)
			{
				_rectTransform = transform as RectTransform;
			}
			return _rectTransform;
		}
	}

	public bool TrySubmitSelectedAction()
	{
		if (!isEmptyPoint || pointButton == null || !pointButton.gameObject.activeInHierarchy || !pointButton.interactable)
		{
			return false;
		}
		pointButton.OnSubmit(null);
		return true;
	}

	public void SetGamepadSelected(bool selected, bool isGamepadMode)
	{
		if (pointSelectHandle != null)
		{
			pointSelectHandle.SetActive((isGamepadMode & selected) && isEmptyPoint);
		}
		if (characterSelectHandle != null)
		{
			bool flag = (isGamepadMode & selected) && !isEmptyPoint;
			if (!flag)
			{
				ResetCharacterSelectHandlePosition();
			}
			characterSelectHandle.SetActive(flag);
		}
	}

	public void Init(LoungePoint data, int characterId = 0, Transform targetTransform = null, Transform characterSelectTargetTransform = null, float characterHudHeightOffset = 0f)
	{
		_currentData = data;
		CharacterId = characterId;
		CharacterHudHeightOffset = characterHudHeightOffset;
		SetGamepadSelected(selected: false, isGamepadMode: false);
		characterHud.gameObject.SetActive(data.character.Count > 0 && (data.waitStory != 0 || data.performID != 0));
		pointHud.gameObject.SetActive(data.character.Count <= 0);
		_targetTransform = targetTransform;
		_characterSelectTargetTransform = ((characterSelectTargetTransform != null) ? characterSelectTargetTransform : targetTransform);
		ResetCharacterSelectHandlePosition();
		if (data.character.Count > 0)
		{
			showCharacterTips.SetActive(data.waitStory != 0 && data.performID == 0);
			showCharacterChat.SetActive(data.waitStory == 0 && data.performID != 0);
			showBothInteract.SetActive(data.waitStory != 0 && data.performID != 0);
			return;
		}
		pointReference.StringReference.TableEntryReference = data.name;
		pointButton.SetBtnClick(() =>
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INVITECHARACTER, new UI_InviteCharacterViewData
			{
				pointId = _currentData.id
			});
		});
	}

	public void SetCharacterSelectHandleLocalPosition(Vector2 anchoredPosition)
	{
		RectTransform characterSelectHandleRectTransform = GetCharacterSelectHandleRectTransform();
		if (!(characterSelectHandleRectTransform == null))
		{
			characterSelectHandleRectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public void LockCharacterSelectHandleHudRootPosition(Vector2 hudRootLocalPosition)
	{
		_lockedCharacterSelectHandleHudRootPosition = hudRootLocalPosition;
		_hasLockedCharacterSelectHandleHudRootPosition = true;
		RefreshLockedCharacterSelectHandlePosition();
	}

	public void RefreshLockedCharacterSelectHandlePosition()
	{
		if (!_hasLockedCharacterSelectHandleHudRootPosition)
		{
			return;
		}
		RectTransform characterSelectHandleRectTransform = GetCharacterSelectHandleRectTransform();
		if (!(characterSelectHandleRectTransform == null) && !(RectTransform == null))
		{
			float num = transform.localScale.x;
			if (Mathf.Abs(num) < 0.0001f)
			{
				num = 1f;
			}
			Vector2 anchoredPosition = (_lockedCharacterSelectHandleHudRootPosition - RectTransform.anchoredPosition) / num;
			characterSelectHandleRectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public void ResetCharacterSelectHandlePosition()
	{
		RectTransform characterSelectHandleRectTransform = GetCharacterSelectHandleRectTransform();
		if (!(characterSelectHandleRectTransform == null))
		{
			_hasLockedCharacterSelectHandleHudRootPosition = false;
			if (_hasCachedCharacterSelectHandleDefaultAnchoredPosition)
			{
				characterSelectHandleRectTransform.anchoredPosition = _characterSelectHandleDefaultAnchoredPosition;
			}
		}
	}

	private RectTransform GetCharacterSelectHandleRectTransform()
	{
		if (characterSelectHandle == null)
		{
			return null;
		}
		if (_characterSelectHandleRectTransform == null)
		{
			_characterSelectHandleRectTransform = characterSelectHandle.GetComponent<RectTransform>();
		}
		if (_characterSelectHandleRectTransform != null && !_hasCachedCharacterSelectHandleDefaultAnchoredPosition)
		{
			_characterSelectHandleDefaultAnchoredPosition = _characterSelectHandleRectTransform.anchoredPosition;
			_hasCachedCharacterSelectHandleDefaultAnchoredPosition = true;
		}
		return _characterSelectHandleRectTransform;
	}
}
