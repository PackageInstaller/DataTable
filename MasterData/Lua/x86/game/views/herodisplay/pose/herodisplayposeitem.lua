local HeroDisplayPoseItem = class("HeroDisplayPoseItem", ReduxView)

function HeroDisplayPoseItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "select")
end

function HeroDisplayPoseItem:AddListeners()
	self:AddBtnListener(self.clickBtn_, nil, function()
		manager.notify:Invoke(HERO_POSE_SELECT, self.index_)
	end)
end

function HeroDisplayPoseItem:Dispose()
	HeroDisplayPoseItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function HeroDisplayPoseItem:SetData(arg_5_1, arg_5_2)
	self:Show(true)

	self.index_ = arg_5_2
	self.tagTxt_.text = GetI18NText(HeroDisplayPoseCfg[HeroDisplayData:GetHeroPoseList(arg_5_1)[arg_5_2].id].name)
end

function HeroDisplayPoseItem:SetSelect(arg_6_1)
	if arg_6_1 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

function HeroDisplayPoseItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return HeroDisplayPoseItem
