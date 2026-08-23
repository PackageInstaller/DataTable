local SuccubaMainInteractionComp = class("SuccubaMainInteractionComp", require("app.fairyGUI.succuba.UI_SuccubaMainInteractionComp"))

function SuccubaMainInteractionComp:ctor()
	self._playIdx = 0
	self._curInteractionList = nil
	self._touchBtnList = {}
	self._cfg = nil

	self:_initComp()
end

function SuccubaMainInteractionComp:_initComp()
	for iter_2_0 = 1, 3 do
		self[table.concat({
			"m_chooseItem",
			iter_2_0
		})]:addClickListener(handler(self, self._playChooseEnd))
	end
end

function SuccubaMainInteractionComp:_getInteractionInfo(arg_3_1)
	local var_3_0 = table.concat({
		"lines",
		arg_3_1
	}, "_")

	if not g.core.config.succuba_interaction_info.hasKey(var_3_0) then
		return
	end

	local var_3_1 = {}

	if #self._cfg[var_3_0] > 0 then
		var_3_1.line = self._cfg[var_3_0]
	end

	local var_3_2 = self._cfg[table.concat({
		"sound",
		arg_3_1
	}, "_")]

	if #var_3_2 > 0 then
		var_3_1.sound = var_3_2
	end

	local var_3_3 = self._cfg[table.concat({
		"time",
		arg_3_1
	}, "_")]

	if var_3_3 > 0 then
		var_3_1.time = var_3_3
	end

	local var_3_4 = table.concat({
		"touch",
		"y",
		arg_3_1
	}, "_")

	if g.core.config.succuba_interaction_info.hasKey(var_3_4) then
		local var_3_5 = self._cfg[table.concat({
			"touch",
			"x",
			arg_3_1
		}, "_")]

		if #var_3_5 > 0 then
			var_3_1.touchPos = {
				x = tonumber(var_3_5),
				y = tonumber(self._cfg[var_3_4])
			}
		end
	end

	local var_3_6 = table.concat({
		"res",
		arg_3_1
	}, "_")

	if g.core.config.succuba_interaction_info.hasKey(var_3_6) then
		if #self._cfg[var_3_6] > 0 then
			var_3_1.showAction = self._cfg[var_3_6]
		end
	end

	local var_3_7 = table.concat({
		"loop_res",
		arg_3_1
	}, "_")

	if g.core.config.succuba_interaction_info.hasKey(var_3_7) then
		if #self._cfg[var_3_7] > 0 then
			var_3_1.loopAction = self._cfg[var_3_7]
		end
	end

	local var_3_8 = {}

	for iter_3_0 = 1, 3 do
		local var_3_9 = self._cfg[table.concat({
			"lines",
			arg_3_1,
			"option",
			iter_3_0
		}, "_")]

		if #var_3_9 > 0 then
			var_3_8[#var_3_8 + 1] = var_3_9
		end
	end

	if #var_3_8 > 0 then
		var_3_1.chooseList = var_3_8
	end

	if not next(var_3_1) then
		return
	end

	return var_3_1
end

function SuccubaMainInteractionComp:_playAct()
	print("_playAct")
	print(self._playIdx)

	if self._lineInfoList[self._playIdx].line then
		self:_playLine()
	elseif self._lineInfoList[self._playIdx].touchPos then
		self:_playTouch()
	elseif self._lineInfoList[self._playIdx].chooseList then
		self:_playChoose()
	else
		self._playIdx = self._playIdx + 1
		self._isLoop = false

		if self._playIdx > #self._lineInfoList then
			self.m_showTypeController:setSelectedIndex(3)

			if self._needNetSync then
				g.core.network.GameNetProxy:send_C2S_Succuba_InterActiveFinish({
					tp = 1,
					id = self._succuba:getSid(),
					event_id = self._cfg.id
				})
			end

			if self._callback then
				self._callback(self._succuba)
			end
		else
			if self._needNetSync then
				g.core.network.GameNetProxy:send_C2S_Succuba_InterActiveSave({
					id = self._succuba:getSid(),
					event_id = self._cfg.id,
					progress = self._playIdx
				})
			end

			return self:_playAct()
		end
	end
end

function SuccubaMainInteractionComp:_playLine()
	self._typeWriter = require("app.view.common.TypeWriter").new({
		speed = 20,
		label = self.m_dialogComp:getChild("dialogTxt"),
		str = self._lineInfoList[self._playIdx].line
	})

	self._typeWriter:start()
	self.m_showTypeController:setSelectedIndex(0)
	g.core.sound.SoundManager:playSound(self._lineInfoList[self._playIdx].sound)

	self._lineTimer = self:newScheduleOnce(handler(self, self._playLineEnd), self._lineInfoList[self._playIdx].time)

	if self._lineInfoList[self._playIdx].showAction then
		self:_playShowAction()
	end
end

function SuccubaMainInteractionComp:_playLineEnd()
	self._typeWriter = nil

	if self._lineTimer then
		self:cancelSchedule(self._lineTimer)

		self._lineTimer = nil
	end

	self._lineInfoList[self._playIdx].line = nil

	self:_playAct()
end

function SuccubaMainInteractionComp:_playTouch()
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(self._touchBtnList) do
		if not iter_7_1:isVisible() then
			var_7_0 = iter_7_1

			break
		end
	end

	var_7_0 = var_7_0 or self:_createTouchBtn()

	var_7_0:setPosition(self._lineInfoList[self._playIdx].touchPos)
	var_7_0:setVisible(true)

	self._touchTimer = self:newScheduleOnce(handler(self, self._playTouchEnd), g.core.config.succuba_parameter_info.get(g.core.const.ConstMgr.SuccubaConst.PARAMETER_ID.AUTO_INTERACTION_TIME_ID).parameter)

	self.m_showTypeController:setSelectedIndex(1)
end

function SuccubaMainInteractionComp:_createTouchBtn()
	local var_8_0 = fgui.UIPackage:createObject("base_new", "BaseLoaderBtn")

	var_8_0:addClickListener(handler(self, self._playTouchEnd))
	var_8_0:setIcon("ui://succuba/pic_mnzj_ai_jiaohudongxiao")
	var_8_0:getChild("icon"):setAlpha(0)
	self.m_touchNode:addChild(var_8_0)

	self._touchBtnList[#self._touchBtnList + 1] = var_8_0

	local var_8_1 = var_8_0:getSize()

	var_8_0:addEffectSpine({
		isLoop = true,
		name = "eff_ui_succuba_click",
		x = var_8_1.width / 2,
		y = var_8_1.height / 2
	})

	return var_8_0
end

function SuccubaMainInteractionComp:_playTouchEnd()
	if self._touchTimer then
		self:cancelSchedule(self._touchTimer)

		self._touchTimer = nil
	end

	self._lineInfoList[self._playIdx].touchPos = nil

	for iter_9_0, iter_9_1 in ipairs(self._touchBtnList) do
		iter_9_1:setVisible(false)
	end

	self:_playAct()
end

function SuccubaMainInteractionComp:_playShowAction()
	self._drawSuccuba:playAction(self._lineInfoList[self._playIdx].showAction, handler(self, self._playLoopAction))
end

function SuccubaMainInteractionComp:_playLoopAction()
	if self._isLoop or not self._lineInfoList[self._playIdx] or not self._lineInfoList[self._playIdx].loopAction then
		return
	end

	self._drawSuccuba:playAction(self._lineInfoList[self._playIdx].loopAction, nil, nil, true)

	self._isLoop = true
end

function SuccubaMainInteractionComp:_playChoose()
	for iter_12_0 = 1, 3 do
		local var_12_0 = self[table.concat({
			"m_chooseItem",
			iter_12_0
		})]

		if self._lineInfoList[self._playIdx].chooseList[iter_12_0] then
			var_12_0:setTitle(self._lineInfoList[self._playIdx].chooseList[iter_12_0])
			var_12_0:setVisible(true)
		else
			var_12_0:setVisible(false)
		end
	end

	self.m_showTypeController:setSelectedIndex(2)
end

function SuccubaMainInteractionComp:_playChooseEnd()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_01)

	self._lineInfoList[self._playIdx].chooseList = nil

	self:_playAct()
end

function SuccubaMainInteractionComp:playInteraction(arg_14_1)
	self._cfg = arg_14_1.cfg
	self._lineInfoList = {}
	self._callback = arg_14_1.callback
	self._needNetSync = arg_14_1.netSync
	self._succuba = arg_14_1.succuba

	self.m_dialogComp:getChild("nameTxt"):setText(self._succuba:getCurCfg().name)

	if arg_14_1.needCreateDraw then
		self:_createSuccubaSpine(self._succuba:getMineShowCfg())
	else
		self._drawSuccuba = arg_14_1.drawSuccuba
	end

	for iter_14_0 = 1, 99 do
		local var_14_0 = self:_getInteractionInfo(iter_14_0)

		if not var_14_0 then
			break
		end

		self._lineInfoList[#self._lineInfoList + 1] = var_14_0
	end

	self._playIdx = arg_14_1.idx or 1

	self:_playAct()
end

function SuccubaMainInteractionComp:_createSuccubaSpine(arg_15_1)
	self.m_spineNode:removeChildren()

	self._drawSuccuba = require("app.view.common.DrawSuccuba").new({
		showCfg = arg_15_1
	})

	self.m_spineNode:addChild(self._drawSuccuba)
end

return SuccubaMainInteractionComp
