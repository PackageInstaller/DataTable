_class("UIActiveTaskAwardShowController", UIController)
UIActiveTaskAwardShowController = UIActiveTaskAwardShowController

function UIActiveTaskAwardShowController:Constructor()
end

function UIActiveTaskAwardShowController:OnShow(param)
  self._itemList = param[1]
  self._selectItem = nil
  self:_GetComponent()
end

function UIActiveTaskAwardShowController:OnHide()
end

function UIActiveTaskAwardShowController:_GetComponent()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemInfoContent = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._clickObj = self:GetGameObject("click")
  local passEvent = self:GetUIComponent("PassEventComponent", "click")
  passEvent:SetClickCallback(function()
    if self._selectItem then
      self._itemInfo:SetActive(false)
      self._clickObj:SetActive(false)
    end
  end)
  self:InitComponent()
end

function UIActiveTaskAwardShowController:InitComponent()
  self._cfg = Cfg.cfg_component_turn_card({})
  local awardList = self:CaleItemGroup()
  self._clickObj:SetActive(false)
  self._awardContents = self._content:SpawnObjects("UIActiveTaskAwardShowIContent", #awardList)
  self._itemInfo = self._itemInfoContent:SpawnObject("UIActiveTaskAwardItemInfo")
  self._itemInfo:SetActive(false)
  for i, v in pairs(self._awardContents) do
    local data = awardList[i]
    v:SetData(data, i, function(item)
      self._selectItem = item
      local txt = item:GetItemInfo()
      local pos = item:GetPosition()
      self._itemInfo:SetData(txt, pos)
      self._itemInfo:SetActive(true)
      self._clickObj:SetActive(true)
    end)
  end
end

function UIActiveTaskAwardShowController:CaleItemGroup()
  local awardList = {}
  local level1 = {}
  local level2 = {}
  local level3 = {}
  for _, v in pairs(self._itemList) do
    local cfg = Cfg.cfg_component_turn_card_item[v.id]
    local curLevel
    if cfg.RewardLevel == 1 then
      curLevel = level1
    elseif cfg.RewardLevel == 2 then
      curLevel = level2
    elseif cfg.RewardLevel == 3 then
      curLevel = level3
    end
    if curLevel then
      if v.isGet then
        curLevel[v.id] = curLevel[v.id] and curLevel[v.id] or 0
      else
        curLevel[v.id] = curLevel[v.id] and curLevel[v.id] + 1 or 1
      end
    end
  end
  table.insert(awardList, level1)
  table.insert(awardList, level2)
  table.insert(awardList, level3)
  return awardList
end

function UIActiveTaskAwardShowController:BackBtnOnClick()
  self:StartTask(function(TT)
    self:Lock("UIActiveTaskAwardShowController_BackBtnOnClick")
    self._anim:Play("uieff_UIActiveTaskAwardShowController_out")
    for _, v in pairs(self._awardContents) do
      v:Close()
    end
    YIELD(TT, 333)
    self:CloseDialog()
    self:UnLock("UIActiveTaskAwardShowController_BackBtnOnClick")
  end, self)
end
