local var_0_0 = g.core.model.User.artifactHandBookData
local ArtifactHandBookActivePop = class("ArtifactHandBookActivePop", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookActivePop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactHandBookActivePop",
		pkgPath = "ui/artifactHandbook/artifactHandbook",
		pkgName = "artifactHandbook"
	}, ...)
end)

function ArtifactHandBookActivePop:ctor(arg_2_1)
	self:showAtCenter()

	self._closing = false
	self._params = arg_2_1

	self.m_bgLoader:setURL("pic/base_new/bg_tjshengjidi.png")

	if not arg_2_1.isUR then
		self:updateNormalView()
	else
		self:updateURView()
	end

	self.m_closePnl:addClickListener(handler(self, self._onClickClose))
	self.m_enter_0Transition:play()
end

function ArtifactHandBookActivePop:updateNormalView()
	local var_3_0 = g.core.config.artifact_compose_info.get(self._params.id)

	self.m_isURController:setSelectedIndex(0)

	local var_3_1

	if self._params.lv then
		var_3_1 = g.core.model.User.artifactHandBookData:getTargetLvCfg(self._params.cfg.advance_code, self._params.lv - 1)
		var_3_0 = g.core.model.User.artifactHandBookData:getTargetLvCfg(self._params.cfg.advance_code, self._params.lv)
	end

	for iter_3_0 = 1, 4 do
		self["m_attr" .. iter_3_0]:setVisible(false)

		if var_3_0["affect_type_" .. iter_3_0] ~= 0 then
			local var_3_2 = {
				isAll = true,
				type = var_3_0["affect_type_" .. iter_3_0]
			}

			if var_3_1 then
				var_3_2.value = var_3_1["affect_value_" .. iter_3_0] or 0
			end

			var_3_2.value2 = var_3_0["affect_value_" .. iter_3_0]

			self["m_attr" .. iter_3_0]:updateAttr(var_3_2)
			self["m_attr" .. iter_3_0]:setVisible(true)
		end
	end

	local var_3_3 = g.core.config.artifact_info.get(self._params.id)

	self.m_imgLoader:setURL(g.core.common.Path:getArtifactPic(var_3_0.icon))
	self.m_nameComp:setData({
		name = var_3_3.name,
		quality = var_3_3.quality
	}, "artifactHandbook")
end

function ArtifactHandBookActivePop:updateURView()
	local var_4_0 = g.core.config.artifact_compose_advanced_info.get(self._params.id)

	self.m_isURController:setSelectedIndex(1)

	local var_4_1

	if self._params.new_id then
		var_4_1 = var_4_0
		var_4_0 = g.core.config.artifact_compose_advanced_info.get(self._params.new_id)
	end

	local var_4_2

	if var_4_1 then
		var_4_2 = var_0_0:getURHandBookLevelAllAttr(var_4_1.advance_code, var_4_1.level)
	end

	local var_4_3 = var_0_0:getURHandBookLevelAllAttr(var_4_0.advance_code, var_4_0.level)
	local var_4_4 = 1

	for iter_4_0 = 1, 4 do
		self["m_attr" .. var_4_4]:setVisible(false)

		if var_4_0["affect_type_" .. iter_4_0] ~= 0 then
			local var_4_5 = {
				isAll = true,
				type = var_4_0["affect_type_" .. iter_4_0]
			}

			if var_4_2 then
				var_4_5.value = var_4_2[var_4_0["affect_type_" .. iter_4_0]] or 0
			end

			if var_4_3 then
				var_4_5.value2 = var_4_3[var_4_0["affect_type_" .. iter_4_0]] or 0
			end

			self["m_attr" .. var_4_4]:updateAttr(var_4_5)
			self["m_attr" .. var_4_4]:setVisible(true)

			var_4_4 = var_4_4 + 1
		end
	end

	self["m_attr" .. var_4_4]:setVisible(true)

	local var_4_6 = {
		name = g.core.lang:get(205561)
	}

	var_4_6.value = var_4_1 and var_0_0:getURHandBookLevelAllScore(var_4_1.advance_code, var_4_1.level) or 0
	var_4_6.value2 = var_0_0:getURHandBookLevelAllScore(var_4_0.advance_code, var_4_0.level)

	self["m_attr" .. var_4_4]:updateAttr(var_4_6)

	local var_4_7 = g.core.config.artifact_info.get(var_4_0.advance_code)

	self.m_imgLoader:setURL(g.core.common.Path:getArtifactPic(var_4_0.icon))
	self.m_nameComp:setData({
		name = var_4_7.name,
		quality = var_4_7.quality
	}, "artifactHandbook")
end

function ArtifactHandBookActivePop:_onClickClose()
	if self._closing then
		return
	end

	self._closing = true

	self.m_back_0Transition:play(handler(self, self._onExitPlayFinish))
end

function ArtifactHandBookActivePop:_onExitPlayFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ArtifactHandBookActivePop:onUnload()
	if self._params.closeCallback then
		self._params.closeCallback()
	end
end

return ArtifactHandBookActivePop
