local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.peakArenaData
local var_0_4 = g.core.common.Path
local PAIntegralStageInfoComp = class("PAIntegralStageInfoComp", require("app.fairyGUI.peakArena.UI_PAIntegralStageInfoComp"))

function PAIntegralStageInfoComp:ctor()
	self.m_startMatchBtn:addClickListener(handler(self, self._onClickStartMatchBtn))
	self.m_matchServerBgLoader:addClickListener(handler(self, self._onClickMatchServerBtn))
	self.m_matchServerLoaderBtn:addClickListener(handler(self, self._onClickMatchServerBtn))
	self.m_danGradingIconBgLoader:addClickListener(handler(self, self._onGotoRankLayer))
end

function PAIntegralStageInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
end

function PAIntegralStageInfoComp:updateComp()
	self.m_gradingController:setSelectedIndex(1)

	local var_3_0 = var_0_3:getCrossActivityId()

	self.m_matchNameTxt:setText((var_0_3:getName(var_3_0)))
	self.m_buffTxt:setText((var_0_3:getBuffDesc(var_3_0)))

	local var_3_1 = var_0_3:getMyselfInfo()
	local var_3_2 = var_0_3:getPALevelInfo(var_3_1.score)

	self.m_danGradingLoader:setURL((var_0_4:getPeakArenaDanGradingPic(var_3_2.pic)))
	self.m_danGradingTxt:setText(var_3_2.name)

	if var_3_1.rank == 0 then
		self.m_haveRankingController:setSelectedIndex(0)
	else
		self.m_rankingTxt:setText(var_3_1.rank)
		self.m_haveRankingController:setSelectedIndex(1)
	end

	self.m_scoreTxt:setText(var_3_1.score)
	self.m_oddsTxt:setText(g.core.lang:get(307005, {
		num = var_0_3:getPercentageOdds()
	}))
	self.m_nPlayedTxt:setText(var_3_1.match_count)
	self.m_starComp:initStar({
		style = 2,
		index = 8,
		gap = -6,
		num = var_3_2.star,
		max = var_0_3:getMaxStarNum(var_3_2.pic)
	})
	self:checkSpeWeakGuide()
end

function PAIntegralStageInfoComp:_onForceGuideEnd()
	self:checkSpeWeakGuide()
end

function PAIntegralStageInfoComp:checkSpeWeakGuide()
	if var_0_3:getStageType() == var_0_1.StageType.INTEGRAL then
		if g.core.model.User.guideData:getServerDataById(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.PEAK_ARENA_FIGHT_CLICKED) then
			return
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_PEAK_ARENA",
			targetBtn = self.m_startMatchBtn
		})
	end
end

function PAIntegralStageInfoComp:_onClickStartMatchBtn()
	if not var_0_3:isCanSelectMatchBtn() then
		var_0_2:tip(g.core.lang:get(307031))

		return
	end

	g.core.model.User.guideData:setSaveServerData(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.PEAK_ARENA_FIGHT_CLICKED)
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaMatchingPop").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PAIntegralStageInfoComp:_onClickMatchServerBtn()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaMatchServerPop").new(), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function PAIntegralStageInfoComp:_onGotoRankLayer()
	var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaRankLayer").new(var_0_1.RankLayerTabIdx.DAN_GRADING_AWARD), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PAIntegralStageInfoComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return PAIntegralStageInfoComp
