local DayNightCutSceneLoadingNight = class("DayNightCutSceneLoadingNight", ReduxView)

function DayNightCutSceneLoadingNight:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/DayNightCutSceneLoading_Night"
end

function DayNightCutSceneLoadingNight:UIParent()
	return manager.ui.uiPop.transform
end

function DayNightCutSceneLoadingNight:Dispose()
	DayNightCutSceneLoadingNight.super.Dispose(self)
end

return DayNightCutSceneLoadingNight
