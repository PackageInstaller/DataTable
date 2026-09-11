local cjson = require("cjson")
local QuizSceneShareView = class("QuizSceneShareView", (import("game.views.heroDisplay.HeroDisplayShareView")))

function QuizSceneShareView:SendToSDK(arg_1_1)
	return
end

function QuizSceneShareView:Dispose()
	self.super.Dispose(self)
end

return QuizSceneShareView
