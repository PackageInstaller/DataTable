local var_0_0 = g.core.const.ConstMgr.GuideConst
local TipGuideService = class("TipGuideService")

function TipGuideService:ctor()
	self._finishTipsGuide = {}
	self._guideLayer = g.core.layer.LayerManager:getGuideLayer()
	self._tipClickRect = fgui.GComponent:create()

	self._tipClickRect:setSize(display.width, display.height)
	self._tipClickRect:setPosition(cc.p(display.width / 2, display.height / 2))
	self._guideLayer:addChild(self._tipClickRect)
	self._tipClickRect:setOpaque(true)
	self._tipClickRect:setTouchable(true)
	self._tipClickRect:addClickListener(function(arg_2_0)
		self:onThisStepFinish()
		arg_2_0:stopPropagation()
	end)
	self._tipClickRect:setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, self._onCheckTickTipsGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_TIP_GUIDE_FINISH, self._onTickTipsGuideFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, self._onTickTipsGuideFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER_ROOT, self._onTickTipsGuideFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onTickTipsGuideFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onStoryEnd, self)
end

function TipGuideService:onThisStepFinish()
	self._tipSpeGuideMap[self._curKey].index = self._index + 1

	g.core.common.Scheduler:newScheduleOnce(function()
		self:doRunNextStep()
		self:_saveTickWeakGuide()
	end, 0)
end

function TipGuideService:reset()
	self._curObject = nil
	self._tipSpeGuideMap = nil
	self._curKey = nil
	self._finishTipsGuide = {}
	self._loadedTipGuildSaveData = false
end

function TipGuideService:doRunNextStep()
	if not self._curObject then
		return
	end

	if not self._curKey then
		return
	end

	local var_6_0 = var_0_0.ONE_LAYER_TIPS_GUIDE[self._curKey]

	if not var_0_0.ONE_LAYER_TIPS_GUIDE[self._curKey] then
		return
	end

	if not self._loadedTipGuildSaveData then
		self._loadedTipGuildSaveData = true
		self._tipSpeGuideMap = g.core.common.Storage:load("guide_tip_guide.json", true) or {}
	end

	if self._tipSpeGuideMap[self._curKey] and self._tipSpeGuideMap[self._curKey].index > #var_6_0 then
		self:_onTickTipsGuideFinish()

		return
	end

	self._tipClickRect:setVisible(true)

	if self._tipSpeGuideMap[self._curKey] then
		self._index = self._tipSpeGuideMap[self._curKey].index or 1
	end

	if var_6_0 then
		if var_6_0.tickEventId then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = var_6_0.tickEventId,
				value = var_6_0.tickEventDesc
			})
		end

		self._tipSpeGuideMap[self._curKey] = self._tipSpeGuideMap[self._curKey] or {
			index = self._index
		}

		if self:_createSpeWeakGuideComp(self._curObject[self._index], var_6_0[self._index]) then
			self:onThisStepFinish()
		end
	end
end

function TipGuideService:_onStoryEnd()
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if not self._curKey then
		return
	end

	local var_7_0 = var_0_0.ONE_LAYER_TIPS_GUIDE[self._curKey]

	if not var_0_0.ONE_LAYER_TIPS_GUIDE[self._curKey] then
		return
	end

	if var_7_0[self._tipSpeGuideMap[self._curKey].index] and var_7_0[self._tipSpeGuideMap[self._curKey].index].storyId then
		self:onThisStepFinish()
	end
end

function TipGuideService:_saveTickWeakGuide()
	g.core.common.Storage:save("guide_tip_guide.json", self._tipSpeGuideMap, true)
end

function TipGuideService:_onTickTipsGuideFinish()
	self:clearComp()
	self._tipClickRect:setVisible(false)
end

function TipGuideService:clearComp()
	if self._speFrameComp then
		self._speFrameComp:removeSelf()

		self._speFrameComp = nil
	end

	if self._speGuideDialog then
		self._speGuideDialog:removeSelf()

		self._speGuideDialog = nil
	end

	if self._touchComp then
		self._touchComp:removeSelf()

		self._touchComp = nil
	end
