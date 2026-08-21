using UnityEngine;

namespace Ase;

public class LanceActiveSegment : MonoBehaviour
{
	[SerializeField]
	private GameObject shortSegment;

	[SerializeField]
	private Animation segmentAni;

	private int curType = -1;

	public void SetSegmentShow(bool showLong)
	{
		if ((!showLong || curType != 2) && (showLong || curType != 1))
		{
			curType = ((!showLong) ? 1 : 2);
			bool flag = base.gameObject.activeSelf && !showLong;
			if (!base.gameObject.activeSelf)
			{
				base.gameObject.SetActive(value: true);
			}
			if (shortSegment.activeSelf == showLong)
			{
				shortSegment.SetActive(!showLong);
			}
			if (showLong)
			{
				SegmengLightActive(activeState: true);
				segmentAni.Play("Segmaent_enter");
			}
			else if (flag)
			{
				SegmengLightActive(activeState: true);
				segmentAni.Play("Segmaent_out");
			}
			else
			{
				SegmengLightActive(activeState: false);
			}
		}
	}

	private void SegmengLightActive(bool activeState)
	{
		if (((Component)(object)segmentAni).gameObject.activeSelf != activeState)
		{
			((Component)(object)segmentAni).gameObject.SetActive(activeState);
		}
	}

	public void NoSegmentShow()
	{
		if (curType != 0)
		{
			base.gameObject.SetActive(value: false);
			curType = 0;
		}
	}
}
