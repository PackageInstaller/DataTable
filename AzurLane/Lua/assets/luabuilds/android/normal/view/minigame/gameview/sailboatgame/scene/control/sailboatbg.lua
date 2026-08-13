class = var_0_10000

local var_0_0 = var_0_10000("SailBoatBg")
local var_0_1 = 1920
local var_0_2 = 1080

Vector2 = var_0_10003

local var_0_3 = var_0_10003(1, 0)

Vector2 = var_4

local var_0_4 = var_4(-1, 0)

Vector2 = var_5

local var_0_5 = var_5(0, 1)

Vector2 = var_6

local var_0_6 = var_6(0, -1)
local var_0_7

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	SailBoatGameVo = var_1_10003
	var_0_7 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._layerBack = var_1_10003(arg_1_0._tf, "scene_background/content")
	findTF = var_3
	arg_1_0._layerMid = var_3(arg_1_0._tf, "scene/content")
	findTF = var_3
	arg_1_0._layerTop = var_3(arg_1_0._tf, "scene_front/content")
	arg_1_0._layerContent = nil
	arg_1_0._bgGrids = {}
	arg_1_0._bgDic = {}
	arg_1_0._bgPrepareGrids = {}
	arg_1_0._bgTfPool = {}
	arg_1_0._sceneWidth = var_0_7.scene_width
	arg_1_0._sceneHeight = var_0_7.scene_height

	return
end

function var_0_0.setRuleData(arg_2_0, arg_2_1)
	arg_2_0._bgTplName = arg_2_1.tpl
	arg_2_0._layerType = arg_2_1.layer
	arg_2_0._showType = arg_2_1.show
	arg_2_0._width = arg_2_1.width
	arg_2_0._height = arg_2_1.height
	arg_2_0._removeBound = arg_2_1.remove_bound

	local var_2_0 = arg_2_0._layerType

	SailBoatGameConst = var_1_10003

	if var_2_0 == var_1_10003.bg_layer_back then
		arg_2_0._layerContent = arg_2_0._layerBack
	else
		var_2_0 = arg_2_0._layerType
		SailBoatGameConst = var_3

		if var_2_0 == var_3.bg_layer_mid then
			arg_2_0._layerContent = arg_2_0._layerMid
		else
			var_2_0 = arg_2_0._layerType
			SailBoatGameConst = var_3

			if var_2_0 == var_3.bg_layer_top then
				arg_2_0._layerContent = arg_2_0._layerTop
			end
		end
	end

	findTF = var_2_0
	arg_2_0._content = var_2_0(arg_2_0._layerContent, arg_2_1.content)

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0:createGrid(0, 0, true)
	arg_3_0:createGrid(0, 0, true)
	arg_3_0:createGrid(0, 0, true)
	arg_3_0:clear()
	arg_3_0:createGrid(0, 0, true)
	arg_3_0:updateGrid()

	return
end

function var_0_0.step(arg_4_0)
	arg_4_0:checkEmptyGrid()
	arg_4_0:updateGrid()

	return
end

