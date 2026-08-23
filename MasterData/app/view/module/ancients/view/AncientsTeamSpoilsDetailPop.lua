local AncientsTeamSpoilsDetailPop = class("AncientsTeamSpoilsDetailPop", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsDetailPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsTeamSpoilsDetailPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function var_0_1:ctor(arg_2_1)
	self._diceEffect = nil
	self._diceEffect2 = nil

	self.m_diceAnimMask:setSize(display.width, display.height)
	self:getView():center(true)

	self._cellData = arg_2_1

	self.m_Btn_alloate:addClickListener(handler(self, self._onClickBtnAlloate))
	self.m_Btn_giveup:addClickListener(handler(self, self._onClickBtnGiveup))
	self.m_List_dices:setVirtual(self)
	self.m_List_dices:setItemRenderer(handler(self, self._onRenderListDices))
	self.m_enterTransition:play()
end

function var_0_1:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICENOTIFY, handler(self, self._onRevDiceNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICEROLL, handler(self, self._onRevDiceRoll), self)
	self:_updateView()
end

function var_0_1:_onRevDiceNotify(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if self._weekDay == arg_4_4.score_day and arg_4_4.dice.id == self._cellData.info.id then
		self._cellData.dices = arg_4_4.dice.rolls
	end

	self:_updateView()
end

function var_0_1:_onRevDiceRoll(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_4.points % 10
	local var_5_1 = math.floor(arg_5_4.points / 10)

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Dice)

	if not self._diceEffect then
		self.m_diceAnimController:setSelectedIndex(1)

		self._diceEffect = self.m_dicePlaceHolder:addEffectSpine({
			name = "dice2",
			isLoop = false,
			anim = "turn",
			scale = 0.3,
			eventHandler = function(self)
				if self.type == "complete" then
					self._diceEffect:setAnimation(0, tostring(var_5_1), false)
					self._diceEffect:addSpineEventListener(handler(self, self._onAnimationEnd))
				end
			end
		})
		self._diceEffect2 = self.m_dicePlaceHolder2:addEffectSpine({
			name = "dice2",
			isLoop = false,
			anim = "turn",
			scale = 0.3,
			eventHandler = function(self)
				if self.type == "complete" then
					self._diceEffect2:setAnimation(0, tostring(var_5_0), false)
				end
			end
		})
	end
end

function var_0_1:_onAnimationEnd(arg_8_1)
	if arg_8_1.type == "complete" then
		self._diceEffect:removeFromParent()
		self._diceEffect2:removeFromParent()

		self._diceEffect = nil
		self._diceEffect2 = nil

		self.m_diceAnimController:setSelectedIndex(0)
		self:_updateView()
	end
end

function var_0_1:_updateView()
	self._weekDay = self._cellData.weekDay

	self.m_is_emptyController:setSelectedIndex(self._cellData.dices and #self._cellData.dices > 0 and 0 or 1)
	self.m_Comp_icon:updateIcon((g.core.common.Goods:convert({
		type = self._cellData.info.type,
		value = self._cellData.info.value,
		size = self._cellData.info.size
	})))
	self.m_Comp_cost:updateByTVS({
		value = 12004,
		size = 1,
		showOwn = true,
		type = g.core.common.Goods.TYPE_ITEM
	})

	local var_9_0

	if self._cellData.dices then
		for iter_9_0, iter_9_1 in ipairs(self._cellData.dices) do
			if iter_9_1.uid == g.core.model.User:getId() then
				var_9_0 = iter_9_1
			end
		end
	end

	self.m_has_myDiceController:setSelectedIndex(var_9_0 and 1 or 0)

	if var_9_0 then
		self.m_Txt_curPoint:setText(var_9_0.points)
	end

	if self._cellData.dices and #self._cellData.dices > 0 then
		table.sort(self._cellData.dices, function(arg_10_0, arg_10_1)
			return arg_10_0.points > arg_10_1.points
		end)
		self.m_List_dices:setNumItems(#self._cellData.dices)
	end
end

function var_0_1:_onClickBtnAlloate()
	if self._diceEffect then
		return
	end

	if g.core.model.User.ancientsData:getSelfDiceNum() > 0 then
		g.core.network.GameNetProxy:send_C2S_Ancient_DiceRoll({
			id = self._cellData.info.id,
			score_day = self._weekDay
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 12004,
			type = g.core.common.Goods.TYPE_ITEM
		})
	end
end

function var_0_1._onClickBtnGiveup(arg_12_0)
	g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
		text = g.core.lang:get(433374),
		text_ok = g.core.lang:get(300033),
		text_cancel = g.core.lang:get(1037),
		handler_ok = function()
			g.core.network.GameNetProxy:send_C2S_Ancient_DiceGiveUp({
				id = arg_12_0._cellData.info.id,
				score_day = arg_12_0._weekDay
			})
		end
	})))
end

function var_0_1:_onRenderListDices(arg_14_1, arg_14_2)
	arg_14_2:updateCell(self._cellData.dices[arg_14_1 + 1])
end

return var_0_1
