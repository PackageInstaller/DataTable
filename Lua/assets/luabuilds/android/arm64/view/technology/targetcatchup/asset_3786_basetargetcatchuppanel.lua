local BaseTargetCatchupPanel = class("BaseTargetCatchupPanel", import("...base.BaseUI"))

BaseTargetCatchupPanel.SELECT_CHAR_LIGHT_FADE_TIME = 0.3

function BaseTargetCatchupPanel:Ctor(arg_1_1, arg_1_2)
	BaseTargetCatchupPanel.super.Ctor(self)
	PoolMgr.GetInstance():GetUI(self:getUIName(), true, function(arg_2_0)
		arg_2_0.transform:SetParent(arg_1_1, false)
		self:onUILoaded(arg_2_0)

		if arg_1_2 then
			arg_1_2()
		end

		return
	end)

	return
end

function BaseTargetCatchupPanel:getUIName()
	assert(false)

	return ""
end

function BaseTargetCatchupPanel:init()
	return
end

function BaseTargetCatchupPanel:initData()
	self.curSelectedIndex = 0
	self.technologyProxy = getProxy(TechnologyProxy)
	self.bayProxy = getProxy(BayProxy)
	self.bagProxy = getProxy(BagProxy)
	self.configCatchup = pg.technology_catchup_template
	self.charIDList = self.configCatchup[self.tecID].char_choice
	self.urList = self.configCatchup[self.tecID].ur_char
	self.state = self.technologyProxy:getCatchupState(self.tecID)

	return
end

