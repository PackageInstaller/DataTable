local EquipBreakThroughMaterialModeView = class("EquipBreakThroughMaterialModeView", ReduxView)

function EquipBreakThroughMaterialModeView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSelectDifficultyUI"
end

function EquipBreakThroughMaterialModeView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipBreakThroughMaterialModeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.btnTransform_, "conName")
	self.chooseHandler_ = handler(self, self.ChooseMode)
	self.modeUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, EquipBreakThroughMaterialModeItem)
end

function EquipBreakThroughMaterialModeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
	self.modeUIList_:StartScroll(#EquipBreakThroughMaterialDifficultyCfg.all, 1)
	self:RefreshUI()
	self:CheckMail()
end

function EquipBreakThroughMaterialModeView:OnExit()
	self.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
end

function EquipBreakThroughMaterialModeView:Dispose()
	EquipBreakThroughMaterialModeView.super.Dispose(self)

	self.chooseHandler_ = nil

	if self.modeUIList_ then
		self.modeUIList_:Dispose()

		self.modeUIList_ = nil
	end
end

function EquipBreakThroughMaterialModeView:AddListeners()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		if self.chooseIndex_ == nil then
			return
		end

		if self.chooseIndex_ == EquipBreakThroughMaterialData:GetSelectModeID() then
			self:Go("/equipBreakThroughMaterialMap", nil, true)

			return
		end

		if EquipBreakThroughMaterialData:GetSelectModeID() ~= 0 or EquipBreakThroughMaterialData:GetSelectModeID() == self.chooseIndex_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_RESET_DIFFICULTY"),
				OkCallback = function()
					self:ClickBtn()
				end
			})

			return
		else
			self:ClickBtn()
		end
	end)
end

function EquipBreakThroughMaterialModeView:CheckMail()
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL)
			end
		})
	end
end

function EquipBreakThroughMaterialModeView:ClickBtn()
	EquipBreakThroughMaterialAction.RequireEquipBTMaterialData(self.chooseIndex_, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE)
		self:Go("/equipBreakThroughMaterialMap", nil, true)
	end)
end

function EquipBreakThroughMaterialModeView:RefreshUI()
	self:ChooseMode(self.chooseIndex_)
end

function EquipBreakThroughMaterialModeView:RefreshItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.chooseIndex_)
end

function EquipBreakThroughMaterialModeView:ChooseMode(arg_16_1)
	self.chooseIndex_ = arg_16_1

	if arg_16_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

return EquipBreakThroughMaterialModeView
