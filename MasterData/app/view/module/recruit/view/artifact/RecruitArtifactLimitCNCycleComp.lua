local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local RecruitArtifactLimitCNCycleComp = class("RecruitArtifactLimitCNCycleComp", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactLimitCNCycleComp"), RecruitLimitCompBase)

function RecruitArtifactLimitCNCycleComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitArtifactLimitCNCycleComp)
		RecruitLimitCompBase.ctor(self)
	end
end

function RecruitArtifactLimitCNCycleComp:_initOtherUI()
	self.m_leftLoader:setURL("pic/recruit/bg_zm_zw_xunhuan_0.png")
	self.m_rightLoader:setURL("pic/recruit/bg_zm_zw_xhty_0.png")
	self.m_knightLoader:setURL(string.format("pic/recruit/pic_zm_zw_gf_%s.png", self:_getKnightLoaderIdByRecruitId(self._recruitCfg.id)))
	self._subComps.raioText:setText((math.ceil(g.core.config.parameter_info.get(15028).parameter / 100)))
	RecruitFuncCfg.addBtnTip(self, g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB)
end

function RecruitArtifactLimitCNCycleComp:playRecruitAction(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_5 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_3_1
	self._highQuality = 0

	for iter_3_0 = 1, #arg_3_1.awards do
		local var_3_0 = g.core.common.Goods:convert(arg_3_1.awards[iter_3_0])

		self._highQuality = math.max(self._highQuality, var_3_0.quality)
		arg_3_1.awards[iter_3_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_3_1.awards[iter_3_0].value)
		arg_3_1.awards[iter_3_0].quality = var_3_0.quality
		arg_3_1.awards[iter_3_0].id = iter_3_0
	end

	arg_3_3:playShow("ArtifactTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitArtifactLimitCNCycleComp:_goToRewardLayer(arg_4_1)
	local var_4_0 = clone(arg_4_1.content)

	var_4_0.cfg = self._recruitCfg
	var_4_0.matchQuality = self._recruitCfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, var_4_0)
end

function RecruitArtifactLimitCNCycleComp:_getKnightLoaderIdByRecruitId(arg_5_1)
	return string.format("%04d", arg_5_1 % 1000)
end

return RecruitArtifactLimitCNCycleComp
