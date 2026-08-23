local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.crossServerArenaData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_5 = g.core.const.ConstMgr.ArenaConst
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.common.Goods
local CrossServerArenaBeChallengerComp = class("CrossServerArenaBeChallengerComp", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaBeChallengerComp"))

function CrossServerArenaBeChallengerComp:ctor()
	self._challengeData = nil
	self._params = nil
	self.m_halfPhotoLoader = self.m_halfPhotoComp:getChild("halfPhotoLoader")

	self.m_rankingController:setSelectedIndex(var_0_5.CTRL_RANKING_OTHER)
	self:_initBtn()
end

function CrossServerArenaBeChallengerComp:_initBtn()
	self:addClickListener(handler(self, self._onChallengeClick))
end

function CrossServerArenaBeChallengerComp:updateCell(arg_3_1, arg_3_2)
	if not arg_3_1 then
		self:setVisible(false)
		self:setTouchable(false)

		return
	end

	self._challengeData = arg_3_1
	self._params = arg_3_2

	self:_refreshKnightPictorialBook(arg_3_1.user)

	local var_3_0 = arg_3_1.user.name

	if arg_3_1.robotBaseId and arg_3_1.robotBaseId > 0 then
		clone(arg_3_1.user).robotId = arg_3_1.robotBaseId
		var_3_0 = g.core.utils.String.transRobotName(arg_3_1.user)
	end

	self.m_nameTxt:setText(var_3_0)
	self.m_lvTxt:setText(g.core.lang:get(302516, {
		level = arg_3_1.user.level
	}))
	self.m_powerNumTxt:setText(arg_3_1.user.fight_value)

	self._rank = arg_3_1.rank

	self.m_rankingTxt:setText(arg_3_1.showRank or self._rank)
	self.m_rankingController:setSelectedIndex((self:_getRankingCtrlerIdx(self._rank)))
	self.m_serverNameTxt:setText(arg_3_1.user.server_name)
	self.m_scoreTxt:setText(var_0_2:getRankScoreByRank(self._rank))
	self:setVisible(true)
	self:setTouchable(true)
end

function CrossServerArenaBeChallengerComp:_refreshKnightPictorialBook(arg_4_1)
	local var_4_0 = var_0_2:getPaintedIdBySnapshot(arg_4_1)

	if var_4_0 then
		self.m_halfPhotoLoader:setURL((var_0_0:getKnightPictorialBook(var_4_0)))
	end
end

function CrossServerArenaBeChallengerComp:_getRankingCtrlerIdx(arg_5_1)
	if arg_5_1 == 1 then
		return var_0_5.CTRL_RANKING_1
	elseif arg_5_1 == 2 then
		return var_0_5.CTRL_RANKING_2
	elseif arg_5_1 == 3 then
		return var_0_5.CTRL_RANKING_3
	elseif arg_5_1 > 3 and arg_5_1 < 100 then
		return var_0_5.CTRL_RANKING_2_DIGITS
	elseif arg_5_1 < 1000 then
		return var_0_5.CTRL_RANKING_3_DIGITS
	else
		return var_0_5.CTRL_RANKING_OTHER
	end
end

function CrossServerArenaBeChallengerComp:_onChallengeClick()
	if not self._challengeData then
		return
	end

	if var_0_2:getSeasonStatus() ~= var_0_4.CTRL_ON_SEASON then
		g.core.module.ModuleManager:tip(g.core.lang:get(411016))

		return
	end

	if not self._challengeData.canChallenge then
		g.core.module.ModuleManager:tip(g.core.lang:get(302503))
	elseif var_0_1.shopData:getLeftCount(var_0_4.BUY_TIMES_ID) == 0 then
		self:_popBuyPop()

		return
	elseif not var_0_2:isFormationValid() then
		if var_0_2:isNeedGuide() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.CROSS_SERVER_ARENA_GUIDE_FORMATION)
		end

		g.core.module.ModuleManager:tip(g.core.lang:get(411038))

		return
	else
		if var_0_2:isNeedGuide() then
			var_0_1.guideData:setSaveServerData(var_0_3.GuideConst.SAVE_SERVER_DATA_IDS.CROSS_SERVER_ARENA1)
			g.core.service.ServiceManager:getServiceByName("GuideService"):reset()
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaChallengeConfirmPop").new(self._challengeData, self._params), {
			touchDisappear = false,
			hideContinue = true
		})
	end
end

function CrossServerArenaBeChallengerComp:_popBuyPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_7.TYPE_ITEM,
		value = var_0_7.ITEM.TYPE_CROSS_SERVER_ARENA_TOKEN,
		shopId = var_0_6.SHOP_ITEM_ID.CROSS_SERVER_ARENA_TOKEN
	}), {
		touchDisappear = true
	})
end

return CrossServerArenaBeChallengerComp
