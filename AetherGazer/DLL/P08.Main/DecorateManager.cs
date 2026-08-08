using System.Collections.Generic;
using UnityEngine;

public class DecorateManager : MonoBehaviour
{
	public bool showDecorateID = true;

	public bool showRoomID;

	private Dictionary<int, DecorateShow> _decorates = new Dictionary<int, DecorateShow>();

	private Dictionary<int, RoomShow> _rooms = new Dictionary<int, RoomShow>();

	public Dictionary<int, DecorateShow> decorates => _decorates;

	public Dictionary<int, RoomShow> rooms => _rooms;

	public void Init()
	{
		DecorateShow[] componentsInChildren = base.gameObject.GetComponentsInChildren<DecorateShow>();
		foreach (DecorateShow decorateShow in componentsInChildren)
		{
			_decorates[decorateShow.index] = decorateShow;
		}
		RoomShow[] componentsInChildren2 = base.gameObject.GetComponentsInChildren<RoomShow>();
		foreach (RoomShow roomShow in componentsInChildren2)
		{
			_rooms[roomShow.index] = roomShow;
		}
	}

	public DecorateShow AddDecorate()
	{
		int index = CalDecorateIndex();
		DecorateShow decorateShow = CreateDecorate(index);
		_decorates[decorateShow.index] = decorateShow;
		return decorateShow;
	}

	public RoomShow AddRoom()
	{
		int index = CalRoomIndex();
		RoomShow roomShow = CreateRoom(index);
		_rooms[roomShow.index] = roomShow;
		return roomShow;
	}

	private int CalDecorateIndex()
	{
		DecorateShow[] componentsInChildren = base.gameObject.GetComponentsInChildren<DecorateShow>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			DecorateShow value = null;
			if (!_decorates.TryGetValue(i + 1, out value) || null == value)
			{
				if (null == value)
				{
					_decorates.Remove(i + 1);
				}
				return i + 1;
			}
		}
		return componentsInChildren.Length + 1;
	}

	private int CalRoomIndex()
	{
		RoomShow[] componentsInChildren = base.gameObject.GetComponentsInChildren<RoomShow>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			RoomShow value = null;
			if (!_rooms.TryGetValue(i + 1, out value) || null == value)
			{
				if (null == value)
				{
					_decorates.Remove(i + 1);
				}
				return i + 1;
			}
		}
		return componentsInChildren.Length + 1;
	}

	private DecorateShow CreateDecorate(int index)
	{
		GameObject obj = new GameObject("Decorate_" + index);
		DecorateShow decorateShow = obj.AddComponent<DecorateShow>();
		decorateShow.index = index;
		obj.transform.SetParent(base.transform);
		return decorateShow;
	}

	private RoomShow CreateRoom(int index)
	{
		GameObject obj = new GameObject("Room_" + index);
		RoomShow roomShow = obj.AddComponent<RoomShow>();
		roomShow.index = index;
		obj.transform.SetParent(base.transform);
		return roomShow;
	}
}
