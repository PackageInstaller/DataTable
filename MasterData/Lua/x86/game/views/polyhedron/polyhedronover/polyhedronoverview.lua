local polyhedronOverView = class("polyhedronOverView", ReduxView)

function polyhedronOverView:UIName()
	return "Widget/System/Polyhedron/PolyhedronOverUI"
end

function polyhedronOverView:UIBackCount()
	return 2
end

function polyhedronOverView:UIParent()
	return manager.ui.uiMain.transform
end

function polyhedronOverView:Init()
	self:InitUI()
	self:AddUIListener()

	self.heroList = LuaList.New(handler(self, self.IndexHeroItem), self.m_heroList, PolyhedronOverHeroItem)
	self.difficultyList = LuaList.New(handler(self, self.IndexDifficultyItem), self.m_affixList, PolyhedronOverDifficultyItem)
	self.beaconList = LuaList.New(handler(self, self.IndexBeaconItem), self.m_beaconList, PolyhedronOverBeaconItem)
	self.artifactGroupList = {}
end

function polyhedronOverView:InitUI()
	self:BindCfgUI()

	self.clickhandler = handler(self, self.PopInfo)
	self.clickLefthandler = handler(self, self.PopInfoLeft)
end

function polyhedronOverView:AddUIListener()
	self:AddBtnListener(self.m_closeBtn, nil, function()
		PolyhedronAction.QueryPolyhedronReset()
	end)
	self:AddBtnListener(self.m_statisticsBtn, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsPolyhdronOver")
	end)
	self:AddBtnListener(self.m_infoMask, nil, function()
		SetActive(self.m_infoGo, false)
	end)
end

function polyhedronOverView:OnTop()
	return
end

function polyhedronOverView:OnEnter()
	SetActive(self.m_infoGo, false)

	self.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	self.polyhedronSettlement = PolyhedronData:GetPolyhedronSettlement()

	if self.polyhedronSettlement then
		self.m_policyExpLab.text = self.polyhedronSettlement.decision_exp or -1
	end

	if self.polyhedronSettlement then
		self.m_terminalExpLab.text = self.polyhedronSettlement.terminal_exp or -1
	end

	if self.polyhedronSettlement then
		self.m_rankScoreText.text = self.polyhedronSettlement.point or -1
	end

	self.m_difficultyLab.text = self.polyhedronInfo:GetDifficulty()

	local var_11_0 = PolyhedronTierCfg[self.polyhedronInfo:GetTierId()]

	self.m_tierLab.text = var_11_0.tier .. "-" .. var_11_0.level
	self.fight_hero_id_list = self.polyhedronInfo:GetFightHeroList()

	self.heroList:StartScroll(#self.fight_hero_id_list)

	self.beacon_id_list = self.polyhedronInfo:GetBeaconList()

	self.beaconList:StartScroll(#self.beacon_id_list)

	if #self.beacon_id_list == 0 then
		SetActive(self.m_beaconText_, false)
	else
		SetActive(self.m_beaconText_, true)
	end

	self.difficulty = self.polyhedronInfo:GetDifficulty()

	local var_11_1 = {}

	PolyhedronTools.CalPolyhedronDifficultyAttr(var_11_1, self.difficulty)

	self.difficultyEffectList = {}

	for iter_11_0, iter_11_1 in pairs((PolyhedronTools.GetPolyhedronDifficultyAffixDir(self.difficulty))) do
		table.insert(self.difficultyEffectList, {
			up_type = 1,
			data = iter_11_1
		})
	end

	for iter_11_2, iter_11_3 in pairs(var_11_1) do
		table.insert(self.difficultyEffectList, {
			up_type = 2,
			data = {
				iter_11_2,
				iter_11_3
			}
		})
	end

	self.difficultyList:StartScroll(#self.difficultyEffectList)

	self.artifact_list = self.polyhedronInfo:GetArtifactList()
	self.artifact_group_data = {}

	for iter_11_4, iter_11_5 in ipairs(self.artifact_list) do
		self.artifact_group_data[PolyhedronArtifactCfg[iter_11_5.id].sub_type] = self.artifact_group_data[PolyhedronArtifactCfg[iter_11_5.id].sub_type] or {}

		table.insert(self.artifact_group_data[PolyhedronArtifactCfg[iter_11_5.id].sub_type], iter_11_5)
	end

	local var_11_2 = table.keys(self.artifact_group_data)

	table.sort(var_11_2, PolyhedronTools.ArtifactSubTypeSorter)

	local var_11_3 = 1

	for iter_11_6, iter_11_7 in ipairs(var_11_2) do
		self.artifactGroupList[var_11_3] = self.artifactGroupList[var_11_3] or PolyhedronOverArtifactGroup.New((Object.Instantiate(self.m_artifactGroup, self.m_artifactContent)))

		self.artifactGroupList[var_11_3]:SetActive(true)
		self.artifactGroupList[var_11_3]:SetData(iter_11_7, self.artifact_group_data[iter_11_7])
		self.artifactGroupList[var_11_3]:RegistCallBack(self.clickhandler)

		var_11_3 = var_11_3 + 1
	end

	for iter_11_8 = var_11_3, #self.artifactGroupList do
		self.artifactGroupList[iter_11_8]:SetActive(false)
	end

	TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_artifactContent)
	end, {})
end

function polyhedronOverView:OnExit()
	return
end

function polyhedronOverView:Dispose()
	self.heroList:Dispose()
	self.difficultyList:Dispose()
	self.beaconList:Dispose()

	for iter_14_0, iter_14_1 in ipairs(self.artifactGroupList) do
		iter_14_1:Dispose()
	end

	self.artifactGroupList = nil

	polyhedronOverView.super.Dispose(self)
end

function polyhedronOverView:IndexHeroItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.polyhedronInfo, self.fight_hero_id_list[arg_15_1])
	arg_15_2:RegistCallBack(self.clickLefthandler)
