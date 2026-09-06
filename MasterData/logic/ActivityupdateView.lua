-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/ActivityupdateView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.ActivityupdateView", package.seeall)

local ActivityupdateView = class("ActivityupdateView", ViewComponent)

ActivityupdateView.CELL_KEY = "ActivityupdateView_"

function ActivityupdateView:ctor()
	ActivityupdateView.super.ctor(self)
end

function ActivityupdateView:unbindEvents()
	ActivityupdateView.super.unbindEvents(self)
end

function ActivityupdateView:bindEvents()
	ActivityupdateView.super.bindEvents(self)
end

function ActivityupdateView:buildUI()
	ActivityupdateView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ActivityupdateView:onExit()
	ActivityupdateView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self.scrollList:dispose()
end

function ActivityupdateView:onEnter()
	ActivityupdateView.super.onEnter(self)

	local actId = ActivitySummaryController.instance:getActivityId()
	local effPath = "20220602/wanfahuodong/fx_ui_wanfa_jiemian.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	local list = XiaonuoBirthConfig.instance:getSummaryActivityUpdateList(actId) or {}

	ArraySort.sortOn(list, {
		function(obj)
			local type = GameUtil.getTimePeriodType(obj.actStartTime, obj.actEndTime)

			if type == GameUtil.afterTimePeriod then
				return GameUtil.string2time(obj.actStartTime)
			elseif type == GameUtil.inTimePeriod then
				return -GameUtil.string2time(obj.actStartTime)
			else
				return GameUtil.string2time(obj.actStartTime)
			end
		end,
		"id"
	}, {
		ArraySort.NUMERIC,
		ArraySort.NUMERIC
	})
	self.scrollList:reloadData(list)
end

function ActivityupdateView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function ActivityupdateView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local over = goutil.findChild(cell, "over")
	local redpoint = goutil.findChild(cell, "redpoint")
	local tipGo = goutil.findChild(cell, "tip")
	local txtTip = goutil.findChildTextComponent(cell, "tip/txt")
	local imgName = data.background
	local url = GameUrl.getBigbgFolderUrl("bonus", imgName)

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, url)

	local type = GameUtil.getTimePeriodType(data.actStartTime, data.actEndTime)

	GameUtil.SetActive(over, type == GameUtil.afterTimePeriod)

	local isMark = GameUtil.getUserData(ActivityupdateView.CELL_KEY .. data.activityId .. "_" .. data.id)

	GameUtil.SetActive(redpoint, type == GameUtil.inTimePeriod and checknumber(isMark) == 0)
	GameUtil.SetActive(tipGo, false)

	if type == GameUtil.beforeTimePeriod then
		GameUtil.SetActive(tipGo, true)

		local date = GameUtil.string2date(data.actStartTime)

		txtTip.text = langPara("%02d月%02d日开启", date.month, date.day)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onCellClick, self, data))
end

function ActivityupdateView:onCellClick(data)
	local type = GameUtil.getTimePeriodType(data.actStartTime, data.actEndTime)

	if type == GameUtil.inTimePeriod then
		GameUtil.saveUserData(ActivityupdateView.CELL_KEY .. data.activityId .. "_" .. data.id, 1)
		self.scrollList:refresh()
		GotoMgr.gotoByString(data.jumpTo)
	else
		TipsFacade.instance:openCommonTips(data.offlineTip)
	end
end

return ActivityupdateView
