local RoleSkinStageUpSuccessPop = class("RoleSkinStageUpSuccessPop", require("app.fairyGUI.roleSkin.UI_RoleSkinStageUpSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "RoleSkinStageUpSuccessPop",
		pkgPath = "ui/roleSkin/roleSkin",
		pkgName = "roleSkin"
	}, ...)
end)

function RoleSkinStageUpSuccessPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1
	self._struct = arg_2_1.struct
end

function RoleSkinStageUpSuccessPop:onLoad()
	self:_updateView()
	self.m_enterTransition:play()
end

function RoleSkinStageUpSuccessPop:onUnload()
	self.m_backTransition:play()
end

function RoleSkinStageUpSuccessPop:_updateView()
	self.m_nameComp:setData(self._struct:getName(), self._struct:getQuality())
	self.m_picLoader:setURL(g.core.common.Path:getRoleSkinIcon(self._struct:getIcon(), 512))
	self.m_stage1:setText(self._params.stage1)
	self.m_stage2:setText(self._params.stage2)

	for iter_5_0 = 1, 4 do
		self["m_attrComp" .. iter_5_0]:setVisible(checkbool(self._params.attrParams[iter_5_0]))

		if self._params.attrParams[iter_5_0] then
			self["m_attrComp" .. iter_5_0]:updateAttr(self._params.attrParams[iter_5_0])
		end
	end

	self.m_talentGroup:setVisible(self._params.talentId > 0)

	if self._params.talentId > 0 then
		self.m_talentTxt:setText(g.core.config.talent_skill_info.get(self._params.talentId).description)
	end
end

return RoleSkinStageUpSuccessPop
