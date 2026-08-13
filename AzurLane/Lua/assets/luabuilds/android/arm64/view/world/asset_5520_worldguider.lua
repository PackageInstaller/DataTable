singletonClass = var_0_10000

local var_0_0 = "WorldGuider"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....Mod.Experiment.BaseEntity"))

var_0_1.Fields = {
	tStamina = "number",
	tempGridPos = "table"
}

function var_0_1.Init(arg_1_0)
	arg_1_0.tempGridPos = {}

	return
end

function var_0_1.SetTempGridPos(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or 1
	pg = var_1_10003

	local var_2_0 = var_1_10003.NewGuideMgr.GetInstance()._tf
	local var_2_1 = var_3.InverseTransformPoint(var_2_0, arg_2_1)

	arg_2_0.tempGridPos[arg_2_2] = var_2_1

	return
end

function var_0_1.SetTempGridPos2(arg_3_0, arg_3_1, arg_3_2)
	GameObject = var_1_10003

	local var_3_0 = var_1_10003.Find("LevelCamera")
	local var_3_1 = var_3.GetComponent

	typeof = var_1_10006
	Camera = var_1_10008

	local var_3_2 = var_3_1(var_3_0, var_1_10006(var_1_10008))
	local var_3_3 = var_3.WorldToScreenPoint(var_3_2, arg_3_1)

	GameObject = var_3_0

	local var_3_4 = var_3_0.Find("OverlayCamera")
	local var_3_5 = var_5.GetComponent

	typeof = var_1_10008
	Camera = var_1_10010

	local var_3_6 = var_3_5(var_3_4, var_1_10008(var_1_10010))
	local var_3_7 = var_5.ScreenToWorldPoint(var_3_6, var_3_3)

	arg_3_0:SetTempGridPos(var_3_7, arg_3_2)

	return
end

function var_0_1.GetTempGridPos(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or 1

	return arg_4_0.tempGridPos[arg_4_1]
end

function var_0_1.CheckPlayChooseCamp(arg_5_0)
	nowWorld = var_1_10001

	local var_5_0 = var_1_10001()

	if var_1.GetRealm(var_5_0) == nil or var_1 < 1 then
		arg_5_0:PlayGuide("WorldG001")
	end

	return
end

function var_0_1.CheckIntruduce(arg_6_0)
	nowWorld = var_1_10001

	local var_6_0 = var_1_10001()

	if var_1.GetRealm(var_6_0) and var_1 > 0 then
		if var_1 == 1 then
			arg_6_0:PlayGuide("WorldG002_1")
		elseif var_1 == 2 then
			arg_6_0:PlayGuide("WorldG002_2")
		end
	end

	return
end

function var_0_1.CheckUseStaminaItem(arg_7_0)
	local var_7_0 = {
		251,
		252,
		253
	}

	nowWorld = var_1_10002

	local var_7_1 = var_1_10002()
	local var_7_2 = var_2.GetInventoryProxy(var_7_1)
	local var_7_3 = 0

	ipairs = var_7_1

	for iter_7_0, iter_7_1 in var_7_1(var_7_0) do
		var_7_3 = var_7_3 + var_7_2:GetItemCount(iter_7_1)
	end

	if var_7_3 > 0 then
		arg_7_0:PlayGuide("WorldG020")
	end

	return
end

function var_0_1.CheckMapLimit(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.NewGuideMgr.GetInstance()

	var_1.Play(var_8_0, "WorldG012")

	return
end

function var_0_1.SpecialCheck(arg_9_0, arg_9_1)
	if arg_9_1 == "WorldG008" then
		nowWorld = var_1_10002

		local var_9_0 = var_1_10002()

		if var_2.GetActiveMap(var_9_0) ~= nil and var_2.findex == 2 then
			return "WorldG008_2"
		end
	end

	return arg_9_1
end

var_0_1.interruptReplayList = {
	"WorldG007",
	"WorldG021",
	"WorldG100",
	"WorldG121",
	"WorldG141",
	"WorldG151"
}

function var_0_1.PlayGuide(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pg = var_1_10004

	local var_10_0 = var_1_10004.NewGuideMgr.GetInstance()

	GUIDE_WROLD = var_1_10005

	if var_1_10005 then
		if not arg_10_2 then
			pg = var_1_10005

			local var_10_1 = var_1_10005.NewStoryMgr.GetInstance()

			if not var_1_10005.IsPlayed(var_10_1, arg_10_1) then
				if not var_10_0:CanPlay() then
					existCall = var_1_10005

					var_1_10005(arg_10_3)

					return false
				end

				_ = var_1_10005

				if not var_1_10005.any(var_0_1.interruptReplayList, function(arg_11_0)
					return arg_10_1 == arg_11_0
				end) then
					pg = var_5

					local var_10_2 = var_5.m02
					local var_10_3 = var_5.sendNotification

					GAME = var_8

					var_10_3(var_10_2, var_8.STORY_UPDATE, {
						storyId = arg_10_1
					})
				end

				var_10_0:Play(arg_10_1, nil, function()
					existCall = var_2_10000

					return var_2_10000(arg_10_3)
				end)

				return true
			end
		end
	end
end

var_0_1.WORLD_HIDE_UI = "world hide ui"
var_0_1.WORLD_OPEN_MAP_OVERVIEW = "world open map overview"
var_0_1.WORLD_SHOW_MARGIN = "world show margin"
var_0_1.WORLD_SCANNER_DISPLAY = "world scanner display"
var_0_1.WORLD_GET_COMPASS_POS = "world get compass pos"
var_0_1.WORLD_GET_COMPASS_MAP_POS = "world get compass map pos"
var_0_1.WORLD_GET_SLG_TILE_POS = "world get slg tile pos"
var_0_1.WORLD_GET_SCANNER_POS = "world get scanner pos"
var_0_1.WORLD_OPEN_TRANSPORT_POS = "world open transport pos"
var_0_1.WORLD_SELECT_MODEL_MAP = "world select model map"
var_0_1.WORLD_FOCUS_EDGE = "world focus edge"
var_0_1.WORLD_FOCUS_EVENT = "world focus event"
var_0_1.WORLD_SCANNER_EVENT = "world scanner event"
var_0_1.WORLD_HELP_EVENT = "world help event"
var_0_1.WORLD_RECALL = "world recall"

local var_0_2 = {
	[var_0_1.WORLD_HIDE_UI] = function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1.type == 1 then
			arg_13_2:HideMapRightCompass()
		elseif arg_13_1.type == 2 then
			arg_13_2:HideMapRightMemo()
		elseif arg_13_1.type == 3 then
			-- block empty
		elseif arg_13_1.type == 4 then
			arg_13_2:HideOverall()
		end

		return
	end,
	[var_0_1.WORLD_GET_COMPASS_POS] = function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_2:GetCompassGridPos(arg_14_1.row, arg_14_1.column, arg_14_1.cachedIndex)

		return
	end,
	[var_0_1.WORLD_GET_COMPASS_MAP_POS] = function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_2:GetEntranceTrackMark(arg_15_1.mapId, arg_15_1.cachedIndex)

		return
	end,
	[var_0_1.WORLD_GET_SLG_TILE_POS] = function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_2:GetSlgTilePos(arg_16_1.row, arg_16_1.column, arg_16_1.cachedIndex)

		return
	end,
	[var_0_1.WORLD_GET_SCANNER_POS] = function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_17_2
		local var_17_1 = arg_17_2.GetScannerPos
		local var_17_2

		if not arg_17_1 or not arg_17_1.cachedIndex then
			var_17_2 = 1
		end

		var_17_1(var_17_0, var_17_2)

		return
	end,
	[var_0_1.WORLD_OPEN_MAP_OVERVIEW] = function(arg_18_0, arg_18_1, arg_18_2)
		arg_18_2:Op("OpShowMarkOverview", {
			ids = arg_18_1.mapIds
		})

		return
	end,
	[var_0_1.WORLD_SHOW_MARGIN] = function(arg_19_0, arg_19_1, arg_19_2)
		arg_19_2:ShowMargin(arg_19_1.tdType)

		return
	end,
	[var_0_1.WORLD_SCANNER_DISPLAY] = function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_1.open == 1 then
			arg_20_2:OnLongPressMap(arg_20_1.row, arg_20_1.column)
		else
			arg_20_2:HideScannerPanel()
		end

		return
	end,
	[var_0_1.WORLD_OPEN_TRANSPORT_POS] = function(arg_21_0, arg_21_1, arg_21_2)
		arg_21_2:EnterTransportWorld()

		return
	end,
	[var_0_1.WORLD_SELECT_MODEL_MAP] = function(arg_22_0, arg_22_1, arg_22_2)
		arg_22_2:GuideSelectModelMap(arg_22_1.mapId)

		return
	end,
	[var_0_1.WORLD_FOCUS_EDGE] = function(arg_23_0, arg_23_1, arg_23_2)
		arg_23_2:Op("OpMoveCameraTarget", arg_23_1.line, arg_23_1.stayTime)

		return
	end,
	[var_0_1.WORLD_FOCUS_EVENT] = function(arg_24_0, arg_24_1, arg_24_2)
		arg_24_2:Op("OpMoveCamera", arg_24_1.eventId, arg_24_1.stayTime)

		return
	end,
	[var_0_1.WORLD_SCANNER_EVENT] = function(arg_25_0, arg_25_1, arg_25_2)
		arg_25_2:GuideShowScannerEvent(arg_25_1.eventId)

		return
	end,
	[var_0_1.WORLD_HELP_EVENT] = function(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_2
		local var_26_1 = arg_26_2.emit

		WorldMediator = var_1_10006

		local var_26_2 = var_1_10006.OnOpenLayer

		Context = var_1_10007

		local var_26_3 = var_1_10007.New
		local var_26_4 = {}

		WorldHelpMediator = var_1_10010
		var_26_4.mediator = var_1_10010
		WorldHelpLayer = var_1_10010
		var_26_4.viewComponent = var_1_10010
		var_26_4.data = {
			titleId = arg_26_1.titleId,
			pageId = arg_26_1.pageId
		}

		var_26_1(var_26_0, var_26_2, var_26_3(var_26_4))

		return
	end,
	[var_0_1.WORLD_RECALL] = function(arg_27_0, arg_27_1, arg_27_2)
		arg_27_2:Op("OpInteractive")

		return
	end
}

function var_0_1.GetWorldGuiderNotifies(arg_28_0)
	underscore = var_1_10001

	return var_1_10001.keys(var_0_2)
end

function var_0_1.WorldGuiderNotifyHandler(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	switch = var_1_10004

	var_1_10004(arg_29_1, var_0_2, nil, arg_29_1, arg_29_2, arg_29_3)

	return
end

return var_0_1
