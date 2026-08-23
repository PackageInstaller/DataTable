local ArtifactRewardLayer = class("ArtifactRewardLayer", require("app.fairyGUI.recruitArtifact.UI_ArtifactRewardLayer"), function()
	return fgui.GComponent:create({
		resName = "ArtifactRewardLayer",
		pkgName = "recruitArtifact",
		isFullScreen = true,
		pkgPath = "ui/recruitArtifact/recruitArtifact"
	}, ...)
end)
local var_0_1 = g.core.model.User.recruitData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function ArtifactRewardLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._awards = arg_2_1.awards
	self._justShowResult = arg_2_1.justShowResult
	self._isAlive = true
	self._recruitType = arg_2_1.recruit_type
	self._callBack = arg_2_1.callBack
	self._isShare = arg_2_1.isShare
	self._recruitCfg = arg_2_1.cfg
	self._matchQuality = arg_2_1.matchQuality or 3
	self._animEndRecords = {}
	self._animEndRecordCount = 0

	self:_addListeners()
	self:_init()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))

	if #self._awards > 1 then
		self.m_isTenController:setSelectedIndex(1)
	else
		self.m_isTenController:setSelectedIndex(0)
	end

	self.m_shareComp:setAutoFadeOut(false)
	self.m_tipText:setVisible(not self._isShare)
	self.m_shareComp:setVisibleEx(false)
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function ArtifactRewardLayer:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
end

function ArtifactRewardLayer:_addListeners()
	self:addClickListener(handler(self, self._onOkBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))
end

function ArtifactRewardLayer:_init()
	local var_5_0 = self:addBg("bg/recruit/bg_zm_gmwz.png")

	var_5_0:setOpacity(0)
	var_5_0:runFGAction(fgui.FFadeIn:create(0.4))
	self:_onUpdateTipText()
end

function ArtifactRewardLayer:_onUpdateTipText()
	local var_6_0 = var_0_1:getCostInfoId(self._recruitType, #self._params.awards)

	if var_6_0 == 0 then
		self.m_tipText:setText("")

		return
	end

	local var_6_1 = g.core.config.recruit_knight_cost_gain_info.get(var_6_0)
	local var_6_2 = g.core.common.Goods:convert({
		value = var_6_1.gain_value,
		type = var_6_1.gain_type,
		size = var_6_1.gain_size
	})

	self.m_tipText:setText(g.core.lang:get(108046, {
		num = var_6_2.size,
		name = var_6_2.name
	}))
end

function ArtifactRewardLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._onRecruitMsg, self)
	self:_updateView()
	self:setVisible(false)

	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end

	self:_showAllPop((self:_getNeedShowPopAwards()))
end

function ArtifactRewardLayer:_updateView()
	if #self._awards > 1 then
		self:_updateRewardItemGroup()
	end

	self.m_rewardItem:updateItem(self._awards[1], 1)
	self:_updateCost()
end

function ArtifactRewardLayer:_getNeedShowPopAwards()
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

function ArtifactRewardLayer:_showAllPop(arg_10_1)
	if #arg_10_1 == 0 then
		self:_onShowPopEnd()

		return
	end

	local var_10_0 = {
		callBack = handler(self, self._onShowPopEnd),
		awards = arg_10_1
	}

	self:setVisible(true)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.ArtifactShowTimePop").new(var_10_0), var_10_0)
end

function ArtifactRewardLayer:_onShowPopEnd()
	if not self._isAlive then
		return
	end

	self:setVisible(true)

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_ONE_REWARD)
	else
		for iter_11_0 = 1, 10 do
			self["m_rewardItem" .. iter_11_0]:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
			self["m_rewardItem" .. iter_11_0]:playShareTrans((iter_11_0 - 1) * 0.03)
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_TEN_REWARD)
	end
end

function ArtifactRewardLayer:_updateRewardItemGroup()
	for iter_12_0 = 1, 10 do
		self["m_rewardItem" .. iter_12_0]:updateItem(self._awards[iter_12_0], iter_12_0)
	end
end

function ArtifactRewardLayer:onUnload()
	self._isAlive = false

	if self._callBack then
		self._callBack()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function ArtifactRewardLayer:_onOkBtnClick()
	if not self._isAnimEnd then
		return
	end

	self:_closeLayer()
end

function ArtifactRewardLayer:_closeLayer()
	if self._params.isPreLoad then
		self:removeFromParent()
	else
		g.core.module.ModuleManager:popComponent()
	end

	if self._callBack then
		self._callBack()
	end
end

