local var_0_0 = class("PolyhedronAdditionSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.stageData = arg_2_3

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0.clickTerminalHandler_ = handler(arg_3_0, arg_3_0.PopInfo)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_beaconTrs, function()
		arg_4_0:Select(3)
		SetActive(arg_4_0.m_terminalDescGo, false)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_artifaceTrs, function()
		arg_4_0:Select(1)
		SetActive(arg_4_0.m_terminalDescGo, false)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_talentTrs, function()
		arg_4_0:Select(2)
		SetActive(arg_4_0.m_terminalDescGo, false)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_infoMask, nil, function()
		SetActive(arg_4_0.m_terminalDescGo, false)
	end)
end

function var_0_0.PopInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	SetActive(arg_9_0.m_terminalDescGo, true)

	arg_9_0.m_terminalDescTrans.position = arg_9_3
	arg_9_0.m_terminalDescTitle.text = GetI18NText(arg_9_1)
	arg_9_0.m_terminalDesc.text = GetI18NText(arg_9_2)
end

function var_0_0.Select(arg_10_0, arg_10_1)
	arg_10_0.toggleController_1:SetSelectedIndex(arg_10_1 == 1 and 1 or 0)
	arg_10_0.toggleController_2:SetSelectedIndex(arg_10_1 == 2 and 1 or 0)
	arg_10_0.toggleController_3:SetSelectedIndex(arg_10_1 == 3 and 1 or 0)

	if arg_10_1 == 1 then
		arg_10_0:RefreshArtifact()
	end
end

function var_0_0.InitUI(arg_11_0)
	arg_11_0:BindCfgUI()

	arg_11_0.beaconList = {}
	arg_11_0.toggleController_3 = ControllerUtil.GetController(arg_11_0.m_beaconTrs, "name")
	arg_11_0.toggleController_1 = ControllerUtil.GetController(arg_11_0.m_artifaceTrs, "name")
	arg_11_0.toggleController_2 = ControllerUtil.GetController(arg_11_0.m_talentTrs, "name")
	arg_11_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	arg_11_0.beacon_id_list = arg_11_0.polyhedronInfo:GetBeaconList()

	local var_11_0 = #arg_11_0.beacon_id_list

	for iter_11_0 = 1, var_11_0 do
		if not arg_11_0.beaconList[iter_11_0] then
			arg_11_0.beaconList[iter_11_0] = PolyhedronSetBeaconItem.New(arg_11_0.m_beaconTemplate, arg_11_0.m_beaconContentTrs)
		end

		arg_11_0.beaconList[iter_11_0]:SetData(arg_11_0.beacon_id_list[iter_11_0])
	end

	for iter_11_1 = var_11_0 + 1, #arg_11_0.beaconList do
		arg_11_0.beaconList[iter_11_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_beaconContentTrs)

	if var_11_0 > 0 then
		SetActive(arg_11_0.m_beaconEmpty, false)
	else
		SetActive(arg_11_0.m_beaconEmpty, true)
	end

	arg_11_0.artifactGroupList = {}

	arg_11_0:RefreshArtifact()

	arg_11_0.terminalGroupList = {}
	arg_11_0.terminal_id_list = arg_11_0.polyhedronInfo:GetTerminalIdList()
	arg_11_0.terminal_group_data = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.terminal_id_list) do
		local var_11_1 = PolyhedronTerminalCfg[iter_11_3]

		if not arg_11_0.terminal_group_data[var_11_1.classify] then
			arg_11_0.terminal_group_data[var_11_1.classify] = {}
		end

		table.insert(arg_11_0.terminal_group_data[var_11_1.classify], iter_11_3)
	end

	local var_11_2 = 1

	for iter_11_4, iter_11_5 in pairs(arg_11_0.terminal_group_data) do
		if not arg_11_0.terminalGroupList[var_11_2] then
			local var_11_3 = Object.Instantiate(arg_11_0.m_termianlGroup, arg_11_0.m_termianlContent)

			arg_11_0.terminalGroupList[var_11_2] = PolyhedronSetTerminalGroup.New(var_11_3)
		end

		arg_11_0.terminalGroupList[var_11_2]:SetActive(true)
		arg_11_0.terminalGroupList[var_11_2]:SetData(iter_11_4, iter_11_5)
		arg_11_0.terminalGroupList[var_11_2]:RegistCallBack(arg_11_0.clickTerminalHandler_)

		var_11_2 = var_11_2 + 1
	end

	local var_11_4 = #arg_11_0.terminalGroupList

	for iter_11_6 = var_11_2, var_11_4 do
		arg_11_0.terminalGroupList[iter_11_6]:SetActive(false)
	end

	if table.length(arg_11_0.terminal_group_data) > 0 then
		SetActive(arg_11_0.m_terminalEmpty, false)
	else
		SetActive(arg_11_0.m_terminalEmpty, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.transform_)

	arg_11_0.data = clone(PolyhedronData:GetTerminalGift())

	local var_11_5 = PolyhedronData:GetTerminalLevel()

	arg_11_0.allPoint = PolyhedronTerminalLevelCfg[var_11_5].point

	local var_11_6 = PolyhedronData:GetTerminalLevel()
	local var_11_7 = PolyhedronData:GetTerminalExp()

	arg_11_0.m_levelLab.text = "" .. var_11_6

	if var_11_6 == #PolyhedronTerminalLevelCfg.all then
		arg_11_0.m_expSlider.value = 1

		local var_11_8 = PolyhedronTerminalLevelCfg[var_11_6].exp - PolyhedronTerminalLevelCfg[var_11_6 - 1].exp

		arg_11_0.m_expLab.text = var_11_8 .. "/" .. var_11_8
	else
		local var_11_9 = PolyhedronTerminalLevelCfg[var_11_6 + 1].exp - PolyhedronTerminalLevelCfg[var_11_6].exp

		arg_11_0.m_expSlider.value = var_11_7 / var_11_9
		arg_11_0.m_expLab.text = var_11_7 .. "/" .. var_11_9
	end

	local var_11_10 = arg_11_0.allPoint - arg_11_0:GetUsePoint()

	arg_11_0.m_pointLab.text = var_11_10
	arg_11_0.clickhandler = handler(arg_11_0, arg_11_0.PopInfo)

	arg_11_0:Select(1)
