local DormCircleHeroItem = class("DormCircleHeroItem", ReduxView)

function DormCircleHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormCircleHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormCircleHeroItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function DormCircleHeroItem:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.heroID)
		end
	end)
end

function DormCircleHeroItem:SetClickCallBack(arg_6_1)
	if arg_6_1 then
		self.clickFunc = arg_6_1
	end
end

function DormCircleHeroItem:RefreshUI(arg_7_1, arg_7_2)
	if arg_7_1 then
		self.heroID = arg_7_1
		self.imageImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_7_1)
	end

	if HeroTools.GetHeroIsUnlock(arg_7_1) then
		if self.heroID == arg_7_2 then
			self.stateController:SetSelectedState("select")
		else
			self.stateController:SetSelectedState("normal")
		end
	else
		self.stateController:SetSelectedState("mask")
	end
end

function DormCircleHeroItem:Dispose()
	DormCircleHeroItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return DormCircleHeroItem
