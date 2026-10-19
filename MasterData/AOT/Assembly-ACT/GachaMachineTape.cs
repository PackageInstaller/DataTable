using UnityEngine;

public class GachaMachineTape : MonoBehaviour
{
	public GameObject QualityB;

	public GameObject QualityA;

	public GameObject QualityS;

	private void Start()
	{
	}

	public void Refresh(int quality)
	{
		if (QualityB != null)
		{
			QualityB?.SetActive(quality < 4);
		}
		if (QualityA != null)
		{
			QualityA?.SetActive(quality == 4);
		}
		if (QualityS != null)
		{
			QualityS?.SetActive(quality == 5);
		}
	}

	public void RestALLHide()
	{
		if (QualityB != null)
		{
			QualityB?.SetActive(value: false);
		}
		if (QualityA != null)
		{
			QualityA?.SetActive(value: false);
		}
		if (QualityS != null)
		{
			QualityS?.SetActive(value: false);
		}
	}

	private void Update()
	{
	}
}
