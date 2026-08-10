local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("NewHeroAstrolabePage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.infoSGo_ = {}
	arg_3_0.desItemList = {}
	arg_3_0.isSelfController_ = arg_3_0.controller_:GetController("isSelf")
	arg_3_0.isPreviewController_ = arg_3_0.controller_:GetController("isPreview")
end

function var_0_1.AddUIListener(arg_4_0)
	if arg_4_0.astrolabeInfoView_ then
		arg_4_0.astrolabeInfoView_:SetClickAnimaton(true)
	end

	arg_4_0:AddBtnListener(arg_4_0.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("/astrolabeAdjust", {
			heroId = arg_4_0.heroInfo_.id,
			selectPos = {
				0
			},
			astrolabe = arg_4_0.astrolabeInfoView_,
			heroProxy = arg_4_0.heroViewProxy_
		})
	end)
end

function var_0_1.SetHeroInfo(arg_6_0, arg_6_1)
	arg_6_0.heroInfo_ = arg_6_1

	arg_6_0:UpdateView()
end

function var_0_1.HideMaskMessage(arg_7_0)
	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	arg_8_0.super.Show(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_1.IsCanBackAnimation(arg_9_0)
	if gameContext:GetLastOpenPage() ~= "astrolabeAdjust" then
		return false
	end

	if arg_9_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return gameContext:IsBack("/heroPreviewChange") > 0
	else
		return gameContext:IsBack("/newHero") > 0
	end
end

function var_0_1.ShowBackAnimation(arg_10_0)
	if arg_10_0.astrolabeInfoView_ then
		arg_10_0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.HeroInfo)
	end
end

function var_0_1.UpdateView(arg_11_0)
	if arg_11_0.heroInfo_ and arg_11_0.heroViewProxy_ then
		arg_11_0:RefreshAstrolabeInfo()
		arg_11_0:ShowBackAnimation()

		arg_11_0.viewDataType = arg_11_0.heroViewProxy_:GetViewDataType()

		arg_11_0:RefreshAstrolabeEffect()
	end
end

function var_0_1.SelectItem(arg_12_0, arg_12_1)
	if arg_12_0.heroViewProxy_ and not arg_12_0.heroViewProxy_.notGotoAstrolabeAdjust then
		return
	end

	local var_12_0 = arg_12_1:GetItemInfo()

	if arg_12_0.astrolabeInfoView_ then
		arg_12_0.astrolabeInfoView_:SetClickAnimaton(true)
	end

	JumpTools.OpenPageByJump("/astrolabeAdjust", {
		heroId = arg_12_0.heroInfo_.id,
		selectPos = {
			var_12_0.posX,
			var_12_0.posY
		},
		heroProxy = arg_12_0.heroViewProxy_,
		astrolabe = arg_12_0.astrolabeInfoView_
	})
end

function var_0_1.RefreshAstrolabeInfo(arg_13_0)
	if arg_13_0.heroInfo_ and arg_13_0.heroViewProxy_ then
		arg_13_0.currentHeroID = arg_13_0.heroInfo_ and arg_13_0.heroInfo_.id or 1

		local var_13_0 = false

		if arg_13_0.astrolabeInfoView_ and arg_13_0.lastHeroID ~= arg_13_0.currentHeroID then
			var_13_0 = true

			arg_13_0.astrolabeInfoView_:OnExit()
		end

		if not arg_13_0.astrolabeInfoView_ then
			var_13_0 = true
			arg_13_0.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController
		end

		if arg_13_0.astrolabeInfoView_ then
			if var_13_0 then
				arg_13_0.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(arg_13_0.heroInfo_.id), arg_13_0.heroInfo_.id)

				arg_13_0.lastHeroID = arg_13_0.currentHeroID

				arg_13_0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.none)
			end

			arg_13_0.astrolabeInfoView_:SetNodeNameIsHide(true)
			arg_13_0.astrolabeInfoView_:SetProxy(arg_13_0.heroViewProxy_)

			local var_13_1 = arg_13_0:GetAstrolabeInfo(arg_13_0.heroInfo_.id)

			arg_13_0.astrolabeInfoView_:RegistCallBack(handler(arg_13_0, arg_13_0.SelectItem))
			arg_13_0.astrolabeInfoView_:RefreshData(arg_13_0.heroInfo_, var_13_1)
		end

		arg_13_0:UpdateNotice()
	end
