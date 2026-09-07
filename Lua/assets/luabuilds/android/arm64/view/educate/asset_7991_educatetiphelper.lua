local EducateTipHelper = class("EducateTipHelper")

EducateTipHelper.system_save_key = "educate_system_unlcok_tip"
EducateTipHelper.system_tip_list = {
	[EducateConst.SYSTEM_GO_OUT] = i18n("child_unlock_out"),
	[EducateConst.SYSTEM_MEMORY] = i18n("child_unlock_memory"),
	[EducateConst.SYSTEM_POLAROID] = i18n("child_unlock_polaroid"),
	[EducateConst.SYSTEM_ENDING] = i18n("child_unlock_ending"),
	[EducateConst.SYSTEM_FAVOR_AND_MIND] = i18n("child_unlock_intimacy"),
	[EducateConst.SYSTEM_BUFF] = i18n("child_unlock_buff"),
	[EducateConst.SYSTEM_ATTR_2] = i18n("child_unlock_attr2"),
	[EducateConst.SYSTEM_ATTR_3] = i18n("child_unlock_attr3"),
	[EducateConst.SYSTEM_BAG] = i18n("child_unlock_bag")
}

function EducateTipHelper.GetSystemUnlockTips()
	if not getProxy(EducateProxy):IsFirstGame() then
		return {}
	end

	local var_1_0 = getProxy(PlayerProxy):getRawData().id
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(EducateTipHelper.system_tip_list) do
		if PlayerPrefs.GetInt(var_1_0 .. EducateTipHelper.system_save_key .. iter_1_0, 0) ~= 1 and EducateHelper.IsSystemUnlock(iter_1_0) then
			table.insert(var_1_1, iter_1_0)
		end
	end

	return var_1_1
end

function EducateTipHelper:SaveSystemUnlockTip()
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. EducateTipHelper.system_save_key .. self, 1)
	PlayerPrefs.Save()

	return
end

function EducateTipHelper.ClearSystemUnlockTips()
	local var_3_0 = getProxy(PlayerProxy):getRawData().id

	for iter_3_0, iter_3_1 in pairs(EducateTipHelper.system_tip_list) do
		if PlayerPrefs.HasKey(var_3_0 .. EducateTipHelper.system_save_key .. iter_3_0) then
			PlayerPrefs.DeleteKey(var_3_0 .. EducateTipHelper.system_save_key .. iter_3_0)
			PlayerPrefs.Save()
		end
	end

	return
end

EducateTipHelper.site_save_key = "educate_site_unlcok_tip"
EducateTipHelper.needTipSiteIds = {}

for iter_0_0, iter_0_1 in ipairs(pg.child_site.all) do
	if pg.child_site[iter_0_1].type == 1 then
		table.insert(EducateTipHelper.needTipSiteIds, iter_0_1)
	end
end

function EducateTipHelper.GetSiteUnlockTipIds()
	if not getProxy(EducateProxy):IsFirstGame() then
		return {}
	end

	local var_4_0 = getProxy(PlayerProxy):getRawData().id
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(EducateTipHelper.needTipSiteIds) do
		if PlayerPrefs.GetInt(var_4_0 .. EducateTipHelper.site_save_key .. iter_4_1, 0) ~= 1 and EducateHelper.IsSiteUnlock(iter_4_1, true) then
			table.insert(var_4_1, iter_4_1)
			EducateTipHelper.SetNewTip(EducateTipHelper.NEW_SITE, iter_4_1)
		end
	end

	return var_4_1
end

function EducateTipHelper:SaveSiteUnlockTipId()
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. EducateTipHelper.site_save_key .. self, 1)
	PlayerPrefs.Save()

	return
end

function EducateTipHelper.ClearSiteUnlockTipIds()
	local var_6_0 = getProxy(PlayerProxy):getRawData().id

	for iter_6_0, iter_6_1 in ipairs(pg.child_site.all) do
		if PlayerPrefs.HasKey(var_6_0 .. EducateTipHelper.site_save_key .. iter_6_1) then
			PlayerPrefs.DeleteKey(var_6_0 .. EducateTipHelper.site_save_key .. iter_6_1)
			PlayerPrefs.Save()
		end
	end

	return
end

