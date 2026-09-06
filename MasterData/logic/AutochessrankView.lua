-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessrankView.lua

module("logic.extensions.autochess.view.AutochessrankView", package.seeall)

local AutochessrankView = class("AutochessrankView", ViewComponent)

function AutochessrankView:ctor()
	AutochessrankView.super.ctor(self)

	self._scrollList = {}
end

function AutochessrankView:unbindEvents()
	AutochessrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function AutochessrankView:bindEvents()
	AutochessrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function AutochessrankView:buildUI()
	AutochessrankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AutochessrankView:onExit()
	AutochessrankView.super.onExit(self)
	self.scrollList:dispose()
end

function AutochessrankView:onEnter()
	AutochessrankView.super.onEnter(self)
	self.addGEvent(self, AutoChessAgent.ACRankInfoRes, self._onACRankInfoRes, self)
	self:refreshUI()

	self._activityId = AutochessModel.instance:getActivityId()

	AutoChessAgent.instance:sendPM_ACRankInfoReq(self._activityId)
end

function AutochessrankView:refreshUI()
	self.txtmyRank.text = checknumber(self._myRank) > 0 and self._myRank or lang("text_rank_notrank")
	self.txtTip.text = AnnimatchConfig.instance:getCommonByKey("RANK_VIEW_DESC")

	self.scrollList:reloadData(self._rankInfo)
	GameUtil.SetActive(self.goEmpty, not self._rankInfo or #self._rankInfo == 0)
end

function AutochessrankView:_updateCell(view, cell, data, tag)
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
	txtScore.text = data.score

	local time = math.floor(checknumber(data.time) / 1000)
	local date = GameUtil.time2date(time)

	txtTime.text = string.format("%s.%s %s:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local scrollList = self._scrollList[tableview]

	if not scrollList then
		scrollList = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[tableview] = scrollList
	end

	local prizeCfg = AutochessConfig.instance:getRankPrizeCfg(data.rank)
	local prize = string.split(prizeCfg.prize, "#")

	scrollList:reloadData(prize)
end

function AutochessrankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local tableview = goutil.findChild(cell, "tableview")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local scrollList = self._scrollList[tableview]

	if scrollList then
		scrollList:dispose()
	end
end

function AutochessrankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)

	proxy.binder:setEffStatus(false)
end

function AutochessrankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function AutochessrankView:_onACRankInfoRes(msg)
	self._myRank = msg.myRank
	self._rankInfo = msg.rankInfo

	table.sort(self._rankInfo, function(a, b)
		return a.rank < b.rank
	end)
	self:refreshUI()
end

return AutochessrankView
