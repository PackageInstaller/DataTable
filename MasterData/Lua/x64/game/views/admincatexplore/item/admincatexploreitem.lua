local AdminCatExploreItem = class("AdminCatExploreItem", ReduxView)

function AdminCatExploreItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function AdminCatExploreItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.commendController = ControllerUtil.GetController(self.gameObject_.transform, "commend")
end

function AdminCatExploreItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.selectBtn then
			self.selectBtn(self.index)
		end
	end)
end

function AdminCatExploreItem:GetStateController()
	return self.stateController
end

function AdminCatExploreItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.data = arg_7_1
	self.isSelect = arg_7_2
	self.selectBtn = arg_7_3

	self:UpdateView()

	self.index = arg_7_4
end

function AdminCatExploreItem:UpdateView()
	if self.data == nil then
		self.stateController:SetSelectedState("no")
		self.commendController:SetSelectedState("off")

		return
	end

	local var_8_0 = ExploreMeowCfg[self.data.id]
	local var_8_1 = ExploreMeowSkillCfg[ExploreMeowCfg[self.data.id].skill]
	local var_8_2 = ExploreMeowInbornCfg[ExploreMeowCfg[self.data.id].inborn]

	self.nameTxt_.text = GetI18NText(ExploreMeowCfg[self.data.id].meow_name)
	self.skillLvTxt_.text = "Lv.<color=#EDF2F7><size=32>" .. AdminCatExploreData:GetDataByPara("skillData")[ExploreMeowCfg[self.data.id].skill] .. "</size> </color>"

	self.commendController:SetSelectedState(self.data.recommend and "on" or "off")

	if self.isSelect and self.data.canUse then
		self.stateController:SetSelectedState("sel")
	else
		self.stateController:SetSelectedState(self.data.canUse and "normal" or "lock")
	end

	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. var_8_0.meow_icon)
	self.skillImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_8_2.inborn_icon)
	self.skillImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_8_1.skill_icon)
end

function AdminCatExploreItem:OnEnter()
	self:UpdateView()
end

function AdminCatExploreItem:OnExit()
	return
end

function AdminCatExploreItem:Dispose()
	self.selectBtn = nil

	AdminCatExploreItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreItem
