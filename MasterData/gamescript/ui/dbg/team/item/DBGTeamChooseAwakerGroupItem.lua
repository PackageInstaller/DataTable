local UI_Team_Popup_Awaker_ListResource = require("UI.UIPackages.UI_Team_Popup_Awaker_ListResource")
local System = require("System.System")
local CommonDefine = require("World.Enums.CommonDefine")
local DT = require("System.DataTable")
local LT = require("System.LangTable")
local tableInsert = table.insert
local Alert = require("System.Alert")
local Logger = require("Utility.Logger")
local AwakerDataUtils = require("Data.AwakerDataUtils")
local CommonFilterList = require("UI.Public.Item.CommonFilterList")
local AnimatorUtils = require("Animation.AnimatorUtils")
local UIBackCommandStack = require("Managers.UI.UIBackCommandStack")
local UIManager = require("Managers.UI.UIManager")
local Urls = require("Managers.UI.Urls")
local AwakerModel = require("Model.AwakerModel")
local AwakerAttrModel = require("Model.AwakerAttrModel")
local FuncJumpManager = require("Managers.FuncJumpManager")
local AwakerPage = CommonDefine.AwakerPage
local TeamAssign = CommonDefine.TeamAssign
local eStageTeamMode = TeamAssign.eStageTeamMode
local DBGTeamChooseAwakerGroupItem, Super = System.NewComponent("DBGTeamChooseAwakerGroupItem")

function DBGTeamChooseAwakerGroupItem:ctor(res, dbgTeamBuildModel, type, closeCb)
  Super.ctor(self)
  self.ui = UI_Team_Popup_Awaker_ListResource(res)
  self.model = dbgTeamBuildModel
  self.type = type
  self.closeCb = closeCb
  self:InitData()
  self._selectedIndex = Vue.ref(1)
  self.awakerItemMap = {}
end

function DBGTeamChooseAwakerGroupItem:InitData()
  self.model:SetCurBuildingAwakerTeam(table.clone(self.model.teamAwakerTids))
  local sortType = CommonDefine.AwakerSortType.Level
  self.model:SetSortType(sortType)
  self.model:SetSortOrder(CommonDefine.SortOrder.Descend)
end

