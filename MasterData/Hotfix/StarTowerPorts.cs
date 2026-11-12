using System.Collections.Generic;
using UnityEngine;

public class StarTowerPorts : LogicMonoComponent
{
	[SerializeField]
	[ReadOnly]
	protected StarTowerPort[] ports;

	public StarTowerPort[] Ports => ports;

	public void InitOutPorts(int nextRoomType, bool isFinalLevel = false, bool sceneDoMir = false)
	{
		StarTowerPort[] array = ports;
		if (array == null || array.Length != 4)
		{
			Debug.LogError("出入口组节点为空或数量不为4!");
			return;
		}
		int num = 0;
		if (ports[2].gameObject.activeSelf)
		{
			num++;
		}
		if (ports[3].gameObject.activeSelf)
		{
			num++;
		}
		switch (num)
		{
		case 0:
			Debug.LogError("固定rog:预制体中打开的出口数量为0!");
			return;
		case 1:
			if (ports[2].gameObject.activeSelf)
			{
				ports[2].OutPort_InitInfo(nextRoomType, isFinalLevel, sceneDoMir);
				ports[2].Select();
			}
			else
			{
				ports[3].OutPort_InitInfo(nextRoomType, isFinalLevel, sceneDoMir);
				ports[3].Select();
			}
			return;
		}
		int num2 = 2 + MonoSingleton<GameController>.Instance.Random_Roguelike(0, 2);
		ports[num2].OutPort_InitInfo(nextRoomType, isFinalLevel, sceneDoMir);
		ports[num2].Select();
		int num3 = 2;
		if (num2 == 2)
		{
			num3 = 3;
		}
		ports[num3].OutPort_Close();
	}

	public StarTowerPort InitSpawnPorts(HotfixEnum.fixedRoguelikePortDir direction)
	{
		StarTowerPort[] array = ports;
		if (array == null || array.Length != 4)
		{
			Debug.LogError("出入口组节点为空或数量不为4!");
			return null;
		}
		int num = 0;
		if (ports[0].gameObject.activeSelf)
		{
			num++;
		}
		if (ports[1].gameObject.activeSelf)
		{
			num++;
		}
		switch (num)
		{
		case 1:
			if (ports[0].gameObject.activeSelf)
			{
				return ports[0];
			}
			if (ports[1].gameObject.activeSelf)
			{
				return ports[1];
			}
			return null;
		case 0:
			Debug.LogWarning("没有开启的入口!");
			break;
		}
		if (MonoSingleton<GameController>.Instance.Random_Roguelike(0, 2) == 0)
		{
			ports[1].gameObject.SetActive(value: false);
			return ports[0];
		}
		ports[0].gameObject.SetActive(value: false);
		return ports[1];
	}

	public void ActiveTeleporter(bool isOpen)
	{
		if (ports == null || ports.Length == 0)
		{
			Debug.LogError("出入口数量为0");
			return;
		}
		StarTowerPort starTowerPort = ports[2];
		StarTowerPort starTowerPort2 = ports[3];
		if (isOpen)
		{
			if (starTowerPort.isSelected && starTowerPort.gameObject.activeSelf)
			{
				starTowerPort.SetActive_Teleporter(active: true);
			}
			if (starTowerPort2.isSelected && starTowerPort2.gameObject.activeSelf)
			{
				starTowerPort2.SetActive_Teleporter(active: true);
			}
		}
		else
		{
			if (starTowerPort.isSelected && starTowerPort.gameObject.activeSelf)
			{
				starTowerPort.SetActive_Teleporter(active: false);
			}
			if (starTowerPort2.isSelected && starTowerPort2.gameObject.activeSelf)
			{
				starTowerPort2.SetActive_Teleporter(active: false);
			}
		}
	}

	public List<AdventureLevelTeleporter> GetTeleporters()
	{
		if (ports == null || ports.Length == 0)
		{
			Debug.LogError("出入口数量为0");
			return null;
		}
		List<AdventureLevelTeleporter> list = new List<AdventureLevelTeleporter>();
		for (int i = 0; i < ports.Length; i++)
		{
			AdventureLevelTeleporter teleporter = ports[i].GetTeleporter();
			if (!(null == teleporter))
			{
				list.Add(teleporter);
			}
		}
		return list;
	}
}
