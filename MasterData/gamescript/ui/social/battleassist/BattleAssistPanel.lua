local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local AssistAwakerSortType = CommonDefine.AssistAwakerSortType
local SortOrder = CommonDefine.SortOrder
local AssistSortType2LangDict = {
  [AssistAwakerSortType.Level] = LT.Text("AssistAwakerSortTypeAwakerLevel"),
  [AssistAwakerSortType.PotencyLv] = LT.Text("AssistAwakerSortTypeAwakerPotency"),
  [AssistAwakerSortType.Skill] = LT.Text("AssistAwakerSortTypeAwakerSkill"),
  [AssistAwakerSortType.TalentLv] = LT.Text("AssistAwakerSortTypeAwakerTalentLv"),
  [AssistAwakerSortType.WeaponPotency] = LT.Text("AssistAwakerSortTypeWeaponPotency"),
  [AssistAwakerSortType.TrinketCompletion] = LT.Text("AssistAwakerSortTypeTrinketCompletion")
}
local BattleAssistPanel, Super = System.NewClass("BattleAssistPanel", UIBasePanel)
BattleAssistPanel.uiResCls = UI_Social_Panel_HelpListResource

function BattleAssistPanel:ctor(teamModel)
  Super.ctor(self)
  self.teamModel = teamModel
  self.InCD = Vue.ref(false)
  self.loadSeverDataTime = Vue.ref(true)
  self._isReqing = Vue.ref(true)
end

function BattleAssistPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(BattleAssistModel, self.teamModel)
  SocialDataUtils.isFirstReqParams = nil
  AssistFilterModel.Instance:RefreshOnPanelOpen()
  self:BindCloseBtn()
  self:BindTab()
  self:BindAssistBtn()
  self:BindContent()
  self:BindRefreshBtn()
  self:BindTipsBtn()
  self:BindFilterBtn()
  self:BindCommonlyAssistBtn()
  binder:BindEvent(EventMgr.Instance.QueryAssistAwaker, System.fn(self, self._OnQueryAssistAwaker))
end

function BattleAssistPanel:_OnQueryAssistAwaker()
  self._isReqing.value = true
end

function BattleAssistPanel:BindTipsBtn()
  self.binder:BindZ1Button(self.ui.Btn_Role, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("AwakerAssistRuleTitle"), LT.Text("AwakerAssistRule"))
  end)
end

function BattleAssistPanel:BindFilterBtn()
  self.binder:BindZ1Button(self.ui.Btn_Filter, function()
    UIManager.Instance:Reopen(Urls.AssistFilterListView, function()
      self:RefreshCallback()
    end)
  end)
  self.binder:SetActive(self.ui.Group_Inquire, true)
  self.binder:BindToText(self.ui.Text_Trinket_SortType_1, function()
    return AssistSortType2LangDict[self.model.sortType]
  end)
  self.binder:BindToZ1Toggle(self.ui.Btn_Trinket_Level, nil, System.fn(self, self._OnClickToggleTrinketLevel))
  self.binder:BindToZ1Toggle(self.ui.Btn_Trinket_Litre, nil, System.fn(self, self._OnClickToggleTrinketLitre))
end

function BattleAssistPanel:_OnClickToggleTrinketLitre(isOn)
  local targetSortOrder = self.model.sortOrder == SortOrder.Descend and SortOrder.Ascend or SortOrder.Descend
  self.model:SetSortOrder(targetSortOrder)
  self:_ReqRefreshAssistList()
end

function BattleAssistPanel:_OnClickToggleTrinketLevel(isOn)
  UIManager.Instance:Reopen(Urls.BagCommonFilterListView, self.ui.UI_Common_Filter_List_Filter.transform.position, self.model.sortType, {
    {
      type = AssistAwakerSortType.Level,
      name = AssistSortType2LangDict[AssistAwakerSortType.Level]
    },
    {
      type = AssistAwakerSortType.PotencyLv,
      name = AssistSortType2LangDict[AssistAwakerSortType.PotencyLv]
    },
    {
      type = AssistAwakerSortType.Skill,
      name = AssistSortType2LangDict[AssistAwakerSortType.Skill]
    },
    {
      type = AssistAwakerSortType.TalentLv,
      name = AssistSortType2LangDict[AssistAwakerSortType.TalentLv]
    },
    {
      type = AssistAwakerSortType.WeaponPotency,
      name = AssistSortType2LangDict[AssistAwakerSortType.WeaponPotency]
    },
    {
      type = AssistAwakerSortType.TrinketCompletion,
      name = AssistSortType2LangDict[AssistAwakerSortType.TrinketCompletion]
    }
  }, function(sortType)
    self.model:SetSortType(sortType)
    self:_ReqRefreshAssistList()
  end)
