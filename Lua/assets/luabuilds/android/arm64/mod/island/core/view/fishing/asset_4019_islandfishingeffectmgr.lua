local IslandFishingEffectMgr = class("IslandFishingEffectMgr", import("Mod.Island.Core.View.IslandBaseUnit"))

IslandFishingEffectMgr.EFFECT_NORMAL = "vfx_diaoyu_diandian"
IslandFishingEffectMgr.EFFECT_ENTER = "vfx_diaoyu_rushui"
IslandFishingEffectMgr.EFFECT_WAITING = "vfx_diaoyu_dengdai"
IslandFishingEffectMgr.EFFECT_HOOKED = "vfx_diaoyu_yaogou"
IslandFishingEffectMgr.EFFECT_SHAKE = "vfx_diaoyu_zhenzha"
IslandFishingEffectMgr.EFFECT_LEAVE = "vfx_diaoyu_chushui"
IslandFishingEffectMgr.EFFECT_ENTER_TIME = 1
IslandFishingEffectMgr.EFFECT_LEAVE_TIME = 0.7

function IslandFishingEffectMgr:Ctor(arg_1_1)
	IslandFishingEffectMgr.super.Ctor(self, arg_1_1)

	self.effects = {}

	self:Init()

	return
end

function IslandFishingEffectMgr:SetFishHook(arg_2_1)
	self.hookTr = arg_2_1

	return
end

function IslandFishingEffectMgr:Preload(arg_3_1, arg_3_2)
	local var_3_0 = self:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FISH_POINT, arg_3_1)

	self.effects[IslandFishingEffectMgr.EFFECT_NORMAL] = var_3_0._go.transform:Find("vfx")

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs({
		IslandFishingEffectMgr.EFFECT_ENTER,
		IslandFishingEffectMgr.EFFECT_HOOKED,
		IslandFishingEffectMgr.EFFECT_WAITING,
		IslandFishingEffectMgr.EFFECT_SHAKE,
		IslandFishingEffectMgr.EFFECT_LEAVE
	}) do
		table.insert(var_3_1, function(arg_4_0)
			if self.eixted then
				return
			end

			self:GetPoolMgr():GetFishingEffect("island/effect/prefab/game/diaoyu/" .. iter_3_1, function(arg_5_0)
				setParent(arg_5_0, var_3_0._go.transform)

				self.effects[iter_3_1] = arg_5_0

				setActive(arg_5_0, false)
				arg_4_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_3_1, arg_3_2)

	return
end

function IslandFishingEffectMgr:Play(arg_6_1)
	self:RemoveTimer()

	for iter_6_0, iter_6_1 in pairs(self.effects) do
		setActive(iter_6_1, iter_6_0 == arg_6_1)
	end

	if arg_6_1 == IslandFishingEffectMgr.EFFECT_ENTER then
		-- block empty
	end

	return
end

function IslandFishingEffectMgr:UpdatePositions()
	for iter_7_0, iter_7_1 in pairs(self.effects) do
		if iter_7_0 ~= IslandFishingEffectMgr.EFFECT_NORMAL then
			iter_7_1.transform.position = IsNil(self.hookTr) and Vector3(0, 0, 0) or Vector3(self.hookTr.position.x, self.effects[IslandFishingEffectMgr.EFFECT_NORMAL].transform.position.y, self.hookTr.position.z)
		end
	end

	return
end

function IslandFishingEffectMgr:DelayPlay(arg_8_1, arg_8_2)
	self:RemoveTimer()
	self:AddTimer(arg_8_1, function()
		self:Play(arg_8_2)

		return
	end)

	return
end

function IslandFishingEffectMgr:AddTimer(arg_10_1, arg_10_2)
	self.timer = Timer.New(arg_10_2, arg_10_1, 1)

	self.timer:Start()

	return
end

function IslandFishingEffectMgr:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandFishingEffectMgr:OnDestroy()
	self:RemoveTimer()

	for iter_12_0, iter_12_1 in pairs(self.effects) do
		if iter_12_0 ~= IslandFishingEffectMgr.EFFECT_NORMAL then
			self:GetPoolMgr():ReturnFishingEffect("island/effect/prefab/game/diaoyu/" .. iter_12_0, iter_12_1)
		else
			setActive(iter_12_1, true)
		end
	end

	self.effects = {}
	self.eixted = true

	return
end

return IslandFishingEffectMgr
