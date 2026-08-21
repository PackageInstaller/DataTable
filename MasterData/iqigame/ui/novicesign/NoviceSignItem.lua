-- chunkname: @IQIGame\\UI\\NoviceSign\\NoviceSignItem.lua

local NoviceRewardItemCell = {}

function NoviceRewardItemCell.New(go)
	local o = Clone(NoviceRewardItemCell)

	o:Initialize(go)

	return o
end

function NoviceRewardItemCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	function self.DelegateOnClickRewarItem()
		self:OnClickRewarItem()
	end

	self:AddListener()
end

function NoviceRewardItemCell:AddListener()
	self.rewardItemImg:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRewarItem)
end

function NoviceRewardItemCell:RemoveListener()
	self.rewardItemImg:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRewarItem)
end

function NoviceRewardItemCell:SetData(itemCid, itemNum, taskPod)
	self:Show()

	self.itemCid = itemCid
	self.itemNum = itemNum

	local itemCfg = CfgUtil.GetItemCfgDataWithID(itemCid)

	self.taskPod = taskPod

	LuaUtility.SetGameObjectShow(self.receivedImg, self.taskPod.status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.canGetImg, self.taskPod.status == Constant.TaskStatus.hasDone)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.rewardItemImg:GetComponent("Image"))
	LuaUtility.SetText(self.rewardNumText, itemNum)
end

function NoviceRewardItemCell:OnClickRewarItem()
	if self.taskPod.status == Constant.TaskStatus.hadGot or self.taskPod.status == Constant.TaskStatus.doing then
		local itemData = ItemData.CreateByCIDAndNumber(self.itemCid, self.itemNum)

		ItemModule.OpenTipByData(itemData, true, false)
	end
end

function NoviceRewardItemCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function NoviceRewardItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function NoviceRewardItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

local NoviceSignItem = {}

function NoviceSignItem.New(go, mainView)
	local o = Clone(NoviceSignItem)

	o:Initialize(go, mainView)

	return o
end

function NoviceSignItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self.gameObject:SetActive(true)

	self.mainView = mainView

	self:InitMembers()
	self:InitDelegate()
	self:AddListener()
end

function NoviceSignItem:InitMembers()
	self.taskCid = 0
	self.rewardItemList = {}

	table.insert(self.rewardItemList, NoviceRewardItemCell.New(self.item1))
	table.insert(self.rewardItemList, NoviceRewardItemCell.New(self.item2))
end

function NoviceSignItem:InitDelegate()
	function self.canGetImgBtnDelegate()
		self:canGetImgBtnClick()
	end
end

function NoviceSignItem:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.canGetImgBtnDelegate)
end

function NoviceSignItem:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.canGetImgBtnDelegate)
end

function NoviceSignItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function NoviceSignItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function NoviceSignItem:Dispose()
	for i = 1, #self.rewardItemList do
		self.rewardItemList[i]:Dispose()
	end

	self.rewardItemList = nil

	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function NoviceSignItem:canGetImgBtnClick()
	if self.taskCid == 0 then
		return
	end

	local taskPod = TaskSystemModule.taskSystemDataDic[self.taskCid]
	local statues = Constant.TaskStatus.doing

	if taskPod ~= nil then
		statues = taskPod.status
	elseif TaskSystemModule.GetFinishedTaskWithID(taskPod.cid) then
		statues = Constant.TaskStatus.hadGot
	end

	if statues ~= Constant.TaskStatus.hasDone then
		return
	end

	local ciDs = {}

	table.insert(ciDs, self.taskCid)
	TaskSystemModule.SubmitTask(ciDs)
end

function NoviceSignItem:Refresh(Data)
	self.Data = Data
	self.taskCid = self.Data.cid

	local cfgData = TaskSystemModule.GetCfgTaskDataWithID(self.Data.cid)
	local taskPod = TaskSystemModule.taskSystemDataDic[self.Data.cid]
	local statues = Constant.TaskStatus.doing

	if taskPod ~= nil then
		statues = taskPod.status
	elseif TaskSystemModule.GetFinishedTaskWithID(self.Data.cid) then
		statues = Constant.TaskStatus.hadGot
	end

	if statues == Constant.TaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.receivedParent, false)
		LuaUtility.SetGameObjectShow(self.nofinishParent, true)
		LuaUtility.SetGameObjectShow(self.canGetParent, false)
	elseif statues == Constant.TaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.receivedParent, true)
		LuaUtility.SetGameObjectShow(self.nofinishParent, false)
		LuaUtility.SetGameObjectShow(self.canGetParent, false)
	elseif statues == Constant.TaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.receivedParent, false)
		LuaUtility.SetGameObjectShow(self.nofinishParent, false)
		LuaUtility.SetGameObjectShow(self.canGetParent, true)
	end

	for i = 1, #self.rewardItemList do
		self.rewardItemList[i]:Hide()
	end

	local index = 1

	for i = 1, #cfgData.ActionParam, 2 do
		self.rewardItemList[index]:SetData(cfgData.ActionParam[i], cfgData.ActionParam[i + 1], taskPod)

		index = index + 1
	end

	if statues == Constant.TaskStatus.doing then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.NormalSignImg), self.itemDayImg:GetComponent("Image"))
	elseif statues == Constant.TaskStatus.hasDone then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.CanGetSingImg), self.itemDayImg:GetComponent("Image"))
	elseif statues == Constant.TaskStatus.hadGot then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.GettedSingImg), self.itemDayImg:GetComponent("Image"))
	end
end

return NoviceSignItem
