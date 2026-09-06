-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushRankView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushRankView", package.seeall)

local AbyssGoldRushRankView = class("AbyssGoldRushRankView", ViewComponent)

function AbyssGoldRushRankView:ctor()
	AbyssGoldRushRankView.super.ctor(self)
end

function AbyssGoldRushRankView:buildUI()
	AbyssGoldRushRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "tableView")
	self._ranktableCell = goutil.findChild(self.mainGO, "tableCell")
	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "empty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyStep = self:getTxt("myRank/txtMyStep")
	self._tabTableview = self:getGo("tabTableview")
	self._tabTableCell = self:getGo("tabTableview/tabTableCell")
	self._tabTableList = ScrollerList.create(self._tabTableview, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rewardGo = self:getGo("reward")
	self._txtTip = self:getTxt("myRank/txtTip")
	self._txtScore = self:getTxt("title/txtScore")
end

function AbyssGoldRushRankView:bindEvents()
	AbyssGoldRushRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AbyssGoldRushRankView:unbindEvents()
	AbyssGoldRushRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AbyssGoldRushRankView:destroyUI()
	AbyssGoldRushRankView.super.destroyUI(self)
end

function AbyssGoldRushRankView:onEnter()
	AbyssGoldRushRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushRankViewRes, self._refreshView, self)

	self._curTab = nil
	self._itemTableListDir = {}

	self:_onClickTab(1)
end

function AbyssGoldRushRankView:onExit()
	AbyssGoldRushRankView.super.onExit(self)
	self._rankTable:dispose()

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end
end

function AbyssGoldRushRankView:_refreshView()
	local rankInfo = AbyssGoldRushModel.instance:getRankInfo()

	if rankInfo then
		if not rankInfo.rankList then
			local rankList = {}

			self._rankTable:reloadData(rankList)
			GameUtil.SetActive(self._emptyGo, #rankList <= 0)

			self._txtMyRank.text = rankInfo.myRank <= 0 and lang("未上榜") or rankInfo.myRank

			local tabList = {
				1,
				2
			}

			self._tabTableList:reloadData(tabList)

			local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)

			if self._curTab == 1 then
				self._txtTip.text = actCfg.goldRankTipDesc
				self._txtScore.text = lang("游园币")
			elseif self._curTab == 2 then
				self._txtTip.text = actCfg.scoreRankTipDesc
				self._txtScore.text = lang("积分")
			end
		end
	end
end

function AbyssGoldRushRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local itemTableView = goutil.findChild(go, "rewardView")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = checknumber(rankInfo.value)

	local date = GameUtil.time2date(checknumber(rankInfo.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local prizeArray = {}
	local rankPrizeCfgs = AbyssGoldRushConfig.instance:getGoldRankPrizeCfgs(self._activityId)

	for k, v in pairs((self._curTab == 2 or nil) and AbyssGoldRushConfig.instance:getScoreRankPrizeCfgs(self._activityId)) do
		if v.rankRange[1] <= rankInfo.rank and v.rankRange[2] >= rankInfo.rank then
			prizeArray = string.split(v.prize, "#")

			break
		end
	end

	if itemTableView and self._rewardGo then
		if not self._itemTableListDir[itemTableView] then
			local itemTableList = ScrollerList.create(itemTableView, self._rewardGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

			self._itemTableListDir[itemTableView]:reloadData(prizeArray)
		end
	end
end

function AbyssGoldRushRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local itemTableView = goutil.findChild(go, "rewardView")

	HeadItemController.instance:resetHeadCell(imgIcon)

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function AbyssGoldRushRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AbyssGoldRushRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AbyssGoldRushRankView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtNorGo = goutil.findChild(go, "txtNorGo")
	local imgNor = goutil.findChild(go, "imgNor")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtSelectGo = goutil.findChild(go, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(txtSelectGo, "txt")
	local txtNorSelect = goutil.findChildTextComponent(txtNorGo, "txt")

	if data == 1 then
		txtSelect.text = lang("游园币榜")
		txtNorSelect.text = lang("游园币榜")
	else
		txtSelect.text = lang("积分榜")
		txtNorSelect.text = lang("积分榜")
	end

	GameUtil.SetActive(txtNorGo, data ~= self._curTab)
	GameUtil.SetActive(imgNor, data ~= self._curTab)
	GameUtil.SetActive(imgSelect, data == self._curTab)
	GameUtil.SetActive(txtSelectGo, data == self._curTab)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickTab(data)
	end)
end

function AbyssGoldRushRankView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function AbyssGoldRushRankView:_onClickTab(tabIndex)
	if self._curTab ~= tabIndex then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushRankViewReq(self._activityId, tabIndex)

		self._curTab = tabIndex
	end
end

return AbyssGoldRushRankView
