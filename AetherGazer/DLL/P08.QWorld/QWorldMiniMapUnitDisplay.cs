using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMiniMapUnitDisplay : MonoBehaviour
{
	public Image sprite;

	public Image rectSprite;

	public Image baseSprite;

	public Image circularSprite;

	public Image circularAniSprite;

	public Transform iconTrans;

	private Transform content;

	private QWorldMiniMapUI miniMap;

	[HideInInspector]
	public bool track_show;

	public ControllerExCollection controllerExCollection;

	private ControllerEx iconTypeController;

	private ControllerEx trackController;

	private ControllerEx miniMapTypeController;

	private Image[] images;

	private int zoneType;

	private void Awake()
	{
		iconTypeController = controllerExCollection.GetController("type");
		trackController = controllerExCollection.GetController("isTracking");
		miniMapTypeController = controllerExCollection.GetController("miniMapType");
		images = GetComponentsInChildren<Image>(includeInactive: true);
	}

	public void Init(QWorldMiniMapUI miniMap, Transform content)
	{
		this.content = content;
		this.miniMap = miniMap;
	}

	public void Render(QWorldMiniMapUnit unit)
	{
		bool miniMapDisplay = unit.GetMiniMapDisplay();
		track_show = unit.IsTrackMini;
		base.gameObject.SetActive(miniMapDisplay);
		if (!miniMapDisplay)
		{
			return;
		}
		if (unit.MiniMapType == 1)
		{
			zoneType = unit.ZoneType;
			miniMapTypeController.SetSelectedIndex(zoneType);
			RenderRectSprite(unit);
		}
		else
		{
			miniMapTypeController.SetSelectedIndex(0);
		}
		if (!string.IsNullOrEmpty(unit.Icon))
		{
			sprite.sprite = AssetEx.LoadSprite(unit.Icon);
		}
		if (!string.IsNullOrEmpty(unit.baseIcon))
		{
			baseSprite.sprite = AssetEx.LoadSprite(unit.baseIcon);
		}
		iconTypeController.SetSelectedIndex(unit.IconType);
		if (images != null)
		{
			Image[] array = images;
			foreach (Image image in array)
			{
				if (image == rectSprite || image == circularSprite || image == circularAniSprite)
				{
					image.maskable = true;
				}
				else
				{
					image.maskable = !track_show;
				}
			}
		}
		trackController.SetSelectedIndex((!track_show) ? 1 : 0);
		if (track_show)
		{
			base.transform.SetAsLastSibling();
		}
	}

	private void RenderRectSprite(QWorldMiniMapUnit unit)
	{
		if (1 == zoneType)
		{
			Vector3 eulerAngles = unit.Rotation.eulerAngles;
			rectSprite.transform.eulerAngles = new Vector3(0f, 180f, eulerAngles.y);
			Vector3 volumeSize = unit.VolumeSize;
			float x = volumeSize.x * QWorldMiniMapUI.MINI_MAP_RATIO;
			float y = volumeSize.y * QWorldMiniMapUI.MINI_MAP_RATIO;
			rectSprite.rectTransform.sizeDelta = new Vector2(x, y);
		}
		else if (2 == zoneType)
		{
			float num = unit.Radius * 2f;
			circularSprite.rectTransform.sizeDelta = new Vector2(num * QWorldMiniMapUI.MINI_MAP_RATIO, num * QWorldMiniMapUI.MINI_MAP_RATIO);
		}
	}

	public void OnReturn()
	{
		base.gameObject.SetActive(value: false);
	}

	public void UpdatePosition(Vector3 unitPositon, Vector3 agentPosition)
	{
		float num = 125f;
		if (Vector3.Distance(agentPosition, unitPositon) * QWorldMiniMapUI.MINI_MAP_RATIO < num)
		{
			UpdatePosition(unitPositon);
			return;
		}
		Vector3 vector = unitPositon - QWorldMiniMapUI.AGENT_POSITION_OFFSET;
		vector *= QWorldMiniMapUI.MINI_MAP_RATIO;
		base.transform.localPosition = new Vector3(vector.x, vector.z, 0f);
		Vector3 vector2 = unitPositon - agentPosition;
		Vector2 vector3 = new Vector2(vector2.x, vector2.z);
		Vector3 position = content.TransformPoint(vector3.normalized * num);
		Vector3 localPosition = base.transform.InverseTransformPoint(position);
		iconTrans.transform.localPosition = localPosition;
	}

	public void UpdatePosition(Vector3 unitPositon)
	{
		Vector3 vector = unitPositon - QWorldMiniMapUI.AGENT_POSITION_OFFSET;
		vector *= QWorldMiniMapUI.MINI_MAP_RATIO;
		base.transform.localPosition = new Vector3(vector.x, vector.z, 0f);
		iconTrans.transform.localPosition = Vector3.zero;
	}
}
