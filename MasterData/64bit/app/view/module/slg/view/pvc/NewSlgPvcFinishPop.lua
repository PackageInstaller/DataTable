local NewSlgPvcFinishPop = class("NewSlgPvcFinishPop", require("app.fairyGUI.newSlg.UI_NewSlgPvcFinishPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgPvcFinishPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPvcFinishPop:ctor(arg_2_1)
	self:showAtCenter()

	self._result = arg_2_1.result
	self._callback = arg_2_1.callback

	self:updateFinishPop()
end

function NewSlgPvcFinishPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onClose))
end

function NewSlgPvcFinishPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgPvcFinishPop:updateFinishPop()
	local var_5_0 = self._result.city_battle_result
	local var_5_2 = {
		0.5,
		0.25
	}

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_TouziSuccess)

	if self._result.boss_battle_result then
		local var_5_7 = g.core.model.User.newSlgData:getBossInfoById(self._result.boss_battle_result.boss_id)
		local var_5_8 = var_5_7.level
		local var_5_9 = var_5_7.name
		local var_5_10 = display.newSprite("#" .. g.core.common.Path:getNewSlgMonster(g.core.model.User.newSlgData:getBossComponentById(self._result.boss_battle_result.boss_id).res_1))

		var_5_10:setAnchorPoint(var_5_2[1], var_5_2[2])
		self.m_cityComp:getChild("Comp_place"):addNode(var_5_10)

		if self._result.boss_battle_result.is_win then
			local var_5_11 = g.core.lang:get(428982)

			self.m_stateComp:getChild("title"):setText(var_5_11)
			self.m_stateComp:getChild("title2"):setText(var_5_11)
			self.m_stateController:setSelectedIndex(0)
		else
			local var_5_12 = g.core.lang:get(428983)

			self.m_stateComp:getChild("title"):setText(var_5_12)
			self.m_stateComp:getChild("title2"):setText(var_5_12)
			self.m_stateController:setSelectedIndex(1)
		end

		self.m_nameComp:getChild("Txt_level"):setText(g.core.lang:get(429003, {
			level = var_5_8
		}))
		self.m_nameComp:getChild("Txt_name"):setText(var_5_9)
	elseif self._result.monster_battle_result then
		local var_5_13 = g.core.model.User.newSlgData:getMonsterInfoById(self._result.monster_battle_result.monster_id)
		local var_5_14 = var_5_13.level
		local var_5_15 = var_5_13.name

		var_5_2 = {
			0.5,
			0.5
		}

		local var_5_16 = display.newSprite("#" .. g.core.common.Path:getNewSlgMonster(var_5_13.res .. "_00"))

		var_5_16:setAnchorPoint(var_5_2[1], var_5_2[2])
		self.m_cityComp:getChild("Comp_place"):addNode(var_5_16)

		if self._result.monster_battle_result.is_win then
			local var_5_17 = g.core.lang:get(428982)

			self.m_stateComp:getChild("title"):setText(var_5_17)
			self.m_stateComp:getChild("title2"):setText(var_5_17)
			self.m_stateController:setSelectedIndex(0)
		else
			local var_5_18 = g.core.lang:get(428983)

			self.m_stateComp:getChild("title"):setText(var_5_18)
			self.m_stateComp:getChild("title2"):setText(var_5_18)
			self.m_stateController:setSelectedIndex(1)
		end

		self.m_nameComp:getChild("Txt_level"):setText(g.core.lang:get(429003, {
			level = var_5_14
		}))
		self.m_nameComp:getChild("Txt_name"):setText(var_5_15)
	elseif var_5_0 then
		local var_5_19 = g.core.model.User.newSlgData:getCityInfoById(var_5_0.city_id)
		local var_5_20 = var_5_19.level
		local var_5_21 = var_5_19.name
		local var_5_22 = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(g.core.model.User.newSlgData:getCityComponentById(var_5_0.city_id).res_1))

		var_5_22:setAnchorPoint(var_5_2[1], var_5_2[2])
		var_5_22:setScale(200 / var_5_22:getContentSize().width)
		self.m_cityComp:getChild("Comp_place"):addNode(var_5_22)

		if var_5_0.final_winner then
			self.m_stateController:setSelectedIndex(0)

			if var_5_0.rank == 1 then
				local var_5_23 = g.core.lang:get(428980)

				self.m_stateComp:getChild("title"):setText(var_5_23)
				self.m_stateComp:getChild("title2"):setText(var_5_23)
			else
				local var_5_24 = g.core.lang:get(428981)

				self.m_stateComp:getChild("title"):setText(var_5_24)
				self.m_stateComp:getChild("title2"):setText(var_5_24)
			end
		elseif var_5_0.is_win then
			local var_5_26 = g.core.lang:get(428980)

			self.m_stateComp:getChild("title"):setText(var_5_26)
			self.m_stateComp:getChild("title2"):setText(var_5_26)
			self.m_stateController:setSelectedIndex(0)
		else
			local var_5_27 = g.core.lang:get(428981)

			self.m_stateComp:getChild("title"):setText(var_5_27)
			self.m_stateComp:getChild("title2"):setText(var_5_27)
			self.m_stateController:setSelectedIndex(1)
		end

		self.m_nameComp:getChild("Txt_level"):setText(g.core.lang:get(429003, {
			level = var_5_20
		}))
		self.m_nameComp:getChild("Txt_name"):setText(var_5_21)
	end
end

function NewSlgPvcFinishPop:onUnload()
	if self._callback then
		self._callback()
	end
end

return NewSlgPvcFinishPop
