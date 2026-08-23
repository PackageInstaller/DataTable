local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComonUIArtifactCfg = require("app.view.module.recruit.const.RecruitLimitComonUIArtifactCfg")
local RecruitArtifactLimitFirstComp = class("RecruitArtifactLimitFirstComp", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactLimitFirstComp"), RecruitLimitCompBase)

function RecruitArtifactLimitFirstComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitArtifactLimitFirstComp)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitArtifactLimitFirstComp:_initOtherUI()
	local var_2_0 = RecruitLimitComonUIArtifactCfg.getUICfg(self._recruitCfg.id)

	self.m_titleLoader:setURL(var_2_0.titleRes)

	local var_2_1 = self.m_titleLoader:getPosition()

	if var_2_0.titleAdpatMode then
		if var_2_0.titleAdpatMode.x then
			var_2_1.x = self:_getPosXByAdaptMode(var_2_0.titleAdpatMode.x, self.m_titleLoader).x
		end

		if var_2_0.titleAdpatMode.y then
			var_2_1.y = self:_getPosYByAdaptMode(var_2_0.titleAdpatMode.y, self.m_limitTipLoader).y - self.m_titleLoader:getSize().height / 2
		end

		self.m_enterTransition:setValue("titleEndPos", {
			var_2_1.x,
			var_2_1.y
		})
		self.m_enterTransition:setValue("titleStartPos", {
			var_2_1.x - 200,
			var_2_1.y
		})
	end

	self.m_titleLoader:setPosition(cc.pAdd(var_2_1, var_2_0.titleOffset))
	self.m_limitTipLoader:setURL(var_2_0.limitTimesTipBgRes)
	self.m_limitTipLoader:setPosition(cc.pAdd(self.m_limitTipLoader:getPosition(), var_2_0.limitTimesTipBgOffset))
	self.m_leftLoader:setURL(var_2_0.leftBgRes)
	self.m_rightLoader:setURL(var_2_0.rightBgRes)
	self.m_rightTextLoader:setURL(var_2_0.rightTextRes)
	self._subComps.raioText:setText((math.ceil(g.core.config.recruit_knight_info.get(self._recruitCfg.id).up_pro / 100)))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB)
end

function RecruitArtifactLimitFirstComp:_getPosXByAdaptMode(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:getPosition()

	if arg_3_1 == 1 then
		-- block empty
	elseif arg_3_1 == 2 then
		var_3_0.x = self:getSize().width - arg_3_2:getSize().width / 2
	end

	return var_3_0
end

function RecruitArtifactLimitFirstComp:_getPosYByAdaptMode(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:getPosition()
	local var_4_1 = cc.p(0, 0)

	if arg_4_2:isPivotAsAnchor() then
		var_4_1 = arg_4_2:displayObject():getAnchorPoint()
	end

	local var_4_2 = arg_4_2:getSize()

	if arg_4_1 == 1 then
		var_4_0.y = var_4_0.y - var_4_2.height * var_4_1.y
	elseif arg_4_1 == 2 then
		var_4_0.y = var_4_0.y + var_4_2.height * (1 - var_4_1.y)
	end

	return var_4_0
end

function RecruitArtifactLimitFirstComp:playRecruitAction(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_5 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_5_1
	self._highQuality = 0

	for iter_5_0 = 1, #arg_5_1.awards do
		local var_5_0 = g.core.common.Goods:convert(arg_5_1.awards[iter_5_0])

		self._highQuality = math.max(self._highQuality, var_5_0.quality)
		arg_5_1.awards[iter_5_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_5_1.awards[iter_5_0].value)
		arg_5_1.awards[iter_5_0].quality = var_5_0.quality
		arg_5_1.awards[iter_5_0].id = iter_5_0
	end

	arg_5_3:playShow("ArtifactTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitArtifactLimitFirstComp:_goToRewardLayer(arg_6_1)
	local var_6_0 = clone(arg_6_1.content)

	var_6_0.cfg = self._recruitCfg
	var_6_0.matchQuality = self._recruitCfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, var_6_0)
end

return RecruitArtifactLimitFirstComp