function DBGTeamChooseAwakerGroupItem:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Select, System.fn(self, self.OnBtnConfirm), function()
    if self:IsChooseBuildType() then
      if 0 == self.model.curBuildingAwakerTeam[self.model.curAwakerSlot] then
        return CommonDefine.BtnType.Unclickable
      else
        return CommonDefine.BtnType.High
      end
    end
    return CommonDefine.BtnType.High
  end, function()
    local returnText = ""
    if self:IsChooseBuildType() then
      local curSelectTid = self.model.curBuildingAwakerTeam[self.model.curAwakerSlot]
      local curFightTid = self.model.teamAwakerTids[self.model.curAwakerSlot]
      if 0 == curFightTid then
        returnText = LT.Text("Formation_SelectRole_Sure_Btn2")
      elseif curSelectTid == curFightTid then
        returnText = LT.Text("Formation_SelectRole_Sure_Btn1")
      elseif curSelectTid ~= curFightTid then
        returnText = LT.Text("Formation_SelectRole_Sure_Btn3")
      end
    elseif self:IsQuickBuildType() then
      returnText = LT.Text("Formation_Fast_Sure_Btn")
    end
    return returnText
  end, nil, nil, nil)
  binder:BindToVisible(self.ui.Btn_Select, function()
    return not self.model:GetSingleChooseSpecialAwakerMode()
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self.model:SetCurBuildingAwakerTeam(table.clone(self.model.teamAwakerTids))
    UIBackCommandStack.Remove(tostring(self))
    self:OnClose()
  end)
  binder:BindToVisible(self.ui.Btn_Mask, function()
    do return self.IsQuickBuildType end
    return self.IsQuickBuildType, self
  end)
  binder:BindButtonClick(self.ui.Btn_Sort_Group_Mask, System.fn(self, self.OnClickSortType))
  binder:BindToVisible(self.ui.Btn_Sort_Group_Mask, function()
    return self.model.isShowSortTypePanel
  end)
  binder:BindButtonClick(self.ui.Btn_Battle, System.fn(self, self.OnClickSortType))
  binder:BindButtonClick(self.ui.Btn_Sort, System.fn(self, self.OnClickSortOrder))
  binder:BindToVisible(self.ui.Group_No_Awaker, function()
    return 0 == #self.model.showAwakerList
  end)
  binder:BindToText(self.ui.Txt_SkillLv, function()
    local awakerData = self.model:GetAwakerDataBySlot(self.model.curAwakerSlot)
    if not (awakerData and awakerData.tid) or 0 == awakerData.tid then
      return
    end
    if self.model:IsPresetFakeAwakerData(awakerData) then
      do return self.model.GetChoosePanelSkillLevelText, self.model end
      return self.model.GetChoosePanelSkillLevelText, self.model, awakerData, nil, nil, nil, nil, nil, nil
    end
    local skills = awakerData.skills
    if not skills or not skills[1] then
      return
    end
    if not AwakerDataUtils.HasOwnedAwaker(math.abs(awakerData.tid)) then
      return "<color=#C8C971><size=30>1</size></color>/1/1/1/1/1"
    end
    local skillLv = string.format("<color=#C8C971><size=30>%s</size></color>", skills[1].level)
    for i = 2, #skills do
      skillLv = skillLv .. "/" .. skills[i].level
    end
    return skillLv
  end)
  binder:BindToText(self.ui.Txt_Talent, function()
    local awakerData = self.model:GetAwakerDataBySlot(self.model.curAwakerSlot)
    return awakerData and TalentDataUtils.GetDisplayTalentLvDesc(awakerData.talents)
  end)
  binder:BindToText(self.ui.Text_Tips, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Nothing_Tips"
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Title_String"
  end)
  binder:SetZ1Toggle(self.ui.Toggle_All, true, true)
  self.model:SetCurSelectSchool(self.model.showAllSchool)
  local toggleName = {
    [1] = "Toggle_Hundun",
    [2] = "Toggle_Xuerou",
    [3] = "Toggle_Chaowei",
    [4] = "Toggle_Shenhai",
    [self.model.showAllSchool] = "Toggle_All"
  }
  for key, toggle in pairs(toggleName) do
    binder:BindToZ1Toggle(self.ui[toggle], nil, function(isOn)
      if isOn then
        self.model:SetCurSelectSchool(key)
      end
    end)
  end
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_List, function()
    return self.model.showAwakerList
  end, function(itemBinder, obj, index)
    local awakerData = self.model.showAwakerList[index]
    local tid = awakerData.tid
    self._selectedIndex.value = 1
    local awakerItem = itemBinder:BindComponent(DBGTeamChooseAwakerItem(obj, self.model, awakerData, function()
      self:OnClickAwaker(index)
    end, self.type))
    self.awakerItemMap[tid] = {awakerItem = awakerItem, index = index}
    if self.type == self.model.BuildTeamType.QuickBuild and 1 == index then
      itemBinder:BindTimer(0.1, 0, nil, function()
        NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_QuickBuildAwaker1", obj, Urls.DBGTeamBuildMainPanel)
      end)
    end
    itemBinder:onDestroy(function()
      NewbieGuideManager.Instance:UnregisterNewbieGo("GuideGo_QuickBuildAwaker" .. index)
    end)
  end)
  binder:BindToRaw(function(_, nVal, _)
    local curSlotAwakerTid = self.model.curBuildingAwakerTeam[self.model.curAwakerSlot]
    local curTeamAwakerTids = self.model.teamAwakerTids
    local awakerDataMap = self.model.awakerDataMap
    local fakeAwakerDatas = self.model.tFakeAwakerDatas
    local stageId = self.model.stageId
    local list
    if self:IsQuickBuildType() then
      list = TeamAssignDataUtils.GetQuickBuildAwakers(stageId, awakerDataMap, fakeAwakerDatas)
      TeamAssignDataUtils.FilterAwakerSchool(list, nVal, curTeamAwakerTids)
    else
      local slotIndex = self.model.curAwakerSlot
      list = TeamAssignDataUtils.GetSlotCanInputAwakers(stageId, slotIndex, awakerDataMap, fakeAwakerDatas)
      TeamAssignDataUtils.FilterAwakerSchool(list, nVal, {curSlotAwakerTid})
    end
    self.model:SetShowAwakerList(list)
    self:SortList()
  end, function()
    return self.model.curSelectSchool
  end)
  local commonFilterListData = {
    sortTypeList = self.model.sortTypeList,
    selectedFunc = function(sortType)
      return self.model.sortType == sortType
    end,
    callback = function(tid)
      if not tid then
        return
      end
      self.model:SetSortType(tid)
      self.model:EnableSortTypePanel(false)
    end
  }
  binder:BindComponent(CommonFilterList(self.ui.ScrollView_Sort_List, commonFilterListData))
  binder:BindToAnimator(self.ui.ScrollView_Sort_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      if not self.ui then
        return
      end
      binder:SetActive(self.ui.ScrollView_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.model.isShowSortTypePanel
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if nVal then
      if nVal == oVal then
        return
      end
      self:SortList()
    end
  end, function()
    return self.model.sortType
  end)
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    self:SortList()
  end, function()
    return self.model.sortOrder
  end)
  binder:BindToText(self.ui.Text_Battle, function()
    do return self.model.GetSortTypeName, self.model end
    return self.model.GetSortTypeName, self.model, self.model.sortType
  end)
  binder:BindToText(self.ui.Text_Sort, function()
    if self.model.sortOrder == CommonDefine.SortOrder.Descend then
      do return LT.Text end
      return LT.Text, "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, "ActorString_Sort_Ascend"
  end)
  UIBackCommandStack.Push({
    uiPanel = tostring(self),
    Execute = function()
      self:OnClose()
    end
  })
  self:_BindAwakerInfo(binder)
