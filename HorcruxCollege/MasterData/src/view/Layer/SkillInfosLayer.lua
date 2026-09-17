SkillInfosLayer = class("SkillInfosLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PopLayer")

local total_skill_data = require("data.total_skill_data")
local var_0_1 = config._DEBUG and 0 or 1

function SkillInfosLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = SkillInfosLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function SkillInfosLayer:init(arg_3_1, arg_3_2)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Skill.json" or "Skill.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_middle_skill"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)
	self:showskills(arg_3_1, arg_3_2)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			-- block empty
		end
	end)
end

function SkillInfosLayer:showskills(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_skill_" .. iter_6_0):loadTextures("skill_new/skill/" .. total_skill_data[iter_6_1].icon .. ".png", "skill_new/skill/" .. total_skill_data[iter_6_1].icon .. ".png", "skill_new/skill/" .. total_skill_data[iter_6_1].icon .. ".png", var_0_1)

		local var_6_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "skill_info_" .. iter_6_0)

		var_6_0:getChildByName("name"):setString(total_skill_data[iter_6_1].name)
		var_6_0:getChildByName("des"):setString(total_skill_data[iter_6_1].description)

		if iter_6_0 == 2 then
			ccui.Helper:seekWidgetByName(var_6_0, "num"):setString(total_skill_data[iter_6_1].cd .. "S")

			if total_skill_data[iter_6_1].cd ~= arg_6_2 then
				local var_6_1 = ccui.Helper:seekWidgetByName(var_6_0, "num"):clone()

				var_6_1:setPositionX(ccui.Helper:seekWidgetByName(var_6_0, "num"):getPositionX() - ccui.Helper:seekWidgetByName(var_6_0, "num"):getContentSize().width)
				var_6_1:setColor(cc.c3b(0, 254, 0))
				var_6_1:setString("(" .. string.format("%.1f", arg_6_2) .. "S)")
				ccui.Helper:seekWidgetByName(var_6_0, "cost"):addChild(var_6_1)
			end
		end
	end
end
