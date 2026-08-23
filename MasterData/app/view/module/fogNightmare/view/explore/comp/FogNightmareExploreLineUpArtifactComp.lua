local var_0_0 = g.core.model.User.fogNightmareData
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local FogNightmareExploreLineUpArtifactComp = class("FogNightmareExploreLineUpArtifactComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLineUpArtifactComp"))

function FogNightmareExploreLineUpArtifactComp:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
end

function FogNightmareExploreLineUpArtifactComp:updateComp(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_artifactIcon:updateIcon(arg_2_1)
		self.m_artifactIcon:hideLevel()
		self.m_nameText:setText(arg_2_1:getArtifactName())
		self.m_isUseController:setSelectedIndex(var_0_0:getFormationData():isUsedArtifact(arg_2_1:getServerOnlyId()) and 1 or 0)

		local var_2_1 = (arg_2_2.dataList or {})[arg_2_1:getAdvanceId()]
		local var_2_4

		if var_2_1 then
			local var_2_2 = var_0_0:getFormationData():getKnightByIndexAndPos(var_2_1.formationIndex, var_2_1.pos)

			if not var_2_2 then
				return
			end

			self.m_stateController:setSelectedIndex(1)
			self.m_bindKnightIcon:setURL((g.core.common.Path:getKnightIconById(var_2_2:getResInfo().icon_id)))
			self.m_idleEffectDown:removeAllEffect()
			self.m_idleEffectUp:removeAllEffect()
		else
			local var_2_3 = arg_2_1:getBelongToKnightAvdIdIncludingMainRole()

			self.m_knightIconComp:getChild("maskKnightIcon"):updateBelongToIcon(var_2_3)
			self.m_stateController:setSelectedIndex(0)

			if arg_2_2.knightAdvId == var_2_3 and not arg_2_1:isDemo() then
				self.m_knightIconComp:getController("isLink"):setSelectedIndex(1)
				self:_playLinkEnterAnim()
			else
				self.m_idleEffectDown:removeAllEffect()
				self.m_idleEffectUp:removeAllEffect()

				var_2_4 = {
					gap = -1,
					style = 2,
					index = 4,
					max = arg_2_1:getMaxStar()
				}
			end
		end

		var_2_4.num = arg_2_1:getStar()

		self.m_starComp:initStar(var_2_4)
	end
end

function FogNightmareExploreLineUpArtifactComp:_playLinkEnterAnim()
	self.m_idleEffectDown:removeAllEffect()
	self.m_idleEffectUp:removeAllEffect()
	self.m_idleEffectDown:addEffectSpine({
		anim = "down",
		name = "eff_ui_list_linkEnter",
		isLoop = true
	})
	self.m_idleEffectUp:addEffectSpine({
		anim = "up",
		name = "eff_ui_list_linkEnter",
		isLoop = true
	})
end

return FogNightmareExploreLineUpArtifactComp
