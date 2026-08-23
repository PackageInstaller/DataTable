local RoleSkinAwardComp = class("RoleSkinAwardComp", require("app.fairyGUI.roleSkin.UI_RoleSkinAwardComp"))

function RoleSkinAwardComp:ctor()
	return
end

function RoleSkinAwardComp:update(arg_2_1)
	local var_2_0 = g.core.model.User.roleSkinData:getPartItemByAdvanceId(arg_2_1.data.value)

	self.m_nameComp:updateNameComp(var_2_0)
	self.m_roleSkinPic:setURL(g.core.common.Path:getRoleSkinIcon(var_2_0:getIcon(), 512))

	local var_2_1 = 1

	for iter_2_0, iter_2_1 in pairs((var_2_0:getCurLevelAttrMap())) do
		self["m_attrComp" .. var_2_1]:updateAttr({
			isAll = true,
			type = iter_2_1.type,
			value = iter_2_1.value
		})

		var_2_1 = var_2_1 + 1
	end

	for iter_2_2 = var_2_1, 4 do
		self["m_attrComp" .. iter_2_2]:setVisible(false)
	end
end

function RoleSkinAwardComp:onLoad()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = false,
		name = "eff_ui_common_singlereward",
		scale = 1,
		isLoop = false
	})
end

function RoleSkinAwardComp:onUnload()
	self.m_backTransition:play()
end

return RoleSkinAwardComp
