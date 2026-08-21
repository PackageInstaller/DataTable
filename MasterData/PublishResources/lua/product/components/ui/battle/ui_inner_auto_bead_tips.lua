_class("UIInnerAutoBeadTips", UICustomWidget)
UIInnerAutoBeadTips = UIInnerAutoBeadTips

function UIInnerAutoBeadTips:OnShow(uiParams)
  self:_InitWidget()
  self:_RegisterFuncs()
end

function UIInnerAutoBeadTips:_InitWidget()
  self._gameObject = self.view:GetGameObject()
  self._root = self:GetGameObject("Root")
  self._rootRectTransform = self:GetUIComponent("RectTransform", "Root")
  self._rootTransform = self._root.transform
  self.name = self:GetUIComponent("UILocalizationText", "Name")
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
  self._gameObject:SetActive(false)
  self._bgRect = self:GetUIComponent("RectTransform", "Bg")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Root")
end

function UIInnerAutoBeadTips:SetData(uid, id, data, position)
  self._uid = uid
  self._id = id
  self._data = data
  self._position = position
  self:Lock("UIInnerAutoBeadTips")
  self:StartTask(function(TT)
    self:_OnValue(TT)
    self:UnLock("UIInnerAutoBeadTips")
  end)
end

function UIInnerAutoBeadTips:_OnValue(TT)
  self._gameObject:SetActive(true)
  self._rootTransform.position = self._position
  self._cfg = Cfg.cfg_component_season_maze_autobead[self._id]
  self.name:SetText(StringTable.Get(self._cfg.Name))
  for key, star in ipairs(self._star) do
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
  if self._position then
    self:_AdaptivePosition(TT, self._position)
  end
end

function UIInnerAutoBeadTips:_AdaptivePosition(TT, position)
  self._canvasGroup.alpha = 0
  YIELD(TT)
  local controllName = self.uiOwner:GetName()
  local camera = GameGlobal.UIStateManager():GetControllerCamera(controllName)
  local controller = GameGlobal.UIStateManager():GetController(controllName)
  local gameObject = controller:GetGameObject()
  local transform = gameObject.transform:Find("UICanvas")
  local rectTransform = transform:GetComponent(typeof(UnityEngine.RectTransform))
  local point = camera:WorldToScreenPoint(position)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, point, camera, nil)
  if position.x + self._bgRect.sizeDelta.x > rectTransform.sizeDelta.x * 0.5 then
    position.x = rectTransform.sizeDelta.x * 0.5 - self._bgRect.sizeDelta.x
  end
  if position.y + rectTransform.sizeDelta.y * 0.5 < self._bgRect.sizeDelta.y then
    position.y = self._bgRect.sizeDelta.y - rectTransform.sizeDelta.y * 0.5
  end
  self._rootTransform.localPosition = position
  self._canvasGroup.alpha = 1
end

function UIInnerAutoBeadTips:CloseBtnOnClick(go)
  self._gameObject:SetActive(false)
end

function UIInnerAutoBeadTips:GetTypeStr(beadType)
  if beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "str_season_maze_bead_type"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "str_season_maze_bead_type1"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "str_season_maze_bead_type2"
  end
end

function UIInnerAutoBeadTips:_RegisterFuncs()
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

function UIInnerAutoBeadTips:GetAttStr()
  self._attStr = {}
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

function UIInnerAutoBeadTips:GetInnerValue(beadAttType)
  return self._data.att_info[beadAttType]
end

function UIInnerAutoBeadTips:GetAttValueStr(beadAttType, cfgValue, cfgStr, isPercent)
  local func = self._funcs[beadAttType]
  func = func or self._DefaultFunc
  func(self, beadAttType, cfgValue, cfgStr, isPercent)
end

function UIInnerAutoBeadTips:_DefaultFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local innerValue = self:GetInnerValue(beadAttType) or cfgValue
  local valueStr
  if cfgValue < innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue > innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, innerValue))
  end
  if valueStr then
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UIInnerAutoBeadTips:_EnergyFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local innerValue = self:GetInnerValue(beadAttType) or cfgValue
  local valueStr
  if cfgValue < innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue > innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, innerValue))
  end
  if valueStr then
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UIInnerAutoBeadTips:_EnergyRevise(beadAttType, cfgValue, cfgStr, isPercent)
  local innerValue = self:GetInnerValue(beadAttType) or cfgValue
  local valueStr
  if cfgValue < innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue > innerValue then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Red, self:_ToPercent(isPercent, innerValue))
  elseif cfgValue ~= 0 then
    valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Black, self:_ToPercent(isPercent, innerValue))
  end
  if valueStr then
    if 0 < innerValue then
      valueStr = "+" .. valueStr
    end
    table.insert(self._attStr, StringTable.Get(cfgStr, valueStr))
  end
end

function UIInnerAutoBeadTips:_HitFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local innerValue = self:GetInnerValue(beadAttType) or cfgValue
  local valueStr
  local finalValue = innerValue
  finalValue = finalValue - 1000
  if finalValue ~= 0 then
    if cfgValue < innerValue then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, finalValue))
    elseif cfgValue > innerValue then
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

function UIInnerAutoBeadTips:_CritHurtFunc(beadAttType, cfgValue, cfgStr, isPercent)
  local innerValue = self:GetInnerValue(beadAttType) or cfgValue
  local valueStr
  local finalValue = innerValue
  finalValue = finalValue - 1500
  if finalValue ~= 0 then
    if cfgValue < innerValue then
      valueStr = self:_ToColorStr(SeasonMazeBeadTipsColorType.Green, self:_ToPercent(isPercent, finalValue))
    elseif cfgValue > innerValue then
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

function UIInnerAutoBeadTips:_ToPercent(isPercent, value)
  if isPercent then
    local x, y = math.modf(math.floor(value * 0.1))
    return x .. "%%"
  else
    local x, y = math.modf(math.floor(value))
    return tostring(x)
  end
end

function UIInnerAutoBeadTips:_ToColorStr(colorType, str)
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
