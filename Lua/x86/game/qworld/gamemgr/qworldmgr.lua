local var_0_0 = {}
local var_0_1 = false
local var_0_2

function IsQworldRunning()
	return var_0_1
end

function QWorldLuaGC()
	manager.gc:Collect()
end

local var_0_3

function var_0_0.GetQWorldStoryMgr(arg_3_0)
	return var_0_3
end

local var_0_4

function var_0_0.GetQWorldEntityMgr(arg_4_0)
	return var_0_4
end

local var_0_5

function var_0_0.GetQWorldPerformMgr(arg_5_0)
	return var_0_5
end

local var_0_6

function var_0_0.GetQWorldQuestMgr(arg_6_0)
	return var_0_6
end

local var_0_7

function var_0_0.GetQWorldHintMgr(arg_7_0)
	return var_0_7
end

local var_0_8

function var_0_0.GetQWorldTagMgr(arg_8_0)
	return var_0_8
end

local var_0_9

function var_0_0.GetQWorldSoundMgr(arg_9_0)
	return var_0_9
end

function var_0_0.EnterQWorld(arg_10_0)
	var_0_1 = true
	var_0_3 = import("game.qworld.story.QWorldStoryMgr")

	var_0_3:Init()

	var_0_4 = import("game.qworld.prefabScript.QWorldEntityMgr").New()

	var_0_4:Init()

	var_0_5 = import("game.qworld.perform.QWPerformMgr").New()

	var_0_5:Init()

	var_0_6 = import("game.qworld.quest.QWorldQuestMgr").New()

	var_0_6:Init()

	var_0_7 = import("game.qworld.hint.QWorldHintMgr").New()

	var_0_7:Init()

	var_0_8 = import("game.qworld.tag.QWorldTagMgr").New()

	var_0_8:Init()

	var_0_9 = import("game.qworld.sound.QWorldSoundMgr").New()

	var_0_9:Init()
	QWorldQuanzhouNotify:Init()
	QWorldNotifyQueue:Init()
end

function var_0_0.GetActivityMap(arg_11_0, arg_11_1)
	if not var_0_2 then
		var_0_2 = {}

		for iter_11_0, iter_11_1 in ipairs(SandPlayMapCfg.all) do
			local var_11_0 = SandPlayMapCfg[iter_11_1]

			var_0_2[var_11_0.activity_id] = var_11_0.id
		end
	end

	return var_0_2[arg_11_1]
end

function var_0_0.GetMapId(arg_12_0)
	return arg_12_0:GetActivityMap(arg_12_0:GetActivityId())
end

function var_0_0.GetActivityId(arg_13_0)
	return QWorldData:GetCurActivityId()
end

function var_0_0.GetMapHeroId(arg_14_0)
	if var_0_1 then
		return arg_14_0:GetQWorldEntityMgr():GetCurrentPlayerId()
	end

	return SandPlayMapCfg[arg_14_0:GetMapId()].hero_id
end

function var_0_0.OnQWorldLoaded(arg_15_0)
	var_0_4:RefreshCurrentPlayerData()

	local var_15_0 = QWorldData:GetQWorldContext()

	if var_15_0 then
		local var_15_1 = manager.ui.mainCamera.transform

		QWorldLuaBridge.TeleportToCachePos(var_15_0.position, var_15_0.rotation, true)

		if var_15_0.cacheTag and SandplayTagCfg[var_15_0.cacheTag] then
			local var_15_2 = SandplayTagCfg[var_15_0.cacheTag]

			QWorldGoto:SetTagId(var_15_0.cacheTag)
			QWorldGoto:Goto(var_15_2.tag_behaviour, arg_15_0.entityId, var_15_2.behaviour_parameters, var_15_2.passthrough_parameters, var_15_2.camera_parameters, {
				immediate = true
			})
			QWorldData:SetCacheTag(nil)
		end
	end

	var_0_6:CreateMissingQuestStaff()

	if not var_0_0.posSyncTimer_ then
		var_0_0.posSyncTimer_ = Timer.New(function()
			if var_0_0.isLogout_ then
				return
			end

			QWorldAction.SavePlayerData()

			if QWorldLuaBridge.GetPlayer().transform.position.y < -50 then
				QWorldMgr:StartBlackFade(0.5, 0.5, 1, function()
					QWorldLuaBridge.TeleportToStageOrigin()
				end)
			end
		end, 5, -1)

		var_0_0.posSyncTimer_:Start()
	end

	var_0_0.isQWorldLoaded_ = true
	var_0_0.isLogout_ = nil
end

function var_0_0.PostExitQWorld(arg_18_0)
	if var_0_1 then
		QWorldData:SetIsBackQWorld(false)

		if not var_0_0.isLogout_ then
			QWorldAction.SavePlayerData()
		end

		QWorldData:SetCurMapId(0)
	end
end

function var_0_0.DisposeQueue(arg_19_0)
	QWorldNotifyQueue:Dispose()
	QWorldQuanzhouNotify:Dispose()
end

function var_0_0.ExitQWorld(arg_20_0)
	if var_0_0.posSyncTimer_ then
		var_0_0.posSyncTimer_:Stop()

		var_0_0.posSyncTimer_ = nil
	end

	var_0_1 = false

	var_0_3:Dispose()

	var_0_3 = nil

	var_0_4:Dispose()

	var_0_4 = nil

	var_0_5:Dispose()

	var_0_5 = nil

	var_0_6:Dispose()

	var_0_6 = nil

	var_0_7:Dispose()

	var_0_7 = nil

	var_0_8:Dispose()

	var_0_8 = nil

	var_0_9:Dispose()

	var_0_9 = nil