end

function DBGTeamChooseAwakerGroupItem:OnClickAwaker(index)
  self._selectedIndex.value = index
  local awakerData = self.model.showAwakerList[index]
  local clickedAwakerTid = awakerData.tid
  local isFakeAwaker = awakerData.isFakeAwaker
  if not clickedAwakerTid or 0 == clickedAwakerTid then
    return
  end
  if self.model:IsSpecialTeamAssignBan(clickedAwakerTid) then
    return
  end
  if self:IsQuickBuildType() then
    if NewbieGuideManager.Instance:IsInGuidePanel() then
      self:GuideActiveNextAwaker(clickedAwakerTid)
      return
    end
    self:OnQuickBuildClickAwaker(clickedAwakerTid, isFakeAwaker)
  elseif self:IsChooseBuildType() then
    self:OnChooseBuildClickAwaker(clickedAwakerTid, isFakeAwaker)
  end
end

function DBGTeamChooseAwakerGroupItem:GuideActiveNextAwaker(clickedAwakerTid)
  local awakerItemInfo = self.awakerItemMap[clickedAwakerTid]
  local isNeedChoose = true
  if awakerItemInfo.index <= 4 then
    for tid, info in pairs(self.awakerItemMap) do
      if info.index == awakerItemInfo.index + 1 then
        NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_QuickBuildAwaker" .. info.index, info.awakerItem.ui.uiNode, Urls.DBGTeamBuildMainPanel)
        break
      end
    end
    if self.model:QuickBuildCanSelect(clickedAwakerTid) then
      isNeedChoose = false
    end
  end
  if isNeedChoose then
    self:OnQuickBuildClickAwaker(clickedAwakerTid)
  end
  if 4 == awakerItemInfo.index and not self.model:QuickBuildCanSelect(0) then
    NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_QuickSaveBtn", self.ui.Btn_Select, Urls.DBGTeamBuildMainPanel)
    self.binder:onDestroy(function()
      NewbieGuideManager.Instance:UnregisterNewbieGo("GuideGo_QuickSaveBtn")
    end)
  end
end

