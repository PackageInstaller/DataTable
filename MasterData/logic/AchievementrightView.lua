-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementrightView.lua

module("logic.extensions.achievement.view.AchievementrightView", package.seeall)

local AchievementrightView = class("AchievementrightView", ViewComponent)

function AchievementrightView:ctor()
	AchievementrightView.super.ctor(self)
end

function AchievementrightView:bindEvents()
	self._btnAllPrize:AddClickListener(self._onClickAllPrize, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
end

function AchievementrightView:unbindEvents()
	self._btnAllPrize:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
end

function AchievementrightView:buildUI()
	AchievementrightView.super.buildUI(self)

	self._listView = goutil.findChildComponent(self.mainGO, "right/listview/tableview", "UITableview")
	self._listCell = goutil.findChild(self.mainGO, "right/listview/tablecell")

	goutil.setActive(self._listCell, false)
	self._listView:RegisterCallback(self._achievementNumInView, self._achievementCellSize, self._achievementCellAtIndex, self)
	self._listView:RegisterUpdateCellCallback(self._updateAchievementCell)
	self._listView:SetOffsetWithoutRefresh(0)

	self._animRight = goutil.findChildComponent(self.mainGO, "right", "Animator")
	self._progresses = {}

	for i = 1, 6 do
		local progress = {}
		local cfg = AchievementConfig.instance:getIndexCfg(i, 0)

		progress.mainGO = goutil.findChild(self.mainGO, "right/overall/left/grid/" .. i)

		if cfg ~= nil then
			goutil.setActive(progress.mainGO, true)

			progress.txtProgress = goutil.findChildComponent(progress.mainGO, "txtProgress", "Text")
			progress.imgProgress = goutil.findChildComponent(progress.mainGO, "imgProgress", "Image")
			progress.txtName = goutil.findChildComponent(progress.mainGO, "txtName", "Text")
			progress.txtName.text = string.gsub(cfg.name, " ", "")
			progress.imgIcon = goutil.findChildComponent(progress.mainGO, "imgIcon", "UIImageSpriteChange")

			progress.imgIcon:SetState(i - 1)

			self._progresses[i] = progress
		else
			goutil.setActive(progress.mainGO, false)
		end
	end

	local container = self:getGo("right/overall/right")

	self._txtTotalProgress = goutil.findChildComponent(container, "txtTotalProgress", "Text")
	self._txtCurProgress = goutil.findChildComponent(container, "txtCurProgress", "Text")
	self._txtCurLv = goutil.findChildComponent(container, "txtCurLv", "Text")
	self._imgLvProgress = goutil.findChildComponent(container, "imgLvProgress", "Image")
	self._btnAllPrize = Framework.ButtonAdapter.GetFrom(container, "btnAllPrize")
	self._prizeRedPoint = goutil.findChild(self._btnAllPrize.gameObject, "imgRedPoint")
	self._txtTitle = goutil.findChildComponent(self.mainGO, "right/title/txtTitle", "Text")
	self._tipsNull = self:getGo("right/tipsNull")
	self._right = self:getGo("right")
	self._btnOneKey = self:getBtn("right/overall/btnOneKey")
end

function AchievementrightView:destroyUI()
	return
end

function AchievementrightView:onEnter()
	AchievementrightView.super.onEnter(self)

	self._initRoot = 1
	self._initLeaf = 0

	local params = self:getOpenParam()

	if params then
		local cfg = params[1]

		self._initRoot = cfg.root + 1
		self._initLeaf = cfg.leaf
	end

	AchievementController.instance:registerLocalNotify("LoadAllAchievement", self._refreshView, self)
	AchievementController.instance:registerLocalNotify("GainAchievementPrize", self._sendInfoReq, self)
	AchievementController.instance:registerLocalNotify("GainAchievementLevelPrize", self._sendInfoReq, self)

	self._selectedRoot = self._initRoot
	self._selectedLeaf = self._initLeaf

	goutil.setActive(self._right, false)
	GlobalDispatcher:addListener(GlobalNotify.AchievementOneKeySuccess, self._onOneKeySuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateAchievementrightView, self._onUpdateTab, self)
	self:_sendInfoReq()
end

function AchievementrightView:_sendInfoReq()
	AchievementController.instance:sendLoadAllAchievementReq()
end

function AchievementrightView:_onUpdateTab(cfg)
	self._initRoot = cfg.root + 1
	self._initLeaf = cfg.leaf

	self:_refreshView()
end

function AchievementrightView:_refreshView()
	goutil.setActive(self._right, true)

	self._selectedRoot = self._initRoot
	self._selectedLeaf = self._initLeaf

	self:_refreshPage(self._initRoot, self._initLeaf)
end

function AchievementrightView:_getDirectoryName(root, leaf)
	local cfg = AchievementConfig.instance:getIndexCfg(root - 1, leaf)

	if cfg ~= nil then
		return cfg.name
	else
		return ""
	end
end

function AchievementrightView:onEnterFinished()
	return
end

function AchievementrightView:onExit()
	AchievementrightView.super.onExit(self)
	AchievementController.instance:unregisterLocalNotify("LoadAllAchievement", self._refreshView, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementPrize", self._sendInfoReq, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementLevelPrize", self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.AchievementOneKeySuccess, self._onOneKeySuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateAchievementrightView, self._onUpdateTab, self)
end

function AchievementrightView:onExitFinished()
	return
end

function AchievementrightView:_onReloadFinish()
	self._reloadFinished = true

	self._listView:SetOffset(0, false)
end

function AchievementrightView:_refreshPage(root, leaf)
	print("_refreshPage root = " .. root .. " leaf = " .. leaf)

	if root == 1 then
		self._animRight:Play("achievementani")
		self:_updateOverall()
	else
		self._animRight:Play("listview")
		self:_updateListView(root, leaf)
	end

	goutil.setActive(self._tipsNull, #self._achievementDatas == 0)
end

function AchievementrightView:_updateListView(root, leaf)
	local dataList = AchievementConfig.instance:getCfgsByRootAndLeaf(root - 1, leaf)

	self:_filterDatas(dataList)
	self._listView:ReloadData()

	self._txtTitle.text = self:_getDirectoryName(root, leaf)
end

function AchievementrightView:_updateOverall()
	for i = 1, 6 do
		local progress = self._progresses[i]

		if progress ~= nil then
			local mo = AchievementModel.instance:getProgress(i) or {}
			local curProgress = checknumber(mo.curProgress)
			local totalProgress = checknumber(mo.totalProgress)

			progress.txtProgress.text = string.format("%s/%s", curProgress, totalProgress)

			if totalProgress > 0 then
				progress.imgProgress.fillAmount = curProgress / totalProgress or 0
			end
		end
	end

	local dataList = AchievementModel.instance:getOverallAchievements()

	self:_filterDatas(dataList)
	self._listView:ReloadData()
	self:_updateBtnOneKey()
	self:_updateCurLv()

	self._txtTitle.text = "最近达成"
end

function AchievementrightView:_filterDatas(dataList)
	self._lastDataList = dataList
	self._achievementDatas = {}

	local lastData

	for i, data in ipairs(dataList) do
		local isEnd = AchievementModel.instance:isHasEndOfTask(data.id)

		if not isEnd then
			local status = AchievementModel.instance:getAchievementStatus(data.id)

			if status == 1 then
				table.insert(self._achievementDatas, data)
			elseif lastData == nil then
				table.insert(self._achievementDatas, data)

				lastData = data
			elseif checknumber(lastData.stackType) ~= checknumber(data.stackType) then
				table.insert(self._achievementDatas, data)

				lastData = data
			end
		end
	end
end

function AchievementrightView:_updateCurLv()
	local allProgress = AchievementModel.instance:getProgress(0)
	local lv, cur, total = AchievementModel.instance:getLevelProgress()
	local curLvCfg = AchievementConfig.instance:getLvCfg(lv)
	local nextLvCfg = AchievementConfig.instance:getLvCfg(lv + 1)
	local nextTotalNum = 0

	if nextLvCfg then
		nextTotalNum = nextLvCfg.needPoint
	elseif curLvCfg then
		nextTotalNum = curLvCfg.needPoint
	end

	self._txtTotalProgress.text = string.format("%s/%s", checknumber(allProgress.curProgress), nextTotalNum)
	self._txtCurProgress.text = string.format("%s/%s", cur, total)
	self._imgLvProgress.fillAmount = nextTotalNum > 0 and checknumber(allProgress.curProgress) / nextTotalNum or 0
	self._txtCurLv.text = lv

	local isRed = false

	for i = 1, lv do
		if not AchievementModel.instance:getLevelPrizeGained(i) then
			isRed = true

			break
		end
	end

	goutil.setActive(self._prizeRedPoint, isRed)
end

function AchievementrightView:_achievementNumInView()
	if self._achievementDatas ~= nil then
		return #self._achievementDatas
	else
		return 0
	end
end

function AchievementrightView:_achievementCellSize(view, idx)
	if idx == #self._achievementDatas - 1 then
		return 1000, 145
	else
		return 1000, 130
	end
end

function AchievementrightView:_achievementCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._listCell)
	cell.index = idx

	self:_updateAchievementCell(view, cell)

	return cell
end

function AchievementrightView:_updateAchievementCell(view, cell)
	local idx = cell.index
	local component = AchievementItem.AddOnce(cell.gameObject)

	component:onSetMo(self._achievementDatas[idx + 1])

	return cell
end

function AchievementrightView:_onClickAllPrize()
	UIStateManager.instance:open(ViewName.AchievementReward)
end

function AchievementrightView:_onGainPrize()
	print("onGainPrize")
	table.sort(self._lastDataList, AchievementModel.sortAchievement)
	self:_filterDatas(self._lastDataList)
	self._listView:ReloadData()
	self:_updateBtnOneKey()
end

function AchievementrightView:_onGainLevelPrize()
	self:_updateCurLv()
end

function AchievementrightView:_onClickOneKey()
	AchievementAgent.instance:sendPM_OneKeyGainAchievementPrizeReq()
end

function AchievementrightView:_onOneKeySuccess()
	FloatWordMgr.instance:show("一键领取成功")
	self:_sendInfoReq()
end

function AchievementrightView:_updateBtnOneKey()
	local mo = self._achievementDatas[1]

	goutil.setActive(self._btnOneKey.gameObject, false)

	if mo ~= nil then
		local msg = AchievementModel.instance:getAchivementMsg(mo.id)
		local cur, total = AchievementModel.instance:getAchivementProgress(mo.id)
		local isFinished = AchievementModel.instance:getAchivementIsFinished(mo.id)
		local canReceive = isFinished and msg.gainPrize ~= true

		goutil.setActive(self._btnOneKey.gameObject, canReceive)
	end
end

return AchievementrightView
