class = var_0_10000

local var_0_0 = var_0_10000("EducateTipHelper")

var_0_0.system_save_key = "educate_system_unlcok_tip"

local var_0_1 = {}

EducateConst = var_0_10002

local var_0_2 = var_0_10002.SYSTEM_GO_OUT

i18n = var_0_10003
var_0_1[var_0_2] = var_0_10003("child_unlock_out")
EducateConst = var_0_2

local var_0_3 = var_0_2.SYSTEM_MEMORY

i18n = var_3
var_0_1[var_0_3] = var_3("child_unlock_memory")
EducateConst = var_0_3

local var_0_4 = var_0_3.SYSTEM_POLAROID

i18n = var_3
var_0_1[var_0_4] = var_3("child_unlock_polaroid")
EducateConst = var_0_4

local var_0_5 = var_0_4.SYSTEM_ENDING

i18n = var_3
var_0_1[var_0_5] = var_3("child_unlock_ending")
EducateConst = var_0_5

local var_0_6 = var_0_5.SYSTEM_FAVOR_AND_MIND

i18n = var_3
var_0_1[var_0_6] = var_3("child_unlock_intimacy")
EducateConst = var_0_6

local var_0_7 = var_0_6.SYSTEM_BUFF

i18n = var_3
var_0_1[var_0_7] = var_3("child_unlock_buff")
EducateConst = var_0_7

local var_0_8 = var_0_7.SYSTEM_ATTR_2

i18n = var_3
var_0_1[var_0_8] = var_3("child_unlock_attr2")
EducateConst = var_0_8

local var_0_9 = var_0_8.SYSTEM_ATTR_3

i18n = var_3
var_0_1[var_0_9] = var_3("child_unlock_attr3")
EducateConst = var_0_9

local var_0_10 = var_0_9.SYSTEM_BAG

i18n = var_3
var_0_1[var_0_10] = var_3("child_unlock_bag")
var_0_0.system_tip_list = var_0_1

function var_0_0.GetSystemUnlockTips()
	getProxy = var_1_10000
	EducateProxy = var_1_10001

	local var_1_0 = var_1_10000(var_1_10001)

	if not var_0.IsFirstGame(var_1_0) then
		return {}
	end

	getProxy = var_0
	PlayerProxy = var_1_0

	local var_1_1 = var_0(var_1_0)
	local var_1_2 = var_0.getRawData(var_1_1).id
	local var_1_3 = {}

	pairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_0_0.system_tip_list) do
		PlayerPrefs = var_1_10007
		var_1_10007 = var_1_10007.GetInt(var_1_2 .. var_0_0.system_save_key .. iter_1_0, 0) == 1

		if not var_1_10007 then
			EducateHelper = var_8

			if var_8.IsSystemUnlock(iter_1_0) then
				table = var_8

				var_8.insert(var_1_3, iter_1_0)
			end
		end
	end

	return var_1_3
end

