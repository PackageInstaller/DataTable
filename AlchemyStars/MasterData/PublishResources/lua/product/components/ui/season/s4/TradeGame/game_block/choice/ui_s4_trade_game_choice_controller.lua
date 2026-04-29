_class("UIS4TradeGameChoiceController", UIController)
UIS4TradeGameChoiceController = UIS4TradeGameChoiceController

function UIS4TradeGameChoiceController:OnShow(uiParams)
  self._optionDataTb = uiParams[1]
  self._callback = uiParams[2]
  self:_GetComponents()
  self:_InitComponents()
end

function UIS4TradeGameChoiceController:_GetComponents()
  self._info = self:GetUIComponent("UILocalizationText", "Info")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIS4TradeGameChoiceController:_InitComponents()
  local empty = true
  local info = ""
  for i, data in pairs(self._optionDataTb) do
    if data.isSuccess then
      local str = "str_season_s4_trade_game_choice" .. data.valueType
      local txt = data.value > 0 and "+" .. data.value or data.value
      info = info .. StringTable.Get(str) .. " " .. txt
      if i ~= table.count(self._optionDataTb) and self._optionDataTb[i + 1].isSuccess then
        info = info .. "\n"
      end
      empty = false
    end
  end
  if empty then
    info = StringTable.Get("str_season_s4_trade_game_choice_empty")
  end
  self._info:SetText(info)
end

function UIS4TradeGameChoiceController:_Close()
  if self._callback then
    self._callback()
  end
  self:StartTask(function(TT)
    self:Lock("uieff_UIS4TradeGameChoiceController_out")
    self._anim:Play("uieff_UIS4TradeGameChoiceController_out")
    YIELD(TT, 334)
    self:UnLock("uieff_UIS4TradeGameChoiceController_out")
    self:CloseDialog()
  end)
end

function UIS4TradeGameChoiceController:CheckBtnOnClick()
  self:_Close()
end
