local OathMainBtnContent = class("OathMainBtnContent", ReduxView)

function OathMainBtnContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function OathMainBtnContent:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.lvInfo_ = OathLvInfo.New(self.lvGo_)
	self.oathController_ = self.controller_:GetController("oathState")
end

function OathMainBtnContent:AddListeners()
	self:AddBtnListener(self.contentBtn_, nil, function()
		if OathTools.IsOath(self.heroID) then
			JumpTools.OpenPageByJump("/oathDetailsView", {
				heroID = self.heroID
			})
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(self.heroID)))
		end
	end)
	self:AddBtnListener(self.equityBtn_, nil, function()
		JumpTools.OpenPageByJump("oathEquityPopView", {
			heroID = self.heroID
		})
	end)
	self:AddBtnListener(self.bookBtn_, nil, function()
		if OathTools.IsOath(self.heroID) then
			JumpTools.OpenPageByJump("oathBookView", {
				isMainViewEnter = true,
				heroID = self.heroID
			})
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(self.heroID)))
		end
	end)
	self:AddBtnListener(self.photoBtn_, nil, function()
		if OathTools.IsOath(self.heroID) then
			OathLaunchScene(WeddingCfg[self.heroID].wedding_scene, self.heroID, WeddingCfg[self.heroID].skin_id, OathConst.OATH_SCENE_MODE.SHARE)
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(self.heroID)))
		end
	end)
	self:AddBtnListener(self.nameBtn_, nil, function()
		JumpTools.OpenPageByJump("/oathNamePopView", {
			heroID = self.heroID
		})
	end)
end

function OathMainBtnContent:SetData(arg_9_1)
	if self.heroID then
		manager.redPoint:unbindUIandKey(self.contentBtn_.transform, RedPointConst.OATH_CONTENT .. self.heroID)
	end

	self.heroID = arg_9_1

	self:RefreshUI()
end

function OathMainBtnContent:RefreshUI()
	self:RefreshNameUI()
	self.lvInfo_:SetData(self.heroID)

	if OathCollectionContentData:GetOathState(self.heroID) then
		self.oathController_:SetSelectedState("oath")

		self.contentAni_.enabled = true
	else
		self.oathController_:SetSelectedState("noOath")

		self.contentAni_.enabled = false
	end

	manager.redPoint:bindUIandKey(self.contentBtn_.transform, RedPointConst.OATH_CONTENT .. self.heroID)
end

function OathMainBtnContent:RefreshNameUI()
	self.oathName_.text = HeroTools.GetHeroName(self.heroID)
end

function OathMainBtnContent:OnExit()
	manager.redPoint:unbindUIandKey(self.contentBtn_.transform, RedPointConst.OATH_CONTENT .. self.heroID)
	self.lvInfo_:OnExit()
	self:RemoveAllEventListener()
end

function OathMainBtnContent:Dispose()
	if self.lvInfo_ then
		self.lvInfo_:Dispose()

		self.lvInfo_ = nil
	end

	self.super.Dispose(self)
end

return OathMainBtnContent