end

function var_0_0.Init(arg_21_0)
	return
end

function OnLogoutQWorld()
	var_0_0.isLogout_ = true
end

function var_0_0.StartBlackFade(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	local var_23_0

	if arg_23_5 then
		function var_23_0()
			if arg_23_5 then
				arg_23_5()
			end
		end
	end

	QWorldMgr:GetQWorldStoryMgr():GetBlackFade():StartFade({
		showContent = true,
		contentTime = arg_23_3,
		showTimer = arg_23_1,
		outTimer = arg_23_2,
		centerAction = function()
			if arg_23_4 then
				arg_23_4()
			end
		end,
		done = var_23_0
	})
end

function var_0_0.ActiveControl(arg_26_0, arg_26_1)
	if var_0_1 then
		QWorldLuaBridge.CloseUI(not arg_26_1)
		arg_26_0:ActivePlayerControl(arg_26_1)
	end
end

function var_0_0.ActivePlayerControlWithMain(arg_27_0, arg_27_1)
	if var_0_1 and gameContext:GetLastOpenPage() == "qworldMainHome" then
		arg_27_0:ActivePlayerControl(arg_27_1)
	end
end

function var_0_0.ActivePlayerControl(arg_28_0, arg_28_1)
	if var_0_1 then
		if arg_28_1 then
			if not QWorldMgr:GetQWorldPerformMgr():IsInPerform() and not QWorldMgr:GetQWorldPerformMgr():IsInActivityPerform() then
				QWorldLuaBridge.HideBubble(false)
				QWorldLuaBridge.StopControl(false)
				QWorldLuaBridge.EnableCamera(QWorldCameraFlag.Player, "", QWorldCameraLayer.PlayerOrStory)
			elseif QWorldMgr:GetQWorldPerformMgr():IsInPerform() then
				QWorldLuaBridge.EnableCamera(QWorldCameraFlag.Player, "", QWorldCameraLayer.PlayerOrStory)
			end

			if QWorldMgr:GetQWorldPerformMgr():TryClearPerformDirty() then
				QWorldLuaBridge.EnableCamera(QWorldCameraFlag.Player, "", QWorldCameraLayer.PlayerOrStory)
			end

			QWorldLuaBridge.HideHud(false)
			QWorldLuaBridge.HidePlayer(false)
		else
			QWorldLuaBridge.StopControlFrame(2)
			QWorldLuaBridge.HideBubble(true)
			QWorldLuaBridge.StopControl(true)
		end
	end
end

function var_0_0.CullDynamic(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_3 then
		local var_29_0 = bit.lshift(1, 0)

		for iter_29_0, iter_29_1 in ipairs(arg_29_3) do
			var_29_0 = bit.bxor(iter_29_1, var_29_0)
		end

		QWorldLuaBridge.CullingAllDynamic(arg_29_1, arg_29_2, var_29_0)
	else
		QWorldLuaBridge.CullingAllDynamic(arg_29_1, arg_29_2)
	end
end

function var_0_0.StartSetCamera(arg_30_0)
	QWorldLuaBridge.HidePlayer(true)
	QWorldLuaBridge.HideHud(true)
end

function var_0_0.EnableCamera(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if var_0_1 then
		if arg_31_1 == QWorldCameraFlag.CustomCamera and arg_31_2 == nil then
			return
		end

		QWorldLuaBridge.EnableCamera(arg_31_1, arg_31_2 or "", arg_31_3 or QWorldCameraLayer.PlayerOrStory)
	end
end

function var_0_0.EnableCustomCamera(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = SandplayCameraGroupCfg[arg_32_1]

	if var_32_0 then
		local var_32_1 = var_32_0.camera[arg_32_2 or 1]

		if var_32_1 then
			arg_32_0:EnableCamera(QWorldCameraFlag.CustomCamera, var_32_1, arg_32_3)
		end
	end
end

function var_0_0.ExitCustomCameraByGroup(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = SandplayCameraGroupCfg[arg_33_1]

	if var_33_0 then
		local var_33_1 = var_33_0.camera[arg_33_2 or 1]

		if var_33_1 then
			arg_33_0:ExitCustomCamera(var_33_1)
		end
	end
end

function var_0_0.ExitFocusCamera(arg_34_0)
	QWorldLuaBridge.ExitFocusCamera()
end

function var_0_0.ExitTopCustomCamera(arg_35_0)
	QWorldLuaBridge.ExitTopCustomCamera()
end

function var_0_0.ExitCustomCamera(arg_36_0, arg_36_1)
	QWorldLuaBridge.ExitCustomCamera(arg_36_1)
end

function var_0_0.IsInQWorldMain(arg_37_0)
	if gameContext:GetLastOpenPage() == "qworldMainHome" then
		return true
	end

	return false
end

function var_0_0.PostCheck(arg_38_0)
	if gameContext:GetLastOpenPage() == "qworldMainHome" then
		QWorldLuaBridge.HidePlayer(false)
		QWorldLuaBridge.HideHud(false)

		return false
	end

	return true
end

return var_0_0
