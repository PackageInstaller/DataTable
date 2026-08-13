class = var_0_10000

local var_0_0 = "MetaProgress"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.STATE_LESS_PT = 1
var_0_1.STATE_LESS_STORY = 2
var_0_1.STATE_CAN_AWARD = 3
var_0_1.STATE_CAN_FINISH = 4
var_0_1.STATE_GOT_SHIP = 5

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_strengthen_meta
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.metaType = arg_2_0:getConfig("type")
	arg_2_0.actID = arg_2_0:getConfig("activity_id")
	arg_2_0.metaShipVO = nil

	if arg_2_0:isPtType() then
		arg_2_0.unlockPTNum = arg_2_0:getConfig("synchronize")
		arg_2_0.unlockPTLevel = nil
		MetaPTData = var_2
		arg_2_0.metaPtData = var_2.New({
			group_id = arg_2_0.id
		})

		local var_2_0

		ipairs = var_1_10003
		pg = var_5

		for iter_2_0, iter_2_1 in var_1_10003(var_5.world_joint_boss_template.all) do
			pg = var_1_10008

			if var_1_10008.world_joint_boss_template[iter_2_1].meta_id == arg_2_0.id then
				var_2_0 = var_1_10008

				break
			end
		end

		if var_2_0 then
			arg_2_0.timeConfig = var_2_0.state
		end
	end

	return
end

function var_0_1.updateMetaPtData(arg_3_0, arg_3_1)
	if arg_3_0.metaPtData then
		local var_3_0 = arg_3_0.metaPtData

		var_2.Update(var_3_0, arg_3_1)
	end

	return
end

function var_0_1.getSynRate(arg_4_0)
	local var_4_0 = arg_4_0.metaPtData
	local var_4_1, var_4_2, var_4_3 = var_1.GetResProgress(var_4_0)

	return var_4_1 / arg_4_0.unlockPTNum
end

function var_0_1.getStoryIndexList(arg_5_0)
	local var_5_0

	if not arg_5_0:getConfig("unlock_story") then
		var_5_0 = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	end

	return var_5_0
end

function var_0_1.getCurLevelStoryIndex(arg_6_0)
	local var_6_0 = arg_6_0.metaPtData
	local var_6_1, var_6_2, var_6_3 = var_1.GetLevelProgress(var_6_0)

	return arg_6_0:getStoryIndexList()[var_6_1]
end

