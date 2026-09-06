-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityxiuertaskView.lua

module("logic.extensions.operationsummary.view.ActivityxiuertaskView", package.seeall)

local ActivityxiuertaskView = class("ActivityxiuertaskView", ViewComponent)

function ActivityxiuertaskView:ctor()
	ActivityxiuertaskView.super.ctor(self)
end

function ActivityxiuertaskView:buildUI()
	ActivityxiuertaskView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnGo = self:getGo("btnGo")
	self.icon = self:getGo("con")
	self.txtTip = MaterialMgr.findGraphicText(self.mainGO, "txtTip")
	self.txtTitle = self:getTxt("txtTitle")
	self.cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ActivityxiuertaskView:bindEvents()
	ActivityxiuertaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnGo, self.onClickJump, self)
end

function ActivityxiuertaskView:unbindEvents()
	ActivityxiuertaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnGo)
end

function ActivityxiuertaskView:destroyUI()
	ActivityxiuertaskView.super.destroyUI(self)
end

function ActivityxiuertaskView:onClickJump()
	GotoMgr.gotoByString(self.jumpToStr)
	self:close()
end

function ActivityxiuertaskView:onEnter()
	ActivityxiuertaskView.super.onEnter(self)

	self._activityId = -1
	self.actId = -1
	self.showImgIdx = 1

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self.actId = checknumber(params[2])
		self.showImgIdx = checknumber(params[3]) > 0 and checknumber(params[3]) or 1

		local list = {}
		local cfgList = OperationSummaryConfig.instance:getTaskDetailsCfg(self._activityId)

		for k, cfg in pairs(cfgList) do
			if cfg.showType == self.actId then
				table.insert(list, cfg)
			end
		end

		ArraySort.sortOn(list, {
			"id",
			function(data)
				local obj = OpSummaryModel.instance:getTaskInfo(data.id)

				if obj and obj.hasGainPrize then
					return 1
				else
					return 0
				end
			end
		})
		self.scrollList:reloadData(list)

		local pcfg = OperationSummaryConfig.instance:getPrizeCfg(self.actId)
		local prize = pcfg.prize
		local type, id, num = MaterialMgr.getMatParams(prize)
		local pName = MaterialMgr.getMaterialsName(type, id)
		local baseCfg = OperationSummaryConfig.instance:getTaskBaseCfg(self._activityId)
		local content = MaterialMgr.getContentMatStr(baseCfg.fakeId, 35, -10, MaterialMgr.ICON_TYPE_ICON)
		local content2 = MaterialMgr.getContentMatStr(prize, 35, -10, MaterialMgr.ICON_TYPE_ICON)

		GameUtil.SetActive(self.btnGo, false)

		self.jumpToStr = nil

		if not string.nilorempty(pcfg.jumpTo) then
			GameUtil.SetActive(self.btnGo, true)

			self.jumpToStr = pcfg.jumpTo
		end

		self.txtTip.text = langPara("每完成一个任务，即可获得[%sx1]\n并获得[%sx%s]", content, content2, num)

		local cfg = OperationSummaryConfig.instance:getTaskItemsCfg(self._activityId)[self.actId]

		self.txtTitle.text = cfg.name

		uGuiUtil.setSpriteToImage(self.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl("board_tanchuangqietu_0" .. self.showImgIdx), function()
			self.icon.gameObject:GetComponent("Image"):SetNativeSize()
		end)
		GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onRefreshUI, self)
		self:onRefreshUI()
	else
		self:close()
	end
end

function ActivityxiuertaskView:onEnterFinished()
	ActivityxiuertaskView.super.onEnterFinished(self)
end

function ActivityxiuertaskView:onExit()
	ActivityxiuertaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self.onRefreshUI, self)
	self.scrollList:dispose()
end

function ActivityxiuertaskView:onExitFinished()
	ActivityxiuertaskView.super.onExitFinished(self)
end

function ActivityxiuertaskView:onRefreshUI()
	self.scrollList:refresh()
end

function ActivityxiuertaskView:clearCell(cell)
	return
end

function ActivityxiuertaskView:_updateCell(view, cell, data, tag)
	local btnRecieve = goutil.findChild(cell, "btnRecieve")
	local btnGo = goutil.findChild(cell, "btnGo")
	local receive = goutil.findChild(cell, "receive")
	local txtTask = goutil.findChildTextComponent(cell, "txtTask")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtNotOpen = goutil.findChild(cell, "txtNotOpen")
	local obj = OpSummaryModel.instance:getTaskInfo(data.id)
	local num = checknumber(obj.curProgress)

	num = math.min(num, checknumber(data.maxProgress))

	local hasGain = obj.hasGainPrize

	txtTask.text = data.desc
	txtNum.text = string.format("<color=#20B376FF>%s</color>", num) .. "/" .. checknumber(data.maxProgress)

	GameUtil.SetActive(receive, hasGain)
	GameUtil.SetActive(btnRecieve, false)
	GameUtil.SetActive(btnGo, false)
	GameUtil.SetActive(txtNotOpen, false)

	if not hasGain then
		if data.judge == 1 then
			local tem = OpSummaryModel.instance:getTaskInfo(data.id - 1)

			if tem.hasGainPrize then
				if num >= checknumber(data.maxProgress) then
					GameUtil.SetActive(btnRecieve, true)
				else
					GameUtil.SetActive(btnGo, true)
				end
			else
				GameUtil.SetActive(txtNotOpen, true)
			end
		elseif num >= checknumber(data.maxProgress) then
			GameUtil.SetActive(btnRecieve, true)
		else
			GameUtil.SetActive(btnGo, true)
		end
	end

	GameUtil.addClickHandler(btnGo, GameUtil.handler(self.onClickGo, self, data))
	GameUtil.addClickHandler(btnRecieve, GameUtil.handler(self.onClickRecieve, self, data))
end

function ActivityxiuertaskView:onClickGo(data)
	local params = string.split(data.jumpTo, "#")
	local key = table.remove(params, 1)

	if key ~= "event" then
		ViewAutoShowController.instance:saveCurModalView()
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function ActivityxiuertaskView:onClickRecieve(data)
	OpSummaryController.instance:sendGetTaskPrize(self._activityId, data)
end

return ActivityxiuertaskView
