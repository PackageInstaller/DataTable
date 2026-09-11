local PolyhedronAdditionSettingView = class("PolyhedronAdditionSettingView", ReduxView)

function PolyhedronAdditionSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function PolyhedronAdditionSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.stageData = arg_2_3

	self:Init()
end

function PolyhedronAdditionSettingView:Init()
	self.clickTerminalHandler_ = handler(self, self.PopInfo)

	self:InitUI()
	self:AddUIListener()
end

function PolyhedronAdditionSettingView:AddUIListener()
	self:AddBtnListener(nil, self.m_beaconTrs, function()
		self:Select(3)
		SetActive(self.m_terminalDescGo, false)
	end)
	self:AddBtnListener(nil, self.m_artifaceTrs, function()
		self:Select(1)
		SetActive(self.m_terminalDescGo, false)
	end)
	self:AddBtnListener(nil, self.m_talentTrs, function()
		self:Select(2)
		SetActive(self.m_terminalDescGo, false)
	end)
	self:AddBtnListener(self.m_infoMask, nil, function()
		SetActive(self.m_terminalDescGo, false)
	end)
end

function PolyhedronAdditionSettingView:PopInfo(arg_9_1, arg_9_2, arg_9_3)
	SetActive(self.m_terminalDescGo, true)

	self.m_terminalDescTrans.position = arg_9_3
	self.m_terminalDescTitle.text = GetI18NText(arg_9_1)
	self.m_terminalDesc.text = GetI18NText(arg_9_2)
end

function PolyhedronAdditionSettingView:Select(arg_10_1)
	self.toggleController_1:SetSelectedIndex(arg_10_1 == 1 and 1 or 0)
	self.toggleController_2:SetSelectedIndex(arg_10_1 == 2 and 1 or 0)
	self.toggleController_3:SetSelectedIndex(arg_10_1 == 3 and 1 or 0)

	if arg_10_1 == 1 then
		self:RefreshArtifact()
	end
end

function PolyhedronAdditionSettingView:InitUI()
	self:BindCfgUI()

	self.beaconList = {}
	self.toggleController_3 = ControllerUtil.GetController(self.m_beaconTrs, "name")
	self.toggleController_1 = ControllerUtil.GetController(self.m_artifaceTrs, "name")
	self.toggleController_2 = ControllerUtil.GetController(self.m_talentTrs, "name")
	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	self.beacon_id_list = self.polyhedronInfo:GetBeaconList()

	for iter_11_0 = 1, #self.beacon_id_list do
		self.beaconList[iter_11_0] = self.beaconList[iter_11_0] or PolyhedronSetBeaconItem.New(self.m_beaconTemplate, self.m_beaconContentTrs)

		self.beaconList[iter_11_0]:SetData(self.beacon_id_list[iter_11_0])
	end

	for iter_11_1 = #self.beacon_id_list + 1, #self.beaconList do
		self.beaconList[iter_11_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_beaconContentTrs)

	if #self.beacon_id_list > 0 then
		SetActive(self.m_beaconEmpty, false)
	else
		SetActive(self.m_beaconEmpty, true)
	end

	self.artifactGroupList = {}

	self:RefreshArtifact()

	self.terminalGroupList = {}
	self.terminal_id_list = self.polyhedronInfo:GetTerminalIdList()
	self.terminal_group_data = {}

	for iter_11_2, iter_11_3 in ipairs(self.terminal_id_list) do
		self.terminal_group_data[PolyhedronTerminalCfg[iter_11_3].classify] = self.terminal_group_data[PolyhedronTerminalCfg[iter_11_3].classify] or {}

		table.insert(self.terminal_group_data[PolyhedronTerminalCfg[iter_11_3].classify], iter_11_3)
	end

	local var_11_0 = 1

	for iter_11_4, iter_11_5 in pairs(self.terminal_group_data) do
		self.terminalGroupList[var_11_0] = self.terminalGroupList[var_11_0] or PolyhedronSetTerminalGroup.New((Object.Instantiate(self.m_termianlGroup, self.m_termianlContent)))

		self.terminalGroupList[var_11_0]:SetActive(true)
		self.terminalGroupList[var_11_0]:SetData(iter_11_4, iter_11_5)
		self.terminalGroupList[var_11_0]:RegistCallBack(self.clickTerminalHandler_)

		var_11_0 = var_11_0 + 1
	end

	for iter_11_6 = var_11_0, #self.terminalGroupList do
		self.terminalGroupList[iter_11_6]:SetActive(false)
	end

	if table.length(self.terminal_group_data) > 0 then
		SetActive(self.m_terminalEmpty, false)
	else
		SetActive(self.m_terminalEmpty, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)

	self.data = clone(PolyhedronData:GetTerminalGift())
	self.allPoint = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point

	local var_11_1 = PolyhedronData:GetTerminalLevel()
	local var_11_2 = PolyhedronData:GetTerminalExp()

	self.m_levelLab.text = "" .. var_11_1

	if var_11_1 == #PolyhedronTerminalLevelCfg.all then
		self.m_expSlider.value = 1
		self.m_expLab.text = PolyhedronTerminalLevelCfg[var_11_1].exp - PolyhedronTerminalLevelCfg[var_11_1 - 1].exp .. "/" .. PolyhedronTerminalLevelCfg[var_11_1].exp - PolyhedronTerminalLevelCfg[var_11_1 - 1].exp
	else
		self.m_expSlider.value = var_11_2 / (PolyhedronTerminalLevelCfg[var_11_1 + 1].exp - PolyhedronTerminalLevelCfg[var_11_1].exp)
		self.m_expLab.text = var_11_2 .. "/" .. PolyhedronTerminalLevelCfg[var_11_1 + 1].exp - PolyhedronTerminalLevelCfg[var_11_1].exp
	end

	self.m_pointLab.text = self.allPoint - self:GetUsePoint()
	self.clickhandler = handler(self, self.PopInfo)

	self:Select(1)