EducateTipHelper.plan_save_key = "educate_plan_unlcok_tip"
EducateTipHelper.needTipPlanIds = {}

for iter_0_2, iter_0_3 in ipairs(pg.child_plan.all) do
	if #pg.child_plan[iter_0_3].pre > 0 then
		table.insert(EducateTipHelper.needTipPlanIds, iter_0_3)
	end
end

function EducateTipHelper.GetPlanUnlockTipIds()
	local var_7_0 = getProxy(PlayerProxy)
	local var_7_1 = var_7_0:getRawData().id
	local var_7_2 = {}
	local var_7_3 = getProxy(EducateProxy).GetPlanProxy(var_7_0)

	for iter_7_0, iter_7_1 in ipairs(EducateTipHelper.needTipPlanIds) do
		if PlayerPrefs.GetInt(var_7_1 .. EducateTipHelper.plan_save_key .. iter_7_1, 0) ~= 1 and var_7_3:GetHistoryCntById(pg.child_plan[iter_7_1].pre[1]) >= pg.child_plan[iter_7_1].pre[2] then
			table.insert(var_7_2, iter_7_1)
		end
	end

	return var_7_2
end

function EducateTipHelper:SavePlanUnlockTipId()
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. EducateTipHelper.plan_save_key .. self, 1)
	PlayerPrefs.Save()

	return
end

function EducateTipHelper.ClearPlanUnlockTipIds()
	local var_9_0 = getProxy(PlayerProxy):getRawData().id

	for iter_9_0, iter_9_1 in ipairs(EducateTipHelper.needTipPlanIds) do
		if PlayerPrefs.HasKey(var_9_0 .. EducateTipHelper.plan_save_key .. iter_9_1) then
			PlayerPrefs.DeleteKey(var_9_0 .. EducateTipHelper.plan_save_key .. iter_9_1)
			PlayerPrefs.Save()
		end
	end

	return
end

function EducateTipHelper.ClearAllRecord()
	EducateTipHelper.ClearSystemUnlockTips()
	EducateTipHelper.ClearSiteUnlockTipIds()
	EducateTipHelper.ClearPlanUnlockTipIds()

	return
end

EducateTipHelper.NEW_MEMORY = 1
EducateTipHelper.NEW_POLAROID = 2
EducateTipHelper.NEW_MIND_TASK = 3
EducateTipHelper.NEW_SITE = 4
EducateTipHelper.new_tip_keys = {
	[EducateTipHelper.NEW_MEMORY] = "educate_memory_new_tip",
	[EducateTipHelper.NEW_POLAROID] = "educate_polaroid_new_tip",
	[EducateTipHelper.NEW_MIND_TASK] = "educate_mind_task_new_tip",
	[EducateTipHelper.NEW_SITE] = "educate_site_new_tip"
}

function EducateTipHelper:SetNewTip(arg_11_1)
	local var_11_0 = getProxy(PlayerProxy):getRawData().id
	local var_11_1 = EducateTipHelper.new_tip_keys[self] .. (arg_11_1 and tostring(arg_11_1) or "")

	if PlayerPrefs.GetInt(var_11_0 .. EducateTipHelper.new_tip_keys[self] .. (arg_11_1 and tostring(arg_11_1) or ""), 0) == 1 then
		return
	end

	PlayerPrefs.SetInt(var_11_0 .. var_11_1, 1)
	PlayerPrefs.Save()

	return
end

function EducateTipHelper:IsShowNewTip(arg_12_1)
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. EducateTipHelper.new_tip_keys[self] .. (arg_12_1 and tostring(arg_12_1) or ""), 0) == 1
end

function EducateTipHelper:ClearNewTip(arg_13_1)
	local var_13_1 = getProxy(PlayerProxy):getRawData().id .. EducateTipHelper.new_tip_keys[self] .. (arg_13_1 and tostring(arg_13_1) or "")

	if PlayerPrefs.HasKey(var_13_1) then
		PlayerPrefs.DeleteKey(var_13_1)
		PlayerPrefs.Save()
		pg.m02:sendNotification(EducateProxy.CLEAR_NEW_TIP, {
			index = self,
			id = arg_13_1
		})
	end

	return
end

return EducateTipHelper