function BaseTargetCatchupPanel:initUI()
	self.choosePanel = self._tf:Find("ChoosePanel")
	self.selectedImgUIItemList = UIItemList.New(self.choosePanel:Find("SelectedImgList"), (self.choosePanel:Find("SelectedImgTpl")))

	self.selectedImgUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = arg_7_2:Find("Selected")

			setActive(var_7_0, arg_7_1 == self.curSelectedIndex)

			if arg_7_1 == self.curSelectedIndex then
				setImageAlpha(var_7_0, 0)
				self:updateProgress(self.charIDList[self.curSelectedIndex])
				self:managedTween(LeanTween.alpha, nil, rtf(var_7_0), 1, BaseTargetCatchupPanel.SELECT_CHAR_LIGHT_FADE_TIME):setFrom(0)
			end
		end

		return
	end)
	self.selectedImgUIItemList:align(#self.charIDList)

	self.charUIItemList = UIItemList.New(self.choosePanel:Find("CharList"), (self.choosePanel:Find("CharTpl")))

	self.charUIItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_8_1 = arg_8_1 + 1

			self:updateCharTpl(arg_8_1, arg_8_2)
			onButton(self, arg_8_2, function()
				if arg_8_1 ~= self.curSelectedIndex then
					self.curSelectedIndex = arg_8_1

					self.selectedImgUIItemList:align(#self.charIDList)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.charUIItemList:align(#self.charIDList)

	self.confirmBtn = self.choosePanel:Find("ConfirmBtn")

	onButton(self, self.confirmBtn, function()
		if self.curSelectedIndex and self.curSelectedIndex ~= 0 then
			local var_10_0 = self.charIDList[self.curSelectedIndex]

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tec_target_catchup_select_tip", ShipGroup.getDefaultShipNameByGroupID(self.charIDList[self.curSelectedIndex])),
				onYes = function()
					pg.m02:sendNotification(GAME.SELECT_TEC_TARGET_CATCHUP, {
						tecID = self.tecID,
						charID = var_10_0
					})

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	self.proTitle = self.choosePanel:Find("ProgressTitle/Text")

	setText(self.proTitle, i18n("tec_target_catchup_progress"))

	self.ssrProgress = self.choosePanel:Find("ProgressTitle/Progress_SSR")
	self.urProgress = self.choosePanel:Find("ProgressTitle/Progress_UR")
	self.showPanel = self._tf:Find("ShowPanel")
	self.showBG = self.showPanel:Find("BG")
	self.nameText = self.showPanel:Find("NameText")
	self.progressText = self.showPanel:Find("Progress/ProgressText")
	self.tipText = self.showPanel:Find("Progress/Text")

	setText(self.tipText, i18n("tec_target_catchup_progress"))

	self.selectedImg = self.showPanel:Find("Selected")
	self.giveupBtn = self.showPanel:Find("GiveupBtn")
	self.finishedImg = self.showPanel:Find("Finished")
	self.helpBtn = self._tf:Find("HelpBtn")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tec_target_catchup_help_tip.tip
		})

		return
	end, SFX_PANEL)
	setText(self.choosePanel:Find("FinishAll/BG/Text"), i18n("tec_target_catchup_all_finish_tip"))
	setText(self.choosePanel:Find("CharListBG/SSRTag/Text"), i18n("tec_target_catchup_pry_char"))

	if #self.urList > 0 then
		setText(self.choosePanel:Find("FinishPart/BG/Text"), i18n("tec_target_catchup_dr_finish_tip"))
		setText(self.choosePanel:Find("CharListBG/URTag/Text"), i18n("tec_target_catchup_dr_char"))
	end

	for iter_6_0, iter_6_1 in ipairs(self.urList) do
		setText(self.choosePanel:Find("Finish_" .. iter_6_1 .. "/BG/Text"), i18n("tec_target_catchup_dr_finish_tip"))
	end

	return
end

function BaseTargetCatchupPanel:updateTargetCatchupPage()
	self.state = self.technologyProxy:getCatchupState(self.tecID)

	if self.state == TechnologyCatchup.STATE_CATCHUPING then
		self:updateShowPanel()
	else
		self:updateChoosePanel()
	end

	return
end

function BaseTargetCatchupPanel:updateCharTpl(arg_14_1, arg_14_2)
	setText(arg_14_2:Find("PrintNum/Text"), i18n("tec_target_need_print"))

	local var_14_0 = arg_14_2:Find("NameText")
	local var_14_1 = arg_14_2:Find("LevelText")
	local var_14_2 = arg_14_2:Find("NotGetTag")
	local var_14_3 = self.charIDList[arg_14_1]
	local var_14_4 = self.bayProxy:findShipByGroup(self.charIDList[arg_14_1])

	setText(arg_14_2:Find("PrintNum/NumText"), (math.max(self.configCatchup[self.tecID].blueprint_max[arg_14_1] - (var_14_4 and math.floor(self:getShipBluePrintCurExp((self.technologyProxy:getBluePrintVOByGroupID(self.charIDList[arg_14_1]))) / Item.getConfigData(pg.ship_data_blueprint[self.charIDList[arg_14_1]].strengthen_item).usage_arg[1]) or 0) - self.bagProxy:getItemCountById(pg.ship_data_blueprint[self.charIDList[arg_14_1]].strengthen_item), 0)))
	setText(var_14_0, (ShipGroup.getDefaultShipNameByGroupID(var_14_3)))
	setActive(var_14_1, var_14_4)
	setActive(var_14_2, not var_14_4)

	if var_14_4 then
		local var_14_5 = self.technologyProxy:getBluePrintVOByGroupID(var_14_3)

		setText(var_14_1, "Lv. " .. var_14_5.level .. "/" .. var_14_5:getMaxLevel())
	end

	return
end

function BaseTargetCatchupPanel:updateShowPanel()
	setActive(self.showPanel, true)
	setActive(self.choosePanel, false)

	local var_15_0 = self.technologyProxy:getCurCatchupTecInfo()

	setImageSprite(self.showBG, LoadSprite("TecCatchup/selbg" .. var_15_0.groupID, var_15_0.groupID))
	setText(self.nameText, (ShipGroup.getDefaultShipNameByGroupID(var_15_0.groupID)))
	setText(self.progressText, var_15_0.printNum .. "/" .. self:getMaxNum(var_15_0.groupID))

	local var_15_2 = self.state == TechnologyCatchup.STATE_FINISHED_ALL

	setActive(self.finishedImg, self.state == TechnologyCatchup.STATE_FINISHED_ALL)
	setActive(self.selectedImg, not var_15_2)
	onButton(self, self.selectedImg, function()
		self:updateChoosePanel()
		setActive(self.choosePanel:Find("ProgressTitle"), false)

		return
	end, SFX_PANEL)

	return
end

function BaseTargetCatchupPanel:updateChoosePanel()
	setActive(self.showPanel, false)
	setActive(self.choosePanel, true)

	local var_17_0 = self.technologyProxy:getCatchupData(self.tecID)

	if self.state == TechnologyCatchup.STATE_FINISHED_ALL then
		setActive(self.choosePanel:Find("FinishAll"), true)
		setActive(self.choosePanel:Find("ProgressTitle"), false)
	elseif #self.urList > 0 then
		setActive(self.choosePanel:Find("FinishAll"), false)
		setActive(self.choosePanel:Find("FinishPart"), (var_17_0:isFinishSSR()))

		for iter_17_0, iter_17_1 in ipairs(self.urList) do
			setActive(self.choosePanel:Find("Finish_" .. iter_17_1), (var_17_0:isFinish(iter_17_1)))
		end
	end

	return
end

function BaseTargetCatchupPanel:updateProgress(arg_18_1)
	setActive(self.choosePanel:Find("ProgressTitle"), true)

	local var_18_0 = self.technologyProxy:getCatchupData(self.tecID):getTargetNum(arg_18_1)
	local var_18_1 = self:getMaxNum(arg_18_1)

	if self:isUR(arg_18_1) then
		setActive(self.urProgress, true)
		setActive(self.ssrProgress, false)
		setText(self.urProgress:Find("Text"), var_18_0 .. "/" .. var_18_1)
	else
		setActive(self.urProgress, false)
		setActive(self.ssrProgress, true)
		setText(self.ssrProgress:Find("Text"), var_18_0 .. "/" .. var_18_1)
	end

	return
end

function BaseTargetCatchupPanel:isUR(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.urList) do
		if arg_19_1 == iter_19_1 then
			return true
		end
	end

	return false
end

function BaseTargetCatchupPanel:getMaxNum(arg_20_1)
	return (self:isUR(arg_20_1) or nil) and (pg.technology_catchup_template[self.tecID].obtain_max_per_ur or pg.technology_catchup_template[self.tecID].obtain_max)
end

function BaseTargetCatchupPanel:willExit()
	PoolMgr.GetInstance():ReturnUI(self:getUIName(), self._go)

	return
end

function BaseTargetCatchupPanel:getShipBluePrintCurExp(arg_22_1)
	local var_22_0 = arg_22_1:getConfig("strengthen_effect")
	local var_22_1 = arg_22_1:getConfig("fate_strengthen")
	local var_22_2 = 0 + arg_22_1.exp

	for iter_22_0 = 1, arg_22_1.level do
		var_22_2 = var_22_2 + pg.ship_strengthen_blueprint[var_22_0[iter_22_0]].need_exp
	end

	for iter_22_1 = 1, arg_22_1.fateLevel do
		var_22_2 = var_22_2 + pg.ship_strengthen_blueprint[var_22_1[iter_22_1]].need_exp
	end

	return var_22_2
end

return BaseTargetCatchupPanel
