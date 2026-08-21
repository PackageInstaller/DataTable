local var_0_0 = class("MetaProgress", import("..BaseVO"))

var_0_0.STATE_LESS_PT = 1
var_0_0.STATE_LESS_STORY = 2
var_0_0.STATE_CAN_AWARD = 3
var_0_0.STATE_CAN_FINISH = 4
var_0_0.STATE_GOT_SHIP = 5

function var_0_0.bindConfigTable(arg_1_0)
	return pg.ship_strengthen_meta
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.metaType = arg_2_0:getConfig("type")
	arg_2_0.actID = arg_2_0:getConfig("activity_id")
	arg_2_0.metaShipVO = nil

	if arg_2_0:isPtType() then
		arg_2_0.unlockPTNum = arg_2_0:getConfig("synchronize")
		arg_2_0.unlockPTLevel = nil
		arg_2_0.metaPtData = MetaPTData.New({
			group_id = arg_2_0.id
		})

		local var_2_0

		for iter_2_0, iter_2_1 in ipairs(pg.world_joint_boss_template.all) do
			if pg.world_joint_boss_template[iter_2_1].meta_id == arg_2_0.id then
				var_2_0 = pg.world_joint_boss_template[iter_2_1]

				break
			end
		end

		if var_2_0 then
			arg_2_0.timeConfig = var_2_0.state
		end
	end

	return
end

function var_0_0.updateMetaPtData(arg_3_0, arg_3_1)
	if arg_3_0.metaPtData then
		arg_3_0.metaPtData:Update(arg_3_1)
	end

	return
end

