local BloodCardInfoView = class("BloodCardInfoView", ReduxView)

function BloodCardInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()

	self.specialController_ = self.controller_:GetController("special")
	self.goldController_ = self.controller_:GetController("gold")
	self.needPointController_ = self.controller_:GetController("needPoint")
	self.emptyController_ = self.controller_:GetController("empty")
	self.noneController_ = self.controller_:GetController("none")
end

function BloodCardInfoView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function BloodCardInfoView:AddUIListener()
	return
end

function BloodCardInfoView:RefreshUI()
	if self.id_ and self.id_ ~= 0 then
		self.cardNameText_.text = self.cfg_.name
		self.typeDescText_.text = BloodCardConst.TYPE_DESC[self.cfg_.type]
		self.powerNumText_.text = self.cfg_.power
		self.sepcialDescText_.text = self.cfg_.desc

		if self.cfg_.type == 2 then
			self.needPointController_:SetSelectedState("overlay")
		else
			self.needPointController_:SetSelectedState(tostring(self.cfg_.need_point))
		end

		self.goldController_:SetSelectedState(tostring(self.cfg_.kind == BloodCardConst.CARD_KIND.GOLD))
		self.specialController_:SetSelectedState(tostring(#self.cfg_.effect_list ~= 0))
		self.noneController_:SetSelectedState(tostring(self.cfg_.kind ~= BloodCardConst.CARD_KIND.GOLD and #self.cfg_.effect_list == 0))
	end
end

function BloodCardInfoView:SetData(arg_5_1)
	self.id_ = arg_5_1
	self.cfg_ = BloodCardGameCardCfg[self.id_]

	self:RefreshUI()
	self.emptyController_:SetSelectedState(tostring(not arg_5_1 or arg_5_1 == 0))

	self.lockText_.text = self.cfg_.acquire_text ~= "" and self.cfg_.acquire_text or GetTips("ACTIVITY_BLOOD_CARD_GAME_CARD_LOCK")
end

function BloodCardInfoView:SetState(arg_6_1)
	self.emptyController_:SetSelectedState(arg_6_1)
end

function BloodCardInfoView:Dispose()
	BloodCardInfoView.super.Dispose(self)
end

return BloodCardInfoView
