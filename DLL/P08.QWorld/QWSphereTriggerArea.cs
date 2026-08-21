using UnityEngine;

public class QWSphereTriggerArea : MonoBehaviour
{
	public static string EnterFunc = "QWSphereEnterAreaFunc";

	public static string ExitFunc = "QWSphereExitAreaFunc";

	public int uniqueId;

	public int enter_size = 3;

	public int exit_size = 10;

	[SerializeField]
	private bool isStart;

	public void Start()
	{
		QWorldMapEntity component = GetComponent<QWorldMapEntity>();
		if (null != component)
		{
			uniqueId = component.uniqueId;
			enter_size = component.GetEnterRadius();
			exit_size = component.GetExitRadius();
		}
		isStart = QWorldLuaBridge.GetMapEntityData(component.entityId).entity_child_list.Count > 0;
	}

	public void OnEnable()
	{
		QWTriggerSystem.Instance?.Register(this);
	}

	public void OnDisable()
	{
		QWTriggerSystem.Instance?.UnRegister(this);
	}

	public void Tick()
	{
		if (base.gameObject.activeSelf)
		{
			CheckEnter();
			CheckExit();
		}
	}

	private void CheckEnter()
	{
		if (enter_size > 0)
		{
			QWCharacterAgent agent = QWorldScene.Scene.Agent;
			if (Vector3.Distance(base.transform.position, agent.Position) <= (float)enter_size)
			{
				OnEnter();
			}
		}
	}

	private void CheckExit()
	{
		if (!isStart && exit_size > 0)
		{
			QWCharacterAgent agent = QWorldScene.Scene.Agent;
			if (Vector3.Distance(base.transform.position, agent.Position) > (float)exit_size)
			{
				OnExit();
			}
		}
	}

	private void OnEnter()
	{
		if (uniqueId != 0)
		{
			LuaHelper.GetFunc(EnterFunc).Call(uniqueId);
		}
	}

	private void OnExit()
	{
		if (uniqueId != 0)
		{
			LuaHelper.GetFunc(ExitFunc).Call(uniqueId);
		}
	}
}
