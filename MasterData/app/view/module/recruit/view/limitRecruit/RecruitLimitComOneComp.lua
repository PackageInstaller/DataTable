local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComonUICfg = require("app.view.module.recruit.const.RecruitLimitComonUICfg")
local RecruitLimitComOneComp = class("RecruitLimitComOneComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitComOneComp"), RecruitLimitCompBase)

function RecruitLimitComOneComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitComOneComp)
		RecruitLimitCompBase.ctor(self)
	end

	self._originBtnPos = self.m_tipKnightBtn1:getPosition()

	if self.m_giftBtn then
		self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
	end

	if self.m_leaderTaskBtn then
		self.m_leaderTaskBtn:addClickListener(handler(self, self._onClickLeaderTaskBtn))
	end

	self._effLoop = nil
	self._fixed = false
end

function RecruitLimitComOneComp:_updateLuck()
	local var_2_0 = g.core.model.User.recruitData:getGuaranteedInfos(self._recruitType, true, true)

	if var_2_0 then
		if self._subComps.curLuckText then
			self._subComps.curLuckText:setText(var_2_0.totalTimes - var_2_0.times)
		end

		if self._subComps.maxLuckText then
			self._subComps.maxLuckText:setText("/" .. var_2_0.totalTimes)
		end

		if self._subComps.extLuckProg then
			self._subComps.extLuckProg:setSize(cc.size((var_2_0.totalTimes - var_2_0.times) / var_2_0.totalTimes * 192, 4))
		end

		if self._subComps.extLuckText then
			local var_2_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(self._recruitType, 7) or {
				totalTimes = 0,
				times = 0
			}
			local var_2_2 = var_2_1.totalTimes - var_2_1.times

			self._subComps.extLuckText:setText(var_2_1.totalTimes - var_2_1.times)
			self._subComps.extLuckIcon:setVisible(false)

			if self._subComps.extLuckLight then
				local var_2_3 = self._subComps.extLuckLight

				self._subComps.extLuckLight:setVisible(var_2_2 > 0)

				self._effLoop = self._effLoop or var_2_3:addEffectSpine({
					isLoop = true,
					name = "eff_ui_recruit_guarantee"
				})
			end
		end
	end
end

function RecruitLimitComOneComp:_initOtherUI()
	local var_3_0 = RecruitLimitComonUICfg.getUICfg(self._displayCfg.cfg.show_id)

	self.m_titleLoader:setURL(var_3_0.titleRes)

	local var_3_1 = self.m_titleLoader:getPosition()

	if var_3_0.titleOffset then
		self.m_titleLoader:setPosition(cc.pAdd((var_3_0.titleAdpatMode or nil) and self:_getPosXByAdaptMode(var_3_0.titleAdpatMode, self.m_titleLoader), var_3_0.titleOffset))
	end

	self.m_limitTipLoader:setURL(var_3_0.limitTimesTipBgRes)
	self.m_limitTipLoader:setPosition(cc.pAdd(self.m_limitTipLoader:getPosition(), var_3_0.limitTimesTipBgOffset))

	if var_3_0.knightBtnAdaptMode then
		local var_3_2 = self:_getPosXByAdaptMode(var_3_0.knightBtnAdaptMode, self.m_tipKnightBtn1)

		var_3_2.x = var_3_2.x - self.m_tipKnightBtn1:getSize().width / 2

		self.m_tipKnightBtn1:setPosition(var_3_2)
		self.m_enterTransition:setValue("tipEndPosX", {
			var_3_2.x,
			var_3_2.y
		})
	end

	if var_3_0.knightBtnOffset then
		local var_3_3 = cc.pAdd(self._originBtnPos, var_3_0.knightBtnOffset)

		self.m_tipKnightBtn1:setPosition(var_3_3)
		self.m_enterTransition:setValue("tipEndPosX", {
			var_3_3.x,
			var_3_3.y
		})
	end

	local var_3_4 = 0

	if var_3_0.showMask and var_3_0.maskImgRes then
		var_3_4 = 1

		self.m_maskLoader:setURL(var_3_0.maskImgRes)
	end

	self.m_isShowMaskController:setSelectedIndex(var_3_4)

	local var_3_8

	if self.m_giftBtn then
		local var_3_5 = self:_checkThemeActivityOpen()

		self.m_giftBtn:setVisible(var_3_5)

		if var_3_5 then
			local var_3_6 = self._recruitCfg.activity_id
			local var_3_7 = g.core.config.activity_theme_display_info.fetch(self._recruitCfg.activity_id)

			self.m_giftBtn:setTitle((var_3_7 or nil) and (var_3_7.gift_name or ""))
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_giftBtn,
				customData = {
					themeValue = var_3_6
				}
			})

			var_3_8 = self._recruitType
		end
	end

	local var_3_9 = var_3_8 == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN

	self.m_recruitLimitTxt:setText(g.core.lang:get(var_3_8 == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN and 108526 or 108525))

	if self.m_leaderTaskBtn then
		local var_3_10 = var_3_9 and g.core.model.User.recruitData:getDrawInfo(self._actId)
		local var_3_11 = var_3_10 and var_3_10:getCaptainSynced() == 1

		self.m_leaderTaskBtn:setVisible(var_3_9 and var_3_11)

		if var_3_9 and var_3_11 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_leaderTaskBtn,
				customData = {
					id = self._actId
				}
			})
		end
	end

	if self.m_leaderDescTxt then
		self.m_leaderDescTxt:setVisible(var_3_9)
	end
end

function RecruitLimitComOneComp:_getPosXByAdaptMode(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:getPosition()

	if arg_4_1 == 1 then
		var_4_0.x = arg_4_2:getSize().width / 2
	elseif arg_4_1 == 2 then
		var_4_0.x = self:getSize().width - arg_4_2:getSize().width / 2
	elseif arg_4_1 == 3 then
		var_4_0.y = arg_4_2:getSize().height / 2
	end

	return var_4_0
end

function RecruitLimitComOneComp:_getCNCycleUICfg(arg_5_1)
	return (arg_5_1 - 101001) % 6 + 101001
end

function RecruitLimitComOneComp:_checkThemeActivityOpen()
	if self._recruitCfg.activity_id == 0 then
		return false
	end

	local var_6_0 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(g.core.const.ConstMgr.ThemeConst.THEME_TYPE, self._recruitCfg.activity_id)

	if not var_6_0 then
		return false
	end

	return var_6_0:isOpen() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUMMER_ACTIVITY)
end

function RecruitLimitComOneComp:_onClickGiftBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopThemeGift.ShopThemeGiftPop").new({
		activityValue = self._recruitCfg.activity_id
	})))
end

function RecruitLimitComOneComp:_onClickLeaderTaskBtn()
	self:addPopup(require("app.view.module.recruit.view.pop.RecruitLeaderProgressPop").new({
		actId = self._actId
	}), {
		touchDisappear = true
	})
end

return RecruitLimitComOneComp
