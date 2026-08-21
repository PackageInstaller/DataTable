require("game.data.CooperationDataTemplate")

local var_0_0 = singletonClass("CooperationData", BaseHeroViewData)
local var_0_1
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7
local var_0_8 = false
local var_0_9 = "0"

function var_0_0.Init(arg_1_0)
	var_0_1 = nil
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
	var_0_6 = {}
	var_0_7 = nil
	var_0_8 = false
end

function var_0_0.InitRoomData(arg_2_0, arg_2_1)
	if not var_0_1 then
		var_0_1 = CooperationRoomTemplate.New()
	end

	var_0_1:Init(arg_2_1)
end

function var_0_0.UpdateRoomData(arg_3_0, arg_3_1)
	if not var_0_1 then
		error("room info update error")

		return
	end

	var_0_1:Update(arg_3_1)
end

function var_0_0.ClearRoomData(arg_4_0)
	var_0_1 = nil
end

function var_0_0.GetRoomData(arg_5_0)
	return var_0_1
end

function var_0_0.CheckInRoom(arg_6_0)
	return var_0_1 ~= nil
end

function var_0_0.GetIsMatching(arg_7_0)
	return var_0_8
end

function var_0_0.SetIsMatching(arg_8_0, arg_8_1)
	var_0_8 = arg_8_1
end

function var_0_0.InitInviteInfo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.invite_list

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = CooperationInviteTemplate.New(iter_9_1)
		local var_9_2 = var_9_1.uid

		var_0_2[var_9_2] = var_9_1
	end

	local var_9_3 = arg_9_1.type_list

	for iter_9_2, iter_9_3 in ipairs(var_9_3) do
		table.insert(var_0_3, iter_9_3)
	end
end

