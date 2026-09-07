local DOACoreActivityCollectPage = class("DOACoreActivityCollectPage", import("view.activity.CorePage.templatePage.CoreAwardTemplatePage"))

function DOACoreActivityCollectPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.itemPanel = self.bg:Find("item_panel")
	self.togglesTF = self.itemPanel:Find("toggles")
	self.content = self.itemPanel:Find("item_list/content")
	self.itemList = UIItemList.New(self.content, self.content:Find("tpl"))
	self.msgBox = DOACoreActivityMsgBox.New(self._tf, self.event)

	return
end

function DOACoreActivityCollectPage:GetTogglesDropTypes()
	return {
		DROP_TYPE_EQUIP,
		DROP_TYPE_SPWEAPON
	}
end

function DOACoreActivityCollectPage:OnClickItem(arg_3_1)
	self.msgBox:ExecuteAction("Show", {
		drop_type = arg_3_1.config.type,
		drop_id = arg_3_1.config.drop_id,
		count = arg_3_1.count,
		count_limit = arg_3_1.config.count,
		skipable_list = arg_3_1.config.link_params
	})

	return
end

function DOACoreActivityCollectPage:AddSpecialBtnListener()
	local var_4_0 = self.activity:getConfig("config_client")

	self.furnitureThemeBtn = self.btnList:Find("furniture_theme")

	if self.furnitureThemeBtn and var_4_0.furniture_theme_link then
		onButton(self, self.furnitureThemeBtn, function()
			self:DoSkip(var_4_0.furniture_theme_link[1], var_4_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	self.medalBtn = self.btnList:Find("medal")

	if self.medalBtn and var_4_0.medal_link then
		onButton(self, self.medalBtn, function()
			self:DoSkip(var_4_0.medal_link[1], var_4_0.medal_link[2])

			return
		end, SFX_PANEL)
	end

	self.equipSkinBoxBtn = self.btnList:Find("equip_skin_box")

	if self.equipSkinBoxBtn and var_4_0.equipskin_box_link then
		local var_4_1 = Drop.New({
			type = var_4_0.equipskin_box_link.drop_type,
			id = var_4_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(self, self.equipSkinBoxBtn, function()
			self.msgBox:ExecuteAction("Show", {
				drop_type = var_4_0.equipskin_box_link.drop_type,
				drop_id = var_4_0.equipskin_box_link.drop_id,
				count = var_4_1,
				skipable_list = var_4_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function DOACoreActivityCollectPage:OnHideFlush()
	if self.msgBox:isShowing() then
		self.msgBox:Hide()
	end

	return
end

function DOACoreActivityCollectPage:OnDestroy()
	if self.msgBox then
		self.msgBox:Hide()
		self.msgBox:Destroy()

		self.msgBox = nil
	end

	return
end

return DOACoreActivityCollectPage
