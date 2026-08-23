local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.common.Goods
local GuideConst = require("app.view.module.guide.const.GuideConst")
local FogNightmareIdleMainLayer = class("FogNightmareIdleMainLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareIdleMainLayer"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareIdleMainLayer",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareIdleMainLayer:ctor()
	self:addBg("bg/fogNightmare/bg_wjmy_guaji.jpg")
	self.m_maskBgDadComp:addBg("bg/fogNightmare/bg_wjmy_guaji_mask.png")

	self._runnerScheduler = nil
	self._fullEff = nil
	self._idleData = var_0_1:getIdleData()
	self._upPercent = 0

	self:_initView()
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FOG_IDLE_ENTER)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
		tickType = 6,
		enum = GuideConst.ENUM_TICK.FOG_FIRST_ENTER_IDLE
	})
end

function FogNightmareIdleMainLayer:_initView()
	self.m_tips:setVisible(false)
	self.m_tipsBtn:addClickListener(handler(self, self._onTipsClick))
	self.m_buffTipsBtn:addClickListener(handler(self, self._onBuffTipsClick))
	self.m_detailBtn:addClickListener(handler(self, self._onIdleDetailClick))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardBtnClick))
	self.m_guildBuffBtn:addClickListener(handler(self, self._onGuildBtnClick))
	self.m_clickGetRewardComp:addClickListener(handler(self, self._onEffRewardClick))
	self.m_fogEffHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_fogNightmare_bgfog"
	})
	self.m_waterEffHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_fogNightmare_bgwater"
	})
	self:updateBaseView()
	self.m_topBar:setResInfoById(156)
	self.m_guildBuffTextList:setVirtual()
	self.m_guildBuffTextList:setItemRenderer(handler(self, self._onGuildBuffTextItemRender))
end

function FogNightmareIdleMainLayer:onLoad()
	self._idleData:clearGuildBuffInfo()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_IDLEAWARD, handler(self, self.onRewardIdle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_IDLEINFO, handler(self, self.onUpdateIdle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GUILDFLOOR, handler(self, self.onUpdateIdle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, handler(self, self._onGameTouchFinish), self)

	self._runnerScheduler = self:newSchedule(handler(self, self.updateIdleLayer), 1)

	self:newScheduleOnce(handler(self, self.checkWeakGuide), 0.5)
	self:updateLayerState()
	self:updateIdleLayer()
	self.m_enterTransition:play()
	g.core.network.GameNetProxy:send_C2S_Fog_IdleInfo({})

	local var_4_0 = g.core.model.User:getGuildId()

	if var_4_0 and var_4_0 ~= 0 then
		g.core.network.GameNetProxy:send_C2S_Fog_GuildFloor({})
		self.m_hasGuildController:setSelectedIndex(1)
	else
		self.m_hasGuildController:setSelectedIndex(0)
	end
end

function FogNightmareIdleMainLayer:checkWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FogNightmareIdleMainLayer:_onTipsClick()
	self.m_tips:setVisible(true)
end

function FogNightmareIdleMainLayer:_onBuffTipsClick()
	self.m_buffTips:setVisible(true)
end

function FogNightmareIdleMainLayer:updateLayerState()
	self._rewardEffList = {}
	self._fullEff = nil

	self.m_rewardEffHolder:removeAllEffect()

	local var_8_0 = self._idleData:getCurIdleTime()
	local var_8_1 = {
		"eff_ui_fogNightmare_partI",
		"eff_ui_fogNightmare_partII",
		"eff_ui_fogNightmare_partIII",
		"eff_ui_fogNightmare_partIIII"
	}

	if var_8_0 < 1800 then
		-- block empty
	elseif var_8_0 < 7200 then
		table.insert(self._rewardEffList, (self.m_rewardEffHolder:addEffectSpine({
			anim = "play",
			isLoop = true,
			name = var_8_1[math.random(1, #var_8_1)]
		})))
	elseif var_8_0 < 18000 then
		for iter_8_0 = 1, 2 do
			local var_8_2 = math.random(1, #var_8_1)
			local var_8_3 = self.m_rewardEffHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_8_1[var_8_2]
			})

			table.remove(var_8_1, var_8_2)
			table.insert(self._rewardEffList, var_8_3)
		end
	elseif var_8_0 < 43200 then
		for iter_8_1 = 1, 3 do
			local var_8_4 = math.random(1, #var_8_1)
			local var_8_5 = self.m_rewardEffHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_8_1[var_8_4]
			})

			table.remove(var_8_1, var_8_4)
			table.insert(self._rewardEffList, var_8_5)
		end
	else
		for iter_8_2 = 1, 4 do
			table.insert(self._rewardEffList, (self.m_rewardEffHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_8_1[iter_8_2]
			})))
		end

		self._fullEff = self.m_rewardEffHolder:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_fullLevel",
			isLoop = true
		})
	end
