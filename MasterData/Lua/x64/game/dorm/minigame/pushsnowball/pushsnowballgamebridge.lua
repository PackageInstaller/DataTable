local var_0_0 = {}

local function var_0_1()
	JumpTools.OpenPageByJump((PushSnowBallData:GetGoViewStr()))
end

function var_0_0.Enter(arg_2_0)
	manager.ui:SetMainCamera("pushSnowBall")
	DormMinigame.AdjustCameraFOV(0.5625)

	arg_2_0.listener = EventListener.New()

	local var_2_0 = PushSnowBallGameMgr.GetInstance()

	var_2_0:Init()
	var_2_0:SetPlayer(PushSnowBallData:GetSelectedHeroID())
	var_0_1()
end

function var_0_0:Exit()
	self.listener:RemoveAll()
	PushSnowBallGameMgr.GetInstance():Dispose()
end

function PushSnowBallGoToMain()
	DestroyLua()
	gameContext:ClearHistoryByName("setting")
	LuaExchangeHelper.GoToMain()
end

return var_0_0
