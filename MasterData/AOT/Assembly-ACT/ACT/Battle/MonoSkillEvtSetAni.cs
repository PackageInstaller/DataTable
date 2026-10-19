using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MonoSkillEvtSetAni : MonoBehaviour
{
	public int id;

	[Range(0f, 1f)]
	public float percent;

	public Animator animator;

	public string parameterName;

	private void Start()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SkillInteract, OnSkillInteract);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SkillInteract, OnSkillInteract);
	}

	private void OnSkillInteract(BaseEventContent obj)
	{
		if (((SkillInteractEvt)obj).id == id && Random.value <= percent)
		{
			animator.SetTrigger(parameterName);
		}
	}
}
