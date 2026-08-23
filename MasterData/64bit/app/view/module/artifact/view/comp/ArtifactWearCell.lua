local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.model.User.artifactData
local ArtifactWearCell = class("ArtifactWearCell", require("app.fairyGUI.artifact.UI_ArtifactWearCell"))
local var_0_3 = g.core.model.User.knightsData

function ArtifactWearCell:ctor()
	self._artifactStruct = nil

	self:addClickListener(handler(self, self._onCellClicked))
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
end

function ArtifactWearCell:updateCell(arg_2_1, arg_2_2)
	if arg_2_1 then
		self._artifactStruct = arg_2_1
		self._artifactOnlyId = arg_2_1:getServerOnlyId()
		self._wearPos = arg_2_1:getFormationPos()
		self._knightPos = arg_2_2
		self._belongToknightCode = arg_2_1:getBelongToKnightAvdIdIncludingMainRole()
		self._isDemo = arg_2_1:isDemo()
		self._belongToknightName = var_0_3:getKnightByAdvanceId(self._belongToknightCode):getName()

		self.m_artifactIcon:updateIcon(arg_2_1)
		self.m_nameText:setText(arg_2_1:getArtifactName())

		local var_2_0 = arg_2_1:getWearKnight()
		local var_2_1

		if var_2_0 then
			self.m_wearStateController:setSelectedIndex(1)
			self.m_wearComp:updateView(var_2_0)
		else
			self.m_knightIconComp:getChild("maskKnightIcon"):updateBelongToIcon((arg_2_1:getBelongToKnightAvdIdIncludingMainRole()))
			self.m_wearStateController:setSelectedIndex(0)

			var_2_1 = {
				index = 4,
				style = 2,
				gap = -1,
				max = arg_2_1:getMaxStar()
			}
		end

		var_2_1.num = arg_2_1:getStar()

		self.m_starComp:initStar(var_2_1)
		self.m_knightIconComp:getController("isLink"):setSelectedIndex(0)

		if g.core.model.User.knightsData:getKnightByFormationIndex(arg_2_2):getAdvanceId() == self._belongToknightCode and not arg_2_1:isDemo() then
			if self._wearPos == 0 then
				self.m_knightIconComp:getController("isLink"):setSelectedIndex(1)
				self:_playLinkEnterAnim()
			else
				self.m_idleEffectDown:removeAllEffect()
				self.m_idleEffectUp:removeAllEffect()
			end
		else
			self.m_idleEffectDown:removeAllEffect()
			self.m_idleEffectUp:removeAllEffect()
		end

		if arg_2_1:isHasWeaponSpirit() and arg_2_1:getSpiritStage() > 0 then
			self.m_spiritComp:updateCurWeapon(arg_2_1)
			self.m_urStageAddController:setSelectedIndex(1)
		else
			self.m_urStageAddController:setSelectedIndex(0)
		end
	end
end

function ArtifactWearCell:_onCellClicked(arg_3_1)
	if self._artifactOnlyId then
		local var_3_0 = var_0_1:getArtifactByFormationIndex(self._knightPos)

		if var_3_0 then
			if self._wearPos and self._wearPos == var_3_0:getFormationPos() then
				g.core.module.ModuleManager:tip(g.core.lang:get(205517))

				return
			end
		end

		local var_3_1 = var_0_3:getKnightByFormationIndex(self._knightPos)

		if not self._artifactStruct:checkWearKnight(var_3_1:getAdvanceId()) then
			g.core.module.ModuleManager:tip(g.core.lang:get(205539))

			return
		end

		if self._wearPos > 0 and var_3_0 then
			local var_3_2 = var_0_3:getKnightByFormationIndex(self._wearPos)

			if var_3_2 and not var_3_0:checkWearKnight(var_3_2:getAdvanceId()) then
				g.core.module.ModuleManager:tip(g.core.lang:get(205539))

				return
			end
		end

		if self._isDemo and self._belongToknightCode ~= var_3_1:getAdvanceId() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(205532, {
					name = self._belongToknightName
				}),
				onConfirm = handler(self, self._startChange)
			}))
		else
			self:_startChange()
		end
	end
end

function ArtifactWearCell:_startChange()
	local var_4_0 = var_0_1:getArtifactByFormationIndex(self._knightPos)

	if var_4_0 and var_4_0:getLevel() > 1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InheritFormationPop").new({
			type = 1,
			pos = self._knightPos,
			id = self._artifactOnlyId
		}))
	else
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = 5,
			pos = self._knightPos,
			id = self._artifactOnlyId
		})
	end
end

function ArtifactWearCell:_playLinkEnterAnim()
	self.m_idleEffectDown:removeAllEffect()
	self.m_idleEffectUp:removeAllEffect()
	self.m_idleEffectDown:addEffectSpine({
		name = "eff_ui_list_linkEnter",
		anim = "down",
		isLoop = true
	})
	self.m_idleEffectUp:addEffectSpine({
		name = "eff_ui_list_linkEnter",
		anim = "up",
		isLoop = true
	})
end

return ArtifactWearCell
