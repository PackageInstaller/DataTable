local AllianceTrialMapConst = require("app.view.module.allianceTrial.const.AllianceTrialMapConst")
local AllianceTrialMapGround = class("AllianceTrialMapGround", require("app.core.ksmap.MapGround"))

function AllianceTrialMapGround:ctor(arg_1_1)
	AllianceTrialMapGround.super.ctor(self, arg_1_1)
end

function AllianceTrialMapGround:doBasePath()
	return g.core.common.Path:getAllianceTrialBasePath()
end

function AllianceTrialMapGround:_doTiledLayer()
	return {
		AllianceTrialMapConst.MAP_FLOOR,
		AllianceTrialMapConst.MAP_DECORATE
	}
end

function AllianceTrialMapGround:doAttachNode()
	return {
		AllianceTrialMapConst.MAP_FLOOR,
		AllianceTrialMapConst.MAP_DECORATE
	}
end

return AllianceTrialMapGround
