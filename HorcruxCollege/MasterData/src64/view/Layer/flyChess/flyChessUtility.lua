local var_0_0 = {}
local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local task_data = require("data.task_data")

function var_0_0.showHorcruxDetails(arg_1_0)
	local var_1_0 = -1
	local var_1_1 = require("data.horcrux_data")[arg_1_0].horcruxt

	for iter_1_0, iter_1_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_1_0 == iter_1_1.item_id then
			var_1_0 = iter_1_0

			break
		end
	end

	if var_1_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_1_0,
		itemid = arg_1_0
	})
end

function var_0_0.createIcon(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = drop_manager:getDropMsg(arg_2_0)
	local var_2_1
	local var_2_2

	if not arg_2_2 then
		if var_2_0.gold ~= 0 then
			var_2_1 = "gold"
			var_2_2 = var_2_0.gold
		elseif var_2_0.diamond ~= 0 then
			var_2_1 = "diamond"
			var_2_2 = var_2_0.diamond
		elseif var_2_0.equips then
			for iter_2_0, iter_2_1 in pairs(var_2_0.equips) do
				var_2_1 = iter_2_1.dropid
				var_2_2 = iter_2_1.dropNum
			end
		end
	else
		var_2_1 = arg_2_2
		var_2_2 = arg_2_3
	end

	local var_2_4 = ccui.ImageView:create()

	if item_data[var_2_1].bag_item_type == kITEM_SKIN then
		var_2_4:loadTexture("roleimage/role1/" .. model_data[item_data[var_2_1].model].cute_role .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
		local var_2_5 = drop_manager:getAllDropsNotMerge(arg_2_0)[1].item_attr
		local var_2_6 = ccui.Layout:create()

		var_2_6:setName("starsPanel")
		var_2_6:setScale(1.75)
		var_2_6:setPositionY(58)
		var_2_6:setPositionX(200)
		var_2_4:addChild(var_2_6, 5)

		local var_2_7 = 0

		if var_2_5 then
			for iter_2_2, iter_2_3 in var_2_5:gmatch("([^&]+)=([^&]+)") do
				if iter_2_2 == "star" then
					var_2_7 = tonumber(iter_2_3)
				end
			end
		end

		for iter_2_4 = 1, var_2_7 do
			local var_2_8

			if config._DEBUG then
				var_2_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_2_8:setPosition(25, (iter_2_4 - 1) * 24 - 30)
			var_2_6:addChild(var_2_8)
		end

		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_COMPONENT then
		var_2_4:removeFromParent()

		var_2_4 = nil
		var_2_4 = component_manager:create_component_icon(var_2_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_2_4:setScale(0.75)
	elseif item_data[var_2_1].image_id then
		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.75)
	end

	var_2_4:setTouchEnabled(arg_2_1)
	var_2_4:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
			self.showHorcruxDetails(var_2_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_2_1
			})
		end
	end)

	return var_2_4, var_2_2, name
end

return var_0_0
