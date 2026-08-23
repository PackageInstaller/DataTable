local ArtifactHandBookIcon = class("ArtifactHandBookIcon", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookIcon"))

function ArtifactHandBookIcon:ctor()
	self._params = nil
	self._parentParams = nil
	self._forceWaitAnim = false
	self._unPut = false

	self:addClickListener(handler(self, self._onClickSelf))
end

function ArtifactHandBookIcon:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKACTIVATE, self._onActiveNetBack, self)
end

function ArtifactHandBookIcon:_onActiveNetBack(arg_3_1, arg_3_2, arg_3_3)
	if not self._params then
		return
	end

	if arg_3_3.id == self._params.id then
		self._forceWaitAnim = true

		self.m_stateController:setSelectedIndex(0)
	end
end

function ArtifactHandBookIcon:playUnlockAnim()
	self.m_effPlaceHolder:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = "eff_ui_artifact_activateIcon",
		remove = true
	})
	self.m_stateController:setSelectedIndex(1)
end

function ArtifactHandBookIcon:playTipsUnlockAnim()
	if self._loopAnim then
		self._loopAnim:removeSelf()

		self._loopAnim = nil
	end

	self._loopAnim = self.m_effPlaceHolder:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = "eff_ui_artifact_active"
	})
end

function ArtifactHandBookIcon:updateIcon(arg_6_1, arg_6_2)
	self._params = arg_6_2

	self.m_baseIcon:updateIcon(arg_6_1)

	if self._loopAnim then
		self._loopAnim:removeSelf()

		self._loopAnim = nil
	end

	self._unPut = false

	self:showUpgradeRedPoint(false)

	if arg_6_2.isActive then
		self.m_stateController:setSelectedIndex(1)
		self.m_starComp:initStar({
			gap = -2,
			style = 2,
			index = 3,
			max = arg_6_2.struct:getMaxStar(),
			num = arg_6_2.lv - 1
		})

		if arg_6_2.lv and arg_6_2.lv > 0 then
			local var_6_0, var_6_1 = g.core.model.User.artifactData:hasArtifactByAdvanceId(arg_6_2.id)

			if g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_6_2.advId, arg_6_2.lv).next_id ~= 0 then
				local var_6_2 = g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_6_2.advId, arg_6_2.lv + 1)

				if var_6_0 and var_6_1:getStar() >= var_6_2.need then
					if var_6_2.num == 0 then
						self:showUpgradeRedPoint(true)
					end

					if g.core.model.User.bagData:getCountById(var_6_2.cost_type, var_6_2.cost_value) >= var_6_2.num then
						self:showUpgradeRedPoint(true)
					end
				end
			end
		end
	elseif g.core.config.artifact_info.get(arg_6_2.id).put == 0 then
		self.m_stateController:setSelectedIndex(2)
		self.m_baseIcon:getIconComp():getBindUINode("iconLoader"):setURL("ui://artifactHandbook/icon_zanwu")

		self._unPut = true
	else
		local var_6_3, var_6_4 = g.core.model.User.artifactData:hasArtifactByAdvanceId(self._params.id)

		if var_6_3 then
			self:playTipsUnlockAnim()
			self.m_stateController:setSelectedIndex(3)
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end

	if self._forceWaitAnim then
		self.m_stateController:setSelectedIndex(0)
	end
end

function ArtifactHandBookIcon:showUpgradeRedPoint(arg_7_1)
	self.m_redPointComp:setVisible(arg_7_1)
	self.m_redPointComp:setShow(arg_7_1)
end

function ArtifactHandBookIcon:_onClickSelf()
	if self._unPut then
		g.core.module.ModuleManager:tip(g.core.lang:get(205520))

		return
	end

	local var_8_0, var_8_1 = g.core.model.User.artifactData:hasArtifactByAdvanceId(self._params.id)

	if var_8_0 and not self._params.isActive then
		g.core.network.GameNetProxy:send_C2S_Artifact_HandbookActivate({
			id = self._params.id
		})
	elseif self._params.isMax or not self._params.isActive then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifactHandBook.view.ArtifactHandBookGroupDetailPop").new(self._params), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifactHandBook.view.ArtifactHandBookLvUpPop").new({
			info = self._params.info,
			param = self._params
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

return ArtifactHandBookIcon
