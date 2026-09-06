-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanrankView.lua

module("logic.extensions.beastrichman.view.BeastrichmanrankView", package.seeall)

local BeastrichmanrankView = class("BeastrichmanrankView", ViewComponent)

function BeastrichmanrankView:ctor()
	BeastrichmanrankView.super.ctor(self)
end

function BeastrichmanrankView:buildUI()
	BeastrichmanrankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txt3 = self:getTxt("container/title/txt3")
	self._txtMyRank = self:getTxt("container/myRank/txtMyRank")
	self._txtMyScore = self:getTxt("container/myRank/txtMyScore")
	self._myRewardCell = self:getGo("container/myRank/myRewardList/item")
	self._myRewardTableview = self:getGo("container/myRank/myRewardList")
	self._myRewardScrollList = ScrollerList.create(self._myRewardTableview, self._myRewardCell, GameUtil.handler(self._updateMyRewardCell, self), GameUtil.handler(self._clearMyRewardCell, self))
	self._rankCell = self:getGo("container/cell")
	self._rankTableview = self:getGo("container/tableview")
	self._rankScrollList = ScrollerList.create(self._rankTableview, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("container/empty")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerListTab = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BeastrichmanrankView:bindEvents()
	BeastrichmanrankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function BeastrichmanrankView:unbindEvents()
	BeastrichmanrankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function BeastrichmanrankView:onEnter()
	BeastrichmanrankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManTotalRankInfoRes, self._onRankInfoRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManScoreRankInfoRes, self._onRankInfoRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManSubRankInfoRes, self._onRankInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())
	self._txtMyRank.text = "未上榜"
	self._txtMyScore.text = 0

	goutil.setActive(self._emptyGo, false)

	self._currTabId = self._currTabId or 1

	self:_updateTabs()
end

function BeastrichmanrankView:onExit()
	BeastrichmanrankView.super.onExit(self)
	self._myRewardScrollList:dispose()
	self._rankScrollList:dispose()
	self._scrollerListTab:dispose()

	if self._subCellScrollList then
		for i, v in ipairs(self._subCellScrollList) do
			v:dispose()
		end

		self._subCellScrollList = nil
	end
end

function BeastrichmanrankView:_updateTabs()
	local cfgs = BeastRichmanConfig.instance:getRankViewCfgs(self._activityId)

	self._scrollerListTab:reloadData(cfgs)
	self:_onClickTab(self._currTabId)
end

function BeastrichmanrankView:_onRankInfoRes()
	self:_initMyRank()
	self:_initAllRanks()
end