end

function BattleAssistPanel:_ResetSortOrder()
  SocialDataUtils.SetAssetAwakerCount(0)
  self.binder:SetZ1Toggle(self.ui.Btn_Trinket_Litre, true, true)
  self.model:SetSortOrder(CommonDefine.SortOrder.Descend)
end

function BattleAssistPanel:BindAssistBtn()
  AssistFilterModel.Instance:ResetSelect()
  self.binder:BindZ1Button(self.ui.Btn_On, function()
    local btnState, inFight, schoolBan = self:AssistBtnState()
    if btnState == CommonDefine.BtnType.High then
      self.model:SetAssistAwaker2Team()
      self:Close()
    elseif not inFight and schoolBan then
      Alert.Show(10752)
    end
  end, function()
    do return self.AssistBtnState end
    return self.AssistBtnState, self
  end)
end

function BattleAssistPanel:AssistBtnState()
  local awakerId = self.model:CurSelectAssistAwakerId()
  local awakerCfg = DT.AwakerConfig[awakerId]
  local inFight, schoolBan
  if awakerCfg then
    local schoolId = awakerCfg.School
    inFight = false
    schoolBan = self.model:SchoolBan(schoolId)
    if not inFight and not schoolBan then
      return CommonDefine.BtnType.High
    end
  end
  return CommonDefine.BtnType.Unclickable, inFight, schoolBan
end

function BattleAssistPanel:RefreshCall()
  local list = self:_GetAssistList()
  self.loadSeverDataTime.value = false
  if #list <= 0 then
    self:CallAddFuncList()
  else
    self:ReloadTableView()
  end
  local IsFliter = AssistFilterModel.Instance:IsFliterAssistAwaker()
  local buttonState = IsFliter and CommonDefine.BtnType.High or CommonDefine.BtnType.Normal
  self.binder:SetButtonState(self.ui.Btn_Filter, buttonState)
  self.binder:SetText(self.ui.Text_Fliter_Type, IsFliter and LT.Text("AwakerHasColletion") or LT.Text("AwakerColletion"))
end

function BattleAssistPanel:ReloadTableView()
  if self.creationTableview then
    self:InitTickCnt()
    self.creationTableview:ReloadData()
  end
end

function BattleAssistPanel:BindRefreshBtn()
  local textComp = self.binder:GetTextComp(self.ui.Text_C_Confim_Nor_1)
  self.refreshText = textComp.text
  self.binder:BindZ1Button(self.ui.Btn_Refresh, function()
    if self.timer then
      return
    end
    local tick = DT.GetConstant("AwakerAssistRefreshInterval")
    textComp.text = tick
    self.InCD.value = true
    self.model:ClearAssistList()
    self:RefreshCall()
    self:_ResetSortOrder()
    self:_ReqRefreshAssistList()
    if self.scrollView == nil then
      self.scrollView = self.ui.ScrollView_PlayerItem:GetComponentInParent(T_ScrollRect)
    end
    self.scrollView.verticalNormalizedPosition = 1
    self.timer = self.binder:BindTimer(1, tick + 1, function()
      tick = tick - 1
      if tick >= 0 then
        textComp.text = tick
      else
        textComp.text = self.refreshText
        self.timer = nil
        self.InCD.value = false
      end
    end)
  end, function()
    if self.InCD.value == false then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end)
end

function BattleAssistPanel:RefreshCallback()
  self.binder:SetZ1Toggle(self.ui.Toggle_All, true, true)
  self:ToggleFunc(0, true)
  if self.scrollView == nil then
    self.scrollView = self.ui.ScrollView_PlayerItem:GetComponentInParent(T_ScrollRect)
  end
  self.scrollView.verticalNormalizedPosition = 1
end

function BattleAssistPanel:BindCloseBtn()
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    SocialDataUtils.isFirstReqParams = nil
    self:Close()
  end))
end

function BattleAssistPanel:BindCommonlyAssistBtn()
  self.binder:BindButtonClick(self.ui.Btn_CommonlyAssist, function()
    SocialDataUtils.OpenAssistStarPanel(self.model)
  end)
end

