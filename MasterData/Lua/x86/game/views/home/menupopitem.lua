local MenuPopItem = class("MenuPopItem", ReduxView)

function MenuPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MenuPopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MenuPopItem:InitUI()
	self:BindCfgUI()

	self.typeController_ = self.controllerEx_:GetController("bgType")
	self.lockController_ = self.controllerEx_:GetController("lock")
end

function MenuPopItem:AddUIListener()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickFun_ then
			self:clickFun_()
		end
	end)
end

function MenuPopItem:SetData(arg_6_1, arg_6_2)
	self.data_ = arg_6_1
	self.clickFun_ = arg_6_2
	self.iconImg_.sprite = getSprite("Atlas/MainAtlas", arg_6_1.icon)
	self.nameText_.text = GetTips(arg_6_1.nameId)

	self.typeController_:SetSelectedState(arg_6_1.type)
	self.lockController_:SetSelectedState(arg_6_1.lock and "true" or "false")
end

function MenuPopItem:BindRedPointUI()
	if MenuPopConst.MenuRedPointList[self.data_.id] then
		manager.redPoint:bindUIandKey(self.transform_, MenuPopConst.MenuRedPointList[self.data_.id])
	end
end

function MenuPopItem:UnBindRedPointUI()
	if MenuPopConst.MenuRedPointList[self.data_.id] then
		manager.redPoint:unbindUIandKey(self.transform_, MenuPopConst.MenuRedPointList[self.data_.id])
	end
end

function MenuPopItem:GetBulletinID()
	local var_9_0 = manager.time:GetServerTime()

	for iter_9_0, iter_9_1 in ipairs({
		101,
		102,
		104
	}) do
		local var_9_1 = BulletinData.GetBulletinIDList()[iter_9_1]

		if var_9_1 then
			for iter_9_2, iter_9_3 in pairs(var_9_1) do
				local var_9_2 = BulletinData.GetBulletinPageList()[iter_9_3]

				if var_9_0 < var_9_2.endTime then
					return var_9_2.id
				end
			end
		end
	end

	return false
end

function MenuPopItem:OnExit()
	self:UnBindRedPointUI()
end

function MenuPopItem:Dispose()
	MenuPopItem.super.Dispose(self)
	self:UnBindRedPointUI()
end

return MenuPopItem
