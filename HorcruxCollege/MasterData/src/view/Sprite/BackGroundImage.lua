local BackGroundImage = class("BackGroundImage", function()
	return ccui.ImageView:create()
end)
local background_data = require("data.background_data")
local item_data = require("data.item_data")

function BackGroundImage:create(arg_2_1)
	local var_2_0 = BackGroundImage.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BackGroundImage:init(arg_3_1)
	self.backGroundid = arg_3_1

	self:loadTexture("mainScenebg/" .. background_data[self.backGroundid].background_image)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function BackGroundImage:reset(arg_5_1)
	if arg_5_1 == self.backGroundid then
		return
	end

	self.backGroundid = arg_5_1

	self:loadTexture("mainScenebg/" .. background_data[self.backGroundid].background_image)
end

return BackGroundImage
