local IlluEnemyFileDetailItem = class("IlluEnemyFileDetailItem", ReduxView)

function IlluEnemyFileDetailItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluEnemyFileDetailItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluEnemyFileDetailItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function IlluEnemyFileDetailItem:RefreshUI(arg_4_1)
	SetActive(self.gameObject_, true)

	self.titleText_.text = GetI18NText(arg_4_1.name)

	if arg_4_1.isLock then
		self.controller_:SetSelectedState("lock")

		self.requireText_.text = GetI18NText(arg_4_1.info)
	else
		self.controller_:SetSelectedState("unlock")

		self.descText_.text = GetI18NText(arg_4_1.info)
	end
end

function IlluEnemyFileDetailItem:Hide()
	SetActive(self.gameObject_, false)
end

function IlluEnemyFileDetailItem:AddUIListener()
	return
end

function IlluEnemyFileDetailItem:Dispose()
	IlluEnemyFileDetailItem.super.Dispose(self)
end

return IlluEnemyFileDetailItem
