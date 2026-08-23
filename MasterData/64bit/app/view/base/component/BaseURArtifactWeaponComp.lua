local BaseURArtifactWeaponComp = class("BaseURArtifactWeaponComp", require("app.fairyGUI.base_new.UI_BaseURArtifactWeaponComp"))

function BaseURArtifactWeaponComp:onLoad()
	self:updateCurWeapon()
end

function BaseURArtifactWeaponComp:updateCurWeapon(arg_2_1)
	self._artifactStruct = arg_2_1 or self._artifactStruct

	if not self._artifactStruct then
		return
	end

	self.m_weaponTxt:setText("+" .. self._artifactStruct:getSpiritStage())
end

return BaseURArtifactWeaponComp
