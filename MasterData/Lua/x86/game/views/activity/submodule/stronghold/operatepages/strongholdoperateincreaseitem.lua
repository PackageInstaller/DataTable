local StrongholdOperateIncreaseItem = class("StrongholdOperateIncreaseItem", ReduxView)

function StrongholdOperateIncreaseItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.node_id = arg_1_2

	self:Init()
end

function StrongholdOperateIncreaseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateIncreaseItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. self.node_id)
end

function StrongholdOperateIncreaseItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.callback_ then
			self.callback_(self.node_id, true, self)
		end
	end)
end

function StrongholdOperateIncreaseItem:Refresh(arg_6_1, arg_6_2)
	local var_6_0 = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.node_id][arg_6_1 + 1]]

	if arg_6_1 == 0 then
		self.lockController:SetSelectedIndex(1)
	elseif not var_6_0 then
		self.lockController:SetSelectedIndex(2)

		self.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	else
		self.lockController:SetSelectedIndex(0)

		self.m_lvLab.text = "Lv" .. arg_6_1
	end

	if var_6_0 and arg_6_2 >= var_6_0.cost then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function StrongholdOperateIncreaseItem:SetSelect(arg_7_1)
	self.selectController:SetSelectedIndex(arg_7_1 == self.node_id and 1 or 0)
end

function StrongholdOperateIncreaseItem:RegistCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

return StrongholdOperateIncreaseItem
