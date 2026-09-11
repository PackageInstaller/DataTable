ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivitySPKaliGamePageView = class("ActivitySPKaliGamePageView", ActivityMainBasePanel)

function ActivitySPKaliGamePageView:GetUIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailihomeUI"
end

function ActivitySPKaliGamePageView:OnEnter()
	ActivitySPKaliGamePageView.super.OnEnter(self)

	self.shopControl = self.shashwatui_com_btn03Controllerexcollection_:GetController("default0")

	self:OnUpdateView()
end

function ActivitySPKaliGamePageView:OnExit()
	ActivitySPKaliGamePageView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_ringsideBtn_.transform)
	manager.redPoint:unbindUIandKey(self.btn_sniperBtn_.transform)
	manager.redPoint:unbindUIandKey(self.btn_treasureBtn_.transform)
end

function ActivitySPKaliGamePageView:OnTop()
	self:OnUpdateView()
end

function ActivitySPKaliGamePageView:OnUpdateView()
	local var_5_0 = SPKaliChallengeData:GetSPChallengeData((SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)))

	self.texttittleText_.text = GetTips("ACTIVITY_KALI_TITLE")
	self.textText_.text = GetTips("ACTIVITY_KALI_DES")
	self.textbtnnameText_.text = GetTips("ACTIVITY_KALI_SHOP")

	local var_5_1 = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)

	manager.redPoint:bindUIandKey(self.btn_ringsideBtn_.transform, ActivityTools.GetRedPointKey(var_5_1) .. var_5_1)

	local var_5_2 = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALISHOOT)

	self.shootKey = ActivityTools.GetRedPointKey(var_5_2) .. var_5_2

	manager.redPoint:bindUIandKey(self.btn_sniperBtn_.transform, self.shootKey)

	local var_5_3 = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALITUG)

	manager.redPoint:bindUIandKey(self.btn_treasureBtn_.transform, ActivityTools.GetRedPointKey(var_5_3) .. var_5_3)
	self.shopControl:SetSelectedState(ShopTools.CheckSoldOut(SpKaliConst.ItemConst.skinID) and "state1" or "state0")
end

function ActivitySPKaliGamePageView:RefreshTimeText()
	self.timeTxt_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
end

function ActivitySPKaliGamePageView:AddListeners()
	local var_7_0 = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALIFIGHT)

	self:AddBtnListener(self.btn_ringsideBtn_, nil, function()
		local var_8_0 = SPKaliChallengeData:GetNowAffixEffect(var_7_0)

		JumpTools.OpenPageByJump("/SpKaliChallenge", {
			activityID_ = var_7_0
		})

		if not SpKaliTool.IsHaveRolled(var_7_0) then
			-- block empty
		end
	end)

	local var_7_1 = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALISHOOT)

	self:AddBtnListener(self.btn_sniperBtn_, nil, function()
		DormMinigame.Launch("HZ07_jiali1", SpShootGameBridge, {
			activityID_ = var_7_1
		})
		manager.redPoint:setTip(self.shootKey, 0)
	end)
	self:AddBtnListener(self.btn_treasureBtn_, nil, function()
		JumpTools.OpenPageByJump("/TugGameView", {
			activityID_ = SpKaliTool.GetGameIDByMainActivityID(self.activityID_, ActivityTemplateConst.ACTIVITY_KALITUG)
		})
	end)
	self:AddBtnListener(self.btn01Btn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1,
			showShops = {
				ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.descbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_KALI_DESC_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_KALI_DESC_1")
		})
	end)
	self:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_13_0, arg_13_1)
		if arg_13_1 == ShopConst.SHOP_ID.SP_KALI_CHALLENGE_1 then
			SPKaliChallengeData:UpdateRedPoint(var_7_0)
			SpShooGameData:UpdateRedPoint(var_7_1)
		end
	end)
end

return ActivitySPKaliGamePageView
