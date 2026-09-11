local MoonFillingMaterialItem = class("MoonFillingMaterialItem", ReduxView)

function MoonFillingMaterialItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function MoonFillingMaterialItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function MoonFillingMaterialItem:SetData(arg_3_1)
	self.activityID_ = activityID
	self.ID_ = arg_3_1
	self.nameText_.text = ""

	self.SetActive(true)
end

function MoonFillingMaterialItem:SetNum(arg_4_1)
	self.numText_.text = arg_4_1
end

function MoonFillingMaterialItem:SetEnough(arg_5_1)
	if self.statusController_ then
		self.statusController_:SetSelectedState(arg_5_1 and "true" or "false")
	end
end

function MoonFillingMaterialItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return MoonFillingMaterialItem
