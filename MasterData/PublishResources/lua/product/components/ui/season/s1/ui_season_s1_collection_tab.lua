_class("UISeasonS1CollectionTab", UICustomWidget)
UISeasonS1CollectionTab = UISeasonS1CollectionTab

function UISeasonS1CollectionTab:OnShow(uiParams)
  self:InitWidget()
  self._firstItem = nil
end

function UISeasonS1CollectionTab:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.condition = self:GetUIComponent("UILocalizationText", "condition")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.des = self:GetUIComponent("UILocalizationText", "des")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._condition2 = self:GetUIComponent("UILocalizationText", "condition2")
  self._unlock = self:GetGameObject("Unlock")
  self._lock = self:GetGameObject("Lock")
  self._finalPlotEnterGo = self:GetGameObject("FinalPlotEnter")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS1CollectionTab:SetData(data)
  self._collageData = data
  self._seasonID = data:GetSeasonID()
  
  local function onClick(data)
    self:_OnSelect(data)
  end
  
  local count = self._collageData:GetCollectionCount()
  self._items = self.content:SpawnObjects("UISeasonS1CollageCollectionItem", count)
  for i = 1, count do
    local data = self._collageData:GetCollectionByIndex(i)
    self._items[i]:SetData(data, onClick)
    if not self._firstItem then
      self._firstItem = self._items[i]
    end
  end
  self._curSelectIdx = nil
  self:_OnSelect(self._collageData:GetCollectionByIndex(1))
end

function UISeasonS1CollectionTab:SetShow(show)
  self:GetGameObject():SetActive(show)
end

function UISeasonS1CollectionTab:_OnSelect(data)
  if self._curSelectIdx == data:Index() then
    return
  end
  if self._curSelectIdx then
    self._items[self._curSelectIdx]:SetSelect(false)
  end
  self._curSelectIdx = data:Index()
  local item = self._items[data:Index()]
  item:SetSelect(true)
  local cfgID = data:ID()
  local cfg = Cfg.cfg_item_season_collection[cfgID]
  if data:IsNew() then
    self._collageData:CollectionCancelNew(data)
    item:SetNew(false)
    self:DispatchEvent(GameEventType.UISeasonS1OnSelectCollageItem)
  end
  self.icon:LoadImage(cfg.HdImage)
  self._finalPlotEnterGo:SetActive(false)
  self._finalStoryID = nil
  if data:IsGot() then
    self.icon:SetColor(Color.white)
    local itemCfg = Cfg.cfg_item[cfgID]
    self.condition:SetText(StringTable.Get(cfg.RequireDesc))
    self.title:SetText(StringTable.Get(itemCfg.Name))
    self.des:SetText(StringTable.Get(itemCfg.Intro) .. "\n" .. StringTable.Get(itemCfg.RpIntro))
    local time = data:GetTime()
    self.time:SetText(StringTable.Get("str_season_require_time", TimeToDate(time)))
    self._unlock:SetActive(true)
    self._lock:SetActive(false)
    local composeQuestID = cfg.ComposeQuestID
    if composeQuestID then
      local finalStoryQuestId
      local seasonClientCfg = Cfg.cfg_season_campaign_client[self._seasonID]
      if seasonClientCfg then
        finalStoryQuestId = seasonClientCfg.FinalStoryQuestID
      end
      if finalStoryQuestId and finalStoryQuestId == composeQuestID then
        self._finalPlotEnterGo:SetActive(true)
        self._finalStoryID = cfg.ComposeStoryID
      end
    end
    self._anim:Stop()
    self._anim:Play("uieffanim_UISeasonS1CollectionTab_in2")
  else
    self.icon:SetColor(Color(0, 0, 0, 0.8))
    self._condition2:SetText(StringTable.Get(cfg.RequireDesc))
    self._unlock:SetActive(false)
    self._lock:SetActive(true)
    self._anim:Stop()
    self._anim:Play("uieffanim_UISeasonS1CollectionTab_middle")
  end
end

function UISeasonS1CollectionTab:FinalPlotEnterOnClick(go)
  if not self._finalStoryID then
    return
  end
  local cb
  UISeasonHelper.PlayStoryInSeasonScence(self._finalStoryID, cb)
end

function UISeasonS1CollectionTab:GetGuideItem()
  return self._firstItem:GetGameObject("icon")
end

function UISeasonS1CollectionTab:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1CollectionTab_out")
end
