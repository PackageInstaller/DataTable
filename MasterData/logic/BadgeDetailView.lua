-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeDetailView.lua

module("logic.extensions.badge.view.BadgeDetailView", package.seeall)

local BadgeDetailView = class("BadgeDetailView", ViewComponent)

BadgeDetailView.SOURCETITLE = 1
BadgeDetailView.SOURCECONTENT = 2

function BadgeDetailView:ctor()
	BadgeDetailView.super.ctor(self)
end

function BadgeDetailView:unbindEvents()
	BadgeDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSource)
	GameUtil.rmClickHandler(self._btnDetail)
end

function BadgeDetailView:bindEvents()
	BadgeDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSource, self._onClikSource, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClikDetail, self)
end

function BadgeDetailView:buildUI()
	BadgeDetailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._sourceTableView = self:getGo("source/tableview")
	self._sourceContentTableCell = self:getGo("source/contentTableCell")
	self._sourceTitleTableCell = self:getGo("source/titleTableCell")
	self._sourceEmptyGo = self:getGo("source/emptyGo")
	self._detailTableView = self:getGo("detail/tableview")
	self._detailTableCell = self:getGo("detail/tableCell")
	self._singleCell = self:getGo("detail/singleCell")
	self._btnSource = self:getGo("btnSource")
	self._changeSource = self._btnSource:GetComponent(ComponentType.UIChangeGroup)
	self._btnDetail = self:getGo("btnDetail")
	self._changeDetail = self._btnDetail:GetComponent(ComponentType.UIChangeGroup)
	self._redPointDetail = self:getGo("btnDetail/redPoint")
	self._source = self:getGo("source")
	self._detail = self:getGo("detail")
end

function BadgeDetailView:onExit()
	BadgeDetailView.super.onExit(self)
	self._detailTableList:dispose()
end

function BadgeDetailView:onEnter()
	BadgeDetailView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BadgeResRefesh, self._refreshView, self)

	self._detailTableList = ScrollerList.create(self._detailTableView, self._detailTableCell, GameUtil.handler(self._updateDetailCell, self), GameUtil.handler(self._clearDetailCell, self))
	self._sourceTableList = ScrollerList.create(self._sourceTableView, {
		self._sourceTitleTableCell,
		self._sourceContentTableCell
	}, GameUtil.handler(self._updateSourceCell, self), GameUtil.handler(self._clearSourceCell, self))

	self._sourceTableList:regGetCellSize(GameUtil.handler(self._getSourceCellSizeCallBack, self))
	self._sourceTableList:regGetTagByIdx(GameUtil.handler(self._getSourceTagByIdx, self))

	self._badgeId = self:getFirstParam()
	self._cfg = BadgeConfig.instance:getDefineById(self._badgeId)
	self._info = BadgeModel.instance:getBadgeInfoById(self._badgeId)

	GameUtil.SetActive(self._detailTableView, false)
	GameUtil.SetActive(self._singleCell, false)
	self:_onClikDetail()
	BadgeController.instance:sendPM_GetBadgeUpgradeLogsReq(self._badgeId)
	AchievementController.instance:sendLoadAllAchievementReq()
end

function BadgeDetailView:_refreshView()
	self._info = BadgeModel.instance:getBadgeInfoById(self._badgeId)

	self:_refreshDetail()
	self:_refreshSource()
end

function BadgeDetailView:_refreshDetail()
	self._log = BadgeModel.instance:getLog(self._badgeId)

	GameUtil.SetActive(self._detailTableView, false)
	GameUtil.SetActive(self._singleCell, false)

	self._pieceCount = 0

	if not string.nilorempty(self._cfg.piece) then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._cfg.piece)

		self._pieceCount = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end

	self._maxLevel = 1

	GameUtil.SetActive(self._redPointDetail, false)

	if checknumber(self._cfg.levelPlanId) > 0 then
		local levelCfg = BadgeConfig.instance:getLevelPlan(self._cfg.levelPlanId)

		self._maxLevel = #levelCfg

		if self._maxLevel > 1 then
			GameUtil.SetActive(self._detailTableView, true)
			self._detailTableList:reloadData(levelCfg)

			if #levelCfg > 0 and self._info then
				if levelCfg[self._info.level + 1] and levelCfg[self._info.level + 1].count <= self._pieceCount then
					self._detailTableList:MoveCellToCenter(self._info.level or 0)
				else
					self._detailTableList:MoveCellToCenter(self._info.level - 1 or 0)
				end
			else
				self._detailTableList:MoveCellToCenter(0)
			end
		else
			GameUtil.SetActive(self._singleCell, true)
			self:_updateDetailInfoCell(self._singleCell, 1)
		end

		if not self._info or not (self._info.level + 1) then
			-- block empty
		end
	else
		GameUtil.SetActive(self._singleCell, true)
		self:_updateDetailInfoCell(self._singleCell, 1)
	end
