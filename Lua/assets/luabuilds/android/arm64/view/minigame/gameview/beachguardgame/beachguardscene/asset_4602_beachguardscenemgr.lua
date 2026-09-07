local BeachGuardSceneMgr = class("BeachGuardSceneMgr")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(self)
			self._tf = arg_1_0
			self._charTpl = arg_1_1
			self._event = arg_1_2
			self.chars = {}
			self.charPool = {}
			self.gridChars = {}
			self.enemys = {}
			self.enemysPool = {}
			self.content = findTF(self._tf, "sceneContainer/scene/content")

			return
		end,
		changeRecycles = function(self, arg_3_1)
			self.recycle = arg_3_1

			for iter_3_0 = #self.chars, 1, -1 do
				self.chars[iter_3_0]:setRecycleFlag(arg_3_1)
			end

			return
		end,
		setGridChar = function(self, arg_4_1, arg_4_2)
			local var_4_0 = self:createChar(arg_4_1)

			var_4_0:prepareData()
			var_4_0:setParent(self.content, true, (self.content:InverseTransformPoint(arg_4_2:getPos().position)))
			var_4_0:setLineIndex(arg_4_2:getLineIndex())
			var_4_0:setGridIndex(arg_4_2:getIndex())
			var_4_0:setCamp(1)
			var_4_0:setRaycast(true)
			table.insert(self.chars, var_4_0)

			return var_4_0
		end,
		createChar = function(self, arg_5_1)
			return self:getCharFromPool(arg_5_1) or BeachGuardChar.New(tf(instantiate(self._charTpl)), BeachGuardConst.chars[arg_5_1], self._event)
		end,
		getCharFromPool = function(self, arg_6_1)
			for iter_6_0 = #self.charPool, 1, -1 do
				if self.charPool[iter_6_0]:getId() == arg_6_1 then
					return table.remove(self.charPool, iter_6_0)
				end
			end

			return nil
		end,
		removeChar = function(self, arg_7_1)
			for iter_7_0 = #self.chars, 1, -1 do
				if self.chars[iter_7_0] == arg_7_1 then
					local var_7_0 = table.remove(self.chars, iter_7_0)

					var_7_0:clear()
					table.insert(self.charPool, var_7_0)
				elseif self.chars[iter_7_0]:getTarget() == arg_7_1 then
					self.chars[iter_7_0]:setTarget(nil)
				end
			end

			for iter_7_1 = #self.enemys, 1, -1 do
				if self.enemys[iter_7_1] == arg_7_1 then
					local var_7_1 = table.remove(self.enemys, iter_7_1)

					var_7_1:clear()
					table.insert(self.charPool, var_7_1)
				elseif self.enemys[iter_7_1]:getTarget() == arg_7_1 then
					self.enemys[iter_7_1]:setTarget(nil)
				end
			end

			return
		end,
		clear = function(self)
			for iter_8_0 = #self.chars, 1, -1 do
				local var_8_0 = table.remove(self.chars, iter_8_0)

				var_8_0:clear()
				table.insert(self.charPool, var_8_0)
			end

			for iter_8_1 = #self.enemys, 1, -1 do
				local var_8_1 = table.remove(self.enemys, iter_8_1)

				var_8_1:clear()
				table.insert(self.charPool, var_8_1)
			end

			return
		end,
		start = function(self)
			for iter_9_0 = #self.chars, 1, -1 do
				self.chars[iter_9_0]:start()
			end

			self.recycle = false

			return
		end,
		step = function(self, arg_10_1)
			for iter_10_0 = #self.chars, 1, -1 do
				self.chars[iter_10_0]:step(arg_10_1)
			end

			for iter_10_1 = #self.enemys, 1, -1 do
				self.enemys[iter_10_1]:step(arg_10_1)
			end

			self.enemyOver = false

			for iter_10_2 = #self.enemys, 1, -1 do
				if not self.enemys[iter_10_2]:getTarget() then
					local var_10_0 = self.enemys[iter_10_2]:getPointWorld()
					local var_10_1 = self.enemys[iter_10_2]:getPos()

					for iter_10_3, iter_10_4 in ipairs((self:getCharLine((self.enemys[iter_10_2]:getLineIndex())))) do
						if iter_10_4:checkCollider(var_10_0, var_10_1) and (not false or true) then
							self.enemys[iter_10_2]:setTarget(iter_10_4)
						end
					end
				end

				if self.enemys[iter_10_2]:getPos().x < BeachGuardConst.enemy_over_width then
					self.enemyOver = true
				end
			end

			for iter_10_5 = 1, #self.chars do
				local var_10_3 = self.chars[iter_10_5]:getSkillDistance() * BeachGuardConst.part_width

				for iter_10_6, iter_10_7 in ipairs((self:getCanHitChar(self.chars[iter_10_5]:getLineIndex(), self.chars[iter_10_5]:getCamp()))) do
					local var_10_4 = iter_10_7:getPos().x - self.chars[iter_10_5]:getPos().x

					if var_10_4 > 0 and var_10_4 < var_10_3 then
						self.chars[iter_10_5]:setTarget(iter_10_7)
					end
				end
			end

			self:sortChar()

			return
		end,
		stop = function(self)
			for iter_11_0 = #self.chars, 1, -1 do
				self.chars[iter_11_0]:stop()
			end

			return
		end,
		getLineCampChars = function(self, arg_12_1, arg_12_2)
			local var_12_0 = {}
			local var_12_1 = {}

			if arg_12_2 == 1 then
				var_12_1 = self.chars
			elseif arg_12_2 == 2 then
				var_12_1 = self.enemys
			end

			for iter_12_0 = 1, #var_12_1 do
				if table.contains(arg_12_1, var_12_1[iter_12_0]:getLineIndex()) then
					table.insert(var_12_0, var_12_1[iter_12_0])
				end
			end

			return var_12_0
		end,
		getCharByCamp = function(self, arg_13_1)
			local var_13_0 = {}

			if arg_13_1 == 1 then
				var_13_0 = self.chars
			elseif arg_13_1 == 2 then
				var_13_0 = self.enemys
			end

			return var_13_0
		end,
		getEnemyOver = function(self)
			return self.enemyOver
		end,
		getCanHitChar = function(self, arg_15_1, arg_15_2)
			local var_15_0 = {}
			local var_15_1 = {}

			if arg_15_2 == 1 then
				var_15_1 = self.enemys
			elseif arg_15_2 == 2 then
				var_15_1 = self.chars
			end

			for iter_15_0 = 1, #var_15_1 do
				if var_15_1[iter_15_0]:getLineIndex() == arg_15_1 and var_15_1[iter_15_0]:inBulletBound() then
					table.insert(var_15_0, var_15_1[iter_15_0])
				end
			end

			return var_15_0
		end,
		getChars = function(self)
			return self.chars
		end,
		getEnemys = function(self)
			return self.enemys
		end,
		getCharLine = function(self, arg_18_1)
			local var_18_0 = {}

			for iter_18_0 = 1, #self.chars do
				if self.chars[iter_18_0]:getLineIndex() == arg_18_1 then
					table.insert(var_18_0, self.chars[iter_18_0])
				end
			end

			return var_18_0
		end,
		addEnemyChar = function(self, arg_19_1, arg_19_2)
			local var_19_0 = self:createChar(arg_19_1)

			var_19_0:prepareData()
			var_19_0:setLineIndex(arg_19_2.index)

			local var_19_1 = self.content:InverseTransformPoint(arg_19_2.position)

			var_19_0:setParent(self.content, false, Vector2(math.random(BeachGuardConst.enemy_pos[1], BeachGuardConst.enemy_pos[2]) + var_19_1.x, var_19_1.y + BeachGuardConst.enemy_offset_y))
			var_19_0:setCamp(2)
			var_19_0:setRaycast(false)
			table.insert(self.enemys, var_19_0)

			return
		end,
		sortChar = function(self)
			if not self.sorts or #self.sorts ~= #self.chars + #self.enemys then
				self.sorts = {}

				for iter_20_0 = 1, #self.chars do
					table.insert(self.sorts, self.chars[iter_20_0])
				end

				for iter_20_1 = 1, #self.enemys do
					table.insert(self.sorts, self.enemys[iter_20_1])
				end

				table.sort(self.sorts, function(arg_21_0, arg_21_1)
					local var_21_0 = arg_21_0:getPos()
					local var_21_1 = arg_21_1:getPos()

					if var_21_0.y > var_21_1.y then
						return true
					elseif var_21_0.y < var_21_1.y then
						return false
					end

					if var_21_0.x > var_21_1.x then
						return true
					elseif var_21_0.x < var_21_1.x then
						return false
					end

					return
				end)

				for iter_20_2 = 1, #self.sorts do
					self.sorts[iter_20_2]:SetSiblingIndex(iter_20_2)
				end
			end

			return
		end
	}

	var_1_0:Ctor()

	return var_1_0
