local SpringFestivalBuffItem = class("SpringFestivalBuffItem", ReduxView)

function SpringFestivalBuffItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.TalentID = arg_1_2

	self:InitUI()
end

function SpringFestivalBuffItem:InitUI()
	self:BindCfgUI()

	self.lockStateController = self.controllerexcollection_:GetController("lock")
	self.selectStateController = self.controllerexcollection_:GetController("select")
	self.baseStateController = self.controllerexcollection_:GetController("base")

	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack then
			self.clickCallBack(self.TalentID)
		end
	end)
end

function SpringFestivalBuffItem:GetTalentID()
	return self.TalentID
end

function SpringFestivalBuffItem:SetClickCallBack(arg_5_1)
	self.clickCallBack = arg_5_1
end

function SpringFestivalBuffItem:PlayUnLockAni()
	self.ani_:Play("UI_SandPlay_3_11_ZumaTalent_UnLock")
end

function SpringFestivalBuffItem:UpdateBaseState()
	if self.TalentID == 2002 then
		self.baseStateController:SetSelectedState("1")
	elseif self.TalentID == 2007 then
		self.baseStateController:SetSelectedState("2")
	elseif self.TalentID == 2012 then
		self.baseStateController:SetSelectedState("3")
	end
end

function SpringFestivalBuffItem:UpdateSelectState(arg_8_1)
	self.selectStateController:SetSelectedState(arg_8_1 and "on" or "off")
end

function SpringFestivalBuffItem:RefreshUI(arg_9_1)
	if arg_9_1 then
		self.TalentID = arg_9_1
	end

	if self.iconImg_ then
		self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. ActivityZumaTalentCfg[self.TalentID].icon)
	end

	self.lockStateController:SetSelectedState(self:GetIsCanUse() and "unlock" or "lock")
end

function SpringFestivalBuffItem:GetIsCanUse()
	return ZumaData:GetZumaTalentIsOpen(self.TalentID)
end

function SpringFestivalBuffItem:Dispose()
	SpringFestivalBuffItem.super.Dispose(self)
end

return SpringFestivalBuffItem
