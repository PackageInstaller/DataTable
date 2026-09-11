local LimitTimeTaskTabItem = class("LimitTimeTaskTabItem", ReduxView)

function LimitTimeTaskTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LimitTimeTaskTabItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function LimitTimeTaskTabItem:InitUI()
	self:BindCfgUI()
end

function LimitTimeTaskTabItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self:OnSelectBtnClick()
	end)
end

function LimitTimeTaskTabItem:OnSelectBtnClick()
	self.onClick_(self.index_)
end

function LimitTimeTaskTabItem:SetSelectedState(arg_7_1)
	self.selectController_:SetSelectedState(self.index_ == arg_7_1 and "select" or "upselect")
end

function LimitTimeTaskTabItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.subActivityID_ = arg_8_2
	self.onClick_ = arg_8_3

	self:UpdateView()
end

function LimitTimeTaskTabItem:UpdateView()
	if not ActivityCfg[self.subActivityID_] then
		return
	end

	self.upsText_.text = ActivityCfg[self.subActivityID_].remark
	self.sText_.text = ActivityCfg[self.subActivityID_].remark
	self.upsImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Com/" .. self.subActivityID_)
	self.sImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Com/" .. self.subActivityID_)
end

function LimitTimeTaskTabItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. self.subActivityID_)
	end
end

function LimitTimeTaskTabItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. self.subActivityID_)
end

function LimitTimeTaskTabItem:GetActivityID()
	return self.subActivityID_
end

function LimitTimeTaskTabItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	LimitTimeTaskTabItem.super.Dispose(self)
end

return LimitTimeTaskTabItem
