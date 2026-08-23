local KnightSoulRewardLayer = class("KnightSoulRewardLayer", require("app.fairyGUI.recruitKnightSoul.UI_KnightSoulRewardLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/recruitKnightSoul/recruitKnightSoul",
		resName = "KnightSoulRewardLayer",
		pkgName = "recruitKnightSoul",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.model.User.recruitData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function KnightSoulRewardLayer:ctor(arg_2_1)
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
	self._matchQuality = arg_2_1.matchQuality or 3
	self._highQuality = arg_2_1.quality
	self._forceJump = false

	self:_addListeners()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))
	self.m_cardSpineComp:setCallBack(handler(self, self._onSpineActionEnd))
	self:_updateView()
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function KnightSoulRewardLayer:_updateView()
	local var_3_0

	if #self._awards > 1 then
		local var_3_2

		var_3_2, var_3_0 = var_0_1:getgenRecruitConsume(self._cfg.ten_summon_cost)

		self.m_isTenController:setSelectedIndex(1)
	else
		local var_3_4

		var_3_4, var_3_0 = var_0_1:getgenRecruitConsume(self._cfg.single_summon_cost)

		self.m_isTenController:setSelectedIndex(0)
	end

	self:_updateCost(var_3_0)
	self:_onUpdateTipText()
	self.m_showTypeController:setSelectedIndex(0)
end

function KnightSoulRewardLayer:_updateCost(arg_4_1)
	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(arg_4_1.type, arg_4_1.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = arg_4_1.size
	}))

	if g.core.model.User.bagData:getOwnNum(arg_4_1.type, arg_4_1.value) < arg_4_1.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end
end

function KnightSoulRewardLayer:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
end

function KnightSoulRewardLayer:_addListeners()
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))
	self:addListen(self.m_cardSpineComp)
end

function KnightSoulRewardLayer:_onSpineActionEnd()
	self.m_showTypeController:setSelectedIndex(1)

	if #self._awards > 1 then
		self:_updateRewardItemGroup()
	end

	self.m_rewardItem:updateItem(self._awards[1], 1)
	self:setVisible(false)
	self:_showAllPop((self:_getNeedShowPopAwards()))
	self.m_cardSpineComp:setVisible(false)
end

function KnightSoulRewardLayer:onLoad()
	self.m_cardSpineComp:playShow({
		quality = self._highQuality
	})

	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end
end

function KnightSoulRewardLayer:_getNeedShowPopAwards()
	if #self._awards == 1 then
		return clone(self._awards)
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._awards) do
		if iter_9_1.isNew or iter_9_1.quality and iter_9_1.quality >= self._matchQuality then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function KnightSoulRewardLayer:_showAllPop(arg_10_1)
	self:_onShowPopEnd()
end

function KnightSoulRewardLayer:_onShowPopEnd()
	if not self._isAlive then
		return
	end

	self:setVisible(true)

	if self.m_isTenController:getSelectedIndex() == 0 then
		if self._forceJump then
			self.m_rewardItem:playEnterAction(handler(self, self._onOneItemAnimPlayEnd), 1.5)
		else
			self.m_rewardItem:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_ONE_REWARD)
	else
		for iter_11_0 = 1, 10 do
			if self._forceJump then
				self["m_rewardItem" .. iter_11_0]:playEnterAction(handler(self, self._onOneItemAnimPlayEnd), 1.5)
			else
				self["m_rewardItem" .. iter_11_0]:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
				self["m_rewardItem" .. iter_11_0]:playShareTrans((iter_11_0 - 1) * 0.03)
			end
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_TEN_REWARD)
	end
end

function KnightSoulRewardLayer:_updateRewardItemGroup()
	for iter_12_0 = 1, 10 do
		self["m_rewardItem" .. iter_12_0]:updateItem(self._awards[iter_12_0], iter_12_0)
	end
end

function KnightSoulRewardLayer:_onUpdateTipText()
	local var_13_0 = var_0_1:getCostInfoId(self._recruitType, #self._params.awards)

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

function KnightSoulRewardLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "skipAnimation" then
		self._forceJump = true
		self._isAnimEnd = true

		self:_onSpineActionEnd()

		return true
	end

	return false
end

function KnightSoulRewardLayer:onUnload()
	self._isAlive = false

	if self._callBack then
		self._callBack()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function KnightSoulRewardLayer:_onOkBtnClick()
	if not self._isAnimEnd then
		return
	end

	self:_closeLayer()
end

function KnightSoulRewardLayer:_closeLayer()
	if self._params.isPreLoad then
		self:removeFromParent()
	else
		g.core.module.ModuleManager:popByDisplay(self)
	end

	if self._callBack then
		self._callBack()
	end
end

function KnightSoulRewardLayer:_onOneItemAnimPlayEnd(arg_18_1)
	if not self._animEndRecords[arg_18_1] then
		self._animEndRecords[arg_18_1] = true
		self._animEndRecordCount = self._animEndRecordCount + 1

		if self._animEndRecordCount >= #self._awards then
			self._isAnimEnd = true
		end
	end
end

function KnightSoulRewardLayer:onClickBackBtn()
	self:_closeLayer()
end

function KnightSoulRewardLayer:_onClickContinueBtn()
	local var_20_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_20_1 = g.core.model.User.recruitData:getDrawInfo(var_20_0:getRecruitId())
	local var_20_2 = var_20_1:getCfg()
	local var_20_3 = var_20_0:getRecruitNum()
	local var_20_4

	if var_20_3 == 1 then
		var_20_4 = "single_summon_cost"
	elseif var_20_3 <= 10 then
		var_20_4 = "ten_summon_cost"
	elseif var_20_3 == 20 then
		var_20_4 = "twenty_summon_cost"
	end

	local var_20_5, var_20_6 = var_0_1:getgenRecruitConsume(var_20_2[var_20_4])
	local var_20_7 = var_20_0:getCurBuyItemInfo()
	local var_20_8 = {
		itemInfo = var_20_7,
		recruitType = var_20_0:getRecruitType(),
		consumeType = var_20_6.requestType,
		num = var_20_3,
		recruitId = var_20_0:getRecruitId()
	}

	if var_20_3 <= var_20_1:getLeftFreeTimes() then
		var_20_8.consumeType = 0
		var_20_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_20_7, var_20_8, 1, 0)
end

function KnightSoulRewardLayer:_sendContinue(arg_21_1)
	self:dispatchCompEvent("doRecruitContinue", {
		display = self,
		num = #self._awards
	})
	self:_closeLayer()
end

return KnightSoulRewardLayer