function DBGTeamChooseAwakerGroupItem:OnQuickBuildClickAwaker(clickedAwakerTid)
  local changeFormTid = AwakerDataUtils.GetChangerForm(math.abs(clickedAwakerTid)) or 0
  if 0 ~= changeFormTid and self.model:IsAwakerInBuildingTeam(changeFormTid, true) then
    local awakerTeamData = self.model:GetAwakerDataByCfgId(changeFormTid)
    if not awakerTeamData.isFakeAwaker then
      self:UpdateBuildTeam(changeFormTid, self.model.BuildTeamOperate.Remove)
    end
  end
  local hasSelected = self.model:IsAwakerInBuildingTeam(clickedAwakerTid, false)
  if hasSelected then
    self:UpdateBuildTeam(clickedAwakerTid, self.model.BuildTeamOperate.Remove)
    return
  end
  local isHaveSameTidAwakwer = self.model:IsAwakerInBuildingTeam(clickedAwakerTid, true)
  if isHaveSameTidAwakwer then
    Alert.Show(20219)
    return
  end
  if self.model:IsSpecialTeamAssignBan(clickedAwakerTid) then
    Alert.Show(10575)
    return
  end
  if self.model:IsBanTid(clickedAwakerTid) then
    Alert.ShowWithParams(10757, {
      AwakerDataUtils.GetAwakerName(clickedAwakerTid)
    })
    return
  end
  local fightNum = self.model:GetFightAwakerNum(self.model.curBuildingAwakerTeam)
  local containAwaker = self.model:IsAwakerInBuildingTeam(clickedAwakerTid, true)
  if fightNum >= self.model.MaxBattleNum and not containAwaker then
    Alert.Show(10526)
    return
  end
  if self.model:IsInSpecialTeamForbids(clickedAwakerTid) then
    Alert.Show(10727)
    return
  end
  if self.model:IsWrongCareer(clickedAwakerTid) then
    local tipId = 10524
    local tipConfig = DT.TipsType[tipId]
    local curSchoolId = self.model:GetCurEnableSchoolId()
    if not curSchoolId then
      return
    end
    local schoolCfg = DT.SchoolConfig[curSchoolId]
    local curEffectSchoolName = LT.Text(schoolCfg.Name)
    Alert.Show(tipId, nil, nil, nil, LT.Textf(tipConfig.Desc, curEffectSchoolName))
    return
  end
  local fightedMap = self.model:GetFightedStageGroupData()
  if fightedMap[clickedAwakerTid] then
    local awakerName = LT.Text(DT.AwakerConfig[clickedAwakerTid].Name)
    local stageGroupName = LT.Text(DT.StageGroup[fightedMap[clickedAwakerTid].stageGroupId].Name)
    local desc = DT.TipsType[10739].Desc
    Alert.ShowStr(LT.Textf(desc, awakerName, stageGroupName))
    return
  end
  if self.model:IsForbidden(clickedAwakerTid) then
    Alert.ShowStr(LT.Text("SchoolTowerTeamBuildFobiddenTips"))
    return
  end
  if self.model:GetFightAwakerNum(self.model.curBuildingAwakerTeam) >= self.model.MaxBattleNum then
    return
  end
  self:UpdateBuildTeam(clickedAwakerTid, self.model.BuildTeamOperate.Add)
end

function DBGTeamChooseAwakerGroupItem:OnChooseBuildClickAwaker(clickedAwakerTid, isFakeAwaker)
  if self.model:InTeamAndNotCurSelect(clickedAwakerTid, isFakeAwaker) then
    self.model:SetCurBuildingAwakerTeam(table.clone(self.model.teamAwakerTids))
    self.model:SetUseConfigAwaker(self.model.curAwakerSlot, isFakeAwaker)
    local clickedAwakerSlot = self.model:GetSlotByTeamAwakerTids(clickedAwakerTid)
    local oldAwakerId = self.model:GetAwakerByTeamAwakerTids(self.model.curAwakerSlot)
    self:UpdateBuildTeam(clickedAwakerTid, self.model.BuildTeamOperate.Add, self.model.curAwakerSlot)
    self:RecordReplaceSlot(oldAwakerId, clickedAwakerSlot)
  else
    self:ClearReplacePos()
    local changeFormId = AwakerDataUtils.GetChangerForm(clickedAwakerTid)
    for slot, tid in pairs(self.model.curBuildingAwakerTeam) do
      if tid == clickedAwakerTid or tid == changeFormId then
        self:UpdateBuildTeam(0, self.model.BuildTeamOperate.Remove, slot)
        break
      end
    end
    self:UpdateBuildTeam(clickedAwakerTid, self.model.BuildTeamOperate.Add, self.model.curAwakerSlot)
  end
  self:UpdateBuildTeam(clickedAwakerTid, self.model.BuildTeamOperate.Add, self.model.curAwakerSlot)
end

