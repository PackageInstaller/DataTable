function global_CalculatePower()
	return 0
end

function global_CalculateCoreAddition()
	return
end

function global_CalculateMajorAddition(arg_3_0, arg_3_1)
	return
end

function global_riseWord(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	arg_4_2 = arg_4_2 or 0
	arg_4_3 = arg_4_3 or 0
	arg_4_5 = arg_4_5 or 3
	arg_4_6 = arg_4_6 or 1
	arg_4_7 = arg_4_7 or 32

	local var_4_0 = ""
	local var_4_1

	if type(arg_4_0) == "string" then
		var_4_0 = arg_4_0
	else
		var_4_0 = arg_4_0.text
		var_4_1 = arg_4_0.sp
	end

	local var_4_2 = cc.Label:createWithTTF(var_4_0, "fonts/new1.ttf", arg_4_7)

	var_4_2:setAnchorPoint(({
		cc.p(0.5, 0.5),
		cc.p(0, 0.5),
		cc.p(1, 0.5)
	})[arg_4_6])

	if arg_4_4 then
		var_4_2:setPosition(arg_4_4.x, arg_4_4.y + arg_4_2)
	else
		var_4_2:setPosition(SCREEN_WIDTH / 2, GameDisplay.height / 2 + arg_4_2)
	end

	var_4_2:setColor(arg_4_1 or RISE_WORDS_WARNING)
	var_4_2:enableOutline(RISE_WORDS_OUTLINE, 2)

	local var_4_3 = cc.Director:getInstance():getRunningScene()

	var_4_3:addChild(var_4_2, 10000)

	if var_4_1 then
		local var_4_4, var_4_5 = var_4_2:getPosition()

		if arg_4_6 == 1 then
			var_4_1:setPosition(cc.p(var_4_4 - var_4_2:getContentSize().width / 2 - var_4_1:getContentSize().width * var_4_1:getScaleX() / 2, var_4_5))
		elseif arg_4_6 == 2 then
			var_4_1:setPosition(cc.p(var_4_4 - var_4_1:getContentSize().width * var_4_1:getScaleX() / 2, var_4_5))
		elseif arg_4_6 == 3 then
			var_4_1:setPosition(cc.p(var_4_4 - var_4_2:getContentSize().width - var_4_1:getContentSize().width * var_4_1:getScaleX() / 2, var_4_5))
		end

		var_4_3:addChild(var_4_1, 10000)
	end

	var_4_3:runAction(cc.Sequence:create(cc.DelayTime:create(arg_4_3), cc.CallFunc:create(function()
		var_4_2:runAction(cc.FadeTo:create(arg_4_5, 0))

		if var_4_1 then
			var_4_1:runAction(cc.FadeTo:create(arg_4_5, 0))
			var_4_1:runAction(cc.MoveBy:create(arg_4_5, cc.p(0, 200)))
		end

		var_4_2:runAction(cc.Sequence:create(cc.MoveBy:create(arg_4_5, cc.p(0, 200)), cc.CallFunc:create(function()
			var_4_2:removeFromParent()

			if var_4_1 then
				var_4_1:removeFromParent()
				var_4_1:release()
			end
		end)))
	end)))
end

function global_runHorseLight(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	arg_7_1 = arg_7_1 or cc.c3b(0, 0, 0)
	var_7_0 = type(arg_7_0) == "string" and arg_7_0 or arg_7_0.text

	local var_7_1 = cc.Director:getInstance():getRunningScene()

	if var_7_1:getChildByName("alert_node") then
		var_7_1:getChildByName("alert_node"):getChildByName("label"):setString(var_7_0)

		return
	end

	local var_7_2 = ccui.Layout:create()

	var_7_2:setName("alert_node")
	var_7_2:setContentSize(cc.p(600, 60))
	var_7_2:setPosition(640, GameDisplay.height * 0.85 - GameDisplay.fix_y)
	var_7_1:addChild(var_7_2, 10000)

	local var_7_3 = RUN_HOURSE_LIGHT_PATH[arg_7_2] or RUN_HOURSE_LIGHT_PATH.off_line
	local var_7_4 = ccui.ImageView:create(var_7_3[1], config._DEBUG and 0 or 1)

	var_7_4:setAnchorPoint(cc.p(0, 0.5))
	var_7_4:setPosition(cc.p(0, 0))
	var_7_2:addChild(var_7_4)

	local var_7_5 = cc.Label:createWithTTF(var_7_0, "fonts/new1.ttf", 18)
	local var_7_6 = (var_7_5:getContentSize().width + 80) / var_7_4:getContentSize().width

	var_7_5:setColor(arg_7_1)
	var_7_5:setName("label")
	var_7_5:setAnchorPoint(cc.p(0, 0.5))
	var_7_5:setPosition(cc.p(55, var_7_2:getContentSize().height / 2))
	var_7_4:setScaleX(var_7_6)
	var_7_2:addChild(var_7_5)

	local var_7_7 = ccui.ImageView:create(var_7_3[2], config._DEBUG and 0 or 1)

	var_7_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_7_7:setPosition(cc.p(0, var_7_2:getContentSize().height / 2))
	var_7_2:addChild(var_7_7)
	var_7_2:runAction(cc.Sequence:create(cc.MoveTo:create(6, cc.p(-var_7_4:getContentSize().width * var_7_6, var_7_2:getPositionY())), cc.RemoveSelf:create()))
end

function global_offlineAlert(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = string.match(arg_8_0, "^<(.*)>(.+)")

	if var_8_0 == "newyear" then
		global_show_count_down(tonumber(var_8_1))
	else
		global_runHorseLight(arg_8_0, arg_8_1, "off_line")
	end
end

function global_show_count_down(arg_9_0)
	if not global_basic_scene then
		return
	end

	if not arg_9_0 then
		return
	end

	if arg_9_0 < 0 then
		arg_9_0 = 0
	end

	local var_9_0 = global_basic_scene:getChildByName("count_down_bg")

	if not var_9_0 then
		var_9_0 = ccui.ImageView:create("mainScenebg/new_year_count_down/bg.png")

		var_9_0:setName("count_down_bg")
		var_9_0:setPosition(GameDisplay.width / 2, GameDisplay:getScreenSize().height / 2)
		global_basic_scene:addChild(var_9_0, 10000)
	end

	local var_9_1 = var_9_0:getChildByName("count_down_img")

	if not var_9_1 then
		var_9_1 = ccui.ImageView:create("mainScenebg/new_year_count_down/" .. arg_9_0 .. ".png")

		var_9_1:setName("count_down_img")
		var_9_1:setPosition(320, var_9_0:getContentSize().height / 2)
		var_9_0:addChild(var_9_1, 2)
	else
		var_9_1:stopAllActions()
		var_9_1:loadTexture("mainScenebg/new_year_count_down/" .. arg_9_0 .. ".png")
	end

	var_9_1:setScale(1)

	if arg_9_0 > 0 then
		var_9_1:runAction(cc.Sequence:create(cc.ScaleTo:create(1, 0.2, 0.2)))
	else
		var_9_1:setScale(0.2)
		var_9_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
		var_9_0:setTouchEnabled(true)

		local audio_manager = require("controller.audio_manager")

		audio_manager:playeffectMusic("sound/newyearboom", true)

		local var_9_3 = L2Skeleton:create("spine/ui/yuandanlihua.json", "spine/ui/yuandanlihua.atlas", nil, true)

		var_9_3:refreshSkeleton()
		var_9_3:setPosition(cc.p(var_9_1:getPositionX(), var_9_1:getPositionY() - 300))
		var_9_0:addChild(var_9_3, 1)
		var_9_3:play("yuandanlihua")
		var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			audio_manager:stopAllEffects()
			var_9_0:runAction(cc.RemoveSelf:create())
		end)
	end
end

function global_riseSuccess(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	global_riseWord(arg_11_0, arg_11_1 or RISE_WORDS_SUCCESS, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
end

function global_riseWords(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = -110
	local var_12_1 = arg_12_1 or RISE_WORDS_SUCCESS
	local var_12_4 = cc.Director:getInstance():getRunningScene()

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		var_12_4:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			global_riseWord(iter_12_1, var_12_1, var_12_0, 0, arg_12_2, arg_12_3)
		end)))

		var_12_0 = var_12_0 - 5
	end
end

function global_ShowBlockWords(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if not require("common.Utility"):blockEvents() then
		return
	end

	local var_14_1 = arg_14_1 or RISE_WORDS_WARNING
	local var_14_2 = arg_14_3 or 2

	if not arg_14_4 then
		::label_14_0::

		local var_14_3 = 0.6
		local var_14_4 = cc.Director:getInstance():getRunningScene()
	end

	global_ShowWord(arg_14_0, var_14_1, nil, 0, arg_14_2 or cc.p(SCREEN_WIDTH / 2, GameDisplay.height / 2 + 40), var_14_2, align, arg_14_5)
end

function global_ShowWord(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	local var_15_0 = {
		cc.p(0.5, 0.5),
		cc.p(0, 0.5),
		cc.p(1, 0.5)
	}

	arg_15_2 = arg_15_2 or 250
	arg_15_3 = arg_15_3 or 0
	arg_15_5 = arg_15_5 or 2
	arg_15_6 = arg_15_6 or 1

	local var_15_1 = ""
	local var_15_2

	if type(arg_15_0) == "string" then
		var_15_1 = arg_15_0
	elseif type(arg_15_0) == "number" then
		var_15_1 = tostring(arg_15_0)
	else
		var_15_1 = arg_15_0.text
		var_15_2 = arg_15_0.sp
	end

	local var_15_3 = cc.Director:getInstance():getRunningScene()
	local var_15_4

	if var_15_3:getChildByName("global_blockword") then
		var_15_4 = var_15_3:getChildByName("global_blockword")

		var_15_4:setScale(1)
		var_15_4:setOpacity(255)
		var_15_4:removeAllChildren()
	else
		var_15_4 = ccui.Layout:create()
	end

	boxtime = type(arg_15_0) == "table" and table.getn(arg_15_0) or 1
	boxheight = 38 * boxtime + 20

	local var_15_5

	if config._DEBUG then
		var_15_5 = cc.Scale9Sprite:create("public/panelbg/whitebg.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/whitebg.png")
	end

	var_15_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_5:setPosition(320, boxheight / 2)
	var_15_5:setCapInsets(cc.rect(100, 50, 400, 20))
	var_15_4:setPosition(arg_15_4)
	var_15_4:ignoreAnchorPointForPosition(false)
	var_15_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_4:addChild(var_15_5)

	if boxheight < 103 then
		boxheight = 103
	end

	var_15_4:setContentSize(cc.size(640, boxheight))
	var_15_5:setPreferredSize(cc.size(640, boxheight))
	var_15_5:runAction(cc.ScaleTo:create(0.1, 1, 1))
	var_15_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		if type(arg_15_0) == "table" then
			labels = {}

			for iter_16_0, iter_16_1 in pairs(arg_15_0) do
				labels[iter_16_0] = cc.Label:createWithTTF(iter_16_1, FONT_NAME, 30)

				labels[iter_16_0]:setAnchorPoint(cc.p(0.5, 0.5))

				if arg_15_1 ~= nil and type(arg_15_1[iter_16_0]) == "table" then
					labels[iter_16_0]:setColor(arg_15_1[iter_16_0])
				else
					labels[iter_16_0]:setColor(arg_15_1)
				end

				var_15_4:addChild(labels[iter_16_0])

				local var_16_0 = labels[iter_16_0]:getContentSize().width
			end

			for iter_16_2 = 1, #labels + 1 - 1 do
				if #labels == 1 then
					labels[iter_16_2]:setPosition(cc.p(320, 30))
				else
					labels[iter_16_2]:setPosition(cc.p(320, boxheight * iter_16_2 / (#labels + 1)))
				end
			end
		else
			label = cc.Label:createWithTTF(var_15_1, FONT_TITLE, 32)

			if arg_15_7 then
				label = cc.Label:createWithTTF(var_15_1, FONT_TITLE, arg_15_7)
			end

			label:setAnchorPoint(cc.p(0.5, 0.5))
			label:setPosition(320, 30)

			if arg_15_1 ~= nil then
				label:setColor(arg_15_1)
			end

			var_15_4:addChild(label)

			local var_16_2 = label:getContentSize().width
		end
	end)))

	local var_15_6 = cc.Spawn:create(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeTo:create(arg_15_5 - 0.5, 50)), cc.Sequence:create(cc.DelayTime:create(arg_15_5 - 0.5), cc.ScaleTo:create(0.1, 1, 0)))

	var_15_6:setTag(1)

	local var_15_7 = cc.Sequence:create(cc.DelayTime:create(arg_15_5), cc.CallFunc:create(function()
		if var_15_4 then
			var_15_4:removeAllChildren()
			var_15_4:removeFromParent()

			if var_15_2 then
				var_15_2:removeFromParent()
				var_15_2:release()
			end
		end
	end))

	var_15_7:setTag(2)

	if not var_15_3:getChildByName("global_blockword") then
		var_15_3:addChild(var_15_4, 99999)
		var_15_4:setName("global_blockword")
		var_15_4:runAction(var_15_6)
		var_15_4:runAction(var_15_7)
	else
		var_15_4:stopActionByTag(1)
		var_15_4:stopActionByTag(2)
		var_15_4:runAction(var_15_6)
		var_15_4:runAction(var_15_7)
	end
end

function global_riseWords2(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = -110 + math.random(10)
	local var_18_1 = arg_18_1 or RISE_WORDS_SUCCESS
	local var_18_4 = cc.Director:getInstance():getRunningScene()

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		var_18_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			global_riseWord(iter_18_1, var_18_1, var_18_0 + math.random(3), 0, arg_18_2, arg_18_3, arg_18_5)
		end)))

		var_18_0 = var_18_0 - 5
	end
end

function global_riseWords3(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = -110 + math.random(10)
	local var_20_3 = cc.Director:getInstance():getRunningScene()

	for iter_20_0, iter_20_1 in pairs(arg_20_0) do
		var_20_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			global_riseWord(iter_20_1, arg_20_1[iter_20_0], var_20_0 + math.random(3), 0, arg_20_2, arg_20_3, arg_20_5)
		end)))

		var_20_0 = var_20_0 - 5
	end