end

function BadgeDetailView:_refreshSource()
	local sourceList = {}
	local sourceCfg = BadgeConfig.instance:getSourceCfg(self._badgeId)

	if sourceCfg and #sourceCfg > 0 then
		GameUtil.SetActive(self._sourceTableView, true)
		GameUtil.SetActive(self._sourceEmptyGo, false)

		local sourceTypeMap = {}
		local typeIdList = {}
		local typeIdMap = {}

		for i, v in ipairs(sourceCfg) do
			sourceTypeMap[v.typeId] = sourceTypeMap[v.typeId] or {}

			table.insert(sourceTypeMap[v.typeId], v)

			if not typeIdMap[v.typeId] then
				table.insert(typeIdList, v.typeId)
			end

			typeIdMap[v.typeId] = true
		end

		table.sort(typeIdList, function(a, b)
			return a < b
		end)

		for i, v in pairs(sourceTypeMap) do
			table.sort(v, function(a, b)
				local isReachA = false
				local isReachB = false
				local isFinishA = false
				local isFinishB = false

				if a.achievementId > 0 then
					local cur, total = AchievementModel.instance:getAchivementProgress(a.achievementId)

					isFinishA = AchievementModel.instance:getAchievementStatus(a.achievementId) == 1
					isReachA = total <= cur
				end

				if b.achievementId > 0 then
					local cur, total = AchievementModel.instance:getAchivementProgress(b.achievementId)

					isFinishB = AchievementModel.instance:getAchievementStatus(b.achievementId) == 1
					isReachB = total <= cur
				end

				if isFinishA ~= isFinishB then
					return isFinishB
				elseif isReachA ~= isReachB then
					return isReachB
				else
					return a.indexId < b.indexId
				end
			end)
		end

		local nameList = {
			"成就",
			"挑战",
			"玩法"
		}

		for i, v in ipairs(typeIdList) do
			table.insert(sourceList, {
				isTitle = true,
				name = nameList[v]
			})

			for j, cfg in ipairs(sourceTypeMap[v]) do
				table.insert(sourceList, {
					cfg = cfg
				})
			end
		end
	else
		GameUtil.SetActive(self._sourceTableView, false)
		GameUtil.SetActive(self._sourceEmptyGo, true)
	end

	self._sourceTableList:reloadData(sourceList)
end

function BadgeDetailView:_updateDetailCell(view, cell, data, tag)
	local go = cell.gameObject
	local infoGo = goutil.findChild(go, "infoCell")
	local arrowGo = goutil.findChild(go, "imgArrow")

	self:_updateDetailInfoCell(infoGo, data.level)
	GameUtil.SetActive(arrowGo, data.level < self._maxLevel)
end

function BadgeDetailView:_clearDetailCell(cell)
	local go = cell.gameObject

	self:_clearDetailInfoCell(go)
end

