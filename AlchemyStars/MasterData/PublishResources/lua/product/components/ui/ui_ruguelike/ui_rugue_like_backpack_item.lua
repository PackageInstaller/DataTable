_class("UIRugueLikeBackpackItem", UICustomWidget)
UIRugueLikeBackpackItem = UIRugueLikeBackpackItem

function UIRugueLikeBackpackItem:OnShow(uiParam)
  self.ItemColorToText = {
    [ItemColor.ItemColor_White] = "str_item_public_color_white",
    [ItemColor.ItemColor_Green] = "str_item_public_color_green",
    [ItemColor.ItemColor_Blue] = "str_item_public_color_blue",
    [ItemColor.ItemColor_Purple] = "str_item_public_color_purple",
    [ItemColor.ItemColor_Yellow] = "str_item_public_color_yellow",
    [ItemColor.ItemColor_Golden] = "str_item_public_color_golden"
  }
  self.ItemColorToTextColor = {
    [ItemColor.ItemColor_White] = Color(0.8117647058823529, 0.8117647058823529, 0.8117647058823529, 1),
    [ItemColor.ItemColor_Green] = Color(0.12549019607843137, 0.8470588235294118, 0.6470588235294118, 1),
    [ItemColor.ItemColor_Blue] = Color(0.21568627450980393, 0.6588235294117647, 1.0, 1),
    [ItemColor.ItemColor_Purple] = Color(0.6980392156862745, 0.5372549019607843, 0.9803921568627451, 1),
    [ItemColor.ItemColor_Yellow] = Color(1.0, 0.9529411764705882, 0.21568627450980393, 1),
    [ItemColor.ItemColor_Golden] = Color(1.0, 0.5568627450980392, 0 / 255, 1)
  }
  self._prof2img = {
    [2001] = "spirit_prof_5",
    [2002] = "spirit_prof_1",
    [2003] = "spirit_prof_3",
    [2004] = "spirit_prof_7"
  }
end

function UIRugueLikeBackpackItem:GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._msg1 = self:GetUIComponent("UILocalizationText", "msg1")
  self._colorBg = self:GetUIComponent("Image", "colorBg")
  self._colorTex = self:GetUIComponent("UILocalizationText", "colorTex")
  self._new = self:GetGameObject("new")
  self._profGo = self:GetGameObject("profGo")
  self._profImg = self:GetUIComponent("Image", "profImg")
  self._timerTxt = self:GetUIComponent("UILocalizationText", "TimeTxt")
  self._timeObj = self:GetGameObject("Time")
  self._atlas = self:GetAsset("UIMazeBackPack.spriteatlas", LoadType.SpriteAtlas)
  self._profAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  local passEvent = self:GetUIComponent("PassEventComponent", "Viewport")
  passEvent:SetClickCallback(function()
    self:bgOnClick()
  end)
end

function UIRugueLikeBackpackItem:Flush(itemID)
  local item = Cfg.cfg_item[itemID]
  if item == nil then
    Log.fatal("[error] maze --> _cfg == nil ! id --> " .. itemID)
    return
  end
  self._colorBg.sprite = self._atlas:GetSprite("map_tansuo_pinzhi" .. item.Color)
  self._colorTex:SetText(StringTable.Get(self.ItemColorToText[item.Color]))
  self._name.color = self.ItemColorToTextColor[item.Color]
  self._icon:LoadImage(item.Icon)
  self._name:SetText(StringTable.Get(item.Name))
  self._msg1:SetText(StringTable.Get(item.Intro))
  local cfg_prof = Cfg.cfg_item_relic[itemID]
  if cfg_prof then
    local prof = cfg_prof.Prof
    if prof then
      self._profGo:SetActive(true)
      self._profImg.sprite = self._profAtlas:GetSprite(self._prof2img[prof])
    else
      self._profGo:SetActive(false)
    end
    if self._isFromPopStarPro then
      local anipopModule = self:GetModule(AnipopModule)
      local anipopInfo = anipopModule:GetAniPopInfo()
      local relicInfo = anipopInfo.relic_info
      local relicCounters = relicInfo.relic_counters
      local tempTime = relicCounters[itemID] or 0
      if self._isInnerGame then
        tempTime = InnerGameHelperRender.GetRelicCounter(itemID) or 0
      end
      local leftTime = cfg_prof.OutGameTriggerCount - tempTime
      if cfg_prof.OutGameTriggerCount ~= 0 then
        self._timeObj:SetActive(true)
        self._timerTxt:SetText(leftTime)
      else
        self._timeObj:SetActive(false)
      end
    end
  else
    Log.fatal("###cfg_item_relic is nil ! id --> ", itemID)
  end
end

function UIRugueLikeBackpackItem:SetData(index, itemID, _callback, needNew, isFromPopStarPro, innerGame)
  self:GetComponents()
  self._callback = _callback
  self._index = index
  self._new:SetActive(needNew)
  self._isFromPopStarPro = isFromPopStarPro
  self._isInnerGame = innerGame
  self:Flush(itemID)
end

function UIRugueLikeBackpackItem:bgOnClick()
  if self._callback then
    self._callback(self._index)
  end
end