function ArtifactRewardLayer:_onOneItemAnimPlayEnd(arg_16_1)
	if not self._animEndRecords[arg_16_1] then
		self._animEndRecords[arg_16_1] = true
		self._animEndRecordCount = self._animEndRecordCount + 1

		if self._animEndRecordCount >= #self._awards then
			self._isAnimEnd = true

			self.m_shareComp:setVisibleEx(not self._isShare)
			self.m_shareComp:setAutoFadeOut(true)
		end
	end
end

function ArtifactRewardLayer:_onShareClick()
	if not self._isAnimEnd then
		return
	end

	local var_17_0 = self.m_tipText:isVisible()

	self.m_shareComp:setVisibleEx(false)
	self.m_tipText:setVisible(false)
	self.m_continueText:setVisible(false)

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:setCtrlIndex(0, 0)
	else
		for iter_17_0 = 1, 10 do
			self["m_rewardItem" .. iter_17_0]:setCtrlIndex(0, 0)
		end
	end

	local var_17_1 = cc.utils:captureNode(self)

	var_17_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_17_1:release()

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:resetState()
	else
		for iter_17_1 = 1, 10 do
			self["m_rewardItem" .. iter_17_1]:resetState()
		end
	end

	self.m_shareComp:setVisibleEx(true)
	self.m_tipText:setVisible(var_17_0)
	self.m_continueText:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_7,
		awards = self._params.awards
	})
end

function ArtifactRewardLayer:onClickBackBtn()
	self:_closeLayer()
end

function ArtifactRewardLayer:_updateCost()
	if not self._recruitCfg or self._justShowResult then
		self.m_isHideBtnGroupController:setSelectedIndex(1)

		return
	end

	local var_19_0

	if #self._params.awards > 1 then
		local var_19_2

		var_19_2, var_19_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	else
		local var_19_4

		var_19_4, var_19_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	end

	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(var_19_0.type, var_19_0.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = var_19_0.size
	}))

	if g.core.model.User.bagData:getOwnNum(var_19_0.type, var_19_0.value) < var_19_0.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end

	self.m_isHideBtnGroupController:setSelectedIndex(0)
end

function ArtifactRewardLayer:_onClickContinueBtn()
	if not self._isAnimEnd then
		return
	end

	if var_0_1:checkIsFull(self._recruitCfg) then
		local var_20_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_20_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doContinue),
			onCheck = function(arg_21_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_21_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doContinue()
	end
end

function ArtifactRewardLayer:_doContinue()
	local var_22_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_22_1 = g.core.model.User.recruitData:getDrawInfo(var_22_0:getRecruitId())
	local var_22_2 = var_22_1:getCfg()
	local var_22_3 = var_22_0:getRecruitNum()
	local var_22_4

	if var_22_3 == 1 then
		var_22_4 = "single_summon_cost"
	elseif var_22_3 <= 10 then
		var_22_4 = "ten_summon_cost"
	elseif var_22_3 == 20 then
		var_22_4 = "twenty_summon_cost"
	end

	local var_22_5, var_22_6 = var_0_1:getgenRecruitConsume(var_22_2[var_22_4])
	local var_22_7 = var_22_0:getCurBuyItemInfo()
	local var_22_8 = {
		itemInfo = var_22_7,
		recruitType = var_22_0:getRecruitType(),
		consumeType = var_22_6.requestType,
		num = var_22_3,
		recruitId = var_22_0:getRecruitId()
	}

	if var_22_3 <= var_22_1:getLeftFreeTimes() then
		var_22_8.consumeType = 0
		var_22_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_22_7, var_22_8, 1, 0)
	self:dispatchCompEvent("doRecruitContinue", {
		num = var_22_3
	})
end

function ArtifactRewardLayer:_sendContinue(arg_23_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_23_1.recruitId,
		consume_type = arg_23_1.consumeType,
		num = arg_23_1.num
	})
end

function ArtifactRewardLayer:_onRecruitMsg(arg_24_1, arg_24_2, arg_24_3)
	if not self:isVisible() then
		return
	end

	local var_24_0 = g.core.common.Goods

	for iter_24_0 = 1, #arg_24_3.awards do
		local var_24_1 = var_24_0:convert(arg_24_3.awards[iter_24_0])

		arg_24_3.awards[iter_24_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_24_3.awards[iter_24_0].value)
		arg_24_3.awards[iter_24_0].quality = var_24_1.quality
		arg_24_3.awards[iter_24_0].id = iter_24_0
	end

	self._awards = arg_24_3.awards

	self:_updateView()
	self:_showAllPop((self:_getNeedShowPopAwards()))
end

return ArtifactRewardLayer
