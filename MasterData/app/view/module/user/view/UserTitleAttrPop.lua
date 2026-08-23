local var_0_0 = g.core.lang
local UserTitleAttrPop = class("UserTitleAttrPop", require("app.fairyGUI.user.UI_UserTitleAttrPop"), function()
	return fgui.GComponent:create({
		resName = "UserTitleAttrPop",
		pkgPath = "ui/user/user",
		pkgName = "user"
	}, ...)
end)

function UserTitleAttrPop:ctor()
	self:showAtCenter()

	self._attrsData = {}

	self.m_attrsList:setVirtual()
	self.m_attrsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
end

function UserTitleAttrPop:onLoad()
	self._attrsData = g.core.model.User.UserTitleData:getTitleAllAttrsData()

	self.m_attrsList:setNumItems(#self._attrsData)
end

function UserTitleAttrPop:_onAttrsItemRenderer(arg_4_1, arg_4_2)
	if self._attrsData[arg_4_1 + 1] then
		local var_4_0, var_4_1 = var_0_0:getAttr(self._attrsData[arg_4_1 + 1].type, self._attrsData[arg_4_1 + 1].value)
		local var_4_2, var_4_3

		if self._attrsData[arg_4_1 + 1].target == 2 then
			var_4_2 = var_0_0:get(105508)

			if not var_4_2 then
				var_4_2 = var_0_0:get(105509)
				var_4_3 = {}
			end
		end

		var_4_3.name = var_4_2 .. var_4_0
		var_4_3.value = var_4_1

		arg_4_2:updateAttr(var_4_3)
	end
end

return UserTitleAttrPop
