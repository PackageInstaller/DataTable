-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupView.lua

module("logic.extensions.brothergroup.view.BrotherGroupView", package.seeall)

local BrotherGroupView = class("BrotherGroupView", ViewComponent)

function BrotherGroupView:buildUI()
	BrotherGroupView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self.container = self:getGo("container")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("time/txtLeftTime")
end

function BrotherGroupView:bindEvents()
	BrotherGroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function BrotherGroupView:unbindEvents()
	BrotherGroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BrotherGroupView:onEnter()
	BrotherGroupView.super.onEnter(self)

	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.BrotherGroup)

	if actTimeCfg then
		self._actId = actTimeCfg.activityId

		BrotherGroupModel.instance:setCurActId(self._actId)
		self:refreshViewByCfg()
		BrotherGroupController.instance:getInfo()
		removetimer(self._onCountDown, self)

		self._curEndTime = GameUtil.string2time(actTimeCfg.endTime)

		self:_onCountDown()
		settimer(1, self._onCountDown, self)
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end
end

function BrotherGroupView:onExit()
	BrotherGroupView.super.onExit(self)
	self._tableview:dispose()

	if self._curShowData then
		BrotherGroupModel.instance:setLastOpenId(self._curShowData.id)
	end

	self._curShowData = nil

	removetimer(self._onCountDown, self)
end

function BrotherGroupView:refreshViewByCfg()
	self._actCfg = BrotherGroupConfig.instance:getActCfg(self._actId)
	self._hudCfgs = BrotherGroupConfig.instance:getHudCfgs(self._actCfg.hudPlanId)
	self._curShowData = nil

	local curShowId = checkint(self:getFirstParam())

	if curShowId <= 0 then
		curShowId = BrotherGroupModel.instance:getLastOpenId()
	end

	self._tagDataList = {}

	for k, v in pairs(self._hudCfgs) do
		if v.id > 0 then
			table.insert(self._tagDataList, v)
		end
	end

	table.sort(self._tagDataList, function(a, b)
		return a.sort < b.sort
	end)
	self:_onClickTab(curShowId)
end

function BrotherGroupView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txt.text = data.name

	if data == self._curShowData then
		cell.imgChange:SetState(1)
		cell.txtChange:SetState(1)
	else
		cell.imgChange:SetState(0)
		cell.txtChange:SetState(0)
	end

	RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(data.redpointId or "", "#")))
	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickTab, self, data.id))
end

function BrotherGroupView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.imgChange = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
	cell.txtChange = goutil.findChildComponent(cell.go, "txt", "UITextColorChange")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.redpoint = goutil.findChild(cell.go, "redpoint")
	cell.txt = goutil.findChildTextComponent(cell.go, "txt")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.redpoint, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function BrotherGroupView:_onClickTab(id)
	local tryOpenData

	for i, v in ipairs(self._tagDataList) do
		if v.id == checkint(id) then
			tryOpenData = v
		end
	end

	tryOpenData = tryOpenData or self._tagDataList[1]

	if tryOpenData ~= self._curShowData then
		self._curShowData = tryOpenData

		self:showTabAt(self.container)
		self:showTabAt(self.container, self._curShowData.viewname, self._curShowData.parameter)
		self._tableview:reloadData(self._tagDataList)
	end
end

function BrotherGroupView:_onClickClose()
	self._curShowData = nil

	BrotherGroupModel.instance:setLastOpenId(0)
	self:close()
end

function BrotherGroupView:_onCountDown()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

return BrotherGroupView
