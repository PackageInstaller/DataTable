local var_0_0 = {
	4,
	0,
	1,
	2,
	3
}
local ArtifactHandBookGroupComp = class("ArtifactHandBookGroupComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookGroupComp"))

function ArtifactHandBookGroupComp:ctor()
	self._params = nil

	self.m_groupClickPnl:addClickListener(handler(self, self._onGroupClick))
end

function ArtifactHandBookGroupComp:checkAndPlayUnlockAnim(arg_2_1)
	if self._params then
		if self._params.info.id == arg_2_1 then
			self:playUnlockAnim()
		else
			for iter_2_0, iter_2_1 in ipairs(self._params.artifacts) do
				if iter_2_1.id == arg_2_1 then
					self["m_itemArtifact" .. iter_2_0]:playUnlockAnim()

					break
				end
			end
		end
	end
end

function ArtifactHandBookGroupComp:playUnlockAnim()
	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_artifact_activateFetter",
		anim = "play2"
	})
end

function ArtifactHandBookGroupComp:playTipUnlockEff()
	if self._loopAnim then
		self._loopAnim:removeSelf()

		self._loopAnim = nil
	end

	self._loopAnim = self.m_loopPlaceHolder:addEffectSpine({
		anim = "play1",
		isLoop = true,
		name = "eff_ui_artifact_activateFetter"
	})
end

function ArtifactHandBookGroupComp:updateCompView(arg_5_1)
	self._params = arg_5_1

	if self._loopAnim then
		self._loopAnim:removeSelf()

		self._loopAnim = nil
	end

	local var_5_0 = #arg_5_1.artifacts

	self.m_numController:setSelectedIndex(var_0_0[#arg_5_1.artifacts])
	self.m_groupNameTxt:setText(arg_5_1.info.name)

	for iter_5_0 = 1, var_5_0 do
		self["m_itemArtifact" .. iter_5_0]:updateIcon({
			type = g.core.common.Goods.TYPE_ARTIFACT,
			value = arg_5_1.artifacts[iter_5_0].id
		}, arg_5_1.artifacts[iter_5_0])
	end

	self.m_levelTxt:setText(g.core.lang:get(205526, {
		num = arg_5_1.lv
	}))
	self:showUpgradeRedPoint(false)

	if arg_5_1.isActive then
		self.m_activeController:setSelectedIndex(1)

		if arg_5_1.lv and arg_5_1.lv > 0 then
			local var_5_1 = g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_5_1.advId, arg_5_1.lv)

			if var_5_1 and var_5_1.next_id ~= 0 then
				local var_5_2 = g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_5_1.advId, arg_5_1.lv + 1)

				if self._params.childLv >= var_5_2.need then
					if var_5_1.num == 0 then
						self:showUpgradeRedPoint(true)
					end

					if g.core.model.User.bagData:getCountById(var_5_2.cost_type, var_5_2.cost_value) >= var_5_2.num then
						self:showUpgradeRedPoint(true)
					end
				end
			end
		end
	elseif arg_5_1.canActive then
		self:playTipUnlockEff()
		self.m_activeController:setSelectedIndex(2)
	else
		self.m_activeController:setSelectedIndex(0)
	end

	self.m_groupIcon:setURL(g.core.common.Path:getArtifactTissuePic(arg_5_1.info.icon))
end

function ArtifactHandBookGroupComp:showUpgradeRedPoint(arg_6_1)
	self.m_redPointComp:setVisible(arg_6_1)
	self.m_redPointComp:setShow(arg_6_1)
end

function ArtifactHandBookGroupComp:_onGroupClick()
	if not self._params then
		return
	end

	if self._params.canActive and not self._params.isActive then
		g.core.network.GameNetProxy:send_C2S_Artifact_HandbookActivate({
			id = self._params.info.id
		})
	elseif self._params.isMax or not self._params.isActive then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.artifactHandBook.view.ArtifactHandBookGroupDetailPop").new(self._params), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		local var_7_0 = require("app.view.base.show.BaseFeedBackPopNew").new

		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				param = self._params
			},
			title = g.core.lang:get(205519),
			showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookLvUpFettersComp")
		}), {
			touchDisappear = true
		})
	end
end

return ArtifactHandBookGroupComp
