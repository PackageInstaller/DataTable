local MailMgrWindow = class("MailMgrWindow", import("view.base.BaseSubView"))

function MailMgrWindow:getUIName()
	return "MailMgrMsgboxUI"
end

function MailMgrWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("window/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.readBtn = self._tf:Find("window/button_container/btn_read")

	onButton(self, self.readBtn, function()
		self:emit(MailMediator.ON_OPERATION, {
			cmd = "read",
			filter = self:GetFilterData()
		})

		return
	end, SFX_CONFIRM)

	self.attachBtn = self._tf:Find("window/button_container/btn_get")

	onButton(self, self.attachBtn, function()
		self:emit(MailMediator.ON_OPERATION, {
			cmd = "attachment",
			filter = self:GetFilterData()
		})

		return
	end, SFX_CONFIRM)

	self.deleteBtn = self._tf:Find("window/button_container/btn_delete")

	onButton(self, self.deleteBtn, function()
		seriesAsync({
			function(arg_8_0)
				pg.m02:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
					type = MailProxy.MailMessageBoxType.ShowTips,
					content = i18n("main_mailLayer_quest_clear_choice"),
					onYes = arg_8_0
				})

				return
			end
		}, function()
			self:emit(MailMediator.ON_OPERATION, {
				cmd = "delete",
				filter = self:GetFilterData()
			})

			return
		end)

		return
	end, SFX_CONFIRM)

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs({
		[DROP_TYPE_RESOURCE] = {
			PlayerConst.ResGold,
			PlayerConst.ResOil,
			PlayerConst.ResExploit,
			PlayerConst.ResDiamond
		},
		[DROP_TYPE_ITEM] = {
			ITEM_ID_CUBE
		}
	}) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			table.insert(var_2_0, Drop.New({
				type = iter_2_0,
				id = iter_2_3
			}))
		end
	end

	if MailWaterSelect then
		table.insert(var_2_0, Drop.New({
			id = 50002,
			type = DROP_TYPE_ITEM
		}))
	end

	self.filterDic = {}
	self.rtContent = self._tf:Find("window/frame/toggle_group/filter/content")

	UIItemList.StaticAlign(self.rtContent, self.rtContent:Find("toggle_tpl"), #var_2_0, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1

		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_2_0[arg_10_1]

			GetImageSpriteFromAtlasAsync(var_2_0[arg_10_1]:getIcon(), "", arg_10_2:Find("Image"))
			onToggle(self, arg_10_2, function(arg_11_0)
				self.filterDic[var_10_0.type .. "_" .. var_10_0.id] = arg_11_0

				if arg_11_0 then
					triggerToggle(self._tf:Find("window/frame/toggle_group/filter"), true)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	eachChild(self._tf:Find("window/frame/toggle_group"), function(arg_12_0)
		onToggle(self, arg_12_0, function(arg_13_0)
			if arg_13_0 then
				self.filterType = arg_12_0.name

				if self.filterType == "all" then
					eachChild(self.rtContent, function(arg_14_0)
						triggerToggle(arg_14_0, false)

						return
					end)
				end
			end

			return
		end, SFX_PANEL)

		return
	end)
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("mail_manager_title"))
	setText(self._tf:Find("window/frame/tip/Text"), i18n("mail_manage_tip_1"))
	setText(self._tf:Find("window/frame/tip_1/Text"), i18n("mail_manager_tips_2"))
	setText(self._tf:Find("window/frame/toggle_group/all/Text"), i18n("mail_manage_1"))
	setText(self._tf:Find("window/frame/toggle_group/filter/Text"), i18n("mail_manage_2"))
	setText(self.attachBtn:Find("Text"), i18n("mail_get_oneclick"))
	setText(self.readBtn:Find("Text"), i18n("mail_read_oneclick"))
	setText(self.deleteBtn:Find("Text"), i18n("mail_delete_oneclick"))

	return
end

function MailMgrWindow:GetFilterData()
	return switch(self.filterType, {
		all = function()
			return {
				type = "all"
			}
		end,
		filter = function()
			local var_17_0 = {}

			for iter_17_0, iter_17_1 in pairs(self.filterDic) do
				if iter_17_1 then
					local var_17_1, var_17_2 = unpack(string.split(iter_17_0, "_"))

					table.insert(var_17_0, Drop.New({
						type = tonumber(var_17_1),
						id = tonumber(var_17_2)
					}))
				end
			end

			return {
				type = "drops",
				list = var_17_0
			}
		end
	}, function()
		assert(false)

		return
	end)
end

function MailMgrWindow:Show(arg_19_1)
	MailMgrWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	triggerToggle(self._tf:Find("window/frame/toggle_group/all"), true)

	return
end

function MailMgrWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MailMgrWindow.super.Hide(self)

	return
end

function MailMgrWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MailMgrWindow
