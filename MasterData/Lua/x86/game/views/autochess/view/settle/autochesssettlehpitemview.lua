local AutoChessSettleHpItemView = class("AutoChessSettleHpItemView", ReduxView)

function AutoChessSettleHpItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessSettleHpItemView:Init()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
end

function AutoChessSettleHpItemView:SetStatus(arg_3_1, arg_3_2)
	self.statusController_:SetSelectedState(arg_3_1)

	if arg_3_2 and arg_3_1 == AutoChessConst.HP_STATUS.HURTING then
		self.timer_ = nil
		self.timer_ = Timer.New(function()
			if self.gameObject_.activeInHierarchy then
				self.anim_:Play("U_HPItem_cx", -1, 0)
				self.statusController_:SetSelectedState(AutoChessConst.HP_STATUS.HURTING)
				self.timer_:Stop()

				self.timer_ = nil
			end
		end, 0.33, -1)

		self.timer_:Start()
	else
		SetActive(self.animGo_, false)
	end
end

function AutoChessSettleHpItemView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil

		AnimatorTools.Stop()
	end
end

return AutoChessSettleHpItemView
