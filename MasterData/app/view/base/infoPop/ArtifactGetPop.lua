local ArtifactGetPop = class("ArtifactGetPop", require("app.fairyGUI.infoPop.UI_ArtifactGetPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactGetPop",
		pkgPath = "ui/infoPop/infoPop",
		isFullScreen = true,
		pkgName = "infoPop"
	})
end)

function ArtifactGetPop:ctor(arg_2_1)
	self:addClickListener(handler(self, self._onTouchClick))
	self:showAtCenter()
	self:getView():setSize(display.width, display.height)

	self._callBack = arg_2_1.callBack
	self._isCanClose = false
	self._params = arg_2_1
end

function ArtifactGetPop:onLoad()
	if self._params.good.from then
		-- block empty
	end

	local var_3_2 = g.core.config.artifact_info.get(self._params.good.value)

	self._quality = var_3_2.quality

	self.m_itemLoader:setURL(g.core.common.Path:getArtifactImg(var_3_2.res_id))
	self.m_nameTxt:setText(var_3_2.name)
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(var_3_2.quality))

	if self._params.good.from then
		self.m_convertGroup:setVisible(true)
		self.m_autoFragmentTxt2:setText("X" .. self._params.good.size)
		self.m_fragIcon2:setURL(self._params.good.icon_mini)
	else
		self.m_convertGroup:setVisible(false)
	end

	self.m_qualityEffectNode:addEffectSpine({
		remove = true,
		name = "eff_ui_recruitReward_show",
		isLoop = false,
		anim = "play_role_" .. self._quality + 1
	})
	self.m_effPlaceHolder:addEffectSpine({
		name = "eff_ui_knight_idleEff",
		isLoop = true,
		anim = "play_" .. self._quality + 1
	})
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
end

function ArtifactGetPop:onUnload()
	if self._callBack then
		self._callBack()
	end
end

function ArtifactGetPop:_onEnterAnimEnd()
	self._isCanClose = true
end

function ArtifactGetPop:_onTouchClick()
	if self._isCanClose then
		self._isCanClose = false

		g.core.module.ModuleManager:popComponent()
	end
end

return ArtifactGetPop
