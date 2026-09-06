-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/welfareguidelines/ActivityWelfareGuidelinesView.lua

module("logic.extensions.operationsummary.view.welfareguidelines.ActivityWelfareGuidelinesView", package.seeall)

local ActivityWelfareGuidelinesView = class("ActivityWelfareGuidelinesView", ViewComponent)

function ActivityWelfareGuidelinesView:ctor()
	ActivityWelfareGuidelinesView.super.ctor(self)

	self.curPageId = 1
end

function ActivityWelfareGuidelinesView:buildUI()
	ActivityWelfareGuidelinesView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topColumn/btnClose")
	self._modelCamera = goutil.findChild(self.mainGO, "modelCamera")
	self._bg = goutil.findChild(self.mainGO, "modelCamera/bg")
	self._con = goutil.findChild(self.mainGO, "con")
	self._conObj = nil
	self._role = goutil.findChild(self.mainGO, "role")
	self._avatar = nil
	self._avatarMo = nil
	self._photoEff = nil
	self._pageScrollerGo = goutil.findChild(self.mainGO, "tablePageView")
	self._pageCellGo = goutil.findChild(self.mainGO, "tablePageCell")
	self.pageScrollList = ScrollerList.create(self._pageScrollerGo, self._pageCellGo, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))
	self._rewardScrollerGo = goutil.findChild(self.mainGO, "tableRewardView")
	self._rewardCellGo = goutil.findChild(self.mainGO, "tableRewardCell")
	self.rewardScrollList = ScrollerList.create(self._rewardScrollerGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self.pageCellList = {}
	self.rewardCellList = {}
end

function ActivityWelfareGuidelinesView:onEnter()
	ActivityWelfareGuidelinesView.super.onEnter(self)

	local params = self:getOpenParam()

	self.activityId = checknumber(params[1])

	if self.activityId == 0 then
		printError("活动id错误，无法继续构成界面")

		return
	end

	self.cfg_rewardContent = OperationSummaryConfig.instance:getRewardContentCfg(self.activityId)

	if self.cfg_rewardContent == nil then
		printError(string.format("t_activity_reward_content 配置表缺失,无法继续构成界面(活动id = %s )", self.activityId))

		return
	end

	self.cfg_rewardPage = OperationSummaryConfig.instance:getRewardPageCfg(self.activityId)

	if self.cfg_rewardPage == nil then
		printError("t_activity_reward_page 配置表缺失,无法继续构成界面")

		return
	end

	self:_updateAllUI()
end

function ActivityWelfareGuidelinesView:onEnterFinished()
	self:_loadRole()
end

function ActivityWelfareGuidelinesView:onExit()
	ActivityWelfareGuidelinesView.super.onExit(self)
	self:_removeCon()

	for _, cell in pairs(self.rewardCellList) do
		uGuiUtil.clearImage(cell._icon)
	end

	self.rewardScrollList:dispose()
end

function ActivityWelfareGuidelinesView:bindEvents()
	ActivityWelfareGuidelinesView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function ActivityWelfareGuidelinesView:unbindEvents()
	ActivityWelfareGuidelinesView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for _, cell in pairs(self.rewardCellList) do
		GameUtil.rmClickHandler(cell._jumpBtn)
	end
end

function ActivityWelfareGuidelinesView:destroyUI()
	ActivityWelfareGuidelinesView.super.destroyUI(self)
	self:_clearRole()
end

function ActivityWelfareGuidelinesView:_updateAllUI()
	self:_onUpdatePageScroller()
	self:_onUpdateRewardScroller()
	self:_updatePlaneUI()
end

function ActivityWelfareGuidelinesView:_updatePlaneUI()
	if not self.cfg_rewardPage[self.curPageId] then
		if #self.cfg_rewardPage[self.curPageId] == 0 then
			printError(string.format("无法找到第%d页配置", self.curPageId))

			return
		end

		if self._conObj ~= nil then
			self:_removeCon()
		end

		if self._avatar ~= nil then
			self._avatar:setVisible(false)
		end

		if self.cfg_rewardPage[self.curPageId].isUseRole == true then
			self:_setRole(self.cfg_rewardPage[self.curPageId])
		else
			self:_setCon(self.cfg_rewardPage[self.curPageId])
		end
	end
end

function ActivityWelfareGuidelinesView:_loadRole()
	if self._avatarMo ~= nil or self._avatar ~= nil or self._photoEff ~= nil then
		return
	end

	self._photoEff = AvatarPhotoShow.Get(self._role)

	local avatarSktId = RoleModel.instance:getGender() + 1

	self._avatar, self._avatarMo = AvatarsMgrNew.instance:getAvatarAndMoByCfgId(avatarSktId)

	self._photoEff:setRawWidthAndHeight(1024, 1024)
	self._photoEff:setCameraPosition(0, 1.15, -1)
	self._photoEff:setCamSize(1.65)
	self._photoEff:addShowAvatarEffect(self._avatar, true)
end

function ActivityWelfareGuidelinesView:_setRole(cfg)
	if self._avatarMo == nil or self._avatar == nil or self._photoEff == nil then
		self:_loadRole()
	end

	local curGender = RoleModel.instance:getGender()
	local dressIdArr = string.split(cfg.roleDressIds, "#")
	local curDressIdArr = {}

	for _, str in ipairs(dressIdArr) do
		local strArr = string.split(str, ":")
		local dressGender = checknumber(strArr[1])

		if dressGender == curGender or dressGender == GameEnum.Gender.Neutral then
			curDressIdArr = string.split(strArr[2], ",")

			break
		end
	end

	if #curDressIdArr == 0 then
		-- block empty
	end

	for _, dressId in ipairs(curDressIdArr) do
		self._avatarMo:setDataByCfgId(checknumber(dressId))
	end

	local x = cfg.modelPos[1]
	local y = cfg.modelPos[2]

	Framework.TransformUtil.SetLocalPos(self._role.transform, x, y, 0)

	local scaleX = cfg.modelScale[1]
	local scaleY = cfg.modelScale[2]

	Framework.TransformUtil.SetLocalScale(self._role.transform, scaleX, scaleY, 1)
	self._avatar:updateByMo(self._avatarMo)
	self._avatar:setVisible(true)
end

function ActivityWelfareGuidelinesView:_clearRole()
	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)
	end

	if self._photoEff then
		self._photoEff:clear()
	end

	self._avatar = nil
	self._avatarMo = nil
	self._photoEff = nil
