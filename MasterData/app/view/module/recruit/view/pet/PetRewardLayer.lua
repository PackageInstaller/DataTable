local PetRewardLayer = class("PetRewardLayer", require("app.fairyGUI.recruitPet.UI_PetRewardLayer"), function()
	return fgui.GComponent:create({
		resName = "PetRewardLayer",
		pkgPath = "ui/recruitPet/recruitPet",
		isFullScreen = true,
		pkgName = "recruitPet"
	}, ...)
end)
local var_0_1 = g.core.model.User.recruitData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function PetRewardLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._awards = arg_2_1.awards
	self._recruitType = arg_2_1.recruit_type
	self._justShowResult = arg_2_1.justShowResult
	self._matchQuality = arg_2_1.matchQuality or 3
	self._callBack = arg_2_1.callBack
	self._isShare = arg_2_1.isShare
	self._recruitCfg = arg_2_1.cfg
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
	self:_checkAwards()
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function PetRewardLayer:_checkAwards()
	for iter_3_0, iter_3_1 in ipairs(self._awards) do
		iter_3_1.quality = iter_3_1.quality or g.core.common.Goods:convert(iter_3_1).quality
	end
end

function PetRewardLayer:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
end

function PetRewardLayer:_addListeners()
	self:addClickListener(handler(self, self._onOkBtnClick))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))
end

function PetRewardLayer:_init()
	local var_6_0 = self:addBg("bg/recruit/bg_zm_yuanzhishou2.jpg")

	var_6_0:setOpacity(0)
	var_6_0:runFGAction(fgui.FFadeIn:create(0.4))
	self:_onUpdateTipText()
end

function PetRewardLayer:_onUpdateTipText()
	local var_7_0 = var_0_1:getCostInfoId(self._recruitType, #self._params.awards)

	if var_7_0 == 0 then
		self.m_tipText:setText("")

		return
	end

	local var_7_1 = g.core.config.recruit_knight_cost_gain_info.get(var_7_0)
	local var_7_2 = g.core.common.Goods:convert({
		value = var_7_1.gain_value,
		type = var_7_1.gain_type,
		size = var_7_1.gain_size
	})

	self.m_tipText:setText(g.core.lang:get(108046, {
		num = var_7_2.size,
		name = var_7_2.name
	}))
end

function PetRewardLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._onRecruitMsg, self)
	self:_updateView()
	self:setVisible(false)

	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end

	self:_showAllPop((self:_getNeedShowPopAwards()))
end

function PetRewardLayer:_updateView()
	if #self._awards > 1 then
		self:_updateRewardItemGroup()
	end

	self.m_rewardItem:updateItem(self._awards[1], 1)
	self:_updateCost()
end

function PetRewardLayer:_updateRewardItemGroup()
	for iter_10_0 = 1, 10 do
		self["m_rewardItem" .. iter_10_0]:updateItem(self._awards[iter_10_0], iter_10_0)
	end
end

function PetRewardLayer:_getNeedShowPopAwards()
	return self:_filterAwards(#self._awards == 1)
end

function PetRewardLayer:_filterAwards(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._awards) do
		if iter_12_1.type == g.core.common.Goods.TYPE_PET and (arg_12_1 or iter_12_1.isNew or iter_12_1.quality >= self._matchQuality) then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function PetRewardLayer:_showAllPop(arg_13_1)
	if #arg_13_1 == 0 then
		self:_onShowPopEnd()

		return
	end

	local var_13_0 = {
		callBack = handler(self, self._onShowPopEnd),
		awards = arg_13_1
	}

	self:setVisible(true)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.PetShowTimePop").new(var_13_0), var_13_0)
end

function PetRewardLayer:_onShowPopEnd()
	self:setVisible(true)

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_ONE_REWARD)
	else
		for iter_14_0 = 1, 10 do
			self["m_rewardItem" .. iter_14_0]:playEnterAction(handler(self, self._onOneItemAnimPlayEnd))
			self["m_rewardItem" .. iter_14_0]:playShareTrans((iter_14_0 - 1) * 0.03)
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_TEN_REWARD)
	end
end

function PetRewardLayer:_onRewardItemRender(arg_15_1, arg_15_2)
	arg_15_2:updateItem(self._awards[arg_15_1 + 1], arg_15_1 + 1)
end

function PetRewardLayer:onUnload()
	if self._callBack then
		self._callBack()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function PetRewardLayer:_onOkBtnClick()
	if not self._isAnimEnd then
		return
	end

	self:_closeLayer()
end

function PetRewardLayer:_closeLayer()
	if self._params.isPreLoad then
		self:removeFromParent()
	else
		g.core.module.ModuleManager:popComponent()
	end

	if self._callBack then
		self._callBack()
	end
end