end

function global_trans_number(arg_22_0)
	if type(arg_22_0) == "nil" then
		return ""
	end

	if type(arg_22_0) == "string" and not tonumber(arg_22_0) then
		return arg_22_0
	end

	if type(arg_22_0) == "string" then
		arg_22_0 = tonumber(arg_22_0)
	end

	local var_22_0 = ""

	if arg_22_0 < 10000 then
		var_22_0 = string.format("%d", arg_22_0)
	elseif arg_22_0 < 10000 * 10000 then
		if arg_22_0 / 10000 < 10 then
			local var_22_1 = math.floor(arg_22_0 / 10000)

			var_22_0 = string.format(L_GLOBALFUNC[1], var_22_1, (math.floor((arg_22_0 - var_22_1 * 10000) / 100)))
		elseif arg_22_0 / 10000 < 100 then
			local var_22_2 = math.floor(arg_22_0 / 10000)

			var_22_0 = string.format(L_GLOBALFUNC[2], var_22_2, (math.floor((arg_22_0 - var_22_2 * 10000) / 1000)))
		else
			var_22_0 = string.format(L_GLOBALFUNC[3], math.floor(arg_22_0 / 10000))
		end
	elseif arg_22_0 < 10000 * 10000 * 10000 then
		if arg_22_0 / 10000 / 10000 < 10 then
			local var_22_3 = math.floor(arg_22_0 / 10000 / 10000)

			var_22_0 = string.format(L_GLOBALFUNC[4], var_22_3, (math.floor((arg_22_0 - var_22_3 * 10000 * 10000) / (100 * 10000))))
		elseif arg_22_0 / 10000 / 10000 < 100 then
			local var_22_4 = math.floor(arg_22_0 / 10000 / 10000)

			var_22_0 = string.format(L_GLOBALFUNC[5], var_22_4, (math.floor((arg_22_0 - var_22_4 * 10000 * 10000) / (1000 * 10000))))
		else
			var_22_0 = string.format(L_GLOBALFUNC[6], math.floor(arg_22_0 / 10000 / 10000))
		end
	else
		local var_22_5 = math.floor(math.log10(arg_22_0))

		var_22_0 = string.format("%.3fE%d", arg_22_0 / math.pow(10, var_22_5), var_22_5)
	end

	return var_22_0
end

function global_trans_bitmapnumber(arg_23_0)
	if type(arg_23_0) == "string" and not tonumber(arg_23_0) then
		return arg_23_0
	end

	if type(arg_23_0) == "string" then
		arg_23_0 = tonumber(arg_23_0)
	end

	local var_23_0 = ""

	if arg_23_0 < 10000 then
		var_23_0 = string.format("%d", arg_23_0)
	elseif arg_23_0 < 10000 * 10000 then
		if arg_23_0 / 10000 < 10 then
			local var_23_1 = math.floor(arg_23_0 / 10000)

			var_23_0 = string.format("%d.%02dK", var_23_1, (math.floor((arg_23_0 - var_23_1 * 10000) / 100)))
		elseif arg_23_0 / 10000 < 100 then
			local var_23_2 = math.floor(arg_23_0 / 10000)

			var_23_0 = string.format("%d.%dK", var_23_2, (math.floor((arg_23_0 - var_23_2 * 10000) / 1000)))
		else
			var_23_0 = string.format("%dK", math.floor(arg_23_0 / 10000))
		end
	elseif arg_23_0 < 10000 * 10000 * 10000 then
		local var_23_3 = arg_23_0 / 10000 / 10000

		if arg_23_0 / 10000 / 10000 < 10 then
			local var_23_4 = math.floor(var_23_3)

			var_23_0 = string.format("%d.%02dM", var_23_4, (math.floor((arg_23_0 - var_23_4 * 10000 * 10000) / (100 * 10000))))
		elseif var_23_3 < 100 then
			local var_23_5 = math.floor(var_23_3)

			var_23_0 = string.format("%d.%dM", var_23_5, (math.floor((arg_23_0 - var_23_5 * 10000 * 10000) / (1000 * 10000))))
		else
			var_23_0 = string.format("%dM", math.floor(var_23_3))
		end
	else
		local var_23_6 = math.floor(math.log10(arg_23_0))

		var_23_0 = string.format("%.3fE%d", arg_23_0 / math.pow(10, var_23_6), var_23_6)
	end

	return var_23_0
end

function global_get(arg_24_0)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local var_24_2 = 0
	local var_24_3 = 0
	local var_24_4 = 0
	local var_24_5 = 0
	local var_24_6 = 0
	local var_24_7 = {}
	local var_24_8
	local var_24_9
	local var_24_10
	local var_24_11 = false

	if arg_24_0.gold and checkint(arg_24_0.gold) ~= 0 then
		playermodel.gold = playermodel.gold + checkint(arg_24_0.gold)
		var_24_2 = checkint(arg_24_0.gold)
		var_24_11 = true
	end

	if arg_24_0.diamond and arg_24_0.diamond ~= 0 then
		playermodel.diamond = playermodel.diamond + arg_24_0.diamond
		var_24_3 = arg_24_0.diamond
		var_24_11 = true
	end

	if arg_24_0.honor and arg_24_0.honor ~= 0 then
		playermodel.honor = playermodel.honor + arg_24_0.honor
		var_24_4 = arg_24_0.honor
		var_24_11 = true
	end

	if arg_24_0.sp and checkint(arg_24_0.sp) ~= 0 then
		playermodel.strengthpoint = playermodel.strengthpoint + checkint(arg_24_0.sp)
		var_24_5 = checkint(arg_24_0.sp)

		global_update_strengthpoint(true)
		AlertManager:check_servant_strenghth(true)

		var_24_11 = true
	end

	if arg_24_0.active and checkint(arg_24_0.active) ~= 0 then
		var_24_6 = checkint(arg_24_0.active)
		var_24_11 = true
	end

	if arg_24_0.items then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.items) do
			local var_24_12 = item_manager:setItemByServerItem(iter_24_1)

			if var_24_12 > 0 then
				var_24_7[#var_24_7 + 1] = {
					dropid = iter_24_1.itemid,
					dropNum = var_24_12,
					entityid = iter_24_1.entityid,
					horcrux_attr = iter_24_1.horcrux_attr
				}
				var_24_11 = true
			end
		end
	end

	if arg_24_0.surecallback then
		var_24_8 = arg_24_0.surecallback
	end

	if arg_24_0.cancelcallback then
		var_24_9 = arg_24_0.cancelcallback
	end

	if arg_24_0.intocallback then
		var_24_10 = arg_24_0.intocallback
	end

	global_update_gold_stone_diamond(arg_24_0.gold, arg_24_0.stone, arg_24_0.diamond)

	return var_24_2, var_24_3, var_24_4, var_24_5, var_24_7, 0, var_24_6, var_24_8, var_24_9, var_24_11, var_24_10
end

function global_gain(arg_25_0)
	local var_25_0, var_25_1, var_25_2, var_25_3, var_25_4, var_25_5, var_25_6, var_25_7, var_25_8, var_25_9, var_25_10 = global_get(arg_25_0)

	if not var_25_9 then
		return
	end

	LayerManager:pushInLayer("PopPurchaseResultLayer", {
		gold = var_25_0,
		diamond = var_25_1,
		honor = var_25_2,
		sp = var_25_3,
		energy = var_25_5,
		active = var_25_6,
		items = var_25_4,
		itemformat = arg_25_0.itemformat,
		surecallback = var_25_7,
		intocallback = var_25_10,
		cancelcallback = var_25_8
	})