function BadgeDetailView:_updateDetailInfoCell(go, level)
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local btnCompose = goutil.findChild(go, "btnCompose")
	local txtTip = goutil.findChildTextComponent(go, "txtTip")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local imgGain = goutil.findChild(go, "imgGain")
	local badgeBgChange = goutil.findChildComponent(go, "badgeBg", "UIImageSpriteChange")
	local con = goutil.findChild(go, "con")
	local starGroup = goutil.findChild(go, "starLv")

	txtName.text = self._cfg.name
	txtTip.text = self._cfg.tip

	GameUtil.SetActive(badgeBgChange, false)

	local proxy = MaterialMgr.setCell(MatType.Item_Badge, self._badgeId, con)

	proxy.binder:setActiveImgC_Bg(false)
	proxy.binder:setAutoTips(false)
	proxy.binder:setLevel(level)
	proxy.binder:setBadgeBg(false)
	GameUtil.rmClickHandler(btnCompose)

	if self._log and self._log.upgradeTimeMillis and self._log.upgradeTimeMillis[level] then
		GameUtil.SetActive(imgGain, true)

		txtDesc.text = langPara("%s 获得", GameUtil.formatTimeStamp("%Y/%m/%d", checknumber(self._log.upgradeTimeMillis[level]) / 1000))

		GameUtil.SetActive(btnCompose, false)
		proxy.binder:setGray(false)
	elseif checknumber(self._cfg.levelPlanId) > 0 then
		proxy.binder:setGray(true)

		local levelCfg = BadgeConfig.instance:getLevelCfg(self._cfg.levelPlanId, level)

		GameUtil.SetActive(imgGain, false)

		local isEnough = self._pieceCount >= levelCfg.count

		txtDesc.text = isEnough == true and langPara("(<color=#009E28FF>%d</color>/%d)", self._pieceCount, levelCfg.count) or langPara("(<color=#FF4559FF>%d</color>/%d)", self._pieceCount, levelCfg.count)

		if self._info and self._info.level + 1 == level or level == 1 then
			GameUtil.SetActive(btnCompose, true)
			GameUtil.addClickHandler(btnCompose, function()
				self:_onClickCompose()
			end)
		else
			GameUtil.SetActive(btnCompose, false)
		end
	else
		txtDesc.text = lang("未获得")

		GameUtil.SetActive(btnCompose, false)
		GameUtil.SetActive(imgGain, false)
		proxy.binder:setGray(true)
	end

	local iconGroupCfg = BadgeConfig.instance:getIconGroup(self._cfg.iconGroupId)

	if iconGroupCfg and not iconGroupCfg[level] then
		GameUtil.SetActive(starGroup, true)

		local addLevel = level - #iconGroupCfg
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
		GameUtil.SetActive(badgeBgChange, true)

		if level then
			badgeBgChange:SetState(math.min(level - 1, 2))
		else
			badgeBgChange:SetState(0)
		end

		GameUtil.setLocalScale(con, 1)
	else
		GameUtil.setLocalScale(con, 1.5)
		GameUtil.SetActive(badgeBgChange, false)
	end
end

function BadgeDetailView:_clearDetailInfoCell(go)
	local btnCompose = goutil.findChild(go, "btnCompose")
	local con = goutil.findChild(go, "con")

	GameUtil.rmClickHandler(btnCompose)
	MaterialMgr.resetAll(con)
end

function BadgeDetailView:_updateSourceCell(view, cell, data, tag)
	if tag == BadgeDetailView.SOURCETITLE then
		self:_updateSourceTitle(cell, data)
	else
		self:_updateSourceContent(cell, data)
	end
end

function BadgeDetailView:_clearSourceCell(cell)
	local go = cell.gameObject
	local prize = goutil.findChild(go, "items")
	local btnJumpTo = goutil.findChild(go, "btnJumpTo")

	if prize then
		for i = 1, prize.transform.childCount do
			local prizeCon = goutil.findChild(prize, "" .. i)

			if prizeCon then
				MaterialMgr.resetAll(prizeCon)
			end
		end
	end

	if btnJumpTo then
		GameUtil.rmClickHandler(btnJumpTo)
	end
end

function BadgeDetailView:_updateSourceTitle(cell, data)
	local go = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")

	txtTitle.text = data.name
end

