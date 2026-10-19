using ACT.Battle;
using UnityEngine;

namespace ACT.EventTrack;

public class EventTrackTrigger : MonoBehaviour
{
	private void OnTriggerEnter(Collider collision)
	{
		if (gameObject.activeInHierarchy)
		{
			MonoEntity component = collision.gameObject.GetComponent<MonoEntity>();
			if (component != null && MonoECS.instance.IsMainEntity(component.entity))
			{
				EventTrackSolver.Instance.Dispatch(EventTrackSolver.Instance.GetEvt<TrackTriggerEnterEvt>());
			}
		}
	}
}
