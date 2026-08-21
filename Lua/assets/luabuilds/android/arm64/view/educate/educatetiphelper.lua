local var_0_0 = class("EducateTipHelper")

var_0_0.system_save_key = "educate_system_unlcok_tip"
var_0_0.system_tip_list = {
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

function var_0_0.GetSystemUnlockTips()
	if not getProxy(EducateProxy):IsFirstGame() then
		return {}
	end

	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = var_1_0:getRawData().id
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.system_tip_list) do
		if PlayerPrefs.GetInt(var_1_1 .. var_0_0.system_save_key .. iter_1_0, 0) ~= 1 and EducateHelper.IsSystemUnlock(iter_1_0) then
			table.insert(var_1_2, iter_1_0)
		end
	end

	return var_1_2
end

function var_0_0.SaveSystemUnlockTip(arg_2_0)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. var_0_0.system_save_key .. arg_2_0, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.ClearSystemUnlockTips()
	local var_3_0 = getProxy(PlayerProxy):getRawData().id

	for iter_3_0, iter_3_1 in pairs(var_0_0.system_tip_list) do
		if PlayerPrefs.HasKey(var_3_0 .. var_0_0.system_save_key .. iter_3_0) then
			PlayerPrefs.DeleteKey(var_3_0 .. var_0_0.system_save_key .. iter_3_0)
			PlayerPrefs.Save()
		end
	end

	return
end

var_0_0.site_save_key = "educate_site_unlcok_tip"
var_0_0.needTipSiteIds = {}

for iter_0_0, iter_0_1 in ipairs(pg.child_site.all) do
	if pg.child_site[iter_0_1].type == 1 then
		table.insert(var_0_0.needTipSiteIds, iter_0_1)
	end
end

function var_0_0.GetSiteUnlockTipIds()
	if not getProxy(EducateProxy):IsFirstGame() then
		return {}
	end

	local var_4_0 = getProxy(PlayerProxy)
	local var_4_1 = var_4_0:getRawData().id
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_0.needTipSiteIds) do
		if PlayerPrefs.GetInt(var_4_1 .. var_0_0.site_save_key .. iter_4_1, 0) ~= 1 and EducateHelper.IsSiteUnlock(iter_4_1, true) then
			table.insert(var_4_2, iter_4_1)
			var_0_0.SetNewTip(var_0_0.NEW_SITE, iter_4_1)
		end
	end

	return var_4_2
end

function var_0_0.SaveSiteUnlockTipId(arg_5_0)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. var_0_0.site_save_key .. arg_5_0, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.ClearSiteUnlockTipIds()
	local var_6_0 = getProxy(PlayerProxy):getRawData().id

	for iter_6_0, iter_6_1 in ipairs(pg.child_site.all) do
		if PlayerPrefs.HasKey(var_6_0 .. var_0_0.site_save_key .. iter_6_1) then
			PlayerPrefs.DeleteKey(var_6_0 .. var_0_0.site_save_key .. iter_6_1)
			PlayerPrefs.Save()
		end
	end

	return
end

var_0_0.plan_save_key = "educate_plan_unlcok_tip"
var_0_0.needTipPlanIds = {}

for iter_0_2, iter_0_3 in ipairs(pg.child_plan.all) do
	if #pg.child_plan[iter_0_3].pre > 0 then
		table.insert(var_0_0.needTipPlanIds, iter_0_3)
	end
end

function var_0_0.GetPlanUnlockTipIds()
	local var_7_9000
	local var_7_0 = getProxy(PlayerProxy)
	local var_7_1 = var_7_0.getRawData(var_7_9000).id
	local var_7_2 = {}
	local var_7_3 = getProxy(EducateProxy).GetPlanProxy(var_7_0)

	for iter_7_0, iter_7_1 in ipairs(var_0_0.needTipPlanIds) do
		if PlayerPrefs.GetInt(var_7_1 .. var_0_0.plan_save_key .. iter_7_1, 0) ~= 1 and var_7_3:GetHistoryCntById(pg.child_plan[iter_7_1].pre[1]) >= pg.child_plan[iter_7_1].pre[2] then
			table.insert(var_7_2, iter_7_1)
		end
	end

	return var_7_2
end

function var_0_0.SavePlanUnlockTipId(arg_8_0)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. var_0_0.plan_save_key .. arg_8_0, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.ClearPlanUnlockTipIds()
	local var_9_0 = getProxy(PlayerProxy):getRawData().id

	for iter_9_0, iter_9_1 in ipairs(var_0_0.needTipPlanIds) do
		if PlayerPrefs.HasKey(var_9_0 .. var_0_0.plan_save_key .. iter_9_1) then
			PlayerPrefs.DeleteKey(var_9_0 .. var_0_0.plan_save_key .. iter_9_1)
			PlayerPrefs.Save()
		end
	end

	return
end

function var_0_0.ClearAllRecord()
	var_0_0.ClearSystemUnlockTips()
	var_0_0.ClearSiteUnlockTipIds()
	var_0_0.ClearPlanUnlockTipIds()

	return
end

var_0_0.NEW_MEMORY = 1
var_0_0.NEW_POLAROID = 2
var_0_0.NEW_MIND_TASK = 3
var_0_0.NEW_SITE = 4
var_0_0.new_tip_keys = {
	[var_0_0.NEW_MEMORY] = "educate_memory_new_tip",
	[var_0_0.NEW_POLAROID] = "educate_polaroid_new_tip",
	[var_0_0.NEW_MIND_TASK] = "educate_mind_task_new_tip",
	[var_0_0.NEW_SITE] = "educate_site_new_tip"
}

function var_0_0.SetNewTip(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(PlayerProxy):getRawData().id
	local var_11_1 = arg_11_1 and tostring(arg_11_1) or ""
	local var_11_2 = var_0_0.new_tip_keys[arg_11_0] .. var_11_1

	if PlayerPrefs.GetInt(var_11_0 .. var_0_0.new_tip_keys[arg_11_0] .. var_11_1, 0) == 1 then
		return
	end

	PlayerPrefs.SetInt(var_11_0 .. var_11_2, 1)
	PlayerPrefs.Save()

	return
end

function var_0_0.IsShowNewTip(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(PlayerProxy)
	local var_12_1 = arg_12_1 and tostring(arg_12_1) or ""

	return PlayerPrefs.GetInt(var_12_0:getRawData().id .. var_0_0.new_tip_keys[arg_12_0] .. var_12_1, 0) == 1
end

function var_0_0.ClearNewTip(arg_13_0, arg_13_1)
	local var_13_0 = getProxy(PlayerProxy)
	local var_13_1 = arg_13_1 and tostring(arg_13_1) or ""
	local var_13_2 = var_13_0:getRawData().id .. var_0_0.new_tip_keys[arg_13_0] .. var_13_1

	if PlayerPrefs.HasKey(var_13_2) then
		PlayerPrefs.DeleteKey(var_13_2)
		PlayerPrefs.Save()
		pg.m02:sendNotification(EducateProxy.CLEAR_NEW_TIP, {
			index = arg_13_0,
			id = arg_13_1
		})
	end

	return
end

return var_0_0
