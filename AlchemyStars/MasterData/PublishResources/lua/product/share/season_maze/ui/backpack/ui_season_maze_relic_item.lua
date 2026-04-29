_class("UISeasonMazeRelicItem", UICustomWidget)
UISeasonMazeRelicItem = UISeasonMazeRelicItem

function UISeasonMazeRelicItem:OnShow(uiParam)
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
  self:GetComponents()
end

function UISeasonMazeRelicItem:OnHide()
  self.close = true
  if self.timerEvent then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
end

function UISeasonMazeRelicItem:GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._msg1 = self:GetUIComponent("UILocalizedTMP", "msg1")
  self._msg1Obj = self:GetGameObject("msg1")
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
    self:BgOnClick()
  end)
  self.useendObj = self:GetGameObject("UseEnd")
  self.useendObj:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._anim.gameObject:SetActive(false)
  UIEventTriggerListener.Get(self._msg1Obj).onClick = function()
    self:BgOnClick()
  end
  self.contentRectTf = self:GetUIComponent("RectTransform", "Content")
  self.scrollViewRectTf = self:GetUIComponent("RectTransform", "ScrollView")
  self.scrollView = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UISeasonMazeRelicItem:DisableAnimation()
  self._disalbeAnimation = true
  self._anim.enabled = false
  self._anim.gameObject:SetActive(true)
end

function UISeasonMazeRelicItem:Flush(itemID)
  local item = Cfg.cfg_item[itemID]
  if item == nil then
    Log.fatal("[error] maze --> _cfg == nil ! id --> " .. itemID)
    return
  end
  self._colorBg.sprite = self._atlas:GetSprite("map_tansuo_pinzhi" .. item.Color)
  self._colorTex:SetText(StringTable.Get(self.ItemColorToText[item.Color]))
  self._icon:LoadImage(item.Icon)
  self._name:SetText(StringTable.Get(item.Name))
  self._msg1:SetText(StringTable.Get(item.Intro))
  if self.isInBagInfo then
    function self._msg1.onHrefClick(hrefName)
      GameGlobal.UIStateManager():ShowDialog("UISeasonMaze_RelicHrefInfo", hrefName)
    end
  end
  if self._index or not self._disalbeAnimation then
    local delta = math.ceil(self._index / 4)
    delta = delta * 50
    if delta == 0 then
      self._anim.gameObject:SetActive(true)
    else
      self.timerEvent = GameGlobal.Timer():AddEventTimes(delta, TimerTriggerCount.Once, function()
        if self.close then
          return
        end
        if self.timerEvent == nil then
          return
        end
        self._anim.gameObject:SetActive(true)
        self._anim:Play("uieffanim_UISeasonMazeBagPetStateItem_in")
      end)
    end
  else
    self._anim.gameObject:SetActive(true)
  end
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
      local tempTime = 0
      tempTime = self.uiSeasonMazeModule:GetSeasonMazeRelicCanUseCount(itemID)
      if self._isInShop then
        self.useendObj:SetActive(false)
      else
        local leftTime = tempTime
        if 0 < leftTime then
          self.useendObj:SetActive(false)
        else
          self._timeObj:SetActive(false)
          self.useendObj:SetActive(true)
        end
        if cfg_prof.OutGameTriggerCount == 0 then
          self.useendObj:SetActive(false)
        end
      end
    end
  else
    Log.fatal("###cfg_item_relic is nil ! id --> ", itemID)
  end
end

function UISeasonMazeRelicItem:SetData(index, itemID, _callback, needNew, isFromPopStarPro, innerGame, isInShop, isInBagInfo)
  self._callback = _callback
  self._index = index
  self._new:SetActive(needNew)
  self._isFromPopStarPro = isFromPopStarPro
  self._isInnerGame = innerGame
  self._isInShop = isInShop
  self.isInBagInfo = isInBagInfo
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self:Flush(itemID)
end

function UISeasonMazeRelicItem:SetNewVisble(bNew)
  self._new:SetActive(bNew)
end

function UISeasonMazeRelicItem:BgOnClick()
  if self._callback then
    self._callback(self._index)
  end
end