end

function global_update_gold_stone_diamond(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	if arg_28_0 and arg_28_0 ~= 0 then
		GlobalUpdateGold(arg_28_3)
	end

	if arg_28_2 then
		GlobalUpdateDiamond()
	end

	if LayerManager:getCurrentLayerName() == "TwisteggLayer" then
		TwisteggLayer.getInstance():updateGoldPanel()
	end

	local alert_manager = require("controller.alert_manager")

	alert_manager:check_servant_breakout(false)
	alert_manager:check_horcrux_strenghth(false)
end

function global_gold_animation()
	GlobalUpdateGoldImg()
end

function global_update_strengthpoint()
	GlobalUpdateSp()
end

function split(arg_31_0, arg_31_1)
	local var_31_0 = {}
	local var_31_1 = "(.-)" .. arg_31_1
	local var_31_2 = 1
	local var_31_3, var_31_4, var_31_5 = arg_31_0:find("(.-)" .. arg_31_1, 1)

	while var_31_3 do
		if var_31_3 ~= 1 or var_31_5 ~= "" then
			table.insert(var_31_0, var_31_5)
		end

		var_31_2 = var_31_4 + 1
		var_31_3, var_31_4, var_31_5 = arg_31_0:find(var_31_1, var_31_4 + 1)
	end

	if var_31_2 <= #arg_31_0 then
		table.insert(var_31_0, (arg_31_0:sub(var_31_2)))
	end

	return var_31_0
end

function global_get_time_by_date(arg_32_0)
	if not arg_32_0 then
		return 0
	end

	if arg_32_0 == 0 or arg_32_0 == "0" then
		return 0
	end

	local var_32_0 = split(arg_32_0, " ")
	local var_32_1 = split(var_32_0[1], "-")
	local var_32_2 = split(var_32_0[2], ":")

	return (os.time({
		year = var_32_1[1],
		month = var_32_1[2],
		day = var_32_1[3],
		hour = var_32_2[1],
		min = var_32_2[2],
		sec = var_32_2[3]
	}))
end

function global_get_time_by_date_2(arg_33_0)
	if not arg_33_0 then
		return 0
	end

	if arg_33_0 == 0 or arg_33_0 == "0" then
		return 0
	end

	local var_33_0 = split(arg_33_0, " ")
	local var_33_1 = split(var_33_0[1], "/")
	local var_33_2 = split(var_33_0[2], ":")

	var_33_1[3] = var_33_1[3] + 2000

	return (os.time({
		year = var_33_1[3],
		month = var_33_1[2],
		day = var_33_1[1],
		hour = var_33_2[1],
		min = var_33_2[2],
		sec = var_33_2[3]
	}))
end

function global_get_time_by_second(arg_34_0)
	local var_34_0 = math.fmod(math.floor(arg_34_0 / 60 / 60), 24)
	local var_34_1 = math.fmod(math.floor(arg_34_0 / 60), 60)
	local var_34_2 = math.fmod(arg_34_0, 60)

	if var_34_0 == 0 then
		return string.format("%02d", var_34_1) .. ":" .. string.format("%02d", var_34_2)
	else
		return string.format("%02d", var_34_0) .. ":" .. string.format("%02d", var_34_1) .. ":" .. string.format("%02d", var_34_2)
	end
end

function global_format_time_by_date(arg_35_0, arg_35_1)
	if not arg_35_0 then
		return 0
	end

	if arg_35_0 == 0 or arg_35_0 == "0" then
		return 0
	end

	local var_35_0 = split(arg_35_0, " ")
	local var_35_1 = split(var_35_0[1], "-")
	local var_35_2 = split(var_35_0[2], ":")

	return (arg_35_1 == 1 or nil) and string.format("%s月%s日%s:%s", var_35_1[2], var_35_1[3], var_35_2[1], var_35_2[2])
end

function global_deepCopy(arg_36_0)
	local var_36_0 = {}

	local function var_36_1(arg_37_0)
		if type(arg_37_0) ~= "table" then
			return arg_37_0
		elseif var_36_0[arg_37_0] then
			return var_36_0[arg_37_0]
		end

		local var_37_0 = {}

		var_36_0[arg_37_0] = var_37_0

		for iter_37_0, iter_37_1 in pairs(arg_37_0) do
			var_37_0[var_36_1(iter_37_0)] = var_36_1(iter_37_1)
		end

		return setmetatable(var_37_0, getmetatable(arg_37_0))
	end

	return var_36_1(arg_36_0)
end

function GetTableViewShowCellIdx(arg_38_0, arg_38_1)
	local var_38_2 = arg_38_1.maxcount
	local var_38_3 = arg_38_1.cellsize

	local function var_38_4(arg_39_0)
		if arg_38_0:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL then
			return var_38_3.height * arg_39_0
		else
			return var_38_3.width * arg_39_0
		end
	end

	local function var_38_5(arg_40_0)
		local var_40_0 = 0

		while var_40_0 <= var_38_2 - 1 do
			local var_40_1 = math.floor(var_40_0 + (var_38_2 - 1 - var_40_0) / 2)
			local var_40_2 = var_38_4(var_40_1)
			local var_40_3

			if var_40_2 <= arg_40_0 and arg_40_0 <= var_38_4(var_40_1 + 1) then
				return var_40_1
			elseif arg_40_0 < var_40_2 then
				var_40_3 = var_40_1 - 1
			else
				var_40_0 = var_40_1 + 1
			end
		end

		if var_40_0 <= 0 then
			return 0
		end

		return var_38_2 - 1
	end

	local var_38_6 = arg_38_0:getContentOffset()

	var_38_6.x = -1 * var_38_6.x
	var_38_6.y = -1 * var_38_6.y

	if arg_38_0:getVerticalFillOrder() == cc.TABLEVIEW_FILL_TOPDOWN then
		var_38_6.y = var_38_6.y + arg_38_0:getViewSize().height
		var_38_6.y = arg_38_0:getContainer():getContentSize().height - var_38_6.y
	end

	local var_38_7 = var_38_5((arg_38_0:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL or nil) and (var_38_6.y or var_38_6.x))

	if var_38_7 < 0 then
		var_38_7 = 0
	end

	if var_38_2 <= var_38_7 then
		var_38_7 = var_38_2 - 1
	end

	if arg_38_0:getVerticalFillOrder() == cc.TABLEVIEW_FILL_TOPDOWN then
		var_38_6.y = arg_38_0:getContainer():getContentSize().height - var_38_6.y
		var_38_6.y = var_38_6.y - arg_38_0:getViewSize().height
		var_38_6.y = arg_38_0:getContainer():getContentSize().height - var_38_6.y
	else
		var_38_6.y = var_38_6.y + arg_38_0:getViewSize().height
	end

	var_38_6.x = var_38_6.x + arg_38_0:getViewSize().width

	local var_38_8 = var_38_5(arg_38_0:getDirection() == cc.SCROLLVIEW_DIRECTION_VERTICAL and var_38_6.y or var_38_6.x)

	if var_38_8 < 0 then
		var_38_8 = 0
	end

	if var_38_2 <= var_38_8 then
		var_38_8 = var_38_2 - 1
	end

	return var_38_7, var_38_8
end

function showItemDetails(arg_41_0, arg_41_1)
	if not arg_41_0 or type(arg_41_0) ~= "number" then
		print("not itemid or itemid is gold or diamond or other")

		return
	end

	local var_41_0 = require("data.item_data")[arg_41_0].bag_item_type
	local var_41_2 = PopLayer:Item(arg_41_1 and {
		hideAttrButton = true,
		hideGainButton = true,
		entityid = arg_41_1,
		itemid = arg_41_0
	} or {
		hideAttrButton = true,
		hideGainButton = true,
		itemid = arg_41_0
	})
end

function isContainPosOfConvexPolygon(arg_42_0, arg_42_1)
	local var_42_0 = {}
	local var_42_1 = {}

	if #arg_42_0 < 3 then
		print("function isContainPosOfConvexPolygon param1 'posList' length not ", #arg_42_0)

		return false
	end

	for iter_42_0 = 1, #arg_42_0 do
		local var_42_2
		local var_42_3

		if iter_42_0 == 1 then
			var_42_2 = arg_42_0[1]
			var_42_3 = arg_42_0[#arg_42_0]
		else
			var_42_2 = arg_42_0[iter_42_0]
			var_42_3 = arg_42_0[iter_42_0 - 1]
		end

		var_42_0[#var_42_0 + 1] = {}
		var_42_0[#var_42_0].x = var_42_2.x - var_42_3.x
		var_42_0[#var_42_0].y = var_42_2.y - var_42_3.y
		var_42_1[#var_42_1 + 1] = {}
		var_42_1[#var_42_1].x = var_42_2.x - arg_42_1.x
		var_42_1[#var_42_1].y = var_42_2.y - arg_42_1.y
	end

	for iter_42_1, iter_42_2 in pairs(var_42_0) do
		if iter_42_2.x * var_42_1[iter_42_1].y - iter_42_2.y * var_42_1[iter_42_1].x < 0 then
			return false
		end
	end

	return true
end

function transSkillDesToRichText(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 or cc.c3b(3, 195, 231)

	arg_43_0 = string.gsub(arg_43_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", {
		】 = "</span>",
		【 = "<span style=color: " .. string.format("rgb(%d, %d, %d)", var_43_0.r, var_43_0.g, var_43_0.b) .. ";>"
	})
	arg_43_0 = string.gsub(arg_43_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", {
		["]"] = "</span>",
		["["] = "<span style=color: " .. string.format("rgb(%d, %d, %d)", 64, 254, 96) .. ";>"
	})

	return "<p>" .. arg_43_0 .. "</p>"
end

function GenerateRoleConversationClass(arg_44_0, arg_44_1)
	if not arg_44_0 then
		return
	end

	arg_44_1 = arg_44_1 or ROLE_CONVERSATION_TYPE.mainTouch

	local var_44_0 = GenerateRoleConversationClassAct(arg_44_0, arg_44_1)

	if var_44_0 then
		return var_44_0
	end

	local var_44_1 = GenerateRoleConversationClassNew(arg_44_0, arg_44_1)
	local conversation_type_data

	if var_44_1 then
		do return var_44_1 end

		conversation_type_data = require("data.conversation_type_data")

		local servant_data = require("data.servant_data")
	end

	local var_44_4 = require("data.model_data")[arg_44_0].major

	if not var_44_4 then
		return
	end

	local var_44_5

	if arg_44_1 == ROLE_CONVERSATION_TYPE.dormDaily or arg_44_1 == ROLE_CONVERSATION_TYPE.dormTouch then
		var_44_5 = require("model.playermodel").favor[var_44_4].favorlevel
		var_44_5 = math.min(var_44_5, 20)
	end

	local major_factor_data = require("data.major_factor_data")
	local var_44_7 = tonumber((major_factor_data[var_44_4] or nil) and (major_factor_data[var_44_4].model or arg_44_0))
	local var_44_8 = var_44_5 and var_44_7 * 10000 + arg_44_1 * 100 + var_44_5 or var_44_7 * 100 + arg_44_1

	if not conversation_type_data[var_44_8] then
		var_44_8 = var_44_5 and var_44_4 * 10000 + arg_44_1 * 100 + var_44_5 or var_44_4 * 100 + arg_44_1
	end

	if not conversation_type_data[var_44_8] then
		print("conversationTypeData[" .. var_44_8 .. "] is nil 可能会导致说不出话")
		print("id = (majorid*10000) + (对话类型" .. arg_44_1 .. " * 100) + 好感度等级")

		return
	end

	local var_44_9 = 0

	while conversation_type_data[var_44_8]["class" .. var_44_9 + 1] do
		var_44_9 = var_44_9 + 1
	end

	if var_44_9 == 0 then
		return
	end

	return conversation_type_data[var_44_8]["class" .. (var_44_9 > 1 and math.random(var_44_9) or 1)]
end

function GenerateRoleConversationClassNew(arg_45_0, arg_45_1)
	arg_45_1 = arg_45_1 or ROLE_CONVERSATION_TYPE.mainTouch

	local role_conversation_index_data = require("data.role_conversation_index_data")
	local var_45_1 = require("data.model_data")[arg_45_0].major

	if require("data.npc_data")[var_45_1] then
		local var_45_2 = ROLE_CONVERSATION_TYPE_TO_STR[arg_45_1]

		if not ROLE_CONVERSATION_TYPE_TO_STR[arg_45_1] then
			return
		end

		if role_conversation_index_data[tostring(arg_45_0) .. "_npc"] and role_conversation_index_data[tostring(arg_45_0) .. "_npc"][var_45_2 .. "1"] then
			local var_45_3 = 0

			while role_conversation_index_data[tostring(arg_45_0) .. "_npc"][var_45_2 .. var_45_3 + 1] do
				var_45_3 = var_45_3 + 1
			end

			if var_45_3 == 0 then
				return
			end

			return role_conversation_index_data[tostring(arg_45_0) .. "_npc"][var_45_2 .. (var_45_3 > 1 and math.random(var_45_3) or 1)]
		elseif role_conversation_index_data[tostring(var_45_1) .. "_npc"] and role_conversation_index_data[tostring(var_45_1) .. "_npc"][var_45_2 .. "1"] then
			local var_45_4 = 0

			while role_conversation_index_data[tostring(var_45_1) .. "_npc"][var_45_2 .. var_45_4 + 1] do
				var_45_4 = var_45_4 + 1
			end

			if var_45_4 == 0 then
				return
			end

			return role_conversation_index_data[tostring(var_45_1) .. "_npc"][var_45_2 .. (var_45_4 > 1 and math.random(var_45_4) or 1)]
		else
			return
		end
	else
		local var_45_5

		if arg_45_1 == ROLE_CONVERSATION_TYPE.dormDaily or arg_45_1 == ROLE_CONVERSATION_TYPE.dormTouch then
			var_45_5 = require("model.playermodel").favor[var_45_1].favorlevel
		end

		local var_45_6 = var_45_5 and ROLE_CONVERSATION_TYPE_TO_STR[arg_45_1] .. var_45_5 .. "_" or ROLE_CONVERSATION_TYPE_TO_STR[arg_45_1]

		if not var_45_6 then
			return
		end

		if role_conversation_index_data[tostring(arg_45_0)] and role_conversation_index_data[tostring(arg_45_0)][var_45_6 .. "1"] then
			local var_45_7 = 0

			while role_conversation_index_data[tostring(arg_45_0)][var_45_6 .. var_45_7 + 1] do
				var_45_7 = var_45_7 + 1
			end

			if var_45_7 == 0 then
				return
			end

			return role_conversation_index_data[tostring(arg_45_0)][var_45_6 .. (var_45_7 > 1 and math.random(var_45_7) or 1)]
		elseif role_conversation_index_data[tostring(var_45_1)] and role_conversation_index_data[tostring(var_45_1)][var_45_6 .. "1"] then
			local var_45_8 = 0

			while role_conversation_index_data[tostring(var_45_1)][var_45_6 .. var_45_8 + 1] do
				var_45_8 = var_45_8 + 1
			end

			if var_45_8 == 0 then
				return
			end

			return role_conversation_index_data[tostring(var_45_1)][var_45_6 .. (var_45_8 > 1 and math.random(var_45_8) or 1)]
		else
			return
		end
	end
end

function GenerateRoleConversationClassAct(arg_46_0, arg_46_1)
	local model_data = require("data.model_data")

	if arg_46_1 == ROLE_CONVERSATION_TYPE.act_got then
		return 222021325
	elseif arg_46_1 == ROLE_CONVERSATION_TYPE.act_gift then
		return tonumber(model_data[arg_46_0].major .. "2601")
	elseif arg_46_1 == ROLE_CONVERSATION_TYPE.act_false then
		return 242021325
	elseif arg_46_1 == ROLE_CONVERSATION_TYPE.act_get then
		return tonumber(model_data[arg_46_0].major .. "2601")
	end
end

function GlobalPlayRoleSound(arg_47_0, arg_47_1)
	local audio_manager = require("controller.audio_manager")

	if not audio_manager:isPlayerSoundValid() then
		return
	end

	local var_47_1 = GenerateRoleConversationClass(arg_47_0, arg_47_1)

	if not var_47_1 then
		return
	end

	local conversation_class_data = require("data.conversation_class_data")
	local role_conversation_data = require("data.role_conversation_data")

	if not role_conversation_data[var_47_1 * 100 + 1] then
		return
	end

	local var_47_4 = 0

	while role_conversation_data[var_47_1 * 100 + var_47_4 + 1] do
		var_47_4 = var_47_4 + 1
	end

	if var_47_4 == 0 then
		return
	end

	local var_47_5 = role_conversation_data[var_47_1 * 100 + (var_47_4 > 1 and math.random(var_47_4) or 1)].sound

	if not role_conversation_data[var_47_1 * 100 + (var_47_4 > 1 and math.random(var_47_4) or 1)].sound then
		return
	end

	audio_manager.playingplayersound = true

	audio_manager:playPlayerSound("sound/role_voice/" .. var_47_5, nil, nil, function()
		audio_manager.playingplayersound = false
	end)
end

function GlobalShowRoleSaying(arg_49_0, arg_49_1)
	local var_49_0 = GenerateRoleConversationClass(arg_49_0, arg_49_1)

	if not var_49_0 then
		return
	end

	local conversation_class_data = require("data.conversation_class_data")
	local role_conversation_data = require("data.role_conversation_data")

	if not role_conversation_data[var_49_0 * 100 + 1] then
		return
	end

	local var_49_3 = 0

	while role_conversation_data[var_49_0 * 100 + var_49_3 + 1] do
		var_49_3 = var_49_3 + 1
	end

	if var_49_3 == 0 then
		return
	end

	local var_49_4 = var_49_3 > 1 and math.random(var_49_3) or 1

	if not role_conversation_data[var_49_0 * 100 + var_49_4] then
		return
	end

	return role_conversation_data[var_49_0 * 100 + var_49_4].dec
end

function global_favor_show(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0 = arg_50_0 or 0

	local var_50_0 = ccui.ImageView:create("Dormitory/effeft_pa2.png", config._DEBUG and 0 or 1)

	var_50_0:setScaleX(0.1)
	var_50_0:setPosition(320, 640)
	global_basic_scene:addChild(var_50_0, 10000)

	local var_50_2 = cc.Label:createWithTTF(arg_50_2 and L_FAVOR .. "+" .. arg_50_0 .. "+" .. arg_50_2 or L_FAVOR .. "+" .. arg_50_0, FONT_TITLE, 36)

	var_50_2:setAnchorPoint(cc.p(1, 0))
	var_50_2:setPosition(var_50_0:getContentSize().width - 17, 15)
	var_50_2:setColor(cc.c3b(251, 183, 211))
	var_50_2:enableOutline(cc.c4b(144, 38, 61, 255), 2)
	var_50_0:addChild(var_50_2)
	var_50_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.Spawn:create(cc.FadeOut:create(1), cc.MoveBy:create(1, cc.p(0, 80))), cc.CallFunc:create(function()
		if arg_50_1 then
			arg_50_1()
		end
	end), cc.RemoveSelf:create()))
end

function globa_create_tips(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0 = arg_52_0 or cc.size(160, 50)
	arg_52_1 = arg_52_1 or ""
	arg_52_2 = arg_52_2 or 28

	local var_52_0 = ccui.Layout:create()

	var_52_0:setTouchEnabled(false)
	var_52_0:setContentSize(arg_52_0)
	var_52_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_52_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_52_0:setBackGroundColorOpacity(200)
	var_52_0:setCascadeOpacityEnabled(false)
	var_52_0:setLocalZOrder(99)

	local var_52_1 = cc.Label:createWithTTF(arg_52_1, FONT_TITLE, arg_52_2)

	var_52_1:setName("label")
	var_52_1:setPosition(var_52_0:getContentSize().width / 2, var_52_0:getContentSize().height / 2)
	var_52_1:setColor(cc.c3b(255, 175, 2))
	var_52_0:addChild(var_52_1)

	return var_52_0
end

function global_window_open_action(arg_53_0, arg_53_1)
	if not arg_53_0 then
		return
	end

	local var_53_0 = arg_53_1 or nil or {
		blink_time = 0.15,
		open_time = 0.1
	}

	arg_53_0:setOpacity(0)
	arg_53_0:setScale(1, 0.001)
	arg_53_0:runAction((cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(var_53_0.open_time), cc.ScaleTo:create(var_53_0.open_time, 1, 1)))))
end

function global_window_close_action(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_0 then
		if arg_54_1 then
			arg_54_1()
		end

		return
	end

	local var_54_0 = arg_54_2 or nil or {
		blink_time = 0.15,
		close_time = 0.1
	}

	arg_54_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeTo:create(var_54_0.close_time, 20), cc.ScaleTo:create(var_54_0.close_time, 1, 0.001)), cc.DelayTime:create(var_54_0.close_time), cc.CallFunc:create(function()
		if arg_54_1 then
			arg_54_1()
		end
	end)))
end

function global_add_alert_tag(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if not arg_56_0 then
		return
	end

	local var_56_0
	local var_56_1

	if arg_56_0 and arg_56_0:getChildByName("reddot") then
		arg_56_0:getChildByName("reddot"):setVisible(true)

		if arg_56_1 then
			arg_56_0:getChildByName("reddot"):setPosition(arg_56_1)
		end

		do return end

		var_56_0 = arg_56_2 or 999
		var_56_1 = arg_56_1 or {
			x = arg_56_0:getContentSize().width,
			y = arg_56_0:getContentSize().height
		}
	end

	local var_56_2 = ccui.ImageView:create(({
		"public/reddot/reddot2.png",
		"public/reddot/new.png",
		"public/reddot/reddot3.png",
		"public/reddot/patrol_alert.png"
	})[arg_56_3 or 1], config._DEBUG and 0 or 1)

	var_56_2:setName("reddot")
	var_56_2:setAnchorPoint(cc.p(1, 1))
	var_56_2:setPosition(cc.p(var_56_1.x, var_56_1.y))
	arg_56_0:addChild(var_56_2, var_56_0)

	return var_56_2
end

function global_remove_alert_tag(arg_57_0)
	if not arg_57_0 then
		return
	end

	if not arg_57_0:getChildByName("reddot") then
		return
	end

	arg_57_0:getChildByName("reddot"):runAction(cc.RemoveSelf:create())
end

function glabal_trans_text_horizontal_to_vertical(arg_58_0)
	return (string.gsub(arg_58_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", function(arg_59_0)
		return arg_59_0 .. "\n"
	end))
end

local var_0_1 = {
	[kITEM_HERO] = 0.9882352941176471,
	[kITEM_HORCRUX] = 0.6640625,
	[kITEM_WEAPON] = 0.703125,
	[kITEM_FOOD] = 1.3125,
	[kITEM_SCULTURE] = 1,
	[kITEM_COMPONENT] = 1,
	[kITEM_DRAWING] = 0.46875,
	[kITEM_HORCRUX_DRAWING] = 0.46875,
	[kITEM_MEDAL] = 0.4880952380952381,
	[KITEM_SPRING_FESTIVAL_WORD] = 0.4296875
}

setmetatable(var_0_1, {
	__index = function(arg_60_0, arg_60_1)
		return 1
	end
})

local var_0_2 = {
	[kITEM_HERO] = 170,
	[kITEM_HORCRUX] = 256,
	[kITEM_WEAPON] = 256,
	[kITEM_FOOD] = 128,
	[kITEM_DRAWING] = 256,
	[kITEM_HORCRUX_DRAWING] = 256,
	[kITEM_MEDAL] = 200,
	[KITEM_SPRING_FESTIVAL_WORD] = 340
}

function global_get_item_scale(arg_61_0, arg_61_1)
	local var_61_1 = var_0_1[arg_61_1] == 1 and 1 or ((not var_0_2[arg_61_1] or nil) and 256) / arg_61_0:getContentSize().width * var_0_1[arg_61_1]

	return var_61_1
end

function global_get_item_scale_by_size(arg_62_0, arg_62_1)
	local var_62_1 = var_0_1[arg_62_1] == 1 and 1 or ((not var_0_2[arg_62_1] or nil) and 256) / arg_62_0 * var_0_1[arg_62_1]

	return var_62_1
end

function global_get_node_display_posy(arg_63_0, arg_63_1)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(arg_63_1) do
		local var_63_1 = GameDisplay.pos_transform(iter_63_1.reference, iter_63_1.posY, iter_63_1.unit)
		local var_63_2 = ccui.Helper:seekWidgetByName(arg_63_0, iter_63_0) or arg_63_0:getChildByName(iter_63_0)
		local var_63_3

		if iter_63_0 == iter_63_1.focusName then
			var_63_3 = ccui.Helper:seekWidgetByName(arg_63_0, iter_63_0) or arg_63_0:getChildByName(iter_63_0)
		else
			var_63_3 = ccui.Helper:seekWidgetByName(var_63_2, iter_63_1.focusName)
			var_63_3 = var_63_3 or var_63_2:getChildByName(iter_63_1.focusName)
		end

		if not var_63_3 then
			var_63_0[iter_63_0] = 0
		else
			local var_63_4

			if var_63_3.anchorPoint then
				var_63_4 = var_63_3.anchorPoint.x or var_63_3:getAnchorPoint().x

				local var_63_5

				if var_63_3.anchorPoint then
					var_63_5 = var_63_3.anchorPoint.y or var_63_3:getAnchorPoint().y
				end
			end

			local var_63_6 = var_63_3:getContentSize().width * var_63_4
			local var_63_7 = var_63_3.displayheight
			local var_63_8

			if not var_63_3.displayheight then
				var_63_7 = var_63_3:getContentSize().height
				var_63_8 = var_63_2:getPositionY() + var_63_1
			end

			var_63_0[iter_63_0] = var_63_8 - var_63_3:convertToWorldSpace(cc.p(var_63_6, var_63_7 * var_63_5)).y
		end
	end

	return var_63_0
end

function global_transfrompercent_pos(arg_64_0)
	return arg_64_0 > 1 and arg_64_0 / 1136 * GameDisplay.getUiScreenSize().height - GameDisplay.fix_y / 2 or arg_64_0 * GameDisplay.getUiScreenSize().height - GameDisplay.fix_y
end

function global_get_servant_skin(arg_65_0, arg_65_1)
	local playermodel = require("model.playermodel")
	local servant_data = require("data.servant_data")
	local major_factor_data = require("data.major_factor_data")

	if not servant_data[arg_65_0] then
		return arg_65_0
	end

	local var_65_3 = arg_65_1 or playermodel.servantUsedskin[arg_65_0]
	local var_65_4

	if (arg_65_1 or playermodel.servantUsedskin[arg_65_0]) < 0 then
		var_65_4 = servant_data[arg_65_0].modelid
	else
		local var_65_5 = 1

		while major_factor_data[servant_data[arg_65_0].major]["item" .. var_65_5] do
			if major_factor_data[servant_data[arg_65_0].major]["item" .. var_65_5] == var_65_3 then
				var_65_4 = servant_data[arg_65_0]["modelid" .. var_65_5]
			end

			var_65_5 = var_65_5 + 1
		end

		if major_factor_data[servant_data[arg_65_0].major].item_oc and major_factor_data[servant_data[arg_65_0].major].item_oc == var_65_3 then
			var_65_4 = servant_data[arg_65_0].model_oc
		end
	end

	var_65_4 = var_65_4 or servant_data[arg_65_0].modelid

	return var_65_4
end

function global_logout(arg_66_0)
	local var_66_0 = cc.EventCustom:new("LOGOUT")

	var_66_0.logouttype = arg_66_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_66_0)
end

function global_restart_game()
	if FightManager then
		FightManager.releaseAllCharacter()
	end

	require("view.Scene.RestartScene")
	cc.Director:getInstance():replaceScene(RestartScene:createScene(true))
end

STATIC_IS_OWOD = nil

function global_open_harmony_world()
	return
end

function global_revert_harmony_world()
	local var_69_0 = cc.FileUtils:getInstance():getSearchPaths()

	while var_69_0[1] do
		local var_69_1

		if var_69_0[1]:find("owod") then
			table.remove(var_69_0, 1)
		else
			var_69_1 = 1 + 1
		end
	end

	cc.FileUtils:getInstance():setSearchPaths(var_69_0)

	STATIC_IS_OWOD = nil
end

function global_is_hide_skin_by_modelid(arg_70_0)
	if not STATIC_IS_OWOD then
		return false
	end

	local major_factor_data = require("data.major_factor_data")
	local var_70_2

	for iter_70_0, iter_70_1 in pairs((require("data.servant_data"))) do
		while iter_70_1["modelid" .. 1] do
			print("modelid", arg_70_0, iter_70_1["modelid" .. 1])

			if iter_70_1.classtype == 1 and arg_70_0 == iter_70_1["modelid" .. 1] then
				var_70_2 = 1
			end
		end
	end

	print(arg_70_0, nil, var_70_2)

	local var_70_5 = require("controller.account_manager"):getChannel()

	if nil and var_70_2 then
		if major_factor_data[nil]["hide" .. var_70_2 .. "_channel"] and next(major_factor_data[nil]["hide" .. var_70_2 .. "_channel"]) then
			for iter_70_2, iter_70_3 in pairs(string.split(major_factor_data[nil]["hide" .. var_70_2 .. "_channel"], ",")) do
				if var_70_5 == iter_70_3 then
					return true
				end
			end
		end
	end

	return false
end

function global_is_hide_skin_by_itemid(arg_71_0, arg_71_1)
	return not require("controller.hexie_manager"):canPreviewSkin(arg_71_0, arg_71_1)
end

function global_get_model_attr(arg_72_0)
	local model_data = require("data.model_data")

	if not arg_72_0 then
		print("global_get_model_attr id is null")

		return "wind"
	end

	for iter_72_0, iter_72_1 in pairs(ATTR_ID) do
		if iter_72_0 ~= 0 and model_data[arg_72_0][iter_72_1] == 1 then
			return iter_72_1
		end
	end

	return "wind"
end

function global_get_all_model_attrs(arg_73_0)
	local model_data = require("data.model_data")

	if not arg_73_0 then
		print(" global_get_all_model_attrs id is null")

		return {
			main = "wind"
		}
	end

	local var_73_1 = {}

	for iter_73_0, iter_73_1 in pairs(ATTR_ID) do
		if iter_73_0 ~= 0 then
			if model_data[arg_73_0][iter_73_1] == 1 then
				var_73_1.main = iter_73_1
			elseif model_data[arg_73_0][iter_73_1] ~= nil then
				var_73_1.sub = var_73_1.sub or {}

				table.insert(var_73_1.sub, iter_73_1)
			end
		end
	end

	return var_73_1
end

function global_get_all_model_attrs_img_path(arg_74_0)
	local var_74_0 = global_get_all_model_attrs(arg_74_0)
	local var_74_1 = var_74_0.main

	if var_74_0.sub and next(var_74_0.sub) then
		for iter_74_0, iter_74_1 in ipairs(var_74_0.sub) do
			var_74_1 = var_74_1 .. "_" .. iter_74_1
		end
	end

	return var_74_1
end

function global_get_all_servant_attrs(arg_75_0)
	return global_get_all_model_attrs(require("data.servant_data")[arg_75_0].modelid)
end

function global_show_data_bubble(arg_76_0, arg_76_1, arg_76_2, arg_76_3, arg_76_4, arg_76_5, arg_76_6, arg_76_7)
	arg_76_4 = arg_76_4 or 260
	arg_76_5 = arg_76_5 or 120
	arg_76_6 = arg_76_6 or 250
	arg_76_7 = arg_76_7 or 255

	local var_76_0 = ccui.Layout:create()

	var_76_0:setContentSize(cc.size(arg_76_4, arg_76_5))
	var_76_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_76_0:setAnchorPoint(0, 1)
	var_76_0:setPosition(cc.p(0, 10))
	var_76_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_76_0:setCascadeOpacityEnabled(false)
	var_76_0:setBackGroundColorOpacity(arg_76_7)
	var_76_0:setName("showskill")
	var_76_0:setTouchEnabled(true)
	var_76_0:setScale(0)
	arg_76_0:addChild(var_76_0, 100000)

	local var_76_1 = cc.Label:createWithTTF("1", FONT_DES, 22)

	var_76_1:setMaxLineWidth(190)
	var_76_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_76_1:setColor(cc.c3b(253, 211, 81))
	var_76_1:setPosition(cc.p(var_76_0:getContentSize().width / 2, var_76_0:getContentSize().height - 12))
	var_76_1:setName("Label1")
	var_76_1:setString(arg_76_2 or "")
	var_76_0:addChild(var_76_1)

	local var_76_2 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_76_2:setMaxLineWidth(arg_76_6)
	var_76_2:setAnchorPoint(cc.p(0, 1))
	var_76_2:setColor(cc.c3b(234, 232, 226))
	var_76_2:setPosition(cc.p(0, var_76_1:getPositionY() - var_76_1:getContentSize().height))
	var_76_2:setName("Label2")
	var_76_2:setString(arg_76_3)
	var_76_0:addChild(var_76_2)

	local var_76_3 = cc.EventListenerTouchOneByOne:create()

	var_76_3:setSwallowTouches(false)
	var_76_3:registerScriptHandler(function(arg_77_0, arg_77_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_76_3:registerScriptHandler(function(arg_78_0, arg_78_1)
		if var_76_0 then
			var_76_0:removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	arg_76_1:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_76_3, var_76_0)
	var_76_0:runAction((cc.ScaleTo:create(0.2, 1)))
end

function global_change_fontsize_by_length(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	local var_79_0 = subStringGetTotalIndex(arg_79_0)

	return (arg_79_2 < var_79_0 or nil) and arg_79_1 - (var_79_0 - arg_79_2) * arg_79_3
end

function global_get_rest_of_the_week()
	local var_80_0 = require("controller.time_check_manager"):getCurTime()
	local var_80_1 = os.date("*t", var_80_0)
	local var_80_2 = tonumber(os.date("%w", var_80_0))

	return ((var_80_2 ~= 0 or nil) and 7 - var_80_2) * 86400 + (os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = var_80_1.year,
		month = var_80_1.month,
		day = var_80_1.day
	}) - var_80_0)
end

function global_get_conversation_ani(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = require("data.role_conversation_data")[arg_81_0]

	if not var_81_0 then
		return nil
	end

	local var_81_1 = arg_81_2 == 1 and "spine" or "l2d"
	local var_81_2

	while var_81_0[var_81_1 .. "_model" .. 1] do
		if var_81_0[var_81_1 .. "_model" .. 1] == arg_81_1 then
			var_81_2 = var_81_0[var_81_1 .. "_ani" .. 1]

			break
		end
	end

	return var_81_2 or var_81_0.ani
end

function hx_print(arg_82_0, arg_82_1, arg_82_2)
	if config.packagechannel == "palmpi" then
		arg_82_1 = arg_82_1 or CONSOLE_COLOR_RED
		arg_82_2 = arg_82_2 or CONSOLE_BG_COLOR_BLACK

		ConsoleExt.setColor(arg_82_1 + arg_82_2)
		print(arg_82_0)
		ConsoleExt.reset()
	end
end

function global_sort_by_weight(arg_83_0, arg_83_1)
	local var_83_0 = 0
	local var_83_1 = {}

	for iter_83_0, iter_83_1 in pairs(arg_83_1) do
		if var_83_0 < iter_83_1.weight then
			var_83_0 = iter_83_1.weight
		end

		var_83_1[iter_83_1.weight] = iter_83_1.func
	end

	for iter_83_2, iter_83_3 in pairs(arg_83_0) do
		local var_83_2 = iter_83_3.weight or 0

		if var_83_2 > 10000 then
			iter_83_3.totalWeight = var_83_2
		else
			local var_83_3 = ""

			for iter_83_4 = 1, var_83_0 do
				var_83_3 = (var_83_1[iter_83_4] and string.format("%03d,", (var_83_1[iter_83_4](iter_83_3))) or iter_83_4 == var_83_2 and string.format("%03d,", var_83_2) or string.format("%03d,", 0)) .. var_83_3
			end

			iter_83_3.totalWeight = var_83_3
		end
	end

	table.sort(arg_83_0, function(arg_84_0, arg_84_1)
		if type(arg_84_0.totalWeight) == "number" and type(arg_84_1.totalWeight) == number then
			return arg_84_0.totalWeight > arg_84_1.totalWeight
		elseif type(arg_84_0.totalWeight) == "number" then
			return true
		elseif type(arg_84_1.totalWeight) == "number" then
			return false
		else
			return arg_84_0.totalWeight > arg_84_1.totalWeight
		end
	end)

	return arg_83_0
end

function global_get_finishtime_str(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	if not arg_85_0 then
		return ""
	end

	local var_85_0 = global_get_time_by_date(arg_85_0) - arg_85_1

	if var_85_0 < 0 then
		return ""
	end

	local var_85_1 = ""
	local var_85_6 = math.floor(var_85_0 / 24 / 3600)
	local var_85_7 = math.floor((var_85_0 - var_85_6 * 24 * 3600) / 3600)
	local var_85_8 = math.floor((var_85_0 - var_85_6 * 24 * 3600 - var_85_7 * 3600) / 60)

	var_85_1 = arg_85_3 == 1 and (var_85_6 ~= 0 and string.format(L_TIME_SINGLE.Day, var_85_6) or var_85_7 ~= 0 and string.format(L_TIME_SINGLE.Hour, var_85_7) or string.format(L_TIME_SINGLE.Minute, var_85_8)) or var_85_6 ~= 0 and string.format(L_TIME_TEXT[1], var_85_6, var_85_7) or var_85_7 ~= 0 and string.format(L_TIME_TEXT[2], var_85_7, var_85_8) or string.format(L_TIME_TEXT[3], var_85_8)

	return (arg_85_2 or nil) and (arg_85_2 .. var_85_1 or L_TIME_REST2 .. L_TIME .. var_85_1)
end

function global_check_same_day(arg_86_0, arg_86_1)
	if not arg_86_0 or not arg_86_1 then
		return false
	end

	local var_86_0 = os.date("*t", arg_86_0)
	local var_86_1 = os.date("*t", arg_86_1)

	if var_86_0.year ~= var_86_1.year or var_86_0.month ~= var_86_1.month or var_86_0.day ~= var_86_1.day then
		return false
	else
		return true
	end
end

function global_canshow_live2d(arg_87_0)
	local model_data = require("data.model_data")

	if not model_data[arg_87_0] or not model_data[arg_87_0].live2d then
		return false
	end

	if model_data[arg_87_0] and model_data[arg_87_0].origin then
		return cc.UserDefault:getInstance():getBoolForKey("antihexie", false)
	else
		return true
	end
end

function global_canshow_spine(arg_88_0)
	local model_data = require("data.model_data")

	if not model_data[arg_88_0].rolespine then
		return false
	end

	if model_data[arg_88_0].origin == 2 then
		return cc.UserDefault:getInstance():getBoolForKey("antihexie", false)
	else
		return true
	end
end

function global_is_in_time(arg_89_0, arg_89_1)
	local var_89_0 = require("controller.time_check_manager"):getCurTime()

	if arg_89_0 and var_89_0 < os.time(parse_time(arg_89_0)) then
		return false
	end

	if arg_89_1 and var_89_0 > os.time(parse_time(arg_89_1)) then
		return false
	end

	return true
end

function global_getSpine(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	if arg_90_0 == nil then
		return
	end

	arg_90_1 = arg_90_1 or ""

	local var_90_0 = L2Skeleton:create(arg_90_0 .. ".json", arg_90_0 .. ".atlas", nil, true)

	var_90_0:refreshSkeleton()
	var_90_0:play(arg_90_1, arg_90_2)
	var_90_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_91_0)
		if type(arg_90_3) == "function" then
			arg_90_3(var_90_0)
		end
	end)

	return var_90_0
end

function global_c3b_parse(arg_92_0)
	if #arg_92_0 == 6 then
		return cc.c3b(tonumber(string.sub(arg_92_0, 1, 2), 16), tonumber(string.sub(arg_92_0, 3, 4), 16), (tonumber(string.sub(arg_92_0, 5, 6), 16)))
	end
end

function ui_delegate(arg_93_0)
	if arg_93_0 == nil then
		return nil
	end

	local function var_93_0(arg_94_0, arg_94_1)
		if #arg_94_0 == 0 then
			return nil
		end

		local var_94_1 = {}

		for iter_94_0, iter_94_1 in ipairs(arg_94_0) do
			local var_94_2 = iter_94_1:getChildByName(arg_94_1)

			if var_94_2 then
				return var_94_2
			end
		end

		for iter_94_2, iter_94_3 in ipairs(arg_94_0) do
			local var_94_3 = iter_94_3:getChildren()

			if #var_94_3 ~= 0 then
				for iter_94_4, iter_94_5 in ipairs(var_94_3) do
					table.insert(var_94_1, iter_94_5)
				end
			end
		end

		return var_93_0(var_94_1, arg_94_1)
	end

	local function var_93_1(arg_95_0, arg_95_1)
		return var_93_0({
			arg_95_0
		}, arg_95_1)
	end

	local var_93_2 = {
		nativeUI = arg_93_0
	}

	setmetatable(var_93_2, {
		__index = function(self, arg_96_1)
			local var_96_0 = var_93_1(self.nativeUI, arg_96_1)

			rawset(self, arg_96_1, var_96_0)

			return var_96_0
		end
	})

	return var_93_2
end

function global_check_sensitive(arg_97_0)
	if SensitiveChecker then
		return SensitiveChecker.censorStr(arg_97_0) ~= nil
	else
		return global_is_words_pass_against(arg_97_0)
	end
end

function global_is_words_pass_against(arg_98_0)
	if arg_98_0 == "" then
		return true
	end

	local sensitive_word_english = require("data.sensitive_word_english")

	if string.find(arg_98_0, "(%w+)%.(%w+)") then
		return false
	end

	if string.byte(arg_98_0, 1) < 127 then
		for iter_98_0, iter_98_1 in pairs(sensitive_word_english) do
			if string.find(arg_98_0, iter_98_0) then
				return false
			end
		end
	end

	for iter_98_2, iter_98_3 in pairs((require("data.sensitive_word_chinese"))) do
		if string.find(arg_98_0, iter_98_2) then
			for iter_98_4, iter_98_5 in pairs(iter_98_3) do
				if iter_98_4 ~= "key" and string.find(arg_98_0, iter_98_5) then
					return false
				end
			end
		end
	end

	return true
end

function UpdataTableData(arg_99_0, arg_99_1)
	if type(arg_99_0) == "table" and type(arg_99_1) == "table" then
		for iter_99_0, iter_99_1 in pairs(arg_99_1) do
			if type(iter_99_1) ~= "table" then
				arg_99_0[iter_99_0] = iter_99_1
			else
				arg_99_0[iter_99_0] = arg_99_0[iter_99_0] or {}

				UpdataTableData(arg_99_0[iter_99_0], iter_99_1)
			end
		end
	end
end

function GetCurrencyIconPath(arg_100_0, arg_100_1)
	arg_100_0 = tonumber(arg_100_0)

	local var_100_0 = {
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/UI_battleEnd_gold.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_100_0, {
		__index = function(arg_101_0, arg_101_1)
			return "public/currency/" .. require("data.item_data")[arg_101_1].image_id .. ".png"
		end
	})

	return var_100_0[arg_100_0]
end

function GetCurrencyIcon(arg_102_0, arg_102_1)
	arg_102_0 = tonumber(arg_102_0)

	return (require("view.Sprite.TempWidget"):CreateTempImg((GetCurrencyIconPath(arg_102_0, arg_102_1))))
end

function global_count_down_layer(arg_103_0, arg_103_1, arg_103_2)
	local time_check_manager = require("controller.time_check_manager")
	local var_103_1 = config._DEBUG and 0 or 1
	local var_103_2 = ccui.Layout:create()

	var_103_2:setBackGroundImageColor(cc.c3b(255, 255, 255))
	var_103_2:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
	var_103_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_103_2:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_103_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_103_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_103_2:setBackGroundColorOpacity(150)
	var_103_2:setTouchEnabled(true)
	var_103_2:setName("reward_layout")
	var_103_2:addTouchEventListener(function(arg_104_0, arg_104_1)
		if arg_104_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	var_103_2:registerScriptHandler(function(arg_105_0)
		if arg_105_0 == "exit" and var_103_2.scheduler then
			time_check_manager:removeUpdatePool(var_103_2.scheduler)

			var_103_2.scheduler = nil
		end
	end)

	local var_103_3 = ccui.ImageView:create("public/panelbg/count_down_bg.png", var_103_1)

	var_103_3:setPosition(cc.p(320, GameDisplay.height * 0.72))
	var_103_2:addChild(var_103_3)

	local var_103_4 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_103_4:setPosition(cc.p(276, 25))
	var_103_3:addChild(var_103_4)

	local var_103_5 = {
		231,
		210,
		190
	}
	local var_103_6 = ccui.ImageView:create("public/button/count_down_wait.png", var_103_1)

	var_103_6:setPosition(cc.p(190, 90))
	var_103_3:addChild(var_103_6)

	local var_103_7 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_103_1)

	var_103_7:setPosition(320, GameDisplay.height * 0.72 - 115)

	local var_103_8 = cc.Label:createWithTTF(L_STOP_ATUO_FIGHT[1], FONT_NAME, 22)

	var_103_8:setPosition(var_103_7:getContentSize().width / 2, var_103_7:getContentSize().height / 2)
	var_103_7:addChild(var_103_8)
	var_103_2:addChild(var_103_7)
	var_103_7:addTouchEventListener(function(arg_106_0, arg_106_1)
		if arg_106_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_103_2 then
			arg_103_2()
		end

		var_103_2:runAction(cc.RemoveSelf:create())
	end)

	var_103_2.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_103_0, function(arg_107_0)
		var_103_4:setString(arg_107_0)

		if arg_107_0 <= 0 and var_103_2.scheduler then
			if arg_103_1 then
				arg_103_1()
			end

			var_103_2:runAction(cc.RemoveSelf:create())
		else
			var_103_6:setPositionX(var_103_5[math.ceil(arg_107_0)])
		end
	end)))

	cc.Director:getInstance():getRunningScene():addChild(var_103_2, 99)

	return var_103_2
end

function iif(arg_108_0, arg_108_1, arg_108_2)
	return arg_108_0 and arg_108_1 or arg_108_2
end

function global_add_star(arg_109_0, arg_109_1, arg_109_2)
	if arg_109_0 == null or arg_109_1 <= 0 then
		return
	end

	arg_109_0:removeAllChildren()

	local var_109_0 = arg_109_1

	arg_109_1 = arg_109_1 % 5

	local var_109_1 = {}

	for iter_109_0 = 1, 5 do
		local var_109_4

		if config._DEBUG then
			var_109_4 = cc.Sprite:create(var_109_2) or cc.Sprite:createWithSpriteFrameName(var_109_2)
		end

		arg_109_0:addChild(var_109_4)
		var_109_4:setVisible(var_109_0 >= 5 or iter_109_0 <= arg_109_1)

		var_109_1[5 - (iter_109_0 - 1)] = var_109_4
	end

	if arg_109_2 then
		arg_109_2(var_109_1)
	end
end

function global_load_star(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	if arg_110_0 == null or arg_110_1 <= 0 then
		return
	end

	local var_110_0 = config._DEBUG and 0 or 1
	local var_110_1 = arg_110_1

	arg_110_1 = arg_110_1 % 5
	arg_110_3 = arg_110_3 or "star"

	local var_110_2 = {}

	for iter_110_0 = 1, 5 do
		local var_110_5 = arg_110_0:getChildByName(arg_110_3 .. iter_110_0)

		if var_110_5 then
			var_110_5:setVisible(var_110_1 >= 5 or iter_110_0 <= arg_110_1)
			var_110_5:loadTexture(var_110_3, var_110_0)

			var_110_2[5 - (iter_110_0 - 1)] = var_110_5
		end
	end

	if arg_110_2 then
		arg_110_2(var_110_2)
	end
end

function UIHelpHideBlackMask(arg_111_0, arg_111_1)
	if not arg_111_0 then
		return
	end

	local var_111_0

	if not arg_111_1 then
		arg_111_1 = {
			time = 0.4
		}
		var_111_0 = ccui.Layout:create()
	end

	var_111_0:setContentSize((arg_111_0:getContentSize()))
	var_111_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_111_0:setBackGroundColor(cc.c3b(0, 0, 0))
	arg_111_0:addChild(var_111_0, 1000)

	if not arg_111_1.time then
		-- block empty
	end

	var_111_0:runAction(cc.Sequence:create(cc.FadeOut:create(arg_111_1.time), cc.RemoveSelf:create()))
end

function global_spliet_web_url(arg_112_0)
	local var_112_0 = {}
	local var_112_1 = {}

	for iter_112_0, iter_112_1 in arg_112_0:gmatch("([^&=]+)=([^&]+)") do
		var_112_0[iter_112_0] = string.urldecode(iter_112_1)

		table.insert(var_112_1, iter_112_0)
	end

	return var_112_0, var_112_1
end

function global_sort_keys_by_ascii(arg_113_0)
	local function var_113_0(arg_114_0, arg_114_1)
		for iter_114_0 = 1, (#arg_114_0 < #arg_114_1 or nil) and (#arg_114_0 or #arg_114_1) do
			local var_114_0 = string.byte(arg_114_0, iter_114_0, iter_114_0)
			local var_114_1 = string.byte(arg_114_1, iter_114_0, iter_114_0)

			if var_114_0 ~= var_114_1 then
				return var_114_1 < var_114_0
			end
		end

		return #arg_114_0 > #arg_114_1
	end

	for iter_113_0 = 1, #arg_113_0 do
		for iter_113_1 = 1, #arg_113_0 - iter_113_0 do
			if var_113_0(arg_113_0[iter_113_1], arg_113_0[iter_113_1 + 1]) then
				arg_113_0[iter_113_1 + 1] = arg_113_0[iter_113_1]
				arg_113_0[iter_113_1] = arg_113_0[iter_113_1 + 1]
			end
		end
	end

	return arg_113_0
end

if config._DEBUG and DeviceManager.platform == "windows" then
	function umeng_pushSwitch(arg_115_0)
		return
	end
end

function global_check_is_show_push_open()
	if DeviceManager.getChannelID() == "270054" then
		return false
	end

	return umeng_pushSwitch and type(umeng_pushSwitch) == "function"
end

function global_show_appstar_and_debug()
	local var_117_0 = require("controller.account_manager"):getChannel()
	local channe_url_data = require("data.channe_url_data")

	if var_117_0 ~= "palmpi" then
		if not channe_url_data[var_117_0] then
			return
		end

		if not channe_url_data[var_117_0].appstar then
			return
		end
	else
		channe_url_data[var_117_0] = {}
	end

	layout = ccui.Layout:create()

	layout:setBackGroundImageColor(cc.c3b(255, 255, 255))
	layout:setContentSize(cc.size(cc.Director:getInstance():getVisibleSize().width, cc.Director:getInstance():getVisibleSize().height))
	layout:setAnchorPoint(cc.p(0.5, 0.5))
	layout:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	layout:setBackGroundColor(cc.c3b(0, 0, 0))
	layout:setBackGroundColorOpacity(180)
	layout:setTouchEnabled(true)
	layout:setName("write_layout")
	layout:addTouchEventListener(function(arg_118_0, arg_118_1)
		if arg_118_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	cc.Director:getInstance():getRunningScene():addChild(layout)

	local function var_117_2()
		if var_117_0 == "palmpi" then
			return true
		end

		return channe_url_data[var_117_0].dropid
	end

	local var_117_3 = ccui.ImageView:create(var_117_2() and "mainScenebg/appstar_and_debug/bg_2.png" or "mainScenebg/appstar_and_debug/bg.png")

	var_117_3:setTouchEnabled(true)
	var_117_3:setPosition(layout:getContentSize().width / 2, layout:getContentSize().height / 2 + 150)
	layout:addChild(var_117_3)

	local var_117_4 = ccui.Button:create("mainScenebg/appstar_and_debug/btn_appstar.png", nil, "mainScenebg/appstar_and_debug/btn_appstar.png")

	var_117_4:setPosition(cc.p(474, 40))
	var_117_3:addChild(var_117_4)
	var_117_4:addTouchEventListener(function(arg_120_0, arg_120_1)
		if arg_120_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.show_appstar_and_debug({
			action = "AppStar"
		})
		DeviceManager.openURL(channe_url_data[var_117_0].appstar or "https://www.taptap.com/app/42949/review")

		if var_117_2() then
			require("network.network"):rpc("get_guide_reward", {
				id = GUIDE_APPSTAR_AND_DEBUG
			}, function(arg_121_0)
				print(dump(arg_121_0))

				if arg_121_0.result == 1 then
					global_gain(arg_121_0)
				end
			end)
		end

		layout:runAction(cc.RemoveSelf:create())
	end)

	local var_117_5 = ccui.Button:create("mainScenebg/appstar_and_debug/btn_bug.png", nil, "mainScenebg/appstar_and_debug/btn_bug.png")

	var_117_5:setPosition(cc.p(275, 40))
	var_117_3:addChild(var_117_5)
	var_117_5:addTouchEventListener(function(arg_122_0, arg_122_1)
		if arg_122_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.show_appstar_and_debug({
			action = "Debug"
		})
		DeviceManager.openURL(channe_url_data[var_117_0].debug or "https://aokistudio.wjx.cn/vj/hFJDCHw.aspx")
		layout:runAction(cc.RemoveSelf:create())
	end)

	local var_117_6 = ccui.Button:create("mainScenebg/appstar_and_debug/btn_return.png", nil, "mainScenebg/appstar_and_debug/btn_return.png")

	var_117_6:setPosition(cc.p(120, 40))
	var_117_3:addChild(var_117_6)
	var_117_6:addTouchEventListener(function(arg_123_0, arg_123_1)
		if arg_123_1 ~= ccui.TouchEventType.ended then
			return
		end

		layout:runAction(cc.RemoveSelf:create())
		AnalyticManager.show_appstar_and_debug({
			action = "closed"
		})
		require("network.network"):rpc("reset_guide_stat", {
			id = GUIDE_APPSTAR_AND_DEBUG
		}, function(arg_124_0)
			return
		end)
	end)
	AnalyticManager.show_appstar_and_debug({
		action = "join"
	})

	return layout
end

function registerCCEvent(arg_125_0, arg_125_1, arg_125_2)
	arg_125_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_125_1, arg_125_2), arg_125_0)
end

function GetPrivilegeGoldDropMarkup()
	local supermarket_privilege_manager = require("controller.supermarket_privilege_manager")

	return supermarket_privilege_manager:getInstance():getGoldDropMarkup() + require("controller.supermarket_privilege_recharge_manager").getInstance(supermarket_privilege_manager):getGoldDropMarkup()
end

function GetPrivilegeSpDropMarkup()
	local supermarket_privilege_manager = require("controller.supermarket_privilege_manager")

	return supermarket_privilege_manager:getInstance():getSpDropMarkup() + require("controller.supermarket_privilege_recharge_manager").getInstance(supermarket_privilege_manager):getSpDropMarkup()
end

function GetPrivilegeWarCompetitivePointMarkup()
	local supermarket_privilege_manager = require("controller.supermarket_privilege_manager")

	return supermarket_privilege_manager:getInstance():getWarCompetitivePointMarkup() + require("controller.supermarket_privilege_recharge_manager").getInstance(supermarket_privilege_manager):getWarCompetitivePointMarkup()
end

function IsOpenPrivilege()
	local supermarket_privilege_manager = require("controller.supermarket_privilege_manager")

	return supermarket_privilege_manager:getInstance():isOpenPrivilege() or require("controller.supermarket_privilege_recharge_manager").getInstance(supermarket_privilege_manager):isOpenPrivilege()
end

function GetPrivilegeRemainDay()
	local supermarket_privilege_manager = require("controller.supermarket_privilege_manager")
	local var_130_1 = supermarket_privilege_manager:getInstance()
	local var_130_2 = require("controller.supermarket_privilege_recharge_manager").getInstance(supermarket_privilege_manager)

	if var_130_1:isOpenPrivilege() then
		return var_130_1:getRemainDay()
	end

	if var_130_2:isOpenPrivilege() then
		return var_130_2:getRemainDay()
	end

	return 0
end

function Global_format_time_str(arg_131_0)
	if arg_131_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_131_0 / 86400), math.floor(arg_131_0 % 86400 / 3600))
	elseif arg_131_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_131_0 / 3600), math.floor(arg_131_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[4], math.floor(arg_131_0 / 60), math.floor(arg_131_0 % 60))
	end
end

function Global_save_day_end_time(arg_132_0, arg_132_1)
	local var_132_0 = os.date("*t", arg_132_1 or require("controller.time_check_manager"):getCurTime())
	local var_132_1 = RoleDefault:getInstance():setIntegerForKey(arg_132_0, (os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = var_132_0.year,
		month = var_132_0.month,
		day = var_132_0.day
	})))
