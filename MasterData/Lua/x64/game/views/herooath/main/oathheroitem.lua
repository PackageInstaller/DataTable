local OathHeroItem = class("OathHeroItem", ReduxView)

function OathHeroItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function OathHeroItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
	self.oathLvStateController_ = self.controller_:GetController("oathLv")
	self.oathStateController_ = self.controller_:GetController("oathState")
end

function OathHeroItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(OATH_SELECT_HERO, self.heroID)
	end)
end

function OathHeroItem:ChangeSelect(arg_5_1)
	if arg_5_1 then
		self.selectController_:SetSelectedState("select")
	else
		self.selectController_:SetSelectedState("unselect")
	end
end

function OathHeroItem:SetData(arg_6_1)
	if self.heroID then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.OATH_HERO .. self.heroID)
	end

	self.heroID = arg_6_1

	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.OATH_HERO .. self.heroID)
	self:UpdateCanOathNotice()
end

function OathHeroItem:UpdateCanOathNotice()
	SetActive(self.canOathObj_, (manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO_CAN_COMPLETE .. self.heroID)))
end

function OathHeroItem:RefreshUI()
	self:UpdateLvUI()
	self:UpdateOathState()

	self.oathName_.text = GetI18NText(HeroCfg[self.heroID].suffix)
	self.heroImg_.sprite = HeroTools.GetHeadSprite(self.heroID)
end

function OathHeroItem:UpdateLvUI()
	local var_9_0 = OathCollectionContentData:GetOathLevel(self.heroID)

	if var_9_0 == 0 then
		self.oathLvStateController_:SetSelectedState("begin")
	elseif var_9_0 >= OathConst.OATH_MAX_LV then
		self.oathLvStateController_:SetSelectedState("max")
	else
		self.oathLvStateController_:SetSelectedState("normal")
	end

	self.oathLv_.text = OathTools.GetOathLvShowTips(var_9_0) or var_9_0
	self.oathGrayLv_.text = OathTools.GetOathLvShowTips(var_9_0) or var_9_0
end

function OathHeroItem:UpdateOathState()
	local var_10_0 = HeroData:GetHeroList()[self.heroID]

	if OathCollectionContentData:GetOathState(self.heroID) then
		self.oathStateController_:SetSelectedState("noOath")
	else
		self.oathStateController_:SetSelectedState("finishOath")
	end
end

function OathHeroItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.OATH_HERO .. self.heroID)
	OathHeroItem.super.Dispose(self)
end

return OathHeroItem
