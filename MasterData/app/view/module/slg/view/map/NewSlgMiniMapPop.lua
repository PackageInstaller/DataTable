local NewSlgMiniMapPop = class("NewSlgMiniMapPop", require("app.fairyGUI.newSlg.UI_NewSlgMiniMapPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgMiniMapPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgMiniMapPop:ctor(arg_2_1)
	self:showAtCenter()

	self._compPanel = self:getChild("Comp_map_panel")

	self._compPanel:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self._compPanel:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self._compPanel:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self._compPanel:getChild("Comp_map"):setVisible(false)
	self._compPanel:getChild("Comp_map2"):setVisible(false)

	self._compMap = self._compPanel:getChild("Comp_map")

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self._compMap = self._compPanel:getChild("Comp_map2")
	end

	self._compMap:enableMap()
	self._compMap:setVisible(true)
	self.m_closeGraph:addClickListener(handler(self, self.onClose))

	self._groupInfo = self:getChild("Group_info")

	self._groupInfo:setVisible(false)

	self._txtName = self:getChild("Txt_name")
	self._txtPos = self:getChild("Txt_pos")
	self._btnGo = self:getChild("Btn_goto")

	self._btnGo:addClickListener(handler(self, self._onClickGoto))

	self._rcPos = nil
	self._initPos = arg_2_1 and arg_2_1.pos

	local var_2_0 = g.core.model.User.newSlgData:getMyUserData()

	self._initPos = self._initPos or (var_2_0 or nil) and (var_2_0.pos or cc.p(0, 0))

	if g.core.model.User.newSlgData:getSName() == "S2" then
		local var_2_2 = 0

		for iter_2_0, iter_2_1 in ipairs((g.core.model.User.newSlgData:getOccupiedCities())) do
			if iter_2_1 ~= 0 then
				local var_2_3 = g.core.config.new_slg_city_info.fetch(iter_2_1)

				if var_2_3 and g.core.model.User.newSlgData:getProvinceCfgById(var_2_3.city_state).level ~= 1 then
					var_2_2 = var_2_2 + 1
				end
			end
		end

		self.m_cityNumTxt:setText(g.core.lang:get(429670, {
			num1 = var_2_2,
			num2 = g.core.model.User.newSlgData:getNewSlgParamsValueById(1017)
		}))
		self.m_s2Desc:setVisible(true)
	else
		self.m_s2Desc:setVisible(false)
	end

	self._compMap:initMapParams({
		offset = cc.p(self._compPanel:getWidth() / 2, self._compPanel:getHeight() / 2)
	})
	self._compMap:move({
		pos = self._initPos
	})
	self:_checkMapScroll()
end

function NewSlgMiniMapPop:onLoad()
	self.m_enterTransition:play()
	self:_updateView()

	if g.core.model.User.newSlgData:getSeasonId() >= 2 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetSmallMapInfo({})
	end
end

function NewSlgMiniMapPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgMiniMapPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgMiniMapPop:_onTouchBegin(arg_6_1)
	arg_6_1:captureTouch()

	local var_6_0 = arg_6_1:getInput():getTouch()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0:getLocation()

	self._beginTouchX = var_6_1.x
	self._beginTouchY = var_6_1.y
end

function NewSlgMiniMapPop:_onTouchMove(arg_7_1)
	local var_7_0 = arg_7_1:getInput():getTouch()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getLocation()

	self._beginTouchX = var_7_1.x

	self._compMap:setX(self._compMap:getX() + (var_7_1.x - self._beginTouchX))

	self._beginTouchY = var_7_1.y

	self._compMap:setY(self._compMap:getY() - (var_7_1.y - self._beginTouchY))
	self:_checkMapScroll()
end

function NewSlgMiniMapPop:_onTouchEnd()
	return
end

function NewSlgMiniMapPop:receiveCompEvent(arg_9_1, arg_9_2)
	if arg_9_1 == "NewSlgMiniMapBuildComp_click" then
		self._groupInfo:setVisible(true)

		if arg_9_2.buildType == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.CITY then
			self._txtName:setText(g.core.model.User.newSlgData:getCityInfoById(arg_9_2.buildInfo.value).name)
			self._txtPos:setText("(" .. arg_9_2.buildInfo.pos.x .. " , " .. arg_9_2.buildInfo.pos.y .. ")")

			self._rcPos = arg_9_2.buildInfo.pos

			self.m_isSelectController:setSelectedIndex(1)
		elseif arg_9_2.buildType == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.GATE then
			self._txtName:setText(g.core.model.User.newSlgData:getCheckPointInfoById(arg_9_2.buildInfo.value).name)
			self._txtPos:setText("(" .. arg_9_2.buildInfo.pos.x .. " , " .. arg_9_2.buildInfo.pos.y .. ")")

			self._rcPos = arg_9_2.buildInfo.pos

			self.m_isSelectController:setSelectedIndex(1)
		else
			self._groupInfo:setVisible(false)
			self._txtName:setText(g.core.lang:get(429030))
			self.m_isSelectController:setSelectedIndex(0)
		end
	end

	if arg_9_1 == "NewSlgMiniMapComp_click" then
		self._rcPos = nil

		self._groupInfo:setVisible(false)
		self.m_isSelectController:setSelectedIndex(0)
	end
end

function NewSlgMiniMapPop:_updateView()
	self._compMap:updateView()
end

function NewSlgMiniMapPop:_onClickGoto()
	if self._rcPos then
		self:dispatchCompEvent("NewSlg_jumpToPos_withoutClick", {
			pos = self._rcPos
		})
		self:removeSelf()
	end
end

function NewSlgMiniMapPop:_checkMapScroll2()
	if self._compMap:getX() >= -1172 then
		self._compMap:setX(-1172)
	end

	if self._compMap:getX() <= -2324 then
		self._compMap:setX(-2324)
	end

	if self._compMap:getY() <= -1200 then
		self._compMap:setY(-1200)
	end

	if self._compMap:getY() >= -500 then
		self._compMap:setY(-500)
	end
end

function NewSlgMiniMapPop:_checkMapScroll()
	if g.core.model.User.newSlgData:getSeasonId() >= 2 then
		self:_checkMapScroll2()
	else
		self:_checkMapScroll1()
	end
end

function NewSlgMiniMapPop:_checkMapScroll1()
	if self._compMap:getX() >= -610 then
		self._compMap:setX(-610)
	end

	if self._compMap:getX() <= -830 then
		self._compMap:setX(-830)
	end

	if self._compMap:getY() <= -420 then
		self._compMap:setY(-420)
	end

	if self._compMap:getY() >= -210 then
		self._compMap:setY(-210)
	end
end

return NewSlgMiniMapPop
