local var_0_0 = class("OathMainBtnContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.lvInfo_ = OathLvInfo.New(arg_2_0.lvGo_)
	arg_2_0.oathController_ = arg_2_0.controller_:GetController("oathState")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.contentBtn_, nil, function()
		if OathTools.IsOath(arg_3_0.heroID) then
			JumpTools.OpenPageByJump("/oathDetailsView", {
				heroID = arg_3_0.heroID
			})
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(arg_3_0.heroID)))
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.equityBtn_, nil, function()
		JumpTools.OpenPageByJump("oathEquityPopView", {
			heroID = arg_3_0.heroID
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.bookBtn_, nil, function()
		if OathTools.IsOath(arg_3_0.heroID) then
			JumpTools.OpenPageByJump("oathBookView", {
				isMainViewEnter = true,
				heroID = arg_3_0.heroID
			})
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(arg_3_0.heroID)))
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.photoBtn_, nil, function()
		if OathTools.IsOath(arg_3_0.heroID) then
			local var_7_0 = WeddingCfg[arg_3_0.heroID]

			OathLaunchScene(var_7_0.wedding_scene, arg_3_0.heroID, var_7_0.skin_id, OathConst.OATH_SCENE_MODE.SHARE)
		else
			ShowTips(string.format(GetTips("WEDDING_MAIN_UNLOCK_TIP"), HeroTools.GetHeroName(arg_3_0.heroID)))
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.nameBtn_, nil, function()
		JumpTools.OpenPageByJump("/oathNamePopView", {
			heroID = arg_3_0.heroID
		})
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	if arg_9_0.heroID then
		manager.redPoint:unbindUIandKey(arg_9_0.contentBtn_.transform, RedPointConst.OATH_CONTENT .. arg_9_0.heroID)
	end

	arg_9_0.heroID = arg_9_1

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshNameUI()
	arg_10_0.lvInfo_:SetData(arg_10_0.heroID)

	if OathCollectionContentData:GetOathState(arg_10_0.heroID) then
		arg_10_0.oathController_:SetSelectedState("oath")

		arg_10_0.contentAni_.enabled = true
	else
		arg_10_0.oathController_:SetSelectedState("noOath")

		arg_10_0.contentAni_.enabled = false
	end

	manager.redPoint:bindUIandKey(arg_10_0.contentBtn_.transform, RedPointConst.OATH_CONTENT .. arg_10_0.heroID)
end

function var_0_0.RefreshNameUI(arg_11_0)
	arg_11_0.oathName_.text = HeroTools.GetHeroName(arg_11_0.heroID)
end

function var_0_0.OnExit(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.contentBtn_.transform, RedPointConst.OATH_CONTENT .. arg_12_0.heroID)
	arg_12_0.lvInfo_:OnExit()
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.lvInfo_ then
		arg_13_0.lvInfo_:Dispose()

		arg_13_0.lvInfo_ = nil
	end

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
