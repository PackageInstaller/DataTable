local ClassResourcePage = class("ClassResourcePage", import(".ResourcePage"))

function ClassResourcePage:getUIName()
	return "ClassResourcePage"
end

function ClassResourcePage:OnUpgrade()
	self:emit(ClassMediator.UPGRADE_FIELD, (self.resourceField:GetUpgradeType()))

	return
end

return ClassResourcePage
