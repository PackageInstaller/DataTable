local ArtifactHandBookActiveFettersComp = class("ArtifactHandBookActiveFettersComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookActiveFettersComp"))

function ArtifactHandBookActiveFettersComp:update(arg_1_1)
	self._onGroupFinish = arg_1_1.data.closeCallback

	local var_1_0 = arg_1_1.data.info

	self.m_nameTxt:setText(arg_1_1.data.info.name)
	self.m_fettersIcon:setURL(g.core.common.Path:getKnightTissuePic(var_1_0.icon))

	local var_1_1

	if arg_1_1.data.lv then
		var_1_1 = g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_1_1.data.info.advance_code, arg_1_1.data.lv - 1)
		var_1_0 = g.core.model.User.artifactHandBookData:getTargetLvCfg(arg_1_1.data.info.advance_code, arg_1_1.data.lv)
	end

	for iter_1_0 = 1, 4 do
		self["m_attr" .. iter_1_0]:setVisible(false)

		if var_1_0["affect_type_" .. iter_1_0] ~= 0 then
			local var_1_2 = {
				isAll = true,
				type = var_1_0["affect_type_" .. iter_1_0]
			}

			if var_1_1 then
				var_1_2.value = var_1_1["affect_value_" .. iter_1_0] or 0
			end

			var_1_2.value2 = var_1_0["affect_value_" .. iter_1_0]

			self["m_attr" .. iter_1_0]:updateAttr(var_1_2)
			self["m_attr" .. iter_1_0]:setVisible(true)
		end
	end
end

function ArtifactHandBookActiveFettersComp:onUnload()
	if self._onGroupFinish then
		self._onGroupFinish()
	end
end

return ArtifactHandBookActiveFettersComp
