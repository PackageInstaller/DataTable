local QWorldHintItem = class("QWorldHintItem", ReduxView)

function QWorldHintItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldHintItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldHintItem:InitUI()
	self:BindCfgUI()
end

function QWorldHintItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnSelectBtnClick()
	end)
end

function QWorldHintItem:OnSelectBtnClick()
	SandPlayIlluTool.EnterSandPlayIllu(self.itemID_)
end

function QWorldHintItem:SetData(arg_7_1)
	self.itemID_ = arg_7_1

	self:UpdateView()
end

function QWorldHintItem:UpdateView()
	if not SandplayIlluCfg[self.itemID_] then
		return
	end

	self.image_.sprite = getSpriteViaConfig("SandplayIllu", SandplayIlluCfg[self.itemID_].icon)
	self.nameText_.text = GetI18NText(SandplayIlluCfg[self.itemID_].name)
end

function QWorldHintItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function QWorldHintItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	QWorldHintItem.super.Dispose(self)
end

return QWorldHintItem
