using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class PrizeDayTag : MonoBehaviour
{
	public GameObject Normal;

	public GameObject Received;

	public GameObject Receiving;

	public void SetStatus(ActivityCenterModel.ActivityRewardState state)
	{
		switch (state)
		{
		case ActivityCenterModel.ActivityRewardState.Normal:
			Normal.SetActive(value: true);
			Received.SetActive(value: false);
			Receiving.SetActive(value: false);
			break;
		case ActivityCenterModel.ActivityRewardState.Receive:
			Normal.SetActive(value: false);
			Received.SetActive(value: false);
			Receiving.SetActive(value: true);
			break;
		case ActivityCenterModel.ActivityRewardState.Received:
			Normal.SetActive(value: false);
			Received.SetActive(value: true);
			Receiving.SetActive(value: false);
			break;
		}
	}
}
