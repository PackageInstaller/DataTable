using System;
using System.Collections.Generic;
using UnityEngine;

namespace Lumin.LoungeSystem;

[CreateAssetMenu(fileName = "RoomConfig", menuName = "BackHome/Room Config")]
public class RoomConfig : ScriptableObject
{
	[Serializable]
	public class RoomSetting
	{
		public int roomId;

		public string roomName;

		public LoungeDefine.RoomType roomType;

		public int baseComfortLevel;

		public int maxCapacity;

		public string prefabPath;

		public Sprite previewImage;

		public int unlockCost;

		public string description;
	}

	[Header("房间列表")]
	public List<RoomSetting> rooms = new List<RoomSetting>();

	public RoomSetting GetRoom(int roomId)
	{
		return rooms.Find((RoomSetting r) => r.roomId == roomId);
	}
}