function var_0_0.getSynRate(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = arg_4_0.metaPtData:GetResProgress()

	return var_4_0 / arg_4_0.unlockPTNum
end

function var_0_0.getStoryIndexList(arg_5_0)
	return arg_5_0:getConfig("unlock_story") or {
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

function var_0_0.getCurLevelStoryIndex(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = arg_6_0.metaPtData:GetLevelProgress()

	return arg_6_0:getStoryIndexList()[var_6_0]
end

function var_0_0.isFinishCurLevelStory(arg_7_0)
	local var_7_0 = arg_7_0:getCurLevelStoryIndex()
	local var_7_1 = false

	if var_7_0 == 0 then
		var_7_1 = true
	else
		local var_7_2 = pg.NewStoryMgr.GetInstance()

		if var_7_2:IsPlayed((var_7_2:StoryName2StoryId(var_7_0))) then
			var_7_1 = true
		end
	end

	return var_7_1
end

function var_0_0.getCurLevelStoryName(arg_8_0)
	return pg.memory_template[arg_8_0:getCurLevelStoryIndex()].title
end

function var_0_0.isCanGetAward(arg_9_0)
	local var_9_0 = arg_9_0.metaPtData:CanGetAward()
	local var_9_1 = arg_9_0:getCurLevelStoryIndex()
	local var_9_2 = false

	if var_9_1 == 0 then
		var_9_2 = true
	else
		local var_9_3 = pg.NewStoryMgr.GetInstance()
		local var_9_4 = var_9_3:GetStoryByName("index")[var_9_1]

		if var_9_3:IsPlayed(var_9_1) then
			var_9_2 = true
		end
	end

	return var_9_0 and var_9_2
end

function var_0_0.getMetaProgressPTState(arg_10_0)
	local var_10_0 = arg_10_0.metaPtData:CanGetAward()
	local var_10_1 = arg_10_0:isFinishCurLevelStory()
	local var_10_2 = arg_10_0:isUnlocked()

	if arg_10_0.metaPtData.level + 1 < arg_10_0.unlockPTLevel then
		if not var_10_0 then
			return var_0_0.STATE_LESS_PT
		elseif var_10_1 == false then
			return var_0_0.STATE_LESS_STORY
		elseif var_10_1 == true then
			return var_0_0.STATE_CAN_AWARD
		end
	elseif arg_10_0.metaPtData.level + 1 == arg_10_0.unlockPTLevel then
		if not var_10_0 then
			return var_0_0.STATE_LESS_PT
		elseif var_10_1 == false then
			return var_0_0.STATE_LESS_STORY
		elseif var_10_1 == true then
			return var_0_0.STATE_CAN_FINISH
		end
	elseif arg_10_0.metaPtData.level + 1 > arg_10_0.unlockPTLevel then
		return var_0_0.STATE_GOT_SHIP
	end

	return
end

function var_0_0.IsGotAllAwards(arg_11_0)
	return arg_11_0:isInAct() and arg_11_0:isInArchive() and not arg_11_0.metaPtData:CanGetNextAward()
end

function var_0_0.getRepairRateFromMetaCharacter(arg_12_0)
	assert(arg_12_0.metaShipVO, "metaShipVO is null")
	assert(arg_12_0.metaShipVO.metaCharacter, "metaCharacterVO is null")

	return (arg_12_0.metaShipVO.metaCharacter:getRepairRate())
end

function var_0_0.isPtType(arg_13_0)
	return arg_13_0.metaType == MetaCharacterConst.Meta_Type_Act_PT
end

function var_0_0.isPassType(arg_14_0)
	return arg_14_0.metaType == MetaCharacterConst.Meta_Type_Pass
end

function var_0_0.isBuildType(arg_15_0)
	return arg_15_0.metaType == MetaCharacterConst.Meta_Type_Build
end

function var_0_0.isInAct(arg_16_0)
	if arg_16_0:isPtType() then
		do return WorldBossConst.IsCurrBoss(arg_16_0.id) end

		goto label_16_0
	end

	::label_16_0::

	if not arg_16_0:isPassType() then
		if arg_16_0:isBuildType() then
			local var_16_0 = getProxy(ActivityProxy):getActivityById((arg_16_0:getConfig("activity_id")))

			return var_16_0 and not var_16_0:isEnd()
		end

		return
	end
end

function var_0_0.isInArchive(arg_17_0)
	return WorldBossConst.IsAchieveBoss(arg_17_0.id)
end

function var_0_0.isUnlocked(arg_18_0)
	return arg_18_0.metaShipVO ~= nil
end

function var_0_0.isShow(arg_19_0)
	if arg_19_0:isUnlocked() then
		return true
	elseif arg_19_0:isInArchive() then
		return true
	elseif arg_19_0:isInAct() then
		if arg_19_0:isPtType() and true then
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

function var_0_0.getMetaShipFromBayProxy(arg_20_0)
	local var_20_0 = getProxy(BayProxy):getMetaShipByGroupId(arg_20_0.configId)

	arg_20_0.metaShipVO = var_20_0

	return var_20_0
end

function var_0_0.getShip(arg_21_0)
	return arg_21_0.metaShipVO
end

function var_0_0.updateShip(arg_22_0, arg_22_1)
	assert(arg_22_1, "metaShipVO can not be null!")

	arg_22_0.metaShipVO = arg_22_1

	return
end

function var_0_0.setDataBeforeGet(arg_23_0)
	arg_23_0.metaShipVO = arg_23_0:getMetaShipFromBayProxy()

	if arg_23_0:isPtType() and arg_23_0.metaPtData and not arg_23_0.unlockPTLevel then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.metaPtData.targets) do
			if iter_23_1 == arg_23_0.unlockPTNum then
				arg_23_0.unlockPTLevel = iter_23_0

				break
			end
		end
	end

	if (arg_23_0:isPassType() or arg_23_0:isBuildType()) and not arg_23_0.timeConfig then
		local var_23_0 = getProxy(ActivityProxy):getActivityById((arg_23_0:getConfig("activity_id")))

		if var_23_0 then
			arg_23_0.timeConfig = {
				var_23_0:getConfig("time")[2],
				var_23_0:getConfig("time")[3]
			}
		end
	end

	return
end

function var_0_0.updateDataAfterAddShip(arg_24_0)
	arg_24_0.metaShipVO = arg_24_0:getMetaShipFromBayProxy()

	return
end

function var_0_0.addPT(arg_25_0, arg_25_1)
	if arg_25_0:isPtType() and arg_25_0.metaPtData then
		arg_25_0.metaPtData:addPT(arg_25_1)
	end

	return
end

function var_0_0.updatePTLevel(arg_26_0, arg_26_1)
	if arg_26_0:isPtType() and arg_26_0.metaPtData then
		arg_26_0.metaPtData:updateLevel(arg_26_1)
	end

	return
end

function var_0_0.getPaintPathAndName(arg_27_0)
	local var_27_0, var_27_1 = MetaCharacterConst.GetMetaCharacterPaintPath(arg_27_0.configId, (arg_27_0:isUnlocked()))

	return var_27_0, var_27_1
end

function var_0_0.getBannerPathAndName(arg_28_0)
	local var_28_0, var_28_1 = MetaCharacterConst.GetMetaCharacterBannerPath(arg_28_0.configId)

	return var_28_0, var_28_1
end

function var_0_0.getBGNamePathAndName(arg_29_0)
	local var_29_0, var_29_1 = MetaCharacterConst.GetMetaCharacterNamePath(arg_29_0.configId)

	return var_29_0, var_29_1
end

function var_0_0.getPtIconPath(arg_30_0)
	local var_30_0 = arg_30_0:isPtType() and arg_30_0.metaPtData

	assert(var_30_0)

	return Item.getConfigData(arg_30_0.metaPtData.resId).icon
end

return var_0_0
