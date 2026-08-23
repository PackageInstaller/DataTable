local UniteTokenAwakeBottomComp = class("UniteTokenAwakeBottomComp", require("app.fairyGUI.uniteToken.UI_UniteTokenAwakeBottomComp"))
local UniteTokenConst = require("app.view.module.uniteToken.const.UniteTokenConst")
local var_0_5 = g.core.model.User.uniteTokenData

function UniteTokenAwakeBottomComp:ctor()
	return
end

function UniteTokenAwakeBottomComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_5:getTokenBaseInfo((arg_2_1:getBaseId()))

	for iter_2_0 = 1, UniteTokenConst.AWAKEN_ATTR_NUM do
		local var_2_1 = not not var_2_0.attrList[iter_2_0]
		local var_2_2 = self["m_totalAttrComp" .. iter_2_0]

		self["m_totalAttrComp" .. iter_2_0]:setVisible(var_2_0.attrList[iter_2_0] and true or false)

		if var_2_1 then
			var_2_2:updateAttr(var_2_0.attrList[iter_2_0])
		end
	end
end

return UniteTokenAwakeBottomComp
