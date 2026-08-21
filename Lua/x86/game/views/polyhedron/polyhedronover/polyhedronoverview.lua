local var_0_0 = class("polyhedronOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronOverUI"
end

function var_0_0.UIBackCount(arg_2_0)
	return 2
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.heroList = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.m_heroList, PolyhedronOverHeroItem)
	arg_4_0.difficultyList = LuaList.New(handler(arg_4_0, arg_4_0.IndexDifficultyItem), arg_4_0.m_affixList, PolyhedronOverDifficultyItem)
	arg_4_0.beaconList = LuaList.New(handler(arg_4_0, arg_4_0.IndexBeaconItem), arg_4_0.m_beaconList, PolyhedronOverBeaconItem)
	arg_4_0.artifactGroupList = {}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.clickhandler = handler(arg_5_0, arg_5_0.PopInfo)
	arg_5_0.clickLefthandler = handler(arg_5_0, arg_5_0.PopInfoLeft)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_closeBtn, nil, function()
		PolyhedronAction.QueryPolyhedronReset()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_statisticsBtn, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsPolyhdronOver")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_infoMask, nil, function()
		SetActive(arg_6_0.m_infoGo, false)
	end)
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	SetActive(arg_11_0.m_infoGo, false)

	arg_11_0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	arg_11_0.polyhedronSettlement = PolyhedronData:GetPolyhedronSettlement()
	arg_11_0.m_policyExpLab.text = arg_11_0.polyhedronSettlement and arg_11_0.polyhedronSettlement.decision_exp or -1
	arg_11_0.m_terminalExpLab.text = arg_11_0.polyhedronSettlement and arg_11_0.polyhedronSettlement.terminal_exp or -1
	arg_11_0.m_rankScoreText.text = arg_11_0.polyhedronSettlement and arg_11_0.polyhedronSettlement.point or -1
	arg_11_0.m_difficultyLab.text = arg_11_0.polyhedronInfo:GetDifficulty()

	local var_11_0 = arg_11_0.polyhedronInfo:GetTierId()
	local var_11_1 = PolyhedronTierCfg[var_11_0]

	arg_11_0.m_tierLab.text = var_11_1.tier .. "-" .. var_11_1.level
	arg_11_0.fight_hero_id_list = arg_11_0.polyhedronInfo:GetFightHeroList()

	arg_11_0.heroList:StartScroll(#arg_11_0.fight_hero_id_list)

	arg_11_0.beacon_id_list = arg_11_0.polyhedronInfo:GetBeaconList()

	arg_11_0.beaconList:StartScroll(#arg_11_0.beacon_id_list)

	if #arg_11_0.beacon_id_list == 0 then
		SetActive(arg_11_0.m_beaconText_, false)
	else
		SetActive(arg_11_0.m_beaconText_, true)
	end

	arg_11_0.difficulty = arg_11_0.polyhedronInfo:GetDifficulty()

	local var_11_2 = PolyhedronTools.GetPolyhedronDifficultyAffixDir(arg_11_0.difficulty)
	local var_11_3 = {}

	PolyhedronTools.CalPolyhedronDifficultyAttr(var_11_3, arg_11_0.difficulty)

	arg_11_0.difficultyEffectList = {}

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		table.insert(arg_11_0.difficultyEffectList, {
			up_type = 1,
			data = iter_11_1
		})
	end

	for iter_11_2, iter_11_3 in pairs(var_11_3) do
		table.insert(arg_11_0.difficultyEffectList, {
			up_type = 2,
			data = {
				iter_11_2,
				iter_11_3
			}
		})
	end

	arg_11_0.difficultyList:StartScroll(#arg_11_0.difficultyEffectList)

	arg_11_0.artifact_list = arg_11_0.polyhedronInfo:GetArtifactList()
	arg_11_0.artifact_group_data = {}

	for iter_11_4, iter_11_5 in ipairs(arg_11_0.artifact_list) do
		local var_11_4 = iter_11_5.id
		local var_11_5 = PolyhedronArtifactCfg[var_11_4]

		if not arg_11_0.artifact_group_data[var_11_5.sub_type] then
			arg_11_0.artifact_group_data[var_11_5.sub_type] = {}
		end

		table.insert(arg_11_0.artifact_group_data[var_11_5.sub_type], iter_11_5)
	end

	local var_11_6 = table.keys(arg_11_0.artifact_group_data)

	table.sort(var_11_6, PolyhedronTools.ArtifactSubTypeSorter)

	local var_11_7 = 1

	for iter_11_6, iter_11_7 in ipairs(var_11_6) do
		local var_11_8 = arg_11_0.artifact_group_data[iter_11_7]

		if not arg_11_0.artifactGroupList[var_11_7] then
			local var_11_9 = Object.Instantiate(arg_11_0.m_artifactGroup, arg_11_0.m_artifactContent)

			arg_11_0.artifactGroupList[var_11_7] = PolyhedronOverArtifactGroup.New(var_11_9)
		end

		arg_11_0.artifactGroupList[var_11_7]:SetActive(true)
		arg_11_0.artifactGroupList[var_11_7]:SetData(iter_11_7, var_11_8)
		arg_11_0.artifactGroupList[var_11_7]:RegistCallBack(arg_11_0.clickhandler)

		var_11_7 = var_11_7 + 1
	end

	local var_11_10 = #arg_11_0.artifactGroupList

	for iter_11_8 = var_11_7, var_11_10 do
		arg_11_0.artifactGroupList[iter_11_8]:SetActive(false)
	end

	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_artifactContent)
	end, {})
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.heroList:Dispose()
	arg_14_0.difficultyList:Dispose()
	arg_14_0.beaconList:Dispose()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.artifactGroupList) do
		iter_14_1:Dispose()
	end

	arg_14_0.artifactGroupList = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.IndexHeroItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.fight_hero_id_list[arg_15_1]

	arg_15_2:SetData(arg_15_0.polyhedronInfo, var_15_0)
	arg_15_2:RegistCallBack(arg_15_0.clickLefthandler)
