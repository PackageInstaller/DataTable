local ShowHeroSelectView = class("ShowHeroSelectView", ReduxView)
local PlayerTools = import("game.tools.PlayerTools")

function ShowHeroSelectView:UIName()
	return "UI/ShowHeroSelectUI"
end

function ShowHeroSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function ShowHeroSelectView:OnCtor()
	self.selector_ = createStructuredSelector({
		sortList = function(self, arg_4_1)
			return (PlayerTools.SortShowHero(self.herolist, self.player.heros, arg_4_1))
		end,
		showHeroList = function(self)
			return self.player.heros
		end
	})
end

function ShowHeroSelectView:InitUI()
	self.show_ = self:FindGo("btn_show")
	self.hide_ = self:FindGo("btn_hide")
	self.list_ = self:FindTrs("list/Grid")
	self.listGo_ = self:FindGo("list")
	self.itemPrefeb = Asset.Load("UI/Common/HeroItemUI")
	self.itemPool_ = Pool.New(self.itemPrefeb, self.list_, 0)
	self.scrollHelper = GridScrollHelper.New(handler(self, self.indexItem), self.listGo_, self.list_)
end

function ShowHeroSelectView:indexItem(arg_7_1)
	if arg_7_1 < 0 or arg_7_1 > #self.model_.sortList then
		return nil
	end

	local var_7_0, var_7_1 = self.itemPool_:GetCanUsingObj()

	SetActive(var_7_0, true)

	local var_7_2 = CommonHeroItem.New(self, var_7_0, self.model_.sortList[arg_7_1])

	var_7_2:RegistCallBack(handler(self, self.OnListBtnClick))

	var_7_2.recycleIndex = var_7_1
	var_7_2.pools = self.itemPool_

	return var_7_2
end

function ShowHeroSelectView:AddUIListener()
	self:AddBtnListenerScale("btn_return", nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale("btn_last", nil, function()
		self:Go("/home")
	end)
	self:AddBtnListener("up", nil, "MoveList", -440)
	self:AddBtnListener("down", nil, "MoveList", 440)
	self:AddBtnListenerScale("btn_show", nil, function()
		self:OnPageBtnClick(false)
	end)
	self:AddBtnListenerScale("btn_hide", nil, function()
		self:OnPageBtnClick(true)
	end)
end

function ShowHeroSelectView:OnPageBtnClick(arg_13_1)
	local var_13_0 = {}
	local var_13_1 = tonumber(self.params_.selectIndex)
	local var_13_2 = table.keyof(self.model_.showHeroList, self.clickedId_)

	for iter_13_0 = 1, 3 do
		var_13_0[iter_13_0] = self.model_.showHeroList[iter_13_0] or 0
	end

	if arg_13_1 then
		var_13_0[var_13_1] = 0
	elseif table.keyof(self.model_.showHeroList, self.clickedId_) ~= nil then
		var_13_0[var_13_2], var_13_0[var_13_1] = var_13_0[var_13_1], self.clickedId_
	else
		var_13_0[var_13_1] = self.clickedId_
	end

	ActionCreators.ChangeShowHero(var_13_0):next(function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			ActionCreators.PlayerShowHeroChange(var_13_0)
			self:Back()
		end
	end)
end

function ShowHeroSelectView:OnListBtnClick(arg_15_1)
	if self.clickedId_ == arg_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(self.scrollHelper:GetItemS()) do
		if self.clickedId_ == iter_15_1:GetItemId() then
			iter_15_1:ShowIsSelect(false)
		end

		if arg_15_1 == iter_15_1:GetItemId() then
			iter_15_1:ShowIsSelect(true)
		end
	end

	self.clickedId_ = tonumber(arg_15_1)

	local var_15_0 = table.keyof(self.model_.showHeroList, arg_15_1)
	local var_15_1 = var_15_0 ~= nil and var_15_0 == tonumber(self.params_.selectIndex)

	if var_15_1 ~= self.isHideBtn_ then
		SetActive(self.show_, not var_15_1)
		SetActive(self.hide_, var_15_1)
	end

	self.isHideBtn_ = var_15_1
end

function ShowHeroSelectView:Render()
	local var_16_0 = self.selector_.compute(gameStore.getState(), tonumber(self.params_.selectIndex))

	if self.model_.sortList ~= var_16_0.sortList then
		self:RefreshUI(var_16_0.sortList, var_16_0.showHeroList)

		self.model_.sortList = var_16_0.sortList
	end
end

function ShowHeroSelectView:RefreshUI(arg_17_1, arg_17_2)
	self.scrollHelper:StartScroll(#self.model_.sortList)

	for iter_17_0, iter_17_1 in ipairs(self.scrollHelper:GetItemS()) do
		local var_17_0 = table.keyof(arg_17_2, iter_17_1:GetItemId())

		if var_17_0 then
			if var_17_0 == tonumber(self.params_.selectIndex) then
				iter_17_1:ShowMiddleText(GetTips("CURRENT_SHOW"))
			else
				iter_17_1:ShowMiddleText(GetTips("IS_IN_SHOW"))
			end
		else
			iter_17_1:ShowMiddleText("")
		end
	end
end

function ShowHeroSelectView:MoveList(arg_18_1)
	self.list_.transform.localPosition = Vector3(self.list_.transform.localPosition.x, math.floor((self.list_.transform.localPosition.y + arg_18_1) / 440) * 440 + 10, self.list_.transform.localPosition.z)
end

function ShowHeroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShowHeroSelectView:OnEnter()
	self.model_ = self.selector_.compute(gameStore.getState(), tonumber(self.params_.selectIndex))

	self:RefreshUI(self.model_.sortList, self.model_.showHeroList)
	self:OnListBtnClick(self.model_.sortList[1])

	self.unsubscribeFun = gameStore.subscribe(function(arg_21_0)
		self:Render()
	end)
end

function ShowHeroSelectView:OnExit()
	self.unsubscribeFun()
end

function ShowHeroSelectView:Dispose()
	self:RemoveAllListeners()

	self.clickedId_ = nil
	self.isHideBtn_ = nil
	self.itemPrefeb = nil

	self.scrollHelper:Dispose()
	self.itemPool_:Dispose()
	ShowHeroSelectView.super.Dispose(self)
end

return ShowHeroSelectView