end

function TipGuideService:_onCheckTickTipsGuide(arg_11_1, arg_11_2)
	if GUIDE_EDIT or GUIDE_CLOSE then
		return
	end

	if self._curKey then
		return
	end

	self._curKey, self._curObject = arg_11_2.key, arg_11_2.objects

	self:doRunNextStep()
end

function TipGuideService:_createSpeWeakGuideComp(arg_12_1, arg_12_2)
	fgui.UIPackage:addPackage("ui/guide/guide")
	self:clearComp()

	if arg_12_2.event then
		g.core.event.EventManager:dispatchEvent(arg_12_2.event)

		return true
	end

	if arg_12_2.storyId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = arg_12_2.storyId
		})

		return
	end

	local var_12_0 = arg_12_1 and arg_12_1:getSize() or cc.size(0, 0)
	local var_12_1 = 0.5 * var_12_0.width
	local var_12_2 = 0.5 * var_12_0.height
	local var_12_3 = cc.p(0, 0)

	if arg_12_1 then
		var_12_3 = arg_12_1:isPivotAsAnchor() and arg_12_1:getPivot() or cc.p(0, 0)
	end

	local var_12_4 = self._guideLayer:globalToLocal(arg_12_1 and arg_12_1:localToGlobal(cc.p(var_12_0.width * (0.5 - var_12_3.x), var_12_0.height * (0.5 - var_12_3.y))) or cc.p(display.cx, display.cy))

	if arg_12_2.frame then
		self._speFrameComp = fgui.UIPackage:createObject("guide", "GuideTipsBoxComp")

		if arg_12_2.addToSelf and arg_12_1 then
			arg_12_1:addChild(self._speFrameComp)
			self._speFrameComp:setPosition(cc.p(var_12_1, var_12_2))
		else
			self._guideLayer:addChild(self._speFrameComp)
			self._speFrameComp:setPosition(var_12_4)
		end

		self._speFrameComp:setSize(var_12_0)
		self._speFrameComp:setScaleAsSize(1, 1, arg_12_2.frame)
		self._speFrameComp:setTouchable(false)
	end

	if arg_12_2.tipsTxt then
		self._speGuideDialog = arg_12_2.isBigTips and fgui.UIPackage:createObject("guide", "GuideFullDialogComp") or fgui.UIPackage:createObject("guide", "GuideDialogComp")

		local var_12_5 = arg_12_2.tipsTxtDir or cc.p(0, 0)

		if arg_12_2.addToSelf and not arg_12_2.isBigTips and arg_12_1 then
			arg_12_1:addChild(self._speGuideDialog)
			self._speGuideDialog:setPosition(cc.p(var_12_5.x + var_12_1, var_12_5.y + var_12_2))
		else
			self._guideLayer:addChild(self._speGuideDialog)

			if not arg_12_2.isBigTips then
				self._speGuideDialog:setPosition(cc.pAdd(cc.p(var_12_5.x + var_12_1, var_12_5.y + var_12_2), var_12_4))
			else
				self._speGuideDialog:setPosition(display.width, display.height)
			end
		end

		self._speGuideDialog:updateView({
			dialogId = arg_12_2.tipsTxt
		}, arg_12_2.tipsTxt)
		self._speGuideDialog:setTouchable(false)
	end

	if arg_12_2.dragShow then
		local var_12_6 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		self._guideLayer:addChild(var_12_6)
		var_12_6:setTouchable(false)

		self._touchComp = var_12_6

		local var_12_7 = cc.p(var_12_4.x + (arg_12_2.dragX or 100), var_12_4.y + (arg_12_2.dragY or 100))

		self._touchComp:setPosition(var_12_7)
		self._touchComp:updateView(nil, {
			centerPos = var_12_4,
			centerPos1 = var_12_7
		}, true, true)
	elseif arg_12_2.finger then
		local var_12_8 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		self._guideLayer:addChild(var_12_8)
		var_12_8:setTouchable(false)

		self._touchComp = var_12_8

		self._touchComp:setPosition(var_12_4)
	end
end

return TipGuideService