end

function sendNotification(arg_133_0, arg_133_1)
	require("controller/layer_notification_manager"):getInstance():sendNotification(arg_133_0, arg_133_1)
end

function getArenaEnemyHorcruxDevour(arg_134_0)
	local arena_manager

	if HORCRUX_DEVOUR_FIGHT_TYPE == 1 then
		arena_manager = require("controller.arena_manager")
	elseif HORCRUX_DEVOUR_FIGHT_TYPE == 2 then
		arena_manager = require("controller.scorearena_manager")
	elseif HORCRUX_DEVOUR_FIGHT_TYPE == 3 then
		arena_manager = require("controller.friend_system_manager")
	elseif HORCRUX_DEVOUR_FIGHT_TYPE == 4 then
		arena_manager = require("controller.arenatft_manager")
	end

	local var_134_1 = {}

	if arena_manager then
		var_134_1 = arena_manager:getArenaEnemyHorcruxDevour(arg_134_0)
	else
		for iter_134_0 = 1, HORCRUX_DEVOUR_MAX do
			var_134_1[iter_134_0] = {}
		end
	end

	return var_134_1
end

function global_is_in_time(arg_135_0, arg_135_1)
	print("starttime", arg_135_0, arg_135_1)

	local var_135_0 = require("controller.time_check_manager"):getCurTime()

	if arg_135_0 and var_135_0 < os.time(parse_time(arg_135_0)) then
		return false
	end

	if arg_135_1 and var_135_0 > os.time(parse_time(arg_135_1)) then
		return false
	end

	return true
