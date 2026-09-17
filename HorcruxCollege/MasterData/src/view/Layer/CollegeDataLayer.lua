CollegeDataLayer = class("CollegeDataLayer", function()
	return cc.Layer:create()
end)

local photofile_all_data = require("data.photofile_all_data")

function CollegeDataLayer.create(arg_2_0)
	local var_2_0 = CollegeDataLayer.new()

	var_2_0:init()

	return var_2_0
end

local var_0_1 = {
	"college",
	"ai",
	"army",
	"foundation",
	"killer"
}

function CollegeDataLayer:init()
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "School_data.json" or "School_data.ExportJson")

	self:addChild(self.rootlayer)

	self.bg = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.bg:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			-- block empty
		end
	end)
	self:getBtn()
	self:setBtn()
end

function CollegeDataLayer:getBtn()
	self.btnTable = {}

	for iter_6_0 = 1, #photofile_all_data do
		self.btnTable[iter_6_0] = ccui.Helper:seekWidgetByName(self.rootlayer, "Image" .. iter_6_0)
	end
end

function CollegeDataLayer:setBtn()
	for iter_7_0 = 1, #self.btnTable do
		self.btnTable[iter_7_0]:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 == ccui.TouchEventType.began then
				local var_8_0 = arg_8_0:convertToNodeSpace((arg_8_0:getTouchBeganPosition()))

				if var_8_0.y < -var_8_0.x + 92 then
					return
				end

				if var_8_0.y < var_8_0.x - 92 then
					return
				end

				if var_8_0.y > var_8_0.x + 92 then
					return
				end

				if var_8_0.y > -var_8_0.x + 276 then
					return
				end

				arg_8_0:setScale(1.2)
			elseif arg_8_1 == ccui.TouchEventType.canceled then
				arg_8_0:setScale(1)
			elseif arg_8_1 == ccui.TouchEventType.ended then
				arg_8_0:setScale(1)
			end

			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_8_1 = arg_8_0:convertToNodeSpace((arg_8_0:getTouchBeganPosition()))

			if var_8_1.y < -var_8_1.x + 92 then
				return
			end

			if var_8_1.y < var_8_1.x - 92 then
				return
			end

			if var_8_1.y > var_8_1.x + 92 then
				return
			end

			if var_8_1.y > -var_8_1.x + 276 then
				return
			end

			LayerManager:pushInLayer("PhotoFileLayer", {
				dataId = iter_7_0,
				roleType = var_0_1[iter_7_0]
			})
		end)
	end
end