end

function FogNightmareIdleMainLayer:onRewardEffShow()
	for iter_9_0, iter_9_1 in ipairs(self._rewardEffList) do
		if iter_9_0 == 1 then
			iter_9_1:addSpineEventListener(handler(self, self._onSpineEvent))
		end

		iter_9_1:setAnimation(0, "play2", false)
	end
end

function FogNightmareIdleMainLayer:_onSpineEvent(arg_10_1)
	if arg_10_1.type == "complete" then
		self:updateLayerState()
	end
end

function FogNightmareIdleMainLayer:_onIdleDetailClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.fogNightmare.view.idle.FogNightmareDetailPop").new()))
end

function FogNightmareIdleMainLayer:updateBaseView()
	local var_12_0, var_12_1 = self._idleData:getMaxIdleTimeDH()
	local var_12_2 = self._idleData:getCurLevel()

	if var_12_0 ~= 0 and var_12_1 ~= 0 then
		self.m_tipsTxt:setText(g.core.lang:get(500106, {
			level = var_12_2,
			day = var_12_0,
			hour = var_12_1
		}))
	elseif var_12_0 ~= 0 then
		self.m_tipsTxt:setText(g.core.lang:get(500109, {
			level = var_12_2,
			day = var_12_0
		}))
	else
		self.m_tipsTxt:setText(g.core.lang:get(500110, {
			level = var_12_2,
			hour = var_12_1
		}))
	end

	local var_12_3 = self._idleData:getCurDayRewardItem()

	for iter_12_0 = 1, 2 do
		if var_12_3[iter_12_0] then
			local var_12_4 = var_0_2:convert(var_12_3[iter_12_0])

			self["m_idleItem" .. iter_12_0]:setTitle(g.core.lang:get(500107, {
				num = var_12_3[iter_12_0].size
			}))
			self["m_idleItem" .. iter_12_0]:setIcon(var_12_4.icon)
		end
	end
end

function FogNightmareIdleMainLayer:_onRewardBtnClick()
	if next((self._idleData:getNowReward())) then
		g.core.network.GameNetProxy:send_C2S_Fog_IdleAward({})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(500133))
	end
end

function FogNightmareIdleMainLayer:_onEffRewardClick()
	if next((self._idleData:getNowReward())) then
		g.core.network.GameNetProxy:send_C2S_Fog_IdleAward({})
	end
end

function FogNightmareIdleMainLayer:_onGameTouchFinish()
	self.m_tips:setVisible(false)
	self.m_buffTips:setVisible(false)
end

