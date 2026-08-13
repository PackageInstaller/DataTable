class = var_0_10000

local var_0_0 = "Dorm3dMemorySubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0:OnLoaded()
	arg_1_0:OnInit()

	return
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "list/container")

	UIItemList = var_1_10002
	arg_2_0.itemList = var_1_10002.New(var_2_1, var_2_1:Find("tpl"))

	local var_2_2 = arg_2_0.itemList

	var_2.make(var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.ids[arg_3_1]

			pg = var_2_10004

			local var_3_1 = var_2_10004.dorm3d_recall[var_3_0]
			local var_3_2 = arg_2_0.unlockDic[var_3_1.story_id]

			setText = var_6

			local var_3_3 = arg_3_2:Find("name")

			if not var_3_2 or not var_3_1.name then
				i18n = var_2_10009
				var_2_10009 = var_2_10009("dorm3d_recall_locked")
			end

			var_6(var_3_3, var_2_10009)

			GetImageSpriteFromAtlasAsync = var_6
			string = var_3_3

			var_6(var_3_3.format("dorm3dmemory/%s_list", var_3_1.image), "", arg_3_2:Find("Image"))

			setImageAlpha = var_6

			var_6(arg_3_2:Find("Image"), var_3_2 and 1 or 0.6)

			onToggle = var_6

			local var_3_4 = arg_2_0
			local var_3_5 = arg_3_2

			local function var_3_6(arg_4_0)
				if arg_4_0 then
					local var_4_0 = arg_2_0

					var_1.UpdateDisplay(var_4_0, arg_3_1, var_3_0)
				end

				return
			end

			SFX_PANEL = var_11

			var_6(var_3_4, var_3_5, var_3_6, var_11)
		end

		return
	end)

	local var_2_3 = arg_2_0._tf

	arg_2_0.rtInfo = var_2.Find(var_2_3, "info")

	return
end

function var_0_1.OnInit(arg_5_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getRoom(var_5_0, arg_5_0.contextData.roomId)

	arg_5_0.ids = var_1.getConfig(var_5_1, "recall_list")
	arg_5_0.unlockDic = {}

	local var_5_2 = {}
	local var_5_3 = 0

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(arg_5_0.ids) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.dorm3d_recall[iter_5_1].story_id
		pg = var_1_10010

		if var_5_2[var_1_10010.dorm3d_dialogue_group[var_1_10009].char_id] == nil then
			getProxy = var_11
			ApartmentProxy = var_1_10013
			var_1_10013 = var_11(var_1_10013)

			local var_5_4

			if not var_11.getApartment(var_1_10013, var_1_10010) then
				var_5_4 = false
			end

			var_5_2[var_1_10010] = var_5_4
		end

		local var_5_5 = arg_5_0.unlockDic
		local var_5_6

		if not var_5_2[var_1_10010] or not var_5_2[var_1_10010].talkDic[var_1_10009] then
			var_5_6 = false
		end

		var_5_5[var_1_10009] = var_5_6
		DORM_LOCK_GUIDE = var_5_5

		if var_5_5 and var_1_10009 == 26 then
			arg_5_0.unlockDic[var_1_10009] = true
		end

		if arg_5_0.unlockDic[var_1_10009] then
			var_5_3 = var_5_3 + 1
		end
	end

	setText = var_4

	local var_5_7 = arg_5_0.rtInfo
	local var_5_8 = var_6.Find(var_5_7, "count")

	string = iter_5_0

	var_4(var_5_8, iter_5_0.format("<color=#285cfc>%d</color>/%d", var_5_3, #arg_5_0.ids))

	local var_5_9 = arg_5_0.itemList

	var_4.align(var_5_9, #arg_5_0.ids)

	triggerToggle = var_4

	local var_5_10 = arg_5_0.itemList.container

	var_4(var_6.GetChild(var_5_10, 0), true)

	return
end

function var_0_1.UpdateDisplay(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.rtInfo
	local var_6_1 = var_3.Find(var_6_0, "content")

	pg = var_1_10004

	local var_6_2 = var_1_10004.dorm3d_recall[arg_6_2]
	local var_6_3 = arg_6_0.unlockDic[var_6_2.story_id]

	GetImageSpriteFromAtlasAsync = var_6
	string = var_1_10008

	var_6(var_1_10008.format("dorm3dmemory/%s_info", var_6_2.image), "", var_6_1:Find("icon"))

	setImageAlpha = var_6

	var_6(var_6_1:Find("icon"), var_6_3 and 1 or 0.25)

	setText = var_6

	local var_6_4 = var_6_1:Find("icon/lock/Text")

	i18n = var_9

	var_6(var_6_4, var_9("dorm3d_reload_unlock"))

	setActive = var_6

	var_6(var_6_1:Find("icon/lock"), not var_6_3)

	setActive = var_6

	var_6(var_6_1:Find("icon/play"), var_6_3)

	onButton = var_6

	local var_6_5 = arg_6_0
	local var_6_6 = var_6_1
	local var_6_7 = var_6_1.Find(var_6_6, "icon/play")

	local function var_6_8()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		Dorm3dCollectionMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.DO_TALK, var_6_2.story_id)

		return
	end

	SFX_CONFIRM = var_6_6

	var_6(var_6_5, var_6_7, var_6_8, var_6_6)

	setText = var_6

	var_6(var_6_1:Find("pro/Text"), "is pro")

	setActive = var_6

	var_6(var_6_1:Find("pro"), var_6_2.type == 2)

	setImageAlpha = var_6

	var_6(var_6_1:Find("name/bg"), var_6_3 and 1 or 0)

	setActive = var_6

	var_6(var_6_1:Find("name"), var_6_3)

	setActive = var_6

	var_6(var_6_1:Find("name_lock"), not var_6_3)

	if var_6_3 then
		setText = var_6

		local var_6_9 = var_6_1:Find("name/number")

		string = var_9

		var_6(var_6_9, var_9.format("%02d.", arg_6_1))

		setText = var_6

		var_6(var_6_1:Find("name/Text"), var_6_2.name)

		setText = var_6

		local var_6_10 = var_6_1:Find("name/Text/en")

		i18n = var_9

		var_6(var_6_10, var_9("dorm3d_collection_title_en"))

		setText = var_6

		var_6(var_6_1:Find("desc"), var_6_2.desc)
	else
		setText = var_6

		local var_6_11 = var_6_1:Find("name_lock")

		i18n = var_9

		var_6(var_6_11, var_9("dorm3d_reload_unlock_name"))

		setText = var_6

		var_6(var_6_1:Find("desc"), var_6_2.unlock_text)
	end

	return
end

return var_0_1
