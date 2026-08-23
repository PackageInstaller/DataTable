local var_0_0 = {}

var_0_0._info = nil
var_0_0._data = nil
var_0_0.BORDER_TYPE = {
	GREY = 5,
	YELLOW = 4,
	WHITE = 3,
	RED = 2,
	GREEN = 1
}

function var_0_0.p2s(arg_1_0, arg_1_1)
	return arg_1_0 .. "_" .. arg_1_1
end

function var_0_0.p3s(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 and arg_2_1 and arg_2_2 then
		return arg_2_0 .. "_" .. arg_2_1 .. "_" .. arg_2_2
	end

	return ""
end

function var_0_0.s2p(arg_3_0)
	local var_3_0 = string.split(arg_3_0, "_")

	if var_3_0[1] and var_3_0[2] then
		return tonumber(var_3_0[1]), tonumber(var_3_0[2])
	end

	return 0, 0
end

function var_0_0:setTileMapInfo()
	var_0_0._info = self
	var_0_0._data = self.data
end

function var_0_0.p2rc(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = var_0_0.getConstIncludeNum() * var_0_0.getConstShowNum()
	local var_5_1 = arg_5_2 or var_0_0.getUnitCellWidth()
	local var_5_2 = arg_5_3 or var_0_0.getUnitCellHeight()
	local var_5_3 = arg_5_0 - var_5_1 * var_5_0 / 2

	return math.floor((math.min(math.max(var_5_3 / var_5_1 - (arg_5_1 - var_5_2 * var_5_0) / var_5_2, 0), var_5_0 - 1))), math.floor((math.min(math.max(-((arg_5_1 - var_5_2 * var_5_0) / var_5_2 + var_5_3 / var_5_1), 0), var_5_0 - 1)))
end

function var_0_0.rc2p(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = var_0_0.getConstIncludeNum() * var_0_0.getConstShowNum()
	local var_6_1 = arg_6_2 or var_0_0.getUnitCellWidth()
	local var_6_2 = arg_6_3 or var_0_0.getUnitCellHeight()
	local var_6_3 = cc.size(var_6_1 * var_6_0, var_6_2 * var_6_0)

	return var_6_3.width * 0.5 + (arg_6_0 - arg_6_1) * var_6_1 * 0.5, var_6_3.height + (-(arg_6_0 + arg_6_1) * var_6_2 * 0.5 - var_6_2 * 0.5)
end

function var_0_0.vc2p(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = var_0_0.vc2rc(arg_7_0, arg_7_1)
	local var_7_2, var_7_3 = var_0_0.rc2p(var_7_0, var_7_1)

	return var_7_2, var_7_3
end

function var_0_0.p2vc(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = var_0_0.p2rc(arg_8_0, arg_8_1)
	local var_8_2, var_8_3 = var_0_0.rc2vc(var_8_0, var_8_1)

	return var_8_2, var_8_3
end

function var_0_0.rc2vc(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.getConstVerTex()

	return arg_9_0 - (var_9_0.VIRTUAL_LEFT.x + (var_9_0.VIRTUAL_LEFT.y == var_9_0.VIRTUAL_LEFT.y and 1 or 0)) - (arg_9_1 - var_9_0.VIRTUAL_LEFT.y), arg_9_0 + arg_9_1 - (var_9_0.VIRTUAL_LEFT.x + (var_9_0.VIRTUAL_LEFT.y == var_9_0.VIRTUAL_LEFT.y and 1 or 0) + var_9_0.VIRTUAL_LEFT.y)
end

function var_0_0.vc2rc(arg_10_0, arg_10_1)
	local var_10_0 = var_0_0.getConstVerTex()

	return math.floor((arg_10_0 + arg_10_1 + 2 * (var_10_0.VIRTUAL_LEFT.x + (var_10_0.VIRTUAL_LEFT.y == var_10_0.VIRTUAL_LEFT.y and 1 or 0))) * 0.5), math.floor((arg_10_1 - arg_10_0 + 2 * var_10_0.VIRTUAL_LEFT.y) * 0.5)
end

function var_0_0.rc2uc(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.getConstIncludeNum()

	return math.floor(arg_11_0 / var_11_0), math.floor(arg_11_1 / var_11_0), arg_11_0 % var_11_0, arg_11_1 % var_11_0
end

function var_0_0.uc2p(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_0.getConstIncludeNum()
	local var_12_1 = var_12_0 * var_0_0.getConstShowNum()
	local var_12_2 = arg_12_2 or var_0_0.getUnitCellWidth()
	local var_12_3 = arg_12_3 or var_0_0.getUnitCellHeight()
	local var_12_4 = cc.size(var_12_2 * var_12_1, var_12_3 * var_12_1)

	return var_12_4.width * 0.5 + (arg_12_0 - arg_12_1) * (var_12_2 * var_12_0) * 0.5, var_12_4.height + (-(arg_12_0 + arg_12_1) * (var_12_3 * var_12_0) * 0.5 - var_12_3 * var_12_0 * 0.5)
end

function var_0_0:_getUnitMapBigTileLayer(arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or "terrain"

	local var_13_0, var_13_1, var_13_2, var_13_3 = var_0_0.rc2uc(arg_13_1, arg_13_2)

	if self[var_13_0] and self[var_13_0][var_13_1] then
		return self[var_13_0][var_13_1]:getLayer(arg_13_3), var_13_2, var_13_3
	end

	return nil, var_13_2, var_13_3
end

function var_0_0.getUnitMapTile(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_3 = arg_14_3 or "terrain"

	local var_14_0, var_14_1, var_14_2 = var_0_0._getUnitMapBigTileLayer(arg_14_0, arg_14_1, arg_14_2, arg_14_3)

	if var_14_0 then
		return var_14_0:getTileAt(cc.p(var_14_1, var_14_2))
	end

	return nil
end

function var_0_0.getArea(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_2 = arg_15_2 or 1

	local var_15_0 = cc.p(arg_15_0 - arg_15_2, arg_15_1)
	local var_15_1 = {}
	local var_15_2 = var_15_0.y

	for iter_15_0 = 1, arg_15_2 + 1 do
		local var_15_3 = var_15_0.x + iter_15_0 - 1
		local var_15_4 = var_15_2

		for iter_15_1 = 1, arg_15_2 + 1 do
			if not arg_15_3 or arg_15_3[var_15_3 .. "_" .. var_15_4] then
				var_15_1[#var_15_1 + 1] = {
					x = var_15_3,
					y = var_15_4
				}
			end

			var_15_4 = var_15_4 - 1
			var_15_3 = var_15_3 + 1
		end

		var_15_2 = var_15_2 + 1
	end

	local var_15_6 = var_15_0.y

	for iter_15_2 = 1, arg_15_2 + 1 - 1 do
		local var_15_7 = var_15_0.x + iter_15_2
		local var_15_8 = var_15_6

		for iter_15_3 = 1, arg_15_2 + 1 - 1 do
			if not arg_15_3 or arg_15_3[var_15_7 .. "_" .. var_15_8] then
				var_15_1[#var_15_1 + 1] = {
					x = var_15_7,
					y = var_15_8
				}
			end

			var_15_8 = var_15_8 - 1
			var_15_7 = var_15_7 + 1
		end

		var_15_6 = var_15_6 + 1
	end

	return var_15_1
end

function var_0_0.isInArea(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or 1

	local var_16_0 = cc.p(arg_16_0 - arg_16_2, arg_16_1)
	local var_16_1 = cc.p(arg_16_0 + arg_16_2, arg_16_1)
	local var_16_2, var_16_3 = var_0_0.rc2p(var_16_0.x, var_16_0.y)
	local var_16_4, var_16_5 = var_0_0.rc2p(var_16_1.x, var_16_1.y)

	if var_16_2 <= arg_16_3.x and var_16_3 <= arg_16_3.x and var_16_4 <= arg_16_3.y and var_16_5 <= arg_16_3.y then
		return true
	end

	return false
end

function var_0_0.getDiamondArea(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	return var_0_0.getDiamondAreaByTopPos(cc.p(arg_17_0 - arg_17_2, arg_17_1 - arg_17_2), arg_17_2 * 2 + 1, arg_17_3)
end

function var_0_0:getDiamondAreaByTopPos(arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0 = 0, arg_18_1 - 1 do
		for iter_18_1 = 0, arg_18_1 - 1 do
			local var_18_2 = {
				x = self.x + iter_18_0,
				y = self.y + iter_18_1
			}

			if not arg_18_2 or arg_18_2[var_18_2.x .. "_" .. var_18_2.y] then
				var_18_2.dirX = (var_18_2.x - self.x) / (arg_18_1 - 1)
				var_18_2.dirY = (var_18_2.y - self.y) / (arg_18_1 - 1)

				if math.floor(var_18_2.dirX) == math.ceil(var_18_2.dirX) or math.floor(var_18_2.dirY) == math.ceil(var_18_2.dirY) then
					var_18_1[#var_18_1 + 1] = var_18_2
				end

				var_18_0[#var_18_0 + 1] = var_18_2
			end
		end
	end

	return var_18_0, var_18_1
end

function var_0_0.getFortDiamondArea(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs({
		{
			x = arg_19_0,
			y = arg_19_1
		},
		{
			x = arg_19_0 + 1,
			y = arg_19_1
		},
		{
			x = arg_19_0 + 1,
			y = arg_19_1 + 1
		},
		{
			x = arg_19_0,
			y = arg_19_1 + 1
		}
	}) do
		var_19_0[#var_19_0 + 1] = iter_19_1
	end

	return var_19_0
end

function var_0_0:convertText(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = self:getChild(arg_20_1)

	var_20_0:removeFromParent()

	local var_20_1 = ccui.Text:create(var_20_0:getText(), arg_20_3 or FONT_PATH, var_20_0:getFontSize())

	var_20_1:setAnchorPoint(var_20_0:getPivot())
	var_20_1:setTextColor(var_20_0:getColor())
	var_20_1:setPosition(var_20_0:getX(), self:getSize().height - var_20_0:getY())

	if arg_20_2 then
		var_20_1:enableOutline(var_20_0:getOutlineColor(), 1)
	end

	return var_20_1
end

function var_0_0:convertText2(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self:getChild(arg_21_1)

	var_21_0:removeFromParent()

	local var_21_1 = ccui.Text:create(var_21_0:getText(), arg_21_3 or FONT_PATH, var_21_0:getFontSize())

	var_21_1:setAnchorPoint(cc.p(var_21_0:getPivot().x, 1 - var_21_0:getPivot().y))
	var_21_1:setTextColor(var_21_0:getColor())
	var_21_1:setPosition(var_21_0:getX(), self:getSize().height - var_21_0:getY())

	if arg_21_2 then
		var_21_1:enableOutline(var_21_0:getOutlineColor(), 2)
	end

	return var_21_1
end

function var_0_0.setQualityColor(arg_22_0, arg_22_1, arg_22_2)
	return
end

function var_0_0:setString(arg_23_1)
	arg_23_1 = var_0_0.getChangeText(arg_23_1)
	arg_23_1 = string.gsub(arg_23_1, "%d+", function(arg_24_0)
		local var_24_0 = tonumber(arg_24_0)

		if var_24_0 then
			if var_24_0 >= math.pow(10, 14) then
				var_24_0 = (var_24_0 - var_24_0 % math.pow(10, 10)) / math.pow(10, 12)
				arg_24_0 = var_24_0 .. g.core.lang:get("WANYI")
			elseif var_24_0 >= math.pow(10, 10) then
				var_24_0 = (var_24_0 - var_24_0 % math.pow(10, 6)) / math.pow(10, 8)
				arg_24_0 = var_24_0 .. g.core.lang:get("YI")
			elseif var_24_0 >= math.pow(10, 6) then
				arg_24_0 = (var_24_0 - var_24_0 % math.pow(10, 4)) / math.pow(10, 4) .. g.core.lang:get("WAN")
			end

			return arg_24_0
		end
	end)

	if self then
		self:setString(arg_23_1)
	end
end

function var_0_0.getChangeText(arg_25_0)
	if arg_25_0 == nil then
		return ""
	end

	local var_25_0 = arg_25_0

	if type(arg_25_0) == "number" then
		var_25_0 = string.format("%d", var_25_0)
	else
		local var_25_1 = string.match(var_25_0, "%d+.%d+e%+%d+")

		while var_25_1 do
			var_25_1 = string.gsub(var_25_1, "e%+", "e%%+")
			var_25_0 = string.gsub(var_25_0, var_25_1, (string.gsub(string.format("%18.0f", tonumber(var_25_1)), "%s+", "")))
			var_25_1 = string.match(var_25_0, "%d+.%d+e%+%d+")
		end
	end

	return var_25_0
end

function var_0_0:convertNode(arg_26_1, arg_26_2)
	local var_26_0 = self:getChild(arg_26_1)
	local var_26_1

	if arg_26_2 then
		var_26_1 = var_26_0:popDisplayObject()

		var_26_1:setAnchorPoint((var_26_0:getPivot()))
		var_26_1:setPosition(var_26_0:getX(), self:getSize().height - var_26_0:getY())
	else
		var_26_1 = var_26_0:displayObject()
	end

	return var_26_1
end

function var_0_0:convertProg(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = self:getChild(arg_27_1)
	local var_27_1 = var_27_0:getChild(arg_27_2)

	var_27_1:setVisible(false)
	arg_27_3:setContentSize(cc.size(var_27_0:getWidth() - arg_27_5 or 0, var_27_1:getHeight()))

	local var_27_2 = cc.ProgressTimer:create(arg_27_3)

	var_27_2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_27_2:setAnchorPoint(0, 0)

	arg_27_4 = arg_27_4 or 1

	if arg_27_4 == 0 then
		var_27_2:setMidpoint(cc.p(1, 0))
		var_27_2:setBarChangeRate(cc.p(1, 0))
	elseif arg_27_4 == 1 then
		var_27_2:setMidpoint(cc.p(0, 0))
		var_27_2:setBarChangeRate(cc.p(1, 0))
	end

	var_27_2:setPercentage(50)
	var_27_2:setPosition(var_27_1:getPosition())
	var_27_0:displayObject():addChild(var_27_2)

	return var_27_2
end

function var_0_0.convertProg2(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = cc.ProgressTimer:create(arg_28_0)

	var_28_0:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_28_0:setAnchorPoint(0, 0)

	arg_28_1 = arg_28_1 or 1

	if arg_28_1 == 0 then
		var_28_0:setMidpoint(cc.p(1, 0))
		var_28_0:setBarChangeRate(cc.p(1, 0))
	elseif arg_28_1 == 1 then
		var_28_0:setMidpoint(cc.p(0, 0))
		var_28_0:setBarChangeRate(cc.p(1, 0))
	end

	var_28_0:setPercentage(50)
	var_28_0:setPosition(cc.p(arg_28_2.x, arg_28_2.y))

	return var_28_0
end

function var_0_0:convertProgCircle(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = self:getChild(arg_29_1)
	local var_29_1 = cc.ProgressTimer:create((var_29_0:getChild(arg_29_2):popDisplayObject()))

	var_29_1:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_29_1:setPercentage(50)
	var_29_1:setRotation(-180)
	var_29_0:getChild(arg_29_3):displayObject():addChild(var_29_1)

	return var_29_1
end

function var_0_0.normalize(arg_30_0, arg_30_1)
	if arg_30_0 * arg_30_0 + arg_30_1 * arg_30_1 == 1 then
		return cc.p(arg_30_0, arg_30_1)
	end

	if arg_30_0 * arg_30_0 + arg_30_1 * arg_30_1 == 0 then
		return cc.p(arg_30_0, arg_30_1)
	end

	local var_30_0 = 1 / math.sqrt(arg_30_0 * arg_30_0 + arg_30_1 * arg_30_1)

	arg_30_0 = arg_30_0 * var_30_0
	arg_30_1 = arg_30_1 * var_30_0

	return cc.p(arg_30_0, arg_30_1)
end

function var_0_0.getData()
	return var_0_0._data
end

function var_0_0.getTiledMapPath(arg_32_0, arg_32_1)
	return var_0_0._data:getMapPath(tostring(arg_32_0), tostring(arg_32_1))
end

function var_0_0.getCsvPath(arg_33_0)
	return var_0_0._data:getCsvPath(arg_33_0)
end

function var_0_0:updateCsvData(arg_34_1)
	if not self then
		self = {}

		for iter_34_0, iter_34_1 in ipairs((string.split(cc.FileUtils:getInstance():getStringFromFile((var_0_0.getCsvPath(arg_34_1))), "\n"))) do
			self[iter_34_0] = self[iter_34_0] or {}
			self[iter_34_0] = string.split(iter_34_1, ",")
		end
	end

	return self
end

function var_0_0.updateCsvUsefulData(arg_35_0, arg_35_1)
	if not arg_35_0 then
		arg_35_0 = {}

		for iter_35_0, iter_35_1 in ipairs((string.split(cc.FileUtils:getInstance():getStringFromFile((var_0_0.getCsvPath(arg_35_1))), "\n"))) do
			for iter_35_2, iter_35_3 in ipairs((string.split(iter_35_1, ","))) do
				if iter_35_3 ~= "" and iter_35_3 ~= "0" then
					arg_35_0[var_0_0.p2s(iter_35_2 - 1, iter_35_0 - 1)] = tonumber(iter_35_3)
				end
			end
		end
	end

	return arg_35_0
end

function var_0_0:drawArea(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = arg_36_3 or var_0_0.BORDER_TYPE.GREEN
	local var_36_1 = (arg_36_3 or var_0_0.BORDER_TYPE.GREEN) == var_0_0.BORDER_TYPE.WHITE

	self:removeAllChildren()

	local var_36_2 = table.values(arg_36_1)

	if #var_36_2 == 1 then
		local var_36_3 = display.newSprite(g.core.common.Path:getGroupWarSelectImg(1, arg_36_4))

		self:addChild(var_36_3)

		local var_36_4, var_36_5 = var_0_0.rc2p(var_36_2[1].x, var_36_2[1].y)

		var_36_3:setPosition((cc.p(var_36_4, var_36_5)))

		return
	end

	for iter_36_0, iter_36_1 in pairs(arg_36_1) do
		local var_36_6 = arg_36_1[var_0_0.p2s(iter_36_1.x - 1, iter_36_1.y)]
		local var_36_7 = arg_36_1[var_0_0.p2s(iter_36_1.x, iter_36_1.y - 1)]
		local var_36_8 = arg_36_1[var_0_0.p2s(iter_36_1.x + 1, iter_36_1.y)]
		local var_36_9 = arg_36_1[var_0_0.p2s(iter_36_1.x, iter_36_1.y + 1)]
		local var_36_10 = 0
		local var_36_11 = false
		local var_36_12 = false
		local var_36_13 = 0
		local var_36_14 = 0

		if not var_36_6 and not var_36_7 then
			var_36_10 = 1
			var_36_14 = -10
		elseif not var_36_8 and not var_36_9 then
			var_36_10 = 1
			var_36_12 = true
			var_36_14 = 10
		elseif not var_36_6 and not var_36_9 then
			var_36_10 = 2
			var_36_13 = 23
		elseif not var_36_7 and not var_36_8 then
			var_36_10 = 2
			var_36_11 = true
			var_36_13 = -23
		elseif not var_36_6 then
			var_36_10 = 3
			var_36_13 = 20
		elseif not var_36_7 then
			var_36_10 = 3
			var_36_11 = true
			var_36_13 = -20
		elseif not var_36_8 then
			var_36_10 = 3
			var_36_11 = true
			var_36_12 = true
			var_36_14 = 10
		elseif not var_36_9 then
			var_36_10 = 3
			var_36_12 = true
			var_36_14 = 10
		end

		if var_36_10 ~= 0 then
			local var_36_15 = ""

			if var_36_0 == var_0_0.BORDER_TYPE.GREEN then
				var_36_15 = g.core.common.Path:getGroupWarManorImg(var_36_10, arg_36_4)
			elseif var_36_0 == var_0_0.BORDER_TYPE.RED then
				var_36_15 = g.core.common.Path:getGroupWarManorRedImg(var_36_10, arg_36_4)
			elseif var_36_0 == var_0_0.BORDER_TYPE.WHITE then
				var_36_15 = g.core.common.Path:getGroupWarManorWhiteImg(var_36_10, arg_36_4)
			elseif var_36_0 == var_0_0.BORDER_TYPE.YELLOW then
				var_36_15 = g.core.common.Path:getGroupWarManorYellowImg(var_36_10, arg_36_4)
			elseif var_36_0 == var_0_0.BORDER_TYPE.GREY then
				var_36_15 = g.core.common.Path:getGroupWarManorGreyImg(var_36_10, arg_36_4)
			end

			local var_36_16 = cc.Node:create()

			self:addChild(var_36_16)

			local var_36_17 = display.newSprite(var_36_15)

			if arg_36_2 then
				var_36_17:setOpacity(arg_36_2)
			end

			local var_36_18, var_36_19 = var_0_0.rc2p(iter_36_1.x, iter_36_1.y)
			local var_36_20 = cc.p(var_36_18, var_36_19)

			var_36_17:setFlippedX(var_36_11)
			var_36_17:setFlippedY(var_36_12)

			if var_36_1 then
				var_36_20.x = var_36_20.x + var_36_13
				var_36_20.y = var_36_20.y + var_36_14
			end

			var_36_17:setPosition(var_36_20)
			var_36_16:addChild(var_36_17)
		end
	end
end

function var_0_0.getPosInMap(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0, var_37_1 = var_0_0.rc2p((2 * arg_37_0 + arg_37_2) / 2, (2 * arg_37_1 + arg_37_3) / 2)

	return var_37_0, var_37_1 + var_0_0.getUnitCellHeight() / 2
end

function var_0_0:changeCocosNodeAnchor(arg_38_1)
	self:setAnchorPoint(arg_38_1)
	self:setPositionY(self:getPositionY() + self:getContentSize().height * (arg_38_1.y - self:getAnchorPoint().y))
end

function var_0_0.getConstIncludeNum()
	return var_0_0._info.B_INCLUDE_S_NUM
end

function var_0_0.getConstVerTex()
	return var_0_0._info.VERTEX
end

function var_0_0.getConstShowNum()
	return var_0_0._info.B_SHOW_NUM
end

function var_0_0.getUnitCellWidth()
	return var_0_0._info.S_CELL_WIDTH
end

function var_0_0.getUnitCellHeight()
	return var_0_0._info.S_CELL_HEIGHT
end

return var_0_0
