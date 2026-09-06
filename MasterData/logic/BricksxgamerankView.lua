-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/view/BricksxgamerankView.lua

module("logic.extensions.bricksxgame.view.BricksxgamerankView", package.seeall)

local BricksxgamerankView = class("BricksxgamerankView", ViewComponent)

function BricksxgamerankView:ctor()
	BricksxgamerankView.super.ctor(self)
end

function BricksxgamerankView:unbindEvents()
	BricksxgamerankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function BricksxgamerankView:bindEvents()
	BricksxgamerankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function BricksxgamerankView:buildUI()
	BricksxgamerankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self._txtMyScore = self:getTxt("content/myRank/txtMyScore")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function BricksxgamerankView:onExit()
	BricksxgamerankView.super.onExit(self)
	self.scrollList:dispose()
end

function BricksxgamerankView:onEnter()
	BricksxgamerankView.super.onEnter(self)

	self._scrollList = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = BricksxgameController.instance:getDeafultActId()
	end

	self.addGEvent(self, GlobalNotify.BRICKSXGAME_INFO_UPDATE, self._refreshUI, self)
	BricksxgameController.instance:sendGetRank(self._activityId)
	self:_refreshUI()
end

function BricksxgamerankView:_refreshUI()
	local info = BricksxgameModel.instance:getRankInfo(self._activityId) or {}

	self._myRank = checknumber(info.myRank)
	self._rankInfo = info.rankInfos or {}
	self.txtmyRank.text = checknumber(self._myRank) > 0 and self._myRank or lang("text_rank_notrank")
	self.txtTip.text = "只显示上榜的前200名"

	self.scrollList:reloadData(self._rankInfo)
	GameUtil.SetActive(self.goEmpty, not self._rankInfo or #self._rankInfo == 0)

	self._txtMyScore.text = "-暂无数据-"

	local info = BricksxgameModel.instance:getInfo(self._activityId)

	if info then
		self._txtMyScore.text = info.score
	end
end

function BricksxgamerankView:_updateCell(view, cell, data, tag)
	local tableview = goutil.findChild(cell, "tableview")
	local tablecell = goutil.findChild(cell, "tablecell")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local imgRank = goutil.findChild(cell, "imgRank")

	GameUtil.SetActive(imgRank, data.rank <= 3)

	if data.rank <= 3 then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)

		txtRank.text = ""
	else
		txtRank.text = data.rank
	end

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	txtName.text = data.headInfo.userName
	txtScore.text = data.value

	local time = math.floor(checknumber(data.time) / 1000)
	local date = GameUtil.time2date(time)

	txtTime.text = string.format("%s.%s %s:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local scrollList = self._scrollList[tableview]

	if not scrollList then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[tableview] = scrollList
	end

	local prizeCfg = BricksxgameConfig.instance:getRankPrizeCfg(self._activityId, data.rank)
	local prize = string.split(prizeCfg.prize, "#")

	scrollList:reloadData(prize)
end

function BricksxgamerankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local tableview = goutil.findChild(cell, "tableview")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local scrollList = self._scrollList[tableview]

	if scrollList then
		scrollList:dispose()
	end
end

function BricksxgamerankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)

	proxy.binder:setEffStatus(false)
end

function BricksxgamerankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return BricksxgamerankView
