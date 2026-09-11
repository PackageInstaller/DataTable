local AutoChessPVESelectStageTabItem = class("AutoChessPVESelectStageTabItem", ReduxView)

function AutoChessPVESelectStageTabItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.clickFun_ = arg_1_2

	self:Init()
end

function AutoChessPVESelectStageTabItem:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessPVESelectStageTabItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if AutoChessTools.IsAreaUnlock(self.areaID_) then
			if self.clickFun_ then
				self.clickFun_(self.areaID_)
			end
		else
			ShowTips("AUTO_CHESS_LATTER_LEVEL_LOCKED")
		end
	end)
end

function AutoChessPVESelectStageTabItem:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function AutoChessPVESelectStageTabItem:InitController()
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.completeController_ = self.mainControllerEx_:GetController("Completed")

	self.lockController_:SetSelectedState("lock")
end

function AutoChessPVESelectStageTabItem:SetData(arg_7_1)
	self.areaID_ = arg_7_1

	if not AutoChessAreaCfg[self.areaID_] then
		return
	end

	self.text2_.text = AutoChessAreaCfg[self.areaID_].name

	if AutoChessTools.IsAreaUnlock(self.areaID_) then
		if (getData("auto_chess_stage_item", "area_" .. self.areaID_) or 0) ~= 0 then
			self.lockController_:SetSelectedState("unlock")
		else
			local var_7_0 = 1

			saveData("auto_chess_stage_item", "area_" .. self.areaID_, 1)

			self.unlockTimer_ = Timer.New(function()
				if var_7_0 == 1 then
					self.unlockAnim_:Play("U_nd01_unlook_01", 0, 0)

					var_7_0 = var_7_0 + 1
				else
					self.lockController_:SetSelectedState("unlock")
				end
			end, 0.8, 2)

			self.unlockTimer_:Start()
		end
	else
		self.lockController_:SetSelectedState("lock")
	end

	if AutoChessTools.IsAreaComplete(self.areaID_) then
		self.completeController_:SetSelectedState("on")
	else
		self.completeController_:SetSelectedState("off")
	end
end

function AutoChessPVESelectStageTabItem:SetSelect(arg_9_1)
	if self.areaID_ == arg_9_1 then
		self.selectController_:SetSelectedState("select")
	else
		self.selectController_:SetSelectedState("notselect")
	end
end

function AutoChessPVESelectStageTabItem:Dispose()
	if self.unlockTimer_ then
		self.unlockTimer_:Stop()

		self.unlockTimer_ = nil
	end

	AutoChessPVESelectStageTabItem.super.Dispose(self)
end

return AutoChessPVESelectStageTabItem