end

local function var_0_2(arg_22_0, arg_22_1)
	local var_22_0 = {
		Ctor = function(self)
			self._tf = arg_22_0
			self._event = arg_22_1
			self.lineTpl = findTF(self._tf, "sceneContainer/scene/classes/lineTpl")
			self.gridTpl = findTF(self._tf, "sceneContainer/scene/classes/gridTpl")
			self.lines = {}
			self.content = findTF(self._tf, "sceneContainer/scene/content")

			for iter_23_0 = 1, BeachGuardConst.line_num do
				local var_23_0 = findTF(self._tf, "sceneContainer/scene/linePos/" .. iter_23_0)
				local var_23_1 = tf(instantiate(self.lineTpl))

				var_23_1.anchoredPosition = Vector2(0, 0)

				setParent(var_23_1, var_23_0)

				local var_23_2 = BeachGuardLine.New(var_23_1, self.gridTpl, self._event)

				var_23_2:setIndex(iter_23_0)
				table.insert(self.lines, var_23_2)
			end

			return
		end,
		setMapData = function(self, arg_24_1)
			self.activeLines = {}

			for iter_24_0 = 1, #self.lines do
				if table.contains(arg_24_1.line, self.lines[iter_24_0]:getIndex()) then
					self.lines[iter_24_0]:active(true)
					table.insert(self.activeLines, self.lines[iter_24_0])
				else
					self.lines[iter_24_0]:active(false)
				end
			end

			return
		end,
		getGridByIndex = function(self, arg_25_1, arg_25_2)
			for iter_25_0 = 1, #self.activeLines do
				if self.activeLines[iter_25_0]:getIndex() == arg_25_1 then
					return self.activeLines[iter_25_0]:getGridByIndex(arg_25_2)
				end
			end

			return nil
		end,
		setDrag = function(arg_26_0, arg_26_1)
			arg_26_0.dragData = arg_26_1

			return
		end,
		start = function(self)
			for iter_27_0 = 1, #self.lines do
				local var_27_0 = self.lines[iter_27_0]:start()
			end

			return
		end,
		step = function(self, arg_28_1)
			for iter_28_0 = 1, #self.lines do
				local var_28_0 = self.lines[iter_28_0]:step(arg_28_1)
			end

			return
		end,
		clear = function(self)
			self:clearPre()

			for iter_29_0 = 1, #self.lines do
				self.lines[iter_29_0]:clear()
			end

			return
		end,
		onTimer = function(self)
			if not self.dragData then
				return
			end

			if self.dragData.flag ~= true or not self.dragData.pos then
				if self.preCharGrid then
					self._event:emit(BeachGuardGameView.PULL_CHAR, {
						card_id = self.preCardID,
						line_index = self.preCharGrid:getLineIndex(),
						grid_index = self.preCharGrid:getIndex()
					})
				end

				self:clearPre()

				return
			end

			local var_30_0 = self:getGridByWorld(self.dragData.pos)

			if var_30_0 and var_30_0:isEmpty() then
				if self.preCharGrid == var_30_0 and self.preCardID == self.dragData.config.id then
					return
				end

				self:clearPre()

				self.preCharGrid = var_30_0
				self.preCardID = self.dragData.config.id

				self.preCharGrid:prechar(self.dragData.config.char_id)

				local var_30_1 = self.preCharGrid:getLineIndex()
				local var_30_2 = self.preCharGrid:getIndex()

				if var_30_1 and var_30_2 then
					for iter_30_0 = 1, BeachGuardConst.chars[self.dragData.config.char_id].distance do
						local var_30_3 = self:getGridByIndex(var_30_1, var_30_2 + iter_30_0)

						if var_30_3 then
							var_30_3:preDistance()
							table.insert(self.preDistanceGrids, var_30_3)
						end
					end
				end
			else
				self:clearPre()
			end

			return
		end,
		clearPre = function(self)
			if self.preCharGrid then
				self.preCharGrid:unPreChar()

				self.preCharGrid = nil
			end

			if self.preDistanceGrids and #self.preDistanceGrids > 0 then
				for iter_31_0 = 1, #self.preDistanceGrids do
					self.preDistanceGrids[iter_31_0]:unPreDistance()
				end
			end

			self.preDistanceGrids = {}

			return
		end,
		removeGridChar = function(self, arg_32_1)
			local var_32_0 = self:getGridByChar(arg_32_1)

			if var_32_0 then
				var_32_0:removeChar()

				return true
			end

			return
		end,
		getGridByWorld = function(self, arg_33_1)
			for iter_33_0 = 1, #self.activeLines do
				local var_33_0 = self.activeLines[iter_33_0]:getGridWorld(arg_33_1)

				if var_33_0 then
					return var_33_0
				end
			end

			return nil
		end,
		getGridByChar = function(self, arg_34_1)
			for iter_34_0 = 1, #self.lines do
				for iter_34_1, iter_34_2 in ipairs((self.lines[iter_34_0]:getGrids())) do
					if iter_34_2:getChar() == arg_34_1 then
						return iter_34_2
					end
				end
			end

			return nil
		end,
		getAbleLinePos = function(self, arg_35_1)
			local var_35_0 = {}

			for iter_35_0 = 1, #self.activeLines do
				local var_35_1 = self.activeLines[iter_35_0]:getIndex()

				if table.contains(arg_35_1, var_35_1) then
					table.insert(var_35_0, {
						position = self.activeLines[iter_35_0]:getPosition(),
						index = var_35_1
					})
				end
			end

			return var_35_0[math.random(1, #var_35_0)]
		end
	}

	var_22_0:Ctor()

	return var_22_0
end

local function var_0_3(arg_36_0, arg_36_1)
	local var_36_0 = {
		Ctor = function(self)
			self._tf = arg_36_0
			self._event = arg_36_1
			self.content = findTF(self._tf, "sceneContainer/scene/content")
			self.bullets = {}
			self.bulletPool = {}

			return
		end,
		useSkill = function(self, arg_38_1)
			if arg_38_1.skill.type == BeachGuardConst.skill_craft then
				self._event:emit(BeachGuardGameView.ADD_CRAFT, {
					num = arg_38_1.skill.num
				})
			elseif arg_38_1.skill.type == BeachGuardConst.skill_bullet then
				for iter_38_0, iter_38_1 in ipairs(arg_38_1.skill.bullet_id) do
					self:pullBullet(iter_38_1, arg_38_1)
				end
			elseif arg_38_1.skill.type == BeachGuardConst.skill_melee then
				self._event:emit(BeachGuardGameView.CREATE_CHAR_DAMAGE, {
					damage = arg_38_1.damage,
					position = arg_38_1.position,
					target = arg_38_1.target,
					useData = arg_38_1
				})
			end

			return
		end,
		pullBullet = function(self, arg_39_1, arg_39_2)
			local var_39_0 = self:getOrCreateBullet(arg_39_1)

			var_39_0.tf.anchoredPosition = self.content:InverseTransformPoint(arg_39_2.position)

			if var_39_0.config.offset then
				var_39_0.tf.anchoredPosition = Vector2(var_39_0.tf.anchoredPosition.x + var_39_0.config.offset.x, var_39_0.tf.anchoredPosition.y + var_39_0.config.offset.y)
			end

			setActive(var_39_0.tf, true)

			var_39_0.distanceVec = arg_39_2.distanceVec
			var_39_0.speed = Vector2(var_39_0.config.speed[1], var_39_0.config.speed[2])
			var_39_0.direct = arg_39_2.direct
			var_39_0.hit = false
			var_39_0.useData = arg_39_2

			if var_39_0.config.point_able then
				var_39_0.life = nil
			elseif var_39_0.config.speed_high and var_39_0.config.speed_high ~= 0 then
				local var_39_1 = arg_39_2.target:getPos()
				local var_39_2 = math.random(-10, 5)

				var_39_1.x = var_39_1.x + 5 - math.random() * 15

				local var_39_3 = arg_39_2.useChar:getPos()

				var_39_0.life = var_39_1 and var_39_3 and math.abs(var_39_1.x - var_39_3.x) / math.abs(var_39_0.speed.x) or math.abs(var_39_0.distanceVec.x) / math.abs(var_39_0.speed.x)
			else
				var_39_0.life = math.abs(var_39_0.distanceVec.x) / math.abs(var_39_0.speed.x)
			end

			var_39_0.gravity = 0

			if var_39_0.config.speed_high and var_39_0.config.speed_high ~= 0 then
				local var_39_4 = -(var_39_0.config.speed_high * 2) / math.pow(var_39_0.life / 2, 2)

				var_39_0.speed.y = math.abs(var_39_4) * (var_39_0.life / 2)
				var_39_0.gravity = var_39_4
			end

			table.insert(self.bullets, var_39_0)

			return
		end,
		getBullets = function(self)
			return self.bullets
		end,
		getOrCreateBullet = function(self, arg_41_1)
			local var_41_0 = self:getBulletFromPool(arg_41_1)

			if not var_41_0 then
				local var_41_1 = BeachGuardAsset.getBullet(BeachGuardConst.bullet[arg_41_1].name)

				setParent(var_41_1, self.content)

				var_41_0 = {
					tf = var_41_1,
					config = BeachGuardConst.bullet[arg_41_1]
				}
			end

			return var_41_0
		end,
		getBulletFromPool = function(self, arg_42_1)
			for iter_42_0 = #self.bulletPool, 1, -1 do
				if self.bulletPool[iter_42_0].config.id == arg_42_1 then
					return table.remove(self.bulletPool, iter_42_0)
				end
			end

			return nil
		end,
		finishBullet = function(arg_43_0, arg_43_1)
			setActive(arg_43_1.tf, false)

			return
		end,
		start = function(arg_44_0)
			return
		end,
		step = function(self, arg_45_1)
			for iter_45_0 = #self.bullets, 1, -1 do
				self.bullets[iter_45_0].tf.anchoredPosition = Vector2(self.bullets[iter_45_0].tf.anchoredPosition.x + self.bullets[iter_45_0].speed.x * arg_45_1 * self.bullets[iter_45_0].direct, self.bullets[iter_45_0].tf.anchoredPosition.y + self.bullets[iter_45_0].speed.y * arg_45_1)
				self.bullets[iter_45_0].speed.y = self.bullets[iter_45_0].speed.y + self.bullets[iter_45_0].gravity * arg_45_1

				if self.bullets[iter_45_0].life then
					self.bullets[iter_45_0].life = self.bullets[iter_45_0].life - arg_45_1

					if self.bullets[iter_45_0].life <= 0 then
						if self.bullets[iter_45_0].config.speed_high and self.bullets[iter_45_0].config.speed_high ~= 0 and not self.bullets[iter_45_0].hit then
							self.bullets[iter_45_0].useData.target = nil

							self._event:emit(BeachGuardGameView.BULLET_DAMAGE, {
								damage = self.bullets[iter_45_0].config.damage,
								position = self.bullets[iter_45_0].tf.position,
								useData = self.bullets[iter_45_0].useData
							})
						end

						local var_45_1 = table.remove(self.bullets, iter_45_0)

						self:finishBullet(var_45_1)
						table.insert(self.bulletPool, var_45_1)
					elseif self.bullets[iter_45_0].hit then
						local var_45_2 = table.remove(self.bullets, iter_45_0)

						self:finishBullet(var_45_2)
						table.insert(self.bulletPool, var_45_2)
					end
				end
			end

			return
		end,
		stop = function(arg_46_0)
			return
		end,
		clear = function(self)
			for iter_47_0 = #self.bullets, 1, -1 do
				local var_47_0 = table.remove(self.bullets, iter_47_0)

				setActive(var_47_0.tf, false)

				var_47_0.distanceVec = nil

				table.insert(self.bulletPool, var_47_0)
			end

			return
		end
	}

	var_36_0:Ctor()

	return var_36_0
end

local function var_0_4(arg_48_0, arg_48_1)
	local var_48_0 = {
		Ctor = function(arg_49_0)
			arg_49_0._tf = arg_48_0
			arg_49_0._event = arg_48_1

			return
		end,
		setData = function(self, arg_50_1)
			self._data = arg_50_1
			self._chapterId = self._data.id

			return
		end,
		start = function(self)
			self:clear()

			self._chapterDatas = Clone(self._data.data)

			return
		end,
		step = function(self, arg_52_1)
			self._overTime = self._overTime + arg_52_1

			for iter_52_0 = #self._chapterDatas, 1, -1 do
				if self._chapterDatas[iter_52_0].time < self._overTime then
					table.insert(self.enemyDatas, (self:createData(table.remove(self._chapterDatas, iter_52_0))))
				end
			end

			for iter_52_1 = #self.enemyDatas, 1, -1 do
				if self.enemyDatas[iter_52_1].loop then
					self.enemyDatas[iter_52_1].stepTime = self.enemyDatas[iter_52_1].stepTime - arg_52_1

					if self.enemyDatas[iter_52_1].stepTime <= 0 then
						self.enemyDatas[iter_52_1].stepTime = math.random() * (self.enemyDatas[iter_52_1].step[2] - self.enemyDatas[iter_52_1].step[1]) + self.enemyDatas[iter_52_1].step[1]

						self:addEnemyData(self.enemyDatas[iter_52_1])
					end

					if self._overTime > self.enemyDatas[iter_52_1].stop then
						table.remove(self.enemyDatas, iter_52_1)
					end
				else
					self:addEnemyData(self.enemyDatas[iter_52_1])
					table.remove(self.enemyDatas, iter_52_1)
				end
			end

			self.addEnemyTime = self.addEnemyTime or 1
			self.addEnemyTime = self.addEnemyTime - arg_52_1

			if #self.enemyList > 0 and self.addEnemyTime <= 0 then
				self._event:emit(BeachGuardGameView.ADD_ENEMY, (table.remove(self.enemyList, #self.enemyList)))
			end

			if #self.enemyDatas == 0 and #self._chapterDatas == 0 and #self.enemyList == 0 then
				self.finishCreate = true
			end

			return
		end,
		getFinishCreate = function(self)
			return self.finishCreate
		end,
		createData = function(arg_54_0, arg_54_1)
			local var_54_0 = {}

			if arg_54_1.step then
				var_54_0.loop = true
				var_54_0.stepTime = 0
			else
				var_54_0.loop = false
			end

			var_54_0.create = arg_54_1.create
			var_54_0.time = arg_54_1.time
			var_54_0.stop = arg_54_1.stop
			var_54_0.step = arg_54_1.step
			var_54_0.comming = arg_54_1.comming

			return var_54_0
		end,
		addEnemyData = function(self, arg_55_1)
			if arg_55_1.comming or false then
				arg_55_1.comming = false

				self._event:emit(BeachGuardGameView.ENEMY_COMMING)
			end

			local var_55_1 = BeachGuardConst.create_enemy[arg_55_1.create]

			for iter_55_0 = 1, BeachGuardConst.create_enemy[arg_55_1.create].num do
				table.insert(self.enemyList, {
					id = var_55_1.enemy[math.random(1, #var_55_1.enemy)],
					lines = var_55_1.line
				})
			end

			return
		end,
		stop = function(arg_56_0)
			return
		end,
		clear = function(arg_57_0)
			arg_57_0._overTime = 0
			arg_57_0._chapterDatas = {}
			arg_57_0.enemyDatas = {}
			arg_57_0.enemyList = {}
			arg_57_0.finishCreate = false

			return
		end
	}

	var_48_0:Ctor()

	return var_48_0
end

local function var_0_5(arg_58_0, arg_58_1)
	local var_58_0 = {
		Ctor = function(self)
			self._tf = arg_58_0
			self._event = arg_58_1
			self.effectBackTf = findTF(self._tf, "sceneContainer/scene/effect_back")
			self.effectFrontTf = findTF(self._tf, "sceneContainer/scene/effect_front")
			self.content = findTF(self._tf, "sceneContainer/scene/content")
			self.effects = {}
			self.effectPool = {}

			return
		end,
		setCharCtrl = function(arg_60_0, arg_60_1)
			arg_60_0.charCtrl = arg_60_1

			return
		end,
		setSkillCtrl = function(arg_61_0, arg_61_1)
			arg_61_0.skillCtrl = arg_61_1

			return
		end,
		craeteCharDamage = function(self, arg_62_1)
			self:createDamage(arg_62_1)

			return
		end,
		bulletDamage = function(self, arg_63_1)
			self:createDamage(arg_63_1)

			return
		end,
		createDamage = function(self, arg_64_1)
			local var_64_0 = arg_64_1.position
			local var_64_1 = arg_64_1.useData
			local var_64_2 = arg_64_1.useData.line
			local var_64_3 = arg_64_1.useData.camp

			if not arg_64_1.damage then
				-- block empty
			end

			local var_64_4 = BeachGuardConst.damage[arg_64_1.damage]

			if arg_64_1.useData.target then
				arg_64_1.useData.target:damage(var_64_4.damage * (var_64_1.atkRate or 1))
			end

			if var_64_4.type == BeachGuardConst.bullet_type_range then
				local var_64_6 = var_64_4.config
				local var_64_8 = var_64_4.config.range
				local var_64_9 = self.charCtrl:getLineCampChars({
					var_64_2 + 1,
					var_64_2 - 1,
					var_64_2
				}, var_64_3 == 1 and 2 or 1)
				local var_64_10 = var_64_1.target and var_64_1.target:getPos() or self.effectFrontTf:InverseTransformPoint(var_64_0)

				if var_64_9 and #var_64_9 > 0 then
					for iter_64_0 = 1, #var_64_9 do
						if (not var_64_1.target or var_64_1.target ~= var_64_9[iter_64_0]) and var_64_8 * BeachGuardConst.part_width > math.abs(var_64_10.x - var_64_9[iter_64_0]:getPos().x) then
							local var_64_11 = var_64_9[iter_64_0]:getWorldPos()
							local var_64_12 = Clone(var_64_1)

							var_64_12.target = var_64_9[iter_64_0]

							self:createDamage({
								damage = var_64_6.next,
								position = var_64_11,
								useData = var_64_12
							})
						end
					end
				end
			elseif var_64_4.type == BeachGuardConst.bullet_type_disperse then
				local var_64_13 = var_64_4.config
				local var_64_14 = var_64_4.config.down
				local var_64_15 = var_64_3 == 1 and 2 or 1

				self:addDamageByDisperse({
					var_64_2 - 1
				}, var_64_4.config.range, var_64_3 == 1 and 2 or 1, var_64_4.config.up, var_64_1)
				self:addDamageByDisperse({
					var_64_2 + 1
				}, var_64_13.range, var_64_15, var_64_14, var_64_1)
			end

			if var_64_4.buff and #var_64_4.buff > 0 then
				for iter_64_1 = 1, #var_64_4.buff do
					if BeachGuardConst.buff[var_64_4.buff[iter_64_1]].trigger == BeachGuardConst.buff_trigger_other then
						var_64_1.target:addBuff(BeachGuardConst.buff[var_64_4.buff[iter_64_1]])
					elseif BeachGuardConst.buff[var_64_4.buff[iter_64_1]].trigger == BeachGuardConst.buff_trigger_self then
						var_64_1.useChar:addBuff(BeachGuardConst.buff[var_64_4.buff[iter_64_1]])

						if BeachGuardConst.buff[var_64_4.buff[iter_64_1]].bound and BeachGuardConst.buff[var_64_4.buff[iter_64_1]].bound ~= nil then
							local var_64_17 = var_64_1.useChar:getCamp()
							local var_64_18 = var_64_1.useChar:getLineIndex()
							local var_64_19 = var_64_1.useChar:getGridIndex()

							if var_64_18 and var_64_19 then
								for iter_64_2, iter_64_3 in ipairs((self.charCtrl:getCharByCamp(var_64_17))) do
									if iter_64_3 ~= var_64_1.useChar then
										if math.abs(iter_64_3:getGridIndex() - var_64_19) <= BeachGuardConst.buff[var_64_4.buff[iter_64_1]].bound[1] and math.abs(iter_64_3:getLineIndex() - var_64_18) <= BeachGuardConst.buff[var_64_4.buff[iter_64_1]].bound[2] then
											iter_64_3:addBuff(BeachGuardConst.buff[var_64_4.buff[iter_64_1]])
										end
									end
								end
							end
						end
					end
				end
			end

			if var_64_4.effect and #var_64_4.effect > 0 then
				self:createEffect(var_64_4.effect, var_64_0)
			end

			return
		end,
		addDamageByDisperse = function(self, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5)
			local var_65_0 = self.charCtrl:getLineCampChars(arg_65_1, arg_65_3)

			if var_65_0 and #var_65_0 > 0 then
				local var_65_1 = arg_65_5.target:getPos()

				for iter_65_0 = 1, #var_65_0 do
					if arg_65_2 * BeachGuardConst.part_width > math.abs(var_65_1.x - var_65_0[iter_65_0]:getPos().x) then
						local var_65_2 = var_65_0[iter_65_0]:getWorldPos()
						local var_65_3 = Clone(arg_65_5)

						var_65_3.target = var_65_0[iter_65_0]

						self:createDamage({
							damage = arg_65_4,
							position = var_65_2,
							useData = var_65_3
						})
					end
				end
			end

			return
		end,
		createEffect = function(self, arg_66_1, arg_66_2)
			local var_66_0 = self:getEffect(arg_66_1[1])

			if not var_66_0 then
				-- block empty
			end

			if not var_66_0 then
				return
			end

			var_66_0.tf.anchoredPosition = self.effectFrontTf:InverseTransformPoint(arg_66_2)

			setActive(var_66_0.tf, true)

			var_66_0.time = var_66_0.config.time

			table.insert(self.effects, var_66_0)

			return
		end,
		getEffect = function(self, arg_67_1)
			if #self.effectPool > 0 then
				for iter_67_0 = #self.effectPool, 1, -1 do
					if self.effectPool[iter_67_0].config.id == arg_67_1 then
						return (table.remove(self.effectPool, iter_67_0))
					end
				end
			end

			local var_67_1 = BeachGuardConst.effect[arg_67_1]
			local var_67_2 = BeachGuardAsset.getEffect(BeachGuardConst.effect[arg_67_1].name)

			setParent(var_67_2, self.effectFrontTf)

			return {
				tf = var_67_2,
				config = var_67_1
			}
		end,
		start = function(arg_68_0)
			return
		end,
		step = function(self, arg_69_1)
			local var_69_0 = self.skillCtrl:getBullets()

			for iter_69_0 = 1, #var_69_0 do
				for iter_69_1, iter_69_2 in ipairs((self.charCtrl:getCanHitChar(var_69_0[iter_69_0].useData.line, var_69_0[iter_69_0].useData.camp))) do
					if not false and iter_69_2:inBulletBound() and iter_69_2:checkBulletCollider(var_69_0[iter_69_0].tf.position) then
						var_69_0[iter_69_0].hit = true
						var_69_0[iter_69_0].useData.target = iter_69_2

						self:createDamage({
							damage = var_69_0[iter_69_0].config.damage,
							position = var_69_0[iter_69_0].useData.target:getAnimPos(),
							useData = var_69_0[iter_69_0].useData
						})
					end
				end
			end

			for iter_69_3 = #self.effects, 1, -1 do
				if self.effects[iter_69_3].time and self.effects[iter_69_3].time > 0 then
					self.effects[iter_69_3].time = self.effects[iter_69_3].time - arg_69_1

					if self.effects[iter_69_3].time <= 0 then
						self.effects[iter_69_3].time = 0

						setActive(self.effects[iter_69_3].tf, false)
						table.insert(self.effectPool, (table.remove(self.effects, iter_69_3)))
					end
				end
			end

			return
		end,
		stop = function(arg_70_0)
			return
		end,
		clear = function(self)
			for iter_71_0 = #self.effects, 1, -1 do
				setActive(self.effects[iter_71_0].tf, false)
				table.insert(self.effectPool, table.remove(self.effects, iter_71_0))
			end

			return
		end
	}

	var_58_0:Ctor()

	return var_58_0
end

function BeachGuardSceneMgr:Ctor(arg_72_1, arg_72_2, arg_72_3)
	self._tf = arg_72_1
	self._event = arg_72_3
	self._gameData = arg_72_2
	self.asset = self._gameData.asset
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 0.03333333333333333, -1)

	self:init()

	return
end

function BeachGuardSceneMgr:init()
	self.charTpl = findTF(self._tf, "sceneContainer/scene/classes/charTpl")
	self.charCtrl = var_0_1(self._tf, self.charTpl, self._event)
	self.lineCtrl = var_0_2(self._tf, self._event)
	self.skillCtrl = var_0_3(self._tf, self._event)
	self.enemyCtrl = var_0_4(self._tf, self._event)
	self.damageCtrl = var_0_5(self._tf, self._event)

	self.damageCtrl:setCharCtrl(self.charCtrl)
	self.damageCtrl:setSkillCtrl(self.skillCtrl)
	self.timer:Start()

	return
end

function BeachGuardSceneMgr:onTimer()
	self.lineCtrl:onTimer()

	return
end

function BeachGuardSceneMgr:setData(arg_76_1)
	self._runningData = arg_76_1

	local var_76_0 = BeachGuardConst.map_data[BeachGuardConst.chapter_data[self._runningData.chapter].map]

	self.lineCtrl:setMapData(BeachGuardConst.map_data[BeachGuardConst.chapter_data[self._runningData.chapter].map])
	self.enemyCtrl:setData(BeachGuardConst.chapater_enemy[self._runningData.chapter])

	if arg_76_1.fog then
		setActive(findTF(self._tf, "sceneContainer/scene_front/fog"), true)
	else
		setActive(findTF(self._tf, "sceneContainer/scene_front/fog"), false)
	end

	local var_76_1 = GetComponent(findTF(self._tf, "sceneBg/map"), typeof(Image))

	var_76_1.sprite = BeachGuardAsset.getBeachMap(var_76_0.pic)

	var_76_1:SetNativeSize()

	return
end

function BeachGuardSceneMgr:start()
	self.charCtrl:start()
	self.skillCtrl:start()
	self.enemyCtrl:start()
	self.damageCtrl:start()
	self.lineCtrl:start()

	return
end

function BeachGuardSceneMgr:step()
	self.charCtrl:step(self._runningData.deltaTime)
	self.skillCtrl:step(self._runningData.deltaTime)
	self.enemyCtrl:step(self._runningData.deltaTime)
	self.damageCtrl:step(self._runningData.deltaTime)
	self.lineCtrl:step(self._runningData.deltaTime)

	if self.charCtrl:getEnemyOver() then
		self._event:emit(BeachGuardGameView.GAME_OVER)
	elseif #self.charCtrl:getEnemys() == 0 and self.enemyCtrl:getFinishCreate() then
		self._event:emit(BeachGuardGameView.GAME_OVER)
	end

	return
end

function BeachGuardSceneMgr:stop()
	self.charCtrl:stop()
	self.skillCtrl:stop()
	self.enemyCtrl:stop()
	self.damageCtrl:stop()

	return
end

function BeachGuardSceneMgr:clear()
	self.charCtrl:clear()
	self.lineCtrl:clear()
	self.skillCtrl:clear()
	self.enemyCtrl:clear()
	self.damageCtrl:clear()

	return
end

function BeachGuardSceneMgr:changeRecycles(arg_81_1)
	self.charCtrl:changeRecycles(arg_81_1)

	return
end

function BeachGuardSceneMgr:pullChar(arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = self.lineCtrl:getGridByIndex(arg_82_2, arg_82_3)

	if var_82_0 and var_82_0:isEmpty() then
		var_82_0:setChar((self.charCtrl:setGridChar(arg_82_1, var_82_0)))

		return true
	end

	return false
end

function BeachGuardSceneMgr:setDrag(arg_83_1)
	self.lineCtrl:setDrag(arg_83_1)

	return
end

function BeachGuardSceneMgr:useSkill(arg_84_1)
	self.skillCtrl:useSkill(arg_84_1)

	return
end

function BeachGuardSceneMgr:addEnemy(arg_85_1)
	self.charCtrl:addEnemyChar(arg_85_1.id, (self.lineCtrl:getAbleLinePos(arg_85_1.lines)))

	return
end

function BeachGuardSceneMgr:craeteCharDamage(arg_86_1)
	self.damageCtrl:craeteCharDamage(arg_86_1)

	return
end

function BeachGuardSceneMgr:removeChar(arg_87_1)
	self.charCtrl:removeChar(arg_87_1)
	self.lineCtrl:removeGridChar(arg_87_1)

	return
end

function BeachGuardSceneMgr:bulletDamage(arg_88_1)
	self.damageCtrl:bulletDamage(arg_88_1)

	return
end

function BeachGuardSceneMgr:dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return BeachGuardSceneMgr
