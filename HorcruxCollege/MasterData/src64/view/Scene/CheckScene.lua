local CheckScene = class("CheckScene", function()
	return cc.Scene:create()
end)

require("data.constants")
require("controller.global_func")

function CheckScene:create()
	local var_2_0 = CheckScene.new()

	var_2_0:init()

	return var_2_0
end

local function var_0_1()
	require("lfs")

	for iter_3_0 in lfs.dir("./res/CocosRes") do
		if iter_3_0:find(".plist") then
			cc.SpriteFrameCache:getInstance():addSpriteFrames("CocosRes/" .. iter_3_0)
		end
	end
end

function CheckScene:init()
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)
	print("load all textures, please wait...")
	var_0_1()
	print("load success!!!")
	cc.FileUtils:getInstance():addSearchPath("res/CocosRes_source")

	local var_4_0 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_0:setPosition(cc.p(120, 1000))
	var_4_0:setTitleText(L_CHECK_DATA_TITLE.Data)
	var_4_0:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_0)

	local var_4_1 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_1:setAnchorPoint(cc.p(0, 0.5))
	var_4_1:setPosition(cc.p(200, 34))
	var_4_1:setMaxLineWidth(100)
	var_4_1:setString(L_CHECK_DATA_STR.Data)
	var_4_0:addChild(var_4_1)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkDataFormat()
	end)

	local var_4_2 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_2:setPosition(cc.p(430, 1000))
	var_4_2:setTitleText(L_CHECK_DATA_TITLE.Items)
	var_4_2:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_2)

	local var_4_3 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_3:setAnchorPoint(cc.p(0, 0.5))
	var_4_3:setPosition(cc.p(200, 34))
	var_4_3:setMaxLineWidth(100)
	var_4_3:setString(L_CHECK_DATA_STR.Items)
	var_4_2:addChild(var_4_3)
	var_4_2:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkItemData()
	end)

	local var_4_4 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_4:setPosition(cc.p(120, 900))
	var_4_4:setTitleText(L_CHECK_DATA_TITLE.Drops)
	var_4_4:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_4)

	local var_4_5 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_5:setAnchorPoint(cc.p(0, 0.5))
	var_4_5:setPosition(cc.p(200, 34))
	var_4_5:setMaxLineWidth(100)
	var_4_5:setString(L_CHECK_DATA_STR.Drops)
	var_4_4:addChild(var_4_5)
	var_4_4:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkDropData()
	end)

	local var_4_6 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_6:setPosition(cc.p(430, 900))
	var_4_6:setTitleText(L_CHECK_DATA_TITLE.Task)
	var_4_6:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_6)

	local var_4_7 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_7:setAnchorPoint(cc.p(0, 0.5))
	var_4_7:setPosition(cc.p(200, 34))
	var_4_7:setMaxLineWidth(100)
	var_4_7:setString(L_CHECK_DATA_STR.Task)
	var_4_6:addChild(var_4_7)
	var_4_6:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkTaskData()
	end)

	local var_4_8 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_8:setPosition(cc.p(120, 800))
	var_4_8:setTitleText(L_CHECK_DATA_TITLE.Skill)
	var_4_8:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_8)

	local var_4_9 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_9:setAnchorPoint(cc.p(0, 0.5))
	var_4_9:setPosition(cc.p(200, 34))
	var_4_9:setMaxLineWidth(100)
	var_4_9:setString(L_CHECK_DATA_STR.Skill)
	var_4_8:addChild(var_4_9)
	var_4_8:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkSkillData()
	end)

	local var_4_10 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_10:setPosition(cc.p(430, 800))
	var_4_10:setTitleText(L_CHECK_DATA_TITLE.Enemy)
	var_4_10:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_10)

	local var_4_11 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_11:setAnchorPoint(cc.p(0, 0.5))
	var_4_11:setPosition(cc.p(200, 34))
	var_4_11:setMaxLineWidth(100)
	var_4_11:setString(L_CHECK_DATA_STR.Enemy)
	var_4_10:addChild(var_4_11)
	var_4_10:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkMonsterData()
	end)

	local var_4_12 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_12:setPosition(cc.p(120, 700))
	var_4_12:setTitleText(L_CHECK_DATA_TITLE.Model)
	var_4_12:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_12)

	local var_4_13 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_13:setAnchorPoint(cc.p(0, 0.5))
	var_4_13:setPosition(cc.p(200, 34))
	var_4_13:setMaxLineWidth(100)
	var_4_13:setString(L_CHECK_DATA_STR.Model)
	var_4_12:addChild(var_4_13)
	var_4_12:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkModelData()
	end)

	local var_4_14 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_14:setPosition(cc.p(430, 700))
	var_4_14:setTitleText(L_CHECK_DATA_TITLE.Full_Screen_Dialog)
	var_4_14:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_14)

	local var_4_15 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_15:setAnchorPoint(cc.p(0, 0.5))
	var_4_15:setPosition(cc.p(200, 34))
	var_4_15:setMaxLineWidth(100)
	var_4_15:setString(L_CHECK_DATA_STR.Full_Screen_Dialog)
	var_4_14:addChild(var_4_15)
	var_4_14:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkConversationData()
	end)

	local var_4_16 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_16:setPosition(cc.p(120, 600))
	var_4_16:setTitleText(L_CHECK_DATA_TITLE.Travel)
	var_4_16:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_16)

	local var_4_17 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_17:setAnchorPoint(cc.p(0, 0.5))
	var_4_17:setPosition(cc.p(200, 34))
	var_4_17:setMaxLineWidth(100)
	var_4_17:setString(L_CHECK_DATA_STR.Travel)
	var_4_16:addChild(var_4_17)
	var_4_16:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkTravelData()
	end)

	local var_4_18 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_18:setPosition(cc.p(430, 600))
	var_4_18:setTitleText(L_CHECK_DATA_TITLE.Cook)
	var_4_18:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_18)

	local var_4_19 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_19:setAnchorPoint(cc.p(0, 0.5))
	var_4_19:setPosition(cc.p(200, 34))
	var_4_19:setMaxLineWidth(100)
	var_4_19:setString(L_CHECK_DATA_STR.Cook)
	var_4_18:addChild(var_4_19)
	var_4_18:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkCookData()
	end)

	local var_4_20 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_20:setPosition(cc.p(120, 500))
	var_4_20:setTitleText(L_CHECK_DATA_TITLE.Other_Dialog)
	var_4_20:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_20)

	local var_4_21 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_21:setAnchorPoint(cc.p(0, 0.5))
	var_4_21:setPosition(cc.p(200, 34))
	var_4_21:setMaxLineWidth(100)
	var_4_21:setString(L_CHECK_DATA_STR.Other_Dialog)
	var_4_20:addChild(var_4_21)
	var_4_20:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkRoleConversationData()
	end)

	local var_4_22 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_22:setPosition(cc.p(430, 500))
	var_4_22:setTitleText(L_CHECK_DATA_TITLE.Twist_Egg)
	var_4_22:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_22)

	local var_4_23 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_23:setAnchorPoint(cc.p(0, 0.5))
	var_4_23:setPosition(cc.p(200, 34))
	var_4_23:setMaxLineWidth(100)
	var_4_23:setString(L_CHECK_DATA_STR.Twist_Egg)
	var_4_22:addChild(var_4_23)
	var_4_22:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkTwistDropRate()
	end)

	local var_4_24 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_24:setPosition(cc.p(120, 400))
	var_4_24:setTitleText(L_CHECK_DATA_TITLE.Advanture)
	var_4_24:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_24)

	local var_4_25 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_25:setAnchorPoint(cc.p(0, 0.5))
	var_4_25:setPosition(cc.p(200, 34))
	var_4_25:setMaxLineWidth(100)
	var_4_25:setString(L_CHECK_DATA_STR.Advanture)
	var_4_24:addChild(var_4_25)
	var_4_24:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkExplolreData()
	end)

	local var_4_26 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_26:setPosition(cc.p(430, 400))
	var_4_26:setTitleText(L_CHECK_DATA_TITLE.Create_Advanture_Data)
	var_4_26:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_26)

	local var_4_27 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_27:setAnchorPoint(cc.p(0, 0.5))
	var_4_27:setPosition(cc.p(200, 34))
	var_4_27:setMaxLineWidth(100)
	var_4_27:setString(L_CHECK_DATA_STR.Create_Data)
	var_4_26:addChild(var_4_27)
	var_4_26:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:explore_gen_tile_data()
	end)

	local var_4_28 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_28:setPosition(cc.p(120, 300))
	var_4_28:setTitleText(L_CHECK_DATA_TITLE.Entrust)
	var_4_28:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_28)

	local var_4_29 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_29:setAnchorPoint(cc.p(0, 0.5))
	var_4_29:setPosition(cc.p(200, 34))
	var_4_29:setMaxLineWidth(100)
	var_4_29:setString(L_CHECK_DATA_STR.Create_Data)
	var_4_28:addChild(var_4_29)
	var_4_28:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkPlotData()
	end)

	local var_4_30 = ccui.Button:create("public/button/public_button_big.png", "public/button/public_button_big_on.png", "public/button/public_button_big.png")

	var_4_30:setPosition(cc.p(430, 300))
	var_4_30:setTitleText(L_CHECK_DATA_TITLE.Entrust_Random)
	var_4_30:setTitleFontSize(25)
	self.rootlayer:addChild(var_4_30)

	local var_4_31 = cc.Label:createWithTTF("", "fonts/new1.ttf", 15)

	var_4_31:setAnchorPoint(cc.p(0, 0.5))
	var_4_31:setPosition(cc.p(200, 34))
	var_4_31:setMaxLineWidth(100)
	var_4_31:setString(L_CHECK_DATA_STR.Create_Data)
	var_4_30:addChild(var_4_31)
	var_4_30:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:checkRandomPlotPool()
	end)