function BattleAssistPanel:_ReqRefreshAssistList()
  self.loadSeverDataTime.value = true
  local curSchool = self.model:GetCurSchoolId()
  local awakerfilter = AssistFilterModel.Instance:GetAwakerMapFilter()
  local params = {
    stageTid = self.model.stageId,
    awakerMap = AssistFilterModel.Instance:GetAwakerFilterMap(awakerfilter),
    school = curSchool,
    sortType = self.model.sortType,
    awakerMapFilter = awakerfilter
  }
  self.funcMap = SocialDataUtils.QueryAllAssistAwaker(params, self.model.sortOrder, function(serverData, startIdx, endIdx)
    self._isReqing.value = false
    self.model:AddAssistList(serverData, startIdx, endIdx)
    self:RefreshCall()
  end)
end

function BattleAssistPanel:CallAddFuncList(index)
  if self.funcMap and self.funcMap[index] then
    self.funcMap[index]()
    self.funcMap[index] = nil
  end
end

function BattleAssistPanel:InitTickCnt()
  self.curIdx = 0
end

function BattleAssistPanel:BindContent()
  self.binder:BindToVisible(self.ui.Group_Null_Black, function()
    if self._isReqing.value then
      return false
    end
    local list = self:_GetAssistList()
    return #list <= 0 and not self.loadSeverDataTime.value
  end)
  self:InitTickCnt()
  local sizeDelta = self.ui.UI_Social_Panel_HelpList_Item.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.cbinderMap = {}
  self.creationTableview = self:CreateTableview(self.ui.ScrollView_PlayerItem, function()
    return #self:_GetAssistList()
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Social_Panel_HelpList_Item)
    local cbinder = self.cbinderMap[cell.gameObject]
    if cbinder then
      cbinder:teardown()
    end
    cbinder = self.binder:createChild(cell.gameObject)
    self.cbinderMap[cell.gameObject] = cbinder
    self:_UpdateBattleAssistItem(cbinder, cell.gameObject, index)
    return cell
  end, function()
    return w, h
  end)
  self.creationTableview:ReloadData()
  self.loadSeverDataTime.value = false
end

function BattleAssistPanel:_UpdateBattleAssistItem(childBinder, go, index)
  local list = self:_GetAssistList()
  local data = list[index]
  self:CallAddFuncList(index)
  local itemUI = UI_Social_Panel_HelpList_ItemResource(go)
  local weaponUIs = {
    UI_Dungeons_Item_WeaponResource(itemUI.UI_Dungeons_Item_Weapon_1),
    UI_Dungeons_Item_WeaponResource(itemUI.UI_Dungeons_Item_Weapon_2)
  }
  childBinder:BindComponent(BattleAssistItem(itemUI, self.model, data, weaponUIs))
end

function BattleAssistPanel:_GetAssistList()
  do return self.model.GetAssistList end
  return self.model.GetAssistList, self.model
end

function BattleAssistPanel:BindTab()
  local binder = self.binder
  local curSchoolId = self.model:GetCurSchoolId()
  local list = DT.GetOriginalConstant("AwakerTalent_TabList")
  local uiList = {
    {
      uiNode = self.ui.Toggle_All,
      schoolId = list[1]
    },
    {
      uiNode = self.ui.Toggle_Hundun,
      schoolId = list[2]
    },
    {
      uiNode = self.ui.Toggle_Shenhai,
      schoolId = list[3]
    },
    {
      uiNode = self.ui.Toggle_Xuerou,
      schoolId = list[4]
    },
    {
      uiNode = self.ui.Toggle_Chaowei,
      schoolId = list[5]
    }
  }
  for i, itemData in pairs(uiList) do
    local schoolId = itemData.schoolId
    local uiNode = itemData.uiNode
    local onToggle = System.bind(self.ToggleFunc, self, schoolId)
    binder:BindToZ1Toggle(uiNode, nil, onToggle)
    binder:SetZ1Toggle(uiNode, schoolId == curSchoolId)
  end
end

function BattleAssistPanel:ToggleFunc(schoolId, isOn)
  if not isOn then
    return
  end
  self.model:SetCurSchoolId(schoolId)
  self.model:ClearAssistList()
  self:_ResetSortOrder()
  self:_ReqRefreshAssistList()
  self:ReloadTableView()
end

function BattleAssistPanel:OnUnbind()
  if self.childrenBinders then
    for _, v in pairs(self.childrenBinders) do
      v:teardown()
    end
    self.childrenBinders = nil
    self.uiMap = nil
  end
  ItemDataUtils.CloseHandleMockDataLock(Urls.BattleAssistPanel)
  AwakerDataUtils.CloseHandleMockDataLock(Urls.BattleAssistPanel)
  ItemDataUtils.ResetMockItemData()
  AwakerDataUtils.ResetMockAwakerMap()
  Super.OnUnbind(self)
end

return BattleAssistPanel
