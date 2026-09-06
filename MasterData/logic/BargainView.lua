-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/BargainView.lua

module("logic.extensions.bargain.view.BargainView", package.seeall)

local BargainView = class("BargainView", ViewComponent)
local reduceType = {
	newPlayer = 1,
	oldPlayer = 2,
	commonPlayer = 3
}

function BargainView:ctor()
	BargainView.super.ctor(self)
end

function BargainView:unbindEvents()
	BargainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnInvite:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function BargainView:bindEvents()
	BargainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._buyOnClick, self)
	self._btnInvite:AddClickListener(self._inviteOnClick, self)
	self._btnRight:AddClickListener(self._rightOnClick, self)
	self._btnLeft:AddClickListener(self._leftOnClick, self)
	self._btnTip:AddClickListener(self._tipsOnClick, self)
end

function BargainView:onExit()
	BargainView.super.onExit(self)

	self._goodsInfo = {}

	removetimer(self._showTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBargainInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBargainChatRes, self._chatTips, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendBargainRedpackInfoRes, self._refreshBargainTimes, self)
	self._friendTab:dispose()
end

function BargainView:buildUI()
	BargainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnInvite = self:getBtn("btnInvite")
	self._btnRight = self:getBtn("showCommodity/btnRight")
	self._btnLeft = self:getBtn("showCommodity/btnLeft")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._txtCurCost = self:getTxt("btnBuy/txtCurCost")
	self._txtOriginal = self:getTxt("btnBuy/txtOriginal")
	self._txtProgress = self:getTxt("bargainList/txtProgress")
	self._txtNotStart = self:getTxt("showCommodity/status/imgNotStarted/time")
	self._txtUnderway = self:getTxt("showCommodity/status/imgUnderway/time")
	self._bargainTimes = self:getTxt("bargainTimes")
	self._friendList = self:getGo("bargainList/friendList")
	self._friendCell = self:getGo("bargainList/friendCell")
	self._con = self:getGo("showCommodity/con")
	self._status = self:getGo("showCommodity/status")
	self._imgNull = self:getGo("bargainList/imgNull")
	self._imgFinished = self:getGo("showCommodity/status/imgFinished")
	self._imgUnderway = self:getGo("showCommodity/status/imgUnderway")
	self._imgNotStarted = self:getGo("showCommodity/status/imgNotStarted")
	self._imgOriginal = self:getGo("btnBuy/txtOriginal/img")
	self._friendTab = ScrollerList.create(self._friendList, self._friendCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BargainView:onEnter()
	BargainView.super.onEnter(self)

	self._activityId = BargainModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._selectGoodsId = 1
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.FriendBargain, self._activityId)

	FriendBargainAgent.instance:sendPM_FriendBargainGetInfoReq(self._activityId)
	settimer(1, self._showTime, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendBargainInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendBargainChatRes, self._chatTips, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendBargainRedpackInfoRes, self._refreshBargainTimes, self)
end

function BargainView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "head")
	local imgOld = goutil.findChild(cell, "state/imgOld")
	local imgNew = goutil.findChild(cell, "state/imgNew")
	local txtAera = goutil.findChildTextComponent(cell, "arean/txtAera")
	local txtName = goutil.findChildTextComponent(cell, "arean/txtName")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtState = goutil.findChildTextComponent(cell, "state/txt")
	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtName.text = data.headInfo.userName
	txtAera.text = string.format("%s服-", data.areaId)
	txtNum.text = string.format("-%s神钻", data.reduce)

	goutil.setActive(imgOld, data.userState == reduceType.oldPlayer)
	goutil.setActive(imgNew, data.userState == reduceType.newPlayer)
end

function BargainView:_clearCell(cell)
	return
end