function var_0_0.updateGrid(arg_5_0)
	for iter_5_0 = #arg_5_0._bgGrids, 1, -1 do
		local var_5_0 = arg_5_0._bgGrids[iter_5_0].w
		local var_5_1 = var_1_10005.h

		var_1_10005.anchoredPos.x = arg_5_0._moveAmount.x + var_1_10005.pos.x
		var_1_10005.anchoredPos.y = arg_5_0._moveAmount.y + var_1_10005.pos.y

		local var_5_2 = false

		math = var_9

		if not (var_9.abs(var_1_10005.anchoredPos.x) > arg_5_0._removeBound.x) then
			math = var_9

			if var_9.abs(var_1_10005.anchoredPos.y) > arg_5_0._removeBound.y then
				if not var_1_10005.stop then
					var_1_10005.stop = true

					arg_5_0:removeGrid(var_1_10005)
				end
			else
				var_1_10005.stop = false
			end

			if not var_1_10005.stop then
				math = var_9

				if var_9.abs(var_1_10005.anchoredPos.x) < arg_5_0._sceneWidth then
					math = var_9

					if var_9.abs(var_1_10005.anchoredPos.y) < arg_5_0._sceneHeight then
						local var_5_3 = #arg_5_0:checkPrepareCreate(var_1_10005)

						if 0 < var_5_3 then
							var_1_10011 = arg_5_0

							arg_5_0.createPrepareGrid(var_1_10011, var_9)
						end
					end
				end

				if var_1_10005.tf == nil then
					var_1_10005.tf = arg_5_0:getBgTf()
					GetComponent = var_9

					local var_5_4 = var_1_10005.tf

					typeof = var_1_10011
					CanvasGroup = var_1_10012
					var_9(var_5_4, var_1_10011(var_1_10012)).alpha = 1
				end

				var_1_10005.tf.anchoredPosition = var_1_10005.anchoredPos
			end
		end
	end

	for iter_5_1 = #arg_5_0._bgPrepareGrids, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_5_0._bgPrepareGrids, iter_5_1)
		table = var_6

		var_6.insert(arg_5_0._bgGrids, var_1_10005)
	end

	return
end

function var_0_0.checkEmptyGrid(arg_6_0)
	return
end

