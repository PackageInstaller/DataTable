function string_split(arg_1_0, arg_1_1)
	local var_1_0 = {}

	while true do
		local var_1_1 = string.find(arg_1_0, arg_1_1, 1)

		if not var_1_1 then
			var_1_0[1] = string.sub(arg_1_0, 1, string.len(arg_1_0))

			break
		end

		var_1_0[1] = string.sub(arg_1_0, 1, var_1_1 - 1)

		local var_1_2 = var_1_1 + string.len(arg_1_1)
	end

	return var_1_0
end

function l2Log(arg_2_0, arg_2_1)
	arg_2_0 = arg_2_0 or "nil"
end

function handler(arg_3_0, arg_3_1)
	return function(...)
		return arg_3_1(arg_3_0, ...)
	end
end

function readFile(arg_5_0)
	local var_5_0 = assert(io.open(arg_5_0, "r"), "not the file")

	if var_5_0 then
		return (var_5_0:read("*all"))
	end

	var_5_0:close(errorInfo)
end

function writeFile(arg_6_0, arg_6_1)
	local var_6_0 = assert(io.open(arg_6_0, "a+"), "not the file")

	if var_6_0 then
		var_6_0:write(arg_6_1)
	end

	var_6_0:close()
end

function setSwallowTouchesListenner(arg_7_0)
	if not arg_7_0 then
		return
	end

	local var_7_0 = cc.EventListenerTouchOneByOne:create()

	var_7_0:setSwallowTouches(true)
	var_7_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		if arg_7_0 and arg_7_0.crossRect then
			if cc.rectContainsPoint(arg_7_0.crossRect, (arg_8_0:getLocation())) then
				local var_8_0 = cc.Director:getInstance():convertToUI((cc.p(cc.rectGetMidX(arg_7_0.crossRect), cc.rectGetMidY(arg_7_0.crossRect))))

				arg_8_0:setTouchInfo(arg_8_0:getId(), var_8_0.x, var_8_0.y)

				if arg_7_0.crossCallback then
					arg_7_0.crossCallback()
				end

				return false
			else
				return true
			end
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_7_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		return
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_7_0:registerScriptHandler(function(arg_10_0, arg_10_1)
		return
	end, cc.Handler.EVENT_TOUCH_ENDED)
	arg_7_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_7_0, arg_7_0)
end

FingerSpriteID = 153

local var_0_2 = 154
local var_0_3 = 155
local var_0_4 = 156

function setFinger(arg_11_0, arg_11_1)
	if not arg_11_0 or not arg_11_1 then
		return
	end

	local var_11_0 = cc.p(arg_11_1.x, arg_11_1.y)

	for iter_11_0, iter_11_1 in pairs({
		{
			opacity = 0,
			image = "effect/touchEffect/guideCircle1.png",
			action = cc.Sequence:create(cc.DelayTime:create(0.4), cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 1.12), cc.FadeOut:create(0.2), cc.DelayTime:create(0.2)),
			pos = var_11_0,
			tag = var_0_4,
			anchorPoint = cc.p(0.5, 0.5)
		},
		{
			opacity = 0,
			image = "effect/touchEffect/guideCircle1.png",
			action = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 1.12), cc.FadeOut:create(0.2), cc.DelayTime:create(0.4))),
			pos = var_11_0,
			tag = var_0_3,
			anchorPoint = cc.p(0.5, 0.5)
		},
		{
			opacity = 0,
			image = "effect/touchEffect/guideCircle2.png",
			action = cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 1.12), cc.FadeOut:create(0.2), cc.DelayTime:create(0.6))),
			pos = var_11_0,
			tag = var_0_2,
			anchorPoint = cc.p(0.5, 0.5)
		},
		{
			opacity = 255,
			image = "guide/finger.png",
			action = cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.6, 1.2), cc.ScaleTo:create(0.6, 1))),
			pos = arg_11_1,
			tag = FingerSpriteID,
			anchorPoint = cc.p(0, 1)
		}
	}) do
		local var_11_1 = arg_11_0:getChildByTag(iter_11_1.tag)

		if not var_11_1 then
			var_11_1 = cc.Sprite:create(iter_11_1.image)

			var_11_1:setAnchorPoint(iter_11_1.anchorPoint)
			var_11_1:setOpacity(iter_11_1.opacity)
			var_11_1:runAction(iter_11_1.action)
			arg_11_0:addChild(var_11_1, 101)
		end

		var_11_1:setPosition(iter_11_1.pos)

		if iter_11_1.tag == FingerSpriteID then
			local var_11_2 = false
			local var_11_3 = 0
			local var_11_4 = 0

			if iter_11_1.pos.y <= var_11_1:getContentSize().height then
				var_11_4 = -90
			end

			if iter_11_1.pos.x >= 640 - var_11_1:getContentSize().width then
				var_11_2 = true
				var_11_3 = 1
				var_11_4 = -1 * var_11_4
			end

			var_11_1:setRotation(var_11_4)
			var_11_1:setAnchorPoint(cc.p(var_11_3, 1))
			var_11_1:setFlippedX(var_11_2)
		end
	end
