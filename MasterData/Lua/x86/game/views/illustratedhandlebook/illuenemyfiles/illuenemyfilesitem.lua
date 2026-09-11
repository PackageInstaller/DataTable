local IlluEnemyFilesItem = class("IlluEnemyFilesItem", ReduxView)

function IlluEnemyFilesItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluEnemyFilesItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluEnemyFilesItem:InitUI()
	self:BindCfgUI()

	self.iconImg_.cacheLimit = 3
	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function IlluEnemyFilesItem:RefreshUI(arg_4_1)
	self.ID_ = arg_4_1.id
	self.nameText_.text = GetI18NText(arg_4_1.name)
	self.have_ = IllustratedData:GetEnemyInfo()[self.ID_]

	if self.have_ then
		self.controller_:SetSelectedState("1")

		self.isView_ = IllustratedData:GetIsView(self.ID_, CollectConst.ENEMY)

		manager.redPoint:SetRedPointIndependent(self.transform_, self.isView_ == 0)
	else
		self.controller_:SetSelectedState("0")
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end

	self.iconImg_.spriteSync = string.format("TextureConfig/IllustratedHandbook/boss/%s", arg_4_1.id)
end

function IlluEnemyFilesItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.have_ then
			if self.isView_ == 0 then
				IllustratedAction.ViewIllustration(self.ID_, CollectConst.ENEMY)
			end

			self:Go("/illuEnemyFileDetail", {
				id = self.ID_
			})
		else
			ShowTips("COLLECT_MANSTER_INFO_UNLOCK_FAILED")
		end
	end)
end

function IlluEnemyFilesItem:Dispose()
	IlluEnemyFilesItem.super.Dispose(self)
end

return IlluEnemyFilesItem
