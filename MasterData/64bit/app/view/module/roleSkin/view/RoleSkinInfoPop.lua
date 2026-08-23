local RoleSkinInfoPop = class("RoleSkinInfoPop", require("app.fairyGUI.roleSkin.UI_RoleSkinInfoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/roleSkin/roleSkin",
		resName = "RoleSkinInfoPop",
		pkgName = "roleSkin",
		isFullScreen = true
	}, ...)
end)

function RoleSkinInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._struct = arg_2_1.struct

	self:_updateView()
end

function RoleSkinInfoPop:_updateView()
	if not self._struct then
		return
	end

	local var_3_0 = fgui.GLoader:create()

	var_3_0:setAutoSize(true)
	var_3_0:setPivot(0.5, 0.5, true)
	var_3_0:setURL(g.core.common.Path:getRoleSkinIcon(self._struct:getIcon(), 512))

	local var_3_1 = fgui.UIPackage:createObject("roleSkin", "RoleSkinPartItemNameComp")

	var_3_1:updateNameComp(self._struct, false)
	var_3_1:setPivot(-0.2, 1, true)
	var_3_1:setVisible(true)
	self.m_infoPopBase:setPopView({
		quality = self._struct:getQuality(),
		tabParam = {
			{
				package = "roleSkin",
				compName = "RoleSkinInfoPopInfoComp",
				title = g.core.lang:get(201097)
			},
			{
				package = "roleSkin",
				compName = "RoleSkinInfoPopTalentComp",
				title = g.core.lang:get(205512)
			}
		},
		commonParam = self._struct,
		nameComp = var_3_1,
		itemComp = var_3_0
	})
end

return RoleSkinInfoPop
