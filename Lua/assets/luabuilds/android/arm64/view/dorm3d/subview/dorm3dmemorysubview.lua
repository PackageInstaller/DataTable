local var_0_0 = class("Dorm3dMemorySubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0:OnLoaded()
	arg_1_0:OnInit()

	return
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("list/container")

	arg_2_0.itemList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	arg_2_0.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = pg.dorm3d_recall[arg_2_0.ids[arg_3_1]]
			local var_3_1 = arg_2_0.unlockDic[pg.dorm3d_recall[arg_2_0.ids[arg_3_1]].story_id]
			local var_3_3 = arg_3_2:Find("name")

			if arg_2_0.unlockDic[pg.dorm3d_recall[arg_2_0.ids[arg_3_1]].story_id] then
				local var_3_4 = var_3_0.name or i18n("dorm3d_recall_locked")

				var_3_2(var_3_3, var_3_4)
				GetImageSpriteFromAtlasAsync(string.format("dorm3dmemory/%s_list", var_3_0.image), "", arg_3_2:Find("Image"))
				setImageAlpha(arg_3_2:Find("Image"), var_3_1 and 1 or 0.6)
				onToggle(arg_2_0, arg_3_2, function(arg_4_0)
					if arg_4_0 then
						arg_2_0:UpdateDisplay(arg_3_1, var_0)
					end

					return
				end, SFX_PANEL)

				return
			end
		end
	end)

	arg_2_0.rtInfo = arg_2_0._tf:Find("info")

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0.ids = getProxy(ApartmentProxy):getRoom(arg_5_0.contextData.roomId):getConfig("recall_list")
	arg_5_0.unlockDic = {}

	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.ids) do
		local var_5_1 = pg.dorm3d_recall[iter_5_1].story_id

		if ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] == nil then
			local var_5_2 = getProxy(ApartmentProxy):getApartment(pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id)

			var_5_2 = var_5_2 or false
			;({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] = var_5_2
		end

		local var_5_3 = arg_5_0.unlockDic

		if ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] then
			local var_5_4 = ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id].talkDic[var_5_1]

			if not ({})[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id].talkDic[var_5_1] then
				var_5_4 = false
			end

			var_5_3[var_5_1] = var_5_4

			if DORM_LOCK_GUIDE and var_5_1 == 26 then
				arg_5_0.unlockDic[var_5_1] = true
			end

			if arg_5_0.unlockDic[var_5_1] then
				var_5_0 = var_5_0 + 1
			end
		end
	end

	setText(arg_5_0.rtInfo:Find("count"), string.format("<color=#285cfc>%d</color>/%d", var_5_0, #arg_5_0.ids))
	arg_5_0.itemList:align(#arg_5_0.ids)
	triggerToggle(arg_5_0.itemList.container:GetChild(0), true)

	return
end

function var_0_0.UpdateDisplay(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.rtInfo:Find("content")
	local var_6_1 = pg.dorm3d_recall[arg_6_2]
	local var_6_2 = arg_6_0.unlockDic[pg.dorm3d_recall[arg_6_2].story_id]

	GetImageSpriteFromAtlasAsync(string.format("dorm3dmemory/%s_info", pg.dorm3d_recall[arg_6_2].image), "", var_6_0:Find("icon"))
	setImageAlpha(var_6_0:Find("icon"), var_6_2 and 1 or 0.25)
	setText(var_6_0:Find("icon/lock/Text"), i18n("dorm3d_reload_unlock"))
	setActive(var_6_0:Find("icon/lock"), not var_6_2)
	setActive(var_6_0:Find("icon/play"), var_6_2)
	onButton(arg_6_0, var_6_0:Find("icon/play"), function()
		arg_6_0:emit(Dorm3dCollectionMediator.DO_TALK, var_6_1.story_id)

		return
	end, SFX_CONFIRM)
	setText(var_6_0:Find("pro/Text"), "is pro")
	setActive(var_6_0:Find("pro"), var_6_1.type == 2)
	setImageAlpha(var_6_0:Find("name/bg"), var_6_2 and 1 or 0)
	setActive(var_6_0:Find("name"), var_6_2)
	setActive(var_6_0:Find("name_lock"), not var_6_2)

	if var_6_2 then
		setText(var_6_0:Find("name/number"), string.format("%02d.", arg_6_1))
		setText(var_6_0:Find("name/Text"), var_6_1.name)
		setText(var_6_0:Find("name/Text/en"), i18n("dorm3d_collection_title_en"))
		setText(var_6_0:Find("desc"), var_6_1.desc)
	else
		setText(var_6_0:Find("name_lock"), i18n("dorm3d_reload_unlock_name"))
		setText(var_6_0:Find("desc"), var_6_1.unlock_text)
	end

	return
end

return var_0_0
