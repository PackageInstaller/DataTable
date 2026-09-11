local RecallMainView = class("RecallMainView", ReduxView)
local var_0_1 = {
	"recalled",
	"recall",
	"mission",
	"treasure"
}

function RecallMainView:UIName()
	return "Widget/System/RecallUI/RC1stMenuUI"
end

function RecallMainView:UIParent()
	return manager.ui.uiMain.transform
end

function RecallMainView:Init()
	self.curPageIndex_ = -1
	self.params_ = {}
	self.prefabList_ = {
		"Widget/System/RecallUI/RC1stReturnUI",
		"Widget/System/RecallUI/RC1stInitiateUI",
		"Widget/System/RecallUI/RC1stMissionUI",
		"Widget/System/RecallUI/RC1stTreasureUI"
	}
	self.ClassList_ = {
		RecallSystemRecalledView,
		RecallSystemRecallView,
		RecallSystemTaskView,
		RecallSystemShopView
	}

	self:InitUI()
	self:AddUIListener()

	self.needExitAnim = {
		[2] = true,
		[4] = true
	}
	self.needEnterAnim = {
		[1] = true,
		[3] = true
	}
	self.playAnimTypeConst = {
		EXIT = 2,
		ENTER = 1
	}
	self.animConst = {
		[1] = "Fx_adron_cx",
		[2] = "Fx_adron_xs"
	}
	self.animation = self.animPanelGo_:GetComponent("Animation")
end

function RecallMainView:InitUI()
	self:BindCfgUI()

	self.pages_ = {}
end

function RecallMainView:AddUIListener()
	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		self:AddToggleListener(self[iter_5_1 .. "Btn_"], function(arg_6_0)
			if arg_6_0 then
				self:SwitchPage(iter_5_0)
				ControllerUtil.GetController(self[iter_5_1 .. "Btn_"].transform, "toggle"):SetSelectedState("on")
			end
		end)
	end

	self:RegistEventListener(MATERIAL_MODIFY, function(arg_7_0)
		if arg_7_0 == self.id then
			manager.windowBar:SwitchBar(self.barList)
		end
	end)
end

function RecallMainView:SwitchPage(arg_8_1)
	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:Hide()
	end

	self.curPageIndex_ = arg_8_1
	self.params_.page = arg_8_1

	if not self.pages_[arg_8_1] and self.prefabList_[arg_8_1] and self.ClassList_[arg_8_1] then
		self.pages_[arg_8_1] = self.ClassList_[arg_8_1].New((Object.Instantiate(Asset.Load(self.prefabList_[arg_8_1]), self.container_)))
	end

	self.pages_[self.curPageIndex_]:Show()
	self.pages_[arg_8_1]:OnEnter()
	self:PlayAnim()
end

function RecallMainView:PlayAnim()
	local var_9_0 = false
	local var_9_1 = -1

	if self.params_.isEnter == true then
		if self.needExitAnim[self.curPageIndex_] == true then
			var_9_0 = false
			var_9_1 = self.playAnimTypeConst.EXIT
		elseif self.needEnterAnim[self.curPageIndex_] == true then
			var_9_0 = true
			var_9_1 = self.playAnimTypeConst.ENTER
			self.params_.isEnter = false
		end
	else
		var_9_0 = true

		if self.needEnterAnim[self.curPageIndex_] == true and self.lastPlayType ~= self.playAnimTypeConst.ENTER then
			var_9_1 = self.playAnimTypeConst.ENTER
		elseif self.needExitAnim[self.curPageIndex_] == true and self.lastPlayType ~= self.playAnimTypeConst.EXIT then
			var_9_1 = self.playAnimTypeConst.EXIT
		end
	end

	SetActive(self.animPanelGo_, var_9_0)

	if var_9_0 == true and var_9_1 ~= -1 then
		self.lastPlayType = var_9_1

		self.animation:Play(self.animConst[var_9_1])
	end
end

function RecallMainView:CheckPageEnter(arg_10_1)
	if not self.enteredPage_[arg_10_1] then
		self.pages_[arg_10_1]:OnEnter()

		self.enteredPage_[arg_10_1] = true
	end
