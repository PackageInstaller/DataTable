local SailBoatBg = class("SailBoatBg")
local var_0_3 = Vector2(1, 0)
local var_0_4 = Vector2(-1, 0)
local var_0_5 = Vector2(0, 1)
local var_0_6 = Vector2(0, -1)
local var_0_7

function SailBoatBg:Ctor(arg_1_1, arg_1_2)
	var_0_7 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._layerBack = findTF(self._tf, "scene_background/content")
	self._layerMid = findTF(self._tf, "scene/content")
	self._layerTop = findTF(self._tf, "scene_front/content")
	self._layerContent = nil
	self._bgGrids = {}
	self._bgDic = {}
	self._bgPrepareGrids = {}
	self._bgTfPool = {}
	self._sceneWidth = var_0_7.scene_width
	self._sceneHeight = var_0_7.scene_height

	return
end

function SailBoatBg:setRuleData(arg_2_1)
	self._bgTplName = arg_2_1.tpl
	self._layerType = arg_2_1.layer
	self._showType = arg_2_1.show
	self._width = arg_2_1.width
	self._height = arg_2_1.height
	self._removeBound = arg_2_1.remove_bound

	if self._layerType == SailBoatGameConst.bg_layer_back then
		self._layerContent = self._layerBack
	elseif self._layerType == SailBoatGameConst.bg_layer_mid then
		self._layerContent = self._layerMid
	elseif self._layerType == SailBoatGameConst.bg_layer_top then
		self._layerContent = self._layerTop
	end

	self._content = findTF(self._layerContent, arg_2_1.content)

	return
end

function SailBoatBg:start()
	self:createGrid(0, 0, true)
	self:createGrid(0, 0, true)
	self:createGrid(0, 0, true)
	self:clear()
	self:createGrid(0, 0, true)
	self:updateGrid()

	return
end

function SailBoatBg:step()
	self:checkEmptyGrid()
	self:updateGrid()

	return
end

function SailBoatBg:updateGrid()
	for iter_5_0 = #self._bgGrids, 1, -1 do
		local var_5_0 = self._bgGrids[iter_5_0]

		self._bgGrids[iter_5_0].anchoredPos.x = self._moveAmount.x + self._bgGrids[iter_5_0].pos.x
		var_5_0.anchoredPos.y = self._moveAmount.y + var_5_0.pos.y

		if math.abs(var_5_0.anchoredPos.x) > self._removeBound.x or math.abs(var_5_0.anchoredPos.y) > self._removeBound.y then
			if not var_5_0.stop then
				var_5_0.stop = true

				self:removeGrid(var_5_0)
			end
		else
			var_5_0.stop = false
		end

		if not var_5_0.stop then
			if math.abs(var_5_0.anchoredPos.x) < self._sceneWidth and math.abs(var_5_0.anchoredPos.y) < self._sceneHeight then
				local var_5_4 = self:checkPrepareCreate(var_5_0)

				if #var_5_4 > 0 then
					self:createPrepareGrid(var_5_4)
				end
			end

			if var_5_0.tf == nil then
				var_5_0.tf = self:getBgTf()
				GetComponent(var_5_0.tf, typeof(CanvasGroup)).alpha = 1
			end

			var_5_0.tf.anchoredPosition = var_5_0.anchoredPos
		end
	end

	for iter_5_1 = #self._bgPrepareGrids, 1, -1 do
		table.insert(self._bgGrids, (table.remove(self._bgPrepareGrids, iter_5_1)))
	end

	return
end

function SailBoatBg:checkEmptyGrid()
	return
end

function SailBoatBg:checkPrepareCreate(arg_7_1)
	local var_7_0 = {}

	if arg_7_1.anchoredPos.x + self._width / 2 < self._sceneWidth / 2 + var_0_7.fill_offsetX then
		local var_7_2 = self:checkPrepare(arg_7_1.w, arg_7_1.h, var_0_3)

		if var_7_2 then
			table.insert(var_7_0, var_7_2)
		end
	end

	if arg_7_1.anchoredPos.x - self._width / 2 > -self._sceneWidth / 2 - var_0_7.fill_offsetX then
		local var_7_3 = self:checkPrepare(arg_7_1.w, arg_7_1.h, var_0_4)

		if var_7_3 then
			table.insert(var_7_0, var_7_3)
		end
	end

	if arg_7_1.anchoredPos.y + self._height / 2 < self._sceneHeight / 2 + var_0_7.fill_offsetY then
		local var_7_4 = self:checkPrepare(arg_7_1.w, arg_7_1.h, var_0_5)

		if var_7_4 then
			table.insert(var_7_0, var_7_4)
		end
	end

	if arg_7_1.anchoredPos.y - self._height / 2 > -self._sceneHeight / 2 - var_0_7.fill_offsetY then
		local var_7_5 = self:checkPrepare(arg_7_1.w, arg_7_1.h, var_0_6)

		if var_7_5 then
			table.insert(var_7_0, var_7_5)
		end
	end

	return var_7_0