end

function ActivityWelfareGuidelinesView:_setCon(cfg)
	if checknumber(cfg.modelId) == 0 or self._con == nil then
		return
	end

	local scale = cfg.modelScale
	local x = cfg.modelPos[1]
	local y = cfg.modelPos[2]

	self._conObj = RoleObjectPool.instance:addRoleToParent(self._conObj, cfg.modelId, self._con, scale, nil, true, x, y)
end

function ActivityWelfareGuidelinesView:_removeCon()
	RoleObjectPool.instance:removeRole(self._conObj)
end

function ActivityWelfareGuidelinesView:_onUpdatePageScroller()
	self:_setPageDataList()
	self.pageScrollList:refresh()
end

function ActivityWelfareGuidelinesView:_setPageDataList()
	self.pageScrollList:reloadData(self.cfg_rewardPage)
end

function ActivityWelfareGuidelinesView:_updatePageCell(view, cellModel, data, tag)
	local cell = {}

	self.pageCellList[data.pageId] = self.pageCellList[data.pageId] or cell
	cell._mainGo = cellModel
	cell._txtName = goutil.findChild(cell._mainGo, "txtName"):GetComponent(goutil.Type_UIText)
	cell._UIChangeGroup = cell._mainGo:GetComponent("UIChangeGroup")
	cell.data = data

	GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickPageCell, self, cell))

	cell._txtName.text = data.pageName

	if self.curPageId == cell.data.pageId then
		cell._UIChangeGroup:SetState(1)
	else
		cell._UIChangeGroup:SetState(0)
	end
end

function ActivityWelfareGuidelinesView:_clearPageCell()
	return
end

function ActivityWelfareGuidelinesView:_onUpdateRewardScroller()
	self:_setRewardDataList()
	self.rewardScrollList:refresh()
end

function ActivityWelfareGuidelinesView:_setRewardDataList()
	if not self.cfg_rewardContent[self.curPageId] then
		if #self.cfg_rewardContent[self.curPageId] == 0 then
			printError(string.format("无法找到第%d页配置", self.curPageId))
		end

		self.rewardScrollList:reloadData(self.cfg_rewardContent[self.curPageId])
	end
end

function ActivityWelfareGuidelinesView:_updateRewardCell(view, cellModel, data, tag)
	local cell = {}

	self.rewardCellList[data.rewardId] = self.rewardCellList[data.rewardId] or cell
	cell._mainGo = cellModel
	cell._jumpBtn = cell._mainGo:GetComponent(goutil.Type_UIButton)
	cell._txtName = goutil.findChild(cell._mainGo, "txtName"):GetComponent(goutil.Type_UIText)
	cell._icon = goutil.findChild(cell._mainGo, "icon")
	cell.data = data

	GameUtil.rmClickHandler(cell._jumpBtn)
	GameUtil.addClickHandler(cell._jumpBtn, GameUtil.handler(self._onClickRewardCell, self, cell))

	local strArr = string.split(cell.data.fakeId, ":")
	local matType = strArr[1]
	local matId = strArr[2]
	local cfg = MaterialMgr.getMatCfg(matType, matId)
	local bgUrl = GameUrl.getItemIconUrl(cfg.icon)

	uGuiUtil.clearImage(cell._icon)
	uGuiUtil.setSpriteToImage(cell._icon, uGuiUtil.SpriteType.BigBg, bgUrl)

	cell._txtName.text = cfg.name
end

function ActivityWelfareGuidelinesView:_clearRewardCell()
	return
end

function ActivityWelfareGuidelinesView:_onClickBtnClose()
	self:close()
end

function ActivityWelfareGuidelinesView:_onClickPageCell(cell)
	self.curPageId = cell.data.pageId

	self:_updateAllUI()
end

function ActivityWelfareGuidelinesView:_onClickRewardCell(cell)
	local strArr = string.split(cell.data.fakeId, ":")
	local data = {}

	data.type = checknumber(strArr[1])
	data.id = checknumber(strArr[2])

	MaterialMgr.openGetSourceByData(data)
end

return ActivityWelfareGuidelinesView
