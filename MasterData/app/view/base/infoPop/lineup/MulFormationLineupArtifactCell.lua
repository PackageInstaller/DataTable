local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.model.User.mulFormationData
local MulFormationLineupArtifactCell = class("MulFormationLineupArtifactCell", require("app.fairyGUI.infoPop.UI_MulFormationLineupArtifactCell"))

function MulFormationLineupArtifactCell:ctor()
	self.m_maskKnightIcon = self.m_knightIconComp:getChild("maskKnightIcon")

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = -1,
		style = 2,
		index = 4,
		num = 0,
		max = ArtifactConst.STAR_MAX
	})
	self.m_artifactIcon:hideLevel()
end

function MulFormationLineupArtifactCell:updateCell(arg_2_1, arg_2_2)
	self.m_artifactIcon:updateIcon(arg_2_1)
	self.m_nameText:setText(arg_2_1:getArtifactName())

	local var_2_0 = arg_2_1:getServerOnlyId()
	local var_2_1
	local var_2_2 = var_0_3:getFormationStructArtifactLineup(arg_2_2.formationType, var_2_0)

	if var_2_2 then
		var_2_1 = var_0_2:getKnightById((var_2_2:getKnightSid((var_2_2:getArtifactStationPos(var_2_0)))))
	end

	self.m_knightIconComp:getController("isLink"):setSelectedIndex(0)

	if var_2_1 then
		self.m_wearStateController:setSelectedIndex(1)
		self.m_knightIconLoader:setURL((var_0_1:getKnightIconById(g.core.config.knight_base_info.get(var_2_1:getBaseInfo().res_id).icon_id)))
		self.m_idleEffectDown:removeAllEffect()
		self.m_idleEffectUp:removeAllEffect()
	else
		self.m_wearStateController:setSelectedIndex(0)

		local var_2_3 = arg_2_1:getBelongToKnightAvdIdIncludingMainRole()

		self.m_maskKnightIcon:updateBelongToIcon(var_2_3)

		if arg_2_2.knightAdvId == var_2_3 and not arg_2_1:isDemo() then
			self.m_knightIconComp:getController("isLink"):setSelectedIndex(1)
			self:_playLinkEnterAnim()
		else
			self.m_idleEffectDown:removeAllEffect()
			self.m_idleEffectUp:removeAllEffect()
		end
	end

	self.m_starComp:setStarNum(arg_2_1:getStar())

	if arg_2_1:isHasWeaponSpirit() and arg_2_1:getSpiritStage() > 0 then
		self.m_spiritComp:updateCurWeapon(arg_2_1)
		self.m_urStageAddController:setSelectedIndex(1)
	else
		self.m_urStageAddController:setSelectedIndex(0)
	end
end

function MulFormationLineupArtifactCell:_playLinkEnterAnim()
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

return MulFormationLineupArtifactCell
