-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaySportsWishesMainView.lua

module("logic.extensions.birthdaysportswish.view.BirthdaySportsWishesMainView", package.seeall)

local BirthdaySportsWishesMainView = class("BirthdaySportsWishesMainView", ViewComponent)

function BirthdaySportsWishesMainView:ctor()
	BirthdaySportsWishesMainView.super.ctor(self)
end

function BirthdaySportsWishesMainView:unbindEvents()
	BirthdaySportsWishesMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BirthdaySportsWishesMainView:bindEvents()
	BirthdaySportsWishesMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function BirthdaySportsWishesMainView:buildUI()
	BirthdaySportsWishesMainView.super.buildUI(self)

	self._container = self:getGo("container")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._tableView = self:getGo("ScrollView")
	self._tableCell = self:getGo("BtnCell")
	self._scrollerList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BirthdaySportsWishesMainView:onExit()
	BirthdaySportsWishesMainView.super.onExit(self)
	self._scrollerList:dispose()
	BirthdaySportsWishModel.instance:setLastOpenTabId(self._curIndex)
end

function BirthdaySportsWishesMainView:onEnter()
	BirthdaySportsWishesMainView.super.onEnter(self)

	local actCfgs = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES)
	local actId = actCfgs.activityId
	local isOpen = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES, actId)

	if not isOpen then
		FloatWordMgr.instance:show("此活动未在时间内")
		self:close()

		return
	end

	self:_initView(actId)

	self._curIndex = nil
	self._tabCfgs = BirthdaySportsWishConfig.instance:getTabCfgs(actId)

	self._scrollerList:reloadData(self._tabCfgs)

	local openId = checkint(BirthdaySportsWishModel.instance:getLastOpenTabId() or self:getFirstParam())

	openId = self._tabCfgs[openId] and openId or 1

	self:_onClickTab(openId)
end

function BirthdaySportsWishesMainView:_initView(actId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES, actId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function BirthdaySportsWishesMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtName.text = data.title

	GameUtil.SetActive(cell.select, self._curIndex == data.id)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data.id))

	if string.nilorempty(data.tag) then
		goutil.setActive(cell.tag, false)
	else
		goutil.setActive(cell.tag, true)

		cell.txtTag.text = data.tag
	end

	if not string.nilorempty(data.redPointId) then
		RedPointController.instance:regRedPoint(cell.redpoint, unpack(string.split(data.redPointId, "#")))
	end
end

function BirthdaySportsWishesMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtName = goutil.findChildTextComponent(goCell, "name/txtName")
	cell.select = goutil.findChildImageComponent(goCell, "select")
	cell.tag = goutil.findChild(goCell, "tag")
	cell.txtTag = goutil.findChildTextComponent(cell.tag, "txt")

	GameUtil.rmClickHandler(cell.go)

	cell.redpoint = goutil.findChild(cell.go, "redpoint")

	goutil.setActive(cell.redpoint, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function BirthdaySportsWishesMainView:_onClickTab(openId)
	if self._curIndex ~= openId then
		self._curIndex = openId

		self._scrollerList:refresh()

		local openCfg = self._tabCfgs[self._curIndex]

		self:showTabAt(self._container)
		self:showTabAt(self._container, openCfg.viewName, openCfg)
	end
end

function BirthdaySportsWishesMainView:_onClickClose()
	self:close()
	BirthdaySportsWishModel.instance:setLastOpenTabId()
end

return BirthdaySportsWishesMainView
