local MessageBoxItem = import("manager.message.MessageBoxItem")
local ShowMessageMgr = class("ShowMessageMgr", import("game.extend.BaseView"))

function ShowMessageMgr:Ctor()
	self:OnCtor()
end

function ShowMessageMgr:OnCtor()
	print("initializing show message manager ...")

	self.itemList_ = {}
end

function ShowMessageMgr:ShowMessage(arg_3_1)
	if manager.ui.uiMessage == nil then
		return
	end

	if arg_3_1.boxType == nil or arg_3_1.boxType == NORMAL_MESSAGE_BOX then
		self:ShowNormalBox(arg_3_1)
	end
end

function ShowMessageMgr:ShowNormalBox(arg_4_1)
	self:GetFreeItem(arg_4_1):SetData(arg_4_1)
end

function ShowMessageMgr:GetFreeItem(arg_5_1)
	if self.itemList_ == nil then
		print("弹窗已经被销毁，被调用")

		self.itemList_ = {}
	end

	local var_5_0 = "Widget/Common/Pop/UIInquirepopup12"

	if arg_5_1.prefabPath and arg_5_1.prefabPath ~= "" then
		var_5_0 = arg_5_1.prefabPath
	end

	self.itemList_[var_5_0] = self.itemList_[var_5_0] or {}

	for iter_5_0, iter_5_1 in pairs(self.itemList_[var_5_0]) do
		if iter_5_1:IsFree() then
			return iter_5_1
		end
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(var_5_0), manager.ui.uiMessage.transform)

	SetActive(self.gameObject_, false)

	local var_5_2 = MessageBoxItem.New(self.gameObject_)

	table.insert(self.itemList_[var_5_0], var_5_2)

	return var_5_2
end

function ShowMessageMgr:HideAll()
	if self.itemList_ then
		for iter_6_0, iter_6_1 in pairs(self.itemList_) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				iter_6_3:Hide()
			end
		end
	end
end

function ShowMessageMgr:GetItemList()
	return self.itemList_
end

function ShowMessageMgr:GetIsAllFree()
	for iter_8_0, iter_8_1 in pairs(self.itemList_) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			if not iter_8_3:IsFree() then
				return false
			end
		end
	end

	return true
end

function ShowMessageMgr:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.itemList_) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			iter_9_3:Dispose()
		end
	end

	self.itemList_ = nil

	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	ShowMessageMgr.super.Dispose(self)
end

return ShowMessageMgr
