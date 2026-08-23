local var_0_0 = g.core.common.Path
local GveFormationPresetKnightComp = class("GveFormationPresetKnightComp", require("app.fairyGUI.gve.UI_GveFormationPresetKnightComp"))

function GveFormationPresetKnightComp:ctor()
	self._knightStruct = nil
	self._pos = 0

	self.m_knightClickNode:addClickListener(handler(self, self._onClickAddBtn))
	self.m_artifactIcon1:getChild("icon"):setGloaderMask(true, 0.3)
end

function GveFormationPresetKnightComp:updateCompByPosAndKnight(arg_2_1, arg_2_2, arg_2_3)
	self._pos = arg_2_1
	self._knightStruct = arg_2_2

	if arg_2_2 then
		self.m_knightIcon:setIcon(var_0_0:getKnightPicRes(arg_2_2:getResInfo().painted_id))
		self.m_qualityController:setSelectedIndex(arg_2_2:getQuality())
	else
		self.m_qualityController:setSelectedIndex(0)
	end

	self:updateArtifact(arg_2_3)
end

function GveFormationPresetKnightComp:updateArtifact(arg_3_1)
	if arg_3_1 then
		local var_3_0 = var_0_0:getArtifactFormationImg(arg_3_1:getCfg().res_id)

		self.m_artifactIcon:setIcon(var_3_0)
		self.m_artifactIcon1:setIcon(var_3_0)
		self.m_artifactStarText:setText((arg_3_1:getStar()))
		self.m_isActiveArtifactController:setSelectedIndex(arg_3_1:isOwn() and 1 or 0)
	else
		self.m_isActiveArtifactController:setSelectedIndex(0)
	end
end

function GveFormationPresetKnightComp:_onClickAddBtn()
	if self._isTouching then
		return
	end

	if self._pos == 0 then
		return
	end

	self:dispatchCompEvent("gve_preset_formation_click_add_knight", {
		pos = self._pos
	})
end

function GveFormationPresetKnightComp:setCompTouch(arg_5_1)
	self._isTouching = not arg_5_1
end

function GveFormationPresetKnightComp:hasKnight()
	return self._knightStruct ~= nil
end

return GveFormationPresetKnightComp
