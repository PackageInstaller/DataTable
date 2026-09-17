local this = class("cellStackElement_Boss", G_UIModuleBase)
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()
local _battleDamageTpl = L_GameTpl:getBattleDamagetextTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local BgBattleElement = {
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_fire.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_wind.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_earth.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_wood.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_ice.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_water.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_thunder.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_light.png",
  "UI/Page/BattleHpBar/tex_battle_icon_echobg_2_dark.png"
}
local materialKey = {
  "mat_battle_element_fx_huo",
  "mat_battle_element_fx_feng",
  "mat_battle_element_fx_di",
  "mat_battle_element_fx_mu",
  "mat_battle_element_fx_bing",
  "mat_battle_element_fx_shui",
  "mat_battle_element_fx_lei",
  "mat_battle_element_fx_guang",
  "mat_battle_element_fx_an",
  "mat_battle_element_fx_wu"
}
local iconColorKey = {
  "#A04141",
  "#AB6007",
  "#896146",
  "#5B831F",
  "#2D8578",
  "#3C71A7",
  "#435399",
  "#A1790D",
  "#594089"
}
local animator_param_Init = "ShowInit"
local animator_param_Hide = "Hide"
local animator_param_Show = "Show"
local animator_param_Cast = "Cast"
local animator_param_CastHide = "Cast&Hide"

function this.bind()
  return {
    alpha_cell = 0,
    active_cell = true,
    img_icon = "",
    color_icon = nil,
    img_bgNormal = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.stage = L_Const.hpStackState.Normal
  self:hideView()
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:getElementId()
  if self.element then
    return self.element.elementId
  end
  return 0
end

function this:setElement(element)
  self.element = element
  self:initAni()
  local elementId = self.element.elementId
  local config = _battleDamageTpl:getTplById(elementId)
  local elemenType = _elementTypeTpl:getTplById(config.element)
  self.bind.img_icon = _elementTypeTpl:getPetPuzzleIcon(elemenType, 2)
  self.bind.img_bgNormal = BgBattleElement[config.element]
  local _, color = C_ColorUtility.TryParseHtmlString(iconColorKey[config.element])
  self.bind.color_icon = color
  self.bindComponents.fx.material = self.bindComponents[materialKey[config.element]].material
end

function this:switchState(_state)
  if self.stage ~= _state then
    self.stage = _state
    L_TimerManager:newOrResetTimer(self, "playAin", function()
      self.stage = L_Const.hpStackState.Normal
      if _state == L_Const.hpStackState.Reduce then
        self.element = nil
        self:hideView()
      end
      self:emit("onStackAnimPlayEnd")
    end, 1)
  end
end

function this:initAni()
  self.bindComponents.animator:Play(animator_param_Init)
  self.stage = L_Const.hpStackState.Normal
  self:showView()
end

function this:playShowAni()
  self:showView()
  self:playHideAni()
  self.bindComponents.animator:SetTrigger(animator_param_Show)
  self:switchState(L_Const.hpStackState.Show)
end

function this:playHideAni()
  self.bindComponents.animator:Play(animator_param_Hide, 0)
end

function this:playCastAni()
  self.bindComponents.animator:SetTrigger(animator_param_Cast)
  self:switchState(L_Const.hpStackState.Cast)
end

function this:playReduceAni()
  self.bindComponents.animator:SetTrigger(animator_param_CastHide)
  self:switchState(L_Const.hpStackState.Reduce)
end

function this:clearAndHide()
  self.element = nil
  self.stage = L_Const.hpStackState.Normal
  self:hideView()
end

function this:hideView()
  self.bind.alpha_cell = 0
end

function this:showView()
  self.bind.active_cell = true
  self.bind.alpha_cell = 1
end

return this