end

function SailBoatBg:checkPrepare(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0, var_8_1 = self:getDirecWH(arg_8_1, arg_8_2, arg_8_3)
	local var_8_2 = self:getGrid(var_8_0, var_8_1)
	local var_8_3 = self:getPrepareGrid(var_8_0, var_8_1)

	assert(not var_8_2 or not var_8_3, "创建了两个相同位置的grid,请检查代码")

	if not var_8_2 and not var_8_3 then
		return {
			w = var_8_0,
			h = var_8_1
		}
	end

	return nil
end

function SailBoatBg:getPrepareGrid(arg_9_1, arg_9_2)
	for iter_9_0 = 1, #self._bgPrepareGrids do
		if self._bgPrepareGrids[iter_9_0].w == arg_9_1 and self._bgPrepareGrids[iter_9_0].h == arg_9_2 then
			return self._bgPrepareGrids[iter_9_0]
		end
	end

	return nil
end

function SailBoatBg:createPrepareGrid(arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		table.insert(self._bgPrepareGrids, (self:createGrid(arg_10_1[iter_10_0].w, arg_10_1[iter_10_0].h, false)))
	end

	return
end

function SailBoatBg:getDirecWH(arg_11_1, arg_11_2, arg_11_3)
	return arg_11_1 + arg_11_3.x, arg_11_2 + arg_11_3.y
end

function SailBoatBg:getGrid(arg_12_1, arg_12_2)
	for iter_12_0 = 1, #self._bgGrids do
		if self._bgGrids[iter_12_0].w == arg_12_1 and self._bgGrids[iter_12_0].h == arg_12_2 then
			return self._bgGrids[iter_12_0]
		end
	end

	return nil
end

function SailBoatBg:createGrid(arg_13_1, arg_13_2, arg_13_3)
	self._bgDic[arg_13_1] = self._bgDic[arg_13_1] or {}

	if self._bgDic[arg_13_1][arg_13_2] then
		print("已经存在的grid 无需创建")

		return
	end

	local var_13_0 = {
		pos = Vector2(arg_13_1 * self._width, arg_13_2 * self._height),
		w = arg_13_1,
		h = arg_13_2,
		anchoredPos = Vector2(0, 0)
	}

	if arg_13_3 then
		table.insert(self._bgGrids, var_13_0)

		self._bgDic[var_13_0.w][var_13_0.h] = var_13_0
	end

	return var_13_0
end

function SailBoatBg:removeGrid(arg_14_1)
	if arg_14_1.tf then
		GetComponent(arg_14_1.tf, typeof(CanvasGroup)).alpha = 0

		table.insert(self._bgTfPool, arg_14_1.tf)

		arg_14_1.tf = nil
	end

	self._bgDic[arg_14_1.w][arg_14_1.h] = nil

	return
end

function SailBoatBg:getBgTf()
	local var_15_0

	if self._bgTfPool and #self._bgTfPool > 0 then
		var_15_0 = table.remove(self._bgTfPool, 1)
	end

	if not var_15_0 then
		var_15_0 = var_0_7.GetGameBgTf(self._bgTplName)

		setParent(var_15_0, self._content)
	end

	return var_15_0
end

function SailBoatBg:stop()
	return
end

function SailBoatBg:setMoveAmount(arg_17_1)
	self._moveAmount = arg_17_1

	return
end

function SailBoatBg:clear()
	self._moveAmount = Vector2(0, 0)

	for iter_18_0 = #self._bgGrids, 1, -1 do
		local var_18_0 = table.remove(self._bgGrids, iter_18_0)

		if var_18_0.tf then
			GetComponent(var_18_0.tf, typeof(CanvasGroup)).alpha = 0

			table.insert(self._bgTfPool, var_18_0.tf)
		end
	end

	for iter_18_1 = #self._bgPrepareGrids, 1, -1 do
		local var_18_1 = table.remove(self._bgPrepareGrids, iter_18_1)

		GetComponent(var_18_1.tf, typeof(CanvasGroup)).alpha = 0

		table.insert(self._bgTfPool, var_18_1.tf)
	end

	self._bgDic = {}

	return
end

function SailBoatBg:dispose()
	return
end

return SailBoatBg
