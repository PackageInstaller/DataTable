-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementView.lua

module("logic.extensions.achievement.view.AchievementView", package.seeall)

local AchievementView = class("AchievementView", DirectoryView)

function AchievementView:ctor()
	AchievementView.super.ctor(self)
end

function AchievementView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function AchievementView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnAllPrize:AddClickListener(self._onClickAllPrize, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
end

function AchievementView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnAllPrize:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
end

function AchievementView:buildUI()
	AchievementView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._btnHome = self:getBtn("topleft/btnHome")
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
	self.goldBarCon = self:getGo("goldBarCon")
	self._tipsNull = self:getGo("right/tipsNull")
	self._right = self:getGo("right")
	self._btnOneKey = self:getBtn("right/overall/btnOneKey")
end

function AchievementView:destroyUI()
	return
end

function AchievementView:onEnter()
	AchievementView.super.onEnter(self)

	self._isloadInfo = false
	self._reloadFinished = false
	self._initRoot = 1
	self._initLeaf = 0

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor)
	AchievementController.instance:registerLocalNotify("LoadAllAchievement", self._refreshView, self)
	AchievementController.instance:registerLocalNotify("GainAchievementPrize", self._onGainPrize, self)
	AchievementController.instance:registerLocalNotify("GainAchievementLevelPrize", self._onGainLevelPrize, self)

	self._curViewDatas = AchievementConfig.instance:getAllIndexs()
	self._selectedRoot = self._initRoot
	self._selectedLeaf = self._initLeaf

	self:reloadData()
	goutil.setActive(self._right, false)
	AchievementController.instance:sendLoadAllAchievementReq()
	GlobalDispatcher:addListener(GlobalNotify.AchievementOneKeySuccess, self._onOneKeySuccess, self)
end

function AchievementView:_refreshView()
	goutil.setActive(self._right, true)

	self._curViewDatas = AchievementConfig.instance:getAllIndexs()
	self._selectedRoot = self._initRoot
	self._selectedLeaf = self._initLeaf

	self:reloadData()

	self._isloadInfo = true

	self:_refreshPage(self._initRoot, self._initLeaf)
end

function AchievementView:_getDirectoryName(root, leaf)
	local cfg = AchievementConfig.instance:getIndexCfg(root - 1, leaf)

	if cfg ~= nil then
		return cfg.name
	else
		return ""
	end
end

function AchievementView:onEnterFinished()
	return
end

function AchievementView:onExit()
	AchievementView.super.onExit(self)
	AchievementController.instance:unregisterLocalNotify("LoadAllAchievement", self._refreshView, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementPrize", self._onGainPrize, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementLevelPrize", self._onGainLevelPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.AchievementOneKeySuccess, self._onOneKeySuccess, self)
end

function AchievementView:onExitFinished()
	return
end

function AchievementView:_onReloadFinish()
	self._reloadFinished = true

	self._listView:SetOffset(0, false)
end

function AchievementView:_setDefault()
	if not self._reloadFinished or not self._isloadInfo then
		return
	end

	if self._initLeaf and self._initLeaf >= 0 then
		self._initRoot = 1
		self._initLeaf = 0
		self._selectedRoot = self._initRoot
		self._selectedLeaf = self._initLeaf

		self:_onClickCell(self._initRoot, self._initLeaf)
	end
end

function AchievementView:_refreshPage(root, leaf)
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

function AchievementView:_updateListView(root, leaf)
	self._achievementDatas = {}

	local dataList = AchievementConfig.instance:getCfgsByRootAndLeaf(root - 1, leaf)

	for _, data in ipairs(dataList) do
		local isNeedShow = AchievementModel.instance:isNeedShow(data.id)

		if isNeedShow then
			table.insert(self._achievementDatas, data)
		end
	end

	self._listView:ReloadData()

	self._txtTitle.text = self:_getDirectoryName(root, leaf)
end

function AchievementView:_updateOverall()
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

	self._achievementDatas = AchievementModel.instance:getOverallAchievements()

	self._listView:ReloadData()
	self:_updateBtnOneKey()
	self:_updateCurLv()

	self._txtTitle.text = "最近达成"
end

function AchievementView:_updateCurLv()
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

function AchievementView:_achievementNumInView()
	if self._achievementDatas ~= nil then
		return #self._achievementDatas
	else
		return 0
	end
end

function AchievementView:_achievementCellSize(view, idx)
	if idx == #self._achievementDatas - 1 then
		return 1000, 145
	else
		return 1000, 130
	end
end

function AchievementView:_achievementCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._listCell)
	cell.index = idx

	self:_updateAchievementCell(view, cell)

	return cell
end

function AchievementView:_updateAchievementCell(view, cell)
	local idx = cell.index
	local component = AchievementItem.AddOnce(cell.gameObject)

	component:onSetMo(self._achievementDatas[idx + 1])

	return cell
end

function AchievementView:_onClickClose()
	self:close()
end

function AchievementView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function AchievementView:_onClickAllPrize()
	UIStateManager.instance:open(ViewName.AchievementReward)
end

function AchievementView:_onGainPrize()
	print("onGainPrize")
	table.sort(self._achievementDatas, AchievementModel.sortAchievement)
	self._listView:ReloadData()
	self:reloadData()
	self:_updateBtnOneKey()
end

function AchievementView:_onGainLevelPrize()
	self:_updateCurLv()
	self:reloadData()
end

function AchievementView:_onClickOneKey()
	AchievementAgent.instance:sendPM_OneKeyGainAchievementPrizeReq()
end

function AchievementView:_onOneKeySuccess()
	FloatWordMgr.instance:show("一键领取成功")
	self:_refreshView()
end

function AchievementView:_updateBtnOneKey()
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

return AchievementView
