using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.UI;

public class ShowEmoteData : IReference
{
	public HeroEntity HeroEntity;

	private Image _emoteImage;

	private float _showTime;

	private Camera _battleCamera;

	private ShowEmoteState _showEmoteState;

	private float _gradientsSpeed;

	private float _tempValue;

	private Vector3 _uiOffset;

	private float _emoteMoveSpeed;

	public void InitCommand(Image image, Sprite sprite, HeroEntity heroEntity, Camera battleCamera)
	{
		_emoteImage = image;
		if (!(_emoteImage == null) && !(sprite == null))
		{
			_emoteImage.sprite = sprite;
			HeroEntity = heroEntity;
			_battleCamera = battleCamera;
			_showEmoteState = ShowEmoteState.StartShow;
			_tempValue = 0f;
			UpdatePosition();
			_emoteImage.transform.gameObject.SetActive(value: true);
		}
	}

	public void RefreshEmoteData(float showTime, float gradientsTime, Vector3 offset, float emoteMoveSpeed)
	{
		_uiOffset = offset;
		_showTime = showTime;
		_gradientsSpeed = 1f / gradientsTime;
		_emoteMoveSpeed = emoteMoveSpeed;
	}

	private void UpdatePosition()
	{
		if (HeroEntity != null && !(_battleCamera == null) && !(_emoteImage == null))
		{
			EntityBoneComponent component = HeroEntity.GetComponent<EntityBoneComponent>();
			if (component != null)
			{
				Vector3 position = component.GetBonePosition("top") + _uiOffset;
				Vector3 vector = _battleCamera.WorldToScreenPoint(position);
				Vector2 anchoredPosition = default(Vector2);
				RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)_emoteImage.transform.parent, (Vector2)vector, UIUtilly.GetUICamera(), ref anchoredPosition);
				_emoteImage.GetComponent<RectTransform>().anchoredPosition = anchoredPosition;
			}
		}
	}

	public void RefreshTime(float showTime, Sprite sprite)
	{
		_showTime = showTime;
		if (!(_emoteImage == null))
		{
			if (_showEmoteState == ShowEmoteState.WaitShow)
			{
				UpdatePosition();
				_showEmoteState = ShowEmoteState.StartShow;
				_emoteImage.color = new Color(1f, 1f, 1f, 0f);
				_emoteImage.sprite = sprite;
				_emoteImage.transform.gameObject.SetActive(value: true);
			}
			else
			{
				_showEmoteState = ShowEmoteState.Show;
				_emoteImage.sprite = sprite;
				_emoteImage.color = new Color(1f, 1f, 1f, 1f);
			}
		}
	}

	public void Update(float deltaTime)
	{
		if (_emoteImage == null || HeroEntity == null || _battleCamera == null || !_emoteImage.transform.gameObject.activeSelf)
		{
			return;
		}
		_showTime -= deltaTime;
		EntityBoneComponent component = HeroEntity.GetComponent<EntityBoneComponent>();
		if (component != null)
		{
			Vector3 position = component.GetBonePosition("top") + _uiOffset;
			Vector3 vector = _battleCamera.WorldToScreenPoint(position);
			Vector2 vector2 = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)_emoteImage.transform.parent, (Vector2)vector, UIUtilly.GetUICamera(), ref vector2);
			_emoteImage.GetComponent<RectTransform>().anchoredPosition = Vector3.Lerp(_emoteImage.GetComponent<RectTransform>().anchoredPosition, vector2, deltaTime * _emoteMoveSpeed);
			if (_showEmoteState == ShowEmoteState.StartShow)
			{
				StartShow(deltaTime);
			}
			else if (_showTime <= 0f)
			{
				_showEmoteState = ShowEmoteState.HideShow;
				HideShow(deltaTime);
			}
		}
	}

	private void HideShow(float deltaTime)
	{
		_tempValue = Mathf.Clamp(_tempValue - deltaTime * _gradientsSpeed, 0f, 1f);
		_emoteImage.color = new Color(1f, 1f, 1f, _tempValue);
		if (_tempValue == 0f)
		{
			_emoteImage.transform.gameObject.SetActive(value: false);
			_showEmoteState = ShowEmoteState.WaitShow;
		}
	}

	private void StartShow(float deltaTime)
	{
		_emoteImage.transform.gameObject.SetActive(value: true);
		_tempValue = Mathf.Clamp(_tempValue + deltaTime * _gradientsSpeed, 0f, 1f);
		_emoteImage.color = new Color(1f, 1f, 1f, _tempValue);
		if (_tempValue >= 1f)
		{
			_showEmoteState = ShowEmoteState.Show;
		}
	}

	public void Clear()
	{
		_emoteImage = null;
		_showTime = 0f;
		HeroEntity = null;
		_battleCamera = null;
	}
}
