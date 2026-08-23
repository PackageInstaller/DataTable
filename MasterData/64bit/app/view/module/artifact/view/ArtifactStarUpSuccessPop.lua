local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.common.Path
local ArtifactStarUpSuccessPop = class("ArtifactStarUpSuccessPop", require("app.fairyGUI.artifact.UI_ArtifactStarUpSuccessPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/artifact/artifact",
		resName = "ArtifactStarUpSuccessPop",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactStarUpSuccessPop:ctor(arg_2_1, arg_2_2)
	self._exAwards = arg_2_2

	self:showAtCenter()

	self._artifactData = arg_2_1
	self._baseId = self._artifactData:getArtifactBaseId()
	self._name = self._artifactData:getArtifactName()
	self._quality = self._artifactData:getQuality()

	self:addClickListener(handler(self, self._onCloseClick))
end

function ArtifactStarUpSuccessPop:onLoad()
	self.m_baseCompPop:initData({
		title = g.core.lang:get(205509),
		englishTitle = g.core.lang:get(205510),
		item = {
			type = 1,
			res = var_0_2:getArtifactImg(self._artifactData:getCfg().res_id)
		},
		quality = self._quality
	})
	self.m_infoComp:updateComp(self._artifactData)
	self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
	self.m_enterTransition:play()
end

function ArtifactStarUpSuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		name = "eff_ui_uniteToken_upGrade",
		remove = true,
		isLoop = false,
		anim = "play_" .. self._quality + 1
	})
end

function ArtifactStarUpSuccessPop:_onCloseClick()
	var_0_1:popComponent()

	if self._exAwards then
		local var_5_0 = self._exAwards

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_5_0)
		end, 0)
	end
end

return ArtifactStarUpSuccessPop
