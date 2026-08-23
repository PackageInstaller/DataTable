local EchoLabCollectMidAttrUpComp = class("EchoLabCollectMidAttrUpComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectMidAttrUpComp"))

function EchoLabCollectMidAttrUpComp:ctor()
	return
end

function EchoLabCollectMidAttrUpComp:onLoad()
	return
end

function EchoLabCollectMidAttrUpComp:updateView(arg_3_1)
	local var_3_0 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectLevelAttr")
	local var_3_1 = arg_3_1:getLevel()

	var_3_0:updateView({
		lastLevel = var_3_1 - 1,
		level = var_3_1
	})
	self.m_listComp:addItem(var_3_0)

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs((arg_3_1:getTalentAttrList(var_3_1 - 1))) do
		var_3_2[iter_3_1.type] = var_3_2[iter_3_1.type] or 0
		var_3_2[iter_3_1.type] = var_3_2[iter_3_1.type] + iter_3_1.value
	end

	local var_3_3 = {}

	for iter_3_2, iter_3_3 in ipairs((arg_3_1:getTalentAttrList(var_3_1))) do
		local var_3_4 = {
			type = iter_3_3.type
		}

		var_3_4.value = iter_3_3.value - (var_3_2[iter_3_3.type] or 0)

		if var_3_4.value > 0 then
			local var_3_5 = {}

			var_3_5.title, var_3_5.desc = g.core.lang:getAttr(var_3_4.type, tonumber(var_3_4.value), false)
			var_3_5.title = g.core.lang:get(2071, {
				name = var_3_5.title
			})
			var_3_5.desc = g.core.lang:get(408522, {
				tip = var_3_5.desc
			})
			var_3_3[#var_3_3 + 1] = var_3_5
		end
	end

	local var_3_6 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectMidUpComp")

	var_3_6:setTitle(g.core.lang:get(408520))
	var_3_6:setProviderPath("ui://echoLab/EchoLabCollectMidAttr")
	var_3_6:updateAttrs(var_3_3)
	self.m_listComp:addItem(var_3_6)

	local var_3_7 = arg_3_1:getHangupOutInfo()
	local var_3_8 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectMidUpComp")

	var_3_8:setTitle(g.core.lang:get(408521))
	var_3_8:setProviderPath("ui://echoLab/EchoLabCollectMidAttr")
	var_3_8:updateAttrs({
		{
			title = g.core.lang:get(408523),
			titleIcon = g.core.common.Path:getIconByTypeValue(var_3_7.type, var_3_7.value, true),
			desc = g.core.lang:get(408524, {
				num = var_3_7.size
			})
		}
	})
	self.m_listComp:addItem(var_3_8)
end

function EchoLabCollectMidAttrUpComp:onLoad()
	self:dispatchCompEvent("echoLabCollectTipPopEnd", {
		name = "EchoLabCollectMidAttrUpComp"
	})
end

return EchoLabCollectMidAttrUpComp
