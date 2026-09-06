-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeoverView.lua

module("logic.extensions.badge.view.BadgeoverView", package.seeall)

local BadgeoverView = class("BadgeoverView", ViewComponent)

function BadgeoverView:ctor()
	BadgeoverView.super.ctor(self)
end

function BadgeoverView:buildUI()
	BadgeoverView.super.buildUI(self)

	self._badgeNum = goutil.findChildComponent(self.mainGO, "badgeNum/imgNum", "UIImgNumeralText")
	self._badgeMax = goutil.findChildTextComponent(self.mainGO, "badgeNum/max")
	self._badgeDescribe = goutil.findChildTextComponent(self.mainGO, "badgeDescribe")
	self._badgeGetRule = goutil.findChildTextComponent(self.mainGO, "ruleView/Viewport/badgeGetRule")
	self._badgeListCell = self:getGo("badgeListCell")
	self._badgeListCellWidth = GameUtil.getWidth(self._badgeListCell)
	self._badgeBtn = self:getGo("badgeBtn")
	self._badgeBtnHeight = 160
	self._badgeBtnSpcacY = 0
	self._badgeList = self:getGo("badgeList")
	self._badgeView = ScrollerList.create(self._badgeList, self._badgeListCell, GameUtil.handler(self._updateBadgeCell, self))

	self._badgeView:regGetCellSize(GameUtil.handler(self._badgeCellSize, self))

	self._closeBtn = self:getBtn("closeBtn")
end

function BadgeoverView:bindEvents()
	BadgeoverView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function BadgeoverView:unbindEvents()
	BadgeoverView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BadgeoverView:destroyUI()
	BadgeoverView.super.destroyUI(self)
end

function BadgeoverView:onEnter()
	BadgeoverView.super.onEnter(self)

	self._badgeDescribe.text = BadgeConfig.instance:getCommonValue("BADGE_DESC")
	self._badgeGetRule.text = BadgeConfig.instance:getCommonValue("GET_BADGE")
	self._cellBadge = {}
	self._view = true
	self._userId = self:getFirstParam()

	if self._userId then
		GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self._loadAllBadgeInfo, self)
	end

	self:_loadAllBadgeInfo()
end

function BadgeoverView:onEnterFinished()
	BadgeoverView.super.onEnterFinished(self)
end

function BadgeoverView:onExit()
	BadgeoverView.super.onExit(self)

	self._view = false

	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialGet, self._loadAllBadgeInfo, self)

	for k, cellList in pairs(self._cellBadge) do
		for i, proxy in ipairs(cellList) do
			MaterialMgr.resetPorxy(proxy)
		end
	end

	self._badgeView:dispose()
	BadgeAgent.instance:getDispatcher():removeAllListener(BadgeAgent.PM_LoadAllBadgeRes)
end

function BadgeoverView:onExitFinished()
	BadgeoverView.super.onExitFinished(self)
end

function BadgeoverView:_loadAllBadgeInfo()
	BadgeAgent.instance:sendPM_LoadAllBadgeReq(self._userId, function(msg)
		BadgeModel.instance:setBadgeInfo(msg.info)

		if not self._view then
			return
		end

		self._badgeNum:SetNum(BadgeModel.instance:getBadgeNum())
		self._badgeView:reloadData(BadgeController.instance:getBadgeTypeInfo())

		self._badgeMax.text = tonumber(string.format("%.2f", BadgeModel.instance:getBadgeNum() / BadgeController.instance:getBadgeMaxNum()) * 100) .. "%"
	end)
end

function BadgeoverView:_updateBadgeCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "name").text = data.typeName

	local content = goutil.findChild(cell.gameObject, "content")

	self._cellBadge[cell] = self._cellBadge[cell] or {}

	for i = 1, 8 do
		local child = goutil.findChild(content, "badge_" .. i)

		if child == nil then
			child = goutil.cloneAndSetParent(self._badgeBtn, content.transform, "badge_" .. i)
		end

		goutil.setActive(child, true)
		goutil.setActive(goutil.findChild(child, "compose"), false)

		if data.badgeList[i] and BadgeConfig.instance:getDefineById(data.badgeList[i]).active then
			local badgeCfg = BadgeConfig.instance:getDefineById(data.badgeList[i])
			local proxy

			if self._cellBadge[cell][i] then
				proxy = self._cellBadge[cell][i]

				self._cellBadge[cell][i].binder:setCfgData(badgeCfg)
			else
				proxy = MaterialMgr.setCell(MatType.Item_Badge, data.badgeList[i], child)
				self._cellBadge[cell][i] = proxy
			end

			proxy.binder:setActiveImgC_Bg(false)

			local getTimeText, badgeInfo = goutil.findChildTextComponent(child, "getTime"), BadgeModel.instance:getBadgeInfoById(data.badgeList[i])
			local getTime

			if badgeInfo then
				getTime = badgeInfo.latestUpgradeTimeMillis
			end

			goutil.setActive(goutil.findChild(child, "compose"), false)

			if getTime then
				getTimeText.text = GameUtil.formatTimeStamp("%Y/%m/%d", checknumber(getTime) / 1000)

				proxy.binder:setGray(false)
				proxy.binder:setAutoTips(true)
				proxy.binder:setClick()
			else
				proxy.binder:setGray(true)

				getTimeText.text = "未获得"

				if BadgeController.instance.canComposeBadge(badgeCfg) then
					goutil.setActive(goutil.findChild(child, "compose"), true)
					proxy.binder:setAutoTips(false)

					local str = string.split(badgeCfg.piece, ":")
					local mo = MaterialMgr.getModel(tonumber(str[1]), tonumber(str[2]))

					proxy.binder:setClick(function()
						ItemBagController.instance:openUsePanel(mo)
					end)
				else
					proxy.binder:setAutoTips(true)
					proxy.binder:setClick()
				end
			end

			goutil.setActive(goutil.findChild(child, "getTime"), true)
			goutil.setActive(goutil.findChild(child, "none"), false)
		else
			if self._cellBadge[cell][i] then
				MaterialMgr.resetAll(child)

				self._cellBadge[cell][i] = nil
			end

			goutil.setActive(goutil.findChild(child, "getTime"), false)
			goutil.setActive(goutil.findChild(child, "none"), true)
		end
	end
end

function BadgeoverView:_badgeCellSize(view, index)
	return 752, 390
end

return BadgeoverView
