local FurnitureItemSimple = class("FurnitureItemSimple", ReduxView)

function FurnitureItemSimple:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.startController = ControllerUtil.GetController(self.transform_, "itembglevel")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.interactController = ControllerUtil.GetController(self.transform_, "interact")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.limitController = ControllerUtil.GetController(self.transform_, "upperlimit")
	self.furNumController = ControllerUtil.GetController(self.transform_, "furNum")
	self.screenController = ControllerUtil.GetController(self.transform_, "screening")
	self.infoController = ControllerUtil.GetController(self.transform_, "info")

	self:InitUI()
end

function FurnitureItemSimple:InitUI()
	self:BindCfgUI()
end

function FurnitureItemSimple:RefreshUI(arg_3_1)
	self.id = arg_3_1
	self.cfg = ItemCfg[self.id]

	if self.cfg then
		self.furName.text = ItemTools.getItemName(self.id)
		self.level = ItemCfg[self.id].rare
		self.iconImg_.sprite = ItemTools.getItemSprite(self.id)

		self.startController:SetSelectedState(0)
	else
		print("家具" .. self.id .. "在item表内未找到")

		return
	end
end

function FurnitureItemSimple:Dispose()
	self:RemoveAllListeners()
	FurnitureItemSimple.super.Dispose(self)
end

return FurnitureItemSimple
