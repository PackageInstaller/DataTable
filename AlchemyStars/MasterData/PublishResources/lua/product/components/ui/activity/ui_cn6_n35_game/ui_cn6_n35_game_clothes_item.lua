_class("UI_CN6_N35_GameClothesItem", UICustomWidget)
UI_CN6_N35_GameClothesItem = UI_CN6_N35_GameClothesItem

function UI_CN6_N35_GameClothesItem:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizedTMP", "name")
  self._idxTex = self:GetUIComponent("UILocalizedTMP", "idx")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._Btn = self:GetUIComponent("Image", "Btn")
  self._btnTex = self:GetGameObject("BtnTex")
  self._btnTex2 = self:GetGameObject("BtnTex2")
  self._redGo = self:GetGameObject("redGo")
  self._anim = self:GetUIComponent("Animation", "UI_CN6_N35_GameClothesItem")
  self._alpha = self:GetUIComponent("CanvasGroup", "UI_CN6_N35_GameClothesItem")
end

function UI_CN6_N35_GameClothesItem:SetData(idx, data, callback, itemTips)
  self._data = data
  self._callback = callback
  self._itemTips = itemTips
  self._idx = idx
  self._idxTex:SetText(tostring(data.number))
  local costID = data.cfg.Input[1][1]
  local cfg_item = Cfg.cfg_item[costID]
  self._name:SetText(StringTable.Get(cfg_item.Name))
  self._icon:LoadImage(cfg_item.Icon)
  local awards = data.cfg.Output
  self._pool:SpawnObjects("UI_CN6_N35_GameClothesAward", #awards)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #awards do
    local item = pools[i]
    local itemid = awards[i][1]
    local count = awards[i][2]
    local cfg_item = Cfg.cfg_item[itemid]
    item:SetData(cfg_item.Icon, count, function(pos)
      if self._itemTips then
        self._itemTips(itemid, pos)
      end
    end)
  end
  self:BtnState()
end

function UI_CN6_N35_GameClothesItem:BtnState()
  self._btnTex:SetActive(false)
  self._btnTex2:SetActive(false)
  self._redGo:SetActive(false)
  if self._data.state == UI_CN6_N35_SmeltState.Finish then
    self._btnTex:SetActive(true)
  elseif self._data.state == UI_CN6_N35_SmeltState.CanFinish then
    self._redGo:SetActive(true)
    self._btnTex:SetActive(true)
  elseif self._data.state == UI_CN6_N35_SmeltState.NotItem then
    self._btnTex2:SetActive(true)
  elseif self._data.state == UI_CN6_N35_SmeltState.NotLast then
    self._btnTex:SetActive(true)
  end
end

function UI_CN6_N35_GameClothesItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._data)
  end
end

function UI_CN6_N35_GameClothesItem:SetAlpha(alpha)
  self._alpha.alpha = alpha
end

function UI_CN6_N35_GameClothesItem:PlayAnim(active, yieldTime)
  if active then
    self:SetAlpha(0)
    if yieldTime and 0 < yieldTime then
      if self._timer then
        GameGlobal.Timer():CancelEvent(self._timer)
      end
      self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
        self._anim:Play("effanim_UI_CN6_N35_GameClothesItem_show")
      end)
    else
      self._anim:Play("effanim_UI_CN6_N35_GameClothesItem_show")
    end
  else
    self:SetAlpha(1)
    self._anim:Play("effanim_UI_CN6_N35_GameClothesItem_hide")
  end
end
