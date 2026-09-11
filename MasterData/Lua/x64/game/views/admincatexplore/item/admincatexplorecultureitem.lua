local AdminCatExploreCultureItem = class("AdminCatExploreCultureItem", ReduxView)

function AdminCatExploreCultureItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function AdminCatExploreCultureItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreCultureItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.selectController = ControllerUtil.GetController(self.gameObject_.transform, "select")
end

function AdminCatExploreCultureItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.registerFunction then
			self.registerFunction(self.index)
		end
	end)
end

function AdminCatExploreCultureItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.data = arg_6_1
	self.index = arg_6_2
	self.registerFunction = arg_6_3
	self.selectIndex = arg_6_4

	self:UpdateView()
end

function AdminCatExploreCultureItem:GetController()
	return self.selectController
end

function AdminCatExploreCultureItem:UpdateView()
	local var_8_0 = ExploreMeowCfg[self.data.id]

	self.stateController:SetSelectedState(self.data.canUse and "unlock" or "lock")

	self.adminCatImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_8_0.meow_icon)
	self.nameTxt_.text = GetI18NText(var_8_0.meow_name)

	self.selectController:SetSelectedState(self.index == self.selectIndex and "sel" or "normal")
	manager.redPoint:bindUIandKey(self.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. self.data.id, {
		x = 150,
		y = 70
	})
end

function AdminCatExploreCultureItem:OnEnter()
	self:UpdateView()
end

function AdminCatExploreCultureItem:OnExit()
	manager.redPoint:unbindUIandKey(self.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. self.data.id)
end

function AdminCatExploreCultureItem:Dispose()
	AdminCatExploreCultureItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreCultureItem
