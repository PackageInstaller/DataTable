local MetaQuickTacticsLayer = class("MetaQuickTacticsLayer", import("...base.BaseUI"))

function MetaQuickTacticsLayer:getUIName()
	return "MetaQuickTacticsUI"
end

function MetaQuickTacticsLayer:getGroupName()
	return "MetaCharacterScene"
end

function MetaQuickTacticsLayer:init()
	self:initUITextTips()
	self:initData()
	self:initUI()
	self:addListener()
	self:overlayPanel(true)

	return
end

function MetaQuickTacticsLayer:didEnter()
	self:initSkillInfoPanel()
	self:initUIItemList()

	return
end

function MetaQuickTacticsLayer:willExit()
	self:overlayPanel(false)

	return
end

function MetaQuickTacticsLayer:onBackPressed()
	self:closeView()

	return
end

function MetaQuickTacticsLayer:initUITextTips()
	setText(self._tf:Find("Content/SkillInfo/UseTip"), i18n("metaskill_up"))

	return
end

function MetaQuickTacticsLayer:initData()
	self.metaProxy = getProxy(MetaCharacterProxy)
	self.bagProxy = getProxy(BagProxy)
	self.bayProxy = getProxy(BayProxy)
	self.shipID = self.contextData.shipID
	self.skillID = self.contextData.skillID
	self.bookIDList = pg.item_data_statistics.get_id_list_by_type[Item.METALESSON_TYPE]
	self.useCountDict = {}
	self.maxCountDict = {}
	self.useCountTextDict = {}

	self:resetUseData()

	self.colorDict = {
		[ItemRarity.Blue] = "#70D4FAFF",
		[ItemRarity.Purple] = "#C380FBFF",
		[ItemRarity.Gold] = "#FFCC4DFF"
	}
	self.expDict = {}

	for iter_8_0, iter_8_1 in ipairs(self.bookIDList) do
		self.expDict[iter_8_1] = tonumber(Item.getConfigData(iter_8_1).usage_arg)
	end

	return
end

function MetaQuickTacticsLayer:initUI()
	self.bg = self._tf:Find("BG")
	self.tpl = self._tf:Find("TacticsTpl")

	local var_9_0 = self._tf:Find("Content")

	self.closeBtn = var_9_0:Find("Title/CloseBtn")

	local var_9_1 = var_9_0:Find("SkillInfo")
	local var_9_2 = var_9_1:Find("Skill")

	self.skillNameText = var_9_2:Find("Name")
	self.skillLevelText = var_9_2:Find("LevelNum")
	self.skillLevelUpText = var_9_2:Find("LevelUp")

	local var_9_3 = var_9_1:Find("Exp")

	self.curExpText = var_9_3:Find("CurExp")
	self.addExpText = var_9_3:Find("AddExp")
	self.totalExpText = var_9_3:Find("TotalExp")
	self.progressBar = var_9_1:Find("Slider")
	self.containerTF = var_9_0:Find("Container")

	local var_9_4 = var_9_0:Find("Action")

	self.clearBtn = var_9_4:Find("ClearBtn")
	self.onestepBtn = var_9_4:Find("OneStepBtn")
	self.confirmBtn = var_9_4:Find("ConfirmBtn")

	return
end

function MetaQuickTacticsLayer:addListener()
	local function var_10_0()
		self:closeView()

		return
	end

	onButton(self, self.bg, var_10_0, SFX_PANEL)
	onButton(self, self.closeBtn, var_10_0, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		self:resetUseData()
		self:updateAfterModifyUseCount()

		return
	end, SFX_PANEL)
	onButton(self, self.onestepBtn, function()
		self:oneStep()
		self:updateAfterModifyUseCount()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		local var_14_0 = 0

		for iter_14_0, iter_14_1 in ipairs(self.bookIDList) do
			var_14_0 = var_14_0 + self.useCountDict[iter_14_1]
		end

		if var_14_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))
		else
			local var_14_1, var_14_2 = self:preCalcExpOverFlow(0, 0)

			if var_14_1 then
				self:emit(MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER, self.shipID, self.skillID, self.useCountDict, var_14_2)
			else
				self:emit(MetaQuickTacticsMediator.USE_TACTICS_BOOK, self.shipID, self.skillID, self.useCountDict)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function MetaQuickTacticsLayer:overlayPanel(arg_15_1)
	if arg_15_1 and self._tf then
		self:OverlayPanel(self._tf)
	elseif self._tf then
		self:UnOverlayPanel(self._tf)
	end

	return
end

function MetaQuickTacticsLayer:initSkillInfoPanel()
	local var_16_0 = self.bayProxy:getShipById(self.shipID):getMetaSkillLevelBySkillID(self.skillID)

	setText(self.skillNameText, (getSkillName(getSkillConfig(self.skillID).id)))
	setText(self.skillLevelText, "LEVEL:" .. var_16_0)
	setText(self.skillLevelUpText, "")

	local var_16_1 = self.metaProxy:getMetaTacticsInfoByShipID(self.shipID):getSkillExp(self.skillID)
	local var_16_2 = MetaCharacterConst.getMetaSkillTacticsConfig(self.skillID, var_16_0).need_exp

	setText(self.curExpText, var_16_1)
	setText(self.totalExpText, var_16_2)
	setText(self.addExpText, "[+0]")
	setSlider(self.progressBar, 0, var_16_2, var_16_1)

	return
end

function MetaQuickTacticsLayer:initUIItemList()
	self.uiitemList = UIItemList.New(self.containerTF, self.tpl)

	self.uiitemList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			arg_18_1 = arg_18_1 + 1

			self:updateTpl(arg_18_1, arg_18_2)
		end

		return
	end)
	self.uiitemList:align(#self.bookIDList)

	return
end

function MetaQuickTacticsLayer:updateUIItemList()
	self.uiitemList:align(#self.bookIDList)

	return
end

function MetaQuickTacticsLayer:updateTpl(arg_20_1, arg_20_2)
	local var_20_0 = self.bookIDList[arg_20_1]
	local var_20_1 = self:getBookItem(self.bookIDList[arg_20_1])
	local var_20_2 = self.bagProxy:getItemCountById(self.bookIDList[arg_20_1])

	if var_20_2 == 0 then
		var_20_2 = "0"
	end

	updateDrop(arg_20_2:Find("IconTpl"), (Drop.New({
		id = self.bookIDList[arg_20_1],
		type = DROP_TYPE_ITEM,
		count = var_20_2
	})))
	setText(arg_20_2:Find("Name"), (setColorStr(var_20_1:getConfig("name"), self.colorDict[var_20_1:getConfig("rarity")])))

	self.useCountTextDict[self.bookIDList[arg_20_1]] = arg_20_2:Find("TextBG/UseNum")

	onButton(self, arg_20_2:Find("MinusTenBtn"), function()
		self:tryModifyUseCount(var_20_0, -10)
		self:updateAfterModifyUseCount()

		return
	end, SFX_PANEL)
	onButton(self, arg_20_2:Find("AddTenBtn"), function()
		if not self:isMaxLevel() and not self:isCanUpMax() then
			self:tryModifyUseCount(var_20_0, 10)
			self:updateAfterModifyUseCount()
		end

		return
	end, SFX_PANEL)
	onButton(self, arg_20_2:Find("MinusBtn"), function()
		self:tryModifyUseCount(var_20_0, -1)
		self:updateAfterModifyUseCount()

		return
	end, SFX_PANEL)
	onButton(self, arg_20_2:Find("AddBtn"), function()
		if not self:isMaxLevel() and not self:isCanUpMax() then
			self:tryModifyUseCount(var_20_0, 1)
			self:updateAfterModifyUseCount()
		end

		return
	end, SFX_PANEL)

	return
end

function MetaQuickTacticsLayer:updateAfterModifyUseCount()
	for iter_25_0, iter_25_1 in ipairs(self.bookIDList) do
		setText(self.useCountTextDict[iter_25_1], self.useCountDict[iter_25_1])
	end

	local var_25_0 = self.shipID
	local var_25_1 = self.skillID
	local var_25_2 = self.bayProxy:getShipById(self.shipID):getMetaSkillLevelBySkillID(self.skillID)
	local var_25_3 = self:calcAwardExp()
	local var_25_4 = self:calcLevelWithAwardExp(var_25_3) - var_25_2

	if var_25_4 > 0 then
		setText(self.skillLevelUpText, "+" .. var_25_4)
	else
		setText(self.skillLevelUpText, "")
	end

	setText(self.addExpText, string.format("[+%d]", var_25_3))

	local var_25_5 = MetaCharacterConst.getMetaSkillTacticsConfig(var_25_1, var_25_2)

	if var_25_5 then
		local var_25_6 = self.metaProxy:getMetaTacticsInfoByShipID(var_25_0):getSkillExp(var_25_1)

		setText(self.curExpText, var_25_6)
		setText(self.totalExpText, var_25_5.need_exp)
		setSlider(self.progressBar, 0, var_25_5.need_exp, var_25_6 + var_25_3)
	end

	return
end

function MetaQuickTacticsLayer:updateAfterUse()
	setText(self.skillLevelText, "LEVEL:" .. self.bayProxy:getShipById(self.shipID):getMetaSkillLevelBySkillID(self.skillID))

	if self:isMaxLevel() then
		setText(self.curExpText, "MAX")
		setSlider(self.progressBar, 0, 1, 1)
	end

	self:updateUIItemList()

	return
end

function MetaQuickTacticsLayer:getBookItem(arg_27_1)
	return self.bagProxy:getItemById(arg_27_1) or Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = arg_27_1
	})
end

function MetaQuickTacticsLayer:resetUseData()
	self.useCountDict = self.useCountDict or {}
	self.maxCountDict = self.maxCountDict or {}

	for iter_28_0, iter_28_1 in ipairs(self.bookIDList) do
		self.useCountDict[iter_28_1] = 0
		self.maxCountDict[iter_28_1] = self.bagProxy:getItemCountById(iter_28_1)
	end

	return
