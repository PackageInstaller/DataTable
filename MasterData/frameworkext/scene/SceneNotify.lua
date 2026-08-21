module("frameworkext.scene.SceneNotify", package.seeall)

return {
	EnterZone = UIDUtil.getEventUID(),
	ExitZone = UIDUtil.getEventUID(),
	FirstZonesLoaded = UIDUtil.getEventUID(),
	ZoneLoaded = UIDUtil.getEventUID(),
	ZoneDestroyed = UIDUtil.getEventUID(),
	TargetMove = UIDUtil.getEventUID(),
	TargetArrive = UIDUtil.getEventUID()
}
