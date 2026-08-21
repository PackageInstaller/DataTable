local var_0_0 = class("NewHeroSurpassView", ReduxView)
local var_0_1 = {
	showPreviewState = {
		name = "showPreview",
		hide = "hide",
		show = "show"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_transition/HeroPrintUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnTop(arg_3_0)
	arg_3_0.surpassInfoView:OnTop()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	SetActive(arg_5_0.root01Go_, false)

	arg_5_0.showPreviewController = arg_5_0.controllerexcollection_:GetController(var_0_1.showPreviewState.name)
	arg_5_0.turnTableView = HeroSurpassTurntableView.New(arg_5_0, arg_5_0.leftRootGo_)
	arg_5_0.surpassInfoView = HeroSurpassInfoView.New(arg_5_0, arg_5_0.root01Go_)
end

function var_0_0.ClosePreviewView(arg_6_0)
	JumpTools.Back()
	arg_6_0:IsShowPreviewState(false)
	arg_6_0.turnTableView:AgainPalyNowAni()
end

function var_0_0.IsShowPreviewState(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.showPreviewController:SetSelectedState(var_0_1.showPreviewState.show)
	else
		arg_7_0.showPreviewController:SetSelectedState(var_0_1.showPreviewState.hide)
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.overviewbtnBtn_, nil, function()
		arg_8_0:IsShowPreviewState(true)
		JumpTools.OpenPageByJump("heroSurpassPreview", {
			heroID = arg_8_0.heroID,
			heroInfo = arg_8_0.heroInfo,
			backCallback = function()
				arg_8_0:ClosePreviewView()
			end
		})
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_11_0, arg_11_0.OnGoldChange))
	arg_11_0:InitViewCallback()
	arg_11_0:InitData()
	arg_11_0:UpdateAvatarView()
	arg_11_0.surpassInfoView:OnEnter()
	arg_11_0.turnTableView:OnEnter()
end

function var_0_0.OnGoldChange(arg_12_0, arg_12_1)
	if arg_12_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_12_0.surpassInfoView:OnGoldChange()
		arg_12_0.turnTableView:OnGoldChange()
	end
end

function var_0_0.UpdateAvatarView(arg_13_0)
	local var_13_0 = arg_13_0.dataProxy:GetHeroUsingSkinInfo(arg_13_0.heroID).id

	manager.heroRaiseTrack:SetModelState(var_13_0)
end

function var_0_0.CameraEnter(arg_14_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		1
	})
end

function var_0_0.InitData(arg_15_0)
	arg_15_0.heroID = arg_15_0.params_.heroId
	arg_15_0.dataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_15_0.heroInfo = arg_15_0.dataProxy:GetHeroData(arg_15_0.heroID)

	arg_15_0.surpassInfoView:SetDataProxy(arg_15_0.dataProxy)
	arg_15_0.surpassInfoView:SetHeroId(arg_15_0.heroID)
	arg_15_0.turnTableView:SetDataProxy(arg_15_0.dataProxy)
	arg_15_0.turnTableView:SetHeroId(arg_15_0.heroID)
end

function var_0_0.InitViewCallback(arg_16_0)
	arg_16_0.turnTableView:SetInfoShowCallBack(function(arg_17_0)
		SetActive(arg_16_0.root01Go_, true)
		arg_16_0.surpassInfoView:RefreshUi(arg_17_0)
	end)
end

function var_0_0.ShowlvUpView(arg_18_0)
	arg_18_0.heroInfo = HeroData:GetHeroData(arg_18_0.heroID)

	local var_18_0 = arg_18_0.heroInfo.star

	if HeroStarCfg[var_18_0].phase ~= 0 then
		JumpTools.OpenPageByJump("newHeroSurpassStarUp", {
			starID = var_18_0,
			heroID = arg_18_0.heroInfo.id,
			dataProxy = arg_18_0.dataProxy
		})
	else
		JumpTools.OpenPageByJump("newHeroSurpassPhaseUp", {
			starID = var_18_0,
			heroID = arg_18_0.heroInfo.id
		})
	end
end

function var_0_0.OnHeroStarUp(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		arg_19_0.turnTableView:RefreshSurpassData()
		arg_19_0:ShowlvUpView()
	else
		ShowTips(arg_19_1.result)
	end
end

function var_0_0.OnExit(arg_20_0)
	SetActive(arg_20_0.root01Go_, false)

	if arg_20_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_20_0.backGround_, ASSET_TYPE.SCENE)
	end

	arg_20_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.turnTableView then
		arg_21_0.turnTableView:Dispose()

		arg_21_0.turnTableView = nil
	end

	if arg_21_0.surpassInfoView then
		arg_21_0.surpassInfoView:Dispose()

		arg_21_0.surpassInfoView = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.InitBackScene(arg_22_0)
	local var_22_0 = "UI/Common/BackgroundQuad"

	arg_22_0.backGround_ = manager.resourcePool:Get(var_22_0, ASSET_TYPE.SCENE)
	arg_22_0.backGroundTrs_ = arg_22_0.backGround_.transform

	arg_22_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_22_1
	local var_22_2
	local var_22_3 = GameDisplayCfg.collect_monster_background_pos.value
	local var_22_4 = CameraCfg.enemyFile.pictureName

	arg_22_0.backGroundTrs_.localPosition = Vector3(var_22_3[1], var_22_3[2], 10)
	arg_22_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_22_5 = GameDisplayCfg.collect_monster_background_pos.scale

	arg_22_0.backGroundTrs_.localScale = Vector3(var_22_5[1], var_22_5[2], var_22_5[3])
	arg_22_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.Bg.path .. var_22_4)
end

return var_0_0
