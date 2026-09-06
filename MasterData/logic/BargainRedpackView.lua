-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/BargainRedpackView.lua

module("logic.extensions.bargain.view.BargainRedpackView", package.seeall)

local BargainRedpackView = class("BargainRedpackView", ViewComponent)

function BargainRedpackView:ctor()
	BargainRedpackView.super.ctor(self)
end

function BargainRedpackView:unbindEvents()
	BargainRedpackView.super.unbindEvents(self)
	self._btnRound:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnGoTo:RemoveClickListener()
end

function BargainRedpackView:bindEvents()
	BargainRedpackView.super.bindEvents(self)
	self._btnRound:AddClickListener(self._openRedPack, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnGoTo:AddClickListener(self._goToOnClick, self)
end

function BargainRedpackView:onExit()
	BargainRedpackView.super.onExit(self)
	MaterialMgr.resetAll(self._roundHead)
	MaterialMgr.resetAll(self._resultHead)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBargainRedpackInfoRes, self._refreshRedpack, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBargainRedpackRes, self._refreshRedPackTxt, self)
end

function BargainRedpackView:buildUI()
	BargainRedpackView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRound = self:getBtn("btns/btnRound")
	self._btnGoTo = self:getBtn("btns/btnResult/btnGoto")
	self._resultGo = self:getGo("btns/btnResult")
	self._roundGo = self:getGo("btns/btnRound")
	self._resultHead = self:getGo("btns/btnResult/goHead")
	self._roundHead = self:getGo("btns/btnRound/goHead")
	self._txtTips = self:getTxt("btns/btnResult/tip/txt")
end

function BargainRedpackView:onEnter()
	BargainRedpackView.super.onEnter(self)

	self._param = self:getOpenParam()
	self._activityId = BargainModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._cfg = BargainConfig.instance:getCfgById(self._activityId)

	goutil.setActive(self._resultGo, false)
	goutil.setActive(self._roundGo, true)
	self:_setHeadIcon()
	GlobalDispatcher:addListener(GlobalNotify.FriendBargainRedpackInfoRes, self._refreshRedpack, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendBargainRedpackRes, self._refreshRedPackTxt, self)
end

function BargainRedpackView:_refreshRedPackTxt(reduce)
	self._txtTips.text = string.format("成功帮好友砍掉%s神钻", reduce)

	goutil.setActive(self._resultGo, true)
	goutil.setActive(self._roundGo, false)
end

function BargainRedpackView:_refreshRedpack(msg)
	local str = ""

	self._info = msg

	local goodsCfg = BargainConfig.instance:getGoodsInfo(self._activityId, self._param[1])
	local timePeriod = GameUtil.getTimePeriod(goodsCfg.startTime, goodsCfg.endTime)

	if self._info.isReduced then
		str = "今日已帮好友砍过价"
	elseif self._info.isBuy or timePeriod == GameUtil.afterTimePeriod then
		str = "当前砍价已结束"
	elseif self._info.curPrize <= 1 then
		str = "已经是最低价啦"
	elseif self._info.hasReduceTime >= self._cfg.timeLimit then
		str = "今日砍价次数已用尽"
	else
		FriendBargainAgent.instance:sendPM_FriendBargainReduceReq(self._activityId, self._param[1], self._param[2])

		return
	end

	self._txtTips.text = str

	goutil.setActive(self._resultGo, true)
	goutil.setActive(self._roundGo, false)
end

function BargainRedpackView:_setHeadIcon()
	local friendInfo = FriendModel.instance:getFriendMo(self._param[2])

	HeadItemController.instance:setHeadCellByInfo(self._roundHead, friendInfo.headInfo)
	HeadItemController.instance:setHeadCellByInfo(self._resultHead, friendInfo.headInfo)
end

function BargainRedpackView:_openRedPack()
	FriendBargainAgent.instance:sendPM_FriendBargainFindReq(self._activityId, self._param[2], self._param[1])
end

function BargainRedpackView:_goToOnClick()
	self:close()
	UIStateManager.instance:push(ViewName.BargainView)
end

return BargainRedpackView
