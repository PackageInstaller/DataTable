local CultureGravureRecommendAstroItem = class("CultureGravureRecommendAstroItem", ReduxView)

function CultureGravureRecommendAstroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureRecommendAstroItem:Init()
	self:InitUI()
	self:AddListeners()

	self.colorController_ = ControllerUtil.GetController(self.gameObject_.transform, "color")
	self.lockController_ = ControllerUtil.GetController(self.gameObject_.transform, "lockstate")
end

function CultureGravureRecommendAstroItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.index_ = arg_3_1
	self.id_ = arg_3_2
	self.heroID_ = arg_3_3
	self.cfg_ = HeroAstrolabeCfg[self.id_]
	self.type_ = string.sub(tostring(self.id_), -2, -2)

	self:RefreshUI()
end

function CultureGravureRecommendAstroItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.callback(HeroAstrolabeCfg[self.id_].name, GetCfgDescription(AstrolabeEffectCfg[self.id_].desc[1], 1), Vector3(self.transform_.position.x, self.transform_.position.y, self.transform_.position.z), self.rightTrans_, true)
	end)
end

function CultureGravureRecommendAstroItem:InitUI()
	self:BindCfgUI()
end

function CultureGravureRecommendAstroItem:SetClickCallBack(arg_7_1, arg_7_2)
	self.callback = arg_7_1
	self.rightTrans_ = arg_7_2
end

function CultureGravureRecommendAstroItem:RefreshUI()
	self.nameText_.text = self.cfg_.name

	self.colorController_:SetSelectedState(self.type_)

	self.isUnlock = CultureGravureData:GetHasUnlockAllAstro(self.heroID_, {
		self.id_
	})

	if self.isUnlock then
		self.lockController_:SetSelectedState("normal")
	else
		self.lockController_:SetSelectedState("lock")
	end
end

function CultureGravureRecommendAstroItem:Dispose()
	CultureGravureRecommendAstroItem.super.Dispose(self)
end

return CultureGravureRecommendAstroItem
