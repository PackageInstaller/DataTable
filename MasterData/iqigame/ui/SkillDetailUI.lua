-- chunkname: @IQIGame\\UI\\SkillDetailUI.lua

local SkillTipsContent = {
	BreachDetailObjList = {},
	PersonDetailObjList = {},
	ConditionObjList = {}
}

function SkillTipsContent.New(view, closeFun)
	local obj = Clone(m)

	obj:Init(view, closeFun)

	return obj
end

function SkillTipsContent:Init(view, closeFun)
	self.closeFunc = closeFun
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, self.BreachDetailParent.transform.childCount do
		table.insert(self.BreachDetailObjList, self.BreachDetailParent.transform:GetChild(i - 1).gameObject)
	end

	for i = 1, self.PersonDetailParent.transform.childCount do
		table.insert(self.PersonDetailObjList, self.PersonDetailParent.transform:GetChild(i - 1).gameObject)
	end

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	for i = 1, self.ConditionBox.transform.childCount do
		table.insert(self.ConditionObjList, self.ConditionBox.transform:GetChild(i - 1).gameObject)
	end

	function self.DelegateStrengthBtn()
		self:OnStrengthBtnClick()
	end

	function self.DelegateReplaceBtn()
		self:OnReplaceBtnClick()
	end

	self:AddListeners()
	UGUIUtil.SetText(self.LvTitle, RoleDevelopmentApi:GetLvFormat(""))
end

function SkillTipsContent:AddListeners()
	self.StrengthenBtn:GetComponent("Button").onClick:AddListener(self.DelegateStrengthBtn)
	self.ReplaceBtn:GetComponent("Button").onClick:AddListener(self.DelegateReplaceBtn)
end

function SkillTipsContent:RemoveListeners()
	self.StrengthenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateStrengthBtn)
	self.ReplaceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateReplaceBtn)
end

function SkillTipsContent:SetData(data, warlockData, isSelfSkill)
	self.Skilldata = data
	self.warlockData = warlockData
	self.isSelfSkill = isSelfSkill or isSelfSkill ~= nil

	self.StrengthenBtn:SetActive(self.isSelfSkill)
	self.ReplaceBtn:SetActive(self.isSelfSkill)

	self.isDiy = self.Skilldata:GetCfg().IsDiy

	if warlockData ~= nil then
		self:SetBreachDesc()
		self:SetPersonDesc()
	end

	self:SetSkillInfo()
end

function SkillTipsContent:SetBreachDesc()
	self.BreachDetailParent:SetActive(self.isDiy)
	self.BreachDetailText:SetActive(self.isDiy)

	if self.isDiy == false then
		return
	end

	local breachCfgList = self.Skilldata.skillCfgsByStrengLv

	self.BreachDetailText:SetActive(not (#breachCfgList <= 0))

	local desc = ""

	for i = 1, #self.BreachDetailObjList do
		self.BreachDetailObjList[i]:SetActive(not (i > #breachCfgList))

		if i <= #breachCfgList then
			desc = self.Skilldata:GetSkillStrengthCfg(breachCfgList[i].StrengthenId).Describe

			UGUIUtil.SetText(self.BreachDetailObjList[i], RoleDevelopmentApi:GetSkillAttrColor(desc, i > self.Skilldata.strengLv))
		end
	end
end

function SkillTipsContent:SetPersonDesc()
	self.PersonDetailParent:SetActive(false)
	self.PersonDetailText:SetActive(false)

	if self.isDiy == true then
		return
	end

	for i = 1, #self.PersonDetailObjList do
		self.PersonDetailObjList[i]:SetActive(false)
	end

	local desc = ""
	local tempindex = 0
	local PersonlityList, index = WarlockModule.GetCurPersonalityIndex(self.warlockData)

	for i = 1, #PersonlityList do
		if PersonlityList[i].config.SkillId == self.Skilldata.skillCid then
			self.PersonDetailText:SetActive(true)
			self.PersonDetailParent:SetActive(true)

			tempindex = tempindex + 1

			self.PersonDetailObjList[tempindex]:SetActive(true)

			desc = self.Skilldata:GetSkillStrengthCfg(PersonlityList[i].config.StrengthenId).Describe

			UGUIUtil.SetText(self.PersonDetailObjList[i], RoleDevelopmentApi:GetSkillAttrColor(desc, not PersonlityList[i].isOpen))
		end
	end
end

function SkillTipsContent:SetSkillRange()
	return
end

function SkillTipsContent:SetSkillInfo()
	self.StartParent:SetActive(self.isDiy)

	if self.isDiy then
		local starComponent = self.stars:GetComponent("SimpleStarComponent")

		starComponent:UpdateView(3, self.Skilldata.strengLv)
	end

	if self.isSelfSkill then
		self.ItemCell:SetItem(WarehouseModule.GetItemDataById(self.Skilldata.id))
	else
		local itemdata = ItemData.CreateByCIDAndNumber(self.Skilldata.itemCid, 0)

		self.ItemCell:SetItem(itemdata)
	end

	UGUIUtil.SetText(self.NameText, self.Skilldata:GetCfg().Name)
	UGUIUtil.SetText(self.Level, self.Skilldata.lv)
	UGUIUtil.SetTextsInChildren(self.SkillInfo_Type, self.Skilldata:GetSkillType())
	self.SkillInfo_Cost:SetActive(not (self.Skilldata.Cost <= 0))

	if self.Skilldata.Cost > 0 then
		UGUIUtil.SetTextsInChildren(self.SkillInfo_Cost, RoleDevelopmentApi:GetSkillCostStr(self.Skilldata.Cost))
	end

	self.SkillInfo_Ap:SetActive(not (self.Skilldata.AP <= 0))

	if self.Skilldata.AP > 0 then
		UGUIUtil.SetTextsInChildren(self.SkillInfo_Ap, self.Skilldata.AP)
	end

	self.ReplaceBtn:SetActive(self.isDiy)
	UGUIUtil.SetText(self.SkillDesText, RoleDevelopmentApi:GetSkillDescValue(self.Skilldata:GetUpgradeDescribe()))
	self:GetSkillCondition()
end

function SkillTipsContent:GetSkillCondition()
	self.ConditionDataList = {}
	self.ConditionDataList[Constant.SkillConditionType.PROFRESSION] = {}
	self.ConditionDataList[Constant.SkillConditionType.ELEMENT] = {}
	self.ConditionDataList[Constant.SkillConditionType.POWER] = {}

	local conditionCfg = self.Skilldata:GetCfg()

	for i = 1, #conditionCfg.ProfessionLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.PROFRESSION], {
			conditionCfg.ProfessionLimit[i],
			conditionCfg.ProfessionLimit[i] == self.HeroProfession
		})
	end

	for i = 1, #conditionCfg.ElementLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.ELEMENT], {
			conditionCfg.ElementLimit[i],
			conditionCfg.ElementLimit[i] == self.HeroElements
		})
	end

	for i = 1, #conditionCfg.ForceLimit do
		table.insert(self.ConditionDataList[Constant.SkillConditionType.POWER], {
			conditionCfg.ForceLimit[i],
			conditionCfg.ForceLimit[i] == self.HeroPower
		})
	end

	self:SetElementCondition()
