local RecruitLimitCommonUIKnightSoulCfg = require("app.view.module.recruit.const.RecruitLimitCommonUIKnightSoulCfg")
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitKnightSoulSingleComp = class("RecruitKnightSoulSingleComp", require("app.fairyGUI.recruitKnightSoul.UI_RecruitKnightSoulSingleComp"), RecruitLimitCompBase)
local var_0_4 = g.core.model.User.recruitData
local var_0_5 = g.core.const.ConstMgr.RecruitConst
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")

function RecruitKnightSoulSingleComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitKnightSoulSingleComp)
		RecruitLimitCompBase.ctor(self)
	end

	self._wishInfos = {}
	self._timeUpdateEnable = false

	self:addListen(self.m_wishComp)
end

function RecruitKnightSoulSingleComp:_initOtherUI()
	self.m_minimumText:enableRich()

	self._uiCfg = RecruitLimitCommonUIKnightSoulCfg.getUICfg(self._recruitCfg.id)

	local var_2_0 = var_0_4:getDisplayInfoById(self._recruitCfg.id)

	for iter_2_0, iter_2_1 in ipairs(var_2_0.displays) do
		self.m_soulTipBtn:updateComp(iter_2_1)
	end

	self._cfg = var_0_4:getRecruitKnightCfgById(self._recruitCfg.id)
	self._displayCfg = var_2_0

	RecruitFuncCfg.addBtnTip(self, var_0_5.RECRUIT_TAB_TYPE.KNIGHT_SOUL_TAB)
	self.m_bigTitle:setURL(self._uiCfg.titleRes)
	self.m_miniTxtBg:setURL(self._uiCfg.titleEnTextRes)
	self.m_enBg:setURL(self._uiCfg.titleEnShadowTextRes)

	if self._uiCfg.chapterId == 999 then
		self.m_tipText:setVisible(false)
	else
		self.m_tipText:setVisible(true)
		self.m_tipText:setText(g.core.lang:get(108472, {
			chapter = g.core.config.ksoul_book_chapter_info.get(self._uiCfg.chapterId).name
		}))
	end
end

function RecruitKnightSoulSingleComp:receiveCompEvent(arg_3_1, arg_3_2)
	if arg_3_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightSoulWishPop").new(var_0_5.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT, self._actId))

		return true
	elseif arg_3_1 == "doRecruitContinue" then
		if arg_3_2.num > 1 then
			self:_onRecruitTenBtnClick()
		else
			self:_onRecruitOneBtnClick()
		end

		return true
	end

	return false
end

function RecruitKnightSoulSingleComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._actId)

	if #self._wishInfos == 0 then
		self._wishInfos = {}
	end

	self.m_wishComp:updateComp(self._wishInfos, self._recruitType, self._actId)
	self.m_minimumText:setText(g.core.lang:get(108464, {
		time = g.core.model.User.recruitData:getGuaranteedInfos(var_0_5.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT, nil, nil, self._recruitCfg.id).times
	}), true)
	self:_updateLuck()
	self:_updateCost()
end

function RecruitKnightSoulSingleComp:updateWishMiniRed()
	self.m_wishComp:refreshRed()
end

function RecruitKnightSoulSingleComp:setLuckTimeText(arg_6_1, arg_6_2)
	self._curLuckText = arg_6_1
	self._maxLuckText = arg_6_2
end

function RecruitKnightSoulSingleComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitKnightSoulSingleComp:playRecruitAction(arg_8_1, arg_8_2, arg_8_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_8_1
	self._highQuality = 0

	for iter_8_0 = 1, #arg_8_1.awards do
		local var_8_0 = g.core.common.Goods:convert(arg_8_1.awards[iter_8_0])

		self._highQuality = math.max(self._highQuality, var_8_0.quality)
		arg_8_1.awards[iter_8_0].quality = var_8_0.quality
		arg_8_1.awards[iter_8_0].id = iter_8_0
		arg_8_1.awards[iter_8_0].isNew = g.core.model.User.recruitData:checkIsNewKnightSoul(arg_8_1.awards[iter_8_0].value)
	end

	self:updateView()
	self:_goToRewardLayer({
		quality = self._highQuality,
		content = self._content
	})
end

function RecruitKnightSoulSingleComp:_goToRewardLayer(arg_9_1)
	local var_9_0 = clone(arg_9_1.content)

	var_9_0.cfg = self._cfg
	var_9_0.quality = arg_9_1.quality
	var_9_0.matchQuality = self._cfg.gacha_display_quality

	local var_9_1 = require("app.view.module.recruit.view.knightSoul.KnightSoulRewardLayer").new(var_9_0)

	self:addListen(var_9_1)
	g.core.module.ModuleManager:pushPopup(var_9_1, {
		touchDisappear = false
	})
end

function RecruitLimitCompBase._continueRecruit(arg_10_0, arg_10_1)
	return
end

return RecruitKnightSoulSingleComp
