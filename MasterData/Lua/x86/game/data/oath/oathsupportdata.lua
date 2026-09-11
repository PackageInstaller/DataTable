local var_0_0 = singletonClass("OathSupportData")

function var_0_0.Init(arg_1_0)
	arg_1_0.oathRegeditSaveData = nil
end

function var_0_0:GetRegeditData(arg_2_1)
	self.oathRegeditSaveData = self.oathRegeditSaveData or {}
	self.oathRegeditSaveData[arg_2_1] = self.oathRegeditSaveData[arg_2_1] or self:GetRegeditSaveData(arg_2_1)

	return self.oathRegeditSaveData[arg_2_1]
end

function var_0_0:ClearAllData()
	for iter_3_0, iter_3_1 in pairs(WeddingCfg.all) do
		self:SaveRegeditData(iter_3_1, self:GetDafultData())
	end

	self:SaveRegeditData(OathConst.OATH_OPEN_TAG_ID, self:GetDafultData())
	saveData("Oath", "LastPopTimes", 0)
end

function var_0_0:SaveRegeditData(arg_4_1, arg_4_2)
	self.oathRegeditSaveData[arg_4_1] = arg_4_2

	saveData("Oath", "OathRegeditData_" .. arg_4_1, arg_4_2)
end

function var_0_0:GetRegeditSaveData(arg_5_1)
	return getData("Oath", "OathRegeditData_" .. arg_5_1) or self:GetDafultData()
end

function var_0_0.GetDafultData(arg_6_0)
	return {
		readVoiceIndex = 0,
		readPlotIndex = 0,
		readStoryIndex = 0,
		readArchieveIndex = 0,
		isLoginPop = false,
		isNewHeroNotice = false
	}
end

function var_0_0.UpdateOathCanCompleteNotice(arg_7_0, arg_7_1)
	if not OathTools.GetIsOpenOath() then
		return
	end

	local var_7_0

	if not OathTools.GetIsCanOathHero(arg_7_1) then
		do return end

		var_7_0 = true
	end

	if OathTools.IsOath(arg_7_1) then
		var_7_0 = false
	else
		for iter_7_0, iter_7_1 in ipairs(WeddingCfg[arg_7_1].condition) do
			if not IsConditionAchieved(iter_7_1) then
				var_7_0 = false
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.OATH_HERO_CAN_COMPLETE .. arg_7_1, var_7_0 and 1 or 0)
end

