_class("UISeasonS3CollectionTab", UICustomWidget)
UISeasonS3CollectionTab = UISeasonS3CollectionTab

function UISeasonS3CollectionTab:OnShow(uiParams)
  self:InitWidget()
  self._firstItem = nil
end

function UISeasonS3CollectionTab:InitWidget()
  self.condition = self:GetUIComponent("UILocalizationText", "condition")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.des = self:GetUIComponent("UILocalizationText", "des")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._unlock = self:GetGameObject("Unlock")
  self._lock = self:GetGameObject("Lock")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
  self.title = self:GetUIComponent("UILocalizationText", "title")
end

function UISeasonS3CollectionTab:SetData(data, onEnter)
  self._collageData = data
  self._seasonID = data:GetSeasonID()
  
  local function onClick(data)
    self:_OnSelect(data)
  end
  
  local count = self._collageData:GetCollectionCount()
  self._items = self.content:SpawnObjects("UISeasonS3CollageCollectionItem", count)
  for i = 1, count do
    local data = self._collageData:GetCollectionByIndex(i)
    self._items[i]:SetData(data, onClick)
    if not self._firstItem then
      self._firstItem = self._items[i]
    end
  end
  self._curSelectIdx = nil
  self:_OnSelect(self._collageData:GetCollectionByIndex(1), onEnter)
end

function UISeasonS3CollectionTab:SetShow(show)
  self:GetGameObject():SetActive(show)
end

function UISeasonS3CollectionTab:_OnSelect(data, onEnter)
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
  self._finalStoryID = nil
  self.condition:SetText(StringTable.Get(cfg.RequireDesc))
  if data:IsGot() then
    self._unlock:SetActive(true)
    self._lock:SetActive(false)
    self.icon:SetColor(Color.white)
    local itemCfg = Cfg.cfg_item[cfgID]
    self.title:SetText(StringTable.Get(itemCfg.Name))
    self.des:SetText(StringTable.Get(itemCfg.Intro) .. "\n" .. StringTable.Get(itemCfg.RpIntro))
    local time = data:GetTime()
    self.time:SetText(StringTable.Get("str_season_s2_require_time", TimeToDate(time)))
    local composeQuestID = cfg.ComposeQuestID
    if composeQuestID then
      local finalStoryQuestId
      local seasonClientCfg = Cfg.cfg_season_campaign_client[self._seasonID]
      if seasonClientCfg then
        finalStoryQuestId = seasonClientCfg.FinalStoryQuestID
      end
      if finalStoryQuestId and finalStoryQuestId == composeQuestID then
        self._finalStoryID = cfg.ComposeStoryID
      end
    end
    self._anim:Stop()
    if onEnter then
      self._anim:Play("uieffanim_UISeasonS3CollectionTab_in")
    else
      self._anim:Play("uieffanim_UISeasonS3CollectionTab_in1")
    end
  else
    self.title:SetText("???")
    self._unlock:SetActive(false)
    self._lock:SetActive(true)
    self._anim:Stop()
  end
end

function UISeasonS3CollectionTab:FinalPlotEnterOnClick(go)
  if not self._finalStoryID then
    return
  end
  local cb
  UISeasonHelper.PlayStoryInSeasonScence(self._finalStoryID, cb)
end

function UISeasonS3CollectionTab:GetGuideItem()
  return self._firstItem:GetGameObject("icon")
end

function UISeasonS3CollectionTab:PlayExitAnim()
end