end

function var_0_0.IndexDifficultyItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.difficultyEffectList[arg_16_1]

	arg_16_2:SetData(var_16_0.up_type, var_16_0.data)
	arg_16_2:RegistCallBack(arg_16_0.clickhandler)
end

function var_0_0.IndexBeaconItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.beacon_id_list[arg_17_1]

	arg_17_2:SetData(var_17_0)
	arg_17_2:RegistCallBack(arg_17_0.clickhandler)
end

function var_0_0.PopInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	SetActive(arg_18_0.m_infoGo, true)

	arg_18_0.m_name.text = GetI18NText(arg_18_1)
	arg_18_0.m_desc.text = GetI18NText(arg_18_2)

	if arg_18_4 then
		arg_18_0.m_levelText.text = "Lv" .. arg_18_4
	else
		arg_18_0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.m_contentTrs)

	local var_18_0 = arg_18_0.m_rightAdaptTrans_:InverseTransformPoint(arg_18_3)
	local var_18_1 = arg_18_0.m_rightAdaptTrans_.rect.width
	local var_18_2 = Vector3(-var_18_1, var_18_0.y, 0)
	local var_18_3 = arg_18_0.m_rightAdaptTrans_:TransformPoint(var_18_2)
	local var_18_4 = arg_18_0.m_infoParent:InverseTransformPoint(var_18_3)
	local var_18_5 = arg_18_0.m_bottom:TransformPoint(Vector3(0, 0, 0))
	local var_18_6 = arg_18_0.m_infoParent:InverseTransformPoint(var_18_5)
	local var_18_7 = arg_18_0.m_infoParent.rect.height / 2
	local var_18_8 = 0

	if var_18_7 < -var_18_6.y then
		var_18_8 = -var_18_6.y - var_18_7
	end

	arg_18_0.m_infoTrans.localPosition = Vector3(var_18_4.x, var_18_4.y + var_18_8, var_18_4.z)
end

function var_0_0.PopInfoLeft(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	SetActive(arg_19_0.m_infoGo, true)

	arg_19_0.m_name.text = GetI18NText(arg_19_1)
	arg_19_0.m_desc.text = GetI18NText(arg_19_2)

	if arg_19_4 then
		arg_19_0.m_levelText.text = "Lv" .. arg_19_4
	else
		arg_19_0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.m_contentTrs)

	local var_19_0 = arg_19_0.m_leftTrans:InverseTransformPoint(arg_19_3)
	local var_19_1 = arg_19_0.m_leftTrans.rect.width
	local var_19_2 = arg_19_0.m_infoTrans.rect.width
	local var_19_3 = Vector3(var_19_1 + var_19_2, var_19_0.y, 0)
	local var_19_4 = arg_19_0.m_leftTrans:TransformPoint(var_19_3)
	local var_19_5 = arg_19_0.m_infoParent:InverseTransformPoint(var_19_4)

	arg_19_0.m_infoTrans.localPosition = var_19_5

	local var_19_6 = arg_19_0.m_bottom:TransformPoint(Vector3(0, 0, 0))
	local var_19_7 = arg_19_0.m_infoParent:InverseTransformPoint(var_19_6)
	local var_19_8 = arg_19_0.m_infoParent.rect.height / 2
	local var_19_9 = 0

	if var_19_8 < -var_19_7.y then
		var_19_9 = -var_19_7.y - var_19_8
	end

	arg_19_0.m_infoTrans.localPosition = Vector3(var_19_5.x, var_19_5.y + var_19_9, var_19_5.z)
end

return var_0_0