function DBGTeamChooseAwakerGroupItem:_BindAwakerInfo(binder)
  local UI_Awaker_Item_Prop_DetailResource = require("UI.UIPackages.UI_Awaker_Item_Prop_DetailResource")
  local AwakerAttrItem = require("UI.Awaker.Item.AwakerAttrItem")
  binder:BindToVisible(self.ui.Image_Detail, function()
    return 0 ~= (self:GetCurSlotAwakerTid() or 0)
  end)
  binder:BindToText(self.ui.Text_Name_First, function()
    local tid = self:GetCurSlotAbsAwakerTid()
    if not tid or 0 == tid then
      return
    end
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, tid
  end)
  binder:BindToImage(self.ui.Image_Quality_Icon, function()
    local tid = self:GetCurSlotAbsAwakerTid()
    if not tid or 0 == tid then
      return
    end
    do return AwakerDataUtils.GetAwakerSchoolIcon end
    return AwakerDataUtils.GetAwakerSchoolIcon, tid
  end)
  binder:BindToText(self.ui.Text_Name_type, function()
    local tid = self:GetCurSlotAbsAwakerTid()
    do return AwakerDataUtils.GetAwakerType end
    return AwakerDataUtils.GetAwakerType, tid
  end)
  binder:BindToText(self.ui.Text_Level_Count, function()
    local awakerData = self.model:GetAwakerDataBySlot(self.model.curAwakerSlot)
    if not awakerData then
      return
    end
    local currLevel = awakerData.level
    local tid = self:GetCurSlotAbsAwakerTid()
    if AwakerDataUtils.HasOwnedAwaker(tid) then
      local currLevelLimit = AwakerDataUtils.GetAwakerCurrLevelLimit(awakerData)
      do return string.format, "%s/%s", currLevel end
      return string.format, "%s/%s", currLevel, currLevelLimit
    else
      return currLevel
    end
  end)
  binder:BindButtonClick(self.ui.Btn_More, function()
    local tid = self:GetCurSlotAwakerTid()
    if not tid or 0 == tid then
      return
    end
    local awakerData = self.model:GetAwakerDataByCfgId(tid)
    local copyAwakerData = table.clone(awakerData)
    copyAwakerData.tid = math.abs(tid)
    local awakerModel = binder:createModel(AwakerModel, {
      specialAwakerList = {copyAwakerData},
      selectAwakerId = math.abs(tid)
    })
    local attrModel = binder:createModel(AwakerAttrModel, awakerModel)
    UIManager.Instance:Reopen(Urls.AwakerFullAttrPanel, attrModel, AwakerPage.Detail, self.model)
  end)
  binder:BindButtonClick(self.ui.Btn_Detail, function()
    local function panelOpenFunc()
      local tid = self:GetCurSlotAwakerTid()
      
      if not tid or 0 == tid then
        return
      end
      if tid < 0 then
        local awakerData = table.clone(self.model:GetAwakerDataByCfgId(tid) or {})
        awakerData.tid = math.abs(awakerData.tid)
        local previewData = {
          items = {},
          awakers = {
            [tid] = awakerData
          },
          hideAwakerChangeForm = true
        }
        local awakerBasePanelData = {
          jumpPage = CommonDefine.AwakerPage.Detail,
          previewAwakersData = previewData
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      else
        local awakerBasePanelData = {}
        awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
        awakerBasePanelData.specialAwakerList = {
          AwakerDataUtils.GetAwakerData(tid)
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      end
    end
    
    FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
  end)
  binder:BindToRaw(function(childBinder, attrList)
    if not attrList then
      return
    end
    if not attrList or #attrList <= 0 then
      return
    end
    for i = 1, #attrList do
      local obj = self.ui["Prop_" .. i]
      if not obj then
      else
        local attr = attrList[i]
        local itemData = {clientAttr = attr, resourceCls = UI_Awaker_Item_Prop_DetailResource}
        childBinder:BindComponent(AwakerAttrItem(obj, itemData))
      end
    end
  end, function()
    return self.model.selectAwakerBaseAttrs
  end)
  self:_BindPotencyShow(binder)
  self:_BindAwakerFavor(binder)
end

function DBGTeamChooseAwakerGroupItem:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potencyLevel = potency}))
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
    if not awakerData then
      return
    end
    return {
      self:GetCurSlotAbsAwakerTid(),
      self:GetPotency()
    }
  end)
end

function DBGTeamChooseAwakerGroupItem:_BindAwakerFavor(binder)
  if not self.ui.Image_AwakerFavor then
    return
  end
  binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    local tid = self:GetCurSlotAbsAwakerTid()
    if not tid or 0 == tid then
      return false
    end
    local awakerData
    if self.model.curAwakerSlot == CommonDefine.TeamAssign.MaxBattleNum then
      awakerData = self.model:GetAssistAwaker()
    else
      awakerData = self.model:GetAwakerDataByCfgId(tid)
    end
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, tid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, tid, awakerData
  end)
end

function DBGTeamChooseAwakerGroupItem:GetPotency()
  local awakerData = self:GetAwakerData()
  if not awakerData or not table.next(awakerData) then
    return 0
  end
  if awakerData.potencyLevel then
    return awakerData.potencyLevel
  end
  if awakerData.potency then
    do return AwakerDataUtils.GetAwakerPotencyIndex, (math.abs(awakerData.tid)) end
    return AwakerDataUtils.GetAwakerPotencyIndex, math.abs(awakerData.tid), awakerData.potency
  end
  return 0
end

