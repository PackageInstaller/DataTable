local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitUniteTokenRewardPop = class("RecruitUniteTokenRewardPop", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenRewardPop"), function()
	return fgui.GComponent:create({
		pkgName = "recruitUniteToken",
		resName = "RecruitUniteTokenRewardPop",
		pkgPath = "ui/recruitUniteToken/recruitUniteToken"
	})
end)

function RecruitUniteTokenRewardPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self.m_bgLoader:setURL("bg/recruit/bg_zm_zhaomujieguo.jpg")
	self:showAtCenter()

	self._param = arg_2_1
	self._awards = arg_2_1.awards
	self._param1 = arg_2_1.param1 or 0
	self._isShare = arg_2_1.isShare or false
	self._recruitCfg = arg_2_1.cfg
	self._justShowResult = arg_2_1.justShowResult
	self._touchEnable = false

	self:addClickListener(handler(self, self._onCloseSelf))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseSelf))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))

	if self._param.num == 5 then
		self._maxNum = 5

		self.m_typeController:setSelectedIndex(1)
	elseif self._param.num == 20 then
		self._maxNum = 20

		self.m_typeController:setSelectedIndex(2)
	else
		self._maxNum = 1

		self.m_typeController:setSelectedIndex(0)
	end

	self:updateView()

	local var_2_0 = g.core.model.User.recruitData:getCostInfoId(arg_2_1.recruit_type, self._maxNum)

	if var_2_0 == 0 then
		self.m_topDescTxt:setText("")

		return
	end

	local var_2_1 = g.core.config.recruit_knight_cost_gain_info.get(var_2_0)
	local var_2_2 = g.core.common.Goods:convert({
		value = var_2_1.gain_value,
		type = var_2_1.gain_type,
		size = var_2_1.gain_size
	})

	self.m_topDescTxt:setText(g.core.lang:get(108046, {
		num = var_2_2.size,
		name = var_2_2.name
	}))
	self.m_shareComp:setVisibleEx(not self._isShare)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_enterTransition:play(handler(self, self._onEnterPlayFinish))
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function RecruitUniteTokenRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
	self.m_continueBtn:addAutoBuyCompListener()
end

function RecruitUniteTokenRewardPop:_onTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitUniteTokenRewardPop:_onTouchMove(arg_5_1)
	self.m_twentyComp:tTouchMove(arg_5_1)
end

function RecruitUniteTokenRewardPop:_onEnterPlayFinish()
	self._touchEnable = true

	g.core.model.User.UserTitleData:checkScorePush()
end

function RecruitUniteTokenRewardPop:updateView()
	self.m_enterTransition:stop()

	if self._maxNum == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_SHOW_SINGLE)
		self.m_oneShowComp:updateItem(self._awards[1], self._param1)
	elseif self._maxNum == 20 then
		self.m_twentyComp:updateChildComp({
			award = self._awards,
			newFlag = self._param1
		})
		self.m_twentyComp:resetPosition()
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_SHOW_FIVE)

		for iter_7_0 = 1, 5 do
			self["m_comp" .. iter_7_0]:updateItem(self._awards[iter_7_0], self._param1 / math.pow(10, iter_7_0 - 1) % 10 > 0)
		end
	end

	self:_updateCost()
end

function RecruitUniteTokenRewardPop:_onTwentyItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateItem(self._awards[arg_8_1 + 1], self._param1 / math.pow(10, arg_8_1) % 10 > 0)
end

function RecruitUniteTokenRewardPop:_onCloseSelf()
	if not self._touchEnable then
		return
	end

	g.core.model.User.recruitData:clearNewUniteToken()
	g.core.module.ModuleManager:popComponent()
end

function RecruitUniteTokenRewardPop:_onShareClick()
	if not self._touchEnable then
		return
	end

	self.m_shareComp:setVisible(false)

	if self._maxNum == 1 then
		self.m_oneShowComp:setShareState()
	elseif self._maxNum == 20 then
		self.m_twentyComp:setShareState()
	else
		for iter_10_0 = 1, 5 do
			self["m_comp" .. iter_10_0]:setShareState()
		end
	end

	local var_10_0 = cc.utils:captureNode(self)

	var_10_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_10_0:release()
	self.m_shareComp:setVisible(true)

	if self._maxNum == 1 then
		self.m_oneShowComp:resetShareState()
	elseif self._maxNum == 20 then
		self.m_twentyComp:resetShareState()
	else
		for iter_10_1 = 1, 5 do
			self["m_comp" .. iter_10_1]:resetShareState()
		end
	end

	local var_10_1 = {}

	if #self._awards == 1 then
		var_10_1 = {
			{
				isNew = self.m_oneShowComp:getIsNew()
			}
		}
	else
		for iter_10_2 = 1, #self._awards do
			var_10_1[iter_10_2] = {}
			var_10_1[iter_10_2].isNew = self._maxNum == 20 and self.m_twentyComp:getIsNewByIndex(iter_10_2) or self["m_comp" .. iter_10_2]:getIsNew()
		end
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_10,
		awards = self._awards,
		param1 = var_10_1
	})