end

function setFingerVisible(arg_12_0, arg_12_1)
	if not arg_12_0 then
		return
	end

	for iter_12_0, iter_12_1 in pairs({
		FingerSpriteID,
		var_0_2,
		var_0_3,
		var_0_4
	}) do
		local var_12_0 = arg_12_0:getChildByTag(iter_12_1)

		if var_12_0 then
			var_12_0:setVisible(arg_12_1)
		end
	end
end

function utfstrlen(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while #arg_13_0 > 0 do
		local var_13_2 = string.byte(arg_13_0, -#arg_13_0)

		while var_13_1[#var_13_1] do
			if var_13_2 >= var_13_1[#var_13_1] then
				break
			end
		end

		var_13_0 = var_13_0 + 1
	end

	return var_13_0
end

function utfsub(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	if #arg_14_0 <= arg_14_1 then
		return arg_14_0
	end

	while var_14_0 < #arg_14_0 do
		local var_14_2 = string.byte(arg_14_0, var_14_0 + 1)

		while var_14_1[#var_14_1] do
			if var_14_2 >= var_14_1[#var_14_1] then
				var_14_0 = var_14_0 + #var_14_1

				break
			end
		end

		if arg_14_1 < var_14_0 + 1 then
			return string.sub(arg_14_0, 1, var_14_0)
		end
	end

	return nil
end

function utfmatch(arg_15_0, arg_15_1)
	if #arg_15_0 <= arg_15_1 then
		return arg_15_0
	end

	local var_15_0 = #arg_15_0
	local var_15_1 = 0
	local var_15_2 = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while var_15_0 > 0 and 0 < arg_15_1 do
		local var_15_3 = string.byte(arg_15_0, -var_15_0)
		local var_15_4 = #var_15_2

		while var_15_2[var_15_4] do
			if var_15_3 >= var_15_2[var_15_4] then
				var_15_0 = var_15_0 - var_15_4
				var_15_1 = var_15_1 + var_15_4

				break
			end

			var_15_4 = var_15_4 - 1
		end

		if var_15_4 == 0 then
			var_15_1 = var_15_1 + 1
		end
	end

	return utfsub(arg_15_0, var_15_1)
end

function utf8tochars(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or 1

	local var_16_0 = {}
	local var_16_1 = 1

	while var_16_1 <= string.len(arg_16_0) do
		local var_16_3 = string.byte(arg_16_0, var_16_1)
		local var_16_4 = 1

		if var_16_3 < 192 then
			var_16_4 = 1
		elseif var_16_3 < 224 then
			var_16_4 = 2
		elseif var_16_3 < 240 then
			var_16_4 = 3
		elseif var_16_3 < 248 then
			var_16_4 = 4
		else
			local var_16_5

			if var_16_3 < 252 then
				var_16_5 = string.sub(arg_16_0, var_16_1, var_16_1 + 5 * arg_16_1 - 1)
			end
		end

		var_16_1 = var_16_1 + 5 * arg_16_1

		table.insert(var_16_0, var_16_5)
	end

	return var_16_0
end

function subStringUTF8(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 < 0 then
		arg_17_1 = subStringGetTotalIndex(arg_17_0) + arg_17_1 + 1
	end

	if arg_17_2 ~= nil and arg_17_2 < 0 then
		arg_17_2 = subStringGetTotalIndex(arg_17_0) + arg_17_2 + 1
	end

	if arg_17_2 == nil then
		return string.sub(arg_17_0, subStringGetTrueIndex(arg_17_0, arg_17_1))
	else
		return string.sub(arg_17_0, subStringGetTrueIndex(arg_17_0, arg_17_1), subStringGetTrueIndex(arg_17_0, arg_17_2 + 1) - 1)
	end
end

function subStringGetTotalIndex(arg_18_0)
	local var_18_0 = 0

	repeat
		local var_18_2 = subStringGetByteCount(arg_18_0, 1)

		var_18_0 = var_18_0 + 1
	until var_18_2 == 0

	return var_18_0 - 1
end

function subStringGetTrueIndex(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 1
	local var_19_2 = 1

	repeat
		var_19_2 = subStringGetByteCount(arg_19_0, var_19_1)
		var_19_1 = var_19_1 + var_19_2
		var_19_0 = var_19_0 + 1
	until arg_19_1 <= var_19_0

	return var_19_1 - var_19_2
end

function subStringGetByteCount(arg_20_0, arg_20_1)
	local var_20_0 = string.byte(arg_20_0, arg_20_1)
	local var_20_1 = 1

	if var_20_0 == nil then
		var_20_1 = 0
	elseif var_20_0 > 0 and var_20_0 <= 127 then
		var_20_1 = 1
	elseif var_20_0 >= 192 and var_20_0 <= 223 then
		var_20_1 = 2
	elseif var_20_0 >= 224 and var_20_0 <= 239 then
		var_20_1 = 3
	elseif var_20_0 >= 240 and var_20_0 <= 247 then
		var_20_1 = 4
	end

	return var_20_1
end
