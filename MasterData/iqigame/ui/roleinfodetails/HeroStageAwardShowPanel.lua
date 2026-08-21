-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\HeroStageAwardShowPanel.lua

local HeroStageAwardShowPanel = {}

function HeroStageAwardShowPanel.New(go, mainView)
	local o = Clone(HeroStageAwardShowPanel)

	o:Initialize(go, mainView)

	return o
end

function HeroStageAwardShowPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function HeroStageAwardShowPanel:InitMembers()
	self.awardItemViewList = {}
end

function HeroStageAwardShowPanel:InitComponent()
	return
end

function HeroStageAwardShowPanel:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:Hide()
	end
end

function HeroStageAwardShowPanel:AddListener()
	self.returnBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickReturnBtn)
end

function HeroStageAwardShowPanel:RemoveListener()
	self.returnBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickReturnBtn)
end

function HeroStageAwardShowPanel:OnDestroy()
	local len = #self.awardItemViewList

	for i = 1, len do
		self.awardItemViewList[i]:Dispose()

		self.awardItemViewList[i] = nil
	end

	self.awardItemViewList = {}

	self:RemoveListener()
	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function HeroStageAwardShowPanel:Refresh(Data)
	self.data = Data

	local len = #self.awardItemViewList

	for i = 1, len do
		LuaUtility.SetGameObjectShow(self.awardItemViewList[i].root, false)
	end

	len = #self.data

	for i = 1, len do
		local itemCell = self:GetItem(i)
		local itemData = ItemData.CreateByCIDAndNumber(self.data[i].id)

		itemCell:SetItem(itemData)
		itemCell:SetNum(self.data[i].count)
		LuaUtility.SetGameObjectShow(itemCell.root, true)
	end
end

function HeroStageAwardShowPanel:GetItem(index)
	if not self.awardItemViewList[index] then
		local o = GameObject.Instantiate(self.Sample_AwardItem, self.awardScroll.transform)

		self.awardItemViewList[index] = ItemCell.New(o.transform:Find("item").gameObject, true, false)

		LuaCodeInterface.BindOutlet(o, self.awardItemViewList[index])
	end

	return self.awardItemViewList[index]
end

function HeroStageAwardShowPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function HeroStageAwardShowPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

return HeroStageAwardShowPanel
