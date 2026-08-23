local var_0_0 = g.core.const.ConstMgr.EasterEggConst
local var_0_1 = g.core.config.dungeon_stinger_info
local EasterEggLockPop = class("EasterEggLockPop", require("app.fairyGUI.easterEgg.UI_EasterEggLockPop"), function()
	return fgui.GComponent:create({
		pkgName = "easterEgg",
		resName = "EasterEggLockPop",
		pkgPath = "ui/easterEgg/easterEgg"
	}, ...)
end)

function EasterEggLockPop:ctor(arg_2_1)
	self._params = arg_2_1
	self._interactionId = arg_2_1.interactionId
	self._eggId = arg_2_1.eggId
	self._eggLockNum = 0
	self._selectNumList = {}
	self._inClose = false
	self._eggInfo = nil

	self:showAtCenter()
	self:_initData()
	self:_initView(arg_2_1)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onCloseTouch))
end

function EasterEggLockPop:_onCloseTouch(arg_3_1)
	local var_3_0 = arg_3_1:getInput():getTouch()

	if var_3_0 and not self.m_touchSize:containPoint((var_3_0:getLocation())) then
		self:_onClickClose()
	end
end

function EasterEggLockPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play((handler(self, self._onClose)))
end

function EasterEggLockPop:_initData()
	local var_5_0 = var_0_1.get(self._interactionId, self._eggId)

	self._eggLockNum = var_5_0.password
	self._eggInfo = var_5_0
end

function EasterEggLockPop:_initView()
	for iter_6_0 = 0, 9 do
		self["m_numBtn" .. iter_6_0]:addClickListener(handler(self, function()
			self:_onSelectBtn(iter_6_0)
		end))
	end

	self.m_resetBtn:addClickListener(handler(self, self._onClickReset))
	self.m_deleteBtn:addClickListener(handler(self, self._onClickDelete))

	if self._eggInfo.des2 ~= "" then
		self.m_tipDesc:setTitle(self._eggInfo.des2)
	else
		self.m_tipDesc:setVisible(false)
	end

	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_LOCK_POP_OPEN)
end

function EasterEggLockPop:onLoad()
	self:updateView()
end

function EasterEggLockPop:updateView()
	self.m_numCountController:setSelectedIndex(#self._selectNumList)

	for iter_9_0 = 1, #self._selectNumList do
		self["m_num" .. iter_9_0]:setText(self._selectNumList[#self._selectNumList - iter_9_0 + 1] or 0)
	end
end

function EasterEggLockPop:_onSelectBtn(arg_10_1)
	table.insert(self._selectNumList, arg_10_1)
	self:updateView()

	if #self._selectNumList >= var_0_0.PASSWORD_NUM then
		self:checkIsPass()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_LOCK_CLICK_NUM_LAST)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_LOCK_CLICK_NUM)
	end
end

function EasterEggLockPop:_onClickReset()
	self._selectNumList = {}

	self:updateView()
end

function EasterEggLockPop:_onClickReset()
	self._selectNumList = {}

	self:updateView()
end

function EasterEggLockPop:_onClickDelete()
	if #self._selectNumList == 0 then
		return
	end

	table.remove(self._selectNumList, #self._selectNumList)
	self:updateView()
end

function EasterEggLockPop:checkIsPass()
	local var_14_0 = ""

	for iter_14_0 = 1, #self._selectNumList do
		var_14_0 = var_14_0 .. self._selectNumList[iter_14_0]
	end

	if tonumber(var_14_0) == self._eggLockNum then
		self.m_passStateController:setSelectedIndex(1)
		self.m_touch:setVisible(true)
		self.m_passTransition:play(function()
			self.m_touch:setVisible(false)
			g.core.module.ModuleManager:pushModule(g.view.entrance.EASTEREGG_LAYER, {
				eggId = self._eggId,
				interactionId = self._interactionId
			})
			self:_onClose()
		end)
		self.m_effpass:addEffectSpine({
			name = "eff_ui_easterEgg_pass",
			isLoop = false
		})
	else
		self.m_passStateController:setSelectedIndex(2)
		self.m_touch:setVisible(true)
		self.m_errorTransition:play(function()
			self.m_touch:setVisible(false)
			self.m_passStateController:setSelectedIndex(0)

			self._selectNumList = {}

			self:updateView()
		end)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_LOCK_ERROR)
	end
end

function EasterEggLockPop:_onClose()
	self:removeSelf()
end

return EasterEggLockPop
