-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_rewardPanel_rewardItem.lua

local ActivityStageUI_rewardPanel_rewardItem = {}

function ActivityStageUI_rewardPanel_rewardItem.New(go, mainView)
	local o = Clone(ActivityStageUI_rewardPanel_rewardItem)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_rewardPanel_rewardItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.itemCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityStageUI_rewardPanel_rewardItem:InitComponent()
	table.insert(self.itemCellList, ItemCell.New(self.item))
end

function ActivityStageUI_rewardPanel_rewardItem:InitDelegate()
	function self.delegateOnClickButtonDone()
		self:OnClickButtonDone()
	end
end

function ActivityStageUI_rewardPanel_rewardItem:AddListener()
	self.buttonDone:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonDone)
end

function ActivityStageUI_rewardPanel_rewardItem:RemoveListener()
	self.buttonDone:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonDone)
end

function ActivityStageUI_rewardPanel_rewardItem:OnClickButtonDone()
	net_activityDup.receiveReward(self.data.chapterId, self.data.start)
end

function ActivityStageUI_rewardPanel_rewardItem:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textName, string.format("通关星级 %s 星", self.data.start))

	local cfgDropLib = CfgUtil.GetCfgDropLibDataWithID(self.data.drop)
	local len = #cfgDropLib.GiftItemIds

	for i = 1, len do
		local itemID = cfgDropLib.GiftItemIds[i]
		local count = cfgDropLib.GiftItemCount[i]
		local cell = self:_GetCell(i)

		cell:SetItemByCid(itemID)
		cell:SetNum(count)
	end

	LuaUtility.SetGameObjectShow(self.buttonHadGot, false)
	LuaUtility.SetGameObjectShow(self.buttonDoing, false)
	LuaUtility.SetGameObjectShow(self.buttonDone, false)
	LuaUtility.SetGameObjectShow(self.RedDot, false)

	if self.mainView:GetStartState(self.data.start) then
		LuaUtility.SetGameObjectShow(self.buttonHadGot, true)
	elseif self.mainView:GetStartNum() >= self.data.start then
		LuaUtility.SetGameObjectShow(self.buttonDone, true)
		LuaUtility.SetGameObjectShow(self.RedDot, true)
	else
		LuaUtility.SetGameObjectShow(self.buttonDoing, true)
	end
end

function ActivityStageUI_rewardPanel_rewardItem:_GetCell(index)
	if not self.itemCellList[index] then
		local o = GameObject.Instantiate(self.item, self.rewardContent.transform)

		self.itemCellList[index] = ItemCell.New(o)
	end

	return self.itemCellList[index]
end

function ActivityStageUI_rewardPanel_rewardItem:OnDestroy()
	return
end

return ActivityStageUI_rewardPanel_rewardItem
