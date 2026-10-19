using ACT.Battle;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TransformWifiUI : MonoBehaviour
{
	public GameObject[] images;

	private float m_Percent;

	public float Percent
	{
		get
		{
			return m_Percent;
		}
		set
		{
			if (!Mathf.Approximately(value, m_Percent))
			{
				if (m_Percent < 2f / (float)images.Length && value >= 2f / (float)images.Length)
				{
					GameUtility.OpenToolTip(1516);
				}
				m_Percent = value;
			}
		}
	}

	private void FixedUpdate()
	{
		if (!MonoECS.instance.mainEntity.IsLogicAvailable())
		{
			return;
		}
		float magnitude = (MonoECS.instance.mainEntity.GetCompTransform().physicsPosition - transform.position).magnitude;
		Percent = magnitude / GameLoader.meta.controlPathDistance;
		images[0].SetActive(Percent >= 2f / (float)images.Length && Percent <= 1f);
		images[1].SetActive(Percent >= 1f / (float)images.Length && Percent < 2f / (float)images.Length);
		images[2].SetActive(Percent < 1f / (float)images.Length);
		if (Percent > 1f)
		{
			GameObject[] array = images;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: false);
			}
			ExitStateObjectControlEvt evt = Singleton<EventManager>.instance.GetEvt<ExitStateObjectControlEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void Update()
	{
		transform.rotation = Quaternion.identity;
	}
}
