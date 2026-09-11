local AutoChessSettleTrophyItemView = class("AutoChessSettleTrophyItemView", ReduxView)

function AutoChessSettleTrophyItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessSettleTrophyItemView:Init()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
end

function AutoChessSettleTrophyItemView:SetStatus(arg_3_1)
	self.statusController_:SetSelectedState(arg_3_1)

	if arg_3_1 == AutoChessConst.TROPHY_STATUS.NEW then
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		self.timer = nil
		self.timer = Timer.New(function()
			if self.gameObject_.activeInHierarchy then
				self.anim_:Play("U_TrophyItem_cx", -1, 0)
				self.timer:Stop()

				self.timer = nil
			end
		end, 0.33, -1)

		self.timer:Start()
	end
end

function AutoChessSettleTrophyItemView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function AutoChessSettleTrophyItemView:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return AutoChessSettleTrophyItemView
