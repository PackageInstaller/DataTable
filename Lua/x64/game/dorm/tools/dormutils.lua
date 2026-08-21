local var_0_0 = {
	EIdNamespace = function(arg_1_0)
		return "entity." .. arg_1_0 .. ".eid"
	end,
	IdxNamespace = function(arg_2_0)
		return "entity." .. arg_2_0 .. ".idx"
	end,
	GetEntityData = function(arg_3_0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_3_0)
	end,
	EnumerateInteractEntities = function(arg_4_0)
		return pairs(nullable(DormUtils.GetEntityData(arg_4_0), "interactEntities") or {})
	end,
	CallOnNextUpdate = function(arg_5_0)
		DormCharacterActionManager.taskRunner:NewTimer(arg_5_0, 0):Start()
	end,
	MapSceneItemTagInfo = function()
		for iter_6_0, iter_6_1 in pairs(Dorm.sceneItemInfo) do
			Dorm.storage:MapToData(iter_6_0, iter_6_1)
		end
	end
}

function var_0_0.SetEntityInteractContext(arg_7_0, arg_7_1)
	local var_7_0 = var_0_0.GetEntityData(arg_7_0)

	if var_7_0 then
		var_7_0.interactCtx = arg_7_1
	else
		Debug.LogError(string.format("SetEntityInteractContext(%d) data is nil", arg_7_0))
	end
end

