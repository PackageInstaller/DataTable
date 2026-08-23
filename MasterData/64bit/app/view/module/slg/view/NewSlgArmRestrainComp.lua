local NewSlgArmRestrainComp = class("NewSlgArmRestrainComp")

function NewSlgArmRestrainComp:ctor()
	self._compTxt1 = self:getChild("Comp_txt1")
	self._compTxt2 = self:getChild("Comp_txt2")
	self._compArm1 = self:getChild("Comp_arm1")
	self._compArm2 = self:getChild("Comp_arm2")
	self._compArm3 = self:getChild("Comp_arm3")
	self._compArm4 = self:getChild("Comp_arm4")

	self:updateView()
end

function NewSlgArmRestrainComp:updateView()
	self._compTxt1:updateView({
		txt = g.core.model.User:getNoticeText(741)
	})
	self._compTxt2:updateView({
		txt = g.core.model.User:getNoticeText(742)
	})
end

return NewSlgArmRestrainComp
