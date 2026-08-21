#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class BFBEService : IBFBEService
{
	private Dictionary<int, RoleDecorateData> roleCurDecorates = new Dictionary<int, RoleDecorateData>();

	private List<int> _roundEmojis = new List<int>();

	private List<int> _fightEventEmojis = new List<int>();

	private List<int> _curHeroCardFrames = new List<int>();

	private int _curChatBox;

	private int _indicator;

	private IRoleService roleService;

	private List<int> expired = new List<int>();

	private List<int> lockedSkillSkinIds = new List<int>();

	public async UniTask<bool> RequestUseDatas()
	{
		_ = 6;
		try
		{
			roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			await GetDecorationSettingRst();
			await GetBattleSetEmojiSettingRst();
			roleCurDecorates.Clear();
			await AddRoleUseBattleEmojiDataToDic();
			await AddRoleUseChatBubbleDataToDic();
			await AddRoleUseCardFrameDataToDic();
			await AddRoleUseIndicatorDataToDic();
			await GetHeroSkillCamreaSkin();
			AddRoleUseItemExpireTimeChecker();
			return true;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message);
			return false;
		}
	}

	private async UniTask AddRoleUseBattleEmojiDataToDic()
	{
		if (roleService == null)
		{
			return;
		}
		List<RoleDecorateData> list = await roleService.GetIconOrTitleList(RoleDecorateEnum.BattleEmote);
		if (list == null)
		{
			return;
		}
		foreach (RoleDecorateData item in list)
		{
			if (item.expireTime > 0)
			{
				roleCurDecorates[item.id] = item;
			}
		}
	}

	private RoleDecorateData CheckResultIncludeEmote(int id, List<RoleDecorateData> list)
	{
		if (id == 0)
		{
			return null;
		}
		DRBattleEmote dataRow = GameEntry.DataTable.GetDataRow<DRBattleEmote>(id);
		foreach (RoleDecorateData item in list)
		{
			if (item.id == dataRow.GroupId)
			{
				return item;
			}
		}
		return null;
	}

	private async UniTask AddRoleUseChatBubbleDataToDic()
	{
		if (roleService == null)
		{
			return;
		}
		List<RoleDecorateData> list = await roleService.GetIconOrTitleList(RoleDecorateEnum.ChatBubble);
		if (list == null)
		{
			return;
		}
		foreach (RoleDecorateData item in list)
		{
			if (item.expireTime > 0)
			{
				roleCurDecorates[item.id] = item;
			}
		}
	}

	private async UniTask AddRoleUseCardFrameDataToDic()
	{
		if (roleService == null)
		{
			return;
		}
		List<RoleDecorateData> list = await roleService.GetIconOrTitleList(RoleDecorateEnum.CardFrame);
		if (list == null)
		{
			return;
		}
		foreach (RoleDecorateData item in list)
		{
			if (item.expireTime > 0)
			{
				roleCurDecorates[item.id] = item;
			}
		}
	}

	private async UniTask AddRoleUseIndicatorDataToDic()
	{
		if (roleService == null)
		{
			return;
		}
		List<RoleDecorateData> list = await roleService.GetIconOrTitleList(RoleDecorateEnum.Indicator);
		if (list == null)
		{
			return;
		}
		foreach (RoleDecorateData item in list)
		{
			if (item.expireTime > 0)
			{
				roleCurDecorates[item.id] = item;
			}
		}
	}

	private void AddRoleUseItemExpireTimeChecker()
	{
		foreach (KeyValuePair<int, RoleDecorateData> roleCurDecorate in roleCurDecorates)
		{
			if (roleCurDecorate.Value.expireTime > 0)
			{
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(RoleDecorateItemExpireTimeChecker);
				break;
			}
		}
	}

	private void RoleDecorateItemExpireTimeChecker(long curServerTime)
	{
		expired.Clear();
		foreach (KeyValuePair<int, RoleDecorateData> roleCurDecorate in roleCurDecorates)
		{
			if (roleCurDecorate.Value.expireTime != 0L && roleCurDecorate.Value.expireTime <= curServerTime)
			{
				expired.Add(roleCurDecorate.Key);
				if (roleCurDecorate.Value.DecorateType == RoleDecorateEnum.BattleEmote)
				{
					SendUnLoadBattleEmote(roleCurDecorate.Value);
				}
				else if (roleCurDecorate.Value.DecorateType == RoleDecorateEnum.ChatBubble)
				{
					SendUnLoadChatBubble(roleCurDecorate.Value);
				}
				else if (roleCurDecorate.Value.DecorateType == RoleDecorateEnum.CardFrame)
				{
					SendUnLoadCardFrame(roleCurDecorate.Value);
				}
				else if (roleCurDecorate.Value.DecorateType == RoleDecorateEnum.Indicator)
				{
					SendUnLoadIndicator(roleCurDecorate.Value);
				}
			}
		}
		if (expired.Count > 0)
		{
			foreach (int item in expired)
			{
				roleCurDecorates.Remove(item);
			}
		}
		if (roleCurDecorates.Count == 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveNormalSecondUpdateAction(RoleDecorateItemExpireTimeChecker);
		}
	}

	private async void SendUnLoadBattleEmote(RoleDecorateData unLoadData)
	{
		DRBattleEmote[] dr = GameEntry.DataTable.GetDataRows((DRBattleEmote x) => x.GroupId == unLoadData.id);
		if (_roundEmojis.Count > 0)
		{
			int i;
			for (i = 0; i < dr.Length; i++)
			{
				int num = _roundEmojis.FindIndex((int p) => p == dr[i].Id);
				if (num != -1)
				{
					_roundEmojis[num] = 0;
				}
			}
			await SetBattleSetEmojiSetting(_roundEmojis, _fightEventEmojis);
		}
		if (_fightEventEmojis.Count <= 0)
		{
			return;
		}
		int i2;
		for (i2 = 0; i2 < dr.Length; i2++)
		{
			int num2 = _fightEventEmojis.FindIndex((int p) => p == dr[i2].Id);
			if (num2 != -1)
			{
				_fightEventEmojis[num2] = 0;
			}
		}
		await SetBattleSetEmojiSetting(_roundEmojis, _fightEventEmojis);
	}

	private async void SendUnLoadChatBubble(RoleDecorateData unLoadData)
	{
		if (unLoadData.id != 0)
		{
			_curChatBox = 0;
			await SetChatBubbleSetting(_curChatBox);
		}
	}

	private async void SendUnLoadCardFrame(RoleDecorateData unLoadData)
	{
		if (_curHeroCardFrames.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _curHeroCardFrames.Count; i++)
		{
			if (_curHeroCardFrames[i] == unLoadData.id)
			{
				_curHeroCardFrames[i] = 0;
			}
		}
		await SetCardFrameSetting(_curHeroCardFrames);
	}

	private async void SendUnLoadIndicator(RoleDecorateData unLoadData)
	{
		if (unLoadData.id != 0)
		{
			_indicator = 0;
			await SetIndicatorSetting(_indicator);
		}
	}

	public async UniTask<bool> SetBattleSetEmojiSetting(List<int> RoundEmojis, List<int> FightEventEmojis)
	{
		SetBattleSetEmojiSettingRequest request = SetBattleSetEmojiSettingRequest.Create();
		request.RoundEmojis = RoundEmojis;
		request.FightEventEmojis = FightEventEmojis;
		SetBattleSetEmojiSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetBattleSetEmojiSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置战斗表情") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置战斗表情失败"))
			{
				_roundEmojis = RoundEmojis;
				_fightEventEmojis = FightEventEmojis;
				await AddRoleUseBattleEmojiDataToDic();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public (List<int>, List<int>) GetBattleSetEmojiSetting()
	{
		return (_roundEmojis, _fightEventEmojis);
	}

	public async UniTask<bool> SetCardFrameSetting(List<int> cardFrames)
	{
		SetUserDecorationSettingRequest request = SetUserDecorationSettingRequest.Create();
		request.Type = 9;
		request.CardFrames = cardFrames;
		SetUserDecorationSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetUserDecorationSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置角色框") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "角色框设置失败"))
			{
				_curHeroCardFrames = cardFrames;
				AddRoleUseCardFrameDataToDic();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SetChatBubbleSetting(int bubble)
	{
		SetUserDecorationSettingRequest request = SetUserDecorationSettingRequest.Create();
		request.Type = 8;
		request.Bubble = bubble;
		SetUserDecorationSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetUserDecorationSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置聊天气泡") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "聊天气泡设置失败"))
			{
				_curChatBox = bubble;
				AddRoleUseChatBubbleDataToDic();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<(List<int>, List<int>)> GetBattleSetEmojiSettingRst()
	{
		GetBattleSetEmojiSettingRequest request = GetBattleSetEmojiSettingRequest.Create();
		GetBattleSetEmojiSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetBattleSetEmojiSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取战斗表情") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取战斗表情失败"))
			{
				_roundEmojis = response.RoundEmojis;
				_fightEventEmojis = response.FightEventEmojis;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return (_roundEmojis, _fightEventEmojis);
	}

	public List<int> GetCardFrameSet()
	{
		return _curHeroCardFrames;
	}

	public int GetChatBubble()
	{
		return _curChatBox;
	}

	public async UniTask<(List<int>, int, int)> GetDecorationSettingRst()
	{
		GetUserDecorationSettingRequest request = GetUserDecorationSettingRequest.Create();
		GetUserDecorationSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUserDecorationSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取角色框和气泡以及指示器") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取角色框和气泡以及指示器失败"))
			{
				_curHeroCardFrames = response.HeroCardFrames;
				_curChatBox = response.Bubble;
				_indicator = response.Indicator;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return (_curHeroCardFrames, _curChatBox, _indicator);
	}

	public async UniTask<bool> SetIndicatorSetting(int indicator)
	{
		SetUserDecorationSettingRequest request = SetUserDecorationSettingRequest.Create();
		request.Type = 11;
		request.Indicator = indicator;
		SetUserDecorationSettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetUserDecorationSettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置指示器") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置指示器失败"))
			{
				_indicator = indicator;
				AddRoleUseIndicatorDataToDic();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public int GetIndicatorSetting()
	{
		return _indicator;
	}

	public async UniTask<bool> RequestDatas()
	{
		_ = 3;
		try
		{
			IRoleService roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (roleService == null)
			{
				return false;
			}
			List<RoleDecorateData> result1 = await roleService.GetIconOrTitleList(RoleDecorateEnum.BattleEmote);
			List<RoleDecorateData> result2 = await roleService.GetIconOrTitleList(RoleDecorateEnum.ChatBubble);
			List<RoleDecorateData> result3 = await roleService.GetIconOrTitleList(RoleDecorateEnum.CardFrame);
			List<RoleDecorateData> list = await roleService.GetIconOrTitleList(RoleDecorateEnum.Indicator);
			foreach (RoleDecorateData item in result1)
			{
				if (item.id == 97002)
				{
					result1.Remove(item);
					break;
				}
			}
			roleService?.GetRoleData()?.SetItemList(RoleDecorateEnum.BattleEmote, result1);
			roleService?.GetRoleData()?.SetItemList(RoleDecorateEnum.ChatBubble, result2);
			roleService?.GetRoleData()?.SetItemList(RoleDecorateEnum.CardFrame, result3);
			roleService?.GetRoleData()?.SetItemList(RoleDecorateEnum.Indicator, list);
			return true;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message);
			return false;
		}
	}

	public async UniTask<bool> GetHeroSkillCamreaSkin(RoleDecorateEnum type = RoleDecorateEnum.HeroSkillCameraSkin)
	{
		lockedSkillSkinIds.Clear();
		GetIconOrTitleListRequest rst = GetIconOrTitleListRequest.Create();
		rst.Type = (int)type;
		GetIconOrTitleListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetIconOrTitleListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取所有已解锁技能镜头皮肤数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取所有已解锁技能镜头皮肤数据失败"))
			{
				foreach (PbExtraItemInfo extraItemInfo in response.ExtraItemInfos)
				{
					lockedSkillSkinIds.Add(extraItemInfo.Id);
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SetOrChangeSkillSkinInfoRst(int heroId, int skillSkinId)
	{
		C2S_SetOrChangeSkillSkinInfo rst = C2S_SetOrChangeSkillSkinInfo.Create();
		rst.HeroId = heroId;
		rst.SkillSkinId = skillSkinId;
		S2C_SetOrChangeSkillSkinInfo response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_SetOrChangeSkillSkinInfo>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "更换技能镜头皮肤") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "更换技能镜头皮肤失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> UnlockSkillSkinInfoRst(int skillSkinId)
	{
		C2S_UnlockSkillSkinWithItem rst = C2S_UnlockSkillSkinWithItem.Create();
		rst.SkillSkinId = skillSkinId;
		S2C_UnlockSkillSkinWithItem response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_UnlockSkillSkinWithItem>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "解锁技能镜头皮肤") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "解锁技能镜头皮肤失败"))
			{
				lockedSkillSkinIds.Add(skillSkinId);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public bool HeroSkillCameraSkinIsLock(int skillSkinId)
	{
		if (lockedSkillSkinIds.Contains(skillSkinId))
		{
			return true;
		}
		return false;
	}
}
