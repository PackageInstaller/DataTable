local var_0_0
local var_0_1
local var_0_2

function DoPolyhedronNextTrigger()
	LuaExchangeHelper.EnableATrigger(var_0_0, var_0_1)
end

function DoPolyhedronNextBattleTrigger()
	LuaExchangeHelper.EnableATrigger(var_0_0, var_0_2)
end

local function var_0_3()
	LuaForCursor.SwitchCursor(false)
	JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
end

local function var_0_4()
	JumpTools.OpenPageByJump("/polyhedronBlank")
end

function SendPolyhedronGetBattleStage()
	CheckManagers()

	local var_5_0 = PolyhedronData:GetPolyhedronInfo()
	local var_5_1 = var_5_0:GetSavePoint()

	print("更新关卡点" .. var_5_1)

	if PolyhedronConst.SAVE_POINT_TYPE.BATTLE == var_5_1 then
		if PolyhedronConst.REWARD_TYEP.TEAMMATE == var_5_0:GetRewardType() then
			var_0_3()
		else
			var_0_4()
		end

		return 0
	elseif PolyhedronConst.SAVE_POINT_TYPE.REWARD == var_5_1 then
		return 1
	elseif PolyhedronConst.SAVE_POINT_TYPE.OPTION == var_5_1 then
		var_0_3()

		return 2
	end
end

function UpdatePolyhedronBattleHpUI()
	local var_6_0 = manager.ui.uiMain.transform:Find("BattlePanel/ScreenAdjustContainer/PlayerInfo").transform
	local var_6_1 = var_6_0:Find("hp/hp_value_text_max"):GetComponent("Text")

	var_6_0:GetComponent("PlayerInfoUI").enabled = false

	local var_6_2 = PolyhedronData:GetPolyhedronInfo()
	local var_6_3 = var_6_2:GetHeroPolyData(var_6_2:GetLeaderHeroId())
	local var_6_4 = math.round(tonumber(var_6_1.text) * var_6_3:GetHeroHP() / var_6_3:GetHeroMaxHP())

	var_6_0:Find("hp/hp_value_text"):GetComponent("Text").text = var_6_4
	var_6_0:Find("hp/Slider"):GetComponent("Slider").value = var_6_4 / tonumber(var_6_1.text)

	local var_6_5, var_6_6 = var_6_2:GetReviveCount()
	local var_6_7 = manager.ui.uiMain.transform:Find("BattlePanel/ScreenAdjustContainer/RightTopButtons/MatrixResurrectCoin")

	for iter_6_0 = 0, var_6_7.transform.childCount - 2 do
		local var_6_8 = var_6_7.transform:GetChild(iter_6_0).gameObject
		local var_6_9 = var_6_8.transform:GetChild(0).gameObject

		if iter_6_0 < var_6_6 then
			var_6_8:SetActive(true)
		else
			var_6_8:SetActive(false)
		end

		if iter_6_0 < var_6_5 then
			var_6_9:SetActive(true)
		else
			var_6_9:SetActive(false)
		end
	end
end

function SendPolyhedronSetNextTrigger(arg_7_0, arg_7_1)
	var_0_0 = arg_7_0
	var_0_1 = arg_7_1
end

function SendPolyhedronGetCharactorInfo(arg_8_0)
	local var_8_0 = PolyhedronData:GetPolyhedronInfo()

	if PolyhedronConst.REWARD_TYEP.TEAMMATE == var_8_0:GetRewardType() then
		local var_8_1 = var_8_0:GetEnlistHeroList()

		return var_8_1[arg_8_0 + 1] and PolyhedronData:GetHeroUsingSkinInfo(var_8_1[arg_8_0 + 1].heroId).id or 0
	else
		Debug.LogError("SendPolyhedronGetCharactorInfo config error")

		if arg_8_0 + 1 == 1 then
			return 1011
		else
			return 0
		end
	end
end

function SendPolyhedronShowCharactorInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0 = arg_9_0 + 1

	if arg_9_0 ~= 0 and not PolyhedronData:GetPolyhedronInfo():GetEnlistHeroList()[arg_9_0] then
		return
	end

	var_0_0 = arg_9_1
	var_0_1 = arg_9_2
	var_0_2 = arg_9_3

	JumpTools.OpenPageByJump("polyhedronInteractiveHero", {
		index = arg_9_0
	})
end

function SendPolyhedronHideCharactorInfo(arg_10_0)
	var_0_3()
end

function SendPolyhedronNextMapIsExist(arg_11_0)
	local var_11_0 = PolyhedronData:GetPolyhedronInfo():GetGateData(arg_11_0)

	if var_11_0 then
		return PolyhedronTools.GetGateCfg(var_11_0.id, var_11_0.reward_type).gate_index
	else
		return 0
	end
end

function SendPolyhedronShowNextMapInfo(arg_12_0)
	JumpTools.OpenPageByJump("polyhedronInteractive", {
		index = arg_12_0
	})
end

function SendPolyhedronHideNextMapInfo(arg_13_0)
	var_0_3()
end

function SendPolyhedronShowRewardInfo(arg_14_0, arg_14_1)
	if PolyhedronConst.SAVE_POINT_TYPE.REWARD == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
		var_0_0 = arg_14_0
		var_0_1 = arg_14_1

		JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle/polyhedronReward")
		LuaForCursor.SwitchCursor(true)
	else
		LuaExchangeHelper.EnableATrigger(arg_14_0, arg_14_1)
	end
end

function SendPolyhedronShowStoreInfo()
	JumpTools.OpenPageByJump("polyhedronBattle/polyhedronInteractiveShop")
end

function HidePolyhedronShowStoreInfo()
	var_0_3()
end

function SendPolyhedronShowExitInfo()
	return
end

function SendPolyhedronHideExitInfo()
	return
end

function SendPolyhedronShowTeamInfo()
	return
end

function SendPolyhedronHideTeamInfo()
	return
end
