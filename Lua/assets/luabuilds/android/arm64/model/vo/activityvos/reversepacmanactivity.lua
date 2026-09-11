local ReversePacmanActivity = class("ReversePacmanActivity", import(".VirtualBagActivity"))

ReversePacmanActivity.KEY_VIRTUAL_ITEM = 1
ReversePacmanActivity.KEY_STAGE_DATA = 2
ReversePacmanActivity.KEY_FAVORABILITY = 3

function ReversePacmanActivity:Ctor(...)
	ReversePacmanActivity.super.Ctor(self, ...)
	pg.m02:sendNotification(GAME.GET_ACTIVITY_SHOP)

	return
end

function ReversePacmanActivity:GetVitemNumber(arg_2_1)
	return ReversePacmanActivity.super.getVitemNumber(self, arg_2_1)
end

function ReversePacmanActivity:SetVitemNumber(arg_3_1, arg_3_2)
	ReversePacmanActivity.super.setVitemNumber(self, arg_3_1, arg_3_2)

	return
end

function ReversePacmanActivity:AddVitemNumber(arg_4_1, arg_4_2)
	ReversePacmanActivity.super.addVitemNumber(self, arg_4_1, arg_4_2)

	return
end

function ReversePacmanActivity:SubVitemNumber(arg_5_1, arg_5_2)
	ReversePacmanActivity.super.subVitemNumber(self, arg_5_1, arg_5_2)

	return
end

function ReversePacmanActivity:GetStageDataList()
	return self.data1KeyValueList[ReversePacmanActivity.KEY_STAGE_DATA] or {}
end

function ReversePacmanActivity:UpdatePassStage(arg_7_1, arg_7_2)
	self.data1KeyValueList[ReversePacmanActivity.KEY_STAGE_DATA] = self.data1KeyValueList[ReversePacmanActivity.KEY_STAGE_DATA] or {}

	local var_7_0 = self.data1KeyValueList[ReversePacmanActivity.KEY_STAGE_DATA][arg_7_1] or 0

	if var_7_0 == 0 or arg_7_2 < var_7_0 then
		self.data1KeyValueList[ReversePacmanActivity.KEY_STAGE_DATA][arg_7_1] = arg_7_2
	end

	return
end

function ReversePacmanActivity:IsUnlockStage(arg_8_1)
	return pg.activity_chasing_level[arg_8_1].unlock_date and pg.TimeMgr.GetInstance():passTime(pg.activity_chasing_level[arg_8_1].unlock_date[1])
end

function ReversePacmanActivity:GetRoleIds()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self:GetFavorabilityList()) do
		table.insert(var_9_0, iter_9_0)
	end

	return var_9_0
end

function ReversePacmanActivity:GetFavorabilityList()
	return self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY] or {}
end

function ReversePacmanActivity:AddFavorability(arg_11_1, arg_11_2)
	self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY] = self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY] or {}
	self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY][arg_11_1] = (self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY][arg_11_1] or 0) + arg_11_2

	return
end

function ReversePacmanActivity:GetFavorability(arg_12_1)
	return (self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY] or nil) and (self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY][arg_12_1] or 0)
end

function ReversePacmanActivity:readyToAchieve()
	if self:isEnd() then
		return false
	end

	return self:GetHireTip() or self:GetTechnologyTip() or self:GetTaskTip() or self:GetGameTip()
end

function ReversePacmanActivity:GetHireTip()
	if ReversePacmanTools.GetItemCnt((ReversePacmanTools.GetInterviewItemID())) <= 0 then
		return false
	end

	if self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY] == nil then
		return true
	end

	for iter_14_0, iter_14_1 in ipairs(ReversePacmanTools.GetActivity():getConfig("config_client").chasing_char) do
		if self.data1KeyValueList[ReversePacmanActivity.KEY_FAVORABILITY][iter_14_1] == nil then
			return true
		end
	end

	return false
end

function ReversePacmanActivity:GetTechnologyTip()
	if not ReversePacmanTools.HasHireRole() then
		return false
	end

	return self:GetGiftTip() or self:GetRoleSkillTip() or self:GetPlayerSkillTip()
