_class("UIN25IdolCommonTips", UICustomWidget)
UIN25IdolCommonTips = UIN25IdolCommonTips

function UIN25IdolCommonTips:HideBtnOnClick(go)
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolCommonTrainPoint_tips_out")
end

function UIN25IdolCommonTips:SetData(type)
  self:_SetTips(type)
  local bgState = type == 4 and 1 or 2
  local tb = {
    "uieff_UIN25IdolCommonTrainPoint_tips_leftin",
    "uieff_UIN25IdolCommonTrainPoint_tips_rightin"
  }
  local anim = tb[bgState]
  UIWidgetHelper.SetAnimationPlay(self, "_anim", anim)
  self:_SetState(bgState)
  self:_SetOffset(bgState)
end

function UIN25IdolCommonTips:_SetTips(type)
  local color = {
    "#907df1",
    "#f57c86",
    "#ffad5a",
    "#d44aee"
  }
  local titleId = {
    "str_n25_idol_game_tip_music_title",
    "str_n25_idol_game_tip_dance_title",
    "str_n25_idol_game_tip_perform_title",
    "str_n25_idol_game_tip_fans_title"
  }
  local title = UIActivityHelper.GetColorText(color[type], StringTable.Get(titleId[type]))
  UIWidgetHelper.SetLocalizationText(self, "_tipsTitle", title)
  local textId = {
    "str_n25_idol_game_tip_music_desc",
    "str_n25_idol_game_tip_dance_desc",
    "str_n25_idol_game_tip_perform_desc",
    "str_n25_idol_game_tip_fans_desc"
  }
  local text = StringTable.Get(textId[type])
  UIWidgetHelper.SetLocalizationText(self, "_tipsText", text)
end

function UIN25IdolCommonTips:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_bgLeft"},
    {"_bgRight"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN25IdolCommonTips:_SetOffset(state)
  local trans = self:GetGameObject("_tips").transform
  local pos = {
    [1] = {
      x = trans.rect.width * 0.5 - 150,
      y = 0
    },
    [2] = {
      x = -trans.rect.width * 0.5 + 75,
      y = 0
    }
  }
  local posTrans = self:GetGameObject("_pos").transform
  posTrans.anchoredPosition = Vector2(pos[state].x, pos[state].y)
end