end

function polyhedronOverView:IndexDifficultyItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.difficultyEffectList[arg_16_1].up_type, self.difficultyEffectList[arg_16_1].data)
	arg_16_2:RegistCallBack(self.clickhandler)
end

function polyhedronOverView:IndexBeaconItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.beacon_id_list[arg_17_1])
	arg_17_2:RegistCallBack(self.clickhandler)
end

function polyhedronOverView:PopInfo(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	SetActive(self.m_infoGo, true)

	self.m_name.text = GetI18NText(arg_18_1)
	self.m_desc.text = GetI18NText(arg_18_2)
	self.m_levelText.text = arg_18_4 and "Lv" .. arg_18_4 or ""

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)

	local var_18_0 = self.m_infoParent:InverseTransformPoint((self.m_rightAdaptTrans_:TransformPoint((Vector3(-self.m_rightAdaptTrans_.rect.width, self.m_rightAdaptTrans_:InverseTransformPoint(arg_18_3).y, 0)))))
	local var_18_1 = self.m_infoParent:InverseTransformPoint((self.m_bottom:TransformPoint(Vector3(0, 0, 0))))

	self.m_infoTrans.localPosition = Vector3(var_18_0.x, var_18_0.y + ((self.m_infoParent.rect.height / 2 < -var_18_1.y or nil) and -var_18_1.y - self.m_infoParent.rect.height / 2), var_18_0.z)
end

function polyhedronOverView:PopInfoLeft(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	SetActive(self.m_infoGo, true)

	self.m_name.text = GetI18NText(arg_19_1)
	self.m_desc.text = GetI18NText(arg_19_2)
	self.m_levelText.text = arg_19_4 and "Lv" .. arg_19_4 or ""

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)

	local var_19_0 = self.m_infoParent:InverseTransformPoint((self.m_leftTrans:TransformPoint((Vector3(self.m_leftTrans.rect.width + self.m_infoTrans.rect.width, self.m_leftTrans:InverseTransformPoint(arg_19_3).y, 0)))))

	self.m_infoTrans.localPosition = var_19_0

	local var_19_1 = self.m_infoParent:InverseTransformPoint((self.m_bottom:TransformPoint(Vector3(0, 0, 0))))

	self.m_infoTrans.localPosition = Vector3(var_19_0.x, var_19_0.y + ((self.m_infoParent.rect.height / 2 < -var_19_1.y or nil) and -var_19_1.y - self.m_infoParent.rect.height / 2), var_19_0.z)
end

return polyhedronOverView
