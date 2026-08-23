local var_0_0 = g.core.model.User.bioData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = BattleConst.SPINE_ACTION_TYPE
local var_0_3 = g.core.const.ConstMgr.BioMapConst
local BioGameTreeLayer = class("BioGameTreeLayer", require("app.fairyGUI.biography.UI_BioGameTreeLayer"), function()
	return fgui.GComponent:create({
		resName = "BioGameTreeLayer",
		pkgPath = "ui/biography/biography",
		isFullScreen = true,
		pkgName = "biography"
	}, ...)
end)

function BioGameTreeLayer:ctor(arg_2_1, arg_2_2)
	self._missionId = arg_2_1
	self._awardList = arg_2_2 or {}
	self._spine = nil
	self._isAllAwardGet = false

	self:_initView()
end

function BioGameTreeLayer:onLoad()
	self._newOpenBoxScheduleHandler = g.core.common.Scheduler:newScheduleOnce(handler(self, function()
		self:_onOpenBox()
	end), 0.3)
end

function BioGameTreeLayer:onUnload()
	if self._newOpenBoxScheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._newOpenBoxScheduleHandler)

		self._newOpenBoxScheduleHandler = nil
	end

	if self._newAddAwardScheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._newAddAwardScheduleHandler)

		self._newAddAwardScheduleHandler = nil
	end
end

function BioGameTreeLayer:_initView()
	local var_6_0 = g.core.config.biography_event_info.get(var_0_0:getMission(self._missionId).sub_id)

	self.m_infoComp:updateEventInfo(var_6_0)

	self._spine = self.m_iconHolderComp:addEffectSpine({
		isLoop = true,
		name = var_6_0.pic,
		anim = var_0_2.IN,
		eventHandler = handler(self, self._onSpineEvent)
	})
end

function BioGameTreeLayer:_addAwardIcons()
	for iter_7_0 = 1, var_0_3.GAME_TREE_AWARD_NUM do
		local var_7_0 = self._awardList[iter_7_0]
		local var_7_1 = self["m_awardComp" .. iter_7_0]

		if self._awardList[iter_7_0] then
			var_7_1:setOpaque(true)
			var_7_1:addClickListener(handler(self, function()
				self:_onClickAward(iter_7_0)
			end))
			var_7_1:addEffectSpine({
				y = 50,
				isLoop = false,
				x = 40,
				name = var_7_0.isRare and "eff_ui_bio_wuzigold" or "eff_ui_bio_wuzisilver" .. (iter_7_0 - 1 < 1 and 1 or iter_7_0 - 1),
				anim = var_0_2.IN,
				eventHandler = handler(self, self._onAwardSpineEvent)
			})
		else
			var_7_1:setVisible(false)
		end
	end
end

function BioGameTreeLayer:_onOpenBox()
	self._spine:setAnimation(0, var_0_2.HIT, false)

	self._newAddAwardScheduleHandler = g.core.common.Scheduler:newScheduleOnce(function(arg_10_0)
		self:_addAwardIcons()
	end, 0.1)
end

function BioGameTreeLayer:_onClickAward(arg_11_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		startAction = true,
		baseShowReward = {
			self._awardList[arg_11_1]
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_REQUEST_RESPONSE, true)

	if self["m_awardComp" .. arg_11_1] then
		self["m_awardComp" .. arg_11_1]:setVisible(false)
	end

	self._isAllAwardGet = true

	for iter_11_0 = 1, var_0_3.GAME_TREE_AWARD_NUM do
		if self["m_awardComp" .. iter_11_0]:isVisible() then
			self._isAllAwardGet = false

			break
		end
	end

	self:_onAwardClose()
end

function BioGameTreeLayer:_onSpineEvent(arg_12_1)
	if arg_12_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_12_1.animation == var_0_2.HIT then
			self._spine:setAnimation(0, var_0_2.IDLE, true)
		elseif arg_12_1.animation == var_0_2.OUT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIOFRAOHY_COMPLETE_TASK, false, {
				id = self._missionId,
				awards = self._awardList
			})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function BioGameTreeLayer:_onAwardSpineEvent(arg_13_1, arg_13_2)
	if arg_13_1.type == BattleConst.SPINE_EVENT.COMPLETE and arg_13_1.animation == var_0_2.IN then
		arg_13_2:setAnimation(0, var_0_2.PLAY, true)
	end
end

function BioGameTreeLayer:_onAwardClose()
	if self._isAllAwardGet then
		self.m_infoComp:setVisible(false)
		self._spine:setAnimation(0, var_0_2.OUT, false)
	end
end

function BioGameTreeLayer:doAutoAction()
	for iter_15_0 = 1, var_0_3.GAME_TREE_AWARD_NUM do
		if self["m_awardComp" .. iter_15_0]:isVisible() then
			self:_onClickAward(iter_15_0)

			break
		end
	end
end

return BioGameTreeLayer