end

function RecruitUniteTokenRewardPop:_updateCost()
	if not self._recruitCfg or self._justShowResult then
		self.m_isHideBtnGroupController:setSelectedIndex(1)

		return
	end

	local var_11_0

	if #self._awards == 5 then
		local var_11_2

		var_11_2, var_11_0 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	elseif #self._awards == 1 then
		local var_11_4

		var_11_4, var_11_0 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	elseif #self._awards > 10 then
		local var_11_6

		var_11_6, var_11_0 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.twenty_summon_cost)
	end

	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(var_11_0.type, var_11_0.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = var_11_0.size
	}))

	if g.core.model.User.bagData:getOwnNum(var_11_0.type, var_11_0.value) < var_11_0.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end

	self.m_isHideBtnGroupController:setSelectedIndex(0)
end

function RecruitUniteTokenRewardPop:_onClickContinueBtn()
	if not self._touchEnable then
		return
	end

	if g.core.model.User.recruitData:checkIsFull(self._recruitCfg) then
		local var_12_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_12_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doContinue),
			onCheck = function(arg_13_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_13_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doContinue()
	end
end

function RecruitUniteTokenRewardPop:_doContinue()
	local var_14_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_14_1 = g.core.model.User.recruitData:getDrawInfo(var_14_0:getRecruitId())
	local var_14_2 = var_14_1:getCfg()
	local var_14_3 = var_14_0:getRecruitNum()
	local var_14_4

	if var_14_3 == 1 then
		var_14_4 = "single_summon_cost"
	elseif var_14_3 <= 10 then
		var_14_4 = "ten_summon_cost"
	elseif var_14_3 == 20 then
		var_14_4 = "twenty_summon_cost"
	end

	local var_14_5, var_14_6 = g.core.model.User.recruitData:getgenRecruitConsume(var_14_2[var_14_4])
	local var_14_7 = var_14_0:getCurBuyItemInfo()
	local var_14_8 = {
		itemInfo = var_14_7,
		recruitType = var_14_0:getRecruitType(),
		consumeType = var_14_6.requestType,
		num = var_14_3,
		recruitId = var_14_0:getRecruitId()
	}

	if var_14_3 <= var_14_1:getLeftFreeTimes() then
		var_14_8.consumeType = 0
		var_14_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_14_7, var_14_8, 1, 0)
	self:dispatchCompEvent("doRecruitContinue", {
		num = var_14_0:getRecruitNum()
	})
end

function RecruitUniteTokenRewardPop:_sendContinue(arg_15_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_15_1.recruitId,
		consume_type = arg_15_1.consumeType,
		num = arg_15_1.num
	})
end

function RecruitUniteTokenRewardPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function RecruitUniteTokenRewardPop:_doRecruit(arg_17_1, arg_17_2, arg_17_3)
	if not self:isVisible() then
		return
	end

	self._awards = arg_17_3.awards
	self._touchEnable = false

	self:_onShowFullAward()
end

function RecruitUniteTokenRewardPop:_onShowFullAward()
	local var_18_0 = handler(self, self._onShowAllReward)
	local var_18_1 = require("app.view.module.show.ShowFactory"):getUniteTokenShowArr({
		awards = self._awards
	})

	if #var_18_1 > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "RecruitGetUniteToken",
					func = function()
						local var_19_0 = require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop").new(var_18_1, var_18_0)

						g.core.module.ModuleManager:pushPopup(var_19_0)

						return var_19_0
					end
				}
			}
		})
	else
		var_18_0()
	end
end

function RecruitUniteTokenRewardPop:_onShowAllReward()
	self:updateView()
	self.m_enterTransition:play(handler(self, self._onEnterPlayFinish))
end

return RecruitUniteTokenRewardPop
