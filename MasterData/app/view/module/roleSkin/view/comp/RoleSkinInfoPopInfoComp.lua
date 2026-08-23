local RoleSkinInfoPopInfoComp = class("RoleSkinInfoPopInfoComp", require("app.fairyGUI.roleSkin.UI_RoleSkinInfoPopInfoComp"))

function RoleSkinInfoPopInfoComp:ctor()
	return
end

function RoleSkinInfoPopInfoComp:updateShow(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_nameComp:updateNameComp(arg_2_1)
	self.m_descText:setText(arg_2_1:getDesc())

	for iter_2_0, iter_2_1 in pairs((arg_2_1:getCurLevelAttrMap())) do
		self["m_attr" .. 1]:setVisible(checkbool(iter_2_1))

		if iter_2_1 then
			self["m_attr" .. 1]:updateAttr({
				isAll = true,
				type = iter_2_1.type,
				value = iter_2_1.value
			})
		end
	end
end

return RoleSkinInfoPopInfoComp
