using ACT.Event;
using ACT.MultiPlayer;
using Fundamental;
using UnityEngine;

namespace ACT;

[ExecuteInEditMode]
[AddComponentMenu("3UI工具/跳字测试工具 TestDamageNumberSpawner")]
public class TestDamageNumberSpawner : MonoBehaviour
{
	public bool spawn = true;

	public float time = 1f;

	public bool useEasyMode;

	public CmdDamageNumber cmdDamageNumber;

	private float timer;

	private void Start()
	{
	}

	private void Update()
	{
		if (!spawn)
		{
			return;
		}
		timer -= Time.deltaTime;
		if (timer <= 0f)
		{
			timer = time;
			DamageNumberSpawnEvt evt = Singleton<EventManager>.instance.GetEvt<DamageNumberSpawnEvt>();
			if (!useEasyMode)
			{
				evt.cmdDamageNumber = cmdDamageNumber;
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.DamageNumberSpawn, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
