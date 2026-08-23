local var_0_1 = g.core.model.User.fogNightmareData
local FogNightmareExploreQuickSwitchPop = class("FogNightmareExploreQuickSwitchPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreQuickSwitchPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareExploreQuickSwitchPop",
		pkgName = "fogNightmare",
		isFullScreen = false
	}, ...)
end)

function FogNightmareExploreQuickSwitchPop:ctor(arg_2_1)
	self._formationData = var_0_1:getFormationData()
	self._maxFormationCount = arg_2_1
	self._selectedComp = nil
	self._moveComp = nil
	self._movePos = nil
	self._formationList = self._formationData:getAllLineUpFormations()

	self:_initView()
end

function FogNightmareExploreQuickSwitchPop:_initView()
	self:showAtCenter()

	for iter_3_0 = 1, 4 do
		if self["m_formation" .. iter_3_0] then
			self["m_formation" .. iter_3_0]:setVisible(iter_3_0 <= self._maxFormationCount)
		end
	end

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function FogNightmareExploreQuickSwitchPop:onLoad()
	self:updateView()
end

function FogNightmareExploreQuickSwitchPop:_checkPosInComp(arg_5_1)
	for iter_5_0 = 1, self._maxFormationCount do
		if self["m_formation" .. iter_5_0] and self["m_formation" .. iter_5_0]:containPoint(arg_5_1) then
			if self._formationData:isUsedFormation(self._formationList[iter_5_0]:getFormationIdx()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(500155))

				return 0
			else
				return iter_5_0, self["m_formation" .. iter_5_0]
			end
		end
	end

	return 0
end

function FogNightmareExploreQuickSwitchPop:_onTouchBegin(arg_6_1)
	if self._isTouched then
		return
	end

	local var_6_0, var_6_1 = self:_checkPosInComp((arg_6_1:getInput():getTouch():getLocation()))

	if var_6_0 > 0 and var_6_1 then
		self._isTouched = true
		self._touchIndex = var_6_0
		self._selectedComp = var_6_1

		if not self._moveComp then
			self._moveComp = fgui.UIPackage:createObject("fogNightmare", "FogNightmareExploreQuickSwitchCell")

			self:getView():addChild(self._moveComp, 1)
		end

		self._moveComp:setVisible(true)
		self._moveComp:playCompEffect()
		self._moveComp:updateComp(var_6_0, self._formationList[var_6_0])
		var_6_1:updateComp(var_6_0, nil)

		local var_6_2 = var_6_1:getPosition()

		self._moveComp:setPosition(var_6_2)

		self._movePos = var_6_2

		arg_6_1:captureTouch()
	end
end

function FogNightmareExploreQuickSwitchPop:_onTouchMove(arg_7_1)
	if not self._isTouched then
		return
	end

	local var_7_0 = arg_7_1:getInput():getTouch():getDelta()

	self._movePos.x = self._movePos.x + var_7_0.x
	self._movePos.y = self._movePos.y - var_7_0.y

	self._moveComp:setPosition(self._movePos)
end

function FogNightmareExploreQuickSwitchPop:_onTouchEnd(arg_8_1)
	if not self._isTouched then
		return
	end

	self._isTouched = false

	self._moveComp:setVisible(false)

	if self._touchIndex > 0 then
		local var_8_0, var_8_1 = self:_checkPosInComp((arg_8_1:getInput():getTouch():getLocation()))

		if var_8_0 > 0 and var_8_0 ~= self._touchIndex then
			self._formationList[var_8_0] = self._formationList[self._touchIndex]
			self._formationList[self._touchIndex] = self._formationList[var_8_0]

			if self._formationList[var_8_0] then
				self._formationList[var_8_0]:setFormationIdx(self._touchIndex)
			end

			if self._formationList[self._touchIndex] then
				self._formationList[self._touchIndex]:setFormationIdx(var_8_0)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FORMATION_CHANGE, false)
		end

		self:updateView()
	end
end

function FogNightmareExploreQuickSwitchPop:updateView()
	for iter_9_0 = 1, self._maxFormationCount do
		if self["m_formation" .. iter_9_0] then
			self["m_formation" .. iter_9_0]:updateComp(iter_9_0, self._formationList[iter_9_0])
		end
	end
end

function FogNightmareExploreQuickSwitchPop:onUnload()
	if self._moveComp then
		self._moveComp:removeFromParent()

		self._moveComp = nil
	end
end

return FogNightmareExploreQuickSwitchPop
