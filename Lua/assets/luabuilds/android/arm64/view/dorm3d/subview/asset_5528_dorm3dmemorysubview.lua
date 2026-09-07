local Dorm3dMemorySubView = class("Dorm3dMemorySubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function Dorm3dMemorySubView:Init()
	self:OnLoaded()
	self:OnInit()

	return
end

function Dorm3dMemorySubView:OnLoaded()
	local var_2_0 = self._tf:Find("list/container")

	self.itemList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = self.ids[arg_3_1]
			local var_3_1 = pg.dorm3d_recall[self.ids[arg_3_1]]
			local var_3_2 = self.unlockDic[pg.dorm3d_recall[self.ids[arg_3_1]].story_id]

			setText(arg_3_2:Find("name"), (self.unlockDic[pg.dorm3d_recall[self.ids[arg_3_1]].story_id] or nil) and (var_3_1.name or i18n("dorm3d_recall_locked")))
			GetImageSpriteFromAtlasAsync(string.format("dorm3dmemory/%s_list", var_3_1.image), "", arg_3_2:Find("Image"))
			setImageAlpha(arg_3_2:Find("Image"), var_3_2 and 1 or 0.6)
			onToggle(self, arg_3_2, function(arg_4_0)
				if arg_4_0 then
					self:UpdateDisplay(arg_3_1, var_3_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.rtInfo = self._tf:Find("info")

	return
end

function Dorm3dMemorySubView:OnInit()
	self.ids = getProxy(ApartmentProxy):getRoom(self.contextData.roomId):getConfig("recall_list")
	self.unlockDic = {}

	local var_5_0 = {}
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(self.ids) do
		local var_5_2 = pg.dorm3d_recall[iter_5_1].story_id

		if var_5_0[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] == nil then
			local var_5_3 = getProxy(ApartmentProxy):getApartment(pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id)

			var_5_3 = var_5_3 or false
			var_5_0[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] = var_5_3
		end

		if var_5_0[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id] then
			self.unlockDic[var_5_2] = var_5_0[pg.dorm3d_dialogue_group[pg.dorm3d_recall[iter_5_1].story_id].char_id].talkDic[var_5_2] or false
		end

		if DORM_LOCK_GUIDE and var_5_2 == 26 then
			self.unlockDic[var_5_2] = true
		end

		if self.unlockDic[var_5_2] then
			var_5_1 = var_5_1 + 1
		end
	end

	setText(self.rtInfo:Find("count"), string.format("<color=#285cfc>%d</color>/%d", var_5_1, #self.ids))
	self.itemList:align(#self.ids)
	triggerToggle(self.itemList.container:GetChild(0), true)

	return
end

function Dorm3dMemorySubView:UpdateDisplay(arg_6_1, arg_6_2)
	local var_6_0 = self.rtInfo:Find("content")
	local var_6_1 = pg.dorm3d_recall[arg_6_2]
	local var_6_2 = self.unlockDic[pg.dorm3d_recall[arg_6_2].story_id]

	GetImageSpriteFromAtlasAsync(string.format("dorm3dmemory/%s_info", pg.dorm3d_recall[arg_6_2].image), "", var_6_0:Find("icon"))
	setImageAlpha(var_6_0:Find("icon"), var_6_2 and 1 or 0.25)
	setText(var_6_0:Find("icon/lock/Text"), i18n("dorm3d_reload_unlock"))
	setActive(var_6_0:Find("icon/lock"), not var_6_2)
	setActive(var_6_0:Find("icon/play"), var_6_2)
	onButton(self, var_6_0:Find("icon/play"), function()
		self:emit(Dorm3dCollectionMediator.DO_TALK, var_6_1.story_id)

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

return Dorm3dMemorySubView
