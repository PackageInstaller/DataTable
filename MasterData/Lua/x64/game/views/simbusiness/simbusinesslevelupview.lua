local SimBusinessLevelUpView = class("SimBusinessLevelUpView", ReduxView)

function SimBusinessLevelUpView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessShopUpgradePopUI"
end

function SimBusinessLevelUpView:UIParent()
	return manager.ui.uiPop.transform
end

function SimBusinessLevelUpView:OnCtor()
	return
end

function SimBusinessLevelUpView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.itemScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, SimBusInessUnlockNewItem)
	self.tipsController = self.controllers_:GetController("tips")
end

function SimBusinessLevelUpView:OnEnter()
	self.beforeLevel = self.params_.beforeLevel
	self.curLevel = self.params_.curLevel
	self.callback = self.params_.callback
end

function SimBusinessLevelUpView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()

		if self.callback then
			self.callback()
		end
	end)
end

function SimBusinessLevelUpView:OnTop()
	self:RefreshView()
end

function SimBusinessLevelUpView:OnExit()
	return
end

function SimBusinessLevelUpView:RefreshView()
	if self.curLevel then
		self.level.text = GetTipsF("SIM_BUSINESS_LEVEL_UP", self.curLevel)

		local var_10_0 = SimBusinessPlayerLevelCfg.get_id_list_by_activity_id_level[SimBusinessData.activityID][self.curLevel][1]

		self.result = {}

		local var_10_1 = SimBusinessPlayerLevelCfg[var_10_0].unlock_goods_list
		local var_10_2 = false

		for iter_10_0 = self.beforeLevel, self.curLevel - 1 do
			if SimBusinessGame.GetInstance():HasObstacle(iter_10_0) then
				var_10_2 = true

				break
			end
		end

		if var_10_2 then
			self.notifyNewArea_.text = GetTips("SIM_BUSINESS_UNLOCK_NEW_AREA")

			self.tipsController:SetSelectedState("on")
		else
			self.notifyNewArea_.text = ""

			self.tipsController:SetSelectedState("off")
		end

		for iter_10_1, iter_10_2 in ipairs(var_10_1) do
			table.insert(self.result, {
				id = iter_10_2,
				type = SimBusinessConst.ShowItmeType.good
			})
			SimBusinessTools.SetShowGoodsRedPoint(iter_10_2, true)
		end

		for iter_10_3, iter_10_4 in ipairs(SimBusinessPlayerLevelCfg[var_10_0].unlock_shelf_list) do
			table.insert(self.result, {
				id = iter_10_4,
				type = SimBusinessConst.ShowItmeType.shelf
			})
			SimBusinessTools.SetShowShelfRedPoint(iter_10_4, true)
		end

		self.itemScroll:StartScroll(#self.result)
	end
end

function SimBusinessLevelUpView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshView(self.result[arg_11_1].id, self.result[arg_11_1].type)
end

function SimBusinessLevelUpView:Dispose()
	self.itemScroll:Dispose()
	SimBusinessLevelUpView.super.Dispose(self)
end

return SimBusinessLevelUpView
