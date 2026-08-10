ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivitySPKaliGamePageView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailihomeUI"
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	arg_2_0.shopControl = arg_2_0.shashwatui_com_btn03Controllerexcollection_:GetController("default0")

	arg_2_0:OnUpdateView()
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.btn_ringsideBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_3_0.btn_sniperBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_3_0.btn_treasureBtn_.transform)
end

function var_0_0.OnTop(arg_4_0)
	arg_4_0:OnUpdateView()
end

function var_0_0.OnUpdateView(arg_5_0)
	local var_5_0 = SpKaliTool.GetGameIDByMainActivityID(arg_5_0.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)
	local var_5_1 = SPKaliChallengeData:GetSPChallengeData(var_5_0)

	arg_5_0.texttittleText_.text = GetTips("ACTIVITY_KALI_TITLE")
	arg_5_0.textText_.text = GetTips("ACTIVITY_KALI_DES")
	arg_5_0.textbtnnameText_.text = GetTips("ACTIVITY_KALI_SHOP")

	local var_5_2 = SpKaliTool.GetGameIDByMainActivityID(arg_5_0.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)
	local var_5_3 = ActivityTools.GetRedPointKey(var_5_2) .. var_5_2

	manager.redPoint:bindUIandKey(arg_5_0.btn_ringsideBtn_.transform, var_5_3)

	local var_5_4 = SpKaliTool.GetGameIDByMainActivityID(arg_5_0.activityID_, ActivityTemplateConst.ACTIVITY_KALISHOOT)

	arg_5_0.shootKey = ActivityTools.GetRedPointKey(var_5_4) .. var_5_4

	manager.redPoint:bindUIandKey(arg_5_0.btn_sniperBtn_.transform, arg_5_0.shootKey)

	local var_5_5 = SpKaliTool.GetGameIDByMainActivityID(arg_5_0.activityID_, ActivityTemplateConst.ACTIVITY_KALITUG)
	local var_5_6 = ActivityTools.GetRedPointKey(var_5_5) .. var_5_5

	manager.redPoint:bindUIandKey(arg_5_0.btn_treasureBtn_.transform, var_5_6)

	local var_5_7 = ShopTools.CheckSoldOut(SpKaliConst.ItemConst.skinID)

	arg_5_0.shopControl:SetSelectedState(var_5_7 and "state1" or "state0")
end

function var_0_0.RefreshTimeText(arg_6_0)
	arg_6_0.timeTxt_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(arg_6_0.stopTime_))
end

function var_0_0.AddListeners(arg_7_0)
	local var_7_0 = SpKaliTool.GetGameIDByMainActivityID(arg_7_0.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)

	arg_7_0:AddBtnListener(arg_7_0.btn_ringsideBtn_, nil, function()
		local var_8_0 = SPKaliChallengeData:GetNowAffixEffect(var_7_0)

		JumpTools.OpenPageByJump("/SpKaliChallenge", {
			activityID_ = var_7_0
		})

		if not SpKaliTool.IsHaveRolled(var_7_0) then
			-- block empty
		end
	end)

	local var_7_1 = SpKaliTool.GetGameIDByMainActivityID(arg_7_0.activityID_, ActivityTemplateConst.ACTIVITY_KALISHOOT)

	arg_7_0:AddBtnListener(arg_7_0.btn_sniperBtn_, nil, function()
		DormMinigame.Launch("HZ07_jiali1", SpShootGameBridge, {
			activityID_ = var_7_1
		})
		manager.redPoint:setTip(arg_7_0.shootKey, 0)
	end)
	arg_7_0:AddBtnListener(arg_7_0.btn_treasureBtn_, nil, function()
		local var_10_0 = SpKaliTool.GetGameIDByMainActivityID(arg_7_0.activityID_, ActivityTemplateConst.ACTIVITY_KALITUG)

		JumpTools.OpenPageByJump("/TugGameView", {
			activityID_ = var_10_0
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.btn01Btn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1,
			showShops = {
				ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_7_0:AddBtnListener(arg_7_0.descbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_KALI_DESC_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_KALI_DESC_1")
		})
	end)
	arg_7_0:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_13_0, arg_13_1)
		if arg_13_1 == ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1 then
			SPKaliChallengeData:UpdateRedPoint(var_7_0)
			SpShooGameData:UpdateRedPoint(var_7_1)
		end
	end)
end

return var_0_0
