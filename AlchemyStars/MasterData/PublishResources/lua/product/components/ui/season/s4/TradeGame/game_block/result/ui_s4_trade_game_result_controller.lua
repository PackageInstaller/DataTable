_class("UIS4TradeGameResultController", UIController)
UIS4TradeGameResultController = UIS4TradeGameResultController

function UIS4TradeGameResultController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._optionDataTb = uiParams[2]
  self._income = uiParams[3]
  self._statue = uiParams[4]
  self._harborID = uiParams[5]
  self._callback = uiParams[6]
  self:_GetComponents()
  self:_InitComponents()
  self:_AttachEvents()
  self:StartTask(function(TT)
    self:Lock("uieff_UIS4TradeGameResultController_in")
    self._anim:Play("uieff_UIS4TradeGameResultController_in")
    YIELD(TT, 334)
    self:UnLock("uieff_UIS4TradeGameResultController_in")
  end)
end

function UIS4TradeGameResultController:_GetComponents()
  self._shipName = self:GetUIComponent("UILocalizationText", "shipName")
  self._chooseInfo = self:GetUIComponent("UILocalizationText", "ChooseInfo")
  self._statueInfo = self:GetUIComponent("UILocalizationText", "StatueInfo")
  self._resValue = self:GetUIComponent("UILocalizationText", "resValue")
  self._infoParentRect = self:GetUIComponent("RectTransform", "InfoParent")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIS4TradeGameResultController:_InitComponents()
  local showIndexGroup = {}
  local infoGroup = {
    "",
    "",
    ""
  }
  self._shipName:SetText(StringTable.Get("str_season_s4_trade_ship_" .. self._harborID))
  local canAdd = false
  for i, data in pairs(self._optionDataTb) do
    local info = infoGroup[data.index]
    if table.icontains(showIndexGroup, data.index) and canAdd and data.isSuccess then
      info = info .. "      "
      infoGroup[data.index] = info
      canAdd = false
    elseif not table.icontains(showIndexGroup, data.index) then
      info = "#" .. data.index .. " "
      table.insert(showIndexGroup, data.index)
      infoGroup[data.index] = info
      canAdd = false
    end
    if data.isSuccess then
      local str = "str_season_s4_trade_game_choice" .. data.valueType
      local txt = data.value > 0 and "+" .. data.value or data.value
      info = info .. StringTable.Get(str) .. " <color=#b03d2d>" .. txt .. "</color>" .. "\n"
      infoGroup[data.index] = info
      canAdd = true
    else
      canAdd = false
    end
  end
  local showInfo = ""
  for _, txt in pairs(infoGroup) do
    if string.len(txt) <= 3 then
      showInfo = showInfo .. txt .. StringTable.Get("str_season_s4_trade_game_choice_empty") .. "\n"
    else
      showInfo = showInfo .. txt
    end
  end
  self._resValue:SetText(self._income)
  self._chooseInfo:SetText(showInfo)
  self._statueInfo:SetText(math.floor(self._statue * 100) .. "%")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._infoParentRect)
end

function UIS4TradeGameResultController:_AttachEvents()
end

function UIS4TradeGameResultController:_Close()
  if self._callback then
    self._callback()
  end
  self:StartTask(function(TT)
    self:Lock("uieff_UIS4TradeGameResultController_out")
    self._anim:Play("uieff_UIS4TradeGameResultController_out")
    YIELD(TT, 334)
    self:UnLock("uieff_UIS4TradeGameResultController_out")
    self:CloseDialog()
  end)
end

function UIS4TradeGameResultController:CheckBtnOnClick()
  self:_Close()
end
