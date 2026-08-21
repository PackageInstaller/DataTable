_class("UISeasonMazeRoomBeadBuy", UIController)
UISeasonMazeRoomBeadBuy = UISeasonMazeRoomBeadBuy

function UISeasonMazeRoomBeadBuy:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomBeadBuy:OnShow(uiParams)
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._data = uiParams[1]
  self._component = uiParams[2]
  self._callBack = uiParams[3]
  self._id = self._data._slotData.item.id
  self._cfg = Cfg.cfg_component_season_maze_autobead[self._id]
  self:InitWidget()
  self:_RegisterFuncs()
  self:_OnValue()
end

function UISeasonMazeRoomBeadBuy:InitWidget()
  self._lType = self:GetUIComponent("Image", "LType")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.priceText = self:GetUIComponent("UILocalizationText", "PriceText")
  self.costIcon = self:GetUIComponent("Image", "CostIcon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._star = {}
  for i = 1, 3 do
    self._star[i] = self:GetGameObject("Star" .. i)
  end
  self.type = self:GetUIComponent("UILocalizationText", "Type")
  self.tag = self:GetUIComponent("UILocalizationText", "Tag")
  self.desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._attGO = {}
  self._attText = {}
  for i = 1, 8 do
    self._attGO[i] = self:GetGameObject("Att" .. i)
    self._attText[i] = self:GetUIComponent("UILocalizationText", "Att" .. i)
  end
  self._lStar = {}
  for i = 1, 3 do
    self._lStar[i] = self:GetGameObject("LStar" .. i)
  end
end

function UISeasonMazeRoomBeadBuy:BuyBtnOnClick(go)
  local price = self._data._slotData.price
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    local tips = StringTable.Get("str_season_maze_gold_not_enough")
    ToastManager.ShowToast(tips)
    return
  end
  if self._callBack then
    self._callBack()
  end
  self:CloseDialog()
end

function UISeasonMazeRoomBeadBuy:CancelBtnOnClick(go)
  self:CloseDialog()
end

function UISeasonMazeRoomBeadBuy:_OnValue(TT)
  self._lType.sprite = self._atlas:GetSprite(self:_GetTypeSprite(self._cfg))
  self._icon:LoadImage(self._cfg.Icon)
  for key, value in ipairs(self._star) do
    value:SetActive(key < self._cfg.Lv)
  end
  self._name:SetText(StringTable.Get(self._cfg.Name))
  for key, star in ipairs(self._lStar) do
    star:SetActive(key < self._cfg.Lv)
  end
  self.type:SetText(StringTable.Get(self:GetTypeStr(self._cfg.Type)))
  local tagStr = ""
  if self._cfg.Tag_c then
    for key, value in ipairs(self._cfg.Tag_c) do
      if key < #self._cfg.Tag_c then
        tagStr = tagStr .. StringTable.Get(value) .. "、"
      else
        tagStr = tagStr .. StringTable.Get(value)
      end
    end
  end
  self.tag:SetText(tagStr)
  self.desc:SetText(StringTable.Get(self._cfg.Desc))
  local attStr = self:GetAttStr()
  for index, value in ipairs(self._attText) do
    if attStr[index] then
      value:SetText(attStr[index])
    end
    self._attGO[index]:SetActive(attStr[index] ~= nil)
  end
  local price = self._data._slotData.price
  local priceStr = tostring(price)
  local curGold = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  if price > curGold then
    priceStr = "<color=#c97d7d>" .. priceStr .. "</color>"
  end
  self.priceText:SetText(priceStr)
end

function UISeasonMazeRoomBeadBuy:GetTypeStr(beadType)
  if beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "str_season_maze_bead_type"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "str_season_maze_bead_type1"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "str_season_maze_bead_type2"
  end
end

function UISeasonMazeRoomBeadBuy:_RegisterFuncs()
  self._funcs = {}
  self._funcs[SeasonMazeBeadAttType.Hurt] = self._DefaultFunc
  self._funcs[SeasonMazeBeadAttType.Energy] = self._EnergyFunc
  self._funcs[SeasonMazeBeadAttType.EnergyRevise] = self._EnergyRevise
  self._funcs[SeasonMazeBeadAttType.Hit] = self._HitFunc
  self._funcs[SeasonMazeBeadAttType.Crit] = self._DefaultFunc
  self._funcs[SeasonMazeBeadAttType.CritHurt] = self._CritHurtFunc
  self._funcs[SeasonMazeBeadAttType.Combo] = self._DefaultFunc
  self._funcs[SeasonMazeBeadAttType.HurtFload] = self._DefaultFunc
end

function UISeasonMazeRoomBeadBuy:GetAttStr()
  self._attStr = {}
  self._fixValues = nil
  self:GetAttValueStr(SeasonMazeBeadAttType.Hurt, self._cfg.Hurt, "str_season_maze_bead_att_str", false)
  self:GetAttValueStr(SeasonMazeBeadAttType.Energy, self._cfg.Energy, "str_season_maze_bead_att_str1", false)
  self:GetAttValueStr(SeasonMazeBeadAttType.EnergyRevise, self._cfg.EnergyRevise, "str_season_maze_bead_att_str2", true)
  self:GetAttValueStr(SeasonMazeBeadAttType.Hit, self._cfg.HitRate, "str_season_maze_bead_att_str3", true)
  self:GetAttValueStr(SeasonMazeBeadAttType.Crit, self._cfg.CritChance, "str_season_maze_bead_att_str4", true)
  self:GetAttValueStr(SeasonMazeBeadAttType.CritHurt, self._cfg.CritHurt, "str_season_maze_bead_att_str5", true)
  self:GetAttValueStr(SeasonMazeBeadAttType.Combo, self._cfg.ComboRate, "str_season_maze_bead_att_str6", true)
  self:GetAttValueStr(SeasonMazeBeadAttType.HurtFload, self._cfg.HurtFloat, "str_season_maze_bead_att_str7", true)
  return self._attStr
end

function UISeasonMazeRoomBeadBuy:GetFixValue(values, beadAttType)
  if values and beadAttType and values[beadAttType] then
    return values[beadAttType]
  end
  return 0
end

function UISeasonMazeRoomBeadBuy:GetAttValueStr(beadAttType, cfgValue, cfgStr, isPercent)
  local func = self._funcs[beadAttType]
  func = func or self._DefaultFunc
  func(self, beadAttType, cfgValue, cfgStr, isPercent)
end

function UISeasonMazeRoomBeadBuy:_DefaultFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local fixValue = self:GetFixValue(self._fixValues, beadAttType)
  local valueStr
  if 0 < fixValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, cfgValue + fixValue))
  elseif fixValue < 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, cfgValue + fixValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, cfgValue + fixValue))
  end
  if valueStr then
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UISeasonMazeRoomBeadBuy:_EnergyFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local fixValue = self:GetFixValue(self._fixValues, beadAttType)
  local valueStr
  if 0 < fixValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, cfgValue + fixValue))
  elseif fixValue < 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, cfgValue + fixValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, cfgValue + fixValue))
  end
  if valueStr then
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UISeasonMazeRoomBeadBuy:_EnergyRevise(beadAttType, cfgValue, cfgStr, isPercent)
  local fixValue = self:GetFixValue(self._fixValues, beadAttType)
  local valueStr
  local finalValue = cfgValue + fixValue
  if 0 < fixValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, finalValue))
  elseif fixValue < 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, finalValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, finalValue))
  end
  if valueStr then
    if 0 < finalValue then
      valueStr = "+" .. valueStr
    end
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UISeasonMazeRoomBeadBuy:_HitFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local fixValue = self:GetFixValue(self._fixValues, beadAttType)
  local valueStr
  local finalValue = cfgValue + fixValue
  finalValue = finalValue - 1000
  if finalValue ~= 0 then
    if 0 < fixValue then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, finalValue))
    elseif fixValue < 0 then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, finalValue))
    else
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, finalValue))
    end
  end
  if valueStr then
    if 0 < finalValue then
      valueStr = "+" .. valueStr
    end
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UISeasonMazeRoomBeadBuy:_CritHurtFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local fixValue = self:GetFixValue(self._fixValues, beadAttType)
  local valueStr
  local finalValue = cfgValue + fixValue
  finalValue = finalValue - 1500
  if finalValue ~= 0 then
    if 0 < fixValue then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, finalValue))
    elseif fixValue < 0 then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, finalValue))
    else
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, finalValue))
    end
  end
  if valueStr then
    if 0 < finalValue then
      valueStr = "+" .. valueStr
    end
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UISeasonMazeRoomBeadBuy:_ToPercent(isPercent, value)
  if isPercent then
    local x, y = math.modf(math.floor(value * 0.1))
    return x .. "%%"
  else
    local x, y = math.modf(math.floor(value))
    return tostring(x)
  end
end

function UISeasonMazeRoomBeadBuy:_ToColorStr(colorType, str)
  if str then
    if colorType == SeasonMazeBeadTipsColorType.Red then
      return string.format("<color=#ef5151>%s</color>", str)
    elseif colorType == SeasonMazeBeadTipsColorType.Green then
      return string.format("<color=#56c49b>%s</color>", str)
    elseif colorType == SeasonMazeBeadTipsColorType.Black then
      return string.format("<color=#1c1c1c>%s</color>", str)
    end
  end
  return nil
end

function UISeasonMazeRoomBeadBuy:SetCloseBtnVisble(bVisible)
  self._closeBtnGo:SetActive(bVisible)
end

function UISeasonMazeRoomBeadBuy:GetBeadInfo(uid)
  return nil
end

function UISeasonMazeRoomBeadBuy:_GetTypeSprite(cfg)
  if cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif cfg.Type == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
  return "cn14_sjmj_xdjmk_di12"
end
