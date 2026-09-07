local IslandShipBreakoutPage = class("IslandShipBreakoutPage", import("...base.IslandBasePage"))

function IslandShipBreakoutPage:getUIName()
	return "IslandShipBreakoutUI"
end

function IslandShipBreakoutPage:OnLoaded()
	self.uiStarPreList = UIItemList.New(self._tf:Find("frame_1/star/prev"), self._tf:Find("frame_1/star/prev/tpl"))
	self.uiStarNextList = UIItemList.New(self._tf:Find("frame_1/star/now"), self._tf:Find("frame_1/star/now/tpl"))
	self.prevLevelTxt = self._tf:Find("frame_1/level/prev"):GetComponent(typeof(Text))
	self.nextLevelTxt = self._tf:Find("frame_1/level/now"):GetComponent(typeof(Text))
	self.skillTxt = self._tf:Find("frame_1/skill/Text"):GetComponent(typeof(Text))
	self.skillLabelTxt = self._tf:Find("frame_1/skill/now"):GetComponent(typeof(Text))
	self.uiAttrList = UIItemList.New(self._tf:Find("frame_3/attrs"), self._tf:Find("frame_3/attrs/tpl"))
	self.uiConsumeList = UIItemList.New(self._tf:Find("frame_2/comsume"), self._tf:Find("frame_2/comsume/tpl"))
	self.upgradeBtn = self._tf:Find("btn_confirm")
	self.closeBtn = self._tf:Find("frame_1/close")

	setText(self._tf:Find("frame_1/title"), i18n("island_ship_breakout"))
	setText(self._tf:Find("frame_2/consume_title/Text"), i18n("island_ship_breakout_consume"))
	setText(self.upgradeBtn:Find("Text"), i18n("island_chara_breakout_button"))

	return
end

function IslandShipBreakoutPage:AddListeners()
	self:AddListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, self.OnBreakOutDone)

	return
end

function IslandShipBreakoutPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, self.OnBreakOutDone)

	return
end

function IslandShipBreakoutPage:OnBreakOutDone()
	self:Hide()

	return
end

function IslandShipBreakoutPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShipBreakoutPage:OnShow(arg_9_1)
	local var_9_0 = Clone(arg_9_1)

	var_9_0:UpgradeBreakOut()
	self:BlurPanel(var_9_0, arg_9_1)
	self:UpdateBreakOutLevel(var_9_0, arg_9_1)
	self:UpdateLevel(var_9_0, arg_9_1)
	self:UpdateSkill(var_9_0, arg_9_1)
	self:UpdateAttrs(var_9_0, arg_9_1)
	self:UpdateConsume(var_9_0, arg_9_1)
	self:UpdateUpgradeBtn(arg_9_1)

	return
end

function IslandShipBreakoutPage:UpdateBreakOutLevel(arg_10_1, arg_10_2)
	self.uiStarPreList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("Image"), arg_11_1 + 1 <= arg_10_2:GetBreakLevel())
		end

		return
	end)
	self.uiStarPreList:align(arg_10_2:GetBreakMaxLevel())
	self.uiStarNextList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			setActive(arg_12_2:Find("Image"), arg_12_1 + 1 <= arg_10_1:GetBreakLevel())
		end

		return
	end)
	self.uiStarNextList:align(arg_10_1:GetBreakMaxLevel())

	return
end

function IslandShipBreakoutPage:UpdateLevel(arg_13_1, arg_13_2)
	self.prevLevelTxt.text = "Lv." .. arg_13_2:GetMaxLevel()
	self.nextLevelTxt.text = "Lv." .. arg_13_1:GetMaxLevel()

	return
end

function IslandShipBreakoutPage:UpdateSkill(arg_14_1, arg_14_2)
	if arg_14_1:GetSkill():IsUnlock() and not arg_14_2:GetSkill():IsUnlock() then
		self.skillTxt.text = arg_14_2:GetSkill():GetName()
		self.skillLabelTxt.text = i18n("island_ship_newskill_unlock")
	else
		self.skillTxt.text = ""
		self.skillLabelTxt.text = ""
	end

	return
end

function IslandShipBreakoutPage:UpdateAttrs(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:GetGrowthAtt()
	local var_15_1 = arg_15_2:GetGrowthAtt()

	self.uiAttrList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_16_2:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", IslandShipAttr.Grade2Img((arg_15_2:GetAttrGrade(IslandShipAttr.ATTRS[arg_16_1 + 1])))[2])

			setText(arg_16_2:Find("name"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_16_1 + 1]))
			setText(arg_16_2:Find("value"), "+" .. (var_15_1[IslandShipAttr.ATTRS[arg_16_1 + 1]] or 0) .. "  >>>  +" .. (var_15_0[IslandShipAttr.ATTRS[arg_16_1 + 1]] or 0))
		end

		return
	end)
	self.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function IslandShipBreakoutPage:UpdateConsume(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:GetBreakoutMatrials()
	local var_17_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.uiConsumeList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			updateCustomDrop(arg_18_2, var_17_0[arg_18_1 + 1])

			local var_18_1 = var_17_1:GetOwnCount(var_18_0.id)

			setText(arg_18_2:Find("icon_bg/count_bg/count"), setColorStr(var_18_1, (var_18_1 >= var_18_0.count or nil) and (COLOR_GREEN or COLOR_RED)) .. "/" .. var_18_0.count)
		end

		return
	end)
	self.uiConsumeList:align(#var_17_0)

	return
end

function IslandShipBreakoutPage:UpdateUpgradeBtn(arg_19_1)
	local var_19_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_19_1 = _.all(arg_19_1:GetBreakoutMatrials(), function(arg_20_0)
		return var_19_0:GetOwnCount(arg_20_0.id) >= arg_20_0.count
	end)

	setGray(self.upgradeBtn, not var_19_1, true)
	onButton(self, self.upgradeBtn, function()
		if not var_19_1 then
			return
		end

		self:emit(IslandMediator.SHIP_BREAKOUT, arg_19_1.id)

		return
	end, SFX_PANEL)

	return
end

function IslandShipBreakoutPage:OnHide()
	self:UnBlurPanel()

	return
end

return IslandShipBreakoutPage