end

function RecallMainView:SetFirstPage()
	local var_11_0 = ActivityRecallData:GetDataByPara("firstPage")

	SetActive(self.recalledBtn_.gameObject, var_11_0)

	if self.curPageIndex_ == -1 then
		self.curPageIndex_ = var_11_0 and 1 or 2
	end

	self:SwitchPage(self.curPageIndex_)
end

function RecallMainView:OnTop()
	local var_12_0 = ActivityRecallData:GetDataByPara("shopID")

	self.barList = {}

	table.insert(self.barList, INFO_BAR)
	table.insert(self.barList, BACK_BAR)
	table.insert(self.barList, HOME_BAR)
	table.insert(self.barList, NAVI_BAR)

	local var_12_1 = {}

	for iter_12_0 = 1, #ShopListCfg[var_12_0].cost_id do
		self.id = nil
		self.id = CurrencyIdMapCfg[ShopListCfg[var_12_0].cost_id[iter_12_0]] and CurrencyIdMapCfg[ShopListCfg[var_12_0].cost_id[iter_12_0]].item_id or ShopListCfg[var_12_0].cost_id[iter_12_0]

		table.insert(self.barList, self.id)
		table.insert(var_12_1, self.id)
	end

	manager.windowBar:SwitchBar(self.barList)

	for iter_12_1 = 1, #var_12_1 do
		manager.windowBar:SetBarCanClick(var_12_1[iter_12_1], true)
	end

	manager.windowBar:SetGameHelpKey("RECALLED_DESC")
end

function RecallMainView:OnSign(arg_13_1, arg_13_2)
	if self.pages_[self.curPageIndex_] and self.pages_[self.curPageIndex_].OnSign then
		self.pages_[self.curPageIndex_]:OnSign(arg_13_1, arg_13_2)
	end
end

function RecallMainView:OnReceivedCodeReward()
	if self.pages_[self.curPageIndex_] and self.pages_[self.curPageIndex_].OnReceivedCodeReward then
		self.pages_[self.curPageIndex_]:OnReceivedCodeReward()
	end
end

function RecallMainView:OnRecallRewardUpdate()
	if self.pages_[self.curPageIndex_] and self.pages_[self.curPageIndex_].OnRecallRewardUpdate then
		self.pages_[self.curPageIndex_]:OnRecallRewardUpdate()
	end
end

function RecallMainView:OnRecallSignUpdate()
	if self.pages_[self.curPageIndex_] and self.pages_[self.curPageIndex_].OnRecallSignUpdate then
		self.pages_[self.curPageIndex_]:OnRecallSignUpdate()
	end
end

function RecallMainView:OnEnter()
	self.enteredPage_ = {}

	for iter_17_0, iter_17_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_17_0)
	end

	self:SetFirstPage()
	self:BindRedPoint()
end

function RecallMainView:OnExit()
	self:RemoveAllEventListener()

	for iter_18_0, iter_18_1 in pairs(self.pages_) do
		if iter_18_1 ~= nil then
			iter_18_1:OnExit()
		end
	end

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function RecallMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.recalledBtn_.transform, RedPointConst.RECALL_SIGN, {
		x = 160,
		y = 45
	})
	manager.redPoint:bindUIandKey(self.recallBtn_.transform, RedPointConst.RECALL_REWARD, {
		x = 160,
		y = 45
	})
	manager.redPoint:bindUIandKey(self.missionBtn_.transform, RedPointConst.RECALL_TASK, {
		x = 160,
		y = 45
	})
end

function RecallMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.recalledBtn_.transform, RedPointConst.RECALL_SIGN)
	manager.redPoint:unbindUIandKey(self.recallBtn_.transform, RedPointConst.RECALL_REWARD)
	manager.redPoint:unbindUIandKey(self.missionBtn_.transform, RedPointConst.RECALL_TASK)
end

function RecallMainView:Dispose()
	if self.pages_ then
		for iter_21_0, iter_21_1 in pairs(self.pages_) do
			iter_21_1:Dispose()
		end

		self.pages_ = nil
	end

	RecallMainView.super.Dispose(self)
end

return RecallMainView
