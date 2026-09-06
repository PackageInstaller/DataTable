-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonChooseView.lua

module("logic.extensions.bonedragon.view.BoneDragonChooseView", package.seeall)

local BoneDragonChooseView = class("BoneDragonChooseView", ViewComponent)
local FORMATION_NUM = 3

function BoneDragonChooseView:ctor()
	BoneDragonChooseView.super.ctor(self)
end

function BoneDragonChooseView:unbindEvents()
	BoneDragonChooseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnSure)
end

function BoneDragonChooseView:bindEvents()
	BoneDragonChooseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BoneDragonChooseView:buildUI()
	BoneDragonChooseView.super.buildUI(self)

	self._posRootList = {}

	for i = 1, FORMATION_NUM do
		local posCell = self:getGo("pos" .. i)

		table.insert(self._posRootList, posCell)
	end

	self._posCell = self:getGo("posCell")
	self._btnRefresh = self:getGo("btnRefresh")
	self._txtRefresh = self:getTxt("btnRefresh/txt")
	self._imgRefresh = self._btnRefresh:GetComponent(goutil.Type_UIImage)
	self._btnSure = self:getGo("btnSure")
end

function BoneDragonChooseView:onExit()
	BoneDragonChooseView.super.onExit(self)

	for i, posCell in ipairs(self._posRootList) do
		local list = self._posDic[posCell]

		if list then
			for k, formationGo in pairs(list) do
				goutil.destroy(formationGo)
			end
		end

		list = nil
	end

	self._posDic = {}
end

function BoneDragonChooseView:onEnter()
	BoneDragonChooseView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgInfoRes, self._onInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgRefreshFormationRes, self._onRefreshFormationRes, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgSelectFormationRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 488001
	end

	self._curSelectIdx = 1
	self._posDic = {}
	self._actCfg = BoneDragonConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = BoneDragonConfig.instance:getStageCfgs(self._activityId)
	self._refreshTimes = self._actCfg.refreshTimes

	GameUtil.SetActive(self._posCell, false)
	BoneDragonController.instance:sendPM_BoneDragonClgInfoReq(self._activityId)
end

function BoneDragonChooseView:_updateFormationPos()
	local curStageId = 1

	if self._curInfo then
		curStageId = checknumber(self._curInfo.curStageId) + 1
		curStageId = math.min(curStageId, #self._stageCfgs)
	end

	for i = 1, FORMATION_NUM do
		if self._curInfo then
			if not self._curInfo.selectFormationId[i] then
				local formationId = 1
				local positionDic = BoneDragonConfig.instance:getFormationPosDicByStageId(self._activityId, curStageId, formationId)
				local curRootCell = self._posRootList[i]
				local posView = goutil.findChild(curRootCell, "posView")
				local btnChoose = goutil.findChild(curRootCell, "btnChoose")
				local imgSelect = goutil.findChild(curRootCell, "imgSelect")
				local curPosList = self._posDic[curRootCell]

				if curPosList == nil then
					self._posDic[curRootCell] = {}
					curPosList = self._posDic[curRootCell]
				end

				for i = 1, BoneDragonModel.FORMATION_POS_NUM do
					local posCell = curPosList[i]

					if posCell == nil then
						posCell = goutil.cloneAndSetParent(self._posCell, posView.transform, "pos_" .. i)

						table.insert(curPosList, posCell)
					end

					local jobName = positionDic[i]
					local contentGo = goutil.findChild(posCell, "content")
					local imgfinishGo = goutil.findChild(posCell, "imgFinish")

					if jobName then
						local posTextComp = goutil.findChild(posCell, "content/txtPos"):GetComponent(typeof(UIImgNumeralText))
						local iconJobComp = goutil.findChild(posCell, "content/tag/iconJob"):GetComponent(ComponentType.UIImageSpriteChange)
						local txtName = goutil.findChildTextComponent(posCell, "content/tag/txtName")
						local jobId = GameEnum.JobZh[jobName]

						txtName.text = jobName

						posTextComp:SetNum(i)
						iconJobComp:SetState(jobId - 1)
					end

					GameUtil.SetActive(contentGo, jobName ~= nil)
					GameUtil.SetActive(imgfinishGo, jobName ~= nil)
					GameUtil.SetActive(posCell, true)
				end

				GameUtil.SetActive(imgSelect, i == self._curSelectIdx)
				GameUtil.addClickHandler(btnChoose, function()
					self._curSelectIdx = i

					self:_updateFormationPos()
				end, self)
			end
		end
	end
end

function BoneDragonChooseView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function BoneDragonChooseView:_updateData()
	self._info = BoneDragonModel.instance:getInfo(self._activityId)
	self._curInfo = self._info and self._info.curInfo
	self._stageId = 1

	if self._curInfo then
		self._stageId = checknumber(self._curInfo.curStageId) + 1
	end

	self._formationNum = BoneDragonConfig.instance:getFormationNum(self._activityId, self._stageId)
end

function BoneDragonChooseView:_updateUI()
	local refreshFormationTimes = 0

	if self._curInfo then
		refreshFormationTimes = checknumber(self._curInfo.refreshFormationTimes)
	end

	self._txtRefresh.text = string.format("刷新(%d/%d)", self._refreshTimes - refreshFormationTimes, self._refreshTimes)

	GameUtil.SetGray(self._imgRefresh, refreshFormationTimes >= self._refreshTimes)
	self:_updateFormationPos()
end

function BoneDragonChooseView:_onClickBtnRefresh()
	if ((self._curInfo or nil) and checknumber(self._curInfo.refreshFormationTimes)) >= self._refreshTimes then
		FloatWordMgr.instance:show("刷新次数已用完")

		return
	end

	self._curSelectIdx = 1

	BoneDragonController.instance:sendPM_BoneDragonClgRefreshFormationReq(self._activityId, self._stageId)
end

function BoneDragonChooseView:_onClickBtnSure()
	BoneDragonController.instance:sendPM_BoneDragonClgSelectFormationReq(self._activityId, self._stageId, (self._curInfo or nil) and checknumber(self._curInfo.selectFormationId[self._curSelectIdx]))
end

function BoneDragonChooseView:_onRefreshFormationRes()
	BoneDragonController.instance:sendPM_BoneDragonClgInfoReq(self._activityId)
end

function BoneDragonChooseView:_onInfoRes()
	local changeSetId = BoneDragonModel.instance:getChangeSetId(self._activityId)

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	BoneDragonModel.instance:saveChangeSetId(self._activityId)
	self:_onUpdate()
end

return BoneDragonChooseView