function BadgeDetailView:_updateSourceContent(cell, data)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtContent = goutil.findChildTextComponent(go, "txtContent")
	local prize = goutil.findChild(go, "items")
	local progress = goutil.findChild(go, "progress")
	local txtProgress = goutil.findChildTextComponent(progress, "txtProgress")
	local finishGo = goutil.findChild(go, "txtFinishTime")
	local btnJumpTo = goutil.findChild(go, "btnJumpTo")
	local txtJumpTo = goutil.findChildTextComponent(go, "btnJumpTo/Text")
	local cfg = data.cfg

	txtName.text = cfg.name
	txtContent.text = cfg.desc

	local isLinkAchievement = checknumber(cfg.achievementId) > 0
	local isFinish = isLinkAchievement and AchievementModel.instance:getAchievementStatus(cfg.achievementId) == 1 or false

	GameUtil.SetActive(progress, isLinkAchievement and not isFinish)
	GameUtil.SetActive(finishGo, isFinish)

	if isLinkAchievement and not isFinish then
		local cur, total = AchievementModel.instance:getAchivementProgress(cfg.achievementId)

		txtProgress.text = langPara("<color=#6F7D9CFF>%d</color>/%d", cur, total)
	else
		txtProgress.text = ""
	end

	GameUtil.rmClickHandler(btnJumpTo)
	GameUtil.addClickHandler(btnJumpTo, function()
		if isLinkAchievement and AchievementModel.instance:getAchievementStatus(cfg.achievementId) == 3 then
			GotoMgr.gotoByString("func#5#7")
			self:close()
		else
			GotoMgr.gotoByString(cfg.jumpTo)
			self:close()
		end
	end)

	txtJumpTo.text = isLinkAchievement and AchievementModel.instance:getAchievementStatus(cfg.achievementId) == 3 and lang("前往领取") or lang("前往获取")

	GameUtil.SetActive(btnJumpTo, not isFinish and not string.nilorempty(cfg.jumpTo))

	local prizeList = {}

	if not string.nilorempty(cfg.prize) then
		prizeList = string.split(cfg.prize, "#")
	elseif isLinkAchievement then
		local achievementCfg = AchievementConfig.instance:getCfgById(cfg.achievementId)

		if not string.nilorempty(achievementCfg.prize) then
			prizeList = string.split(achievementCfg.prize, "#")
		end
	end

	for i = 1, prize.transform.childCount do
		local prizeCon = goutil.findChild(prize, "" .. i)

		if prizeCon then
			if prizeList[i] then
				MaterialMgr.setCellByCfg(prizeList[i], prizeCon)
			else
				MaterialMgr.resetAll(prizeCon)
			end
		end
	end
end

function BadgeDetailView:_getSourceTagByIdx(data, idx)
	if not data.isTitle then
		return BadgeDetailView.SOURCECONTENT
	else
		return BadgeDetailView.SOURCETITLE
	end
end

function BadgeDetailView:_getSourceCellSizeCallBack(view, idx)
	local data = self._sourceTableList:getData()

	if not data[idx + 1].isTitle then
		return GameUtil.getWidth(self._sourceContentTableCell), GameUtil.getHeight(self._sourceContentTableCell)
	else
		return GameUtil.getWidth(self._sourceTitleTableCell), GameUtil.getHeight(self._sourceTitleTableCell)
	end
end

function BadgeDetailView:_onClickCompose()
	if self._info then
		local levelCfg = BadgeConfig.instance:getLevelCfg(self._cfg.levelPlanId, self._info.level + 1 or 1)

		if levelCfg then
			if self._pieceCount >= levelCfg.count then
				local matType, matId, matNum = MaterialMgr.getMatParams(self._cfg.piece)
				local matName = MaterialMgr.getMaterialsName(matType, matId)
				local content = langPara("是否消耗%d%s合成1个%s", levelCfg.count, matName, self._cfg.name)

				TipsFacade.instance:openPopupCostMatViewNew(matType, matId, levelCfg.count, content, function()
					BadgeAgent.instance:sendPM_ComposeOrUpgradeBadgeReq(self._badgeId)
				end)
			else
				FloatWordMgr.instance:show(lang("数量不足"))
			end
		elseif not string.nilorempty(self._cfg.piece) then
			local matType, matId, matNum = MaterialMgr.getMatParams(self._cfg.piece)

			if matNum <= self._pieceCount then
				local matName = MaterialMgr.getMaterialsName(matType, matId)
				local content = langPara("是否消耗%d%s合成1个%s", matNum, matName, self._cfg.name)

				TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
					BadgeAgent.instance:sendPM_ComposeOrUpgradeBadgeReq(self._badgeId)
				end)
			else
				FloatWordMgr.instance:show(lang("数量不足"))
			end
		else
			FloatWordMgr.instance:show(lang("已无法升级"))
		end
	end
end

function BadgeDetailView:_onClikSource()
	GameUtil.SetActive(self._source, true)
	self._changeSource:SetState(1)
	GameUtil.SetActive(self._detail, false)
	self._changeDetail:SetState(0)
end

function BadgeDetailView:_onClikDetail()
	GameUtil.SetActive(self._source, false)
	self._changeSource:SetState(0)
	GameUtil.SetActive(self._detail, true)
	self._changeDetail:SetState(1)
end

return BadgeDetailView
