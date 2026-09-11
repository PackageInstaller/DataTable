local SpShootGameResultView = class("SpShootGameResultView", ReduxView)

function SpShootGameResultView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailiendUI"
end

function SpShootGameResultView:UIParent()
	return manager.ui.uiMain.transform
end

function SpShootGameResultView:OnCtor()
	return
end

function SpShootGameResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpShootGameResultView:InitUI()
	self:BindCfgUI()
end

function SpShootGameResultView:OnEnter()
	if self.params_ then
		self.textendnumText_.text = self.params_.score or 0
	end

	self.texttargetnum01Text_.text = "x" .. ((self.params_ or nil) and (self.params_.hitNum1 or 0))
	self.texttargetnum02Text_.text = "x" .. ((self.params_ or nil) and (self.params_.hitNum2 or 0))
	self.texttargetnum03Text_.text = "x" .. ((self.params_ or nil) and (self.params_.hitNum3 or 0))

	local var_6_0 = self.params_ and self.params_.resultData and self.params_.resultData.item_list
	local var_6_1

	if var_6_0 and var_6_0[1] then
		var_6_1 = var_6_0[1].num or 0

		local var_6_2

		if var_6_0 and var_6_0[2] then
			var_6_2 = var_6_0[2].num or 0
		end
	end

	local var_6_3 = SpKaliConst.ItemConst.coinID1
	local var_6_4 = SpKaliConst.ItemConst.coinID2
	local var_6_5

	if var_6_0 and var_6_0[1] then
		var_6_5 = var_6_0[1].id or 0
	end

	self.textnum01Text_.text = var_6_5 == var_6_3 and var_6_1 or var_6_2
	self.textnum02Text_.text = var_6_5 == var_6_3 and var_6_2 or var_6_1
	self.textresnum01Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward1NowAndMax(self.params_.activityID))
	self.textresnum02Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward2NowAndMax(self.params_.activityID))
	self.res01Img_.sprite = ItemTools.getItemSprite(var_6_3)
	self.res02Img_.sprite = ItemTools.getItemSprite(var_6_4)
end

function SpShootGameResultView:OnTop()
	return
end

function SpShootGameResultView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SpShootGameResultView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		SpKaliConst.ItemConst.coinID1,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function SpShootGameResultView:SetPosition(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0, var_11_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_11_4.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Vector3.New(arg_11_1, arg_11_2, arg_11_3)), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

	arg_11_4.localPosition = Vector3.New(var_11_1.x, var_11_1.y + 240, var_11_1.z)
end

function SpShootGameResultView:RegisterEvents()
	return
end

function SpShootGameResultView:AddUIListener()
	self:AddBtnListener(self.againjumpBtn_, nil, function()
		DestroyLua()
		DormMinigame.Launch("HZ07_jiali1", SpShootGameBridge, {
			activityID_ = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.btnexitBtn_, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function SpShootGameResultView:Dispose()
	SpShootGameResultView.super.Dispose(self)
end

return SpShootGameResultView
