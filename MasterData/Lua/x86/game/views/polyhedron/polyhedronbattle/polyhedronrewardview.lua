local PolyhedronRewardView = class("PolyhedronRewardView", ReduxView)

function PolyhedronRewardView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronRewardUI"
end

function PolyhedronRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronRewardView:InitUI()
	self:BindCfgUI()

	self.rewardList = LuaList.New(handler(self, self.indexRewardItem), self.m_rewardList, PolyhedronRewardItem)
	self.hasGiveUpRewadController = ControllerUtil.GetController(self.transform_, "hasGiveUpRewad")
	self.refreshController = ControllerUtil.GetController(self.transform_, "refresh")
end

function PolyhedronRewardView:AddUIListener()
	self:AddBtnListener(self.m_confirmBtn, nil, function()
		self:OnRewardAction()
	end)
	self:AddBtnListener(self.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), self.polyhedronInfo:GetRewardGiveUpCoin()),
			OkCallback = function()
				PolyhedronAction.QueryRewardPolyhedron(0)
			end
		})
	end)
	self:AddBtnListener(self.m_refreshBtn, nil, function()
		PolyhedronAction.QueryResetRewardPolyhedron()
	end)
end

function PolyhedronRewardView:OnUpdate()
	self:RefreshUI()
end

function PolyhedronRewardView:OnEnter()
	SetActive(self.effectGo_, false)
	self:RefreshUI()
end

function PolyhedronRewardView:RefreshUI()
	self.selectItemIndex = -1
	self.m_confirmBtn.interactable = false

	local var_12_0 = PolyhedronData:GetPolyhedronInfo()

	self.polyhedronInfo = var_12_0
	self.rewardArray = var_12_0:GetRewardList()

	local var_12_1 = #self.rewardArray

	if #self.rewardArray > 0 then
		self.m_title.text = self:GetRewardTitleitemType(self.rewardArray[1].class)

		if self.rewardArray[1].class == PolyhedronConst.ITEM_TYPE.ARTIFACT then
			self.hasGiveUpRewadController:SetSelectedIndex(1)

			self.m_giveUpLab.text = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), self.polyhedronInfo:GetRewardGiveUpCoin())

			local var_12_2 = var_12_0:GetRollRewardCount()

			if var_12_2 == 0 then
				self.refreshController:SetSelectedIndex(0)
			else
				self.refreshController:SetSelectedIndex(1)
			end

			self.m_refreshCount.text = "x" .. var_12_2
		else
			self.hasGiveUpRewadController:SetSelectedIndex(0)
			self.refreshController:SetSelectedIndex(0)
		end
	else
		self.hasGiveUpRewadController:SetSelectedIndex(0)
		self.refreshController:SetSelectedIndex(0)

		self.m_title.text = ""
	end

	if var_12_1 == 1 then
		self.selectItemIndex = 1
		self.m_confirmBtn.interactable = true
	end

	self.rewardList:StartScroll(var_12_1)
end

function PolyhedronRewardView:GetRewardTitleitemType(arg_13_1)
	if arg_13_1 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT_UP")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.COIN then
		return GetTips("POLYHEDRON_REWARD_TITLE_COIN")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.HERO then
		return GetTips("POLYHEDRON_REWARD_TITLE_ROLE")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.BUFF then
		return GetTips("POLYHEDRON_REWARD_TITLE_EFFECT")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.BLOOD then
		return GetTips("POLYHEDRON_REWARD_TITLE_BLOOD")
	else
		return ""
	end
end

function PolyhedronRewardView:OnExit()
	SetActive(self.effectGo_, false)
	UpdatePolyhedronBattleHpUI()
end

function PolyhedronRewardView:indexRewardItem(arg_15_1, arg_15_2)
	arg_15_2:RegistCallBack(handler(self, self.OnRewardItemClick))
	arg_15_2:SetData(self.polyhedronInfo, self.rewardArray[arg_15_1], arg_15_1)
	arg_15_2:SetSelected(self.selectItemIndex)
end

function PolyhedronRewardView:OnRewardItemClick(arg_16_1)
	if arg_16_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_16_1

	for iter_16_0, iter_16_1 in pairs((self.rewardList:GetItemList())) do
		iter_16_1:SetSelected(self.selectItemIndex)
	end

	self.m_confirmBtn.interactable = true

	if self.rewardArray[self.selectItemIndex].class == PolyhedronConst.ITEM_TYPE.BLOOD then
		SetActive(self.effectGo_, true)
	end
end

function PolyhedronRewardView:OnRewardAction()
	if self.selectItemIndex == -1 then
		return
	end

	PolyhedronAction.QueryRewardPolyhedron(self.selectItemIndex)
end

function PolyhedronRewardView:Dispose()
	self.rewardList:Dispose()
	PolyhedronRewardView.super.Dispose(self)
end

return PolyhedronRewardView
