local var_0_0 = singletonClass("BulletinData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = false
local var_0_4
local var_0_5
local var_0_6 = false
local var_0_7 = {}

Timer.New(function()
	for iter_1_0, iter_1_1 in pairs(BulletinData.GetBulletinPageList()) do
		if manager.time:GetServerTime() > iter_1_1.endTime then
			BulletinAction.BulletinDelete(iter_1_1.id)
		end
	end
end, 1, -1):Start()

function var_0_0.Init()
	var_0_1 = {}
	var_0_2 = {}
	var_0_7 = {}
	var_0_3 = false
end

function var_0_0.constructImage(arg_3_0)
	return {
		itemType = arg_3_0.content_type,
		spriteUrl = arg_3_0.image,
		text = arg_3_0.text,
		event = {
			arg_3_0.event_type,
			arg_3_0.event_arg
		}
	}
end

function var_0_0.constructText(arg_4_0)
	return {
		itemType = arg_4_0.content_type,
		text = arg_4_0.text
	}
end

function var_0_0.constructTitle(arg_5_0)
	return {
		itemType = arg_5_0.content_type,
		text = string.match(arg_5_0.text, "<title>(%a+)</title>")
	}
end

local var_0_8 = {
	CONTENT = 2,
	TITLE = 1
}

function var_0_0.constructBulletin(arg_6_0)
	local var_6_0 = var_0_0.constructSingleBulletin(arg_6_0.content)
	local var_6_1 = {
		id = arg_6_0.id,
		type = arg_6_0.type,
		name = arg_6_0.title,
		startTime = arg_6_0.start_timestamp,
		endTime = arg_6_0.end_timestamp,
		index = arg_6_0.index,
		star = arg_6_0.star,
		content = var_6_0,
		i18n_info_name = {},
		i18n_info_content = {}
	}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.i18n_info) do
		if iter_6_1.type == var_0_8.TITLE then
			var_6_1.i18n_info_name[iter_6_1.language] = iter_6_1.string
		elseif iter_6_1.type == var_0_8.CONTENT then
			var_6_1.i18n_info_content[iter_6_1.language] = var_0_0.constructSingleBulletin(iter_6_1.content)
		end
	end

	return var_6_1
end

function var_0_0.constructSingleBulletin(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if iter_7_1.content_type == 1 then
			var_7_0[iter_7_0] = var_0_0.constructImage(iter_7_1)
		elseif iter_7_1.content_type == 2 then
			if string.find(iter_7_1.text, "<title>") then
				iter_7_1.content_type = 4
				var_7_0[iter_7_0] = var_0_0.constructTitle(iter_7_1)
			else
				var_7_0[iter_7_0] = var_0_0.constructText(iter_7_1)
			end
		end
	end

	return var_7_0
end

function var_0_0.constructBulletionID(arg_8_0, arg_8_1)
	var_0_1[arg_8_0] = var_0_1[arg_8_0] or {}

	for iter_8_0, iter_8_1 in pairs(var_0_1[arg_8_0]) do
		if iter_8_1 == arg_8_1 then
			return
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_0_1[arg_8_0]) do
		if var_0_2[arg_8_1].index > var_0_2[iter_8_3].index then
			table.insert(var_0_1[arg_8_0], iter_8_2, arg_8_1)

			return
		end
	end

	table.insert(var_0_1[arg_8_0], arg_8_1)
end

function var_0_0.insertBulletin(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(var_0_2) do
		if iter_9_1.id == arg_9_0.id then
			var_0_2[arg_9_0.id] = var_0_0.constructBulletin(arg_9_0)

			return
		end
	end

	var_0_2[arg_9_0.id] = var_0_0.constructBulletin(arg_9_0)
end

function var_0_0.refreshBulletin(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.announcement_list) do
		var_0_0.insertBulletin(iter_10_1)
		var_0_0.constructBulletionID(iter_10_1.type, iter_10_1.id)
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
end

function var_0_0.deleteBulletin(arg_11_0)
	local var_11_0 = arg_11_0.id

	var_0_2[var_11_0] = nil

	for iter_11_0, iter_11_1 in pairs(var_0_1) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			if iter_11_3 == var_11_0 then
				var_0_1[iter_11_0][iter_11_2] = nil

				break
			end
		end
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
	manager.notify:Invoke(BULLETIN_DELETE, var_11_0)
end

function var_0_0.GetBulletinIDList()
	return var_0_1
end

function var_0_0.GetBulletinPageList()
	return var_0_2
end

function var_0_0.GetReadFlag()
	return var_0_3
end

function var_0_0.SetReadFlag(arg_15_0)
	var_0_3 = arg_15_0
end

function var_0_0.SetReadFlagById(arg_16_0)
	saveData("bulletin", "bulletin_" .. arg_16_0, "true")
end

function var_0_0.GetIslogin()
	return var_0_6
end

function var_0_0.SetIslogin(arg_18_0)
	var_0_6 = arg_18_0
end

function var_0_0.SetCacheString(arg_19_0, arg_19_1)
	var_0_5 = arg_19_0
	var_0_4 = arg_19_1
end

function var_0_0.GetCurCacheStringAndID()
	return var_0_4, var_0_5
end

function var_0_0.GetCacheStringIsShowByID(arg_21_0)
	local var_21_0 = getData("BulletinData", "Id") or {
		-1
	}
	local var_21_1 = getData("BulletinData", "Num") or {
		-1
	}
	local var_21_2 = table.indexof(var_21_0, arg_21_0)

	if var_21_2 then
		if var_21_1[var_21_2] > 2 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function var_0_0.SetCacheStringIsShowByID(arg_22_0)
	local var_22_0 = getData("BulletinData", "Id") or {
		-1
	}
	local var_22_1 = getData("BulletinData", "Num") or {
		-1
	}
	local var_22_2 = table.indexof(var_22_0, arg_22_0)

	if var_22_2 then
		var_22_1[var_22_2] = var_22_1[var_22_2] + 1
	else
		table.insert(var_22_0, arg_22_0)
		table.insert(var_22_1, 1)
	end

	saveData("BulletinData", "Id", var_22_0)
	saveData("BulletinData", "Num", var_22_1)
end

function var_0_0.CheckDailyLoginPopBulletin()
	local var_23_0 = 0
	local var_23_1 = false

	for iter_23_0, iter_23_1 in pairs(var_0_2) do
		if iter_23_1.star == 1 and not getData("BulletinData", "TodayNeedPopSaveID_" .. iter_23_1.id) then
			table.insert(var_0_7, iter_23_1.id)

			if var_23_0 < iter_23_1.startTime then
				var_23_0 = iter_23_1.startTime
				var_23_1 = iter_23_1.id
			end
		end
	end

	return var_23_1
end

function var_0_0.SaveDailyLoginPopBulletin()
	for iter_24_0, iter_24_1 in ipairs(var_0_7) do
		saveData("BulletinData", "TodayNeedPopSaveID_" .. iter_24_1, true)
	end

	var_0_7 = {}
end

function var_0_0.OnLogout()
	var_0_6 = false
	var_0_4 = nil
	var_0_5 = nil
end

return var_0_0
