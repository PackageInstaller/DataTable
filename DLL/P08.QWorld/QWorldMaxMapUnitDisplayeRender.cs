using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMaxMapUnitDisplayeRender : MonoBehaviour
{
	public Image sprite;

	public Image rectSprite;

	public Image circularSprite;

	public Image baseSprite;

	public RectTransform circularTrs;

	public ControllerExCollection controllerExCollection;

	private ControllerEx selectController;

	private ControllerEx iconTypeController;

	private ControllerEx miniMapTypeController;

	private int zoneType;

	private void Awake()
	{
		selectController = controllerExCollection.GetController("select");
		iconTypeController = controllerExCollection.GetController("type");
		miniMapTypeController = controllerExCollection.GetController("miniMapType");
	}

	public void Render(QWorldMiniMapUnit unit, bool isDynamics)
	{
		if (isDynamics)
		{
			miniMapTypeController.SetSelectedIndex(0);
		}
		else if (unit.MiniMapType == 1)
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
		sprite.maskable = !unit.IsTrack;
		iconTypeController.SetSelectedIndex(unit.IconType);
		if (unit.baseIcon.IsNotNullOrEmpty())
		{
			baseSprite.sprite = AssetEx.LoadSprite(unit.baseIcon);
		}
		selectController.SetSelectedIndex((!unit.Select) ? 1 : 0);
	}

	public void RenderRectSprite(QWorldMiniMapUnit unit)
	{
		if (1 == zoneType)
		{
			Vector3 eulerAngles = unit.Rotation.eulerAngles;
			rectSprite.transform.eulerAngles = new Vector3(0f, 180f, eulerAngles.y);
			Vector3 volumeSize = unit.VolumeSize;
			float x = volumeSize.x * QWorldMaxMapUI.MAX_MAP_RATIO;
			float y = volumeSize.y * QWorldMaxMapUI.MAX_MAP_RATIO;
			rectSprite.rectTransform.sizeDelta = new Vector2(x, y);
		}
		else if (2 == zoneType)
		{
			float num = unit.Radius * 2f;
			circularTrs.sizeDelta = new Vector2(num * QWorldMaxMapUI.MAX_MAP_RATIO, num * QWorldMaxMapUI.MAX_MAP_RATIO);
		}
	}

	public void SetPosition(Vector3 pos)
	{
		base.transform.localPosition = pos;
	}

	public void SetActive(bool value)
	{
		base.gameObject.SetActive(value);
	}
}