function DBGTeamChooseAwakerGroupItem:GetCurSlotAwakerTid()
  do return self.model.GetCurBuildingAwakerTeam, self.model end
  return self.model.GetCurBuildingAwakerTeam, self.model, self.model.curAwakerSlot
end

function DBGTeamChooseAwakerGroupItem:GetCurSlotAbsAwakerTid()
  local tid = self:GetCurSlotAwakerTid()
  return tid and math.abs(tid)
end

function DBGTeamChooseAwakerGroupItem:GetAwakerData()
  local tid = self:GetCurSlotAwakerTid()
  do return self.model.GetAwakerDataByCfgId, self.model end
  return self.model.GetAwakerDataByCfgId, self.model, tid
end

function DBGTeamChooseAwakerGroupItem:RecordReplaceSlot(oldAwakerId, clickedAwakerSlot)
  self.awakerReplacePos = true
  self.oldAwakerId = oldAwakerId
  self.clickedAwakerSlot = clickedAwakerSlot
end

function DBGTeamChooseAwakerGroupItem:AwakerReplacePos()
  self:UpdateBuildTeam(self.oldAwakerId, self.model.BuildTeamOperate.Add, self.clickedAwakerSlot)
  self:ClearReplacePos()
end

function DBGTeamChooseAwakerGroupItem:ClearReplacePos()
  self.awakerReplacePos = nil
  self.oldAwakerId = nil
  self.clickedAwakerSlot = nil
end

function DBGTeamChooseAwakerGroupItem:UpdateBuildTeam(awakerTid, operateType, index)
  if not self.model.curBuildingAwakerTeam then
    Logger.Info("没有队伍数据")
    return
  end
  index = index or TeamAssignDataUtils.GetAwakerSpecialSlot(self.model.stageId, awakerTid)
  if operateType == self.model.BuildTeamOperate.Add then
    if not index then
      for slot, tid in ipairs(self.model.curBuildingAwakerTeam) do
        if 0 == tid then
          self.model:SetCurBuildingAwakerTeamBySlot(awakerTid, slot)
          break
        end
      end
    else
      self.model:SetCurBuildingAwakerTeamBySlot(awakerTid, index)
    end
  elseif operateType == self.model.BuildTeamOperate.Remove then
    if not index then
      local curSelectTeam = table.clone(self.model.curBuildingAwakerTeam)
      for slot, teamAwakerTid in ipairs(curSelectTeam) do
        if awakerTid == teamAwakerTid then
          curSelectTeam[slot] = 0
          self.model:SetCurBuildingAwakerTeam(self:SortSelectTeam(curSelectTeam))
          break
        end
      end
    else
      self.model:SetCurBuildingAwakerTeamBySlot(0, index)
    end
  end
  local schoolTid = 0
  for _, value in ipairs(self.model.teamAwakerTids) do
    local cfg = DT.AwakerConfig[value]
    if cfg then
      if 1 == cfg.School and schoolTid < cfg.School then
        schoolTid = 1
      end
      if cfg.School > 1 then
        schoolTid = cfg.School
      end
    end
  end
  self.model:SetTeamSchoolTid(schoolTid)
end

function DBGTeamChooseAwakerGroupItem:SortList()
  if not self.model.showAwakerList or #self.model.showAwakerList <= 1 then
    return
  end
  local curBuildingAwakerWeightMap = {}
  local curBuildingAwakerTidList = {}
  for key, tid in pairs(self.model.curBuildingAwakerTeam) do
    if 0 == tid then
    else
      local changeFormId = AwakerDataUtils.GetChangerForm(tid)
      tableInsert(curBuildingAwakerTidList, tid)
      tableInsert(curBuildingAwakerTidList, changeFormId)
      curBuildingAwakerWeightMap[tid] = key * 2 - 1
      if changeFormId then
        curBuildingAwakerWeightMap[changeFormId] = key * 2
      end
      if self:IsChooseBuildType() and self.model.curBuildingAwakerTeam[self.model.curAwakerSlot] == tid then
        curBuildingAwakerWeightMap[tid] = -1
        if changeFormId then
          curBuildingAwakerWeightMap[changeFormId] = 0
        end
      end
    end
  end
  local curBuildingAwakerDataList = {}
  local notBuildingAwakerDataList = {}
  local notBuildingBanedAwakerDataList = {}
  for _, data in pairs(self.model.showAwakerList) do
    if table.contains(curBuildingAwakerTidList, data.tid) then
      tableInsert(curBuildingAwakerDataList, data)
    elseif self.model:IsForbidden(data.tid) then
      tableInsert(notBuildingBanedAwakerDataList, data)
    else
      tableInsert(notBuildingAwakerDataList, data)
    end
  end
  table.sort(curBuildingAwakerDataList, function(a, b)
    local aWeight = curBuildingAwakerWeightMap[a.tid] or 100
    local bWeight = curBuildingAwakerWeightMap[b.tid] or 100
    if aWeight ~= bWeight then
      return aWeight < bWeight
    end
    local forbidWeightA = self.model:IsForbidden(a.tid) and 0 or 1
    local forbidWeightB = self.model:IsForbidden(b.tid) and 0 or 1
    return forbidWeightA > forbidWeightB
  end)
  notBuildingAwakerDataList = AwakerDataUtils.Sort(notBuildingAwakerDataList, self.model.sortOrder, self.model.sortType)
  notBuildingBanedAwakerDataList = AwakerDataUtils.Sort(notBuildingBanedAwakerDataList, self.model.sortOrder, self.model.sortType)
  local rst = {}
  for _, data in ipairs(curBuildingAwakerDataList) do
    tableInsert(rst, data)
  end
  for _, data in ipairs(notBuildingAwakerDataList) do
    tableInsert(rst, data)
  end
  for _, data in ipairs(notBuildingBanedAwakerDataList) do
    tableInsert(rst, data)
  end
  self.model:SetShowAwakerList(rst)
