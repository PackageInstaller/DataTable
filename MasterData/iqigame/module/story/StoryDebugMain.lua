-- chunkname: @IQIGame\\Module\\Story\\StoryDebugMain.lua

require("IQIGame.RequireLua")

function Main()
	CfgUtil.Init()
	StoryModule.Initialize()
	EntityUtility.Init()
	ConversationModule.Init()
	PuzzleModule.Initialize()
	OpenUIUtility.Init()
end

Main()