end

function ReversePacmanActivity:GetGiftTip()
	local var_16_0 = ReversePacmanTools.GetItemCnt((ReversePacmanTools.GetGiftItemID()))

	if var_16_0 < 0 then
		return false
	end

	if PlayerPrefs.GetString(string.format("REVERSE_PACMAN_GIFT_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id)) == pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d") then
		return false
	end

	for iter_16_0, iter_16_1 in pairs(self:GetFavorabilityList()) do
		if ReversePacmanTools.GetMaxFavorabilityValue(iter_16_0) > ReversePacmanTools.GetFavorabilityValue(iter_16_0) and var_16_0 >= pg.activity_chasing_character[iter_16_0].need[2] then
			return true
		end
	end

	return false
end

function ReversePacmanActivity:SetGiftTip()
	PlayerPrefs.SetString(string.format("REVERSE_PACMAN_GIFT_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id), (pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")))
	pg.m02:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

	return
end

function ReversePacmanActivity:GetRoleSkillTip()
	if ReversePacmanTools:GetTechnologyPTDrop():getOwnedCount() <= 0 then
		return false
	end

	if PlayerPrefs.GetString(string.format("REVERSE_PACMAN_ROLE_SKILL_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id)) == pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d") then
		return false
	end

	for iter_18_0, iter_18_1 in ipairs(self:getConfig("config_client").technologyShopIDList) do
		if getProxy(ShopsProxy):getActivityShopById(pg.activity_shop_template[iter_18_1].activity):getGoodsById(iter_18_1):CheckCntLimit() then
			return true
		end
	end

	return false
end

function ReversePacmanActivity:SetRoleSkillTip()
	PlayerPrefs.SetString(string.format("REVERSE_PACMAN_ROLE_SKILL_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id), (pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")))
	pg.m02:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

	return
end

function ReversePacmanActivity:GetPlayerSkillTip()
	if ReversePacmanTools:GetTechnologyPTDrop():getOwnedCount() <= 0 then
		return false
	end

	if PlayerPrefs.GetString(string.format("REVERSE_PACMAN_PLAYER_SKILL_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id)) == pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d") then
		return false
	end

	for iter_20_0, iter_20_1 in ipairs(self:getConfig("config_client").playerSkillShopIDList) do
		if getProxy(ShopsProxy):getActivityShopById(pg.activity_shop_template[iter_20_1].activity):getGoodsById(iter_20_1):CheckCntLimit() then
			return true
		end
	end

	return false
end

function ReversePacmanActivity:SetPlayerSkillTip()
	PlayerPrefs.SetString(string.format("REVERSE_PACMAN_PLAYER_SKILL_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id), (pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")))
	pg.m02:sendNotification(GAME.REVERSE_PACMAN_REFRESH_TIP)

	return
end

function ReversePacmanActivity:GetTaskTip()
	local var_22_0 = getProxy(ActivityProxy):getActivityById(self:getConfig("config_client").taskActivityID)

	return var_22_0 and var_22_0:readyToAchieve()
end

function ReversePacmanActivity:GetGameTip()
	if not ReversePacmanTools.HasHireRole() then
		return false
	end

	local var_23_0 = ReversePacmanTools.GetUnPassLevelIds()

	if #var_23_0 <= 0 then
		return false
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if self:IsLevelTip(iter_23_1) then
			return true
		end
	end

	return false
end

function ReversePacmanActivity:IsLevelTip(arg_24_1)
	if PlayerPrefs.GetInt((string.format("REVERSE_PACMAN_LEVEL_TIP_%s_%s_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id, pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d"), arg_24_1))) ~= 1 then
		return true
	end

	return false
end

function ReversePacmanActivity:SetLevelTip(arg_25_1)
	PlayerPrefs.SetInt(string.format("REVERSE_PACMAN_LEVEL_TIP_%s_%s_%s_%s", getProxy(PlayerProxy):getRawData().id, self.id, pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d"), arg_25_1), 1)

	return
end

return ReversePacmanActivity