end

function DBGTeamChooseAwakerGroupItem:OnBtnConfirm()
  if self.model.banClick then
    return
  end
  local isRefreshWeapon = false
  if self.awakerReplacePos then
    self:AwakerReplacePos()
    isRefreshWeapon = true
  end
  local loadTeamList = table.deepclone(self.model.curBuildingAwakerTeam)
  local fightTeamList = table.clone(self.model.teamAwakerTids)
  local lastPosAwakerId = fightTeamList[CommonDefine.TeamAssign.MaxBattleNum] or 0
  if self:IsChooseBuildType() then
    local curSelectTid = loadTeamList[self.model.curAwakerSlot]
    local curFightTid = fightTeamList[self.model.curAwakerSlot]
    if self.model:CheckChangerFormAwaker(table.clone(self.model.teamAwakerTids), self.model.curAwakerSlot, curSelectTid) then
      local tipId = 10761
      Alert.Show(tipId)
      return
    end
    if 0 == curSelectTid then
      Alert.Show(10525)
      return
    elseif curSelectTid == curFightTid then
      local awakerData = self.model:GetAwakerDataByCfgId(curSelectTid)
      if awakerData.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker then
        Alert.Show(20218)
        return
      end
      self.model:SetCurBuildingAwakerTeamBySlot(0, self.model.curAwakerSlot)
      loadTeamList[self.model.curAwakerSlot] = 0
      goto lbl_234
    end
    if self.model:IsSpecialTeamAssignBan(curSelectTid) then
      Alert.Show(10575)
      return
    end
    if self.model:IsInSpecialTeamForbids(curSelectTid) then
      Alert.Show(10727)
      return
    end
    if self.model:IsWrongCareer(curSelectTid) then
      local tipId = 10524
      local tipConfig = DT.TipsType[tipId]
      local curSchoolId = self.model:GetCurEnableSchoolId()
      if not curSchoolId then
        return
      end
      local schoolCfg = DT.SchoolConfig[curSchoolId]
      local curEffectSchoolName = LT.Text(schoolCfg.Name)
      Alert.Show(tipId, nil, nil, nil, LT.Textf(tipConfig.Desc, curEffectSchoolName))
      return
    end
    local fightedMap = self.model:GetFightedStageGroupData()
    if fightedMap[curSelectTid] then
      local awakerName = LT.Text(DT.AwakerConfig[curSelectTid].Name)
      local stageGroupName = LT.Text(DT.StageGroup[fightedMap[curSelectTid].stageGroupId].Name)
      local desc = DT.TipsType[10739].Desc
      Alert.ShowStr(LT.Textf(desc, awakerName, stageGroupName))
      return
    end
    if self.model:IsForbidden(curSelectTid) then
      Alert.ShowStr(LT.Text("SchoolTowerTeamBuildFobiddenTips"))
      return
    end
  end
  if self:IsQuickBuildType() and self:IsEmptyInCfgMustPos(loadTeamList) then
    Alert.Show(20218)
    return
  end
  if self:IsQuickBuildType() and self.model.teamMode == eStageTeamMode.Normal then
    local tmpList = table.deepclone(loadTeamList)
    table.sort(tmpList, function(a, b)
      local aWeight = 5
      local bWeight = 5
      for key, val in pairs(loadTeamList) do
        if a == val then
          aWeight = key
        end
        if b == val then
          bWeight = key
        end
      end
      if 0 == a then
        return false
      end
      if 0 == b then
        return true
      end
      return aWeight < bWeight
    end)
    loadTeamList = tmpList
    for i, vi in pairs(self.model.teamAwakerTids) do
      for j, vj in pairs(loadTeamList) do
        if i ~= j and vi == vj then
          isRefreshWeapon = true
          break
        end
      end
    end
  end
  ::lbl_234::
  if self:IsReplaycedCfgPreset(loadTeamList) then
    isRefreshWeapon = true
  end
  self.model:SetTeamAwakerTids(loadTeamList, isRefreshWeapon, isRefreshWeapon)
  for key, tid in pairs(loadTeamList) do
    if fightTeamList[key] ~= loadTeamList[key] then
      EventMgr.Instance.OnClickFightAwakerItem:Dispatch()
    end
  end
  local assistAwakerId = self.model:GetAssistAwakerId()
  local changerFormId = AwakerDataUtils.GetChangerForm(assistAwakerId)
  if 0 ~= assistAwakerId then
    for key, tid in pairs(loadTeamList) do
      if 0 ~= tid and (tid == assistAwakerId or tid == changerFormId) then
        self.model:SetAssistData(nil)
        break
      end
    end
  end
  local newlastPosAwakerId = loadTeamList[CommonDefine.TeamAssign.MaxBattleNum] or 0
  if lastPosAwakerId ~= newlastPosAwakerId then
    self.model:SetAssistData(nil)
  end
  self:OnClose()
