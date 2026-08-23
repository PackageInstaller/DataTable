local ArtifactHandBookLvUpFettersComp = class("ArtifactHandBookLvUpFettersComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookLvUpFettersComp"))

function ArtifactHandBookLvUpFettersComp:ctor()
	self.m_lvUpBtn:addClickListener(handler(self, self._onLvUpClick))
end

function ArtifactHandBookLvUpFettersComp:update(arg_2_1)
	local var_2_0 = arg_2_1.data.param

	self._info = arg_2_1.data.param

	local var_2_1 = var_2_0.lv or 0
	local var_2_2 = g.core.model.User.artifactHandBookData:getTargetLvCfg(var_2_0.advId, var_2_1)

	self.m_frontLvTxt:setText(var_2_1)
	self.m_behindLvTxt:setText(var_2_1 + 1)

	self._curCfg = var_2_2

	local var_2_3 = g.core.model.User.artifactHandBookData:getTargetLvCfg(var_2_0.advId, var_2_1 + 1)

	self.m_nameTxt:setText(var_2_2.name)
	self.m_fettersIcon:setURL(g.core.common.Path:getKnightTissuePic(var_2_2.icon))

	for iter_2_0 = 1, 4 do
		self["m_attr" .. iter_2_0]:setVisible(false)

		if var_2_0["affect_type_" .. iter_2_0] ~= 0 then
			self["m_attr" .. iter_2_0]:updateAttr({
				isAll = true,
				type = var_2_2["affect_type_" .. iter_2_0],
				value = var_2_2["affect_value_" .. iter_2_0],
				value2 = var_2_3["affect_value_" .. iter_2_0]
			})
			self["m_attr" .. iter_2_0]:setVisible(true)
		end
	end

	if var_2_3.num > 0 then
		self.m_costGroup:setVisible(true)
		self.m_costComp:updateByTVS({
			type = var_2_3.cost_type,
			value = var_2_3.cost_value,
			size = var_2_3.num
		})

		self._canLvUp = g.core.model.User.bagData:getCountById(var_2_3.cost_type, var_2_3.cost_value) >= var_2_3.num and var_2_0.childLv >= var_2_3.need
	else
		self.m_costGroup:setVisible(false)
	end

	self.m_descTxt:setText(g.core.lang:get(205531, {
		num = var_2_3.need - #var_2_0.artifacts
	}))
end

function ArtifactHandBookLvUpFettersComp:_onLvUpClick()
	if self._canLvUp then
		g.core.network.GameNetProxy:send_C2S_Artifact_HandbookUpgrade({
			id = self._curCfg.id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(205527))
	end

	if self._closeFunc then
		self._closeFunc()
	end
end

function ArtifactHandBookLvUpFettersComp:setCloseFunc(arg_4_1)
	self._closeFunc = arg_4_1
end

function ArtifactHandBookLvUpFettersComp:onUnload()
	if self._onGroupFinish then
		self._onGroupFinish()
	end
end

return ArtifactHandBookLvUpFettersComp