local function var_0_1(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if arg_8_2 then
		var_8_0 = arg_8_0.Length - arg_8_1
	else
		var_8_0 = arg_8_1 - 1
	end

	return arg_8_0[var_8_0]
end

function var_0_0.MoveByPath(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = 1

	if arg_9_2 then
		Dorm.DormEntityManager.PutEntityAt(arg_9_0, var_0_1(arg_9_1, var_9_0, arg_9_3))

		var_9_0 = 2
	end

	for iter_9_0 = var_9_0, arg_9_1.Length do
		Dorm.DormEntityManager.SendMoveCMD(arg_9_0, var_0_1(arg_9_1, iter_9_0, arg_9_3), true, true)
	end
end

local var_0_2 = {
	DormEnum.SpecialVfx.Hungry,
	DormEnum.SpecialVfx.Tired,
	DormEnum.SpecialVfx.Gift
}
local var_0_3 = {
	[DormEnum.SpecialVfx.Hungry] = {
		attachPoint = "gua_Hp",
		duration = -1,
		path = "Dorm/Effect/houzhai/fx_HZ04_hungry"
	},
	[DormEnum.SpecialVfx.Tired] = {
		attachPoint = "root",
		duration = -1,
		path = "Dorm/Effect/houzhai/fx_nengliang"
	},
	[DormEnum.SpecialVfx.Gift] = {
		attachPoint = "gua_Hp",
		duration = -1,
		path = "Dorm/Effect/houzhai/fx_HZ04_gift"
	}
}
local var_0_4 = DormEnum.Namespace.HeroShowSpecialVfx
local var_0_5 = {
	[DormEnum.SpecialVfx.Hungry] = function(arg_10_0, arg_10_1)
		return not DormVisitTools:CheckCurIsVisitRoom() and not DormHeroTools:CheckIsVisitHero(arg_10_1) and DormHeroTools:CheckFeedTime(arg_10_0) and not DormHeroTools:CheckDormFatigueLevel(arg_10_0)
	end,
	[DormEnum.SpecialVfx.Tired] = function(arg_11_0)
		return not DormVisitTools:CheckCurIsVisitRoom() and not DormHeroTools:CheckCanteenFatigueLevel(arg_11_0)
	end,
	[DormEnum.SpecialVfx.Gift] = function(arg_12_0, arg_12_1)
		return not DormVisitTools:CheckCurIsVisitRoom() and DormHeroTools:CheckIsVisitHero(arg_12_1) and DormData:CanReceiveVisitReward()
	end
}
local var_0_6 = {
	[DormEnum.SpecialVfx.Gift] = true
}

local function var_0_7(arg_13_0)
	local var_13_0 = var_0_0.GetEntityData(arg_13_0)
	local var_13_1 = var_13_0.cfgID
	local var_13_2 = var_13_0.heroID

	if var_13_2 == nil then
		return
	end

	if DormHeroTools:CheckIsVisitHero(arg_13_0) then
		local var_13_3 = {
			vfxStatus = {}
		}

		if Dorm.charaVfxActiveType then
			for iter_13_0, iter_13_1 in ipairs(Dorm.charaVfxActiveType) do
				if var_0_6[iter_13_1] then
					local var_13_4 = var_0_5[iter_13_1]

					var_13_3.vfxStatus[iter_13_1] = var_13_4 and var_13_4(var_13_2, arg_13_0)
				end
			end
		end

		return var_13_3
	else
		local var_13_5 = Dorm.storage:GetData(var_0_4, var_13_2)

		if var_13_5 == nil then
			var_13_5 = {
				vfxStatus = {}
			}

			if Dorm.charaVfxActiveType then
				for iter_13_2, iter_13_3 in ipairs(Dorm.charaVfxActiveType) do
					local var_13_6 = var_0_5[iter_13_3]

					var_13_5.vfxStatus[iter_13_3] = var_13_6 and var_13_6(var_13_2, arg_13_0)
				end
			end

			Dorm.storage:RecordData(var_0_4, var_13_2, var_13_5)
		end

		return var_13_5
	end
end

local var_0_8 = "status"

function var_0_0.ShowCharaSpecialVfx(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return
	end

	if next(arg_14_1) then
		local var_14_0 = var_0_7(arg_14_0)

		if var_14_0 == nil then
			return
		end

		if var_14_0.hideVfx then
			var_14_0.hideVfx = var_14_0.hideVfx - 1

			if var_14_0.hideVfx == 0 then
				var_14_0.hideVfx = nil
			end
		end

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_1 = var_0_3[iter_14_1]

			if var_14_1 and var_14_0.vfxStatus[iter_14_1] and not var_14_0.hideVfx then
				Dorm.DormEntityManager.PlayEffect(arg_14_0, var_14_1.attachPoint, var_0_8, var_14_1.path, var_14_1.duration)

				return
			end
		end
	end
end

function var_0_0.ResetCharaSpecialVfx(arg_15_0)
	local var_15_0 = var_0_7(arg_15_0)

	if nullable(var_15_0, "hideVfx") then
		var_15_0.hideVfx = nil

		var_0_0.ShowCharaSpecialVfx(arg_15_0, Dorm.charaVfxActiveType)
	end
end

function var_0_0.HideCharaSpecialVfx(arg_16_0)
	local var_16_0 = var_0_7(arg_16_0)

	if var_16_0 then
		var_16_0.hideVfx = (var_16_0.hideVfx or 0) + 1
	end

	Dorm.DormEntityManager.ClearAllEffect(arg_16_0, var_0_8)
end

function var_0_0.ClearCharaHasSpecialVfx(arg_17_0)
	local var_17_0 = nullable(var_0_7(arg_17_0), "vfxStatus")

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_0_2) do
			var_17_0[iter_17_1] = false
		end
	end
end

function var_0_0.ClearSingleSpecialVfx(arg_18_0, arg_18_1)
	local var_18_0 = var_0_7(arg_18_0).vfxStatus

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_0_2) do
			if iter_18_1 == arg_18_1 then
				var_18_0[iter_18_1] = false
			end
		end
	end
end

function var_0_0.MuteEntitySubtitleBubble(arg_19_0)
	SubtitleBubbleView.OnEntityDispose(arg_19_0)
end

function var_0_0.CharaVfxEnabled()
	return Dorm.charaVfxActiveType and next(Dorm.charaVfxActiveType)
end

function var_0_0.ClearSceneItemInfo()
	Dorm.sceneItemInfo = {}
end

local function var_0_9(arg_22_0)
	return string.format("entity.sound_fx.%d", arg_22_0)
end

function var_0_0.OnEntityStartAudioPlayback(arg_23_0, arg_23_1)
	var_0_0.CollectEntityAudioPlayback(arg_23_0, arg_23_1)
	print("OnEntityStartAudioPlayback", arg_23_0, Dorm.storage:GetData(var_0_9(arg_23_0), "#"))
end

function var_0_0.CollectEntityAudioPlayback(arg_24_0, arg_24_1)
	local var_24_0 = var_0_9(arg_24_0)

	for iter_24_0, iter_24_1 in Dorm.storage:ForeachData(var_24_0, ipairs) do
		if iter_24_1:GetState() == 2 then
			Dorm.storage:RecordData(var_24_0, iter_24_0, arg_24_1)

			return
		end
	end

	Dorm.storage:PushBackData(var_24_0, arg_24_1)
end

function var_0_0.StopAllEntityAudioPlayback(arg_25_0)
	local var_25_0 = var_0_9(arg_25_0)
	local var_25_1 = 0

	for iter_25_0, iter_25_1 in Dorm.storage:ForeachData(var_25_0, ipairs) do
		if iter_25_1:GetState() ~= 2 then
			iter_25_1:Stop()

			var_25_1 = var_25_1 + 1
		end
	end

	print("StopAllEntityAudioPlayback", var_25_1)
	Dorm.storage:ClearData(var_25_0)
end

return var_0_0