end

function MetaQuickTacticsLayer:tryModifyUseCount(arg_29_1, arg_29_2)
	if self.maxCountDict[arg_29_1] <= 0 then
		return
	end

	if arg_29_2 < 0 then
		self.useCountDict[arg_29_1] = math.clamp(self.useCountDict[arg_29_1] + arg_29_2, 0, self.maxCountDict[arg_29_1])
	else
		local var_29_0 = math.min(self.maxCountDict[arg_29_1], arg_29_2)
		local var_29_1 = 0

		for iter_29_0 = 0, var_29_0 do
			if not self:preCalcExpOverFlow(var_29_1 * self.expDict[arg_29_1], 0) then
				var_29_1 = iter_29_0

				if var_29_0 <= iter_29_0 or self.maxCountDict[arg_29_1] <= self.useCountDict[arg_29_1] + var_29_1 then
					break
				end
			end
		end

		self.useCountDict[arg_29_1] = self.useCountDict[arg_29_1] + var_29_1
	end

	return
end

function MetaQuickTacticsLayer:getLevelTotalExp(arg_30_1)
	local var_30_0 = self.bayProxy:getShipById(self.shipID)
	local var_30_2 = 0

	for iter_30_0, iter_30_1 in ipairs(pg.ship_meta_skilltask.get_id_list_by_skill_ID[self.skillID]) do
		if pg.ship_meta_skilltask[iter_30_1].level < arg_30_1 then
			var_30_2 = var_30_2 + pg.ship_meta_skilltask[iter_30_1].need_exp
		end
	end

	return var_30_2
end

function MetaQuickTacticsLayer:getCurLevelExp()
	return self:getLevelTotalExp((self.bayProxy:getShipById(self.shipID):getMetaSkillLevelBySkillID(self.skillID))) + self.metaProxy:getMetaTacticsInfoByShipID(self.shipID):getSkillExp(self.skillID)
end

function MetaQuickTacticsLayer:calcAwardExp()
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(self.bookIDList) do
		var_32_0 = var_32_0 + self.useCountDict[iter_32_1] * self.expDict[iter_32_1]
	end

	return var_32_0
end

function MetaQuickTacticsLayer:calcLevelWithAwardExp(arg_33_1)
	local var_33_0 = self:getCurLevelExp() + arg_33_1
	local var_33_1 = 1

	for iter_33_0, iter_33_1 in ipairs(pg.ship_meta_skilltask.get_id_list_by_skill_ID[self.skillID]) do
		if pg.ship_meta_skilltask[iter_33_1].need_exp <= var_33_0 then
			var_33_0 = var_33_0 - pg.ship_meta_skilltask[iter_33_1].need_exp
			var_33_1 = var_33_1 + 1
		else
			break
		end
	end

	return var_33_1
end

function MetaQuickTacticsLayer:isCanUpMax()
	return self:getLevelTotalExp(pg.skill_data_template[self.skillID].max_level) <= self:getCurLevelExp() + self:calcAwardExp()
end

function MetaQuickTacticsLayer:preCalcExpOverFlow(arg_35_1, arg_35_2)
	local var_35_0 = self:getLevelTotalExp(pg.skill_data_template[self.skillID].max_level) - self:getCurLevelExp()
	local var_35_1 = false
	local var_35_2
	local var_35_3 = self:calcAwardExp() + arg_35_1

	if var_35_0 <= var_35_3 then
		var_35_2 = var_35_3 - var_35_0

		if arg_35_2 <= var_35_3 - var_35_0 then
			var_35_1 = true
		end
	end

	return var_35_1, var_35_2
end

function MetaQuickTacticsLayer:oneStep()
	if self:isMaxLevel() then
		return
	end

	self:resetUseData()

	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self.bookIDList) do
		if self:getBookItem(iter_36_1).count > 0 then
			table.insert(var_36_0, iter_36_1)
		end
	end

	table.sort(var_36_0, function(arg_37_0, arg_37_1)
		return arg_37_1 < arg_37_0
	end)

	for iter_36_2, iter_36_3 in ipairs(var_36_0) do
		local var_36_1 = self.expDict[iter_36_3]
		local var_36_2 = iter_36_2 + 1 > #var_36_0 and 0 or self.expDict[var_36_0[iter_36_2 + 1]]

		for iter_36_4 = 1, self:getBookItem(iter_36_3).count do
			if iter_36_2 < #var_36_0 and self:preCalcExpOverFlow(var_36_1, var_36_2) then
				break
			else
				self.useCountDict[iter_36_3] = self.useCountDict[iter_36_3] + 1

				if self:isCanUpMax() then
					return
				end
			end
		end
	end

	return
end

function MetaQuickTacticsLayer:isMaxLevel()
	return self.bayProxy:getShipById(self.shipID):isSkillLevelMax(self.skillID)
end

return MetaQuickTacticsLayer
