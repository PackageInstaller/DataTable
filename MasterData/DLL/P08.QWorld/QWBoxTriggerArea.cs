using UnityEngine;

public class QWBoxTriggerArea : MonoBehaviour
{
	public static string BoxEnterAreaFunc = "QWBoxTriggerEnterAreaFunc";

	public static string BoxExitAreaFunc = "QWBoxTriggerExitAreaFunc";

	public bool is_trigger;

	public static Collider[] interactableObjects = new Collider[1];

	public int uniqueId;

	public Vector3 size;

	public void Start()
	{
		QWorldMapEntity component = GetComponent<QWorldMapEntity>();
		if (null != component)
		{
			uniqueId = component.uniqueId;
			size = component.size;
		}
	}

	private void Update()
	{
		if (!(size.x > 0f) && !(size.y > 0f) && !(size.z > 0f))
		{
			return;
		}
		for (int i = 0; i < interactableObjects.Length; i++)
		{
			interactableObjects[i] = null;
		}
		Physics.OverlapBoxNonAlloc(base.transform.position, size / 2f, interactableObjects, base.transform.rotation, QWorldHelper.CharacterMask);
		if (null != interactableObjects[0])
		{
			if (!is_trigger)
			{
				is_trigger = true;
				OnTriggerChange(isTrigger: true);
			}
		}
		else if (is_trigger)
		{
			is_trigger = false;
			OnTriggerChange(isTrigger: false);
		}
	}

	private void OnTriggerChange(bool isTrigger)
	{
		if (uniqueId != 0)
		{
			if (isTrigger)
			{
				LuaHelper.GetFunc(BoxEnterAreaFunc).Call(uniqueId);
			}
			else
			{
				LuaHelper.GetFunc(BoxExitAreaFunc).Call(uniqueId);
			}
		}
	}
}
