local var_0_0 = g.core.const.ConstMgr.SpineConst
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local var_0_2 = g.core.config.succuba_battle_info
local BattleSuccubaComparePop = class("BattleSuccubaComparePop", require("app.fairyGUI.battle.UI_BattleSuccubaComparePop"), function()
	return fgui.GComponent:create({
		resName = "BattleSuccubaComparePop",
		pkgName = "battle",
		isFullScreen = true,
		pkgPath = "ui/battle/battle"
	})
end)

function BattleSuccubaComparePop:ctor(arg_2_1, arg_2_2)
	self._battleLayer = arg_2_1
	self._endEvent = arg_2_2

	local var_2_0 = arg_2_1:getBattleData()
	local var_2_1 = {
		{
			value = var_2_0:getSuccubaValue(1),
			data = var_2_0:getSuccuba(1)
		},
		{
			value = var_2_0:getSuccubaValue(2),
			data = var_2_0:getSuccuba(2)
		}
	}

	self._ownSpine = nil
	self._enemySpine = nil

	self.m_myValueTxt:setText(var_2_1[1].value)
	self.m_otherValueTxt:setText(var_2_1[2].value)

	local var_2_2 = self:checkCompare(var_2_1[1].value, var_2_1[2].value)

	self.m_winOwnerController:setSelectedIndex(var_2_1[1].value > var_2_1[2].value and 0 or 1)
	self.m_winStateController:setSelectedIndex(var_2_2)

	if var_2_1[1].value == 0 then
		if var_2_1[2].value == 0 then
			self.m_stateController:setSelectedIndex(2)
		else
			local var_2_3 = {
				useBattle = true,
				isAlphaNode = true
			}

			if var_2_1[2].data[1] then
				local var_2_4 = var_2_1[2].data[1].id or 0

				if var_2_4 ~= 0 then
					var_2_3.resId = g.core.config.succuba_info.get(var_2_4).advance_id

					local var_2_5 = DrawSuccuba.new(var_2_3)

					self.m_enemySpine:addChild(var_2_5)

					self._enemySpine = var_2_5
				end
			end

			self.m_stateController:setSelectedIndex(0)
		end
	else
		local var_2_6 = {
			useBattle = true,
			isAlphaNode = true
		}

		if var_2_1[1].data[1] then
			local var_2_7 = var_2_1[1].data[1].id or 0

			if var_2_7 ~= 0 then
				var_2_6.resId = g.core.config.succuba_info.get(var_2_7).advance_id

				local var_2_8 = DrawSuccuba.new(var_2_6)

				self.m_ownSpine:addChild(var_2_8)

				self._ownSpine = var_2_8
			end

			if var_2_1[2].value == 0 then
				self.m_stateController:setSelectedIndex(1)

				goto label_2_0
			end
		end

		local var_2_9 = {
			useBattle = true,
			isAlphaNode = true
		}

		if var_2_1[2].data[1] then
			local var_2_10 = var_2_1[2].data[1].id or 0

			if var_2_10 ~= 0 then
				var_2_9.resId = g.core.config.succuba_info.get(var_2_10).advance_id

				local var_2_11 = DrawSuccuba.new(var_2_9)

				self.m_enemySpine:addChild(var_2_11)

				self._enemySpine = var_2_11
			end
		end

		self.m_stateController:setSelectedIndex(3)
	end

	::label_2_0::

	self:play()
end

function BattleSuccubaComparePop:checkCompare(arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = 0

	if arg_3_2 < arg_3_1 then
		var_3_1 = arg_3_2 == 0 and 99999 or math.floor((arg_3_1 - arg_3_2) / arg_3_2 * 1000)
	elseif arg_3_1 ~= arg_3_2 then
		var_3_1 = arg_3_1 == 0 and 99999 or math.floor((arg_3_2 - arg_3_1) / arg_3_1 * 1000)
	end

	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		if var_3_1 >= iter_3_1.score_low and var_3_1 < iter_3_1.score_high then
			var_3_0 = iter_3_1.id

			break
		end
	end

	return var_3_0 - 1
end

function BattleSuccubaComparePop:onLoad()
	if self._ownSpine then
		self._ownSpine:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-500, 0, 600, 0), 150)
	end

	if self._enemySpine then
		self._enemySpine:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(200, 0, 600, 0), 150)
	end
end

function BattleSuccubaComparePop:onUnload()
	return
end

function BattleSuccubaComparePop:play()
	self.m_effVS:addEffectSpine({
		isLoop = false,
		name = "eff_ui_battle_arenaVS",
		remove = true
	})
	self:getView():getTransition("enter"):play(handler(self, function()
		if self._endEvent then
			self._endEvent()
		end
	end))
end

return BattleSuccubaComparePop
