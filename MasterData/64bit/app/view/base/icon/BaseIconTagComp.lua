local var_0_0 = g.core.const.ConstMgr.BASE_CONST
local BaseIconTagComp = class("BaseIconTagComp", require("app.fairyGUI.base_new.UI_BaseIconTagComp"))

function BaseIconTagComp:setIconTagType(arg_1_1, arg_1_2)
	arg_1_1 = arg_1_1 or var_0_0.ICON_TAG_TYPE.NONE

	if arg_1_1 ~= self:getIconTagType() then
		self.m_tagTypeController:setSelectedIndex(arg_1_1)
	end

	if arg_1_1 == var_0_0.ICON_TAG_TYPE.PROB_NUM then
		self.m_probText:setText(arg_1_2)
	end

	if arg_1_1 == var_0_0.ICON_TAG_TYPE.LEVEL then
		self.m_levelText:setText(g.core.lang:get(201577, {
			level = arg_1_2
		}))
	end

	if arg_1_1 == var_0_0.ICON_TAG_TYPE.NEW_CLUE then
		self:getChild("n3"):setText(g.core.lang:get(409152))
	end

	if arg_1_1 == var_0_0.ICON_TAG_TYPE.ITEM_SPECIAL_USE and arg_1_2 then
		self.m_itemSpecialUseLoader:setURL(var_0_0.ICON_SPECIAL_USE_TYPE[arg_1_2])
	end
end

function BaseIconTagComp:getIconTagType()
	return self.m_tagTypeController:getSelectedIndex()
end

return BaseIconTagComp
