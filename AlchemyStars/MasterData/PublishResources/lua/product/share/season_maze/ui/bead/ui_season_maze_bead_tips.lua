_class("UISeasonMazeBeadTips", UICustomWidget)
UISeasonMazeBeadTips = UISeasonMazeBeadTips

function UISeasonMazeBeadTips:OnShow(uiParams)
  self:_InitWidget()
  self:_RegisterFuncs()
end

function UISeasonMazeBeadTips:_InitWidget()
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
  self._funcBtn = self:GetGameObject("FuncBtn")
  self._funcBtnText = self:GetUIComponent("UILocalizationText", "FuncBtnText")
  self._gameObject:SetActive(false)
  self._closeBtnGo = self:GetGameObject("CloseBtn")
  self._bgRect = self:GetUIComponent("RectTransform", "Bg")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Root")
end

function UISeasonMazeBeadTips:SetData(uid, id, position, btnType, callBack)
  self._uid = uid
  self._id = id
  self._position = position
  self._btnType = btnType or SeasonMazeBeadTipsBtnType.None
  self._callBack = callBack
  self:Lock("UISeasonMazeBeadTips")
  self:StartTask(function(TT)
    self:_OnValue(TT)
    self:UnLock("UISeasonMazeBeadTips")
  end)
end

function UISeasonMazeBeadTips:_OnValue(TT)
  self._gameObject:SetActive(true)
  self:_SetFuncBtn()
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

function UISeasonMazeBeadTips:_AdaptivePosition(TT, position)
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

function UISeasonMazeBeadTips:FuncBtnOnClick(go)
  if self._callBack then
    self._callBack(self._uid)
    self:CloseBtnOnClick()
  end
end

function UISeasonMazeBeadTips:CloseBtnOnClick(go)
  self._gameObject:SetActive(false)
end

function UISeasonMazeBeadTips:GetTypeStr(beadType)
  if beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "str_season_maze_bead_type"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "str_season_maze_bead_type1"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "str_season_maze_bead_type2"
  end
end

function UISeasonMazeBeadTips:_RegisterFuncs()
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

function UISeasonMazeBeadTips:GetAttStr()
  self._attStr = {}
  local data = self:GetBeadInfo(self._uid)
  self._fixValues = nil
  if data then
    self._fixValues = data.incr_value
  end
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

function UISeasonMazeBeadTips:GetFixValue(values, beadAttType)
  if values and beadAttType and values[beadAttType] then
    return values[beadAttType]
  end
  return 0
end

function UISeasonMazeBeadTips:GetAttValueStr(beadAttType, cfgValue, cfgStr, isPercent)
  local func = self._funcs[beadAttType]
  func = func or self._DefaultFunc
  func(self, beadAttType, cfgValue, cfgStr, isPercent)
end

function UISeasonMazeBeadTips:_DefaultFunc(beadAttType, cfgValue, cfgStr, isPercent)
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

function UISeasonMazeBeadTips:_EnergyFunc(beadAttType, cfgValue, cfgStr, isPercent)
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

function UISeasonMazeBeadTips:_EnergyRevise(beadAttType, cfgValue, cfgStr, isPercent)
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

function UISeasonMazeBeadTips:_HitFunc(beadAttType, cfgValue, cfgStr, isPercent)
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

function UISeasonMazeBeadTips:_CritHurtFunc(beadAttType, cfgValue, cfgStr, isPercent)
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

function UISeasonMazeBeadTips:_ToPercent(isPercent, value)
  if isPercent then
    local x, y = math.modf(math.floor(value * 0.1))
    return x .. "%%"
  else
    local x, y = math.modf(math.floor(value))
    return tostring(x)
  end
end

function UISeasonMazeBeadTips:_ToColorStr(colorType, str)
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

function UISeasonMazeBeadTips:SetCloseBtnVisble(bVisible)
  self._closeBtnGo:SetActive(bVisible)
end

function UISeasonMazeBeadTips:GetBeadInfo(uid)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  if seasonMazeObj then
    local component = seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
    local componentInfo = component:GetComponentInfo()
    if componentInfo and componentInfo.m_auto_bead_map then
      for _, value in pairs(componentInfo.m_auto_bead_map) do
        if value.bead_info and value.bead_info.unique_id == uid then
          return value
        end
      end
    end
  end
  return nil
end

function UISeasonMazeBeadTips:_SetFuncBtn()
  self._funcBtn:SetActive(self._btnType ~= SeasonMazeBeadTipsBtnType.None)
  if self._btnType == SeasonMazeBeadTipsBtnType.Demount then
    self._funcBtnText:SetText(StringTable.Get("str_season_maze_bead_demount"))
  elseif self._btnType == SeasonMazeBeadTipsBtnType.Equiped then
    self._funcBtnText:SetText(StringTable.Get("str_season_maze_bead_equiped"))
  elseif self._btnType == SeasonMazeBeadTipsBtnType.RemoveSynthesis then
    self._funcBtnText:SetText(StringTable.Get("str_season_maze_bead_removesynthesis"))
  elseif self._btnType == SeasonMazeBeadTipsBtnType.AddSynthesis then
    self._funcBtnText:SetText(StringTable.Get("str_season_maze_bead_addsynthesis"))
  end
end
