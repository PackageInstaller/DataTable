using System;
using UnityEngine;

[Serializable]
public class QWorldThingEntityData : QWorldEntityData
{
	private static string[] Scripts = new string[13]
	{
		"QWNpc", "QWFurniture", "QWMiniGameCell", "QWMiniGameCellUnit", "QWAirWall", "QWCommon", "QWZone", "QWSpriteRender", "QWCatchFlower", "QWStepFlower",
		"QWFlowerUnit", "QWPhotoGame", "QWNoCull"
	};

	public string script_name;

	public QworldEntitySpawnType spawn_type;

	public int spawn_task_id;

	public string defaultAnim;

	public bool defaultInteractive = true;

	public QWLocomotionCustomIdleState customIdle;

	public int configId;

	public int teleportId;

	public float distance = 2f;

	public string camera;

	public QworldEntityLookAtType lookAtType = QworldEntityLookAtType.NotLookAt;

	public int lookAtEntityId = -1;

	public Vector3 lookAtPoint;

	public int enterRadius;

	public int exitRadius;

	public bool isAreaNode;

	public int index;

	public bool isLast;

	public string startEffect = "";

	public string startLoopEffect = "";

	public string collectStartEffect = "";

	public string collectNormalEffect = "";

	public string collectDirEffect = "";

	public string failEffect = "";

	public string winEffect = "";

	public string spritePath = "";

	[SerializeReference]
	public object otherData;

	public bool IsNpc()
	{
		return script_name == "QWNpc";
	}

	private bool IsLookAtEntity()
	{
		if (script_name == "QWNpc")
		{
			return lookAtType == QworldEntityLookAtType.EntityId;
		}
		return false;
	}

	private bool IsLookAtPoint()
	{
		if (script_name == "QWNpc")
		{
			return lookAtType == QworldEntityLookAtType.Point;
		}
		return false;
	}

	private bool IsMiniGame()
	{
		if (!(script_name == "QWMiniGameCell"))
		{
			return script_name == "QWMiniGameCellUnit";
		}
		return true;
	}

	public bool IsSphereArea()
	{
		if (!(script_name == "QWCatchFlower") && !(script_name == "QWStepFlower"))
		{
			return script_name == "QWFlowerUnit";
		}
		return true;
	}

	public bool IsSpriteRender()
	{
		return script_name == "QWSpriteRender";
	}
}
