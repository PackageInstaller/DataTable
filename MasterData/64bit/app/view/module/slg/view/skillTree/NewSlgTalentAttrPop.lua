local var_0_0 = g.core.model.User.newSlgSkillTreeData
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local NewSlgTalentAttrPop = class("NewSlgTalentAttrPop", require("app.fairyGUI.newSlg.UI_NewSlgTalentAttrPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgTalentAttrPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgTalentAttrPop:ctor()
	self:showAtCenter()

	self._attrs = {}

	self:updateAllAttr()
end

function NewSlgTalentAttrPop:updateAllAttr()
	for iter_3_0, iter_3_1 in ipairs((var_0_0:getAllAttr())) do
		local var_3_0 = iter_3_1.attrValuePre
		local var_3_1 = (var_0_1.ATTR_MODULE_STRING[iter_3_1.module] or "") .. var_0_1.ATTR_STRING[iter_3_1.attrType]
		local var_3_2 = {}
		local var_3_3 = ""

		if iter_3_1.attrValue ~= 0 then
			table.insert(var_3_2, iter_3_1.attrValue)
		end

		local var_3_4 = ""

		if var_3_0 ~= 0 then
			var_3_0 = var_3_0 / 10
			var_3_4 = var_3_0 .. "%"
		end

		if var_3_0 ~= 0 then
			table.insert(var_3_2, var_3_4)
		end

		var_3_3 = #var_3_2 > 1 and var_3_2[1] .. "|" .. var_3_2[2] or var_3_2[1]

		table.insert(self._attrs, {
			attrName = var_3_1,
			attrValue = var_3_3,
			attrType = iter_3_1.attrType,
			addType = iter_3_1.addType
		})
	end

	table.sort(self._attrs, function(arg_4_0, arg_4_1)
		if arg_4_0.attrType ~= arg_4_1.attrType then
			return arg_4_0.attrType < arg_4_1.attrType
		end

		if arg_4_0.addType ~= arg_4_1.addType then
			return arg_4_0.addType < arg_4_1.addType
		end

		return false
	end)
	self.m_hasShowController:setSelectedIndex(#self._attrs == 0 and 0 or 1)
	self.m_showComp:updateShowComp(self._attrs)
end

return NewSlgTalentAttrPop