function FogNightmareIdleMainLayer:updateIdleLayer()
	if var_0_0:getTime() > var_0_1:getEndTime() then
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:popModule()

		return
	end

	local var_16_0, var_16_1, var_16_2 = self._idleData:getCurIdleTimeHMS()

	self.m_timeTxt:setText(g.core.lang:get(500105, {
		hour = g.core.utils.Number.getFormatNum(2, var_16_0),
		min = g.core.utils.Number.getFormatNum(2, var_16_1),
		sec = g.core.utils.Number.getFormatNum(2, var_16_2)
	}))

	local var_16_3 = self._idleData:getNowReward()

	for iter_16_0 = 1, 2 do
		self["m_rewardIcon" .. iter_16_0]:updateIcon(var_16_3[iter_16_0])
	end

	if #var_16_3 == 0 then
		self.m_rewardBtn:setVisible(false)
	else
		self.m_rewardBtn:setVisible(true)
	end

	self._upPercent = self._idleData:getIdleProductsUpValue()

	if self._upPercent > 0 then
		self.m_buffText:setText(g.core.lang:get(500237, {
			upValue = self._upPercent
		}))
		self.m_hasUpValueController:setSelectedIndex(1)
	else
		self.m_hasUpValueController:setSelectedIndex(0)
	end

	local var_16_4 = self._idleData:getGuildBuffInfo()

	if var_16_4.totalUpValue then
		local var_16_5 = math.floor(var_16_4.totalUpValue / 10)

		self.m_guildTipText:setText(g.core.lang:get(500264, {
			value = var_16_5
		}))

		self._guildBuffInfo = self._idleData:getGuildBuffInfo()

		self.m_guildBuffTextList:setNumItems(#self._guildBuffInfo.subInfos)

		local var_16_6 = var_16_5 > 0

		self.m_guildTipText:setVisible(var_16_5 > 0)

		local var_16_7 = self:getChild("n52")

		if var_16_7 then
			var_16_7:setVisible(var_16_6)
		end
	end
end

function FogNightmareIdleMainLayer:onRewardIdle(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_4.level

	if arg_17_4.level then
		local var_17_1 = {
			showNow = true
		}
		local var_17_2 = {}

		var_17_2.awards = arg_17_4.awards or {}
		var_17_1.award = var_17_2
		var_17_1.afterShow = {
			{
				flag = "FogNightMareLevelUp",
				func = function()
					return g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.level.FogNightmareLevelUpPop").new(var_17_0 - 1, var_17_0), {
						ignoreTouch = false,
						hideContinue = false,
						touchDisappear = true
					})
				end
			}
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_17_1)
		self:updateBaseView()
	else
		g.core.module.ModuleManager:awardSummary(arg_17_4.awards)
	end

	self:updateIdleLayer()
	self:onRewardEffShow()
end

function FogNightmareIdleMainLayer:onUpdateIdle()
	self:updateIdleLayer()
end

function FogNightmareIdleMainLayer:_onGuildBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.fogNightmare.view.idle.FogNightmareIdleGuildPop").new()))
end

function FogNightmareIdleMainLayer:_onGuildBuffTextItemRender(arg_21_1, arg_21_2)
	local var_21_0 = 500267
	local var_21_1 = g.core.common.Color.A2

	if self._guildBuffInfo.subInfos[arg_21_1 + 1].enable then
		var_21_0 = 500266
		var_21_1 = g.core.common.Color.A5
	end

	arg_21_2:setTitle((g.core.lang:get(var_21_0, {
		num = self._guildBuffInfo.subInfos[arg_21_1 + 1].cfg.num,
		floor = self._guildBuffInfo.subInfos[arg_21_1 + 1].cfg.floor,
		percent = self._guildBuffInfo.subInfos[arg_21_1 + 1].cfg.rate / 10
	})))

	local var_21_2 = arg_21_2:getChild("title")

	var_21_2:setColor(var_21_1)
	arg_21_2:setSize((var_21_2:getSize()))
	arg_21_2:setTouchable(false)
end

function FogNightmareIdleMainLayer:onUnload()
	if self._runnerScheduler then
		self:cancelSchedule(self._runnerScheduler)

		self._runnerScheduler = nil
	end
end

return FogNightmareIdleMainLayer