end

function var_0_0.OnEnter(arg_12_0)
	SetActive(arg_12_0.m_terminalDescGo, false)

	arg_12_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	arg_12_0:RefreshArtifact()
end

function var_0_0.RefreshArtifact(arg_13_0)
	arg_13_0.artifact_list = arg_13_0.polyhedronInfo:GetArtifactList()
	arg_13_0.artifact_group_data = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.artifact_list) do
		local var_13_0 = iter_13_1.id
		local var_13_1 = PolyhedronArtifactCfg[var_13_0]

		if not arg_13_0.artifact_group_data[var_13_1.sub_type] then
			arg_13_0.artifact_group_data[var_13_1.sub_type] = {}
		end

		table.insert(arg_13_0.artifact_group_data[var_13_1.sub_type], iter_13_1)
	end

	local var_13_2 = table.keys(arg_13_0.artifact_group_data)

	table.sort(var_13_2, PolyhedronTools.ArtifactSubTypeSorter)

	local var_13_3 = 1

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		local var_13_4 = arg_13_0.artifact_group_data[iter_13_3]

		if not arg_13_0.artifactGroupList[var_13_3] then
			local var_13_5 = Object.Instantiate(arg_13_0.m_artifactGroup, arg_13_0.m_artifactContent)

			arg_13_0.artifactGroupList[var_13_3] = PolyhedronSetArtifactGroup.New(var_13_5)
		end

		arg_13_0.artifactGroupList[var_13_3]:SetActive(true)
		arg_13_0.artifactGroupList[var_13_3]:SetData(iter_13_3, var_13_4)
		arg_13_0.artifactGroupList[var_13_3]:RegistCallBack(arg_13_0.clickhandler)

		var_13_3 = var_13_3 + 1
	end

	local var_13_6 = #arg_13_0.artifactGroupList

	for iter_13_4 = var_13_3, var_13_6 do
		arg_13_0.artifactGroupList[iter_13_4]:SetActive(false)
	end

	if table.length(arg_13_0.artifact_group_data) > 0 then
		SetActive(arg_13_0.m_artifactEmpty, false)
	else
		SetActive(arg_13_0.m_artifactEmpty, true)
	end

	arg_13_0:RebuildArtifactLayout()
end

function var_0_0.RebuildArtifactLayout(arg_14_0)
	if arg_14_0.artifactRebuildTimer_ then
		arg_14_0.artifactRebuildTimer_:Stop()

		arg_14_0.artifactRebuildTimer_ = nil
	end

	arg_14_0.artifactRebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.m_artifactContent)

		if arg_14_0.artifactRebuildTimer_ then
			arg_14_0.artifactRebuildTimer_:Stop()

			arg_14_0.artifactRebuildTimer_ = nil
		end
	end, 1, 1)

	arg_14_0.artifactRebuildTimer_:Start()
end

function var_0_0.GetUsePoint(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.data) do
		var_16_0 = var_16_0 + PolyhedronTerminalCfg[iter_16_1].cost
	end

	return var_16_0
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.artifactGroupList) do
		iter_17_1:Dispose()
	end

	arg_17_0.artifactGroupList = nil

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.terminalGroupList) do
		iter_17_3:Dispose()
	end

	arg_17_0.terminalGroupList = nil

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.beaconList) do
		iter_17_5:Dispose()
	end

	arg_17_0.beaconList = nil

	if arg_17_0.artifactRebuildTimer_ then
		arg_17_0.artifactRebuildTimer_:Stop()

		arg_17_0.artifactRebuildTimer_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)

	arg_17_0.transform_ = nil
	arg_17_0.gameObject_ = nil
end

return var_0_0
