local RecruitActUniteTokenRewardPop = class("RecruitActUniteTokenRewardPop", require("app.fairyGUI.recruitActUniteToken.UI_RecruitActUniteTokenRewardPop"), function()
	return fgui.GComponent:create({
		pkgName = "recruitActUniteToken",
		resName = "RecruitActUniteTokenRewardPop",
		pkgPath = "ui/recruitActUniteToken/recruitActUniteToken"
	})
end)

function RecruitActUniteTokenRewardPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()

	self._param = arg_2_1
	self._awards = arg_2_1.awards
	self._param1 = arg_2_1.param1 or 0
	self._isShare = arg_2_1.isShare or false
	self._justShowResult = arg_2_1.justShowResult
	self._recruitCfg = arg_2_1.cfg
	self._matchQuality = arg_2_1.matchQuality or 3
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
end

function RecruitActUniteTokenRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
end

function RecruitActUniteTokenRewardPop:_onTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitActUniteTokenRewardPop:_onTouchMove(arg_5_1)
	self.m_twentyComp:tTouchMove(arg_5_1)
end

function RecruitActUniteTokenRewardPop:_onEnterPlayFinish()
	self._touchEnable = true

	g.core.model.User.UserTitleData:checkScorePush()
end

function RecruitActUniteTokenRewardPop:updateView()
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

function RecruitActUniteTokenRewardPop:_onTwentyItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateItem(self._awards[arg_8_1 + 1], self._param1 / math.pow(10, arg_8_1) % 10 > 0)
end

function RecruitActUniteTokenRewardPop:_onCloseSelf()
	if not self._touchEnable then
		return
	end

	g.core.model.User.recruitData:clearNewUniteToken()
	g.core.module.ModuleManager:popComponent()
end

function RecruitActUniteTokenRewardPop:_onShareClick()
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
		param1 = var_10_1,
		recruitType = self._param.recruit_type
	})
end

function RecruitActUniteTokenRewardPop:_updateCost()
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

function RecruitActUniteTokenRewardPop:_onClickContinueBtn()
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

function RecruitActUniteTokenRewardPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function RecruitActUniteTokenRewardPop:_doContinue()
	self:dispatchCompEvent("doRecruitContinue", {
		num = #self._awards
	})
end

function RecruitActUniteTokenRewardPop:_doRecruit(arg_16_1, arg_16_2, arg_16_3)
	self._awards = arg_16_3.awards
	self._touchEnable = false

	self:_onShowFullAward()
end

function RecruitActUniteTokenRewardPop:_onShowFullAward()
	local var_17_0 = handler(self, self._onShowAllReward)
	local var_17_1 = require("app.view.module.show.ShowFactory"):getUniteTokenShowArr({
		awards = self._awards
	})

	if #var_17_1 > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "RecruitGetUniteToken",
					func = function()
						local var_18_0 = require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop").new(var_17_1, var_17_0)

						g.core.module.ModuleManager:pushPopup(var_18_0)

						return var_18_0
					end
				}
			}
		})
	else
		var_17_0()
	end
end

function RecruitActUniteTokenRewardPop:_onShowAllReward()
	self:updateView()
	self.m_enterTransition:play(handler(self, self._onEnterPlayFinish))
end

return RecruitActUniteTokenRewardPop
