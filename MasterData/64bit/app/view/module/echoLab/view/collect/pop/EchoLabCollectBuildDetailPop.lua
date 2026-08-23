local EchoLabCollectBuildDetailPop = class("EchoLabCollectBuildDetailPop", require("app.fairyGUI.echoLab.UI_EchoLabCollectBuildDetailPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabCollectBuildDetailPop",
		pkgName = "echoLab",
		pkgPath = "ui/echoLab/echoLab"
	})
end)

function EchoLabCollectBuildDetailPop:ctor(arg_2_1)
	self.m_bgPanel:setTitle("")
	self:_init(arg_2_1)
	self:showAtCenter()
end

function EchoLabCollectBuildDetailPop:_init(arg_3_1)
	self.m_title:setText(g.core.lang:get(408538, {
		name = arg_3_1:getBuildName()
	}))
	self.m_listComp:setMargin(-10)

	local var_3_0 = arg_3_1:getExpInfo()
	local var_3_1 = arg_3_1:getLevel()
	local var_3_2 = 1

	while arg_3_1:getCfgByLevel(1) do
		local var_3_3 = fgui.UIPackage:createObject("echoLab", "EchoLabCollectAttrsComp")

		var_3_3:setProviderPath("ui://echoLab/EchoLabCollectMultiLineAttr")
		var_3_3:setTitle(g.core.lang:get(408539, {
			grade = var_3_2
		}))

		local var_3_4 = "#323232"
		local var_3_5

		if var_3_1 < var_3_2 then
			var_3_4 = "#808080"
			var_3_5 = g.core.lang:get(408542)

			if var_3_1 + 1 == var_3_2 then
				var_3_5 = g.core.lang:get(408540, {
					color = "#f44e4e",
					cur = var_3_0.cur,
					max = var_3_0.max
				})
			end
		end

		local var_3_6 = {}
		local var_3_7 = {}

		for iter_3_0, iter_3_1 in pairs((arg_3_1:getTalentAttrDictByOneLevel(var_3_2))) do
			table.insert(var_3_7, {
				type = iter_3_0,
				value = iter_3_1
			})
		end

		for iter_3_2 = 1, #var_3_7, 2 do
			local var_3_8 = {}
			local var_3_9, var_3_10 = g.core.lang:getAttr(var_3_7[iter_3_2].type, tonumber(var_3_7[iter_3_2].value), false)

			var_3_8[1] = {
				title = g.core.lang:get(408541, {
					color = var_3_4,
					des = var_3_9
				}),
				value = g.core.lang:get(408541, {
					color = var_3_4,
					des = var_3_10
				})
			}

			if var_3_7[iter_3_2 + 1] then
				local var_3_11, var_3_12 = g.core.lang:getAttr(var_3_7[iter_3_2 + 1].type, tonumber(var_3_7[iter_3_2 + 1].value), false)

				var_3_8[2] = {
					title = g.core.lang:get(408541, {
						color = var_3_4,
						des = var_3_11
					}),
					value = g.core.lang:get(408541, {
						color = var_3_4,
						des = var_3_12
					})
				}
			end

			var_3_6[#var_3_6 + 1] = var_3_8
		end

		local var_3_13 = arg_3_1:getHangupOutInfo(var_3_2)

		var_3_6[#var_3_6 + 1] = {
			title = g.core.lang:get(408541, {
				color = var_3_4,
				des = g.core.lang:get(408547)
			}),
			iconUrl = g.core.common.Path:getIconByTypeValue(var_3_13.type, var_3_13.value, true),
			value = g.core.lang:get(408541, {
				color = var_3_4,
				des = g.core.lang:get(408548, {
					num = var_3_13.size
				})
			})
		}

		self.m_listComp:addItem(var_3_3)
		var_3_3:updateAttrs(var_3_6, var_3_5)

		var_3_2 = var_3_2 + 1

		local var_3_14 = arg_3_1:getCfgByLevel(var_3_2)
	end
end

return EchoLabCollectBuildDetailPop
