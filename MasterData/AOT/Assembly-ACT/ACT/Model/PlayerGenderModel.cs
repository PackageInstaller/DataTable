using System;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using Fundamental;
using Pb;

namespace ACT.Model;

public class PlayerGenderModel : Model<PlayerGenderModel>
{
	private int ChangeGenderTS;

	protected override void Init()
	{
	}

	public void ReviseGenderTs(int time)
	{
		ChangeGenderTS = time;
	}

	protected override void UnInit()
	{
	}

	public void SendReviseGender(int gender, Action<ChangeGenderAck> callback = null)
	{
		G.service.SendChangeGender(gender, (ChangeGenderAck ChangeGenderAck) =>
		{
			G.detailUserInfo.Brief.Gender = gender;
			G.localPlayer.Profile.EscInfo.CurAvatarId = ChangeGenderAck.CurAvatarId;
			G.localPlayer.Profile.EscInfo.AvatarIds.CopyValueFrom(ChangeGenderAck.AvatarIds);
			AccountDecorationChangedEvt evt = Singleton<EventManager>.instance.GetEvt<AccountDecorationChangedEvt>();
			evt.ChangeType = AccountDecorationChangeType.Avatar;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ChangeAvatar, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			SexChange evt2 = Singleton<EventManager>.instance.GetEvt<SexChange>();
			evt2.Sex = (Sex)G.detailUserInfo.Brief.Gender;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSexChange, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			ReviseGenderTs(ChangeGenderAck.ChangeTS);
			callback?.Invoke(ChangeGenderAck);
		});
	}

	public bool IsCanChangeGender()
	{
		int genderChangeCooldown = RuntimeConfigs.data.game.genderChangeCooldown;
		if (ChangeGenderTS <= 0)
		{
			return true;
		}
		return TimeManager.ServerTime.NowTimestampSecond >= ChangeGenderTS + genderChangeCooldown;
	}
}