function BeastrichmanrankView:_initAllRanks()
	local cfg = BeastRichmanConfig.instance:getRankViewCfg(self._activityId, self._currTabId)
	local info = BeastRichmanModel.instance:getRankInfo(self._activityId, cfg.tabType)

	if info then
		if not info.rankInfoList then
			local list = {}

			self._rankScrollList:reloadData(list)
			goutil.setActive(self._emptyGo, #list == 0)

			local myScore = 0

			if cfg.tabType == BeastRichManEnum.RankTabType.Total then
				local bossCfgs = BeastRichmanConfig.instance:getBossCfgs(self._activityId)

				for i, v in ipairs(bossCfgs) do
					local info = BeastRichmanModel.instance:getBossInfo(self._activityId, v.bossId)

					if info then
						myScore = myScore + BeastRichmanConfig.instance:getBossRankScoreByDamage(self._activityId, v.bossId, info.historyDamage)
					end
				end

				local stages = BeastRichmanModel.instance:getStageBossInfos(self._activityId)

				for i, v in ipairs(stages or {}) do
					myScore = myScore + BeastRichmanConfig.instance:getBreamRankScoreByDamage(self._activityId, v.bossId, v.stageId)
				end
			elseif cfg.tabType == BeastRichManEnum.RankTabType.Sub then
				local arr = string.split(cfg.param, "#")
				local bossType = checknumber(arr[1])
				local bossId = checknumber(arr[2])

				if bossType == BeastRichManEnum.BossType.Boss then
					local info = BeastRichmanModel.instance:getBossInfo(self._activityId, bossId)

					if info then
						myScore = BeastRichmanConfig.instance:getBossRankScoreByDamage(self._activityId, bossId, info.historyDamage)
					end
				elseif bossType == BeastRichManEnum.BossType.Break then
					local info = BeastRichmanModel.instance:getStageInfo(self._activityId, bossId)

					if info then
						myScore = BeastRichmanConfig.instance:getBreamRankScoreByDamage(self._activityId, bossId, info.stageId)
					end
				end
			else
				local myUserId = checknumber(RoleModel.instance:getUserId())

				for i, v in ipairs(list) do
					if checknumber(v.headInfo.userId) == myUserId then
						myScore = v.value

						break
					end
				end
			end

			self._txtMyScore.text = myScore
		end
	end
end

function BeastrichmanrankView:_initMyRank()
	local cfg = BeastRichmanConfig.instance:getRankViewCfg(self._activityId, self._currTabId)
	local info = BeastRichmanModel.instance:getRankInfo(self._activityId, cfg.tabType)

	if info then
		if not info.myRank then
			local myRank = 0

			self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

			local list = BeastRichmanConfig.instance:getRankRewardStrList(myRank, self._activityId, cfg.tabType)

			self._myRewardScrollList:reloadData(list)
		end
	end
end

function BeastrichmanrankView:_updateMyRewardCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function BeastrichmanrankView:_clearMyRewardCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

function BeastrichmanrankView:_updateRankCell(view, cell, data, tag)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local imgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local head = goutil.findChild(cell.gameObject, "head")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txt1")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txt2")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txt3")
	local tableview = goutil.findChild(cell.gameObject, "tableview")
	local tcell = goutil.findChild(cell.gameObject, "item")
	local scrollList = self:_getScrollList(tableview, tcell)
	local cfg = BeastRichmanConfig.instance:getRankViewCfg(self._activityId, self._currTabId)
	local list = BeastRichmanConfig.instance:getRankRewardStrList(data.rank, self._activityId, cfg.tabType)

	scrollList:reloadData(list)

	if data.rank >= 1 and data.rank <= 3 then
		goutil.setActive(txtRank.gameObject, false)
		goutil.setActive(imgRank.gameObject, true)

		txtRank.text = ""

		imgRank:SetState(data.rank - 1)
	else
		goutil.setActive(txtRank.gameObject, true)
		goutil.setActive(imgRank.gameObject, false)

		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtScore.text = data.value

	local timeStamp = checknumber(data.time) / 1000

	txtTime.text = GameUtil.formatTimeStamp("%Y-%m-%d\n%H:%M:%S", timeStamp)
end

function BeastrichmanrankView:_clearRankCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, ProjectAshRankItem)
	local head = goutil.findChild(cell.gameObject, "head")

	cls:reset()
	HeadItemController.instance:resetHeadCell(head)
end

function BeastrichmanrankView:_updateCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local imgChangeImgBg = goutil.findChild(cell.gameObject, "imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	imgChangeImgBg:SetState(self._currTabId == data.tabId and 0 or 1)

	txtName.text = data.name

	btn:AddClickListener(function()
		self:_onClickTab(data.tabId)
	end)
end

function BeastrichmanrankView:_clearCell(cell)
	return
end

function BeastrichmanrankView:_onClickTab(tabId)
	self._currTabId = tabId

	self._scrollerListTab:refresh()
	self:_sendGetRankInfo()

	self._txt3.text = "累计积分"

	if tabId == 2 then
		self._txt3.text = "历史最高收益"
	end
end

function BeastrichmanrankView:_sendGetRankInfo()
	local cfg = BeastRichmanConfig.instance:getRankViewCfg(self._activityId, self._currTabId)

	if cfg.tabType == BeastRichManEnum.RankTabType.Total then
		BeastRichmanAgent.instance:sendPM_BeastRichManTotalRankInfoReq(self._activityId)
	elseif cfg.tabType == BeastRichManEnum.RankTabType.Score then
		BeastRichmanAgent.instance:sendPM_BeastRichManScoreRankInfoReq(self._activityId, self._currTabId)
	elseif cfg.tabType == BeastRichManEnum.RankTabType.Sub then
		local arr = string.split(cfg.param, "#")
		local bossType = checknumber(arr[1])
		local subType = checknumber(arr[2])

		BeastRichmanAgent.instance:sendPM_BeastRichManSubRankInfoReq(self._activityId, bossType, subType)
	end
end

function BeastrichmanrankView:_getScrollList(tableview, cell)
	self._subCellScrollList = self._subCellScrollList or {}

	local scrollList = self._subCellScrollList[tableview]

	if not scrollList then
		scrollList = ScrollerList.create(tableview, cell, GameUtil.handler(self._updateRankRewardCell, self), GameUtil.handler(self._clearRankRewardCell, self))
		self._subCellScrollList[tableview] = scrollList
	end

	return scrollList
end

function BeastrichmanrankView:_updateRankRewardCell(view, cell, data, tag)
	local node = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function BeastrichmanrankView:_clearRankRewardCell(cell)
	local node = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(node)
end

return BeastrichmanrankView
