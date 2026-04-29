_class("UISeasonMaze_Campsites_SmithyWidget", UICustomWidget)
UISeasonMaze_Campsites_SmithyWidget = UISeasonMaze_Campsites_SmithyWidget

function UISeasonMaze_Campsites_SmithyWidget:InitWidget()
  self._RootAreaGo = self:GetGameObject("RootArea")
  self._SoldOutAreaGo = self:GetGameObject("SoldOutArea")
  self._RelicBgGo = self:GetGameObject("RelicBg")
  self._OnceItemBgGo = self:GetGameObject("OnceItemBg")
  self._PriceAreaGo = self:GetGameObject("PriceArea")
  self._OriPriceGo = self:GetGameObject("OriPrice")
  self._SelectedAreaGo = self:GetGameObject("SelectedArea")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._CostIcon = self:GetUIComponent("Image", "CostIcon")
  self._OriPriceText = self:GetUIComponent("UILocalizationText", "OriPrice")
  self._CurPriceText = self:GetUIComponent("UILocalizationText", "CurPrice")
  self._NameText = self:GetUIComponent("UILocalizationText", "NameText")
end

function UISeasonMaze_Campsites_SmithyWidget:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMaze_Campsites_SmithyWidget:Select(idx)
end

function UISeasonMaze_Campsites_SmithyWidget:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if self._hideTimer then
    GameGlobal.Timer():CancelEvent(self._hideTimer)
  end
end

function UISeasonMaze_Campsites_SmithyWidget:SetData(idx, info, callback, com)
  self._callback = callback
  self._idx = idx
  self._info = info
  self._com = com
  self:RefreshUI()
end

function UISeasonMaze_Campsites_SmithyWidget:RefreshUI()
  local slotData = self._info._slotData
  if slotData.sellout then
    self._SoldOutAreaGo:SetActive(true)
  else
    self._SoldOutAreaGo:SetActive(false)
  end
  if slotData.ori_price > 0 and slotData.ori_price ~= slotData.price then
    self._OriPriceGo:SetActive(true)
    self._OriPriceText:SetText(tostring(slotData.ori_price))
  else
    self._OriPriceGo:SetActive(false)
  end
  local priceStr = tostring(slotData.price)
  local curGold = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if curGold < slotData.price then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self._CurPriceText:SetText(priceStr)
  local effectType = slotData.item.type
  if effectType == SeasonMazeEffectType.SMET_Once then
    self._RelicBgGo:SetActive(false)
    self._OnceItemBgGo:SetActive(true)
  else
    self._RelicBgGo:SetActive(true)
    self._OnceItemBgGo:SetActive(false)
  end
  local itemId = slotData.item.id
  local iconRes = ""
  if effectType == SeasonMazeEffectType.SMET_Once then
    local onceCfg = Cfg.cfg_component_season_maze_once({OnceID = itemId})[1]
    if onceCfg then
      iconRes = onceCfg.Icon
      local name = onceCfg.Name
      if name then
        self._NameText:SetText(StringTable.Get(name))
      end
    end
  else
    local item = Cfg.cfg_item[itemId]
    if item then
      iconRes = item.Icon
      self._NameText:SetText(StringTable.Get(item.Name))
    end
  end
  local slotCfgs = Cfg.cfg_component_season_maze_slot({
    ID = self._idx
  })
  if slotCfgs ~= nil then
    local slotCfg = slotCfgs[1]
    if slotCfg.Type == 3 and slotCfg.EffectID ~= nil then
      local effCfg = Cfg.cfg_component_season_maze_effect[slotCfg.EffectID]
      if effCfg ~= nil then
        local effectList = effCfg.EffectList
        if effectList ~= nil then
          local firestEff = effectList[1]
          if firestEff[1] == SeasonMazeEffectType.SMET_Pro then
            local attId = firestEff[2]
            local attCfg = Cfg.cfg_season_maze_attribute[attId]
            if attCfg ~= nil then
              iconRes = attCfg.ItemIcon
              self._NameText:SetText(StringTable.Get(attCfg.Name))
            end
          end
        end
      end
    end
  end
  self._Icon:LoadImage(iconRes)
end

function UISeasonMaze_Campsites_SmithyWidget:BgAreaOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UISeasonMaze_Campsites_SmithyWidget:ShowSelected(bShow)
  self._SelectedAreaGo:SetActive(bShow)
end

function UISeasonMaze_Campsites_SmithyWidget:PlayShowInAnim(delay)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._RootAreaGo:SetActive(true)
  end
  if delay and 0 < delay then
    self._RootAreaGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._RootAreaGo:SetActive(true)
      if self._anim then
        self._anim:Play("uieffanim_UISeasonMaze_Campsites_SmithyWidget_in")
      end
    end)
  else
    self._RootAreaGo:SetActive(true)
    if self._anim then
      self._anim:Play("uieffanim_UISeasonMaze_Campsites_SmithyWidget_in")
    end
  end
end

function UISeasonMaze_Campsites_SmithyWidget:PlayShowOutAnim()
  self._RootAreaGo:SetActive(true)
  if self._anim then
    self._anim:Play("uieffanim_UISeasonMaze_Campsites_SmithyWidget_out")
    if self._hideTimer then
      GameGlobal.Timer():CancelEvent(self._hideTimer)
      self._hideTimer = GameGlobal.Timer():AddEvent(300, function()
        self._RootAreaGo:SetActive(false)
      end)
    end
  end
end