function var_0_0:UpdateOathNewHeroNotice(arg_8_1)
	if not OathTools.GetIsOpenOath() then
		return
	end

	local var_8_0 = self:GetRegeditData(arg_8_1)

	if HeroData:GetHeroData(arg_8_1).unlock == 0 or OathTools.IsOath(arg_8_1) then
		manager.redPoint:setTip(RedPointConst.OATH_NEW_HERO .. arg_8_1, 0)
	else
		arg_8_1 = tostring(arg_8_1)

		manager.redPoint:setTip(RedPointConst.OATH_NEW_HERO .. arg_8_1, (var_8_0.isNewHeroNotice or false) and 0 or 1, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0:SetOathNewHeroNoticeShowed(arg_9_1)
	if not OathTools.GetIsOpenOath() then
		return
	end

	if HeroData:GetHeroData(arg_9_1).unlock == 0 then
		return
	end

	local var_9_0 = self:GetRegeditData(arg_9_1)

	if var_9_0.isNewHeroNotice then
		return
	end

	var_9_0.isNewHeroNotice = true

	self:SaveRegeditData(arg_9_1, var_9_0)
	manager.redPoint:setTip(RedPointConst.OATH_NEW_HERO .. arg_9_1, 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.UpdateOathTaskRedPoint(arg_10_0, arg_10_1)
	if not OathTools.GetIsOpenOath() then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		manager.redPoint:setTip(RedPointConst.OATH_TASK_FINISH .. iter_10_0, iter_10_1 and 1 or 0)
	end
end

function var_0_0.GetOathTaskRedInitList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(WeddingCfg.all) do
		var_11_0[iter_11_1] = false
	end

	return var_11_0
end

function var_0_0.UpdateOathTaskRedData(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = OathAssignmentData:GetOathAssignmentByID(arg_12_1)

	if var_12_0 and var_12_0.status == 0 and var_12_0.progress >= WeddingAssignmentCfg[arg_12_1].need and OathCollectionContentData:GetOathLevel(WeddingAssignmentCfg[arg_12_1].hero_id) >= WeddingAssignmentCfg[arg_12_1].wedding_level then
		arg_12_2[WeddingAssignmentCfg[arg_12_1].hero_id] = true
	end

	return arg_12_2
end

function var_0_0:UpdateOathContentRed(arg_13_1, arg_13_2)
	if not OathTools.GetIsOpenOath() then
		return
	end

	local var_13_0, var_13_1 = self:GetOathContentIndexData(arg_13_1, arg_13_2)

	manager.redPoint:setTip(OathTools.GetOathContentRedKey(arg_13_2, arg_13_1), var_13_0 < var_13_1 and 1 or 0)
end

function var_0_0:SetReadOathContent(arg_14_1, arg_14_2)
	if not OathTools.GetIsOpenOath() then
		return
	end

	local var_14_0, var_14_1 = self:GetOathContentIndexData(arg_14_1, arg_14_2)

	if var_14_0 < var_14_1 then
		local var_14_2 = self:GetRegeditData(arg_14_1)

		if arg_14_2 == OathConst.OATH_CONTENT_TAG_KEY.story then
			var_14_2.readStoryIndex = var_14_1
		elseif arg_14_2 == OathConst.OATH_CONTENT_TAG_KEY.archieve then
			var_14_2.readArchieveIndex = var_14_1
		elseif arg_14_2 == OathConst.OATH_CONTENT_TAG_KEY.plot then
			var_14_2.readPlotIndex = var_14_1
		elseif arg_14_2 == OathConst.OATH_CONTENT_TAG_KEY.voice then
			var_14_2.readVoiceIndex = var_14_1
		end

		self:SaveRegeditData(arg_14_1, var_14_2)
		manager.redPoint:setTip(OathTools.GetOathContentRedKey(arg_14_2, arg_14_1), 0)
	end
end

function var_0_0:GetOathContentIndexData(arg_15_1, arg_15_2)
	local var_15_0 = self:GetRegeditData(arg_15_1)
	local var_15_1 = -1
	local var_15_2 = -1

	if arg_15_2 == OathConst.OATH_CONTENT_TAG_KEY.story then
		var_15_1 = var_15_0.readStoryIndex
		var_15_2 = self:GetOathStoryMaxOpenIndex(arg_15_1)
	elseif arg_15_2 == OathConst.OATH_CONTENT_TAG_KEY.archieve then
		var_15_1 = var_15_0.readArchieveIndex
		var_15_2 = self:GetOathArchieveMaxOpenIndex(arg_15_1)
	elseif arg_15_2 == OathConst.OATH_CONTENT_TAG_KEY.plot then
		var_15_1 = var_15_0.readPlotIndex
		var_15_2 = self:GetOathPlotMaxOpenIndex(arg_15_1)
	elseif arg_15_2 == OathConst.OATH_CONTENT_TAG_KEY.voice then
		var_15_1 = var_15_0.readVoiceIndex
		var_15_2 = self:GetOathVoiceMaxOpenIndex(arg_15_1)
	end

	return var_15_1, var_15_2
end

function var_0_0.GetOathStoryMaxOpenIndex(arg_16_0, arg_16_1)
	for iter_16_0 = #nullable(WeddingCfg, arg_16_1, "wedding_plot"), 1, -1 do
		if IsConditionAchieved(nullable(WeddingCfg, arg_16_1, "plot_condition", iter_16_0) or 0) then
			return iter_16_0
		end
	end

	return -1
end

function var_0_0.GetOathArchieveMaxOpenIndex(arg_17_0, arg_17_1)
	local var_17_0 = {
		1,
		2
	}

	for iter_17_0 = #var_17_0, 1, -1 do
		if IsConditionAchieved(nullable(WeddingCfg, arg_17_1, string.format("record%d_condition", var_17_0[iter_17_0])) or 0) then
			return iter_17_0
		end
	end

	return -1
end

function var_0_0.GetOathPlotMaxOpenIndex(arg_18_0, arg_18_1)
	for iter_18_0 = #WeddingNewsCfg.get_id_list_by_hero[arg_18_1], 1, -1 do
		if OathTools.IsCharaSecretUnlocked(WeddingNewsCfg.get_id_list_by_hero[arg_18_1][iter_18_0]) then
			return iter_18_0
		end
	end

	return -1
end

function var_0_0:GetOathVoiceMaxOpenIndex(arg_19_1)
	local var_19_0 = HeroVoiceCfg.get_id_list_by_tag_id[self:GetVoiceTag()] or {}

	for iter_19_0 = #var_19_0, 1, -1 do
		if HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id[var_19_0[iter_19_0]] then
			for iter_19_1, iter_19_2 in pairs(HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id[var_19_0[iter_19_0]]) do
				if (HeroTools.GetHeroIDFromFormID(iter_19_1) or SkinCfg[iter_19_1].hero) == arg_19_1 and HeroTools.IsUnlockVoice(arg_19_1, var_19_0[iter_19_0]) then
					return iter_19_0
				end
			end
		end
	end

	return -1
end

function var_0_0.GetVoiceTag(arg_20_0)
	return 8
end

function var_0_0.GetPopIsInCD(arg_21_0)
	return (manager.time:CheckIsToday(getData("Oath", "LastPopTimes") or 0, (manager.time:GetServerTime())))
end

local function var_0_1(arg_22_0)
	return function()
		JumpTools.OpenPageByJump(unpack(arg_22_0))
	end
end

function var_0_0:HasNewContent()
	if self:GetPopIsInCD() then
		return false
	end

	if self:HasOpenPop() then
		return true, var_0_1({
			"oathSystemPopView"
		})
	end

	local var_24_0 = self:HasUnOathHeroContent()

	if var_24_0 > 0 then
		return true, var_0_1({
			"oathHeroUnLockPopView",
			{
				heroID = var_24_0
			}
		})
	end

	return false
end

function var_0_0:HasOpenPop()
	if not OathTools.GetIsOpenOath() then
		return
	end

	return not self:GetRegeditData(OathConst.OATH_OPEN_TAG_ID).isLoginPop
end

function var_0_0:HasUnOathHeroContent()
	if not OathTools.GetIsOpenOath() then
		return -1
	end

	for iter_26_0, iter_26_1 in ipairs(WeddingCfg.all) do
		if not OathCollectionContentData:GetOathState(iter_26_1) and not self:GetRegeditData(iter_26_1).isLoginPop and HeroData:GetHeroData(iter_26_1).unlock == 1 then
			return iter_26_1
		end
	end

	return -1
end

function var_0_0:SavePopTag(arg_27_1)
	local var_27_0 = self:GetRegeditData(arg_27_1)

	if var_27_0.isLoginPop then
		return
	end

	var_27_0.isLoginPop = true

	self:SaveRegeditData(arg_27_1, var_27_0)
	saveData("Oath", "LastPopTimes", (manager.time:GetServerTime()))
end

return var_0_0