end

function var_0_1.GetHeroAstrolabeInfoView(arg_14_0)
	return HeroAstrolabeInfoView
end

function var_0_1.GetAstrolabeInfo(arg_15_0, arg_15_1)
	if arg_15_0.heroViewProxy_ then
		return arg_15_0.heroViewProxy_:GetHeroAstrolabeS(arg_15_1)
	end

	return {}
end

function var_0_1.RefreshAstrolabeEffect(arg_16_0)
	if not arg_16_0.heroInfo_ then
		return
	end

	local var_16_0 = clone(arg_16_0.heroViewProxy_:GetUsingAstrolabe(arg_16_0.heroInfo_.id) or {})

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0 < arg_17_1
	end)

	local var_16_1 = #var_16_0
	local var_16_2 = var_16_1 > 0
	local var_16_3 = ""

	for iter_16_0 = 1, var_16_1 do
		if not arg_16_0.desItemList[iter_16_0] then
			local var_16_4 = Object.Instantiate(arg_16_0.messageGo_, arg_16_0.contentTrs_)

			arg_16_0.desItemList[iter_16_0] = AstrolabeSuitDesItem.New(var_16_4)
		end

		arg_16_0.desItemList[iter_16_0]:SetProxy(arg_16_0.heroViewProxy_)
		arg_16_0.desItemList[iter_16_0]:SetData(var_16_0[iter_16_0], arg_16_0.heroInfo_, arg_16_0.viewDataType)
		arg_16_0.desItemList[iter_16_0]:SetActive(true)
	end

	for iter_16_1 = var_16_1 + 1, #arg_16_0.desItemList do
		arg_16_0.desItemList[iter_16_1]:SetActive(false)
	end

	SetActive(arg_16_0.nullGo_, not var_16_2)
	TimeTools.StartAfterSeconds(0.1, function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.contentTrs_)
	end, {})
end

function var_0_1.OnTop(arg_19_0)
	arg_19_0:UpdateNotice()

	if arg_19_0.astrolabeInfoView_ then
		arg_19_0.astrolabeInfoView_:RegistCallBack(handler(arg_19_0, arg_19_0.SelectItem))
	end
end

function var_0_1.UpdateNotice(arg_20_0)
	if arg_20_0.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(arg_20_0.adjustBtn_.transform, RedPointConst.ASTROLABE_UNLOCK)
	end
end

function var_0_1.OnEnter(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.heroViewProxy_ = arg_21_1
	arg_21_0.isHided = true
	arg_21_0.params_ = arg_21_2

	if arg_21_0.heroViewProxy_:GetViewDataType() ~= HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		arg_21_0.isSelfController_:SetSelectedState(tostring(arg_21_0.heroViewProxy_.isSelf))
	else
		arg_21_0.isSelfController_:SetSelectedState("true")
	end

	arg_21_0.isPreviewController_:SetSelectedState(tostring(arg_21_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
end

function var_0_1.CameraEnter(arg_22_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		0
	})
	manager.heroRaiseTrack:RefreshAstrolabeColor(true)
end

function var_0_1.OnExit(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.adjustBtn_.transform)
	arg_23_0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
end

function var_0_1.Hide(arg_24_0)
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
	var_0_1.super.Hide(arg_24_0)
	arg_24_0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	HeroTools.StopTalk()
end

function var_0_1.Dispose(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.desItemList or {}) do
		if iter_25_1 then
			iter_25_1:Dispose()
		end
	end

	arg_25_0.desItemList = nil

	var_0_1.super.Dispose(arg_25_0)
end

return var_0_1
