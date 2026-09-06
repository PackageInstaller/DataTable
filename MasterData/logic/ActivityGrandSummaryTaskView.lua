-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/grandsummary/ActivityGrandSummaryTaskView.lua

module("logic.extensions.operationsummary.view.grandsummary.ActivityGrandSummaryTaskView", package.seeall)

local ActivityGrandSummaryTaskView = class("ActivityGrandSummaryTaskView", ViewComponent)

function ActivityGrandSummaryTaskView:ctor()
	ActivityGrandSummaryTaskView.super.ctor(self)
end

function ActivityGrandSummaryTaskView:buildUI()
	ActivityGrandSummaryTaskView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnGo = self:getGo("btnGo")
	self.redPoint = self:getGo("btnGo/redpoint")
	self.icon = self:getGo("con")
	self.bg = self:getGo("bg")
	self.txtTip = MaterialMgr.findGraphicText(self.mainGO, "txtTip")
	self.txtTitle = self:getTxt("txtTitle")
	self.changeGroup = self:getGo("changeGroup"):GetComponent("UIChangeGroup")
	self.cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")

	goutil.addComponentOnce(self.cellGo, typeof(Framework.ImageBigBG))

	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ActivityGrandSummaryTaskView:bindEvents()
	ActivityGrandSummaryTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self.btnGo, self._onClickBtnJump, self)
end

function ActivityGrandSummaryTaskView:unbindEvents()
	ActivityGrandSummaryTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnGo)
end

function ActivityGrandSummaryTaskView:destroyUI()
	ActivityGrandSummaryTaskView.super.destroyUI(self)
	MaterialMgr.resetAll(self.mainGO)
	uGuiUtil.clearImage(self.icon)
end

function ActivityGrandSummaryTaskView:onEnter()
	ActivityGrandSummaryTaskView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		printError("缺失传入参数，关闭面板")
		self:_onClickBtnClose()

		return
	end

	self.activityId = checknumber(params[1])
	self.showType = checknumber(params[2])
	self.showImgIdx = checknumber(params[3]) > 0 and checknumber(params[3]) or 1
	self.cfg_base = OperationSummaryConfig.instance:getTaskBaseCfg(self.activityId)
	self.cfg_items = OperationSummaryConfig.instance:getTaskItemsCfg(self.activityId)
	self.cfg_deta = OperationSummaryConfig.instance:getTaskDetailsCfg(self.activityId)
	self.cfg_prize = OperationSummaryConfig.instance:getPrizeCfg(self.showType)
	self.cellList = {}

	GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._onRefreshUI, self)
	OpSummaryController.instance:sendGetAllTask(self.activityId)
	self:_setPlaneUI()
	self:_onRefreshUI()
end

function ActivityGrandSummaryTaskView:onExit()
	ActivityGrandSummaryTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._onRefreshUI, self)
	self.scrollList:dispose()
	RedPointController.instance:unregRedPoint(self.redPoint)
end

