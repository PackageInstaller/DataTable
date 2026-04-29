_class("UIN25IdolGamePuppy", UIController)
UIN25IdolGamePuppy = UIN25IdolGamePuppy

function UIN25IdolGamePuppy:_SetBg()
  local url = "n25_ychtfsj_di13"
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIN25IdolGamePuppy:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "_spine", "n25_g_gouzai_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "idle", true)
end

function UIN25IdolGamePuppy:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N25
  self._componentId = ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId
  })
  self._component = self._campaign:GetComponent(self._componentId)
  self._componentInfo = self._campaign:GetComponentInfo(self._componentId)
end

function UIN25IdolGamePuppy:OnShow(uiParams)
  self._eventId = uiParams and uiParams[1]
  self._trainType = uiParams and uiParams[2]
  self._handleCallback = uiParams and uiParams[3]
  self._animCallback = uiParams and uiParams[4]
  if UIActivityHelper.CheckDebugOpen() then
    self._debug = uiParams and uiParams[5]
  end
  self:_SetBg()
  self:_SetSpine()
  local itemInfo = self._component:UI_Cfg_GetSuddenlyEventItemInfo(self._eventId)
  self:_SetQuestion(itemInfo[1].Question)
  self:_SetItems(itemInfo)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioTease)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGamePuppy_puppy_in", 2300)
end

function UIN25IdolGamePuppy:OnHide()
  self._spine = UIWidgetHelper.SetSpineDestroy(self, "_spine")
end

function UIN25IdolGamePuppy:_SetQuestion(txt)
  UIWidgetHelper.SetLocalizationText(self, "_txtName", StringTable.Get("str_n25_idol_game_puppy_question_name"))
  UIWidgetHelper.SetLocalizationText(self, "_txtQuestion", StringTable.Get(txt))
end

function UIN25IdolGamePuppy:_SetItems(itemInfo)
  local eventId = self._eventId
  local trainType = self._trainType
  local widgets = {
    "_item1",
    "_item2",
    "_item3"
  }
  for i, v in ipairs(widgets) do
    local obj = UIWidgetHelper.SpawnObject(self, v, "UIN25IdolGamePuppyItem")
    local icon = itemInfo[i].CondLimitHead
    local txtMain = itemInfo[i].CondLimitName
    local txtSub = not itemInfo[i].Enable and "str_n25_idol_game_puppy_question_cond_disable" or nil
    obj:SetData(i, icon, txtMain, txtSub, function(idx, go)
      if not self._selected then
        self._selected = idx
        self._oldFunNum = self._component:UI_GetFunNum()
        if self._debug then
          self:_OnEventComplete(idx, go, itemInfo)
        else
          local eventType = IdolEventType.IdolEventType_Suddenly
          local optionType = idx
          self._component:Start_HandleIdolCompleteEvent(eventType, optionType, eventId, trainType, function()
            self:_OnEventComplete(idx, go, itemInfo)
          end)
        end
      end
    end)
  end
end

function UIN25IdolGamePuppy:_OnEventComplete(idx, go, itemInfo)
  if self._handleCallback then
    self._handleCallback()
  end
  self:_SetResult(itemInfo[idx])
  local anim = {
    "uieff_UIN25IdolGamePuppy_result_in01",
    "uieff_UIN25IdolGamePuppy_result_in02",
    "uieff_UIN25IdolGamePuppy_result_in03"
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", anim[idx], 600, function()
    go:PlayAnim()
  end)
end

function UIN25IdolGamePuppy:_SetResult(info)
  UIWidgetHelper.SetLocalizationText(self, "_txtResult", StringTable.Get(info.CondLimitResult))
  local funNum = self._oldFunNum
  local funNum2 = self._component:UI_GetFunNum()
  self:_SetResultValue(funNum, funNum2)
  local animName = info.CondLimitSpine
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, animName, true)
end

function UIN25IdolGamePuppy:_SetResultValue(value1, value2)
  UIWidgetHelper.SetLocalizationText(self, "_txtValue1", value1)
  local color = {"#737373", "#fe6767"}
  local c = value1 == value2 and color[1] or color[2]
  local text2 = UIActivityHelper.GetColorText(c, value2)
  UIWidgetHelper.SetLocalizationText(self, "_txtValue2", text2)
end

function UIN25IdolGamePuppy:BtnOnClick(go)
  if self._animCallback then
    self._animCallback()
  end
  self:CloseDialog()
end
