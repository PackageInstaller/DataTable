-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeShowView.lua

module("logic.extensions.badge.view.BadgeShowView", package.seeall)

local BadgeShowView = class("BadgeShowView", ViewComponent)

function BadgeShowView:ctor()
	BadgeShowView.super.ctor(self)
end

function BadgeShowView:unbindEvents()
	BadgeShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BadgeShowView:bindEvents()
	BadgeShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BadgeShowView:buildUI()
	BadgeShowView.super.buildUI(self)

	self._badgeTableView = self:getGo("badgeTableView")
	self._badgeCell = self:getGo("badgeCell")
	self._typeTableView = self:getGo("typeTableView")
	self._typeCell = self:getGo("typeCell")
	self._btnClose = self:getGo("btnClose")
end

function BadgeShowView:onExit()
	BadgeShowView.super.onExit(self)

	self._view = false

	self._badgeTableList:dispose()
	self._typeTableList:dispose()
end

function BadgeShowView:onEnter()
	BadgeShowView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BadgeResRefesh, self.refreshView, self)

	self._badgeTableList = ScrollerList.create(self._badgeTableView, self._badgeCell, GameUtil.handler(self._updateDabgeCell, self), GameUtil.handler(self._clearDabgeCell, self))
	self._typeTableList = ScrollerList.create(self._typeTableView, self._typeCell, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._type = self._type or 0

	local param = self:getOpenParam()

	self._userId = self:getFirstParam()
	self._canCompose = self._canCompose and table.clear(self._canCompose) or {}
	self._readyOpenDadgeId = param and param[2]
	self._view = true

	if self._userId then
		GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._loadAllBadgeInfo, self)
		self:_loadAllBadgeInfo()
	else
		self:refreshView()
	end
end

function BadgeShowView:refreshView()
	self:checkCanCompose()

	local typelist = {
		0
	}
	local typeCfgs = BadgeConfig.instance:getType()

	for i, v in ipairs(typeCfgs.dataList) do
		table.insert(typelist, v.badgeType)
	end

	self._typeTableList:reloadData(typelist)

	local list = {}

	if self._type and self._type > 0 then
		local typeCfg = BadgeConfig.instance:getTypeById(self._type)

		for i, v in ipairs(typeCfg.badgeList) do
			table.insert(list, v)
		end
	else
		local addDeineCfgs = BadgeConfig.instance:getDefine()

		for i, v in ipairs(addDeineCfgs) do
			if v.active == true then
				table.insert(list, v.id)
			end
		end
	end

	table.sort(list, function(a, b)
		if self._canCompose[a] ~= self._canCompose[b] then
			return self._canCompose[a]
		end

		local infoA = BadgeModel.instance:getBadgeInfoById(a)
		local infoB = BadgeModel.instance:getBadgeInfoById(b)

		if not infoA and infoB then
			return false
		elseif infoA and not infoB then
			return true
		end

		local cfgA = BadgeConfig.instance:getDefineById(a)
		local cfgB = BadgeConfig.instance:getDefineById(b)

		if checknumber(cfgA.rank) ~= checknumber(cfgB.rank) then
			return checknumber(cfgA.rank) > checknumber(cfgB.rank)
		else
			return a < b
		end
	end)
	self._badgeTableList:reloadData(list)

	if self._readyOpenDadgeId then
		self:_onClickDabge(self._readyOpenDadgeId)

		self._readyOpenDadgeId = nil
	end
end

