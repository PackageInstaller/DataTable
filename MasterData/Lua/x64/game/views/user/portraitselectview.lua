local PortraitSelectView = class("PortraitSelectView", ReduxView)
local HeroTools = import("game.tools.HeroTools")

function PortraitSelectView:UIName()
	return "UI/ShowHeroSelectUI"
end

function PortraitSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function PortraitSelectView:OnCtor()
	self.selector_ = createStructuredSelector({
		sortList = function(self)
			return (HeroTools.Sort(self.herolist))
		end,
		portrait = function(arg_5_0)
			return PlayerData:GetPlayerInfo().portrait
		end
	})
end

function PortraitSelectView:InitUI()
	self.show_ = self:FindGo("btn_show")
	self.hide_ = self:FindGo("btn_hide")
	self.list_ = self:FindTrs("list/Grid")
	self.listGo_ = self:FindGo("list")
	self.itemPrefeb = Asset.Load("UI/Common/HeroItemUI")
	self.itemPool_ = Pool.New(self.itemPrefeb, self.list_, 0)
	self.scrollHelper = GridScrollHelper.New(handler(self, self.indexItem), self.listGo_, self.list_)

	SetActive(self.hide_, false)
end

function PortraitSelectView:indexItem(arg_7_1)
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

function PortraitSelectView:AddUIListener()
	self:AddBtnListenerScale("btn_return", nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale("btn_last", nil, function()
		self:Go("/home")
	end)
	self:AddBtnListener("up", nil, "MoveList", -440)
	self:AddBtnListener("down", nil, "MoveList", 440)
	self:AddBtnListenerScale("btn_show", nil, function()
		self:OnPageBtnClick()
	end)
end

function PortraitSelectView:OnPageBtnClick()
	local var_12_0 = self.clickedId_

	ActionCreators.ChangePortrait(self.clickedId_):next(function(arg_13_0)
		if isSuccess(arg_13_0.result) then
			ActionCreators.PlayerProtraitChange(var_12_0)
			self:Back()
		end
	end)
end

function PortraitSelectView:OnListBtnClick(arg_14_1)
	if self.clickedId_ == arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(self.scrollHelper:GetItemS()) do
		if self.clickedId_ == iter_14_1:GetItemId() then
			iter_14_1:ShowIsSelect(false)
		end

		if arg_14_1 == iter_14_1:GetItemId() then
			iter_14_1:ShowIsSelect(true)
		end
	end

	self.clickedId_ = tonumber(arg_14_1)

	local var_14_0 = self.clickedId_ ~= self.model_.portrait

	if self.clickedId_ ~= self.model_.portrait ~= self.isShowBtn_ then
		SetActive(self.show_, var_14_0)
	end

	self.isShowBtn_ = var_14_0
end

function PortraitSelectView:Render()
	local var_15_0 = self.selector_.compute(gameStore.getState())

	if self.model_.sortList ~= var_15_0.sortList then
		self:RefreshUI(var_15_0.sortList, var_15_0.portrait)

		self.model_.sortList = var_15_0.sortList
	end
end

function PortraitSelectView:RefreshUI(arg_16_1, arg_16_2)
	self.scrollHelper:StartScroll(#self.model_.sortList)

	for iter_16_0, iter_16_1 in ipairs(self.scrollHelper:GetItemS()) do
		if iter_16_1:GetItemId() == arg_16_2 then
			iter_16_1:ShowMiddleText(GetTips("CURRENT_SHOW"))
		else
			iter_16_1:ShowMiddleText("")
		end
	end
end

function PortraitSelectView:MoveList(arg_17_1)
	self.list_.transform.localPosition = Vector3(self.list_.transform.localPosition.x, math.floor((self.list_.transform.localPosition.y + arg_17_1) / 440) * 440 + 10, self.list_.transform.localPosition.z)
end

function PortraitSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PortraitSelectView:OnEnter()
	self.model_ = self.selector_.compute(gameStore.getState())

	self:RefreshUI(self.model_.sortList, self.model_.portrait)
	self:OnListBtnClick(self.model_.sortList[1])

	self.unsubscribeFun = gameStore.subscribe(function(arg_20_0)
		self:Render()
	end)
end

function PortraitSelectView:OnExit()
	self.unsubscribeFun()
end

function PortraitSelectView:Dispose()
	self.clickedId_ = nil
	self.itemPrefeb = nil

	self.scrollHelper:Dispose()
	self.itemPool_:Dispose()
	PortraitSelectView.super.Dispose(self)
end

return PortraitSelectView
