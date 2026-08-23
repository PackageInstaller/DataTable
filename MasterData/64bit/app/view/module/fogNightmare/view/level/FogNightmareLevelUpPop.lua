local var_0_0 = g.core.config.fog_level_info
local var_0_1 = {
	GREEN = 2,
	RED = 1,
	WHITE = 0
}
local var_0_2 = g.core.model.User.fogNightmareData
local FogNightmareLevelUpPop = class("FogNightmareLevelUpPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareLevelUpPop"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		isFullScreen = false,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareLevelUpPop"
	}, ...)
end)

function FogNightmareLevelUpPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._curShowLevel = arg_2_2
	self._beforeLevel = arg_2_1
	self._callback = arg_2_3
	self._spine = nil
	self._iconBgSpine = nil

	self:_initView()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_LEVEL_UP)
end

function FogNightmareLevelUpPop:_initView()
	self:showAtCenter()
	self:addBg("bg/fogNightmare/bg_wjmy_levelup.png", false, nil, 1):setTouchable(false)

	self._spine = self.m_effComTitle:addEffectSpine({
		name = "eff_ui_FogNightmare_comTitle",
		anim = "play",
		isLoop = false,
		eventHandler = handler(self, self._loopEffect)
	})

	self.m_effArrow:addEffectSpine({
		isLoop = false,
		name = "eff_ui_FogNightmare_levelUpArrow",
		anim = "play"
	})

	self._iconBgSpine = self.m_effIconbg:addEffectSpine({
		name = "eff_ui_FogNightmare_levelUpIconbg",
		anim = "play",
		isLoop = false,
		eventHandler = handler(self, self._iconBgEffect)
	})

	self.m_beforeLevelText:setText(self._beforeLevel)
	self.m_curLevelText:setText(self._curShowLevel)
end

function FogNightmareLevelUpPop:_loopEffect(arg_4_1)
	if arg_4_1.type == "complete" and self._spine and not tolua.isnull(self._spine) then
		self._spine:setAnimation(0, "play2", true)
	end
end

function FogNightmareLevelUpPop:_iconBgEffect(arg_5_1)
	if arg_5_1.type == "complete" and self._iconBgSpine and not tolua.isnull(self._iconBgSpine) then
		self._iconBgSpine:setAnimation(0, "play2", true)
	end
end

function FogNightmareLevelUpPop:onLoad()
	self:updateView()
end

function FogNightmareLevelUpPop:updateView()
	self:updateDescComp(var_0_0.get(self._curShowLevel), (var_0_0.fetch(self._beforeLevel)))
end

function FogNightmareLevelUpPop:updateDescComp(arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = 1

	if arg_8_1.seal_level > 0 then
		local var_8_2 = var_0_2:getFogLevelUnlockMaxSealCount(arg_8_1.level)
		local var_8_3 = var_0_1.GREEN
		local var_8_4 = var_0_1.GREEN

		if arg_8_2 and arg_8_1.seal_level > arg_8_2.seal_level then
			var_8_3 = var_0_1.RED

			if var_8_2 > var_0_2:getFogLevelUnlockMaxSealCount(arg_8_2.level) then
				var_8_4 = var_0_1.RED
			end
		end

		table.insert(var_8_0, {
			desc = g.core.lang:get(500212),
			color = var_8_3,
			num = arg_8_1.seal_level
		})
		table.insert(var_8_0, {
			desc = g.core.lang:get(500213),
			color = var_8_4,
			num = var_8_2
		})

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.idle_time > 0 then
		local var_8_5, var_8_6 = var_0_2:getMaxIdleTimeDHByLevel(self._curShowLevel)

		table.insert(var_8_0, {
			desc = g.core.lang:get(500214),
			color = (arg_8_2 and arg_8_1.idle_time > arg_8_2.idle_time or nil) and var_0_1.RED,
			num = (function(arg_9_0, arg_9_1)
				local var_9_0 = ""

				if arg_9_0 > 0 and arg_9_1 > 0 then
					var_9_0 = g.core.lang:get(500120, {
						day = arg_9_0,
						hour = arg_9_1
					})
				elseif arg_9_0 > 0 then
					var_9_0 = g.core.lang:get(500121, {
						day = arg_9_0
					})
				elseif arg_9_1 > 0 then
					var_9_0 = g.core.lang:get(500122, {
						hour = arg_9_1
					})
				end

				return var_9_0
			end)(var_8_5, var_8_6)
		})

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.talent_addition_level > 0 then
		table.insert(var_8_0, {
			desc = g.core.lang:get(500215),
			color = (arg_8_2 and arg_8_1.talent_addition_level > arg_8_2.talent_addition_level or nil) and var_0_1.RED,
			num = arg_8_1.talent_addition_level
		})

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.knight_num > 0 then
		table.insert(var_8_0, {
			desc = g.core.lang:get(500216),
			color = (arg_8_2 and arg_8_1.knight_num > arg_8_2.knight_num or nil) and var_0_1.RED,
			num = arg_8_1.knight_num
		})

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.seal_times > 0 then
		table.insert(var_8_0, {
			desc = g.core.lang:get(500239),
			color = (arg_8_2 and arg_8_1.seal_times > arg_8_2.seal_times or nil) and var_0_1.RED,
			num = arg_8_1.seal_times
		})
	end

	self.m_levelDescComp:updateView(var_8_0, true)
	self.m_titleText:setText(g.core.lang:get(500131, {
		level = self._curShowLevel
	}))
end

function FogNightmareLevelUpPop:_getDescStr(arg_10_1, arg_10_2)
	return (g.core.lang:get(arg_10_1, {
		descNum = arg_10_2
	}))
end

function FogNightmareLevelUpPop:onUnload()
	if self._callback then
		self._callback()
	end
end

function FogNightmareLevelUpPop:onRemoved()
	local var_12_0 = var_0_2:getSealListByLevel(self._curShowLevel)

	if next(var_12_0) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_KEEPSAKE_UNLOCK, {
			data = var_12_0
		})

		local var_12_1 = var_0_2:getKeepsakeNewData()

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			table.insert(var_12_1, {
				seal_id = iter_12_1.seal_id,
				type = iter_12_1.type
			})
		end

		var_0_2:setKeepsakeNewData(var_12_1)
		g.core.common.Storage:save("fogNightmare_keepsake_new.json", {
			list = var_12_1,
			seasonId = var_0_2:getSeasonId()
		}, true)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FOG_NIGHTMARE_NEXT_FLOOR, false)
	end
end

function FogNightmareLevelUpPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return FogNightmareLevelUpPop