end

function global_get_levelmode_ele_type(arg_136_0)
	local levelmode_data = require("data.levelmode_data")

	if levelmode_data[arg_136_0] and (levelmode_data[arg_136_0].ele_type or levelmode_data[arg_136_0].element_type) then
		local var_136_1 = levelmode_data[arg_136_0].ele_type or levelmode_data[arg_136_0].element_type

		if levelmode_data[arg_136_0].ele_type_show then
			var_136_1 = levelmode_data[arg_136_0].ele_type_show
		end

		if levelmode_data[arg_136_0].element_type == "all" then
			return
		end

		return var_136_1
	end
end

function global_can_doyin_show(arg_137_0)
	if not DeviceManager.getChannelID() == "999" then
		return true
	end

	if ({
		[209020] = true
	})[arg_137_0] then
		return false
	end

	return true
end

function global_update_music_volume(arg_138_0)
	if DeviceManager.getChannelID() ~= "270055" then
		return
	end

	if not arg_138_0 then
		return
	end

	local audio_manager = require("controller.audio_manager")
	local var_138_1 = math.min(3, (math.max(0, cc.UserDefault:getInstance():getIntegerForKey("music_volume", 2) + arg_138_0)))

	cc.UserDefault:getInstance():setIntegerForKey("music_volume", var_138_1)

	audio_manager.music_volume = var_138_1

	audio_manager:setMusicVolume()
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("UPDATE_VOLUME")))
end