end

function PolyhedronAdditionSettingView:OnEnter()
	SetActive(self.m_terminalDescGo, false)

	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	self:RefreshArtifact()
end

function PolyhedronAdditionSettingView:RefreshArtifact()
	self.artifact_list = self.polyhedronInfo:GetArtifactList()
	self.artifact_group_data = {}

	for iter_13_0, iter_13_1 in ipairs(self.artifact_list) do
		self.artifact_group_data[PolyhedronArtifactCfg[iter_13_1.id].sub_type] = self.artifact_group_data[PolyhedronArtifactCfg[iter_13_1.id].sub_type] or {}

		table.insert(self.artifact_group_data[PolyhedronArtifactCfg[iter_13_1.id].sub_type], iter_13_1)
	end

	local var_13_0 = table.keys(self.artifact_group_data)

	table.sort(var_13_0, PolyhedronTools.ArtifactSubTypeSorter)

	local var_13_1 = 1

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		self.artifactGroupList[var_13_1] = self.artifactGroupList[var_13_1] or PolyhedronSetArtifactGroup.New((Object.Instantiate(self.m_artifactGroup, self.m_artifactContent)))

		self.artifactGroupList[var_13_1]:SetActive(true)
		self.artifactGroupList[var_13_1]:SetData(iter_13_3, self.artifact_group_data[iter_13_3])
		self.artifactGroupList[var_13_1]:RegistCallBack(self.clickhandler)

		var_13_1 = var_13_1 + 1
	end

	for iter_13_4 = var_13_1, #self.artifactGroupList do
		self.artifactGroupList[iter_13_4]:SetActive(false)
	end

	if table.length(self.artifact_group_data) > 0 then
		SetActive(self.m_artifactEmpty, false)
	else
		SetActive(self.m_artifactEmpty, true)
	end

	self:RebuildArtifactLayout()
end

function PolyhedronAdditionSettingView:RebuildArtifactLayout()
	if self.artifactRebuildTimer_ then
		self.artifactRebuildTimer_:Stop()

		self.artifactRebuildTimer_ = nil
	end

	self.artifactRebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_artifactContent)

		if self.artifactRebuildTimer_ then
			self.artifactRebuildTimer_:Stop()

			self.artifactRebuildTimer_ = nil
		end
	end, 1, 1)

	self.artifactRebuildTimer_:Start()
end

function PolyhedronAdditionSettingView:GetUsePoint()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self.data) do
		var_16_0 = var_16_0 + PolyhedronTerminalCfg[iter_16_1].cost
	end

	return var_16_0
end

function PolyhedronAdditionSettingView:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.artifactGroupList) do
		iter_17_1:Dispose()
	end

	self.artifactGroupList = nil

	for iter_17_2, iter_17_3 in ipairs(self.terminalGroupList) do
		iter_17_3:Dispose()
	end

	self.terminalGroupList = nil

	for iter_17_4, iter_17_5 in ipairs(self.beaconList) do
		iter_17_5:Dispose()
	end

	self.beaconList = nil

	if self.artifactRebuildTimer_ then
		self.artifactRebuildTimer_:Stop()

		self.artifactRebuildTimer_ = nil
	end

	PolyhedronAdditionSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return PolyhedronAdditionSettingView