end

function CheckScene:checkDataFormat()
	require("lfs")

	local function var_21_1(arg_22_0)
		for iter_22_0 in lfs.dir(arg_22_0) do
			if iter_22_0 ~= "." and iter_22_0 ~= ".." then
				if lfs.attributes(arg_22_0 .. "/" .. iter_22_0).mode == "directory" then
					var_21_1(arg_22_0 .. "/" .. iter_22_0)
				elseif iter_22_0:find(".lua") then
					local var_22_0, var_22_1 = pcall(require, string.format("%s.%s", arg_22_0:sub(3):gsub("/", "."), iter_22_0:match("(.+).lua$")))

					if not var_22_0 then
						print(var_22_1)
					end
				end
			end
		end
	end

	;(nil)("./src/data")
	var_21_1("./src/fight/behavior")
	var_21_1("./src/fight/spine")
	global_ShowBlockWords(L_CHECK_END)
	print("check complete!!!!")
end

function CheckScene:checkItemData()
	local var_23_0, var_23_1 = pcall(require, "data.item_data")

	if not var_23_0 then
		print(var_23_1)

		return
	end

	for iter_23_0, iter_23_1 in pairs({
		"data.weapon_data",
		"data.HelpGirl_data",
		"data.component_data",
		"data.food_production.pot.pot_data",
		"data.food_production.eatables.foodmaterials_data",
		"data.food_production.eatables.cooktable_data",
		"data.medal_data",
		"data.furniture_data",
		"data.lab_material_data"
	}) do
		local var_23_2, var_23_3 = pcall(require, iter_23_1)

		if var_23_2 then
			table.merge(var_23_1, var_23_3)
		else
			print(var_23_3)

			return
		end
	end

	local var_23_4 = {
		dropitem = {},
		shopitem = {},
		signitem = {},
		itemimages = {}
	}

	print("start check itemdata...")
	;(function()
		print("check drop items...")

		local var_24_0, var_24_1 = pcall(require, "data.drop_data")

		if not var_24_0 then
			print(var_24_1)
			print("check drop items fail...")

			return
		end

		for iter_24_0, iter_24_1 in pairs(var_24_1) do
			local var_24_2 = 1

			while iter_24_1["drop_id" .. var_24_2] do
				if not var_23_1[iter_24_1["drop_id" .. var_24_2]] then
					table.insert(var_23_4.dropitem, {
						dropid = iter_24_0,
						item = iter_24_1["drop_id" .. var_24_2]
					})
				end

				var_24_2 = var_24_2 + 1
			end

			local var_24_3 = 1

			while iter_24_1["rd_drop_id" .. var_24_3] do
				if iter_24_1["rd_drop_weight" .. var_24_3] > 0 then
					if not var_23_1[iter_24_1["rd_drop_id" .. var_24_3]] then
						table.insert(var_23_4.dropitem, {
							dropid = iter_24_0,
							item = iter_24_1["rd_drop_id" .. var_24_3]
						})
					end
				end

				var_24_3 = var_24_3 + 1
			end
		end

		print(string.format("check drop item complete, there are %d errors", #var_23_4.dropitem))
	end)()
	;(function()
		print("check shop item....")

		local var_25_0, var_25_1 = pcall(require, "data.shop_data")

		if not var_25_0 then
			print(var_25_1)
			print("check shop items fail...")

			return
		end

		for iter_25_0, iter_25_1 in pairs(var_25_1) do
			if not iter_25_1.itemid then
				table.insert(var_23_4.shopitem, {
					shopid = iter_25_0
				})
			elseif not var_23_1[iter_25_1.itemid] then
				table.insert(var_23_4.shopitem, {
					shopid = iter_25_0,
					item = iter_25_1.itemid
				})
			end
		end

		print(string.format("check shop item complete, there are %d errors", #var_23_4.shopitem))
	end)()
	;(function()
		print("check sign items...")

		local var_26_0, var_26_1 = pcall(require, "data.sign_data")

		if not var_26_0 then
			print(var_26_1)
			print("check sign items fail....")

			return
		end

		for iter_26_0, iter_26_1 in pairs(var_26_1) do
			if not var_23_1[iter_26_1.firsttime] then
				table.insert(var_23_4.signitem, iter_26_1.firsttime)
			end

			if not var_23_1[iter_26_1.secondtime] then
				table.insert(var_23_4.signitem, iter_26_1.secondtime)
			end

			if not var_23_1[iter_26_1.thirdtime] then
				table.insert(var_23_4.signitem, iter_26_1.thirdtime)
			end
		end

		print(string.format("check sign item complete, there are %d errors", #var_23_4.signitem))
	end)()
	;(function()
		print("check item images...")

		for iter_27_0, iter_27_1 in pairs(var_23_1) do
			if iter_27_1.image_id then
				if not cc.FileUtils:getInstance():isFileExist("equipment/" .. iter_27_1.image_id .. ".png") then
					table.insert(var_23_4.itemimages, {
						item = iter_27_1.id,
						image = iter_27_1.image_id
					})
				end
			end
		end

		print(string.format("check item images complete, there are %d errors", #var_23_4.itemimages))
	end)()
	print("check itemdata complete!!!")

	local var_23_5 = io.open("result_item.lua", "w+")

	var_23_5:write(dump(var_23_4))
	var_23_5:flush()
	var_23_5:close()
end

function CheckScene:checkDropData()
	local var_28_0, var_28_1 = pcall(require, "data.drop_data")

	if not var_28_0 then
		print(var_28_1)

		return
	end

	local var_28_2 = {
		leveldrop = {},
		marketdrop = {},
		taskdrop = {},
		emptydrop = {}
	}

	local function var_28_3()
		require("lfs")

		local var_29_0 = {}

		for iter_29_0 in lfs.dir("./src/data/leveldata") do
			if iter_29_0:find("level_data") then
				local var_29_1, var_29_2 = pcall(require, string.format("data.leveldata.%s", iter_29_0:match("(.+).lua$")))

				if var_29_1 then
					table.merge(var_29_0, var_29_2)
				else
					return false, var_29_2
				end
			end
		end

		return true, var_29_0
	end

	print("start check dropdata...")
	;(function()
		print("check level drop....")

		local var_30_0, var_30_1 = var_28_3()

		if not var_30_0 then
			print(var_30_1)
			print("check level drop fail...")

			return
		end

		for iter_30_0, iter_30_1 in pairs(var_30_1) do
			if iter_30_1.equip_drop then
				if not var_28_1[iter_30_1.equip_drop] then
					table.insert(var_28_2.leveldrop, {
						level = iter_30_0,
						drop = iter_30_1.equip_drop
					})
				end
			end
		end

		print(string.format("check level drop complete, there are %d errors", #var_28_2.leveldrop))
	end)()
	;(function()
		print("check market drop.....")

		local var_31_0, var_31_1 = pcall(require, "data.market_level_data")

		if not var_31_0 then
			print(var_31_1)
			print("check market drop fail...")

			return
		end

		local var_31_2, var_31_3 = pcall(require, "data.market_data")

		if not var_31_2 then
			print(var_31_3)
			print("check market drop fail...")

			return
		end

		for iter_31_0, iter_31_1 in pairs(var_31_1) do
			for iter_31_2, iter_31_3 in pairs(iter_31_1) do
				if iter_31_2 ~= "id" and not var_28_1[iter_31_3] then
					table.insert(var_28_2.marketdrop, {
						marketlevel = iter_31_0,
						drop = iter_31_3
					})
				end
			end
		end

		for iter_31_4 = 2, 3 do
			local var_31_4 = 1

			while var_31_3[iter_31_4]["number" .. var_31_4] do
				if not var_28_1[var_31_3[iter_31_4]["number" .. var_31_4]] then
					table.insert(var_28_2.marketdrop, {
						market = iter_31_4,
						drop = var_31_3[iter_31_4]["number" .. var_31_4]
					})
				end

				var_31_4 = var_31_4 + 1
			end
		end

		print(string.format("check market drop complete, there are %d errors", #var_28_2.marketdrop))
	end)()
	;(function()
		print("check task drop...")

		local var_32_0, var_32_1 = pcall(require, "data.task_data")

		if not var_32_0 then
			print(var_32_1)
			print("check task drop fail....")

			return
		end

		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			if not var_28_1[iter_32_1.drop] then
				table.insert(var_28_2.taskdrop, {
					task = iter_32_0,
					drop = iter_32_1.drop
				})
			end
		end

		print(string.format("check task drop complete, there are %d errors", #var_28_2.taskdrop))
	end)()
	;(function()
		print("check empty drop....")

		for iter_33_0, iter_33_1 in pairs(var_28_1) do
			if not iter_33_1.gold and not iter_33_1.diamond then
				local var_33_1 = 1
				local var_33_2 = 0

				while iter_33_1["drop_id" .. var_33_1] do
					var_33_2 = var_33_2 + 1
					var_33_1 = var_33_1 + 1
				end

				local var_33_3 = 1

				while iter_33_1["rd_drop_id" .. var_33_3] do
					if iter_33_1["rd_drop_weight" .. var_33_3] > 0 then
						var_33_2 = var_33_2 + 1
					end

					var_33_3 = var_33_3 + 1
				end

				local var_33_4 = 1

				while iter_33_1["dropmodel_id" .. var_33_4] do
					var_33_2 = var_33_2 + 1
					var_33_4 = var_33_4 + 1
				end

				local var_33_5 = 1

				while iter_33_1["rd_dropmodel_id" .. var_33_5] do
					if iter_33_1["rd_dropmodel_rate" .. var_33_5] > 0 then
						var_33_2 = var_33_2 + 1
					end

					var_33_5 = var_33_5 + 1
				end

				if var_33_2 <= 0 then
					table.insert(var_28_2.emptydrop, {
						dropid = iter_33_1.id
					})
				end
			end
		end

		print(string.format("check emptydrop complete, there are %d errors", #var_28_2.emptydrop))
	end)()
	print("check dropdata complete!!!!")

	local var_28_4 = io.open("result_drop.lua", "w+")

	var_28_4:write(dump(var_28_2))
	var_28_4:flush()
	var_28_4:close()
end

function CheckScene:checkTaskData()
	local task_data = require("data.task_data")
	local var_34_1 = {
		{},
		{},
		{},
		{}
	}

	print("start check taskdata....")

	for iter_34_0, iter_34_1 in pairs({
		require("data.normal_task_index_data"),
		require("data.weekly_task_index_data"),
		require("data.achieve_task_index_data"),
		(require("data.career_task_index_data"))
	}) do
		for iter_34_2, iter_34_3 in pairs(iter_34_1) do
			if iter_34_3.valid and not task_data[iter_34_3.taskid] then
				table.insert(var_34_1[iter_34_0], {
					tasktype = L_CHECK_TASK_DATA.tasktypeStr[iter_34_0],
					index = iter_34_2,
					taskid = iter_34_3.taskid
				})
			end
		end

		print(string.format("check %s complete, there are %d errors", L_CHECK_TASK_DATA.tasktypeStr[iter_34_0], #var_34_1[iter_34_0]))
	end

	print("check task data complete...")

	local var_34_2 = io.open("result_task.lua", "w+")

	var_34_2:write((dump(var_34_1)))
	var_34_2:flush()
	var_34_2:close()
end

function CheckScene:checkSkillData()
	local status_data = require("data.status_data")
	local buff_data = require("data.buff_data")
	local var_35_2 = {
		nullstatusInskill = {},
		nullstatusInbuff = {},
		nullbuffInskill = {},
		nullbuffInstatus = {}
	}

	for iter_35_0, iter_35_1 in pairs((require("data.skill_data"))) do
		local var_35_3 = 1

		while iter_35_1["status_add" .. var_35_3] do
			if not status_data[iter_35_1["status_add" .. var_35_3]] then
				table.insert(var_35_2.nullstatusInskill, {
					skill = iter_35_0,
					status = iter_35_1["status_add" .. var_35_3]
				})
			end

			var_35_3 = var_35_3 + 1
		end

		local var_35_4 = 1

		while iter_35_1["buff_add" .. var_35_4] do
			if not buff_data[iter_35_1["buff_add" .. var_35_4]] then
				table.insert(var_35_2.nullbuffInskill, {
					skill = iter_35_0,
					buff = iter_35_1["buff_add" .. var_35_4]
				})
			end

			var_35_4 = var_35_4 + 1
		end
	end

	print(string.format("check skilldata complete, there %d errors", #var_35_2.nullbuffInskill + #var_35_2.nullstatusInskill))

	for iter_35_2, iter_35_3 in pairs(buff_data) do
		local var_35_5 = 1

		while iter_35_3["status_add" .. var_35_5] do
			if not status_data[iter_35_3["status_add" .. var_35_5]] then
				table.insert(var_35_2.nullstatusInbuff, {
					buff = iter_35_2,
					status = iter_35_3["status_add" .. var_35_5]
				})
			end

			var_35_5 = var_35_5 + 1
		end
	end

	print(string.format("check buffdata complete, there %d errors", #var_35_2.nullstatusInbuff))

	for iter_35_4, iter_35_5 in pairs(status_data) do
		if iter_35_5.status_type == 6 or iter_35_5.status_type == 120 then
			for iter_35_6 in iter_35_5.value1:gmatch("([^&]+)") do
				if not buff_data[tonumber(iter_35_6)] then
					table.insert(var_35_2.nullbuffInstatus, {
						buff = tonumber(iter_35_6),
						status = iter_35_5.id
					})
				end
			end
		end
	end

	print(string.format("check statusdata complete, there %d errors", #var_35_2.nullbuffInstatus))

	local var_35_6 = io.open("result_skill.lua", "w+")

	var_35_6:write((dump(var_35_2)))
	var_35_6:flush()
	var_35_6:close()
end

function CheckScene:checkMonsterData()
	local chapter_data = require("data.chapter_data")
	local var_36_1 = {}

	print("start check monster data...")

	local function var_36_2(arg_37_0, arg_37_1)
		local var_37_0, var_37_1 = pcall(require, "data.leveldata.level_data_" .. arg_37_0)

		if not var_37_0 then
			print(var_37_1)

			return
		end

		local var_37_2 = require("data.leveldata.monster_team_data" .. arg_37_0)
		local var_37_3 = require("data.leveldata.monster_data" .. arg_37_0)

		print(string.format("check monsters in %s", arg_37_1.name))

		var_36_1[arg_37_0] = {
			missInMonsterTeam = {},
			missInMonster = {}
		}

		for iter_37_0, iter_37_1 in pairs(var_37_1) do
			local var_37_4 = 1

			while iter_37_1["monster_team" .. var_37_4] do
				if not var_37_2[iter_37_1["monster_team" .. var_37_4]] then
					table.insert(var_36_1[arg_37_0].missInMonsterTeam, {
						level = iter_37_0,
						team = iter_37_1["monster_team" .. var_37_4]
					})
				else
					local var_37_5 = var_37_2[iter_37_1["monster_team" .. var_37_4]]
					local var_37_6 = 1

					while var_37_5["monster" .. var_37_6] do
						monster = var_37_5["monster" .. var_37_6]

						if not var_37_3[monster] then
							table.insert(var_36_1[arg_37_0].missInMonster, {
								level = iter_37_0,
								monster = monster
							})
						end

						var_37_6 = var_37_6 + 1
					end
				end

				var_37_4 = var_37_4 + 1
			end

			if iter_37_1.boss_team then
				if not var_37_2[iter_37_1.boss_team] then
					table.insert(var_36_1[arg_37_0].missInMonsterTeam, {
						level = iter_37_0,
						team = iter_37_1.boss_team
					})
				else
					local var_37_7 = var_37_2[iter_37_1.boss_team]
					local var_37_8 = 1

					while var_37_7["monster" .. var_37_8] do
						monster = var_37_7["monster" .. var_37_8]

						if not var_37_3[monster] then
							table.insert(var_36_1[arg_37_0].missInMonster, {
								level = iter_37_0,
								monster = monster
							})
						end

						var_37_8 = var_37_8 + 1
					end
				end
			end
		end

		for iter_37_2 = 1, arg_37_1.totalchapter do
			if not chapter_data[arg_37_0 .. "-" .. iter_37_2] then
				print("there is a nil chapter in " .. arg_37_0 .. "-" .. iter_37_2)

				return
			end

			local var_37_9 = 1

			while chapter_data[arg_37_0 .. "-" .. iter_37_2]["monster_team" .. var_37_9] do
				if not var_37_2[chapter_data[arg_37_0 .. "-" .. iter_37_2]["monster_team" .. var_37_9]] then
					table.insert(var_36_1[arg_37_0].missInMonsterTeam, {
						chapter = chapter_data[arg_37_0 .. "-" .. iter_37_2].id,
						team = chapter_data[arg_37_0 .. "-" .. iter_37_2]["monster_team" .. var_37_9]
					})
				else
					local var_37_10 = var_37_2[chapter_data[arg_37_0 .. "-" .. iter_37_2]["monster_team" .. var_37_9]]
					local var_37_11 = 1

					while var_37_10["monster" .. var_37_11] do
						monster = var_37_10["monster" .. var_37_11]

						if not var_37_3[monster] then
							table.insert(var_36_1[arg_37_0].missInMonster, {
								chapter = chapter_data[arg_37_0 .. "-" .. iter_37_2].id,
								monster = monster
							})
						end

						var_37_11 = var_37_11 + 1
					end
				end

				var_37_9 = var_37_9 + 1
			end
		end

		print(string.format("check %d monster complete, there are %d errors", arg_37_0, #var_36_1[arg_37_0].missInMonsterTeam + #var_36_1[arg_37_0].missInMonster))
	end

	for iter_36_0, iter_36_1 in pairs((require("data.levelmode_data"))) do
		var_36_2(iter_36_0, iter_36_1)
	end

	print("check monster data complete...")

	local var_36_3 = io.open("result_monster.lua", "w+")

	var_36_3:write((dump(var_36_1)))
	var_36_3:flush()
	var_36_3:close()
end

function CheckScene:checkModelData()
	local model_data = require("data.model_data")
	local var_38_1, var_38_2 = (function()
		require("lfs")

		local var_39_0 = {}

		for iter_39_0 in lfs.dir("./src/data/leveldata") do
			if iter_39_0:find("monster_data") then
				local var_39_1, var_39_2 = pcall(require, string.format("data.leveldata.%s", iter_39_0:match("(.+).lua$")))

				if var_39_1 then
					table.merge(var_39_0, var_39_2)
				else
					return false, var_39_2
				end
			end
		end

		return true, var_39_0
	end)()

	if not var_38_1 then
		print(var_38_2)
		print("check model data fail...")

		return
	end

	local var_38_3 = {
		nullai = {},
		nullcfg = {},
		nullmodel = {},
		nullimage = {},
		nullcuterole = {},
		nullheadimg = {},
		nullexpression = {}
	}
	local var_38_4 = {
		"expression",
		"fanu",
		"kaixin",
		"haixiu",
		"aichou"
	}

	for iter_38_0, iter_38_1 in pairs(model_data) do
		if not file_exists("./src/fight/behavior/" .. iter_38_1.behavior .. ".lua") then
			table.insert(var_38_3.nullai, iter_38_1.id)
		end

		if not file_exists("./src/fight/spine/" .. iter_38_1.spinecfg .. ".lua") then
			table.insert(var_38_3.nullcfg, iter_38_1.id)
		end

		if iter_38_1.role_image then
			if not cc.FileUtils:getInstance():isFileExist("role/" .. iter_38_1.role_image .. ".png") then
				table.insert(var_38_3.nullimage, {
					model = iter_38_1.id,
					image = iter_38_1.role_image
				})
			end
		end

		if iter_38_1.cute_role then
			if not cc.FileUtils:getInstance():isFileExist("role1/" .. iter_38_1.cute_role .. ".png") then
				table.insert(var_38_3.nullcuterole, {
					model = iter_38_1.id,
					image = iter_38_1.cute_role
				})
			end
		end

		if iter_38_1.head_image then
			if not cc.FileUtils:getInstance():isFileExist("role/wuji/" .. iter_38_1.head_image .. ".png") then
				table.insert(var_38_3.nullheadimg, {
					model = iter_38_1.id,
					image = iter_38_1.head_image
				})
			end
		end

		for iter_38_2, iter_38_3 in pairs(var_38_4) do
			if iter_38_1[iter_38_3] then
				if not cc.FileUtils:getInstance():isFileExist("expression/" .. iter_38_1[iter_38_3] .. ".png") then
					table.insert(var_38_3.nullexpression, {
						model = iter_38_1.id,
						image = iter_38_1[iter_38_3]
					})
				end
			end
		end
	end

	for iter_38_4, iter_38_5 in pairs(var_38_2) do
		if not model_data[iter_38_5.modelid] then
			table.insert(var_38_3.nullmodel, {
				monsterid = iter_38_5.id,
				model = iter_38_5.modelid
			})
		end
	end

	for iter_38_6, iter_38_7 in pairs(var_38_3) do
		print(string.format("there are %d %s", #iter_38_7, iter_38_6))
	end

	local var_38_5 = io.open("result_model.lua", "w+")

	var_38_5:write((dump(var_38_3)))
	var_38_5:flush()
	var_38_5:close()
end

function CheckScene:checkConversationData()
	local model_data = require("data.model_data")
	local var_40_1 = {
		nullimage = {},
		nullmodel = {},
		nullexpression = {}
	}

	for iter_40_0, iter_40_1 in pairs((require("data.conversation_data"))) do
		if iter_40_1.icon then
			local var_40_2 = model_data[tonumber(iter_40_1.icon)]

			if not var_40_2 then
				table.insert(var_40_1.nullmodel, {
					conversation = iter_40_1.id,
					model = iter_40_1.icon
				})
			elseif not cc.FileUtils:getInstance():isFileExist("role/" .. var_40_2.role_image .. ".png") then
				table.insert(var_40_1.nullimage, {
					conversation = iter_40_1.id,
					image = var_40_2.role_image
				})
			end
		end

		if iter_40_1.expression then
			local var_40_3 = model_data[tonumber(iter_40_1.icon)]

			if not var_40_3 then
				-- block empty
			elseif var_40_3[iter_40_1.expression] then
				if not cc.FileUtils:getInstance():isFileExist("expression/" .. var_40_3[iter_40_1.expression] .. ".png") then
					table.insert(var_40_1.nullexpression, {
						model = iter_40_1.id,
						expression = iter_40_1.expression
					})
				end
			else
				table.insert(var_40_1.nullexpression, {
					model = iter_40_1.id,
					expression = iter_40_1.expression
				})
			end
		end
	end

	for iter_40_2, iter_40_3 in pairs(var_40_1) do
		print(string.format("there are %d %s", #iter_40_3, iter_40_2))
	end

	local var_40_4 = io.open("result_conversation.lua", "w+")

	var_40_4:write((dump(var_40_1)))
	var_40_4:flush()
	var_40_4:close()
end

function CheckScene:checkTravelData()
	local travel_route_data = require("data.travel_route_data")
	local travel_city_data = require("data.travel_city_data")
	local travel_event_weight_data = require("data.travel_event_weight_data")
	local travel_event_data = require("data.travel_event_data")
	local travel_conversation_data = require("data.travel_conversation_data")
	local postcard_data = require("data.postcard_data")
	local drop_data = require("data.drop_data")
	local var_41_7 = {
		noEventPool = {},
		noConversation = {},
		noPostcard = {},
		noDrop = {}
	}

	local function var_41_8(arg_42_0)
		local var_42_0 = {}
		local var_42_1 = {}

		while travel_route_data[arg_42_0]["travel_route" .. 1] do
			assert(travel_route_data[arg_42_0]["weight" .. 1], "soulid: " .. arg_42_0 .. "travel_routeid: " .. 1 .. "of weight is nil")

			for iter_42_0, iter_42_1 in string.gmatch(travel_route_data[arg_42_0]["travel_route" .. 1], "([^&]+)") do
				var_42_1[tonumber(iter_42_0)] = 1
			end
		end

		for iter_42_2, iter_42_3 in string.gmatch(travel_route_data[arg_42_0].first_travel_route, "([^&]+)") do
			var_42_1[tonumber(iter_42_2)] = 1
		end

		for iter_42_4, iter_42_5 in pairs(var_42_1) do
			table.insert(var_42_0, iter_42_4)
		end

		return var_42_0
	end

	for iter_41_0, iter_41_1 in pairs(travel_route_data) do
		for iter_41_2, iter_41_3 in pairs((var_41_8(iter_41_0))) do
			if not travel_city_data[iter_41_3]["event_class" .. iter_41_0] then
				table.insert(var_41_7.noEventPool, "soulid: " .. iter_41_0 .. " in City: " .. iter_41_3 .. " is no eventPoolId")
			else
				local var_41_9 = travel_event_weight_data[travel_city_data[iter_41_3]["event_class" .. iter_41_0]]
				local var_41_10 = 1

				while var_41_9["class" .. var_41_10] do
					assert(travel_event_data[var_41_9["class" .. var_41_10]], "event(id: " .. var_41_9["class" .. var_41_10] .. ") invalid")

					if not travel_conversation_data[tonumber(travel_event_data[var_41_9["class" .. var_41_10]].conversation .. "01")] then
						table.insert(var_41_7.noConversation, "event(id: " .. var_41_9["class" .. var_41_10] .. ") of conversation in travel_conversation_data is not exist")
					end

					if travel_event_data[var_41_9["class" .. var_41_10]].postcard and not postcard_data[travel_event_data[var_41_9["class" .. var_41_10]].postcard] then
						table.insert(var_41_7.noPostcard, "event have invalid postcardid:" .. travel_event_data[var_41_9["class" .. var_41_10]].postcard .. "in postcard_data")
					end

					if not travel_event_data[var_41_9["class" .. var_41_10]].dropid or not drop_data[travel_event_data[var_41_9["class" .. var_41_10]].dropid] then
						table.insert(var_41_7.noDrop, "event(id: " .. var_41_9["class" .. var_41_10] .. ") have invalid dropid:" .. ((not travel_event_data[var_41_9["class" .. var_41_10]].dropid or nil) and ""))
					end

					var_41_10 = var_41_10 + 1
				end
			end
		end
	end

	for iter_41_4, iter_41_5 in pairs((require("data.travel_photo_data"))) do
		if not postcard_data[iter_41_5.postcard_id] then
			table.insert(var_41_7.noPostcard, "photo have invalid postcardid:" .. iter_41_5.postcard_id .. "in postcard_data")
		end
	end

	for iter_41_6, iter_41_7 in pairs(var_41_7) do
		print(string.format("there are %d %s", #iter_41_7, iter_41_6))
	end

	local var_41_12 = io.open("result_travel.lua", "w+")

	var_41_12:write((dump(var_41_7)))
	var_41_12:flush()
	var_41_12:close()
end

function CheckScene:checkCookData()
	local var_43_0 = {
		noTasteWeight = {},
		noGuest = {}
	}
	local var_43_1 = {}

	for iter_43_0 = 1, 14 do
		var_43_1[iter_43_0] = require("data.food_production.menu.menu" .. iter_43_0 .. "_data")
	end

	for iter_43_1, iter_43_2 in pairs(var_43_1) do
		for iter_43_3, iter_43_4 in pairs(iter_43_2) do
			for iter_43_5 = 1, 23 do
				if iter_43_4["taste" .. iter_43_5] and not iter_43_4["taste" .. iter_43_5 .. "_weight"] then
					table.insert(var_43_0.noTasteWeight, "soulid: " .. iter_43_1 .. " menuid: " .. iter_43_3 .. " taste" .. iter_43_5 .. " of weight is nil")
				end

				if iter_43_3 % 100 == 1 and iter_43_4.guest then
					table.insert(var_43_0.noGuest, "soulid: " .. iter_43_1 .. " menuid: " .. iter_43_3 .. " shouldn't have guest")
				end
			end
		end
	end

	for iter_43_6, iter_43_7 in pairs(var_43_0) do
		print(string.format("there are %d %s", #iter_43_7, iter_43_6))
	end

	local var_43_5 = io.open("result_cook.lua", "w+")

	var_43_5:write((dump(var_43_0)))
	var_43_5:flush()
	var_43_5:close()
end

function CheckScene:checkRoleConversationData()
	local var_44_0 = {
		type_class = {},
		class_role = {},
		noDormDec = {}
	}
	local role_conversation_data = require("data.role_conversation_data")
	local conversation_class_data = require("data.conversation_class_data")

	for iter_44_0, iter_44_1 in pairs((require("data.conversation_type_data"))) do
		local var_44_3 = 1

		while iter_44_1["class" .. var_44_3] do
			if not conversation_class_data[iter_44_1["class" .. var_44_3]] then
				table.insert(var_44_0.type_class, "conversation_type_data: id(" .. iter_44_0 .. ") of class" .. var_44_3 .. " is not exist in conversation_class_data")
			else
				local var_44_4 = conversation_class_data[iter_44_1["class" .. var_44_3]]
				local var_44_5 = 1

				while var_44_4["conversation" .. var_44_5] do
					if not role_conversation_data[var_44_4["conversation" .. var_44_5]] then
						table.insert(var_44_0.class_role, "conversation_class_data : id(" .. iter_44_1["class" .. var_44_3] .. ") of conversation" .. var_44_5 .. " is not exist in role_conversation_data")
					else
						roleConversation = role_conversation_data[var_44_4["conversation" .. var_44_5]]

						if ({
							[16] = true,
							[13] = true,
							[14] = true
						})[roleConversation.class] and not roleConversation.dec then
							table.insert(var_44_0.noDormDec, "role_conversation_data : id(" .. var_44_4["conversation" .. var_44_5] .. ") is no dec")
						end
					end

					var_44_5 = var_44_5 + 1
				end
			end

			var_44_3 = var_44_3 + 1
		end
	end

	for iter_44_2, iter_44_3 in pairs(var_44_0) do
		print(string.format("there are %d %s", #iter_44_3, iter_44_2))
	end

	local var_44_6 = io.open("result_role_conversation.lua", "w+")

	var_44_6:write((dump(var_44_0)))
	var_44_6:flush()
	var_44_6:close()
end

function CheckScene:checkTwistDropRate()
	local drop_data = require("data.drop_data")
	local item_data = require("data.item_data")

	for iter_45_0, iter_45_1 in pairs({
		"data.weapon_data",
		"data.HelpGirl_data",
		"data.component_data",
		"data.food_production.pot.pot_data",
		"data.food_production.eatables.foodmaterials_data",
		"data.food_production.eatables.cooktable_data",
		"data.medal_data",
		"data.furniture_data",
		"data.lab_material_data"
	}) do
		local var_45_2, var_45_3 = pcall(require, iter_45_1)

		if var_45_2 then
			table.merge(item_data, var_45_3)
		else
			print(var_45_3)

			return
		end
	end

	local var_45_4 = {
		[10000] = 5
	}

	setmetatable(var_45_4, {
		__index = function(arg_46_0, arg_46_1)
			return 0
		end
	})

	local var_45_5 = {}
	local var_45_6 = {}

	local function var_45_7(arg_47_0, arg_47_1)
		local var_47_0 = 1
		local var_47_1 = 0

		while drop_data[arg_47_0]["rd_drop_id" .. var_47_0] do
			var_47_1 = var_47_1 + drop_data[arg_47_0]["rd_drop_weight" .. var_47_0] + var_45_4[drop_data[arg_47_0]["rd_drop_id" .. var_47_0]]
			var_47_0 = var_47_0 + 1
		end

		local var_47_2 = 1

		while drop_data[arg_47_0]["rd_drop_id" .. var_47_2] do
			if (drop_data[arg_47_0]["rd_drop_weight" .. var_47_2] + var_45_4[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]]) / var_47_1 > 0 then
				var_45_5[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]] = (var_45_5[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]] or 0) + (drop_data[arg_47_0]["rd_drop_weight" .. var_47_2] + var_45_4[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]]) / var_47_1 * arg_47_1
				var_45_6[item_data[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]].bag_item_type] = (var_45_6[item_data[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]].bag_item_type] or 0) + (drop_data[arg_47_0]["rd_drop_weight" .. var_47_2] + var_45_4[drop_data[arg_47_0]["rd_drop_id" .. var_47_2]]) / var_47_1 * arg_47_1
			end

			var_47_2 = var_47_2 + 1
		end
	end

	;(function(arg_48_0)
		local var_48_0 = 1
		local var_48_1 = 0

		while drop_data[arg_48_0]["rd_dropmodel_id" .. var_48_0] do
			var_48_1 = var_48_1 + drop_data[arg_48_0]["rd_dropmodel_rate" .. var_48_0]
			var_48_0 = var_48_0 + 1
		end

		local var_48_2 = 1

		while drop_data[arg_48_0]["rd_dropmodel_id" .. var_48_2] do
			if drop_data[arg_48_0]["rd_dropmodel_rate" .. var_48_2] / var_48_1 > 0 then
				var_45_7(drop_data[arg_48_0]["rd_dropmodel_id" .. var_48_2], drop_data[arg_48_0]["rd_dropmodel_rate" .. var_48_2] / var_48_1)
			end

			var_48_2 = var_48_2 + 1
		end
	end)(172001)

	local var_45_8 = {
		itemresult = {},
		itemtyperesult = {}
	}

	print("drop item rate result: ")

	for iter_45_2, iter_45_3 in pairs(var_45_5) do
		local var_45_9 = string.format("drop item %d rate is %.2f%%", iter_45_2, iter_45_3 * 100)

		table.insert(var_45_8.itemresult, var_45_9)
		print(var_45_9)
	end

	print("drop itemtype rate result: ")

	for iter_45_4, iter_45_5 in pairs(var_45_6) do
		local var_45_10 = string.format("drop itemtype %d rate is %.2f%%", iter_45_4, iter_45_5 * 100)

		table.insert(var_45_8.itemtyperesult, var_45_10)
		print(var_45_10)
	end

	local var_45_11 = io.open("result_twistratecheck.lua", "w+")

	var_45_11:write(dump(var_45_8))
	var_45_11:flush()
	var_45_11:close()
end

function CheckScene:checkPlotData()
	local plot_data = require("data.plot_data")
	local plot_index_data = require("data.plot_index_data")
	local conversation_data = require("data.conversation_data")
	local explore_aim_data = require("data.explore.explore_aim_data")
	local drop_data = require("data.drop_data")
	local model_data = require("data.model_data")
	local var_49_6 = {
		plotClassData = {},
		plotData = {}
	}

	for iter_49_0, iter_49_1 in pairs((require("data.plot_class_data"))) do
		for iter_49_2 = 1, iter_49_1.total_steps do
			local var_49_7 = iter_49_1["step" .. iter_49_2]

			if not iter_49_1["step" .. iter_49_2] then
				table.insert(var_49_6.plotClassData, (string.format("in plotClassData plotClassId %d total_steps is %d, but not have step%d", iter_49_0, iter_49_1.total_steps, iter_49_2)))
			elseif not plot_data[var_49_7] then
				table.insert(var_49_6.plotClassData, (string.format("in plotClassData plotClassId %d, have invalid plotid:%d", iter_49_0, var_49_7)))
			else
				local var_49_8 = plot_data[var_49_7]

				if plot_data[var_49_7].finish_condition == 1 then
					if not conversation_data[var_49_8.finish_param1 * 100 + 1] then
						table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid conversation classification: %d", var_49_7, var_49_8.finish_param1)))
					end
				elseif var_49_8.finish_condition == 2 then
					if not explore_aim_data[var_49_8.finish_param1] then
						table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid explore_aim_id: %d", var_49_7, var_49_8.finish_param1)))
					end
				elseif var_49_8.finish_condition == 3 then
					if not conversation_data[var_49_8.finish_param3 * 100 + 1] then
						table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid conversation classification: %d", var_49_7, var_49_8.finish_param3)))
					end

					if not conversation_data[var_49_8.finish_param4 * 100 + 1] then
						table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid conversation classification: %d", var_49_7, var_49_8.finish_param4)))
					end
				end

				if var_49_8.finish_drop and not drop_data[var_49_8.finish_drop] then
					table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid dropId: %s", var_49_7, var_49_8.finish_drop)))
				end

				if var_49_8.npc and not model_data[var_49_8.npc] then
					table.insert(var_49_6.plotData, (string.format("in PlotData potId %d, have invalid modelid: %d", var_49_7, var_49_8.npc)))
				end
			end
		end
	end

	local var_49_11 = io.open("result_plotcheck.lua", "w+")

	var_49_11:write(dump(var_49_6))
	var_49_11:flush()
	var_49_11:close()
	print("check finish!!!")
end

function CheckScene:checkExplolreData()
	local var_50_0 = 10
	local var_50_1 = {
		error_shapeindex = {},
		missImgs = {},
		invalidTiles = {},
		invalidRooms = {},
		invalidDropid = {},
		invalidItemid = {}
	}
	local var_50_2, var_50_3 = pcall(require, "data.item_data")

	if not var_50_2 then
		print(var_50_3)

		return
	end

	for iter_50_0, iter_50_1 in pairs({
		"data.weapon_data",
		"data.component_data",
		"data.food_production.pot.pot_data",
		"data.food_production.eatables.foodmaterials_data",
		"data.food_production.eatables.cooktable_data",
		"data.medal_data",
		"data.furniture_data",
		"data.lab_material_data"
	}) do
		local var_50_4, var_50_5 = pcall(require, iter_50_1)

		if var_50_4 then
			table.merge(var_50_3, var_50_5)
		else
			print(var_50_5)

			return
		end
	end

	local drop_data = require("data.drop_data")
	local drop_manager = require("controller.drop_manager")

	local function var_50_8(arg_51_0, arg_51_1)
		if drop_data[arg_51_0] then
			for iter_51_0, iter_51_1 in pairs((drop_manager:getEquipDrops(arg_51_0))) do
				if not var_50_3[iter_51_1.dropid] then
					table.insert(var_50_1.invalidItemid, "invalid itemid: " .. iter_51_1.dropid)
				end
			end

			for iter_51_2, iter_51_3 in pairs((drop_manager:getAllModelDropIds(arg_51_0))) do
				if drop_data[iter_51_3] then
					for iter_51_4, iter_51_5 in pairs((drop_manager:getEquipDrops(iter_51_3))) do
						if not var_50_3[iter_51_5.dropid] then
							var_50_1.invalidItemid[iter_51_5.dropid] = "invalid itemid: " .. iter_51_5.dropid
						end
					end
				else
					var_50_1.invalidDropid[iter_51_3] = "invalid dropiod: " .. iter_51_3 .. " in dropData"
				end
			end
		else
			var_50_1.invalidDropid[arg_51_0] = "invalid dropiod: " .. arg_51_0 .. "in tile_data" .. arg_51_1
		end
	end

	for iter_50_2, iter_50_3 in pairs((require("data.explore.explore_map_config_data"))) do
		local var_50_9 = require("data.explore.map_data" .. iter_50_2)
		local var_50_10 = require("data.explore.room_data" .. iter_50_2)
		local var_50_11 = require("data.explore.tile_data" .. iter_50_2)
		local var_50_12 = require("data.explore.room_tile_data" .. iter_50_2)
		local var_50_13 = require("data.explore.plot_map_data" .. iter_50_2)
		local var_50_14 = require("data.explore.explore_level_data" .. iter_50_2)
		local var_50_15 = require("data.explore.explore_monster_team_data" .. iter_50_2)
		local var_50_16 = require("data.explore.explore_monster_data" .. iter_50_2)
		local var_50_17 = {}

		local function var_50_18(arg_52_0)
			local var_52_0 = {}

			for iter_52_0 = 1, 9 do
				assert(arg_52_0["room" .. iter_52_0], "map_data" .. iter_50_2 .. " no room" .. iter_52_0)

				for iter_52_1, iter_52_2 in string.gmatch(arg_52_0["room" .. iter_52_0], "([^,]+)") do
					local var_52_1 = tonumber(iter_52_1)

					var_52_0[var_52_1] = true

					if var_50_10[var_52_1] and var_50_10[var_52_1].match_room then
						var_52_0[var_50_10[var_52_1].match_room] = true
					end
				end

				if iter_52_0 == 1 or iter_52_0 == 3 or iter_52_0 == 7 or iter_52_0 == 9 then
					for iter_52_3, iter_52_4 in string.gmatch(arg_52_0["exit" .. iter_52_0], "([^,]+)") do
						local var_52_2 = tonumber(iter_52_3)

						var_52_0[var_52_2] = true

						if var_50_10[var_52_2] and var_50_10[var_52_2].match_room then
							var_52_0[var_50_10[var_52_2].match_room] = true
						end
					end
				end
			end

			return var_52_0
		end

		for iter_50_4, iter_50_5 in pairs(var_50_9) do
			local var_50_19 = {}

			if not iter_50_5.plot_map_size then
				print(iter_50_2, iter_50_4)

				for iter_50_6, iter_50_7 in pairs((var_50_18(iter_50_5))) do
					if var_50_10[iter_50_6] then
						assert(var_50_10[iter_50_6], "invalid roomid: " .. iter_50_6 .. " in map_data" .. iter_50_2)

						local var_50_21 = var_50_10[iter_50_6]
						local var_50_22 = (var_50_10[iter_50_6].shape_index - 1) % 200 + 1
						local var_50_23 = math.floor((var_50_10[iter_50_6].shape_index - 1) / 200) + 1

						if ((var_50_10[iter_50_6].shape_index - 1) % 200 + 1 - 1) % var_50_0 == 0 then
							if (var_50_23 - 1) % var_50_0 ~= 0 then
								table.insert(var_50_1.error_shapeindex, (string.format("error shapeindex:%d in room_data%d key = %d", var_50_10[iter_50_6].shape_index, iter_50_2, iter_50_6)))
							end
						end

						for iter_50_8 = var_50_23, var_50_23 + var_50_0 - 1 do
							for iter_50_9 = var_50_22, var_50_22 + var_50_0 - 1 do
								assert(var_50_12[iter_50_8]["x_" .. iter_50_9], "in room_tile_data" .. iter_50_2 .. " (x = " .. iter_50_9 .. ",y=" .. iter_50_8 .. ") is nil")

								if not var_50_11[var_50_12[iter_50_8]["x_" .. iter_50_9]] then
									table.insert(var_50_1.invalidTiles, "invalid tileid:" .. var_50_12[iter_50_8]["x_" .. iter_50_9] .. ", in room_tile_data" .. iter_50_2 .. " (x:" .. iter_50_9 .. ", y:" .. iter_50_8 .. ")")
								end

								var_50_19[var_50_12[iter_50_8]["x_" .. iter_50_9]] = true
							end
						end

						local var_50_24 = math.floor((var_50_21.bg_shape_index - 1) / 200) + 1

						for iter_50_10 = var_50_24, var_50_24 + var_50_0 - 1 do
							for iter_50_11 = (var_50_21.bg_shape_index - 1) % 200 + 1, (var_50_21.bg_shape_index - 1) % 200 + 1 + var_50_0 - 1 do
								assert(var_50_12[iter_50_10]["x_" .. iter_50_11], "in room_tile_data" .. iter_50_2 .. " (x = " .. iter_50_11 .. ",y=" .. iter_50_10 .. ") is nil")

								var_50_17[var_50_12[iter_50_10]["x_" .. iter_50_11]] = true
							end
						end
					else
						table.insert(var_50_1.error_shapeindex, "invalid roomid: " .. iter_50_6 .. " in map_data" .. iter_50_2)
					end
				end
			else
				local var_50_25 = string.split(var_50_9[iter_50_4].plot_map_size, ",")
				local var_50_26 = math.floor((var_50_9[iter_50_4].shape_index - 1) / 200) + 1

				for iter_50_12 = (var_50_9[iter_50_4].shape_index - 1) % 200 + 1, (var_50_9[iter_50_4].shape_index - 1) % 200 + 1 + var_50_25[1] - 1 do
					for iter_50_13 = var_50_26, var_50_26 + var_50_25[2] - 1 do
						assert(var_50_13[iter_50_13]["x_" .. iter_50_12], iter_50_12 .. " " .. iter_50_13)
						assert(var_50_11[var_50_13[iter_50_13]["x_" .. iter_50_12]], "mapfloor:" .. iter_50_4 .. "plot_map_data:" .. var_50_13[iter_50_13]["x_" .. iter_50_12] .. " is invalid x:" .. iter_50_12 .. "y:" .. iter_50_13 .. " init_x:" .. (var_50_9[iter_50_4].shape_index - 1) % 200 + 1 .. " init_y:" .. var_50_26 .. " width:" .. var_50_25[1] .. " height" .. var_50_25[2])

						var_50_19[var_50_13[iter_50_13]["x_" .. iter_50_12]] = true
					end
				end
			end

			for iter_50_14, iter_50_15 in pairs(var_50_19) do
				local var_50_27 = 1

				while var_50_11[iter_50_14]["result" .. var_50_27 .. "_type"] do
					if var_50_11[iter_50_14]["result" .. var_50_27 .. "_type"] == 3 then
						var_50_8(var_50_11[iter_50_14]["result" .. var_50_27 .. "_param"], iter_50_2)
					elseif var_50_11[iter_50_14]["result" .. var_50_27 .. "_type"] == 7 then
						if not var_50_3[var_50_11[iter_50_14]["result" .. var_50_27 .. "_param"]] then
							var_50_1.invalidItemid[var_50_11[iter_50_14]["result" .. var_50_27 .. "_param"]] = "invalid itemid: " .. var_50_11[iter_50_14]["result" .. var_50_27 .. "_param"]
						end
					elseif var_50_11[iter_50_14]["result" .. var_50_27 .. "_type"] == 4 then
						var_50_8(var_50_14[var_50_11[iter_50_14]["result" .. var_50_27 .. "_param"]].equip_drop, iter_50_2)
					end

					var_50_27 = var_50_27 + 1
				end
			end
		end
	end

	local var_50_28 = io.open("result_exploredatacheck.lua", "w+")

	var_50_28:write(dump(var_50_1))
	var_50_28:flush()
	var_50_28:close()
	print("check finish!!!")
end

function CheckScene:checkItemServant()
	local item_data = require("data.item_data")
	local servant_data = require("data.servant_data")

	for iter_53_0, iter_53_1 in pairs({
		"data.weapon_data",
		"data.component_data",
		"data.food_production.pot.pot_data",
		"data.food_production.eatables.foodmaterials_data",
		"data.food_production.eatables.cooktable_data",
		"data.medal_data",
		"data.furniture_data"
	}) do
		local var_53_2, var_53_3 = pcall(require, iter_53_1)

		if var_53_2 then
			table.merge(item_data, var_53_3)
		else
			print(var_53_3)

			return
		end
	end

	for iter_53_2, iter_53_3 in pairs(item_data) do
		if iter_53_3.bag_item_type == 13 then
			if not iter_53_3.servant then
				print("itemid: " .. iter_53_3.id .. " no servant")
			elseif not servant_data[iter_53_3.servant] then
				print("itemid: " .. iter_53_3.id .. " invalid servantid" .. iter_53_3.servant)
			end
		end
	end
end

function CheckScene:explore_gen_tile_data()
	require("lfs")

	local json = require("json")
	local explore_map_config_data = require("data.explore.explore_map_config_data")

	local function var_54_2(arg_55_0, arg_55_1)
		local var_55_0 = require("res/tile/tileconfig/city_config" .. arg_55_0 .. "/" .. arg_55_1 .. ".lua")
		local var_55_1 = {}

		;(function()
			for iter_56_0, iter_56_1 in ipairs(var_55_0.tilesets) do
				local var_56_0 = string.match(iter_56_1.image, "tilesets/(%w+)")
				local var_56_1 = io.open("./res/tile/tileconfig/tilesets/" .. var_56_0 .. ".json", "rb")

				if not var_56_1 then
					print(L_NO_IMAGE .. ".../tilesets/" .. var_56_0 .. ".json")

					return
				end

				local var_56_2 = json.decode((var_56_1:read("*a")))

				var_56_1:close()

				for iter_56_2, iter_56_3 in pairs(var_56_2.skins.default) do
					var_55_1[0 + ((iter_56_1.imageheight - iter_56_3[iter_56_2].y + iter_56_3[iter_56_2].height / 2) / iter_56_3[iter_56_2].height - 1) * (iter_56_1.imagewidth / iter_56_1.tilewidth) + (iter_56_3[iter_56_2].x + iter_56_3[iter_56_2].width / 2) / iter_56_3[iter_56_2].width] = tonumber(iter_56_2)
				end
			end
		end)()
		;(function()
			local var_57_0 = {}
			local var_57_1 = {}

			for iter_57_0, iter_57_1 in ipairs(var_55_0.layers) do
				if iter_57_1.type == "tilelayer" then
					for iter_57_2, iter_57_3 in ipairs(iter_57_1.data) do
						if iter_57_3 ~= 0 then
							if not var_57_0[101 - iter_57_2] then
								var_57_0[101 - iter_57_2] = {
									var_55_1[iter_57_3]
								}
							else
								table.insert(var_57_0[101 - iter_57_2], var_55_1[iter_57_3])
							end
						end
					end
				elseif iter_57_1.type == "objectgroup" then
					for iter_57_4, iter_57_5 in ipairs(iter_57_1.objects) do
						var_57_1[(math.ceil((1000 - iter_57_5.y) / 100) - 1) * 10 + math.ceil(iter_57_5.x / 100)] = tonumber(iter_57_5.name)
					end
				end
			end
		end)()
	end

	;(function()
		for iter_58_0, iter_58_1 in pairs(explore_map_config_data) do
			for iter_58_2 in lfs.dir("res/tile/tileconfig/city_config" .. iter_58_0) do
				if string.find(iter_58_2, ".lua") then
					var_54_2(iter_58_0, tonumber(string.match(iter_58_2, "%d+")))
				end
			end
		end
	end)()
end

function CheckScene:checkRandomPlotPool()
	local plot_class_data = require("data.plot_class_data")
	local random_plot_data = require("data.random_plot_data")
	local showgirl_plot_data = require("data.showgirl_plot_data")
	local patrol_plot_data = require("data.patrol_plot_data")
	local event_data = require("data.event_data")
	local patrol_event_data = require("data.patrol_event_data")
	local hangup_event_data = require("data.hangup_event_data")
	local var_59_7 = {
		weight = {},
		invalid_id = {}
	}

	;(function()
		for iter_60_0, iter_60_1 in pairs(random_plot_data) do
			while iter_60_1["plot" .. 1] do
				print(string.format("random_plot_data id: %d, count: %d", iter_60_0, 1))

				if not iter_60_1["plot" .. 1 .. "_weight"] then
					table.insert(var_59_7.weight, (string.format("in random_plot_data id: %d, count: %d, have no weight", iter_60_0, 1)))
				end

				if not plot_class_data[iter_60_1["plot" .. 1]] then
					table.insert(var_59_7.invalid_id, (string.format("in random_plot_data id: %d, count: %d, have invalid plot id:%d", iter_60_0, 1, iter_60_1["plot" .. 1])))
				end
			end
		end
	end)()
	;(function()
		for iter_61_0, iter_61_1 in pairs(showgirl_plot_data) do
			for iter_61_2 = 1, 3 do
				while iter_61_1["class" .. iter_61_2 .. "_plot" .. 1] do
					print(string.format("showgirl_plot_data id: %d, class: %d, count: %d", iter_61_0, iter_61_2, 1))

					if not iter_61_1["class" .. iter_61_2 .. "_plot" .. 1 .. "_weight"] then
						table.insert(var_59_7.weight, (string.format("in showgirl_plot_data id: %d, class: %d, count: %d. no weight", iter_61_0, iter_61_2, 1)))
					end

					if not plot_class_data[iter_61_1["class" .. iter_61_2 .. "_plot" .. 1]] then
						table.insert(var_59_7.invalid_id, (string.format("in showgirl_plot_data id: %d, class: %d, count: %d. invalid plot id: %d", iter_61_0, iter_61_2, 1, iter_61_1["class" .. iter_61_2 .. "_plot" .. 1])))
					end
				end
			end
		end
	end)()
	;(function()
		for iter_63_0, iter_63_1 in pairs(patrol_plot_data) do
			for iter_63_2 = 1, 3 do
				while iter_63_1["class" .. iter_63_2 .. "_plot" .. 1] do
					print(string.format("in patrol_plot_data, id: %d, class: %d, count: %d", iter_63_0, iter_63_2, 1))

					if not iter_63_1["class" .. iter_63_2 .. "_plot" .. 1 .. "_weight"] then
						table.insert(var_59_7.weight, (string.format("in patrol_plot_data, id: %d, class: %d, count: %d, no weight", iter_63_0, iter_63_2, 1)))
					end

					if not plot_class_data[iter_63_1["class" .. iter_63_2 .. "_plot" .. 1]] then
						table.insert(var_59_7.invalid_id, (string.format("in patrol_plot_data, id: %d, class: %d, count: %d, invalid plot id: %d", iter_63_0, iter_63_2, 1, iter_63_1["class" .. iter_63_2 .. "_plot" .. 1])))
					end
				end
			end
		end
	end)()
	;(function()
		for iter_64_0, iter_64_1 in pairs(patrol_event_data) do
			for iter_64_2 = 1, 3 do
				while iter_64_1["class" .. iter_64_2 .. "_event" .. 1] do
					print(string.format("in patrol_event_data id: %d, class: %d, count: %d", iter_64_0, iter_64_2, 1))

					if not iter_64_1["class" .. iter_64_2 .. "_event" .. 1 .. "_weight"] then
						table.insert(var_59_7.weight, (string.format("in patrol_event_data id: %d, class: %d, count: %d, no weight", iter_64_0, iter_64_2, 1)))
					end

					if not event_data[iter_64_1["class" .. iter_64_2 .. "_event" .. 1]] then
						table.insert(var_59_7.invalid_id, (string.format("in patrol_event_data id: %d, class: %d, count: %d, invalid event id: %d", iter_64_0, iter_64_2, 1, iter_64_1["class" .. iter_64_2 .. "_event" .. 1])))
					end
				end
			end
		end
	end)()
	;(function()
		for iter_65_0, iter_65_1 in pairs(hangup_event_data) do
			while iter_65_1["event" .. 1] do
				print(string.format("in hangup_event_data id: %d, count: %d", iter_65_0, 1))

				if not iter_65_1["event" .. 1 .. "_weight"] then
					table.insert(var_59_7.weight, (string.format("in hangup_event_data id: %d, count: %d, no weight", iter_65_0, 1)))
				end

				if not event_data[iter_65_1["event" .. 1]] then
					local var_65_0 = string.format("in hangup_event_data id: %d, count: %d, invalid event id: %d", iter_65_0, 1, iter_65_1["event" .. 1])

					table.insert(var_59_7.invalid_id)
				end
			end
		end
	end)()

	local var_59_9 = io.open("result_randomPlotCheck.lua", "w+")

	var_59_9:write(dump(var_59_7))
	var_59_9:flush()
	var_59_9:close()
	print("check finish!!!")
end

return CheckScene