local function var_0_3(arg_139_0)
	local var_139_0 = -1
	local var_139_1 = require("data.horcrux_data")[arg_139_0].horcruxt

	for iter_139_0, iter_139_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_139_0 == iter_139_1.item_id then
			var_139_0 = iter_139_0

			break
		end
	end

	if var_139_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_139_0,
		itemid = arg_139_0
	})
end

function create_item_icon(arg_140_0, arg_140_1, arg_140_2, arg_140_3, arg_140_4)
	local component_manager = require("controller.component_manager")
	local item_manager = require("controller.item_manager")
	local model_data = require("data.model_data")
	local item_data = require("data.item_data")
	local var_140_5
	local var_140_6
	local var_140_7

	if not arg_140_2 then
		local var_140_8 = require("controller.drop_manager"):getDropMsg(arg_140_0)

		if var_140_8.gold ~= 0 then
			var_140_5 = "gold"
			var_140_6 = var_140_8.gold
		elseif var_140_8.diamond ~= 0 then
			var_140_5 = "diamond"
			var_140_6 = var_140_8.diamond
		elseif var_140_8.equips then
			var_140_5 = var_140_8.equips[1].dropid
			var_140_6 = var_140_8.equips[1].itemNum
			var_140_7 = var_140_8.equips[1].itemattr
		end
	else
		var_140_5 = arg_140_2
		var_140_6 = arg_140_3
		var_140_7 = arg_140_4
	end

	local var_140_9 = ccui.ImageView:create()

	if item_data[var_140_5].bag_item_type == kITEM_SKIN then
		var_140_9:loadTexture("roleimage/role1/" .. model_data[item_data[var_140_5].model].cute_role .. ".png")
		var_140_9:setScale(0.3)
	elseif item_data[var_140_5].bag_item_type == kITEM_HORCRUX then
		local var_140_10 = ccui.Layout:create()

		var_140_10:setName("starsPanel")
		var_140_10:setScale(1.75)
		var_140_10:setPositionY(58)
		var_140_10:setPositionX(200)
		var_140_9:addChild(var_140_10, 5)

		local var_140_11 = 0

		if var_140_7 then
			for iter_140_0, iter_140_1 in var_140_7:gmatch("([^&]+)=([^&]+)") do
				if iter_140_0 == "star" then
					var_140_11 = tonumber(iter_140_1)
				end
			end
		end

		for iter_140_2 = 1, var_140_11 do
			local var_140_12

			if config._DEBUG then
				var_140_12 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_140_12:setPosition(25, (iter_140_2 - 1) * 24 - 30)
			var_140_10:addChild(var_140_12)
		end

		var_140_9:loadTexture("equipment/" .. item_data[var_140_5].image_id .. ".png")
		var_140_9:setScale(0.3)
	elseif item_data[var_140_5].bag_item_type == kITEM_COMPONENT then
		var_140_9:removeFromParent()

		var_140_9 = nil
		var_140_9 = component_manager:create_component_icon(var_140_5)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_140_9:setScale(0.75)
	elseif item_data[var_140_5].image_id then
		var_140_9:loadTexture("equipment/" .. item_data[var_140_5].image_id .. ".png")
		var_140_9:setScale(0.75)
	end

	var_140_9:setTouchEnabled(arg_140_1)
	var_140_9:addTouchEventListener(function(arg_141_0, arg_141_1)
		if arg_141_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_140_5].bag_item_type == kITEM_HORCRUX then
			var_0_3(var_140_5)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_140_5
			})
		end
	end)

	return var_140_9, var_140_6
end
