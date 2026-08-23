local PetShowTimePop = class("PetShowTimePop", require("app.fairyGUI.infoPop.UI_PetShowTimePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "PetShowTimePop",
		pkgName = "infoPop",
		isFullScreen = true
	})
end)

function PetShowTimePop:ctor(arg_2_1, arg_2_2)
	self._customPlay = arg_2_2
	self._group1OrginPos = self.m_petItem1:getPosition()

	self:_addListeners()

	if not arg_2_1 then
		return
	end

	self:updatePop(arg_2_1)
	self:addBg("bg/recruit/bg_zm_yuanzhishou.jpg")
end

function PetShowTimePop:_addListeners()
	self:addClickListener(handler(self, self._onReturnBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
end

function PetShowTimePop:_resetUI()
	for iter_4_0 = 1, 2 do
		self["m_petItem" .. iter_4_0]:setVisible(true)
	end

	self.m_shareComp:setVisible(false)
end

function PetShowTimePop:_initShowDatas(arg_5_1)
	self._showDatas = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(self._showDatas, {
			value = iter_5_1.value,
			isNew = iter_5_1.isNew
		})
	end
end

function PetShowTimePop:updatePop(arg_6_1)
	self:_resetUI()

	self._playEndAnmi = false
	self._playIdx = 0
	self._param = arg_6_1

	self:_initShowDatas(arg_6_1.awards)

	self._transPlayEnd = false
	self._wordAnimEnd = false
	self._callBack = arg_6_1.callBack
	self._isJustShow = arg_6_1.justShow

	self:_playShowNextItem()
end

function PetShowTimePop:_playShowNextItem()
	self.m_flushTopNode:setVisible(true)

	if self._playIdx >= #self._showDatas then
		self:_allItemShowOver()

		return
	end

	self._playIdx = self._playIdx + 1

	local var_7_0 = self._playIdx % 2

	if self._playIdx % 2 == 0 then
		var_7_0 = 2
	end

	local var_7_1 = self["m_petItem" .. var_7_0]

	self["m_petItem" .. var_7_0]:updateComp(self._showDatas[self._playIdx])
	var_7_1:setVisible(true)

	self._playEndAnmi = false

	if self._playIdx == 1 then
		-- block empty
	end

	self.m_normalEnterTransition:play(handler(self, self._onOneItemActionPlayEnd))
	self.m_flushTopNode:addEffectSpine({
		name = "eff_ui_petRecruit_show",
		remove = true,
		isLoop = false,
		anim = "play_" .. g.core.config.pet_info.get(self._showDatas[self._playIdx].value).quality + 1
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_POP_SLIDE)
end

function PetShowTimePop:_onOneItemActionPlayEnd()
	self._playEndAnmi = true

	self.m_flushTopNode:setVisible(false)
	self.m_shareComp:setVisibleEx(true)
end

function PetShowTimePop:_onReturnBtnClick()
	if self._playEndAnmi then
		self:_playShowNextItem()
	end
end

function PetShowTimePop:_allItemShowOver()
	if #self._showDatas > 1 then
		self._playEndAnmi = false
		self._playIdx = self._playIdx + 1

		local var_10_0 = math.max(1, self._playIdx % 3)

		self["m_petItem" .. var_10_0]:setVisible(false)
		self["m_enter_" .. var_10_0 .. "Transition"]:play()
		self:newScheduleOnce(handler(self, self._close), 0.3)
	else
		self:_close()
	end
end

function PetShowTimePop:_close()
	if not self._customPlay then
		g.core.module.ModuleManager:popComponent()
	end

	self:_doCallBack()
end

function PetShowTimePop:onUnload()
	self:_doCallBack()
end

function PetShowTimePop:_doCallBack()
	if self._callBack then
		self._callBack()
	end

	self._callBack = nil
end

function PetShowTimePop:_onShareClick()
	if not self._playEndAnmi then
		return
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		self:setVisible(false)

		return
	end

	local var_14_0 = self.m_isNewController:getSelectedIndex()

	self.m_shareComp:setVisible(false)
	self.m_isNewController:setSelectedIndex(0)
	self.m_isAutoFragmentBoxController:setSelectedIndex(0)
	self.m_petItem1.m_fragGroup:setVisible(false)
	self.m_petItem2.m_fragGroup:setVisible(false)

	local var_14_1 = cc.utils:captureNode(self)

	var_14_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_14_1:release()
	self.m_shareComp:setVisible(true)
	self.m_isNewController:setSelectedIndex(var_14_0)
	self.m_isAutoFragmentBoxController:setSelectedIndex((self.m_isAutoFragmentBoxController:getSelectedIndex()))
	self.m_petItem1.m_fragGroup:setVisible((self.m_petItem1.m_fragGroup:isVisible()))
	self.m_petItem2.m_fragGroup:setVisible((self.m_petItem2.m_fragGroup:isVisible()))
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_19
	})
end

return PetShowTimePop