function BargainView:_refreshView(isBtn)
	if not isBtn then
		self:_setCurBargainGoodsId()
	end

	self._goodsInfo = BargainModel.instance:getBargainInfo(self._selectGoodsId)

	local goodsCfg = BargainConfig.instance:getGoodsInfo(self._activityId, self._goodsInfo.goodsId)
	local reduceCfg = BargainConfig.instance:getReduceCfg(self._activityId, reduceType.commonPlayer)
	local num = self._goodsInfo.curPrice == 1 and 0 or math.ceil(self._goodsInfo.curPrice / reduceCfg.reduceRange[1])

	MaterialMgr.resetAll(self._con)
	MaterialMgr.setCellByCfg(goodsCfg.goods, self._con)

	self._txtCurCost.text = self._goodsInfo.curPrice .. "神钻"
	self._txtOriginal.text = self._goodsInfo.curPrice < 0 and "已售罄" or goodsCfg.decNum .. "神钻"
	self._txtProgress.text = num > 0 and string.format("再邀请最多%s人可砍至1神钻", num) or ""
	self._txtNotStart.text = GameUtil.formatTimeString("%m月%d日 %H:%M开启", goodsCfg.startTime)

	self._friendTab:reloadData(self._goodsInfo.records)

	self._timePeriod = GameUtil.getTimePeriod(goodsCfg.startTime, goodsCfg.endTime)

	goutil.setActive(self._imgUnderway, self._timePeriod == GameUtil.inTimePeriod)
	goutil.setActive(self._imgFinished, self._timePeriod == GameUtil.afterTimePeriod)
	goutil.setActive(self._imgNotStarted, self._timePeriod == GameUtil.beforeTimePeriod)
	goutil.setActive(self._imgOriginal, self._goodsInfo.curPrice > 0 and self._timePeriod ~= GameUtil.beforeTimePeriod and self._goodsInfo.curPrice < goodsCfg.decNum)
	goutil.setActive(self._imgNull, TableUtil.isTableEmpty(self._goodsInfo.records))
	goutil.setActive(self._txtCurCost.gameObject, self._goodsInfo.curPrice > 0 and self._timePeriod ~= GameUtil.beforeTimePeriod and self._goodsInfo.curPrice < goodsCfg.decNum)
	GameUtil.SetGray(self._btnInvite, self._timePeriod ~= GameUtil.inTimePeriod)
	GameUtil.SetGray(self._btnBuy, self._timePeriod == GameUtil.beforeTimePeriod)
	self:_showTime()
	FriendBargainAgent.instance:sendPM_FriendBargainFindReq(self._activityId, RoleModel.instance:getUserId(), self._goodsInfo.goodsId)
end

function BargainView:_setCurBargainGoodsId()
	local cfg = BargainConfig.instance:getGoodsInfo(self._activityId)

	for i, v in ipairs(cfg) do
		local goodsCfg = BargainConfig.instance:getGoodsInfo(self._activityId, v.goodsId)
		local timePeriod = GameUtil.getTimePeriod(goodsCfg.startTime, goodsCfg.endTime)

		if timePeriod == GameUtil.inTimePeriod then
			self._selectGoodsId = v.goodsId

			return
		end
	end
end

function BargainView:_showTime()
	if TableUtil.isTableEmpty(self._goodsInfo) then
		return
	end

	if self._timePeriod ~= GameUtil.inTimePeriod then
		return
	end

	local goodsCfg = BargainConfig.instance:getGoodsInfo(self._activityId, self._goodsInfo.goodsId)
	local hour, min, sec = GameUtil.getTimeHHMMSS(GameUtil.string2time(goodsCfg.endTime) - ServerTime.now())

	if GameUtil.string2time(goodsCfg.endTime) - ServerTime.now() < 0 then
		FriendBargainAgent.instance:sendPM_FriendBargainGetInfoReq(self._activityId)

		self._goodsInfo = {}
		self._txtUnderway.text = ""

		return
	end

	self._txtUnderway.text = string.format("剩余时间\n%02d:%02d:%02d", hour, min, sec)
end

function BargainView:_refreshBargainTimes(msg)
	self._bargainTimes.text = string.format("今日已砍次数:%s", msg.hasReduceTime)
end

function BargainView:_rightOnClick()
	local len = BargainModel.instance:getGoodsLength()

	if len <= self._selectGoodsId then
		FloatWordMgr.instance:show("已经到头了")

		return
	end

	self._selectGoodsId = self._selectGoodsId + 1

	self:_refreshView(true)
end

function BargainView:_leftOnClick()
	if self._selectGoodsId <= 1 then
		FloatWordMgr.instance:show("已经到头了")

		return
	end

	self._selectGoodsId = self._selectGoodsId - 1

	self:_refreshView(true)
end

function BargainView:_tipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "bargainview_1")
end

function BargainView:_inviteOnClick()
	if self._timePeriod ~= GameUtil.inTimePeriod then
		return
	end

	UIStateManager.instance:push(ViewName.FriendBargainView, self._goodsInfo.goodsId)
end

function BargainView:_buyOnClick()
	if self._timePeriod == GameUtil.beforeTimePeriod then
		return
	end

	if self._goodsInfo.curPrice < 0 then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	local function okFunc()
		FriendBargainAgent.instance:sendPM_FriendBargainBuyReq(self._activityId, self._goodsInfo.goodsId)
	end

	local function cencelFunc()
		return
	end

	local goodsCfg = BargainConfig.instance:getGoodsInfo(self._activityId, self._goodsInfo.goodsId)
	local costName = MaterialMgr.getMaterialsNameByCfg(goodsCfg.dec)
	local tipsContent = string.format("当前商品已砍%s%s，是否花费%s%s购买？", goodsCfg.decNum - self._goodsInfo.curPrice, costName, self._goodsInfo.curPrice, costName)

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function BargainView:_chatTips()
	FloatWordMgr.instance:show("发送成功")
	SurveyController.instance:reportBehavior(201778)
end

return BargainView
