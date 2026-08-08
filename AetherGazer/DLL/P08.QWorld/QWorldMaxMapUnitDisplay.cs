using UnityEngine;
using UnityEngine.UI;

public class QWorldMaxMapUnitDisplay : MonoBehaviour
{
	private RectTransform content;

	private QWorldMaxMapUI maxMap;

	private Transform parentTransform;

	public Image clickSprite;

	public Transform arrowSprite;

	public QWorldMaxMapUnitDisplayeRender display_static;

	public QWorldMaxMapUnitDisplayeRender display_dynamics;

	public Button clickButton;

	private int EntityEntityId;

	public bool track_show;

	public void Init(QWorldMaxMapUI maxMap, RectTransform content)
	{
		this.content = content;
		this.maxMap = maxMap;
		parentTransform = base.transform.parent;
		clickButton.onClick.AddListener(delegate
		{
			maxMap.SelectEntityEntityId(EntityEntityId);
		});
	}

	public void OnReturn()
	{
		base.gameObject.SetActive(value: false);
	}

	public void Render(QWorldMiniMapUnit unit)
	{
		EntityEntityId = unit.EntityEntityId;
		bool maxMapDisplay = unit.GetMaxMapDisplay();
		track_show = unit.IsTrack;
		base.gameObject.SetActive(maxMapDisplay);
		if (maxMapDisplay)
		{
			display_static.Render(unit, isDynamics: false);
			display_dynamics.Render(unit, isDynamics: true);
		}
	}

	public void UpdateMapRate(QWorldMiniMapUnit unit)
	{
		if (1 == unit.MiniMapType)
		{
			display_static.RenderRectSprite(unit);
		}
		UpdatePosition(unit.Position, unit.IsTrack);
	}

	public void UpdatePosition(Vector3 unitPosition, bool isFollow)
	{
		Vector3 vector = (unitPosition - QWorldMaxMapUI.AGENT_POSITION_OFFSET) * QWorldMaxMapUI.MAX_MAP_RATIO;
		vector = new Vector3(vector.x, vector.z, 0f);
		base.transform.localPosition = vector;
		RectTransform component = base.transform.GetComponent<RectTransform>();
		if (!isFollow)
		{
			display_dynamics.SetActive(value: false);
			return;
		}
		Vector3 position = parentTransform.TransformPoint(vector);
		Vector3 vector2 = content.InverseTransformPoint(position);
		float num = Mathf.Clamp(vector2.x, 0f - QWorldMaxMapUI.MapContentHalfSize.x - component.rect.width, QWorldMaxMapUI.MapContentHalfSize.x + component.rect.width);
		float num2 = Mathf.Clamp(vector2.y, 0f - QWorldMaxMapUI.MapContentHalfSize.y - component.rect.height, QWorldMaxMapUI.MapContentHalfSize.y + component.rect.height);
		if (vector2.x != num || vector2.y != num2)
		{
			num = Mathf.Clamp(num, 0f - QWorldMaxMapUI.MapContentHalfSize.x, QWorldMaxMapUI.MapContentHalfSize.x);
			num2 = Mathf.Clamp(num2, 0f - QWorldMaxMapUI.MapContentHalfSize.y, QWorldMaxMapUI.MapContentHalfSize.y);
			Vector3 position2 = content.TransformPoint(new Vector3(num, num2, 0f));
			Vector3 position3 = base.transform.InverseTransformPoint(position2);
			float angleBetweenVectors = QWorldMaxMapUI.GetAngleBetweenVectors(vector - maxMap.mapImag.InverseTransformPoint(position2), Vector3.up, Vector3.forward);
			arrowSprite.eulerAngles = new Vector3(0f, 0f, angleBetweenVectors);
			display_dynamics.SetActive(value: true);
			display_dynamics.SetPosition(position3);
			clickSprite.SetActive(bActive: false);
		}
		else
		{
			display_dynamics.SetActive(value: false);
			clickSprite.SetActive(bActive: true);
		}
	}

	public void SelectInMap()
	{
		maxMap.SetMapPos(-1f * base.transform.localPosition);
	}
}
