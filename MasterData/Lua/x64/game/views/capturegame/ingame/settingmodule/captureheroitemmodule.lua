local CaptureHeroItemModule = class("CaptureHeroItemModule", ReduxView)

function CaptureHeroItemModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureHeroItemModule:Init()
	self:InitUI()
end

function CaptureHeroItemModule:InitUI()
	self:BindCfgUI()

	self.staticCtx = {
		controller = self.controller_:GetController("default0")
	}
	self.context = {
		skinId = -1
	}
	self.labelTxt_.text = GetTips("CAPTURE_GAME_IN_HOLDER")

	self:AddListener()
end

function CaptureHeroItemModule:AddListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		self:OnHeroClick()
	end)
end

function CaptureHeroItemModule:OnHeroClick()
	if CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin(self:GetCurHolderIdx()) == self.context.skinId then
		return
	end

	CaptureGameMgr:GetPlaceHolderMgr():SwitchSkin(self:GetCurHolderIdx(), self.context.skinId)
	self:Render()
end

function CaptureHeroItemModule:GetCurHolderIdx()
	return CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect()
end

function CaptureHeroItemModule:RenderView(arg_8_1)
	self.context.skinId = arg_8_1

	self:Render()
end

function CaptureHeroItemModule:Render()
	self.heroIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[self.context.skinId].picture_id)

	if CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin(self:GetCurHolderIdx()) == self.context.skinId then
		self.staticCtx.controller:SetSelectedState("nowselect")
	else
		self.staticCtx.controller:SetSelectedState("normal")
	end

	if CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(self.context.skinId) ~= -1 then
		SetActive(self.decorator_, true)
	else
		SetActive(self.decorator_, false)
	end
end

function CaptureHeroItemModule:OnEnter()
	return
end

function CaptureHeroItemModule:Dispose()
	self.staticCtx.controller = nil

	CaptureHeroItemModule.super.Dispose(self)
end

return CaptureHeroItemModule
