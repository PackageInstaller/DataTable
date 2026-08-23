local var_0_0 = g.core.model.User.recruitData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitPreciousRewardPop = class("RecruitPreciousRewardPop", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousRewardPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/recruitPrecious/recruitPrecious",
		resName = "RecruitPreciousRewardPop",
		pkgName = "recruitPrecious"
	}, ...)
end)

function RecruitPreciousRewardPop:ctor(arg_2_1)
	self._params = arg_2_1
	self._awards = arg_2_1.awards
	self._isAlive = true
	self._recruitType = arg_2_1.recruit_type
	self._cfg = arg_2_1.cfg
	self._callBack = arg_2_1.callBack
	self._isShare = false
	self._playIdx = 0
	self._animEndRecords = {}
	self._animEndRecordCount = 0
	self._highQuality = arg_2_1.quality
	self._forceJump = false

	self:_addListeners()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))

	local var_2_0

	if #self._awards > 1 then
		local var_2_2

		var_2_2, var_2_0 = var_0_0:getgenRecruitConsume(self._cfg.ten_summon_cost)

		self.m_isTenController:setSelectedIndex(1)
	else
		local var_2_4

		var_2_4, var_2_0 = var_0_0:getgenRecruitConsume(self._cfg.single_summon_cost)

		self.m_isTenController:setSelectedIndex(0)
	end

	self:_updateCost(var_2_0)
	self:_onUpdateTipText()
	self.m_showTypeController:setSelectedIndex(0)
	self.m_mapSpineComp:setCallBack(handler(self, self._onSpineActionEnd))
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function RecruitPreciousRewardPop:_updateCost(arg_3_1)
	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(arg_3_1.type, arg_3_1.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = arg_3_1.size
	}))

	if g.core.model.User.bagData:getOwnNum(arg_3_1.type, arg_3_1.value) < arg_3_1.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end
end

function RecruitPreciousRewardPop:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
end

function RecruitPreciousRewardPop:_addListeners()
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))
	self:addListen(self.m_mapSpineComp)
end

function RecruitPreciousRewardPop:_onSpineActionEnd()
	self.m_showTypeController:setSelectedIndex(1)

	if #self._awards > 1 then
		self:_updateRewardItemGroup()
	end

	self.m_rewardItem:updateItem(self._awards[1], 1)
	self.m_rewardItem:setActionCallback(handler(self, self._onOneItemAnimPlayEnd))
	self:setVisible(false)
	self:_showAllPop((self:_getNeedShowPopAwards()))
end

function RecruitPreciousRewardPop:onLoad()
	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end

	self.m_mapSpineComp:playShow(self._params)
end

function RecruitPreciousRewardPop:_showMapEffect()
	self.m_showTypeController:setSelectedIndex(0)
end

function RecruitPreciousRewardPop:_getNeedShowPopAwards()
	if #self._awards == 1 then
		return clone(self._awards)
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._awards) do
		if iter_9_1.isNew or iter_9_1.quality and iter_9_1.quality > 2 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function RecruitPreciousRewardPop:_showAllPop(arg_10_1)
	if #arg_10_1 == 0 then
		self:_onShowPopEnd()

		return
	end

	local var_10_0 = {
		callBack = handler(self, self._onShowPopEnd),
		awards = arg_10_1
	}

	self:setVisible(true)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.PreciousShowPop").new(var_10_0), var_10_0)
end

function RecruitPreciousRewardPop:_onShowPopEnd()
	if not self._isAlive then
		return
	end

	self.m_enterTransition:play()
	self:setVisible(true)

	if self.m_isTenController:getSelectedIndex() == 0 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_ONE_REWARD)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_TEN_REWARD)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW)
end

function RecruitPreciousRewardPop:_updateRewardItemGroup()
	for iter_12_0 = 1, 10 do
		self["m_rewardItem" .. iter_12_0]:updateItem(self._awards[iter_12_0], iter_12_0)
		self["m_rewardItem" .. iter_12_0]:setActionCallback(handler(self, self._onOneItemAnimPlayEnd))
	end
end

function RecruitPreciousRewardPop:_onUpdateTipText()
	local var_13_0 = var_0_0:getCostInfoId(self._recruitType, #self._params.awards)

	if var_13_0 == 0 then
		self.m_tipText:setText("")

		return
	end

	local var_13_1 = g.core.config.recruit_knight_cost_gain_info.get(var_13_0)
	local var_13_2 = g.core.common.Goods:convert({
		value = var_13_1.gain_value,
		type = var_13_1.gain_type,
		size = var_13_1.gain_size
	})

	self.m_tipText:setText(g.core.lang:get(108046, {
		num = var_13_2.size,
		name = var_13_2.name
	}))
end

function RecruitPreciousRewardPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)

	self._isAlive = false

	if self._callBack then
		self._callBack()
	end
end

function RecruitPreciousRewardPop:_onOkBtnClick()
	self:_closeLayer()
end

function RecruitPreciousRewardPop:_closeLayer()
	if self._params.isPreLoad then
		self:removeFromParent()
	else
		g.core.module.ModuleManager:popByDisplay(self)
	end

	if self._callBack then
		self._callBack()
	end
end

function RecruitPreciousRewardPop:_onOneItemAnimPlayEnd(arg_17_1)
	if not self._animEndRecords[arg_17_1] then
		self._animEndRecords[arg_17_1] = true
		self._animEndRecordCount = self._animEndRecordCount + 1

		if self._animEndRecordCount >= #self._awards then
			self._isAnimEnd = true
		end
	end
end

function RecruitPreciousRewardPop:onClickBackBtn()
	self:_closeLayer()
end

function RecruitPreciousRewardPop:_onClickContinueBtn()
	local var_19_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_19_1 = g.core.model.User.recruitData:getDrawInfo(var_19_0:getRecruitId())
	local var_19_2 = var_19_1:getCfg()
	local var_19_3 = var_19_0:getRecruitNum()
	local var_19_4

	if var_19_3 == 1 then
		var_19_4 = "single_summon_cost"
	elseif var_19_3 <= 10 then
		var_19_4 = "ten_summon_cost"
	elseif var_19_3 == 20 then
		var_19_4 = "twenty_summon_cost"
	end

	local var_19_5, var_19_6 = var_0_0:getgenRecruitConsume(var_19_2[var_19_4])
	local var_19_7 = var_19_0:getCurBuyItemInfo()
	local var_19_8 = {
		itemInfo = var_19_7,
		recruitType = var_19_0:getRecruitType(),
		consumeType = var_19_6.requestType,
		num = var_19_3,
		recruitId = var_19_0:getRecruitId()
	}

	if var_19_3 <= var_19_1:getLeftFreeTimes() then
		var_19_8.consumeType = 0
		var_19_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_19_7, var_19_8, 1, 0)
end

function RecruitPreciousRewardPop:_sendContinue(arg_20_1)
	self:dispatchCompEvent("doRecruitContinue", {
		display = self,
		num = #self._awards
	})
	self:_closeLayer()
end

return RecruitPreciousRewardPop