function PetRewardLayer:_onOneItemAnimPlayEnd(arg_19_1)
	if not self._animEndRecords[arg_19_1] then
		self._animEndRecords[arg_19_1] = true
		self._animEndRecordCount = self._animEndRecordCount + 1

		if self._animEndRecordCount >= #self._awards then
			self._isAnimEnd = true

			self.m_shareComp:setVisibleEx(not self._isShare)
			self.m_shareComp:setAutoFadeOut(true)
		end
	end
end

function PetRewardLayer:_onShareClick()
	if not self._isAnimEnd then
		return
	end

	local var_20_0 = self.m_tipText:isVisible()

	self.m_shareComp:setVisibleEx(false)
	self.m_tipText:setVisible(false)
	self.m_continueText:setVisible(false)

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:setCtrlIndex(0, 0)
	else
		for iter_20_0 = 1, 10 do
			self["m_rewardItem" .. iter_20_0]:setCtrlIndex(0, 0)
		end
	end

	local var_20_1 = cc.utils:captureNode(self)

	var_20_1:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_20_1:release()

	if self.m_isTenController:getSelectedIndex() == 0 then
		self.m_rewardItem:resetState()
	else
		for iter_20_1 = 1, 10 do
			self["m_rewardItem" .. iter_20_1]:resetState()
		end
	end

	self.m_shareComp:setVisibleEx(true)
	self.m_tipText:setVisible(var_20_0)
	self.m_continueText:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_18,
		awards = self._params.awards
	})
end

function PetRewardLayer:onClickBackBtn()
	self:_closeLayer()
end

function PetRewardLayer:_updateCost()
	if not self._recruitCfg or self._justShowResult then
		self.m_isHideBtnGroupController:setSelectedIndex(1)

		return
	end

	local var_22_0

	if #self._params.awards > 1 then
		local var_22_2

		var_22_2, var_22_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	else
		local var_22_4

		var_22_4, var_22_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	end

	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(var_22_0.type, var_22_0.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = var_22_0.size
	}))

	if g.core.model.User.bagData:getOwnNum(var_22_0.type, var_22_0.value) < var_22_0.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end

	self.m_isHideBtnGroupController:setSelectedIndex(0)
end

function PetRewardLayer:_onClickContinueBtn()
	if var_0_1:checkIsFull(self._recruitCfg) then
		local var_23_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_23_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doContinue),
			onCheck = function(arg_24_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_24_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doContinue()
	end
end

function PetRewardLayer:_doContinue()
	local var_25_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_25_1 = g.core.model.User.recruitData:getDrawInfo(var_25_0:getRecruitId())
	local var_25_2 = var_25_1:getCfg()
	local var_25_3 = var_25_0:getRecruitNum()
	local var_25_4

	if var_25_3 == 1 then
		var_25_4 = "single_summon_cost"
	elseif var_25_3 <= 10 then
		var_25_4 = "ten_summon_cost"
	elseif var_25_3 == 20 then
		var_25_4 = "twenty_summon_cost"
	end

	local var_25_5, var_25_6 = var_0_1:getgenRecruitConsume(var_25_2[var_25_4])
	local var_25_7 = var_25_0:getCurBuyItemInfo()
	local var_25_8 = {
		itemInfo = var_25_7,
		recruitType = var_25_0:getRecruitType(),
		consumeType = var_25_6.requestType,
		num = var_25_3,
		recruitId = var_25_0:getRecruitId()
	}

	if var_25_3 <= var_25_1:getLeftFreeTimes() then
		var_25_8.consumeType = 0
		var_25_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_25_7, var_25_8, 1, 0)
	self:dispatchCompEvent("doRecruitContinue", {
		num = #self._awards
	})
end

function PetRewardLayer:_sendContinue(arg_26_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_26_1.recruitId,
		consume_type = arg_26_1.consumeType,
		num = arg_26_1.num
	})
end

function PetRewardLayer:_onRecruitMsg(arg_27_1, arg_27_2, arg_27_3)
	if not self:isVisible() then
		return
	end

	local var_27_0 = g.core.common.Goods

	for iter_27_0 = 1, #arg_27_3.awards do
		local var_27_1 = var_27_0:convert(arg_27_3.awards[iter_27_0])
		local var_27_2 = math.min(2, var_27_1.quality)

		if arg_27_3.awards[iter_27_0].type == var_27_0.TYPE_PET then
			arg_27_3.awards[iter_27_0].isNew = g.core.model.User.recruitData:checkIsNewPet(arg_27_3.awards[iter_27_0].value)
		end

		arg_27_3.awards[iter_27_0].quality = var_27_1.quality
		arg_27_3.awards[iter_27_0].id = iter_27_0
	end

	self._awards = arg_27_3.awards

	self:_updateView()
	self:_showAllPop((self:_getNeedShowPopAwards()))
end

return PetRewardLayer
