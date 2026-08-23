local var_0_0 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local CultivateMainLayer = class("CultivateMainLayer", require("app.fairyGUI.cultivate.UI_CultivateMainLayer"), function()
	return fgui.GComponent:create({
		resName = "CultivateMainLayer",
		pkgPath = "ui/cultivate/cultivate",
		isFullScreen = true,
		pkgName = "cultivate"
	}, ...)
end)

function CultivateMainLayer:ctor(arg_2_1)
	if arg_2_1.goods then
		self._actId = arg_2_1.goods.activity_value or arg_2_1.route1
	end

	self._actData = var_0_0:getCultivateData(self._actId)

	self:initCurrentView()

	self._currentComp = nil
end

function CultivateMainLayer:initCurrentView()
	local var_3_0 = self._actData:getActivityCfg()
	local var_3_1 = g.core.config.cultivate_activity_display_info.get(var_3_0.id)

	self.m_topBarComp:setResInfoById(var_3_1.interface_main)
	self.m_topBarComp:setTitle(var_3_0.name)

	local var_3_2

	if var_3_0.type ~= CultivateConst.ACTIVITY_TYPE.WITCH then
		var_3_2 = fgui.UIPackage:createObject("cultivate", "CultivateMainPackComp" .. var_3_1.module_type)

		var_3_2:setCurrentActId(self._actId)
		self:addBg("bg/cultivate/" .. var_0_0:getResDirId(self._actId) .. "/bg_main.jpg")
	else
		var_3_2 = fgui.UIPackage:createObject("cultivate", "CultivateWitchPackComp")

		var_3_2:setCurrentActId(self._actId)
		self:addBg("bg/cultivate/" .. var_0_0:getResDirId(self._actId) .. "/bg_mnzj_zjm.jpg")
	end

	self.m_holderHolder:addChild(var_3_2)

	self._currentComp = var_3_2
end

return CultivateMainLayer
