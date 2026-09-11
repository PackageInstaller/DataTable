local DormIlluBasePage = class("DormIlluBasePage", ReduxView)

function DormIlluBasePage:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.itemGo_ = arg_1_2

	self:InitUI()
end

function DormIlluBasePage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.uiList = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, self:ItemClass())
end

function DormIlluBasePage:AddUIListener()
	return
end

function DormIlluBasePage:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)

	if arg_4_1 then
		self:OnShow()
	else
		self:OnHide()
	end
end

function DormIlluBasePage:OnShow()
	return
end

function DormIlluBasePage:OnHide()
	return
end

function DormIlluBasePage:RefreshUI()
	return
end

function DormIlluBasePage:Dispose()
	self:RemoveAllEventListener()
	DormIlluBasePage.super.Dispose(self)
end

function DormIlluBasePage:ItemClass()
	return nil
end

function DormIlluBasePage:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.cardDataList_[arg_10_1])
end

return DormIlluBasePage
