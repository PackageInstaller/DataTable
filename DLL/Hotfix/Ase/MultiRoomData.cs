using System.Collections.Generic;

namespace Ase;

public struct MultiRoomData
{
	public CopyData CopyData;

	public List<MatchRoomUserInfo> Gamers;

	public long RoomId;

	public MultiRoomData(MultiFightEnterMatchRoomResponse response, CopyData copyData)
	{
		CopyData = copyData;
		Gamers = new List<MatchRoomUserInfo>();
		for (int i = 0; i < response.MatchRoomInfo.Gamers.Count; i++)
		{
			Gamers.Add(new MatchRoomUserInfo(response.MatchRoomInfo.Gamers[i].CapFlag, response.MatchRoomInfo.Gamers[i].UserId, response.MatchRoomInfo.Gamers[i].SeatId, response.MatchRoomInfo.Gamers[i].State, response.MatchRoomInfo.Gamers[i].SelectModel, response.MatchRoomInfo.Gamers[i].UserBaseInfo.Icon, response.MatchRoomInfo.Gamers[i].UserBaseInfo.Name, response.MatchRoomInfo.Gamers[i].RoleInfo.RoleId, response.MatchRoomInfo.Gamers[i].RoleInfo.Star, response.MatchRoomInfo.Gamers[i].RoleInfo.Level, response.MatchRoomInfo.Gamers[i].RoleInfo.SkinId, response.MatchRoomInfo.Gamers[i].HeroCardFrame, response.MatchRoomInfo.Gamers[i].RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(response.MatchRoomInfo.Gamers[i].BattleProp)));
		}
		RoomId = response.MatchRoomInfo.RoomId;
	}

	public bool IsValid()
	{
		return RoomId > 0;
	}
}
