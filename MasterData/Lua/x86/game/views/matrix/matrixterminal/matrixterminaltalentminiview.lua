local MartixTerminalTalentView = class("MartixTerminalTalentView", ReduxView)

function MartixTerminalTalentView:UIBackCount()
	return 3
end

function MartixTerminalTalentView:UIName()
	return "UI/Matrix/Terminal/MatrixTerminalTalentMiniUI"
end

function MartixTerminalTalentView:UIParent()
	return manager.ui.uiMain.transform
end

function MartixTerminalTalentView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MartixTerminalTalentView:InitUI()
	self:BindCfgUI()

	self.giftDataList = {}

	for iter_5_0, iter_5_1 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group) do
		self.giftDataList[iter_5_0] = MatrixTools.GetGiftListByGroup(iter_5_0)
	end

	self.terminalList_ = LuaList.New(handler(self, self.IndexItem), self.m_termianlList, MatrixTerminalGroupItem)
	self.toggles_ = {}

	for iter_5_2 = 1, self.m_switchContainer.childCount do
		table.insert(self.toggles_, self.m_switchContainer:GetChild(iter_5_2 - 1):GetComponent(typeof(Toggle)))
	end

	self.showRightInfoCnotroller_ = ControllerUtil.GetController(self.transform_, "showRightInfo")
end

function MartixTerminalTalentView:AddUIListener()
	for iter_6_0, iter_6_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_6_1, function(arg_7_0)
			if arg_7_0 then
				self:SelectGroup(iter_6_0)
			end
		end)
	end

	self:AddBtnListener(self.m_levelBtn, nil, function()
		JumpTools.OpenPageByJump("matrixTerminalLevel")
	end)
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		self:OnItemClick(0)
	end))
	self:AddBtnListener(self.m_infoMask, nil, function()
		self:OnItemClick(0)
	end)
end

function MartixTerminalTalentView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function MartixTerminalTalentView:OnEnter()
	self.data = clone(MatrixData:GetCurrentTerminalGifi())
	self.allPoint = 0
	self.allPoint = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].point
	self.hasPoint = self.allPoint - self:GetUsePoint()
	self.m_giftLab.text = self.hasPoint
	self.toggles_[1].isOn = true

	self:SelectGroup(1)

	local var_13_0 = MatrixData:GetTerminalLevel()
	local var_13_1 = MatrixData:GetTerminalExp()

	self.m_levelLab.text = "" .. var_13_0

	if var_13_0 == #MatrixTerminalLevelCfg.all then
		self.m_expSlider.value = 1
		self.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", MatrixTerminalLevelCfg[var_13_0].exp - MatrixTerminalLevelCfg[var_13_0 - 1].exp, MatrixTerminalLevelCfg[var_13_0].exp - MatrixTerminalLevelCfg[var_13_0 - 1].exp)
	else
		self.m_expSlider.value = var_13_1 / (MatrixTerminalLevelCfg[var_13_0 + 1].exp - MatrixTerminalLevelCfg[var_13_0].exp)
		self.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", var_13_1, MatrixTerminalLevelCfg[var_13_0 + 1].exp - MatrixTerminalLevelCfg[var_13_0].exp)
	end
end

function MartixTerminalTalentView:OnExit()
	self.curPage = nil

	self:OnItemClick(0)
end

function MartixTerminalTalentView:RefreshInfo()
	if not self.data[self.curId] then
		-- block empty
	end

	local var_15_1 = MatrixTerminalGiftCfg[self.curId]
	local var_15_2 = self.data[self.curId] or 0

	self.m_infoNameLab.text = GetI18NText(var_15_1.name)
	self.m_infoLvLab.text = var_15_2 == 0 and 1 or var_15_2
	self.m_infoDesLab.text = MatrixDescCfg[var_15_1.desc_list[var_15_2 == 0 and 1 or var_15_2]] and GetI18NText(MatrixDescCfg[var_15_1.desc_list[var_15_2 == 0 and 1 or var_15_2]].desc) or ""
	self.m_infoIconImg.sprite = getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixTerminal/" .. var_15_1.icon)
end

function MartixTerminalTalentView:OnItemClick(arg_16_1, arg_16_2)
	if arg_16_1 == 0 and self.selectId == arg_16_1 then
		return
	end

	self.selectId = arg_16_1

	local var_16_0 = false

	if arg_16_1 ~= 0 then
		self.showRightInfoCnotroller_:SetSelectedIndex(1)

		self.curId = arg_16_1

		self:RefreshInfo(arg_16_1)

		var_16_0 = true
	else
		self.showRightInfoCnotroller_:SetSelectedIndex(0)

		self.curId = nil
		var_16_0 = false
	end

	for iter_16_0, iter_16_1 in pairs((self.terminalList_:GetItemList())) do
		iter_16_1:SetChoice(self.selectId)
		iter_16_1:SetItemScrollMask(var_16_0)
	end

	self:SetSelect(arg_16_2)
end

function MartixTerminalTalentView:SelectGroup(arg_17_1)
	self:OnItemClick(0)

	if arg_17_1 == self.curPage then
		return
	end

	self.curPage = arg_17_1
	self.list = self.giftDataList[arg_17_1] or {}

	self.terminalList_:StartScrollByPosition(#self.list, Vector2.New(0, 0))
end

function MartixTerminalTalentView:SetSelect(arg_18_1)
	if arg_18_1 then
		self.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -self.m_scrollContent.transform:InverseTransformPoint((arg_18_1.transform_.parent:TransformPoint(Vector3(0, 0, 0)))).x + 100, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			self.m_scrollContent.transform.localPosition = Vector3(arg_19_0, 0, 0)
		end))
	else
		self.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end
end

function MartixTerminalTalentView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function MartixTerminalTalentView:IndexItem(arg_21_1, arg_21_2)
	arg_21_2:Refresh(arg_21_1, self.list[arg_21_1], self.data, self.selectId, self.hasPoint)
	arg_21_2:RegistCallBack(handler(self, self.OnItemClick))
end

function MartixTerminalTalentView:GetUsePoint()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self.data) do
		for iter_22_2 = 1, iter_22_1 do
			var_22_0 = var_22_0 + MatrixTerminalGiftCfg[iter_22_0].cost[iter_22_2]
		end
	end

	return var_22_0
end

function MartixTerminalTalentView:Dispose()
	self.terminalList_:Dispose()
	MartixTerminalTalentView.super.Dispose(self)
end

return MartixTerminalTalentView