function var_0_0.SaveSystemUnlockTip(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getRawData(var_2_0).id

	PlayerPrefs = var_2_0

	var_2_0.SetInt(var_2_1 .. var_0_0.system_save_key .. arg_2_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.ClearSystemUnlockTips()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_3_0 = var_1_10000(var_1_10001)
	local var_3_1 = var_0.getRawData(var_3_0).id

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_0_0.system_tip_list) do
		local var_3_2 = var_3_1 .. var_0_0.system_save_key .. iter_3_0

		PlayerPrefs = var_7

		if var_7.HasKey(var_3_2) then
			PlayerPrefs = var_7

			var_7.DeleteKey(var_3_2)

			PlayerPrefs = var_7

			var_7.Save()
		end
	end

	return
end

var_0_0.site_save_key = "educate_site_unlcok_tip"
var_0_0.needTipSiteIds = {}
ipairs = var_1
pg = var_0_10

for iter_0_0, iter_0_1 in var_1(var_0_10.child_site.all) do
	pg = var_0_10006

	if var_0_10006.child_site[iter_0_1].type == 1 then
		table = var_0_10006

		var_0_10006.insert(var_0_0.needTipSiteIds, iter_0_1)
	end
end

function var_0_0.GetSiteUnlockTipIds()
	getProxy = var_1_10000
	EducateProxy = var_1_10001

	local var_4_0 = var_1_10000(var_1_10001)

	if not var_0.IsFirstGame(var_4_0) then
		return {}
	end

	getProxy = var_0
	PlayerProxy = var_4_0

	local var_4_1 = var_0(var_4_0)
	local var_4_2 = var_0.getRawData(var_4_1).id
	local var_4_3 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(var_0_0.needTipSiteIds) do
		PlayerPrefs = var_1_10007
		var_1_10007 = var_1_10007.GetInt(var_4_2 .. var_0_0.site_save_key .. iter_4_1, 0) == 1

		if not var_1_10007 then
			EducateHelper = var_8

			if var_8.IsSiteUnlock(iter_4_1, true) then
				table = var_8

				var_8.insert(var_4_3, iter_4_1)
				var_0_0.SetNewTip(var_0_0.NEW_SITE, iter_4_1)
			end
		end
	end

	return var_4_3
end

function var_0_0.SaveSiteUnlockTipId(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getRawData(var_5_0).id

	PlayerPrefs = var_5_0

	var_5_0.SetInt(var_5_1 .. var_0_0.site_save_key .. arg_5_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.ClearSiteUnlockTipIds()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_6_0 = var_1_10000(var_1_10001)
	local var_6_1 = var_0.getRawData(var_6_0).id

	ipairs = var_6_0
	pg = var_1_10002

	for iter_6_0, iter_6_1 in var_6_0(var_1_10002.child_site.all) do
		local var_6_2 = var_6_1 .. var_0_0.site_save_key .. iter_6_1

		PlayerPrefs = var_7

		if var_7.HasKey(var_6_2) then
			PlayerPrefs = var_7

			var_7.DeleteKey(var_6_2)

			PlayerPrefs = var_7

			var_7.Save()
		end
	end

	return
end

var_0_0.plan_save_key = "educate_plan_unlcok_tip"
var_0_0.needTipPlanIds = {}
ipairs = var_1
pg = var_2

for iter_0_2, iter_0_3 in var_1(var_2.child_plan.all) do
	pg = var_0_10006

	if #var_0_10006.child_plan[iter_0_3].pre > 0 then
		table = var_0_10006

		var_0_10006.insert(var_0_0.needTipPlanIds, iter_0_3)
	end
end

function var_0_0.GetPlanUnlockTipIds()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_7_0 = var_1_10000(var_1_10001)
	local var_7_1 = var_0.getRawData(var_7_0).id
	local var_7_2 = {}

	getProxy = var_1_10002
	EducateProxy = var_1_10003

	local var_7_3 = var_1_10002(var_1_10003)
	local var_7_4 = var_2.GetPlanProxy(var_7_3)

	ipairs = var_7_3

	for iter_7_0, iter_7_1 in var_7_3(var_0_0.needTipPlanIds) do
		PlayerPrefs = var_1_10008
		var_1_10008 = var_1_10008.GetInt(var_7_1 .. var_0_0.plan_save_key .. iter_7_1, 0) == 1

		if not var_1_10008 then
			pg = var_9

			local var_7_5 = var_9.child_plan[iter_7_1].pre

			if var_7_4:GetHistoryCntById(var_7_5[1]) >= var_7_5[2] then
				table = var_10

				var_10.insert(var_7_2, iter_7_1)
			end
		end
	end

	return var_7_2
end

function var_0_0.SavePlanUnlockTipId(arg_8_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.getRawData(var_8_0).id

	PlayerPrefs = var_8_0

	var_8_0.SetInt(var_8_1 .. var_0_0.plan_save_key .. arg_8_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_0.ClearPlanUnlockTipIds()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_9_0 = var_1_10000(var_1_10001)
	local var_9_1 = var_0.getRawData(var_9_0).id

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_0_0.needTipPlanIds) do
		local var_9_2 = var_9_1 .. var_0_0.plan_save_key .. iter_9_1

		PlayerPrefs = var_7

		if var_7.HasKey(var_9_2) then
			PlayerPrefs = var_7

			var_7.DeleteKey(var_9_2)

			PlayerPrefs = var_7

			var_7.Save()
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
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)
	local var_11_1 = var_2.getRawData(var_11_0).id

	if arg_11_1 then
		tostring = var_11_0

		local var_11_2

		if not var_11_0(arg_11_1) then
			var_11_2 = ""
		end

		local var_11_3 = var_0_0.new_tip_keys[arg_11_0] .. var_11_2

		PlayerPrefs = var_5

		if var_5.GetInt(var_11_1 .. var_11_3, 0) == 1 then
			return
		end

		PlayerPrefs = var_5

		var_5.SetInt(var_11_1 .. var_11_3, 1)

		PlayerPrefs = var_5

		var_5.Save()

		return
	end
end

function var_0_0.IsShowNewTip(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.getRawData(var_12_0).id

	if arg_12_1 then
		tostring = var_12_0

		local var_12_2

		if not var_12_0(arg_12_1) then
			var_12_2 = ""
		end

		local var_12_3 = var_0_0.new_tip_keys[arg_12_0] .. var_12_2

		PlayerPrefs = var_5

		return var_5.GetInt(var_12_1 .. var_12_3, 0) == 1
	end
end

function var_0_0.ClearNewTip(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10002(var_1_10003)
	local var_13_1 = var_2.getRawData(var_13_0).id

	if arg_13_1 then
		tostring = var_13_0

		local var_13_2

		if not var_13_0(arg_13_1) then
			var_13_2 = ""
		end

		local var_13_3 = var_0_0.new_tip_keys[arg_13_0] .. var_13_2
		local var_13_4 = var_13_1 .. var_13_3

		PlayerPrefs = var_6

		if var_6.HasKey(var_13_4) then
			PlayerPrefs = var_6

			var_6.DeleteKey(var_13_4)

			PlayerPrefs = var_6

			var_6.Save()

			pg = var_6

			local var_13_5 = var_6.m02
			local var_13_6 = var_6.sendNotification

			EducateProxy = var_1_10008

			var_13_6(var_13_5, var_1_10008.CLEAR_NEW_TIP, {
				index = arg_13_0,
				id = arg_13_1
			})
		end

		return
	end
end

return var_0_0
