local var_0_0 = g.core.config.fog_level_info
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareLevelPop = class("FogNightmareLevelPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareLevelPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareLevelPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareLevelPop:ctor()
	self._curShowLevel = var_0_1:getFogLevel()
	self._descList = {}

	self:_initView()
	self.m_enterTransition:play()
	self.m_effLevelPopbg:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_levelPopbg",
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_PAPEROPEN)
end

function FogNightmareLevelPop:_initView()
	self:showAtCenter()
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))

	local var_3_0 = var_0_1:getFogLevel()
	local var_3_2 = (var_0_0.fetch(var_3_0) or {}).exp or 0

	self.m_expText:setText(var_0_1:getFogLevelExp() - var_3_2 .. "/" .. math.max(((var_0_0.fetch(var_3_0 + 1) or {}).exp or 0) - var_3_2, 0))
	self.m_isMaxLevelController:setSelectedIndex(var_3_0 >= var_0_1:getFogMaxLevel() and 1 or 0)
end

function FogNightmareLevelPop:onLoad()
	self:updateView()
end

function FogNightmareLevelPop:_onClickLeftBtn()
	if self._curShowLevel <= var_0_1:getFogLevel() then
		return
	end

	self._curShowLevel = self._curShowLevel - 1

	self.m_switchTransition:play()
	self:updateView()
end

function FogNightmareLevelPop:_onClickRightBtn()
	if self._curShowLevel == var_0_1:getFogMaxLevel() then
		g.core.module.ModuleManager:tip(g.core.lang:get(500118))
	elseif self._curShowLevel >= var_0_1:getFogLevel() + var_0_2.MAX_PREVIEW_LEVEL then
		g.core.module.ModuleManager:tip(g.core.lang:get(500119, {
			level = var_0_2.MAX_PREVIEW_LEVEL
		}))
	else
		self._curShowLevel = self._curShowLevel + 1

		self:updateView()
		self.m_switchTransition:play()
	end
end

function FogNightmareLevelPop:updateView()
	local var_7_0 = var_0_0.get(self._curShowLevel)
	local var_7_1 = var_0_0.fetch(self._curShowLevel - 1)

	if self._curShowLevel == var_0_1:getFogLevel() then
		self.m_leftBtn:setVisible(false)
	else
		self.m_leftBtn:setVisible(true)
	end

	self:updateDescComp(var_7_0, var_7_1)
end

function FogNightmareLevelPop:updateDescComp(arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = 1

	local function var_8_2(arg_9_0, arg_9_1)
		return self._curShowLevel == var_0_1:getFogLevel() and g.core.lang:get(arg_9_1 and 500117 or 500116, {
			num = arg_9_0
		}) or g.core.lang:get(arg_9_1 and 500130 or 500129, {
			num = arg_9_0
		})
	end

	local function var_8_3(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = ""

		if arg_10_0 > 0 and arg_10_1 > 0 then
			var_10_0 = g.core.lang:get(500120, {
				day = arg_10_0,
				hour = arg_10_1
			})
		elseif arg_10_0 > 0 then
			var_10_0 = g.core.lang:get(500121, {
				day = arg_10_0
			})
		elseif arg_10_1 > 0 then
			var_10_0 = g.core.lang:get(500122, {
				hour = arg_10_1
			})
		end

		return var_8_2(var_10_0, arg_10_2)
	end

	if arg_8_1.seal_level > 0 then
		local var_8_4 = var_0_1:getFogLevelUnlockMaxSealCount(arg_8_1.level)

		if arg_8_2 and arg_8_1.seal_level > arg_8_2.seal_level then
			local var_8_5 = var_0_1:getFogLevelUnlockMaxSealCount(arg_8_2.level)

			table.insert(var_8_0, self:_getDescStr(500111, var_8_2(arg_8_1.seal_level, true)))
			table.insert(var_8_0, self:_getDescStr(500114, var_8_2(var_8_4, var_8_5 < var_8_4)))
		else
			table.insert(var_8_0, self:_getDescStr(500111, var_8_2(arg_8_1.seal_level, false)))
			table.insert(var_8_0, self:_getDescStr(500114, var_8_2(var_8_4, false)))
		end

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.idle_time > 0 then
		local var_8_6, var_8_7 = var_0_1:getMaxIdleTimeDHByLevel(self._curShowLevel)

		if arg_8_2 and arg_8_1.idle_time > arg_8_2.idle_time then
			table.insert(var_8_0, self:_getDescStr(500112, var_8_3(var_8_6, var_8_7, true)))
		else
			table.insert(var_8_0, self:_getDescStr(500112, var_8_3(var_8_6, var_8_7, false)))
		end

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.talent_addition_level > 0 then
		if arg_8_2 and arg_8_1.talent_addition_level > arg_8_2.talent_addition_level then
			table.insert(var_8_0, self:_getDescStr(500113, var_8_2(arg_8_1.talent_addition_level, true)))
		else
			table.insert(var_8_0, self:_getDescStr(500113, var_8_2(arg_8_1.talent_addition_level, false)))
		end

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.knight_num > 0 then
		if arg_8_2 and arg_8_1.knight_num > arg_8_2.knight_num then
			table.insert(var_8_0, self:_getDescStr(500115, var_8_2(arg_8_1.knight_num, true)))
		else
			table.insert(var_8_0, self:_getDescStr(500115, var_8_2(arg_8_1.knight_num, false)))
		end

		var_8_1 = var_8_1 + 1
	end

	if arg_8_1.seal_times > 0 then
		if arg_8_2 and arg_8_1.seal_times > arg_8_2.seal_times then
			table.insert(var_8_0, self:_getDescStr(500238, var_8_2(arg_8_1.seal_times, true)))
		else
			table.insert(var_8_0, self:_getDescStr(500238, var_8_2(arg_8_1.seal_times, false)))
		end
	end

	local var_8_9 = self._curShowLevel == var_0_1:getFogLevel()

	self.m_isCurLevelController:setSelectedIndex(var_8_9 and 1 or 0)
	self.m_levelDescComp:updateView(var_8_0, var_8_9)
	self.m_titleText:setText(g.core.lang:get(500131, {
		level = self._curShowLevel
	}))
end

function FogNightmareLevelPop:_getDescStr(arg_11_1, arg_11_2)
	return (g.core.lang:get(arg_11_1, {
		descNum = arg_11_2
	}))
end

return FogNightmareLevelPop
