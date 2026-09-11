local StrongholdOperateSkillPage = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function StrongholdOperateSkillPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdIncreaseUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:Refresh()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateSkillPage:InitUI()
	self:BindCfgUI()

	self.node_list = {}

	for iter_4_0, iter_4_1 in pairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id) do
		local var_4_0 = StrongholdOperateIncreaseItem.New(self.m_nodes:Find(tostring(iter_4_0)), iter_4_0)

		var_4_0:RegistCallBack(handler(self, self.SetSelectNode))

		self.node_list[iter_4_0] = var_4_0
	end

	self.stateConotroller = ControllerUtil.GetController(self.transform_, "state")
	self.showConotroller = ControllerUtil.GetController(self.transform_, "show")
end

function StrongholdOperateSkillPage:AddUIListener()
	self:AddBtnListener(self.m_unlockBtn, nil, function()
		if self.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(self.activity_id, self.curNodeId)
	end)
	self:AddBtnListener(self.m_upgradeBtn, nil, function()
		if self.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(self.activity_id, self.curNodeId)
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self:SetSelectNode(nil)
	end)
end

function StrongholdOperateSkillPage:Refresh(arg_9_1)
	self.activity_id = arg_9_1

	self:SetSelectNode(nil, false)
	self:RefreshUI()
end

function StrongholdOperateSkillPage:RefreshUI()
	self.all_level, self.all_poit = StrongholdData:GetStrongholdLevelAndIncreasePoint(self.activity_id)
	self.m_allLvLab.text = self.all_level
	self.use_point = StrongholdData:GetUsePoint(self.activity_id)
	self.m_point.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_LEFT"), self.all_poit - self.use_point)

	for iter_10_0, iter_10_1 in pairs(self.node_list) do
		iter_10_1:Refresh(StrongholdData:GetIncreaseLevel(self.activity_id, iter_10_1.node_id), self.all_poit - self.use_point)
	end
end

function StrongholdOperateSkillPage:SetSelectNode(arg_11_1, arg_11_2, arg_11_3)
	self.curNodeId = arg_11_1

	for iter_11_0, iter_11_1 in pairs(self.node_list) do
		iter_11_1:SetSelect(self.curNodeId)
	end

	if self.curNodeId == nil then
		self.showConotroller:SetSelectedIndex(0)

		self.m_scrollCom.movementType = ScrollRect.MovementType.Elastic

		self:RemoveTween()

		return
	end

	local var_11_0 = Vector3.New(-self.m_scrollContent.transform:InverseTransformPoint((arg_11_3.transform_:TransformPoint(Vector3(0, 0, 0)))).x, 0, 0)

	self:RemoveTween()

	self.tween_ = LeanTween.moveLocal(self.m_scrollContent.gameObject, var_11_0, 0.2)
	self.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

	self.showConotroller:SetSelectedIndex(1)
	self:RefreshRightInfo()

	if arg_11_2 then
		self.m_animator:Play("Fx_messagebg_cx_01", 0, 0)
	end
end

function StrongholdOperateSkillPage:RefreshRightInfo()
	local var_12_0 = StrongholdData:GetIncreaseLevel(self.activity_id, self.curNodeId)

	if var_12_0 == 0 then
		self.stateConotroller:SetSelectedIndex(0)

		self.m_name.text = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][1]].skill_name
		self.m_des.text = self:GetSkillDes(ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][1]])
		self.m_lvLab.text = "Lv" .. ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][1]].skill_level
		self.m_nextLvDes.text = ""
		self.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][1]].cost)
		self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][1]].skill_id)
	elseif var_12_0 >= #ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId] then
		self.stateConotroller:SetSelectedIndex(2)

		self.m_name.text = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][#ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId]]].skill_name
		self.m_des.text = self:GetSkillDes(ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][#ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId]]])
		self.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
		self.m_nextLvDes.text = ""
		self.m_costLab.text = ""
		self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][#ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId]]].skill_id)
	else
		self.stateConotroller:SetSelectedIndex(1)

		self.m_name.text = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0]].skill_name
		self.m_des.text = self:GetSkillDes(ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0]])
		self.m_lvLab.text = "Lv" .. ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0]].skill_level
		self.m_nextLvDes.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_NEXT_LV"), "", self:GetSkillDes(ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0 + 1]]))
		self.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0 + 1]].cost)
		self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[self.curNodeId][var_12_0]].skill_id)
	end
end

function StrongholdOperateSkillPage:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function StrongholdOperateSkillPage:GetSkillDes(arg_14_1)
	if arg_14_1.effect_type == 1 then
		return getAffixDesc(arg_14_1.effect_params)
	elseif arg_14_1.effect_type == 2 then
		return string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_REVIVAL"), arg_14_1.effect_params[1])
	else
		rteurn("")
	end
end

function StrongholdOperateSkillPage:Dispose()
	for iter_15_0, iter_15_1 in pairs(self.node_list) do
		iter_15_1:Dispose()
	end

	self:RemoveTween()

	self.node_list = {}

	StrongholdOperateSkillPage.super.Dispose(self)
end

function StrongholdOperateSkillPage:OnStrongholdUpgradeIncrease()
	self:RefreshUI()
	self:RefreshRightInfo()
end

return StrongholdOperateSkillPage
