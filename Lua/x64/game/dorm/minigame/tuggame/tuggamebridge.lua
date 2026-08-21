local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	JumpTools.OpenPageByJump("/SPKailiTugInfoView", {
		stageID = arg_1_0,
		activityID = arg_1_1
	})
end

function var_0_0.Enter(arg_2_0, arg_2_1, arg_2_2)
	print("TugGameBridge")
	manager.ui:SetMainCamera("TugGame")
	TugGameMgr.GetInstance():Init()

	arg_2_0.gameManager = TugGame.GetInstance()

	var_0_1(arg_2_2.stageID, arg_2_2.activityID)
	arg_2_0.gameManager:Init(arg_2_2.stageID, arg_2_2.activityID)
end

function var_0_0.Exit(arg_3_0)
	print("TugGame  Exit")
	PushTugGameGoToMain()
end

function PushTugGameGoToMain()
	TugGame.GetInstance():Exit()
	DestroyLua()
	LuaExchangeHelper.GoToMain()
end

return var_0_0