function var_0_0.checkPrepareCreate(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_1.w
	local var_7_2 = arg_7_1.h
	local var_7_3 = arg_7_1.anchoredPos
	local var_7_4

	if var_7_3.x + arg_7_0._width / 2 < arg_7_0._sceneWidth / 2 + var_0_7.fill_offsetX and arg_7_0:checkPrepare(var_7_1, var_7_2, var_0_3) then
		table = var_7

		var_7.insert(var_7_0, var_6)
	end

	if var_7_3.x - arg_7_0._width / 2 > -arg_7_0._sceneWidth / 2 - var_0_7.fill_offsetX and arg_7_0:checkPrepare(var_7_1, var_7_2, var_0_4) then
		table = var_7

		var_7.insert(var_7_0, var_6)
	end

	if var_7_3.y + arg_7_0._height / 2 < arg_7_0._sceneHeight / 2 + var_0_7.fill_offsetY and arg_7_0:checkPrepare(var_7_1, var_7_2, var_0_5) then
		table = var_7

		var_7.insert(var_7_0, var_6)
	end

	if var_7_3.y - arg_7_0._height / 2 > -arg_7_0._sceneHeight / 2 - var_0_7.fill_offsetY and arg_7_0:checkPrepare(var_7_1, var_7_2, var_0_6) then
		table = var_7

		var_7.insert(var_7_0, var_6)
	end

	return var_7_0
end

function var_0_0.checkPrepare(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0, var_8_1 = arg_8_0:getDirecWH(arg_8_1, arg_8_2, arg_8_3)
	local var_8_2 = arg_8_0:getGrid(var_8_0, var_8_1)
	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.getPrepareGrid(var_8_3, var_8_0, var_8_1)

	assert = var_8_3

	var_8_3(not var_8_2 or not var_8_4, "创建了两个相同位置的grid,请检查代码")

	if not var_8_2 and not var_8_4 then
		return {
			w = var_8_0,
			h = var_8_1
		}
	end

	return nil
end

function var_0_0.getPrepareGrid(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_0._bgPrepareGrids do
		if arg_9_0._bgPrepareGrids[iter_9_0].w == arg_9_1 and var_7.h == arg_9_2 then
			return var_7
		end
	end

	return nil
end

function var_0_0.createPrepareGrid(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		local var_10_0 = arg_10_1[iter_10_0]
		local var_10_1 = arg_10_0
		local var_10_2 = arg_10_0.createGrid(var_10_1, var_10_0.w, var_10_0.h, false)

		table = var_10_1

		var_10_1.insert(arg_10_0._bgPrepareGrids, var_10_2)
	end

	return
end

function var_0_0.getDirecWH(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_1 + arg_11_3.x, arg_11_2 + arg_11_3.y
end

function var_0_0.getGrid(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, #arg_12_0._bgGrids do
		if arg_12_0._bgGrids[iter_12_0].w == arg_12_1 and var_7.h == arg_12_2 then
			return var_7
		end
	end

	return nil
end

function var_0_0.createGrid(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._bgDic[arg_13_1] then
		arg_13_0._bgDic[arg_13_1] = {}
	end

	if arg_13_0._bgDic[arg_13_1][arg_13_2] then
		print = var_4

		var_4("已经存在的grid 无需创建")

		return
	end

	local var_13_0 = {}

	Vector2 = var_1_10005
	var_13_0.pos = var_1_10005(arg_13_1 * arg_13_0._width, arg_13_2 * arg_13_0._height)
	var_13_0.w = arg_13_1
	var_13_0.h = arg_13_2
	Vector2 = var_5
	var_13_0.anchoredPos = var_5(0, 0)

	if arg_13_3 then
		table = var_5

		var_5.insert(arg_13_0._bgGrids, var_13_0)

		arg_13_0._bgDic[var_13_0.w][var_13_0.h] = var_13_0
	end

	return var_13_0
end

function var_0_0.removeGrid(arg_14_0, arg_14_1)
	if arg_14_1.tf then
		local var_14_0 = arg_14_1.tf

		GetComponent = var_1_10003

		local var_14_1 = arg_14_1.tf

		typeof = var_1_10005
		CanvasGroup = var_1_10006

		local var_14_2 = var_1_10003(var_14_1, var_1_10005(var_1_10006))

		var_14_2.alpha = 0
		table = var_14_2

		var_14_2.insert(arg_14_0._bgTfPool, var_14_0)

		arg_14_1.tf = nil
	end

	arg_14_0._bgDic[arg_14_1.w][arg_14_1.h] = nil

	return
end

function var_0_0.getBgTf(arg_15_0)
	local var_15_0

	if arg_15_0._bgTfPool and #arg_15_0._bgTfPool > 0 then
		table = var_2
		var_15_0 = var_2.remove(arg_15_0._bgTfPool, 1)
	end

	if not var_15_0 then
		var_15_0 = var_0_7.GetGameBgTf(arg_15_0._bgTplName)
		setParent = var_2

		var_2(var_15_0, arg_15_0._content)
	end

	return var_15_0
end

function var_0_0.stop(arg_16_0)
	return
end

function var_0_0.setMoveAmount(arg_17_0, arg_17_1)
	arg_17_0._moveAmount = arg_17_1

	return
end

function var_0_0.clear(arg_18_0)
	Vector2 = var_1_10001
	arg_18_0._moveAmount = var_1_10001(0, 0)

	for iter_18_0 = #arg_18_0._bgGrids, 1, -1 do
		table = var_1_10005

		if var_1_10005.remove(arg_18_0._bgGrids, iter_18_0).tf then
			GetComponent = var_6

			local var_18_0 = var_1_10005.tf

			typeof = var_1_10008
			CanvasGroup = var_1_10009

			local var_18_1 = var_6(var_18_0, var_1_10008(var_1_10009))

			var_18_1.alpha = 0
			table = var_18_1

			var_18_1.insert(arg_18_0._bgTfPool, var_1_10005.tf)
		end
	end

	for iter_18_1 = #arg_18_0._bgPrepareGrids, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_18_0._bgPrepareGrids, iter_18_1)
		GetComponent = var_6

		local var_18_2 = var_1_10005.tf

		typeof = var_1_10008
		CanvasGroup = var_1_10009

		local var_18_3 = var_6(var_18_2, var_1_10008(var_1_10009))

		var_18_3.alpha = 0
		table = var_18_3

		var_18_3.insert(arg_18_0._bgTfPool, var_1_10005.tf)
	end

	arg_18_0._bgDic = {}

	return
end

function var_0_0.dispose(arg_19_0)
	return
end

return var_0_0
