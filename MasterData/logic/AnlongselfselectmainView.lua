-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/view/AnlongselfselectmainView.lua

module("logic.extensions.anlongselfselect.view.AnlongselfselectmainView", package.seeall)

local AnlongselfselectmainView = class("AnlongselfselectmainView", TableViewComponent)

function AnlongselfselectmainView:ctor()
	AnlongselfselectmainView.super.ctor(self)
end

function AnlongselfselectmainView:buildUI()
	AnlongselfselectmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnDaiyliGift = self:getBtn("btnDaiyliGift")
	self._dotGo = self:getGo("btnDaiyliGift/dot")
	self._txtActTime = goutil.findChildTextComponent(self.mainGO, "txtActTime")
end

function AnlongselfselectmainView:bindEvents()
	AnlongselfselectmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnDaiyliGift:AddClickListener(self._onClickbtnDaiyliGift, self)
end

function AnlongselfselectmainView:unbindEvents()
	AnlongselfselectmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnDaiyliGift:RemoveClickListener()
end

function AnlongselfselectmainView:destroyUI()
	AnlongselfselectmainView.super.destroyUI(self)
end

function AnlongselfselectmainView:onEnter()
	AnlongselfselectmainView.super.onEnter(self)

	self._selectList = {}

	GlobalDispatcher:addListener(AnlongselfselectController.PM_SelfSelectInfoRes, self._PM_SelfSelectInfoRes, self)
	GlobalDispatcher:addListener(AnlongselfselectController.PM_NotifySelfSelectBuySucRes, self._PM_NotifySelfSelectBuySucRes, self)
	RedPointController.instance:regRedPoint(self._dotGo, 136)

	local params = self:getOpenParam()

	self._actType = checknumber(params[1])
	self._actId = checknumber(params[2])

	self:_checkActIsEnd()
	self:_setActLeftTime()
	self:_updateGoodsUI()
	SelfSelectAgent.instance:sendPM_SelfSelectInfoReq(self._actId)
end

function AnlongselfselectmainView:onEnterFinished()
	AnlongselfselectmainView.super.onEnterFinished(self)
end

function AnlongselfselectmainView:onExit()
	AnlongselfselectmainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._dotGo)
	GlobalDispatcher:removeListener(AnlongselfselectController.PM_SelfSelectInfoRes, self._PM_SelfSelectInfoRes, self)
	GlobalDispatcher:removeListener(AnlongselfselectController.PM_NotifySelfSelectBuySucRes, self._PM_NotifySelfSelectBuySucRes, self)
end

function AnlongselfselectmainView:onExitFinished()
	AnlongselfselectmainView.super.onExitFinished(self)
end

function AnlongselfselectmainView:_onClickbtnClose()
	self:close()
end

function AnlongselfselectmainView:_onClickbtnDaiyliGift()
	if AnlongselfselectModel.instance:hasGainDailyPrize() then
		FloatWordMgr.instance:show("每日礼包已领取")

		return
	end

	SelfSelectAgent.instance:sendPM_SelfSelectGainDailyPrizeReq(self._actId)
end

function AnlongselfselectmainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function AnlongselfselectmainView:_cellSize(view, index)
	return 100, 100
end

function AnlongselfselectmainView:_buildTabCellItems(cell)
	local items = {}

	for i = 1, 3 do
		local mainGO = goutil.findChild(cell.gameObject, "item" .. i)

		items[i] = {
			btnAdd = Framework.ButtonAdapter.GetFrom(mainGO, "btnAdd"),
			emptyGo = goutil.findChild(mainGO, "empty"),
			con = goutil.findChild(mainGO, "con")
		}
	end

	return items
end

