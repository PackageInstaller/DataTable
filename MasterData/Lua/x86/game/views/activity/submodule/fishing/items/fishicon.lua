local FishIcon = class("FishIcon", ReduxView)

function FishIcon:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishIcon:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishIcon:InitUI()
	self:BindCfgUI()

	self.iconController_ = ControllerUtil.GetController(self.gameObject_.transform, "icon")
	self.showNumController_ = ControllerUtil.GetController(self.gameObject_.transform, "showNum")
	self.showHaveController_ = ControllerUtil.GetController(self.gameObject_.transform, "showHave")
	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
end

function FishIcon:AddUIListener()
	self:AddBtnListener(self.iconBtn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_(self.id_)
		end
	end)
end

function FishIcon:AddEventListeners()
	return
end

function FishIcon:RegisterClickListener(arg_7_1)
	self.icon_.raycastTarget = true
	self.clickListener_ = arg_7_1
end

function FishIcon:SetSelected(arg_8_1)
	self.selectedController_:SetSelectedState(arg_8_1 and "true" or "false")
end

function FishIcon:SetId(arg_9_1, arg_9_2, arg_9_3)
	self.id_ = arg_9_1
	arg_9_2 = arg_9_2 or -1
	arg_9_3 = arg_9_3 or -1
	self.haveNum_ = arg_9_3
	self.num_ = arg_9_2

	self:UpdateView()
end

function FishIcon:UpdateView()
	if self.needUpdateHave_ then
		self:UpdateHaveBg()
	end

	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Fishing/RareFishIcon/%d", self.id_))

	if self.num_ == -1 then
		self.showNumController_:SetSelectedState("false")
	else
		self.showNumController_:SetSelectedState("true")

		self.numLabel_.text = tostring(self.num_)
	end

	if self.haveNum_ == -1 then
		self.showHaveController_:SetSelectedState("false")
	else
		self.showHaveController_:SetSelectedState("true")

		self.haveNumLabel_.text = tostring(self.haveNum_)
	end
end

function FishIcon:OnTop()
	self:UpdateBar()
end

function FishIcon:UpdateBar()
	return
end

function FishIcon:SetNeedUpdateHave(arg_13_1)
	self.needUpdateHave_ = arg_13_1
end

function FishIcon:UpdateHaveBg()
	local var_14_1 = FishingData:GetFish(self.id_)

	if ((var_14_1 ~= nil or nil) and var_14_1.num) > 0 then
		self.iconController_:SetSelectedState("have")
	else
		self.iconController_:SetSelectedState("not")
	end
end

function FishIcon:OnEnter()
	self:AddEventListeners()
end

function FishIcon:OnExit()
	self:RemoveAllEventListener()
end

function FishIcon:Dispose()
	self.clickListener_ = nil

	FishIcon.super.Dispose(self)
end

return FishIcon
