local ToloveCollectPage = class("ToloveCollectPage", import(".TemplatePage.LinkCollectTemplatePage"))

ToloveCollectPage.SKIP_TYPE_MINIGAME = 7

function ToloveCollectPage:OnInit()
	ToloveCollectPage.super.OnInit(self)
	self:findUI()

	return
end

function ToloveCollectPage:OnFirstFlush()
	ToloveCollectPage.super.OnFirstFlush(self)
	self:rewriteEquipSkinBtn()

	return
end

function ToloveCollectPage:findUI()
	setImageRaycastTarget(self.content:Find("tpl/Frame"), false)

	self.boxTF = self._tf:Find("Box")
	self.boxBG = self.boxTF:Find("BG")
	self.panel = self.boxTF:Find("Panel")
	self.infoTF = self.panel:Find("Info")
	self.boxCloseBtn = self.infoTF:Find("CloseBtn")
	self.boxIconTF = self.infoTF:Find("Icon/Mask/IconTpl")
	self.boxNameText = self.infoTF:Find("NameText")
	self.boxNumTF = self.infoTF:Find("Num")
	self.boxNumTip = self.boxNumTF:Find("Text")
	self.boxNumText = self.boxNumTF:Find("NumText")
	self.boxDescText = self.infoTF:Find("DescText")
	self.boxSrcText = self.infoTF:Find("SrcText")

	onButton(self, self.boxBG, function()
		self:showBoxPanel(false)

		return
	end, SFX_PANEL)
	onButton(self, self.boxCloseBtn, function()
		self:showBoxPanel(false)

		return
	end, SFX_PANEL)

	self.boxSrcContent = self.panel:Find("Content")
	self.boxSrcTpl = self.boxSrcContent:Find("SrcTpl")

	GetComponent(self.btnList:Find("furniture_theme/Title"), "Image"):SetNativeSize()
	GetComponent(self.btnList:Find("equip_skin_box/Title"), "Image"):SetNativeSize()
	GetComponent(self.btnList:Find("medal/Title"), "Image"):SetNativeSize()

	return
end

function ToloveCollectPage:rewriteEquipSkinBtn()
	onButton(self, self.equipSkinBoxBtn, function()
		local var_7_0 = self.activity:getConfig("config_client")

		self:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
			drop_type = var_7_0.equipskin_box_link.drop_type,
			drop_id = var_7_0.equipskin_box_link.drop_id,
			count = Drop.New({
				type = var_7_0.equipskin_box_link.drop_type,
				id = var_7_0.equipskin_box_link.drop_id
			}):getOwnedCount(),
			skipable_list = var_7_0.equipskin_box_link.list
		})
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)

	return
end

function ToloveCollectPage:updateBoxPanel(arg_8_1)
	local var_8_0 = Drop.New({
		type = arg_8_1.drop_type,
		id = arg_8_1.drop_id
	})

	updateDrop(self.boxIconTF, var_8_0)
	changeToScrollText(self.boxNameText, var_8_0.cfg.name)
	setText(self.boxDescText, SwitchSpecialChar(var_8_0.desc))
	setText(self.boxNumTip, i18n("word_own1"))

	if arg_8_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setText(self.boxNumText, arg_8_1.count)
	elseif arg_8_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		setText(self.boxNumText, arg_8_1.count .. "/" .. (arg_8_1.count_limit or 0))
	end

	UIItemList.StaticAlign(self.boxSrcContent, self.boxSrcTpl, #arg_8_1.skipable_list, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_1.skipable_list[arg_9_1 + 1][1]
			local var_9_1 = arg_8_1.skipable_list[arg_9_1 + 1][2]

			changeToScrollText(arg_9_2:Find("SrcText"), arg_8_1.skipable_list[arg_9_1 + 1][3])
			onButton(self, arg_9_2:Find("GoBtn"), function()
				if var_9_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
					pg.m02:sendNotification(GAME.GO_SCENE, var_9_1[1], var_9_1[2] or {})
				elseif var_9_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_9_1
					})
				elseif var_9_0 == ToloveCollectPage.SKIP_TYPE_MINIGAME then
					pg.m02:sendNotification(GAME.GO_MINI_GAME, var_9_1[1])
				end

				self:showBoxPanel(false)

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
		end

		return
	end)

	return
end

function ToloveCollectPage:showBoxPanel(arg_11_1)
	setActive(self.boxTF, arg_11_1)

	return
end

function ToloveCollectPage:OnUpdateItem(arg_12_1, arg_12_2)
	local var_12_0 = self.showDataList[arg_12_1 + 1]
	local var_12_1 = arg_12_2:Find("icon_mask/icon")

	updateDrop(var_12_1, {
		type = self.showDataList[arg_12_1 + 1].config.type,
		id = self.showDataList[arg_12_1 + 1].config.drop_id
	})
	onButton(self, var_12_1, function()
		self:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_12_0.config.type,
			drop_id = var_12_0.config.drop_id,
			count = var_12_0.count,
			count_limit = var_12_0.config.count,
			skipable_list = var_12_0.config.link_params
		})
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_12_2:Find("name_mask/name"), Drop.New({
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	}):getName())
	setText(arg_12_2:Find("owner/number"), var_12_0.count .. "/" .. var_12_0.config.count)

	GetOrAddComponent(arg_12_2:Find("owner"), typeof(CanvasGroup)).alpha = var_12_0.count == var_12_0.config.count and 0.5 or 1

	setActive(arg_12_2:Find("got"), var_12_0.count == var_12_0.config.count)
	setActive(arg_12_2:Find("new"), var_12_0.config.is_new == "1")

	return
end

return ToloveCollectPage