function AnlongselfselectmainView:_updateCell(view, cell, cfg)
	local btnBuy = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnBuy")
	local txtLimit = goutil.findChildTextComponent(cell.gameObject, "txtLimit")
	local txtBtnBuy = goutil.findChildTextComponent(cell.gameObject, "btnBuy/text")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local info = self._packInfos[cfg.packId]
	local buyTimes = 0
	local totalTimes = cfg.buyLimit

	if info then
		buyTimes = info.buyTimes
	end

	local preStr = "不限购"
	local isLimitBuy = true

	if cfg.limitType == "daily" then
		preStr = "每日限购："
	elseif cfg.limitType == "weekly" then
		preStr = "每周限购："
	elseif cfg.limitType == "monthly" then
		preStr = "每月限购："
	elseif cfg.limitType == "allTime" then
		preStr = "永久限购："
	else
		isLimitBuy = false
	end

	txtLimit.text = isLimitBuy and string.format("%s%s/%s", preStr, math.max(0, totalTimes - buyTimes), totalTimes) or preStr

	GameUtil.SetGray(btnBuy.gameObject, isLimitBuy and totalTimes - buyTimes <= 0)

	txtTitle.text = cfg.packName
	txtBtnBuy.text = PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId) .. "元"

	local isSelectFull, opts = self:_setTableCellReward(cell, cfg)

	btnBuy:AddClickListener(function()
		if isLimitBuy and buyTimes >= totalTimes then
			FloatWordMgr.instance:show("购买次数不足")

			return
		end

		if isSelectFull then
			local list = {
				actId = self._actId,
				opts = table.concat(opts, ",")
			}
			local json = require("cjson")

			extParams = json.encode(list)
			self._curBuyPackId = cfg.packId

			PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.ANLONG_SELF_SELECT, cfg.packId, extParams)
		else
			FloatWordMgr.instance:show("请先完成定制您的专属礼包哦")
		end
	end)
end

function AnlongselfselectmainView:_setTableCellReward(cell, cfg)
	local items = self:_buildTabCellItems(cell)

	MaterialMgr.setCellByCfg(cfg.fixedPrize, items[1].con)
	goutil.setActive(items[1].emptyGo, false)
	goutil.setActive(items[1].btnAdd.gameObject, false)

	local optionCfgs = AnlongselfselectConfig.instance:getOptionCfgs(self._actId, cfg.packId)
	local optionCfgs_ContentKey = {}

	for k, v in pairs(optionCfgs) do
		optionCfgs_ContentKey[v.optionContent] = v
	end

	local cacheKey = "optionCache" .. cfg.packId
	local optionCache = self._selectList[cfg.packId]

	if not optionCache then
		optionCache = {}
		self._selectList[cfg.packId] = optionCache
	end

	local function okSelectFunc()
		self:_updateGoodsUI()
	end

	local isSelectFull = true
	local opts = {}

	for i = 2, #items do
		local dataIndex = i - 1
		local cacheData = optionCache[dataIndex]

		goutil.setActive(items[i].emptyGo, not cacheData)
		goutil.setActive(items[i].con, cacheData)
		items[i].btnAdd:AddClickListener(function()
			UIStateManager.instance:push(ViewName.AnlongselectpropView, self._actId, cfg.packId, self._selectList, okSelectFunc, cacheKey)
		end)

		if cacheData then
			table.insert(opts, cacheData.optionId)
			MaterialMgr.setCellByCfg(cacheData.contentStr, items[i].con)
		else
			isSelectFull = false
		end
	end

	return isSelectFull, opts
end

function AnlongselfselectmainView:_clearTableview(cell)
	local items = self:_buildTabCellItems(cell)

	for k, v in pairs(items) do
		MaterialMgr.resetAll(v.con)
	end
end

function AnlongselfselectmainView:_setActLeftTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._actId)
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._txtActTime.text = string.format("%s - %s", self:_formatTime(sdate), self:_formatTime(edate))
end

function AnlongselfselectmainView:_formatTime(date)
	return string.format("%s年%s月%s日", date.year, date.month, date.day)
end

function AnlongselfselectmainView:_updateGoodsUI()
	self._curViewDatas = AnlongselfselectConfig.instance:getPackCfgs(self._actId)
	self._packInfos = AnlongselfselectModel.instance:getPackInfos()

	self:reloadData()
end

function AnlongselfselectmainView:_PM_SelfSelectInfoRes(status)
	if status == 0 then
		self:_updateGoodsUI()
	end
end

function AnlongselfselectmainView:_PM_NotifySelfSelectBuySucRes(status)
	if status == 0 and self._curBuyPackId then
		self._selectList[self._curBuyPackId] = {}

		AnlongselfselectModel.instance:addBuyTime(self._curBuyPackId, 1)
		self:_updateGoodsUI()
	end
end

function AnlongselfselectmainView:_checkActIsEnd()
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._actType, self._actId)

	if not isInTime then
		local text = "未在活动时间范围内"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			self:close()
		end, "退出")
	end
end

return AnlongselfselectmainView
