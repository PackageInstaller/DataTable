local AdminCatExploreRewardItem = class("AdminCatExploreRewardItem", ReduxView)

function AdminCatExploreRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function AdminCatExploreRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreRewardItem:InitUI()
	self:BindCfgUI()

	self.nameController = ControllerUtil.GetController(self.gameObject_.transform, "name")
end

function AdminCatExploreRewardItem:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		ShowPopItem(POP_OTHER_ITEM, {
			self.data[1],
			self.data[2]
		})
	end)
end

function AdminCatExploreRewardItem:SetItemData(arg_6_1, arg_6_2)
	self.data = arg_6_1
	self.index = arg_6_2

	self:UpdateView()
end

function AdminCatExploreRewardItem:UpdateText(arg_7_1)
	self.numTxt_.text = arg_7_1
end

function AdminCatExploreRewardItem:UpdateView()
	self.numTxt_.text = self.data[2]
	self.iconImage_.sprite = ItemTools.getItemSprite(self.data[1])
end

function AdminCatExploreRewardItem:OnEnter()
	self:UpdateView()
end

function AdminCatExploreRewardItem:OnExit()
	return
end

function AdminCatExploreRewardItem:Dispose()
	AdminCatExploreRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreRewardItem
