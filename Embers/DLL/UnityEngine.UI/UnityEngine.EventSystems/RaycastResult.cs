namespace UnityEngine.EventSystems;

public struct RaycastResult
{
	private GameObject m_GameObject;

	public BaseRaycaster module;

	public float distance;

	public float index;

	public int depth;

	public int sortingGroupID;

	public int sortingGroupOrder;

	public int sortingLayer;

	public int sortingOrder;

	public Vector3 worldPosition;

	public Vector3 worldNormal;

	public Vector2 screenPosition;

	public int displayIndex;

	public GameObject gameObject
	{
		get
		{
			return m_GameObject;
		}
		set
		{
			m_GameObject = value;
		}
	}

	public bool isValid
	{
		get
		{
			if (module != null)
			{
				return gameObject != null;
			}
			return false;
		}
	}

	public void Clear()
	{
		gameObject = null;
		module = null;
		distance = 0f;
		index = 0f;
		depth = 0;
		sortingLayer = 0;
		sortingOrder = 0;
		worldNormal = Vector3.up;
		worldPosition = Vector3.zero;
		screenPosition = Vector3.zero;
	}

	public override string ToString()
	{
		if (!isValid)
		{
			return "";
		}
		string[] obj = new string[24]
		{
			"Name: ",
			gameObject?.ToString(),
			"\nmodule: ",
			module?.ToString(),
			"\ndistance: ",
			distance.ToString(),
			"\nindex: ",
			index.ToString(),
			"\ndepth: ",
			depth.ToString(),
			"\nworldNormal: ",
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null
		};
		Vector3 vector = worldNormal;
		obj[11] = vector.ToString();
		obj[12] = "\nworldPosition: ";
		vector = worldPosition;
		obj[13] = vector.ToString();
		obj[14] = "\nscreenPosition: ";
		Vector2 vector2 = screenPosition;
		obj[15] = vector2.ToString();
		obj[16] = "\nmodule.sortOrderPriority: ";
		obj[17] = module.sortOrderPriority.ToString();
		obj[18] = "\nmodule.renderOrderPriority: ";
		obj[19] = module.renderOrderPriority.ToString();
		obj[20] = "\nsortingLayer: ";
		obj[21] = sortingLayer.ToString();
		obj[22] = "\nsortingOrder: ";
		obj[23] = sortingOrder.ToString();
		return string.Concat(obj);
	}
}