function var_0_0.AddInviteInfo(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.invite
	local var_10_1 = CooperationInviteTemplate.New(var_10_0)
	local var_10_2 = var_10_1.uid
	local var_10_3 = var_10_1.invite_type

	var_0_2[var_10_2] = var_10_1

	if not table.indexof(var_0_3, var_10_3) then
		var_0_7 = {
			overdue_time = manager.time:GetServerTime() + 10,
			invite = var_10_1
		}

		manager.notify:Invoke(COOPERATION_NEW_INVITE)
	end
end

function var_0_0.GetNewInviteTip(arg_11_0)
	return var_0_7
end

function var_0_0.ClearNewInviteTip(arg_12_0)
	var_0_7 = nil
end

function var_0_0.GetAllInviteList(arg_13_0)
	return var_0_2
end

function var_0_0.GetInvite(arg_14_0, arg_14_1)
	return var_0_2[arg_14_1]
end

function var_0_0.RefuseInvite(arg_15_0, arg_15_1)
	if var_0_2[arg_15_1] then
		var_0_2[arg_15_1]:Refuse()
	end
end

function var_0_0.DelectInvite(arg_16_0, arg_16_1)
	var_0_2[arg_16_1] = nil
end

function var_0_0.ClearInvite(arg_17_0, arg_17_1)
	var_0_2 = {}
end

function var_0_0.GetInviteList(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(var_0_2) do
		local var_18_1 = iter_18_1.invite_type
		local var_18_2 = iter_18_1.activity_id

		if table.indexof(arg_18_1, var_18_1) then
			if var_18_2 and var_18_2 ~= 0 then
				if ActivityData:GetActivityIsOpen(var_18_2) then
					table.insert(var_18_0, iter_18_1)
				end
			else
				table.insert(var_18_0, iter_18_1)
			end
		end
	end

	return var_18_0
end

function var_0_0.CheckInviteEntryShow(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(var_0_2) do
		if not iter_19_1:IsOverdue() and not iter_19_1.refuse then
			return true
		end
	end

	return false
end

function var_0_0.SetInviteRestrict(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = table.indexof(var_0_3, arg_20_1)

	if arg_20_2 == 1 and not var_20_0 then
		table.insert(var_0_3, arg_20_1)
	elseif arg_20_2 == 2 and var_20_0 then
		table.remove(var_0_3, var_20_0)
	end
end

function var_0_0.GetInviteRestrict(arg_21_0, arg_21_1)
	return table.indexof(var_0_3, arg_21_1)
end

function var_0_0.GetRecentVisitList(arg_22_0)
	return var_0_4
end

function var_0_0.InitVisiteList(arg_23_0, arg_23_1)
	var_0_4 = {}

	local var_23_0 = arg_23_1.player_list

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_1 = CooperationRecentVisitTemplate.New(iter_23_1)

		table.insert(var_0_4, var_23_1)
	end
end

function var_0_0.GetIsMaster(arg_24_0)
	local var_24_0 = PlayerData:GetPlayerInfo().userID
	local var_24_1 = var_0_1 and var_0_1:GetRoomPlayerData(var_24_0)

	if var_24_1 then
		return var_24_1.is_master == 1
	else
		return false
	end
end

function var_0_0.SetInviteVisible(arg_25_0, arg_25_1, arg_25_2)
	var_0_5[arg_25_1] = arg_25_2

	saveData("CooperationVisible", tostring(arg_25_1), arg_25_2)
end

function var_0_0.GetInviteVisible(arg_26_0, arg_26_1)
	if not var_0_5[arg_26_1] then
		var_0_5[arg_26_1] = getData("CooperationVisible", tostring(arg_26_1))
	end

	if type(var_0_5[arg_26_1]) ~= "boolean" then
		var_0_5[arg_26_1] = true
	end

	return var_0_5[arg_26_1]
end

function var_0_0.SetHadInvited(arg_27_0, arg_27_1, arg_27_2)
	table.insert(var_0_6, arg_27_1)
end

function var_0_0.GetHadInvited(arg_28_0, arg_28_1, arg_28_2)
	return table.indexof(var_0_6, arg_28_1)
end

function var_0_0.ClearHadInvited(arg_29_0)
	var_0_6 = {}
end

function var_0_0.GetCooperationHero(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = CooperationTools.GetCooperationTeamHeroList(arg_30_1, arg_30_2, arg_30_3)
	local var_30_1 = getData("cooperation", "cooperation_hero_" .. arg_30_1)

	if var_30_1 and type(var_30_1) == "table" then
		local var_30_2 = var_30_1.hero_type
		local var_30_3 = 0
		local var_30_4 = 0

		if var_30_2 == 2 then
			var_30_4 = var_30_1.hero_id

			local var_30_5 = HeroStandardSystemCfg[var_30_4]

			var_30_3 = var_30_5 and var_30_5.hero_id
		else
			var_30_4 = 0
			var_30_3 = var_30_1.hero_id
		end

		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			if iter_30_1.trialID == var_30_4 and iter_30_1.id == var_30_3 then
				return var_30_1
			end
		end
	end

	if #var_30_0 == 0 then
		error("GetCooperationHero error")
	end

	local var_30_6 = var_30_0[1]

	if var_30_6.trialID ~= 0 then
		return {
			hero_type = 2,
			hero_id = var_30_6.trialID,
			owner_id = BattleTeamData.NO_OWNER
		}
	else
		return {
			hero_type = 1,
			hero_id = var_30_6.id,
			owner_id = BattleTeamData.NO_OWNER
		}
	end

	return var_30_0[1]
end

function var_0_0.SetCooperationHero(arg_31_0, arg_31_1)
	local var_31_0 = CooperationData:GetRoomData()

	if var_31_0 then
		local var_31_1 = var_31_0.type
		local var_31_2 = var_31_0.dest

		saveData("cooperation", "cooperation_hero_" .. var_31_1, arg_31_1)
	end
end

local var_0_10
local var_0_11 = {}

function var_0_0.GetCooperationHeroPower(arg_32_0, arg_32_1)
	local var_32_0 = CooperationData:GetRoomData()
	local var_32_1 = var_32_0 and var_32_0:GetRoomPlayerData(arg_32_1)

	if var_32_1 == nil then
		return 0
	end

	local var_32_2 = var_32_1.heroList
	local var_32_3 = var_32_2[1].id

	var_0_10 = var_32_1

	if var_32_2[1].trialID and var_32_2[1].trialID ~= 0 then
		return TempHeroData:GetBattlePower(var_32_2[1].trialID)
	else
		local var_32_4 = var_0_0:GetHeroData(var_32_3)
		local var_32_5 = var_32_4:GetEquipInfoList()
		local var_32_6 = var_32_4:GetServantInfo()
		local var_32_7 = GetHeroFinalAttr(var_32_4, var_32_6, var_32_5, nil, true)

		return calcBattlePower(var_32_4, var_32_6, var_32_5, nil, var_32_7)
	end
end

function var_0_0.GetHeroData(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	if arg_33_2 then
		var_33_0 = TempHeroData:GetHeroData(arg_33_1, arg_33_2)
	end

	if var_0_10 then
		local var_33_1 = var_0_10.heroList

		for iter_33_0, iter_33_1 in ipairs(var_33_1) do
			if arg_33_1 == iter_33_1.id then
				return iter_33_1
			end
		end
	end

	return var_33_0
end

function var_0_0.GetEquipInfoList(arg_34_0, arg_34_1, arg_34_2)
	return arg_34_0:GetHeroData(arg_34_1, arg_34_2):GetEquipInfoList()
end

function var_0_0.GetEquipDataList(arg_35_0, arg_35_1, arg_35_2)
	return arg_35_0:GetHeroData(arg_35_1, arg_35_2).equip_list
end

function var_0_0.GetHeroWeaponInfo(arg_36_0, arg_36_1, arg_36_2)
	return arg_36_0:GetHeroData(arg_36_1, arg_36_2):GetWeaponInfo()
end

function var_0_0.GetHeroServantInfo(arg_37_0, arg_37_1, arg_37_2)
	return arg_37_0:GetHeroData(arg_37_1, arg_37_2):GetServantInfo()
end

function var_0_0.GetHeroSkillInfoList(arg_38_0, arg_38_1, arg_38_2)
	return arg_38_0:GetHeroData(arg_38_1, arg_38_2):GetSkillInfoList()
end

function var_0_0.GetHeroTransitionInfoList(arg_39_0, arg_39_1, arg_39_2)
	return arg_39_0:GetHeroData(arg_39_1, arg_39_2):GetTransitionInfoList()
end

function var_0_0.GetHeroUsingSkinInfo(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:GetHeroData(arg_40_1, arg_40_2)
	local var_40_1 = var_40_0 and var_40_0.using_skin or 0

	if var_40_1 == 0 then
		var_40_1 = arg_40_1
	end

	return SkinCfg[var_40_1]
end

function var_0_0.GetHeroList(arg_41_0)
	if var_0_10 then
		for iter_41_0, iter_41_1 in ipairs(var_0_10.heroList) do
			var_0_11[iter_41_1.id] = iter_41_1
		end
	else
		var_0_11 = {}
	end

	return var_0_11
end

return var_0_0
