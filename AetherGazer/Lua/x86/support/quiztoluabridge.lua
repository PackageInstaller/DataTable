QuizGameManager = import("game.quiz.QuizGameManager")

print("===> QuizToLuaBridge Init")

local var_0_0 = {}
local var_0_1 = {}

function QuizSetGameStartArgs(arg_1_0)
	var_0_0 = arg_1_0
end

function LoadQuizScene()
	QuizSceneLoaded = 1

	DestroyLua()

	local var_2_0 = P08.Quiz.QuizDataForExchange()
	local var_2_1 = ActivityQuizTools.GetCurActivityID()

	var_2_0.sceneName = ActivityQuizTools.GetActivitySceneName(var_2_1)

	P08.Quiz.QuizLuaBridge.Launcher(var_2_0)
	QuizGameManager:Init()
end

function QuitQuizScene()
	if ActivityQuizTools.GetCurActivityBackTo() == "qworld" then
		LaunchQWorld(true)
	else
		gameContext:SetSystemLayer("home")
		LuaExchangeHelper.GoToMain()
	end
end

function OnEnterQuizScene()
	QuizSceneLoaded = 2

	QuizGameManager:StartGame(var_0_0, var_0_1)

	var_0_1 = {}

	manager.uiInit()
	gameContext:SetSystemLayer("battle")

	local var_4_0 = ActivityQuizTools.GetCurActivityID()

	gameContext:Go("/activityQuizSceneMain", {
		activityId = var_4_0
	})
end

function OnExitQuizScene()
	QuizSceneLoaded = 0

	QuizGameManager:Destroy()
	DestroyLua()
end

function QuizPendingAddPlayers(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		table.insert(var_0_1, iter_6_1)
	end
end

function GetQuizSceneLoaded()
	return QuizSceneLoaded
end
