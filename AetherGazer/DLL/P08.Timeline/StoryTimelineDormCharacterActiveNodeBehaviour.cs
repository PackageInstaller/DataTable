using Dorm;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineDormCharacterActiveNodeBehaviour : StoryTimelineDormCharacterBehaviour
{
	public int actorIndex;

	public bool active;

	public ExposedReference<Transform> parent;

	public Vector3 position;

	public Vector3 rotation;

	public bool invert;

	public bool isLocal;

	private Transform m_parent;

	public override void OnGraphStart(Playable playable)
	{
		m_parent = parent.Resolve(playable.GetGraph().GetResolver());
	}

	protected override void Enter()
	{
		if (!DormStoryManager.instance.hasInited)
		{
			return;
		}
		GameObject actorGoByIndex = DormStoryManager.instance.GetActorGoByIndex(actorIndex);
		if (!(actorGoByIndex != null))
		{
			return;
		}
		if (active)
		{
			actorGoByIndex.SetActive(value: true);
			if (m_parent != null)
			{
				actorGoByIndex.transform.SetParent(m_parent);
			}
			if (isLocal)
			{
				actorGoByIndex.transform.localPosition = position;
				actorGoByIndex.transform.localRotation = Quaternion.Euler(rotation);
			}
			else
			{
				actorGoByIndex.transform.position = position;
				actorGoByIndex.transform.rotation = Quaternion.Euler(rotation);
			}
		}
		else
		{
			actorGoByIndex.SetActive(value: false);
		}
	}

	protected override void Exit()
	{
		if (!DormStoryManager.instance.hasInited || !invert)
		{
			return;
		}
		GameObject actorGoByIndex = DormStoryManager.instance.GetActorGoByIndex(actorIndex);
		if (actorGoByIndex != null)
		{
			if (active)
			{
				actorGoByIndex.SetActive(value: false);
			}
			else
			{
				actorGoByIndex.SetActive(value: true);
			}
		}
	}
}
