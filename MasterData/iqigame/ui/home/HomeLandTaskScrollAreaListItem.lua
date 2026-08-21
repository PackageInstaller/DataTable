-- chunkname: @IQIGame\\UI\\Home\\HomeLandTaskScrollAreaListItem.lua

local Item = {
	lastTime = 0,
	taskCid = 0
}

function Item.New(view)
	local obj = Clone(Item)

	obj:__Init(view)

	return obj
end

function Item:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInitDelegateFunc()
	self:__OnAddListeners()
end

function Item:__OnInitDelegateFunc()
	return
end

function Item:__OnAddListeners()
	return
end

function Item:__OnRemoveListeners()
	return
end

function Item:Show(taskCid)
	self.taskCid = taskCid

	self.gameObject:SetActive(true)

	local taskCfg = CfgHomeDispTaskTable[self.taskCid]

	self.taskName1:GetComponent("Text").text = taskCfg.TaskName
	self.taskName2:GetComponent("Text").text = taskCfg.TaskName

	local iconPath = UIGlobalApi.GetIconPath(taskCfg.HomeDispTaskIcon)

	AssetUtil.LoadImage(self, iconPath, self.taskIcon:GetComponent("Image"))

	local qualityIconPath = HomeLandApi:GetTaskQualityImagePath(taskCfg.Quality)

	AssetUtil.LoadImage(self, qualityIconPath, self.taskQuality:GetComponent("Image"))

	local taskData = HomeModule.GetDispTask(self.taskCid)

	self.taskState = taskData.status

	if self.taskState == Constant.HomeLandDispTaskType.Receive then
		self.finishTag.gameObject:SetActive(false)
		self.receiveTag.gameObject:SetActive(true)
		self.runningTag.gameObject:SetActive(false)
	elseif self.taskState == Constant.HomeLandDispTaskType.Finish then
		self.finishTag.gameObject:SetActive(true)
		self.receiveTag.gameObject:SetActive(false)
		self.runningTag.gameObject:SetActive(false)
	elseif self.taskState == Constant.HomeLandDispTaskType.Running then
		self.finishTag.gameObject:SetActive(false)
		self.receiveTag.gameObject:SetActive(false)
		self.runningTag.gameObject:SetActive(true)
		self:__StartTime(taskData.executeTime, taskCfg.Time)
	else
		self.finishTag.gameObject:SetActive(false)
		self.receiveTag.gameObject:SetActive(false)
		self.runningTag.gameObject:SetActive(false)
	end
end

function Item:__StartTime(executeTime, totalTime)
	local serverTime = PlayerModule.GetServerTime()

	self.lastTime = totalTime - (serverTime - executeTime)

	self:__RefreshTimeText()
end

function Item:OnTimeUpdate()
	if self.taskState ~= Constant.HomeLandDispTaskType.Running then
		return
	end

	self.lastTime = self.lastTime - 1

	if self.lastTime <= 0 then
		self.lastTime = 0
	end

	self:__RefreshTimeText()
end

function Item:__RefreshTimeText()
	local timeStr = DateTimeFormat(self.lastTime, "hh:mm:ss")

	self.runningTimeText:GetComponent("Text").text = timeStr
end

function Item:RefreshSelectState(isSelect)
	self.onTab.gameObject:SetActive(isSelect)
	self.offTab.gameObject:SetActive(not isSelect)
end

function Item:Hide()
	self.gameObject:SetActive(false)
end

function Item:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Item