end

function DBGTeamChooseAwakerGroupItem:IsReplaycedCfgPreset(loadTeamList)
  for i, tid in ipairs(loadTeamList) do
    tid = tid or 0
    if tid > 0 then
      local cfgPresetAwaker = self.model:GetAwakerDataByCfgId(tid * -1)
      if cfgPresetAwaker then
        return true
      end
    elseif tid < 0 then
      return true
    end
  end
end

function DBGTeamChooseAwakerGroupItem:IsEmptyInCfgMustPos(buidingAwakers)
  for slot, tid in ipairs(buidingAwakers) do
    local slotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(self.model.stageId, slot)
    if slotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker and 0 == tid then
      return true
    end
  end
end

function DBGTeamChooseAwakerGroupItem:OnClickSortType()
  if self.model.isShowSortTypePanel == true then
    self.model:EnableSortTypePanel(false)
  else
    self.model:EnableSortTypePanel(true)
    self.binder:SetActive(self.ui.ScrollView_Sort_List, true)
  end
end

function DBGTeamChooseAwakerGroupItem:OnClickSortOrder()
  if self.model.sortOrder == CommonDefine.SortOrder.Descend then
    self.model:SetSortOrder(CommonDefine.SortOrder.Ascend)
  else
    self.model:SetSortOrder(CommonDefine.SortOrder.Descend)
  end
end

function DBGTeamChooseAwakerGroupItem:IsQuickBuildType()
  return self.type == self.model.BuildTeamType.QuickBuild
end

function DBGTeamChooseAwakerGroupItem:IsChooseBuildType()
  return self.type == self.model.BuildTeamType.ChooseBuild
end

function DBGTeamChooseAwakerGroupItem:IsSpceialTeamMode()
  return self.model.teamMode == eStageTeamMode.Special
end

function DBGTeamChooseAwakerGroupItem:OnClose()
  self.model:EnableSortTypePanel(false)
  if self:IsQuickBuildType() then
    self.model:EnableQuickBuildPanel(false)
    self.model:SetPage(CommonDefine.DBGTeamBuildPage.Main)
    NewbieGuideManager.Instance:UnregisterNewbiePanel("GuidePanel_QuickTeamBuild")
  end
  if self.closeCb then
    self.closeCb()
  end
end

function DBGTeamChooseAwakerGroupItem:SortSelectTeam(teamList)
  local returnList = {
    0,
    0,
    0,
    0
  }
  local idx = 1
  for _, val in pairs(teamList) do
    if 0 ~= val then
      returnList[idx] = val
      idx = idx + 1
    end
  end
  return returnList
end

function DBGTeamChooseAwakerGroupItem:OnUnbind()
  Super.OnUnbind(self)
  UIBackCommandStack.Remove(tostring(self))
end

return DBGTeamChooseAwakerGroupItem