end

function SkillTipsContent:SetElementCondition()
	for i = 1, #self.ConditionObjList do
		self.ConditionObjList[i]:SetActive(false)
	end

	local length = 0

	for i = 1, #self.ConditionDataList do
		for j = 1, #self.ConditionDataList[i] do
			if self.ConditionDataList[i][j][1] ~= 0 then
				length = length + 1

				self.ConditionObjList[length]:SetActive(true)
				UGUIUtil.SetTextsInChildren(self.ConditionObjList[length], self:GetDictText(i, self.ConditionDataList[i][j][1]))
			end
		end
	end

	self.SkillLimitText:SetActive(length > 0)
	self.LimitConten:SetActive(length > 0)
end

function SkillTipsContent:GetDictText(groupID, id)
	if groupID == 1 then
		groupID = 7
	elseif groupID == 2 then
		groupID = 8
	elseif groupID == 3 then
		groupID = 9
	end

	for k, v in pairsCfg(CfgDictTable) do
		if v.GroupId == groupID and v.TypeId == id then
			return RoleDevelopmentApi:GetItemIipsDesc(v.TipsId)
		end
	end
end

function SkillTipsContent:OnStrengthBtnClick()
	UIModule.Open(Constant.UIControllerName.SkillStrengthenUI, Constant.UILayer.UI, self.Skilldata)
	self.closeFunc()
end

function SkillTipsContent:OnReplaceBtnClick()
	UIModule.Open(Constant.UIControllerName.SkillReplaceUI, Constant.UILayer.UI, {
		self.Skilldata,
		RoleDevelopmentModule.SelectSkillIndex
	})
	self.closeFunc()
end

function SkillTipsContent:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local SkillDetailUI = {}

SkillDetailUI = Base:Extend("SkillDetailUI", "IQIGame.Onigao.UI.SkillDetailUI", SkillDetailUI)

function SkillDetailUI:OnInit()
	LuaCodeInterface.BindOutlet(self.goBtnClose, self)

	function self.DelegateCloseBtnClick()
		self:OnCloseBtnClick()
	end

	self.SkillContent = SkillTipsContent.New(self.SkillTipsContent, function()
		self:OnCloseBtnClick()
	end)
end

function SkillDetailUI:GetPreloadAssetPaths()
	return nil
end

function SkillDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillDetailUI:IsManualShowOnOpen(userData)
	return false
end

function SkillDetailUI:GetBGM(userData)
	return nil
end

function SkillDetailUI:OnOpen(userData)
	RoleDevelopmentModule.SelectSkillIndex = userData[2]

	self.SkillContent:SetData(userData[1], userData[3], userData[4])
end

function SkillDetailUI:OnClose(userData)
	return
end

function SkillDetailUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtnClick)
end

function SkillDetailUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtnClick)
end

function SkillDetailUI:OnPause()
	return
end

function SkillDetailUI:OnResume()
	return
end

function SkillDetailUI:OnCover()
	return
end

function SkillDetailUI:OnReveal()
	return
end

function SkillDetailUI:OnRefocus(userData)
	return
end

function SkillDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goBtnClose, self)
end

function SkillDetailUI:OnCloseBtnClick()
	UIModule.CloseSelf(self)
end

return SkillDetailUI
