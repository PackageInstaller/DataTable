_class("UIAutoFightAwardsItem", UICustomWidget)
UIAutoFightAwardsItem = UIAutoFightAwardsItem

function UIAutoFightAwardsItem:OnShow(uiParams)
  self:InitWidget()
end

function UIAutoFightAwardsItem:InitWidget()
  self.times = self:GetUIComponent("UILocalizationText", "times")
  self.double = self:GetUIComponent("UILocalizationText", "double")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.fighting = self:GetGameObject("fighting")
  self.noAwards = self:GetGameObject("noAwards")
  self.awards = self:GetUIComponent("ScrollRect", "awards")
end

function UIAutoFightAwardsItem:SetData(matchType, count, doubleCount, awards, fightingNum, title, matchResult, onItemClick)
  self._matchType = matchType
  self.times:SetText(title)
  if count == fightingNum then
    self:GetGameObject("fighting"):SetActive(true)
    self:GetGameObject("double"):SetActive(false)
    self:GetGameObject("success"):SetActive(false)
    self:GetGameObject("failed"):SetActive(false)
    self:GetGameObject("noAwards"):SetActive(false)
    self.content:SpawnObjects("UIItem", 0)
  else
    self:GetGameObject("fighting"):SetActive(false)
    if awards and 0 < #awards then
      self:GetGameObject("noAwards"):SetActive(false)
      self:GetGameObject("failed"):SetActive(false)
      if not doubleCount or doubleCount == 0 then
        self:GetGameObject("success"):SetActive(true)
        self:GetGameObject("double"):SetActive(false)
        self:GetGameObject("one"):SetActive(false)
        self:GetGameObject("two"):SetActive(false)
      elseif doubleCount == 1 then
        self:GetGameObject("success"):SetActive(false)
        self:GetGameObject("double"):SetActive(true)
        self:GetGameObject("one"):SetActive(true)
        self:GetGameObject("two"):SetActive(false)
      elseif doubleCount == 2 then
        self:GetGameObject("success"):SetActive(false)
        self:GetGameObject("double"):SetActive(true)
        self:GetGameObject("one"):SetActive(false)
        self:GetGameObject("two"):SetActive(true)
      else
        Log.exception("携行者数量错误:", doubleCount)
      end
      local items = self.content:SpawnObjects("UIItem", #awards)
      for i, asset in ipairs(awards) do
        local award = Award:New()
        local item = items[i]
        award:InitWithCount(asset.assetid, asset.count)
        item:SetForm(UIItemForm.Base)
        local activityText = ""
        if asset.type == StageAwardType.Activity then
          award.type = asset.type
          activityText = StringTable.Get("str_item_xianshi")
        end
        item:SetData({
          icon = award.icon,
          text1 = award.count,
          quality = award.color,
          itemId = award.id,
          activityText = activityText
        })
        item:SetClickCallBack(function(go)
          onItemClick(award.id, go.transform.position)
        end)
      end
    elseif matchResult and matchType == MatchType.MT_Tower then
      self:GetGameObject("double"):SetActive(false)
      self:GetGameObject("noAwards"):SetActive(true)
      self:GetGameObject("success"):SetActive(true)
      self:GetGameObject("failed"):SetActive(false)
      self.content:SpawnObjects("UIItem", 0)
    else
      self:GetGameObject("double"):SetActive(false)
      self:GetGameObject("noAwards"):SetActive(true)
      self:GetGameObject("success"):SetActive(false)
      self:GetGameObject("failed"):SetActive(true)
      self.content:SpawnObjects("UIItem", 0)
    end
  end
  self:FormatAwardsScale()
end

function UIAutoFightAwardsItem:FormatAwardsScale()
  local items = self.content:GetAllSpawnList()
  for k, v in pairs(items) do
    local itemGo = v:GetGameObject()
    itemGo.transform.localScale = Vector3(0.8, 0.8, 1)
  end
end

function UIAutoFightAwardsItem:ParentParentSr(ppSr)
  local items = self.content:GetAllSpawnList()
  for k, v in pairs(items) do
    local go = v:GetBtn()
    local uiDrag = go:GetComponent("UIDrag")
    uiDrag.mScrollViewRect = self.awards
    local uiDrag = go:AddComponent(typeof(UIDrag))
    uiDrag.mScrollViewRect = ppSr
  end
  local uiDrag = self.awards.gameObject:AddComponent(typeof(UIDrag))
  uiDrag.mScrollViewRect = ppSr
end
