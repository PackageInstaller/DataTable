-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActIntroduceMainView.lua

module("logic.extensions.actintroduce.view.ActIntroduceMainView", package.seeall)

local ActIntroduceMainView = class("ActIntroduceMainView", ViewComponent)
local CurTabId

function ActIntroduceMainView:ctor()
	ActIntroduceMainView.super.ctor(self)
end

function ActIntroduceMainView:unbindEvents()
	ActIntroduceMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ActIntroduceMainView:bindEvents()
	ActIntroduceMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		CurTabId = nil

		self:close()
	end, self)
end

function ActIntroduceMainView:buildUI()
	ActIntroduceMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._container = self:getGo("container")
	self._pageScrollObj = self:getGo("pagescrollview")
	self._pageCell = self:getGo("pagecell")
	self._pagetableview = ScrollerList.create(self._pageScrollObj, self._pageCell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageTableview, self))

	self._pagetableview:regGetCellSize(function(view, index)
		return 178, 60
	end)
end

function ActIntroduceMainView:onExit()
	ActIntroduceMainView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	self._pagetableview:dispose()
end

function ActIntroduceMainView:onEnter()
	ActIntroduceMainView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	self:_dailyReset()
end

function ActIntroduceMainView:_dailyReset()
	self._configs = ActIntroduceConfig.instance:getCurActTabConfigs()

	if not self._configs or #self._configs == 0 then
		self:close()
		FloatWordMgr.instance:show("找不到符合的配置")

		return
	end

	self._pagetableview:reloadData(self._configs)

	local tabId = self:getFirstParam()

	tabId = checknumber(tabId)
	tabId = tabId > 0 and tabId or CurTabId or 1

	local curData = self._configs[1]

	for i, v in ipairs(self._configs) do
		if v.id == tabId then
			curData = v

			break
		end
	end

	self:_onClickTab(curData)
end

function ActIntroduceMainView:_updatePageCell(view, cell, data)
	local selectGo = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.addClickHandler(cell, function()
		self:_onClickTab(data)
	end)

	txtName.text = data.title

	goutil.setActive(selectGo, CurTabId == data.id)
end

function ActIntroduceMainView:_clearPageTableview(cell)
	GameUtil.rmClickHandler(cell)
end

function ActIntroduceMainView:_onClickTab(data)
	CurTabId = data.id

	if checknumber(data.reportBehavior) > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)
	end

	self._pagetableview:reloadData(self._configs)
	self:showTabAt(self.container)
	self:showTabAt(self._container, data.viewname, data)
end

return ActIntroduceMainView
