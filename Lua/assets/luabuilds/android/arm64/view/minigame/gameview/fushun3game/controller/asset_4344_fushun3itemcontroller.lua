local Fushun3ItemController = class("Fushun3ItemController")
local var_0_1 = 3
local var_0_2 = 100

function Fushun3ItemController:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._sceneTf = arg_1_1
	self._charTf = arg_1_2
	self._itemTpls = arg_1_3
	self._event = arg_1_4
	self._charCollider = GetComponent(findTF(self._charTf, "collider"), typeof(BoxCollider2D))
	self._itemPos = findTF(self._sceneTf, "item")
	self.weightTotal = 0
	self.weightItems = {}
	self.items = {}
	self.itemPools = {}

	for iter_1_0 = 1, #Fushun3GameConst.item_instance_data do
		self.weightTotal = self.weightTotal + Fushun3GameConst.item_instance_data[iter_1_0].weight

		table.insert(self.weightItems, {
			id = Fushun3GameConst.item_instance_data[iter_1_0].id,
			weight = self.weightTotal,
			map = Fushun3GameConst.item_instance_data[iter_1_0].map
		})
	end

	return
end

function Fushun3ItemController:setCallback(arg_2_1)
	self._callback = arg_2_1

	return
end

function Fushun3ItemController:start()
	for iter_3_0 = #self.items, 1, -1 do
		self:returnItemToPool((table.remove(self.items, iter_3_0)))
	end

	self.createTime = math.random(Fushun3GameConst.create_time[1], Fushun3GameConst.create_time[2])
	self.createPos = Vector2.zero
	self.itemTime = var_0_1

	return
end

function Fushun3ItemController:step()
	self:removeOutItems()

	local var_4_0 = {}

	for iter_4_0 = #self.items, 1, -1 do
		if self.items[iter_4_0].collider and self.items[iter_4_0].data.type ~= Fushun3GameConst.item_type_damage and Fushun3GameConst.CheckBoxCollider(self._charCollider.bounds.min, self.items[iter_4_0].collider.bounds.min, self._charCollider.bounds.size, self.items[iter_4_0].collider.bounds.size) then
			local var_4_1 = table.remove(self.items, iter_4_0)

			if var_4_1.data.effect then
				self._event:emit(Fushun3GameEvent.add_effect_call, {
					effectName = var_4_1.data.effect,
					targetTf = var_4_1.tf
				})
			end

			if self._callback then
				self._callback(Fushun3GameEvent.catch_item_call, {
					data = var_4_1.data
				})
			end

			self:returnItemToPool(var_4_1)
		end

		if self.items[iter_4_0].data.speed then
			self.items[iter_4_0].tf.anchoredPosition.x = self.items[iter_4_0].tf.anchoredPosition.x + self.items[iter_4_0].data.speed * Time.deltaTime
			self.items[iter_4_0].tf.anchoredPosition = self.items[iter_4_0].tf.anchoredPosition
		end

		if self.items[iter_4_0].data.type == Fushun3GameConst.item_type_damage then
			table.insert(var_4_0, self.items[iter_4_0])
		end
	end

	for iter_4_1 = #var_4_0, 1, -1 do
		local var_4_2 = var_4_0[iter_4_1]

		self._event:emit(Fushun3GameEvent.check_item_damage, {
			collider = var_4_0[iter_4_1].collider,
			callback = function(arg_5_0)
				if arg_5_0 then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOOM)
					self._event:emit(Fushun3GameEvent.add_effect_call, {
						effectName = "EF_fr_Hit_LA",
						targetTf = findTF(var_4_2.tf, "effectPos")
					})
					self:removeItem(var_4_2)
				end

				return
			end
		})
	end

	return
end

function Fushun3ItemController:removeItem(arg_6_1)
	for iter_6_0 = #self.items, 1, -1 do
		if arg_6_1 == self.items[iter_6_0] then
			self:returnItemToPool((table.remove(self.items, iter_6_0)))

			return
		end
	end

	return
end

