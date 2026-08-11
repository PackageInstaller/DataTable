using UnityEngine;
using UnityEngine.UI;

public class WeaknessSquare : MonoBehaviour
{
	public GameObject Square1;

	public Image Square1Image;

	public Image Square2Image;

	public void SetSquare(Color color, int level, bool isRotate)
	{
		Square1.SetActive(level == 2);
		Square1Image.gameObject.SetActive(level == 2);
		Square2Image.gameObject.SetActive(level != 2);
		if (level == 2)
		{
			Square1Image.color = color;
		}
		else
		{
			Square2Image.color = color;
		}
		Square1.transform.localEulerAngles = (isRotate ? (Vector3.forward * 180f) : Vector3.zero);
		Square1Image.transform.localEulerAngles = (isRotate ? (Vector3.forward * 180f) : Vector3.zero);
	}
}