function var_0_1.isFinishCurLevelStory(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getCurLevelStoryIndex(var_7_0)
	local var_7_2 = false

	if var_7_1 == 0 then
		var_7_2 = true
	else
		pg = var_7_0

		local var_7_3 = var_7_0.NewStoryMgr.GetInstance()
		local var_7_4 = var_3.StoryName2StoryId(var_7_3, var_7_1)

		if var_3:IsPlayed(var_7_4) then
			var_7_2 = true
		end
	end

	return var_7_2
end

function var_0_1.getCurLevelStoryName(arg_8_0)
	local var_8_0 = arg_8_0:getCurLevelStoryIndex()

	pg = var_1_10002

	return var_1_10002.memory_template[var_8_0].title
end

function var_0_1.isCanGetAward(arg_9_0)
	local var_9_0 = arg_9_0.metaPtData
	local var_9_1 = var_1.CanGetAward(var_9_0)
	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.getCurLevelStoryIndex(var_9_2)
	local var_9_4 = false

	if var_9_3 == 0 then
		var_9_4 = true
	else
		pg = var_9_2

		local var_9_5 = var_9_2.NewStoryMgr.GetInstance()
		local var_9_6 = var_4.GetStoryByName(var_9_5, "index")[var_9_3]

		if var_4:IsPlayed(var_9_3) then
			var_9_4 = true
		end
	end

	return var_9_1 and var_9_4
end

function var_0_1.getMetaProgressPTState(arg_10_0)
	local var_10_0 = arg_10_0.metaPtData
	local var_10_1 = var_1.CanGetAward(var_10_0)
	local var_10_2 = arg_10_0:isFinishCurLevelStory()
	local var_10_3 = arg_10_0:isUnlocked()

	if arg_10_0.metaPtData.level + 1 < arg_10_0.unlockPTLevel then
		if not var_10_1 then
			return var_0_1.STATE_LESS_PT
		elseif var_10_2 == false then
			return var_0_1.STATE_LESS_STORY
		elseif var_10_2 == true then
			return var_0_1.STATE_CAN_AWARD
		end
	elseif var_4 == arg_10_0.unlockPTLevel then
		if not var_10_1 then
			return var_0_1.STATE_LESS_PT
		elseif var_10_2 == false then
			return var_0_1.STATE_LESS_STORY
		elseif var_10_2 == true then
			return var_0_1.STATE_CAN_FINISH
		end
	elseif var_4 > arg_10_0.unlockPTLevel then
		return var_0_1.STATE_GOT_SHIP
	end

	return
end

function var_0_1.IsGotAllAwards(arg_11_0)
	local var_11_1

	if arg_11_0:isInAct() and arg_11_0:isInArchive() then
		local var_11_0 = arg_11_0.metaPtData

		var_11_1 = not var_1.CanGetNextAward(var_11_0)
	end

	return var_11_1
end

function var_0_1.getRepairRateFromMetaCharacter(arg_12_0)
	assert = var_1_10001

	var_1_10001(arg_12_0.metaShipVO, "metaShipVO is null")

	local var_12_0 = arg_12_0.metaShipVO.metaCharacter

	assert = var_1_10002

	var_1_10002(var_12_0, "metaCharacterVO is null")

	return (var_12_0:getRepairRate())
end

function var_0_1.isPtType(arg_13_0)
	local var_13_0 = arg_13_0.metaType

	MetaCharacterConst = var_1_10002

	return var_13_0 == var_1_10002.Meta_Type_Act_PT
end

function var_0_1.isPassType(arg_14_0)
	local var_14_0 = arg_14_0.metaType

	MetaCharacterConst = var_1_10002

	return var_14_0 == var_1_10002.Meta_Type_Pass
end

function var_0_1.isBuildType(arg_15_0)
	local var_15_0 = arg_15_0.metaType

	MetaCharacterConst = var_1_10002

	return var_15_0 == var_1_10002.Meta_Type_Build
end

function var_0_1.isInAct(arg_16_0)
	if arg_16_0:isPtType() then
		WorldBossConst = var_1

		return var_1.IsCurrBoss(arg_16_0.id)
	elseif arg_16_0:isPassType() or arg_16_0:isBuildType() then
		local var_16_0 = arg_16_0:getConfig("activity_id")

		getProxy = var_1_10002
		ActivityProxy = var_4

		local var_16_1 = var_1_10002(var_4)

		return var_2.getActivityById(var_16_1, var_16_0) and not var_2:isEnd()
	end

	return
end

function var_0_1.isInArchive(arg_17_0)
	WorldBossConst = var_1_10001

	return var_1_10001.IsAchieveBoss(arg_17_0.id)
end

function var_0_1.isUnlocked(arg_18_0)
	return arg_18_0.metaShipVO ~= nil
end

function var_0_1.isShow(arg_19_0)
	local var_19_0 = arg_19_0:isInAct()
	local var_19_1 = arg_19_0:isInArchive()
	local var_19_2 = arg_19_0:isUnlocked()
	local var_19_3 = true

	if var_19_2 then
		return true
	elseif var_19_1 then
		return true
	elseif var_19_0 then
		if arg_19_0:isPtType() and var_19_3 then
			return true
		elseif arg_19_0:isPassType() or arg_19_0:isBuildType() then
			return true
		else
			return false
		end
	else
		return false
	end

	return
end

function var_0_1.getMetaShipFromBayProxy(arg_20_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	arg_20_0.metaShipVO = var_1.getMetaShipByGroupId(var_20_0, arg_20_0.configId)

	return var_1
end

function var_0_1.getShip(arg_21_0)
	return arg_21_0.metaShipVO
end

function var_0_1.updateShip(arg_22_0, arg_22_1)
	assert = var_1_10002

	var_1_10002(arg_22_1, "metaShipVO can not be null!")

	arg_22_0.metaShipVO = arg_22_1

	return
end

function var_0_1.setDataBeforeGet(arg_23_0)
	arg_23_0.metaShipVO = arg_23_0:getMetaShipFromBayProxy()

	if arg_23_0:isPtType() and arg_23_0.metaPtData and not arg_23_0.unlockPTLevel then
		local var_23_0 = arg_23_0.metaPtData.targets

		ipairs = var_1_10002

		for iter_23_0, iter_23_1 in var_1_10002(var_23_0) do
			if iter_23_1 == arg_23_0.unlockPTNum then
				arg_23_0.unlockPTLevel = iter_23_0

				break
			end
		end
	end

	if (arg_23_0:isPassType() or arg_23_0:isBuildType()) and not arg_23_0.timeConfig then
		local var_23_1 = arg_23_0:getConfig("activity_id")

		getProxy = var_1_10002
		ActivityProxy = var_4

		local var_23_2 = var_1_10002(var_4)

		if var_2.getActivityById(var_23_2, var_23_1) then
			arg_23_0.timeConfig = {
				var_2:getConfig("time")[2],
				var_2:getConfig("time")[3]
			}
		end
	end

	return
end

function var_0_1.updateDataAfterAddShip(arg_24_0)
	arg_24_0.metaShipVO = arg_24_0:getMetaShipFromBayProxy()

	return
end

function var_0_1.addPT(arg_25_0, arg_25_1)
	if arg_25_0:isPtType() and arg_25_0.metaPtData then
		local var_25_0 = arg_25_0.metaPtData

		var_2.addPT(var_25_0, arg_25_1)
	end

	return
end

function var_0_1.updatePTLevel(arg_26_0, arg_26_1)
	if arg_26_0:isPtType() and arg_26_0.metaPtData then
		local var_26_0 = arg_26_0.metaPtData

		var_2.updateLevel(var_26_0, arg_26_1)
	end

	return
end

function var_0_1.getPaintPathAndName(arg_27_0)
	local var_27_0 = arg_27_0:isUnlocked()

	MetaCharacterConst = var_1_10002

	local var_27_1, var_27_2 = var_1_10002.GetMetaCharacterPaintPath(arg_27_0.configId, var_27_0)

	return var_27_1, var_27_2
end

function var_0_1.getBannerPathAndName(arg_28_0)
	MetaCharacterConst = var_1_10001

	local var_28_0, var_28_1 = var_1_10001.GetMetaCharacterBannerPath(arg_28_0.configId)

	return var_28_0, var_28_1
end

function var_0_1.getBGNamePathAndName(arg_29_0)
	MetaCharacterConst = var_1_10001

	local var_29_0, var_29_1 = var_1_10001.GetMetaCharacterNamePath(arg_29_0.configId)

	return var_29_0, var_29_1
end

function var_0_1.getPtIconPath(arg_30_0)
	assert = var_1_10001

	local var_30_0

	if arg_30_0:isPtType() then
		var_30_0 = arg_30_0.metaPtData
	end

	var_1_10001(var_30_0)

	Item = var_1_10001

	return var_1_10001.getConfigData(arg_30_0.metaPtData.resId).icon
end

return var_0_1