function Fushun3ItemController:createPlatformItem(arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1 = self:getWeightItemsMap()

	if var_7_1 then
		var_7_0 = Fushun3GameConst.item_map[var_7_1]
	end

	if var_7_0 then
		local var_7_2 = self._itemPos:InverseTransformPoint(arg_7_1)

		for iter_7_0 = #var_7_0.list, 1, -1 do
			for iter_7_1, iter_7_2 in ipairs(var_7_0.list[iter_7_0]) do
				if iter_7_2 and iter_7_2 > 0 then
					self:createItemById(iter_7_2, Vector2(var_7_2.x + 0, var_7_2.y + 0))
				end

				local var_7_3 = 0 + Fushun3GameConst.item_h
			end

			var_7_3 = 0
		end
	end

	return
end

function Fushun3ItemController:createItemById(arg_8_1, arg_8_2)
	local var_8_0

	for iter_8_0 = 1, #Fushun3GameConst.item_data do
		if Fushun3GameConst.item_data[iter_8_0].id == arg_8_1 then
			var_8_0 = Fushun3GameConst.item_data[iter_8_0].name
		end
	end

	local var_8_1 = self:getOrCreateItem(var_8_0)

	if var_8_1 then
		setActive(var_8_1.tf, true)

		var_8_1.tf.anchoredPosition = arg_8_2

		table.insert(self.items, var_8_1)
	end

	return
end

function Fushun3ItemController:createItem(arg_9_1, arg_9_2)
	local var_9_0 = self:getOrCreateItem(arg_9_1)

	if var_9_0 then
		var_9_0.tf.position = arg_9_2

		setActive(var_9_0.tf, true)
		table.insert(self.items, var_9_0)
	end

	return
end

function Fushun3ItemController:itemFollow(arg_10_1)
	for iter_10_0 = 1, #self.items do
		local var_10_0 = self.items[iter_10_0]

		if self.items[iter_10_0].data.type == Fushun3GameConst.item_type_buff or var_10_0.data.type == Fushun3GameConst.item_type_score then
			local var_10_1 = var_10_0.tf.anchoredPosition

			if math.abs(arg_10_1.x - var_10_0.tf.anchoredPosition.x) <= 600 and math.abs(arg_10_1.y - var_10_1.y) <= 700 then
				local var_10_2 = false

				if not var_10_0.catchTime then
					var_10_0.catchTime = 1
				else
					var_10_0.catchTime = var_10_0.catchTime - Time.deltaTime

					if var_10_0.catchTime <= 0 then
						var_10_0.catchTime = nil
						var_10_0.tf.anchoredPosition = arg_10_1
						var_10_2 = true
					end
				end

				if not var_10_2 then
					local var_10_3 = 2000 * Time.deltaTime * math.sign(arg_10_1.x - var_10_1.x)
					local var_10_4 = 25 * math.sign(arg_10_1.y - var_10_1.y)

					if math.abs(arg_10_1.y - var_10_1.y) < 25 then
						var_10_4 = 0
					end

					var_10_1.x = var_10_1.x + var_10_3
					var_10_1.y = var_10_1.y + var_10_4
					var_10_0.tf.anchoredPosition = var_10_1
				end
			end
		end
	end

	return
end

function Fushun3ItemController:getOrCreateItem(arg_11_1)
	for iter_11_0 = 1, #self.itemPools do
		if self.itemPools[iter_11_0].data.name == arg_11_1 then
			return table.remove(self.itemPools, iter_11_0)
		end
	end

	for iter_11_1 = 1, #Fushun3GameConst.item_data do
		local var_11_0 = Clone(Fushun3GameConst.item_data[iter_11_1])

		if var_11_0.name == arg_11_1 then
			local var_11_1 = tf(instantiate(findTF(self._itemTpls, arg_11_1)))

			var_11_1.localScale = Fushun3GameConst.game_scale_v3
			findTF(var_11_1, "collider").gameObject.layer = LayerMask.NameToLayer("Collider")

			local var_11_2 = GetComponent(findTF(var_11_1, "collider"), typeof(BoxCollider2D))

			setParent(var_11_1, self._itemPos)

			return {
				tf = var_11_1,
				data = var_11_0,
				collider = var_11_2
			}
		end
	end

	return
end

function Fushun3ItemController:getWeightItemsMap()
	if self.itemTime > 0 then
		if math.random(1, self.itemTime) == self.itemTime then
			self.itemTime = var_0_2

			if not self.itemsMap then
				self.itemsMap = {}

				for iter_12_0 = 1, #self.weightItems do
					if table.contains(Fushun3GameConst.item_map_ids, self.weightItems[iter_12_0].map) then
						table.insert(self.itemsMap, self.weightItems[iter_12_0].map)
					end
				end
			end

			return self.itemsMap[math.random(1, #self.itemsMap)]
		else
			self.itemTime = self.itemTime - 1
		end
	end

	local var_12_0 = math.random(1, self.weightTotal)

	for iter_12_1 = 1, #self.weightItems do
		if var_12_0 <= self.weightItems[iter_12_1].weight then
			return self.weightItems[iter_12_1].map
		end
	end

	return nil
end

function Fushun3ItemController:removeOutItems()
	for iter_13_0 = #self.items, 1, -1 do
		if self.items[iter_13_0].tf.anchoredPosition.x < math.abs(self._sceneTf.anchoredPosition.x) - 1500 then
			self:returnItemToPool((table.remove(self.items, iter_13_0)))
		elseif self.items[iter_13_0].data.type == Fushun3GameConst.item_type_damage and self.items[iter_13_0].tf.anchoredPosition.x >= math.abs(self._sceneTf.anchoredPosition.x) + 2000 then
			self:returnItemToPool((table.remove(self.items, iter_13_0)))
		elseif self.items[iter_13_0].tf.anchoredPosition.x >= math.abs(self._sceneTf.anchoredPosition.x) + 8 then
			self:returnItemToPool((table.remove(self.items, iter_13_0)))
		end
	end

	return
end

function Fushun3ItemController:returnItemToPool(arg_14_1)
	setActive(arg_14_1.tf, false)

	if arg_14_1.catchTime then
		arg_14_1.catchTime = nil
	end

	table.insert(self.itemPools, arg_14_1)

	return
end

return Fushun3ItemController
