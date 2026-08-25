local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local CommonConceptCom, Super = NewViewComponent("CommonConceptCom")

function CommonConceptCom:ctor(uiNode, view, list)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_ComprehensiveResource(uiNode)
  self.list = list
  self.searchStr = ""
  self.showList = {}
end

function CommonConceptCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:UpdateToturialScroll()
end

function CommonConceptCom:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectCommonConcept, self.UpdateSelect, self)
end

function CommonConceptCom:RegisterEvents()
  self:AddInputValueChangeListener(self.ui.InputField_Course, System.fn(self, self._OnInputValueChanged))
  self:AddButtonClickListener(self.ui.Btn_Search, System.fn(self, self.UpdateToturialScroll))
end

function CommonConceptCom:_OnInputValueChanged(text)
  self:SetInputText(self.ui.InputField_Course, text)
  self.searchStr = text
end

function CommonConceptCom:UpdateSelect(selectCfgId)
  self:UpdateShow(selectCfgId)
  self:ResetDescribe()
  self.curSelectId = selectCfgId
end

function CommonConceptCom:ResetDescribe()
  if not self.scrollView_Describe then
    self.scrollView_Describe = self.ui.ScrollView:GetComponentInParent(T_ScrollRect)
  end
  self.scrollView_Describe.verticalNormalizedPosition = 1
end

function CommonConceptCom:ReGetCollectIdList()
  table.clear(self.showList)
  for _, cfgId in ipairs(self.list) do
    local unlock = ArtCollectionController.Instance:IsUnlock(cfgId)
    local cfg = DT.CollectionHall[cfgId]
    local emptySearch = self.searchStr == ""
    local searchMatch = unlock and StrUtils.SearchByKeyStr(self.searchStr, LT.Text(cfg.Title))
    local result = searchMatch or emptySearch
    if result then
      table.insert(self.showList, cfgId)
    end
  end
  self.curSelectId = self:GetFirstLock(self.showList)
end

function CommonConceptCom:UpdateShowResult()
  self.ui.Group_InputNum:SetActive(self.searchStr ~= "")
  if self.searchStr ~= "" then
    self:SetText(self.ui.Text_Result, LT.Textf("TutorialSearchResult", #self.showList))
  end
  if self.curSelectId ~= nil then
    self:UpdateShow(self.curSelectId)
  else
  end
end

function CommonConceptCom:UpdateToturialScroll()
  self:ReGetCollectIdList()
  self:UpdateShowResult()
  if self.tableView == nil then
    local cellRT = self.ui.UI_Collection_Panel_Main_Item:GetComponent(TYPEOF_RectTransform)
    local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
    self.tableView = self:CreateTableview(self.ui.ScrollView_Toturial_Item, function()
      return #self.showList
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Collection_Panel_Main_Item)
      local data = self.showList[index]
      self:AddViewComponentOnce(cell.gameObject, CommonConceptItem, data, self.curSelectId)
      return cell
    end, function()
      return width, height
    end)
  end
  self.tableView:ReloadData()
end

function CommonConceptCom:GetFirstLock(list)
  for _, cfgId in ipairs(list) do
    if ArtCollectionController.Instance:IsUnlock(cfgId) then
      return cfgId
    end
  end
end

function CommonConceptCom:UpdateShow(selectCfgId)
  local cfg = DT.CollectionHall[selectCfgId]
  local conCeptType = ArtCollectionController.Instance:GetCollectTypeByFeature(CommonDefine.FeatureId.CollectionStory, CommonDefine.WorldStorySubFeature.Concept)
  local showComprehensive = cfg.CollectionType == conCeptType and cfg.Picture ~= nil
  self.ui.Image_Comprehensive:SetActive(showComprehensive)
  local CollectionType = PlayerDataUtils.GetFeatureConfig(cfg.CollectionType).Feature
  self:SetImageAlpha(self.ui.Image_Figure_Bg, CollectionType == CommonDefine.FeatureId.CollectionCharacter and 0.33 or 1)
  self.ui.Image_Figure:SetActive(not showComprehensive and cfg.Picture)
  if showComprehensive then
    self:SetImage(self.ui.Image_CG, cfg.Picture)
    self.ui.Image_Comprehensive.transform:SetAsFirstSibling()
  else
    if nil == self.charCom then
      self.charCom = self:AddViewComponentOnce(self.ui.Container_Awaker_Half, ArtCollectRolePortrait, selectCfgId)
    else
      self.charCom:ResetPortrait(selectCfgId)
    end
    self.ui.Container_Awaker_Half.transform:SetAsFirstSibling()
  end
  self:SetText(self.ui.Text_Title, LT.Text(cfg.Title))
  self:UpdateDesc(selectCfgId)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
end

function CommonConceptCom:UpdateDesc(cfgId)
  self:ResetObj()
  local cfg = DT.CollectionHall[cfgId]
  local list = StrUtils.SplitTitleAndContent(LT.Text(cfg.Desc))
  for i = 1, #list do
    local data = list[i]
    local obj = self:GetCacheObj()
    self:AddViewComponentOnce(obj, CommonConceptDescItem, data)
    obj.transform:SetSiblingIndex(i + 1)
  end
end

function CommonConceptCom:ResetObj()
  if self.cacheObj == nil then
    self.cacheObj = {}
    self.usingObj = {}
  end
  for _, obj in ipairs(self.usingObj) do
    obj:SetActive(false)
    table.insert(self.cacheObj, obj)
  end
  table.clear(self.usingObj)
end

function CommonConceptCom:GetCacheObj()
  local obj = table.remove(self.cacheObj, 1)
  if nil == obj then
    obj = GameObject.Instantiate(self.ui.UI_Collection_Image_Describe, self.ui.Image.transform)
  end
  table.insert(self.usingObj, obj)
  obj:SetActive(true)
  return obj
end

return CommonConceptCom
