local AutoChessSunglassesPopView = class("AutoChessSunglassesPopView", ReduxView)

function AutoChessSunglassesPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessSunglassesPopView:InitUI()
	self:BindCfgUI()
end

function AutoChessSunglassesPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessSunglassesPopView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Com/Activity_AutoChess_SunglassesPopUI"
end

function AutoChessSunglassesPopView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()

		local var_6_0 = AutoChessCardData:GetDesireInfo()

		if var_6_0.CardID > 0 then
			if var_6_0.State == AutoChessCardConst.DESIRE_STATE.YES then
				JumpTools.OpenPageByJump("autoChessWishPopView", {
					callback = self.backCallback_
				})
			end
		else
			self.backCallback_()
		end
	end)
end

function AutoChessSunglassesPopView:OnEnter()
	self.txtContent_.text = GetTips("AUTO_CHESS_2_SUNGLASS_POP_TIP")
	self.backCallback_ = self.params_.callback
end

function AutoChessSunglassesPopView:Dispose()
	AutoChessSunglassesPopView.super.Dispose(self)
end

return AutoChessSunglassesPopView
