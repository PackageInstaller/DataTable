_class("UICN9RelicItem", UICustomWidget)
UICN9RelicItem = UICN9RelicItem
local RelicState = {
  Game = "Game",
  RelicStag = "RelicStag",
  ItemToStag = "ItemToStag"
}
_enum("RelicState", RelicState)

function UICN9RelicItem:Constructor()
end

function UICN9RelicItem:SetData(posIndex, clickCB, mainCtrl, data, isOdd, layer, relicId)
  self.icon = self:GetUIComponent("Image", "icon")
  self.Text = self:GetUIComponent("Text", "Text")
  self.bgButton = self:GetUIComponent("Button", "bg")
  self.rootRectTf = self:GetUIComponent("RectTransform", "UICN9RelicItem")
  self.clickCB = clickCB
  self.mainCtrl = mainCtrl
  self.CurRelicStagIndex = -1
  self.isOdd = isOdd
  self.layer = layer
  self.data = data
  self._uicustomEventListener = UICustomUIEventListener:New()
  self:InitBtnPress()
  self._mRelicState = RelicState.Game
  local relicCfg = Cfg.cfg_south_sea_antique[relicId]
  self.initPos = self.mainCtrl.RelicStagAreaRectTf.anchoredPosition
  self.singleDeltaStagX = 120
  self.singleDeltaStagY = 122
  self.singleDeltaStag = 114
  local altas = self:GetAsset("UICN9.spriteatlas", LoadType.SpriteAtlas)
  local spriteScoure = altas:GetSprite(relicCfg.GameIcon)
  self.icon.sprite = spriteScoure
  self.relicType = relicCfg.ID
  local x = 54.0
  local y = 53.0
  local row = data.x
  local vec = data.y
  local rowPos = row * x
  local vecPos = vec * y
  self.anim = self:GetUIComponent("Animation", "UICN9RelicItem")
  self.anim:Play("uieff_CN9RelicItem_in")
  self.rootRectTf:DOAnchorPos(Vector2(rowPos, vecPos), 0)
  self.Text.text = "" .. row .. "-" .. vec .. " - " .. layer
end

function UICN9RelicItem:InitBtnPress()
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.bgButton.gameObject), UIEvent.Press, function(go)
    if self.bgButton.interactable == false then
      return
    end
    if #self.mainCtrl._stagAreaList == 7 then
      return
    end
    if self._mRelicState == RelicState.Game or self._mRelicState == RelicState.ItemToStag then
      local tf = self.bgButton.transform
      tf:DOScale(Vector3(0.9, 0.9, 0.9), 0.15)
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self.bgButton.gameObject), UIEvent.Release, function(go)
    if self.bgButton.interactable == false then
      return
    end
    if #self.mainCtrl._stagAreaList == 7 then
      return
    end
    if self._mRelicState == RelicState.Game or self._mRelicState == RelicState.ItemToStag then
      local tf = self.bgButton.transform
      tf:DOScale(Vector3(1, 1, 1), 0.15)
    end
  end)
end

function UICN9RelicItem:Refresh()
end

function UICN9RelicItem:SetRelicStagIndex(index)
  self.CurRelicStagIndex = index
  if self._mRelicState == RelicState.RelicStag then
    local targetPos = index * Vector2(self.singleDeltaStag, 0)
    self.rootRectTf.transform:SetParent(self.mainCtrl.RelicStagAreaRectTf.transform)
    self._timerHandler = GameGlobal.Timer():AddEventTimes(33, TimerTriggerCount.Once, function()
      self.rootRectTf:DOAnchorPos(targetPos, 0.5)
    end)
  elseif self._mRelicState == RelicState.ItemToStag then
    local targetPos = index * Vector2(0, self.singleDeltaStagY)
    if index < 6 then
      targetPos = index * Vector2(0, self.singleDeltaStagY)
    else
      local curIndex = index - 5
      targetPos = curIndex * Vector2(0, self.singleDeltaStagY)
      targetPos.x = self.singleDeltaStagX
    end
    self.rootRectTf.transform:SetParent(self.mainCtrl.ItemStagAreaRectTf.transform)
    self._timerHandler = GameGlobal.Timer():AddEventTimes(33, TimerTriggerCount.Once, function()
      self.rootRectTf:DOAnchorPos(targetPos, 0.5)
    end)
  end
end

function UICN9RelicItem:PlayDisAnim()
  self.anim:Play("uieff_CN9RelicItem_end")
end

function UICN9RelicItem:BgOnClick()
  if #self.mainCtrl._stagAreaList == 7 then
    return
  end
  local count = 0
  for i = 1, #self.mainCtrl._stagAreaList do
    count = 1
    local one = self.mainCtrl._stagAreaList[i]
    for j = 1, #self.mainCtrl._stagAreaList do
      local two = self.mainCtrl._stagAreaList[j]
      if two.relicType == one.relicType then
        count = count + 1
        if 4 < count then
          return
        end
      end
    end
  end
  if self.bgButton.interactable == false then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCN9Mie_ClickRelic)
  if self._mRelicState == RelicState.Game then
    if self.clickCB ~= nil then
      self.clickCB()
    end
    self._mRelicState = RelicState.RelicStag
    if self.mainCtrl ~= nil then
      self.mainCtrl:CheckRelicItem(self, RelicState.Game)
    end
  elseif self._mRelicState == RelicState.ItemToStag then
    if self.clickCB ~= nil then
      self.clickCB()
    end
    self._mRelicState = RelicState.RelicStag
    if self.mainCtrl ~= nil then
      self.mainCtrl:CheckRelicItem(self, RelicState.ItemToStag)
    end
  end
end

function UICN9RelicItem:SetCanPoint(enable)
  if enable then
    self.bgButton.interactable = true
    self.icon.color = Color.white
  else
    self.bgButton.interactable = false
    self.icon.color = Color.gray
  end
  self.Text.text = "" .. self.data.x .. "-" .. self.data.y .. " - " .. self.layer
end
