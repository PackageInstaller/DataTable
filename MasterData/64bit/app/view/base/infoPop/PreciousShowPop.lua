local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local PreciousShowPop = class("PreciousShowPop", require("app.fairyGUI.infoPop.UI_PreciousShowPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		pkgPath = "ui/infoPop/infoPop",
		resName = "PreciousShowPop"
	})
end)

function PreciousShowPop:ctor(arg_2_1, arg_2_2)
	self._customPlay = arg_2_2
	self._group1OrginPos = self.m_item1:getPosition()

	self:_addListeners()

	if not arg_2_1 then
		return
	end

	self:updatePop(arg_2_1)
	self.m_bgLoader:setURL("bg/precious/bg_gzp_xinxizhanshibg.png")
end

function PreciousShowPop:_addListeners()
	self:addClickListener(handler(self, self._onReturnBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
end

function PreciousShowPop:_resetUI()
	for iter_4_0 = 1, 2 do
		self["m_item" .. iter_4_0]:setVisible(true)
	end

	self.m_shareComp:setVisible(false)
end

function PreciousShowPop:_initShowDatas(arg_5_1)
	self._showDatas = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(self._showDatas, {
			value = iter_5_1.value,
			isNew = iter_5_1.isNew
		})
	end
end

function PreciousShowPop:updatePop(arg_6_1)
	self:_resetUI()

	self._playEndAnmi = false
	self._playIdx = 0
	self._param = arg_6_1

	self:_initShowDatas(arg_6_1.awards)

	if #self._showDatas > 1 then
		self.m_isMulityController:setSelectedIndex(1)
	else
		self.m_isMulityController:setSelectedIndex(0)
	end

	self._transPlayEnd = false
	self._wordAnimEnd = false
	self._callBack = arg_6_1.callBack
	self._isJustShow = arg_6_1.justShow

	self:_playShowNextItem()
end

function PreciousShowPop:_playShowNextItem()
	self.m_flushTopNode:setVisible(true)

	if self._playIdx >= #self._showDatas then
		self:_allItemShowOver()

		return
	end

	self._playIdx = self._playIdx + 1

	local var_7_0 = self["m_item" .. math.max(1, self._playIdx % 3)]
	local var_7_1 = self.m_item1

	self.m_item1:updateItemComp(self._showDatas[self._playIdx].value)
	var_7_1:setVisible(true)

	self._playEndAnmi = false

	self.m_normalEnterTransition:play(handler(self, self._onOneItemActionPlayEnd))

	local var_7_2 = g.core.config.precious_info.get(self._showDatas[self._playIdx].value)

	if var_7_2.quality > var_0_0.SSR then
		self.m_titleBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi" .. var_7_2.quality + 1)
	else
		self.m_titleBg:setURL("ui://base_new/pic_gzp_xinxizhanshidi4")
	end

	var_7_1:playShowEffect(var_7_2.quality)
	self:_playTitleEffect(var_7_2.quality)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_GET_GZ)
end

function PreciousShowPop:_playTitleEffect(arg_8_1)
	self.m_effTitle:addEffectSpine({
		isLoop = false,
		name = "eff_ui_precious_title",
		remove = true,
		anim = (arg_8_1 or nil) and ("play_" .. arg_8_1 + 1 or "play_2")
	})
end

function PreciousShowPop:_onOneItemActionPlayEnd()
	self._playEndAnmi = true

	self.m_flushTopNode:setVisible(false)
	self.m_shareComp:setVisibleEx(true)
end

function PreciousShowPop:_onReturnBtnClick()
	if self._playEndAnmi then
		self:_playShowNextItem()
	end
end

function PreciousShowPop:_allItemShowOver()
	if #self._showDatas > 1 then
		self._playEndAnmi = false
		self._playIdx = self._playIdx + 1

		self["m_item" .. math.max(1, self._playIdx % 3)]:setVisible(false)
		self:newScheduleOnce(handler(self, self._close), 0.3)
	else
		self:_close()
	end
end

function PreciousShowPop:_close()
	if not self._customPlay then
		g.core.module.ModuleManager:popComponent()
	end

	self:_doCallBack()
end

function PreciousShowPop:onUnload()
	self:_doCallBack()
end

function PreciousShowPop:_doCallBack()
	if self._callBack then
		self._callBack()
	end

	self._callBack = nil
end

function PreciousShowPop:_onShareClick()
	if not self._playEndAnmi then
		return
	end

	if g.core.guide.GuideProxy:isGuideRunning() then
		self:setVisible(false)

		return
	end

	self.m_shareComp:setVisible(false)

	local var_15_0 = cc.utils:captureNode(self)

	var_15_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	self.m_shareComp:setVisible(true)
	var_15_0:release()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_19
	})
end

return PreciousShowPop
