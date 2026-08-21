using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DistanceCanelSkill : MonoBehaviour
{
	[SerializeField]
	private Image ShowImage;

	private float distance;

	private bool isShowing;

	public RectTransform distanceCancel;

	private GameObject pressBtnRecord;

	[SerializeField]
	private Color nroaml = new Color(0.29411766f, 0.77254903f, 1f);

	private bool pointUpCancelSkill;

	private Color cancelReleaseColor = new Color(46f / 51f, 0.24313726f, 10f / 51f);

	public bool DragShowDistanceCancel(GameObject pressBtn, Vector3 dirVector3, Vector3 btnPos)
	{
		if (pressBtnRecord != null && pressBtnRecord != pressBtn)
		{
			return false;
		}
		pointUpCancelSkill = false;
		pressBtnRecord = pressBtn;
		ShowImage.enabled = true;
		float num = Vector2.Angle(dirVector3, Vector2.up);
		if (dirVector3.x > 0f)
		{
			num = 0f - num;
		}
		float magnitude = dirVector3.magnitude;
		pointUpCancelSkill = magnitude >= distance;
		float num2 = Mathf.Clamp(magnitude / distance, 0f, 1f);
		if (num2 == 1f)
		{
			cancelReleaseColor.a = num2;
			ShowImage.color = cancelReleaseColor;
		}
		else
		{
			nroaml.a = num2;
			ShowImage.color = nroaml;
		}
		UIUtilly.WrapperSetUIPosition(distanceCancel, btnPos + dirVector3.normalized * distance);
		distanceCancel.localEulerAngles = Vector3.forward * num;
		return pointUpCancelSkill;
	}

	public bool PointUpIsCancelSkill(GameObject pressBtn)
	{
		if (pressBtnRecord != null && pressBtnRecord == pressBtn)
		{
			ShowImage.enabled = false;
			pressBtnRecord = null;
			return pointUpCancelSkill;
		}
		return false;
	}

	public void SetCancelDistance(float cancelDistance)
	{
		distance = cancelDistance;
	}

	public void SetNormalColor(Color color)
	{
		nroaml = color;
	}
}
