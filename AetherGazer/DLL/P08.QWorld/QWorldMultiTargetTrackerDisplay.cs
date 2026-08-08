using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMultiTargetTrackerDisplay : MonoBehaviour
{
	private RectTransform rectTransform;

	private Transform flowTarget;

	private bool _lastLoaded;

	public Transform arrow;

	public Image icon;

	public Image baseIcon;

	public Text distanceText;

	public QWorldMapEntity trackEntitiy;

	public ControllerExCollection controllerExCollection;

	private ControllerEx iconTypeController;

	private ControllerEx isGuideController;

	private int cacheDistance = -1;

	public Vector3 offset = new Vector3(0f, 1f, 0f);

	public bool IsEnable { get; private set; }

	public void Init()
	{
		rectTransform = GetComponent<RectTransform>();
		iconTypeController = controllerExCollection.GetController("type");
		isGuideController = controllerExCollection.GetController("isGuide");
	}

	public void SetActive(bool value)
	{
		IsEnable = value;
		base.gameObject.SetActive(value);
	}

	public Vector3 GetFlowPosition()
	{
		if ((bool)flowTarget)
		{
			if (_lastLoaded != trackEntitiy.isLoaded)
			{
				Refresh(trackEntitiy);
			}
			return flowTarget.position + offset;
		}
		SetActive(value: false);
		return Vector3.zero;
	}

	public void SetIconPosition(Vector2 position, Vector2 direction, bool isInSide, float distance)
	{
		rectTransform.anchoredPosition = position;
		if (isInSide)
		{
			isGuideController.SetSelectedIndex(1);
			if (distance >= 2f)
			{
				if (cacheDistance != (int)distance)
				{
					distanceText.text = (int)distance + QWorldMultiTargetTracker.MeterUnitStr;
					cacheDistance = (int)distance;
				}
			}
			else
			{
				distanceText.text = "";
			}
		}
		else
		{
			isGuideController.SetSelectedIndex(0);
			float num = Mathf.Atan2(direction.y, direction.x) * 57.29578f;
			arrow.rotation = Quaternion.Euler(0f, 0f, num - 90f);
		}
	}

	internal void Refresh(QWorldMapEntity entity)
	{
		Reset();
		trackEntitiy = entity;
		flowTarget = entity.GetTrackTransform();
		Transform transform = entity.BlackBoard?.GetHudPoint();
		if (transform != null)
		{
			flowTarget = transform;
			offset = Vector3.zero;
		}
		else
		{
			offset = new Vector3(0f, 1f, 0f);
		}
		_lastLoaded = trackEntitiy.isLoaded;
		QWorldMiniMapUnit miniMapUnit = entity.GetMiniMapUnit();
		if (miniMapUnit != null)
		{
			if (!string.IsNullOrEmpty(miniMapUnit.Icon))
			{
				icon.sprite = AssetEx.LoadSprite(miniMapUnit.Icon);
			}
			iconTypeController.SetSelectedIndex(miniMapUnit.IconType);
			if (miniMapUnit.baseIcon != null)
			{
				baseIcon.sprite = AssetEx.LoadSprite(miniMapUnit.baseIcon);
			}
		}
		if (trackEntitiy.BlackBoard != null)
		{
			trackEntitiy.BlackBoard.isTracking = true;
		}
	}

	internal void Reset()
	{
		if (trackEntitiy != null && trackEntitiy.BlackBoard != null)
		{
			trackEntitiy.BlackBoard.isTracking = false;
		}
		trackEntitiy = null;
	}
}