function BadgeShowView:_updateDabgeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local badgeBgChange = goutil.findChildComponent(go, "badgeBg", "UIImageSpriteChange")
	local con = goutil.findChild(go, "badgeCon")
	local lock = goutil.findChild(go, "lock")
	local none = goutil.findChild(go, "none")
	local starGroup = goutil.findChild(go, "starLv")
	local btn = goutil.findChild(go, "btn")
	local compose = goutil.findChild(go, "compose")
	local txtCompose = goutil.findChildTextComponent(go, "compose/txt")

	GameUtil.SetActive(none, false)
	GameUtil.SetActive(badgeBgChange, false)
	GameUtil.addClickHandler(btn, function()
		self:_onClickDabge(data)
	end)

	local cfg = BadgeConfig.instance:getDefineById(data)

	txtName.text = cfg.name

	local proxy = MaterialMgr.setCell(MatType.Item_Badge, data, con)

	proxy.binder:setActiveImgC_Bg(false)
	proxy.binder:setAutoTips(false)

	local info = BadgeModel.instance:getBadgeInfoById(data)

	if info and info.latestUpgradeTimeMillis then
		txtTime.text = langPara("%s 获得", GameUtil.formatTimeStamp("%Y/%m/%d", checknumber(info.latestUpgradeTimeMillis) / 1000))

		proxy.binder:setLevel(info.level)
		proxy.binder:setBadgeBg(false)
		GameUtil.SetActive(lock, false)
		proxy.binder:setGray(false)
	else
		txtTime.text = lang("未获得")

		GameUtil.SetActive(lock, false)
		proxy.binder:setGray(true)
	end

	txtCompose.text = info and checknumber(info.level) > 1 and lang("可升级") or lang("可合成")

	local iconGroupCfg = BadgeConfig.instance:getIconGroup(cfg.iconGroupId)

	if info and info.level and iconGroupCfg and not iconGroupCfg[info.level] then
		GameUtil.SetActive(starGroup, true)

		local addLevel = info.level - #iconGroupCfg
		local totalCount = starGroup.transform.childCount
		local iconState = 0

		if addLevel > 0 then
			iconState = math.floor((addLevel - 1) / totalCount)
		end

		addLevel = addLevel - iconState * totalCount

		for i = 1, starGroup.transform.childCount do
			local starGo = goutil.findChild(starGroup, "star_" .. i)
			local starImgChange = starGo:GetComponent(ComponentType.UIImageSpriteChange)

			starImgChange:SetState(iconState)
			GameUtil.SetActive(starGo, i <= addLevel)
		end
	else
		GameUtil.SetActive(starGroup, false)
	end

	if iconGroupCfg and #iconGroupCfg >= 3 then
		GameUtil.setLocalScale(con, 1)
		GameUtil.SetActive(badgeBgChange, true)

		if info then
			badgeBgChange:SetState(math.min(info.level - 1, 2))
		else
			badgeBgChange:SetState(0)
		end
	else
		GameUtil.setLocalScale(con, 1.5)
		GameUtil.SetActive(badgeBgChange, false)
	end

	GameUtil.SetActive(compose, self._canCompose[cfg.id] or false)
end

function BadgeShowView:_clearDabgeCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)

	local con = goutil.findChild(go, "badgeCon")

	MaterialMgr.resetAll(con)
end

function BadgeShowView:_updateTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local changeGroup = go:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(go, "redPoint")

	GameUtil.addClickHandler(go, function()
		self:_onClickTypeTab(data)
	end)

	local hasCompose = false

	if data == 0 then
		txtName.text = lang("全部")

		for i, v in pairs(self._canCompose) do
			if v == true then
				hasCompose = true

				break
			end
		end
	else
		local typeCfg = BadgeConfig.instance:getTypeById(data)

		txtName.text = typeCfg.typeName

		for i, v in ipairs(typeCfg.badgeList) do
			if self._canCompose[v] == true then
				hasCompose = true

				break
			end
		end
	end

	if self._type == data then
		changeGroup:SetState(1)
	else
		changeGroup:SetState(0)
	end

	GameUtil.SetActive(redPoint, hasCompose)
end

function BadgeShowView:_clearTypeCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function BadgeShowView:_onClickDabge(badgeId)
	if not self._userId or self._userId == RoleModel.instance:getUserId() then
		UIStateManager.instance:push(ViewName.BadgeDetailView, badgeId)
	end
end

function BadgeShowView:_onClickTypeTab(typeId)
	self._type = typeId

	self:refreshView()
end

function BadgeShowView:_loadAllBadgeInfo()
	BadgeAgent.instance:sendPM_LoadAllBadgeReq(self._userId, function(msg)
		BadgeModel.instance:setBadgeInfo(msg.info)

		if not self._view then
			return
		end

		self:refreshView()
	end)
end

function BadgeShowView:checkCanCompose()
	self._canCompose = self._canCompose and table.clear(self._canCompose) or {}

	if self._userId and self._userId ~= RoleModel.instance:getUserId() then
		return
	end

	for i, cfg in ipairs(BadgeConfig.instance:getDefine()) do
		local info = BadgeModel.instance:getBadgeInfoById(cfg.id)

		if not string.nilorempty(cfg.piece) then
			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.piece)

			if info then
				if not (info.level + 1) then
					local targetLevel = 1
					local levelCfg = BadgeConfig.instance:getLevelCfg(cfg.levelPlanId, targetLevel)

					if levelCfg and MaterialModel.instance:IsEnough(matType, matId, levelCfg.count) == true then
						self._canCompose[cfg.id] = true
					elseif targetLevel == 1 and not info and MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
						self._canCompose[cfg.id] = true
					end
				end
			end
		end
	end
end

return BadgeShowView