function ActivityGrandSummaryTaskView:_setPlaneUI()
	for i, v in pairs(self.cfg_items) do
		if v.showType == self.showType then
			self.txtTitle.text = string.gsub(v.name, "\n", "")
		end
	end

	if self.btnGo then
		GameUtil.SetActive(self.btnGo, not string.nilorempty(self.cfg_prize.jumpTo))
	end

	if not string.nilorempty(self.cfg_prize.redpointId) and self.redPoint then
		RedPointController.instance:regRedPoint(self.redPoint, unpack(string.split(self.cfg_prize.redpointId or "", "#")))
	end

	local content_1 = ""

	if not string.nilorempty(self.cfg_base.fakeId) then
		content_1 = MaterialMgr.getContentMatStr(self.cfg_base.fakeId, 35, -10, MaterialMgr.ICON_TYPE_ICON)
	elseif not string.nilorempty(self.cfg_base.lotteryFakeId) then
		content_1 = MaterialMgr.getContentMatStr(self.cfg_base.lotteryFakeId, 35, -10, MaterialMgr.ICON_TYPE_ICON)
	end

	local content_2 = MaterialMgr.getContentMatStr(self.cfg_prize.prize, 35, -10, MaterialMgr.ICON_TYPE_ICON)
	local prizeType, prizeId, prizeNum = MaterialMgr.getMatParams(self.cfg_prize.prize)
	local score = ""

	for _, data in pairs(self.cfg_deta) do
		if data.taskPlanId == self.activityId and data.showType == self.showType then
			score = data.score .. ""

			break
		end
	end

	self.txtTip.text = langPara("每阅读完成1章剧情，可得[%s*%s]", content_2, prizeNum)

	if not string.nilorempty(self.cfg_prize.panelBgName) then
		local bgUrl = GameUrl.getBigbgPngUrl(self.cfg_prize.panelBgName)

		local function func()
			self.bg.gameObject:GetComponent("Image"):SetNativeSize()
		end

		uGuiUtil.setSpriteToImage(self.bg, uGuiUtil.SpriteType.BigBg, bgUrl, func)
	end

	if not string.nilorempty(self.cfg_prize.atmosphereType) then
		self.changeGroup:SetState(self.cfg_prize.atmosphereType)
	end

	if not string.nilorempty(self.cfg_prize.iconName) then
		local function func()
			self.icon.gameObject:GetComponent("Image"):SetNativeSize()
		end

		local pathNameArr = string.split(self.cfg_prize.iconName, "/")
		local iconUrl = GameUrl.getIconFolderUrl(pathNameArr[1], pathNameArr[2])

		uGuiUtil.setSpriteToImage(self.icon, uGuiUtil.SpriteType.BigBg, iconUrl, func)
	end
end

function ActivityGrandSummaryTaskView:_onRefreshUI()
	self:_updateTaskScrollerList()
	self.scrollList:refresh()
end

