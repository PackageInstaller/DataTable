local NewHeroSurpassView = class("NewHeroSurpassView", ReduxView)
local var_0_1 = {
	showPreviewState = {
		name = "showPreview",
		hide = "hide",
		show = "show"
	}
}

function NewHeroSurpassView:UIName()
	return "Widget/System/Hero_transition/HeroPrintUI"
end

function NewHeroSurpassView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroSurpassView:OnTop()
	self.surpassInfoView:OnTop()
end

function NewHeroSurpassView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewHeroSurpassView:InitUI()
	self:BindCfgUI()
	SetActive(self.root01Go_, false)

	self.showPreviewController = self.controllerexcollection_:GetController(var_0_1.showPreviewState.name)
	self.turnTableView = HeroSurpassTurntableView.New(self, self.leftRootGo_)
	self.surpassInfoView = HeroSurpassInfoView.New(self, self.root01Go_)
end

function NewHeroSurpassView:ClosePreviewView()
	JumpTools.Back()
	self:IsShowPreviewState(false)
	self.turnTableView:AgainPalyNowAni()
end

function NewHeroSurpassView:IsShowPreviewState(arg_7_1)
	if arg_7_1 then
		self.showPreviewController:SetSelectedState(var_0_1.showPreviewState.show)
	else
		self.showPreviewController:SetSelectedState(var_0_1.showPreviewState.hide)
	end
end

function NewHeroSurpassView:AddUIListener()
	self:AddBtnListener(self.overviewbtnBtn_, nil, function()
		self:IsShowPreviewState(true)
		JumpTools.OpenPageByJump("heroSurpassPreview", {
			heroID = self.heroID,
			heroInfo = self.heroInfo,
			backCallback = function()
				self:ClosePreviewView()
			end
		})
	end)
end

function NewHeroSurpassView:OnEnter()
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
	self:InitViewCallback()
	self:InitData()
	self:UpdateAvatarView()
	self.surpassInfoView:OnEnter()
	self.turnTableView:OnEnter()
end

function NewHeroSurpassView:OnGoldChange(arg_12_1)
	if arg_12_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self.surpassInfoView:OnGoldChange()
		self.turnTableView:OnGoldChange()
	end
end

function NewHeroSurpassView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelState(self.dataProxy:GetHeroUsingSkinInfo(self.heroID).id)
end

function NewHeroSurpassView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		1
	})
end

function NewHeroSurpassView:InitData()
	self.heroID = self.params_.heroId
	self.dataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.heroInfo = self.dataProxy:GetHeroData(self.heroID)

	self.surpassInfoView:SetDataProxy(self.dataProxy)
	self.surpassInfoView:SetHeroId(self.heroID)
	self.turnTableView:SetDataProxy(self.dataProxy)
	self.turnTableView:SetHeroId(self.heroID)
end

function NewHeroSurpassView:InitViewCallback()
	self.turnTableView:SetInfoShowCallBack(function(arg_17_0)
		SetActive(self.root01Go_, true)
		self.surpassInfoView:RefreshUi(arg_17_0)
	end)
end

function NewHeroSurpassView:ShowlvUpView()
	self.heroInfo = HeroData:GetHeroData(self.heroID)

	if HeroStarCfg[self.heroInfo.star].phase ~= 0 then
		JumpTools.OpenPageByJump("newHeroSurpassStarUp", {
			starID = self.heroInfo.star,
			heroID = self.heroInfo.id,
			dataProxy = self.dataProxy
		})
	else
		JumpTools.OpenPageByJump("newHeroSurpassPhaseUp", {
			starID = self.heroInfo.star,
			heroID = self.heroInfo.id
		})
	end
end

function NewHeroSurpassView:OnHeroStarUp(arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		self.turnTableView:RefreshSurpassData()
		self:ShowlvUpView()
	else
		ShowTips(arg_19_1.result)
	end
end

function NewHeroSurpassView:OnExit()
	SetActive(self.root01Go_, false)

	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function NewHeroSurpassView:Dispose()
	if self.turnTableView then
		self.turnTableView:Dispose()

		self.turnTableView = nil
	end

	if self.surpassInfoView then
		self.surpassInfoView:Dispose()

		self.surpassInfoView = nil
	end

	NewHeroSurpassView.super.Dispose(self)
end

function NewHeroSurpassView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.collect_monster_background_pos.value[1], GameDisplayCfg.collect_monster_background_pos.value[2], 10)
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.collect_monster_background_pos.scale[1], GameDisplayCfg.collect_monster_background_pos.scale[2], GameDisplayCfg.collect_monster_background_pos.scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

return NewHeroSurpassView
