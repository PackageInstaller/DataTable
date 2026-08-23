local AncientsBattleResultPop = class("AncientsBattleResultPop", require("app.fairyGUI.ancients.UI_AncientsBattleResultPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsBattleResultPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor(arg_2_1)
	self:getView():center(true)
	self.m_Comp_click:addClickListener(handler(self, self._onClickSelf))
	self.m_List_user:setVirtual(self)
	self.m_List_user:setItemRenderer(handler(self, self._onRenderListUserCell))

	self._resultData = arg_2_1 or {}
	self._resultData.settles = self._resultData.settles or {}
	self._resultData.loot_exp = self._resultData.loot_exp or 0

	self.m_enterTransition:play()

	self._schedule = nil
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._resultData.settles) do
		table.insert(var_3_0, iter_3_1.uid)
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_3_0) then
		self:_updateView()
	end
end

function var_0_0:_updateView()
	local var_4_0 = self._resultData.is_win

	if self._resultData.is_win then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_Success)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_JuXiang_Battle_Fail)
	end

	self.m_is_winController:setSelectedIndex(var_4_0 and 1 or 0)

	local var_4_1 = self:_calTotalScore(var_4_0)

	self.m_Txt_score:setText(g.core.lang:get(433405, {
		score = var_4_1
	}))
	self.m_Txt_score_add:setText(var_4_1)

	local var_4_2 = g.core.model.User.ancientsData:getAwardProg(self._resultData.loot_exp)
	local var_4_3 = g.core.model.User.ancientsData:getAwardProg(g.core.model.User.ancientsData:getOldAwardExp())

	self._data = var_4_2
	self._oldData = var_4_3
	self._value = var_4_2.now

	if var_4_2.isMax then
		self.m_Txt_score_prog:setText(g.core.lang:get(429581))
	else
		self.m_Txt_score_prog:setText(g.core.lang:get(107056, {
			num = var_4_2.now,
			maxNum = var_4_2.max
		}))
	end

	if var_4_2.cfg then
		local var_4_4 = {}

		var_4_4.name = var_4_2.cfg.name or ""

		self.m_Txt_award:setText(g.core.lang:get(433317, var_4_4))

		if self._oldData.cfg.quality ~= var_4_2.cfg.quality then
			self.m_Loader_award_icon:setURL(g.core.common.Path:getAncientsTeamBoxIcon(self._oldData.cfg.quality))
		else
			self.m_Loader_award_icon:setURL(g.core.common.Path:getAncientsTeamBoxIcon(var_4_2.cfg.quality))
		end
	end

	self.m_List_user:setNumItems(#self._resultData.settles)
	self.m_Comp_effect_resultPlay:removeAllEffect()
	self.m_Comp_effect_resultLoop:removeAllEffect()
	self.m_Comp_effect_resultBg:removeAllEffect()
	self.m_Comp_effect_up:removeAllEffect()
	self:_cancelSchedule()

	if var_4_3.isMax then
		self.m_Prog_score:setMax(var_4_2.max)
		self.m_Prog_score:setValue(var_4_2.max)
	else
		self.m_Prog_score:setValue(var_4_3.now)
		self.m_Prog_score:setMax(var_4_3.max)

		self._schedule = self:newSchedule(handler(self, self._updateProg), 0.01)
	end

	local var_4_5 = "eff_ui_ancientsBattle_resultWin"
	local var_4_7 = "eff_ui_ancientsBattle_resultWinbg"

	if var_4_0 then
		-- block empty
	else
		var_4_5 = "eff_ui_ancientsBattle_resultLose"
		var_4_7 = "eff_ui_ancientsBattle_resultLosebg"
	end

	self.m_Comp_effect_resultPlay:addEffectSpine({
		anim = "play",
		remove = true,
		isLoop = false,
		name = var_4_5
	})
	self.m_Comp_effect_resultLoop:addEffectSpine({
		anim = "loop",
		remove = false,
		isLoop = true,
		name = var_4_5
	})
	self.m_Comp_effect_resultBg:addEffectSpine({
		anim = "play",
		remove = false,
		isLoop = true,
		name = var_4_7
	})
end

function var_0_0:_updateProg()
	local var_5_0 = self.m_Prog_score:getValue() + 2

	if self._data.cfg.quality ~= self._oldData.cfg.quality then
		if var_5_0 >= self._oldData.max then
			self.m_Prog_score:setValue(0)
			self.m_Prog_score:setMax(self._data.max)

			self._oldData = self._data

			self.m_Comp_effect_up:addEffectSpine({
				name = "eff_ui_ancients_resultboxlight",
				remove = true,
				isLoop = false,
				anim = (self._resultData.is_win or nil) and "win"
			})
			self.m_Loader_award_icon:setURL(g.core.common.Path:getAncientsTeamBoxIcon(self._data.cfg.quality))
		else
			self.m_Prog_score:setValue(var_5_0)
		end
	elseif var_5_0 >= self._value then
		self:_cancelSchedule()
		self.m_Prog_score:setValue(self._value)
	else
		self.m_Prog_score:setValue(var_5_0)
	end
end

function var_0_0:_cancelSchedule()
	if self._schedule ~= nil then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end
end

function var_0_0._onClickSelf(arg_7_0)
	g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
end

function var_0_0:_onRenderListUserCell(arg_8_1, arg_8_2)
	arg_8_2:updateCell({
		settle = self._resultData.settles[arg_8_1 + 1],
		isWin = self._resultData.is_win
	})
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateView()
end

function var_0_0:_calTotalScore(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._resultData.settles) do
		var_10_0 = var_10_0 + iter_10_1.score
	end

	return var_10_0
end

function var_0_0:_calAwardProg()
	local var_11_0 = g.core.model.User.ancientsData:getTeamPetId()

	if not var_11_0 or var_11_0 == 0 then
		return 0, 0, nil
	end

	local var_11_1 = g.core.config.ancients_pet_info.fetch(var_11_0).award_group
	local var_11_2 = {}

	for iter_11_0 = 1, g.core.config.ancients_award_info.getLength() do
		local var_11_3 = g.core.config.ancients_award_info.indexOf(iter_11_0)

		if var_11_3.award_group == var_11_1 then
			table.insert(var_11_2, var_11_3)
		end
	end

	table.sort(var_11_2, function(arg_12_0, arg_12_1)
		return arg_12_0.exp < arg_12_1.exp
	end)

	local var_11_4 = var_11_2[1]
	local var_11_5

	for iter_11_1 = #var_11_2, 1, -1 do
		if self._resultData.loot_exp >= var_11_2[iter_11_1].exp then
			var_11_4 = var_11_2[iter_11_1]
			var_11_5 = var_11_2[iter_11_1 + 1]

			break
		end
	end

	if not var_11_5 then
		return 0, 0, var_11_4, true
	end

	return self._resultData.loot_exp - var_11_4.exp, var_11_5.exp - var_11_4.exp, var_11_4, false
end

return var_0_0