function ActivityGrandSummaryTaskView:_updateTaskScrollerList()
	local list = {}

	for k, data in pairs(self.cfg_deta) do
		if data.taskPlanId == self.activityId and data.showType == self.showType then
			table.insert(list, data)
		end
	end

	for i, v in ipairs(list) do
		list[i].state = self:_getCellState(v)
	end

	table.sort(list, function(a, b)
		if a.state == b.state then
			if a.id < b.id then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
	self.scrollList:reloadData(list)
end

function ActivityGrandSummaryTaskView:_getCellState(data)
	local state = 0
	local obj = OpSummaryModel.instance:getTaskInfo(data.id)
	local hasGain = obj.hasGainPrize
	local num = math.min(checknumber(obj.curProgress), checknumber(data.maxProgress))

	if hasGain == true then
		state = 4

		return 4
	end

	state = num >= checknumber(data.maxProgress) and 1 or 2

	if data.judge == 1 then
		local FrontTaskData = OpSummaryModel.instance:getTaskInfo(data.id - 1)

		if FrontTaskData.hasGainPrize == false then
			state = 3
		end

		if FrontTaskData.hasGainPrize == nil then
			state = 3
		end
	end

	return state
end

function ActivityGrandSummaryTaskView:_updateCell(view, cellModel, data, tag)
	local cell = {}

	cell.mainGo = cellModel

	if cell.mainGo == nil then
		return nil
	end

	cell.btnRecieve = goutil.findChild(cell.mainGo, "btnRecieve")
	cell.btnGo = goutil.findChild(cell.mainGo, "btnGo")
	cell.receive = goutil.findChild(cell.mainGo, "receive")
	cell.txtTask = goutil.findChild(cell.mainGo, "txtTask"):GetComponent("Text")
	cell.txtNum = goutil.findChild(cell.mainGo, "txtNum"):GetComponent("Text")
	cell.txtNotOpen = goutil.findChild(cell.mainGo, "txtNotOpen")
	cell.UIChangeGroup = cell.mainGo:GetComponent("UIChangeGroup")

	if not string.nilorempty(self.cfg_prize.taskBgName) then
		local bgUrl = GameUrl.getBigbgPngUrl(self.cfg_prize.taskBgName)

		uGuiUtil.setSpriteToImage(cell.mainGo, uGuiUtil.SpriteType.BigBg, bgUrl)
	end

	if not string.nilorempty(self.cfg_prize.atmosphereType) then
		cell.UIChangeGroup:SetState(self.cfg_prize.atmosphereType)
	end

	if cell.txtTask.gameObject == nil then
		printError("target obj is nil!!!")
	else
		cell.txtTask.text = data.desc
	end

	local obj = OpSummaryModel.instance:getTaskInfo(data.id)
	local num = checknumber(obj.curProgress)

	num = math.min(num, checknumber(data.maxProgress))

	if cell.txtNum.gameObject == nil then
		printError("target obj is nil!!!")
	else
		cell.txtNum.text = string.format("<color=#20B376FF>%s</color>", num) .. "/" .. checknumber(data.maxProgress)
	end

	GameUtil.SetActive(cell.receive, false)
	GameUtil.SetActive(cell.btnRecieve, false)
	GameUtil.SetActive(cell.btnGo, false)
	GameUtil.SetActive(cell.txtNotOpen, false)

	if data.state == 1 then
		GameUtil.SetActive(cell.btnRecieve, true)
	elseif data.state == 2 then
		GameUtil.SetActive(cell.btnGo, true)
	elseif data.state == 3 then
		GameUtil.SetActive(cell.txtNotOpen, true)
	elseif data.state == 4 then
		GameUtil.SetActive(cell.receive, true)
	end

	GameUtil.addClickHandler(cell.btnGo, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnRecieve, GameUtil.handler(self._onClickBtnRecieve, self, data))

	self.cellList[cell] = self.cellList[cell] or cell
end

function ActivityGrandSummaryTaskView:_setCell(cellModel, data)
	local cell = {}

	cell.mainGo = cellModel

	if cell.mainGo == nil then
		return nil
	end

	cell.btnRecieve = goutil.findChild(cell.mainGo, "btnRecieve")
	cell.btnGo = goutil.findChild(cell.mainGo, "btnGo")
	cell.receive = goutil.findChild(cell.mainGo, "receive")
	cell.txtTask = goutil.findChild(cell.mainGo, "txtTask"):GetComponent("Text")
	cell.txtNum = goutil.findChild(cell.mainGo, "txtNum"):GetComponent("Text")
	cell.txtNotOpen = goutil.findChild(cell.mainGo, "txtNotOpen")

	if not string.nilorempty(self.cfg_prize.taskBgName) then
		local bgUrl = GameUrl.getBigbgPngUrl("operationsummary/board_myhz_05")

		if cell.mainGo == nil then
			printError("target obj is nil!!!")
		else
			uGuiUtil.setSpriteToImage(cell.mainGo, uGuiUtil.SpriteType.BigBg, bgUrl)
		end
	end

	if cell.txtTask.gameObject == nil then
		printError("target obj is nil!!!")
	else
		cell.txtTask.text = data.desc
	end

	return cell
end

function ActivityGrandSummaryTaskView:_clearCell()
	return
end

function ActivityGrandSummaryTaskView:_onClickBtnClose()
	self:close()
end

function ActivityGrandSummaryTaskView:_onClickBtnJump()
	local params = string.split(self.cfg_prize.jumpTo, "#")
	local key = table.remove(params, 1)

	if key ~= "event" then
		ViewAutoShowController.instance:saveCurModalView()
	end

	GotoMgr.gotoByString(self.cfg_prize.jumpTo)
	self:_onClickBtnClose()
end

function ActivityGrandSummaryTaskView:_onClickBtnGo(data)
	local params = string.split(data.jumpTo, "#")
	local key = table.remove(params, 1)

	if key ~= "event" then
		ViewAutoShowController.instance:saveCurModalView()
	end

	GotoMgr.gotoByString(data.jumpTo)
	self:_onClickBtnClose()
end

function ActivityGrandSummaryTaskView:_onClickBtnRecieve(data)
	OpSummaryController.instance:sendGetTaskPrize(self.activityId, data)
end

return ActivityGrandSummaryTaskView
