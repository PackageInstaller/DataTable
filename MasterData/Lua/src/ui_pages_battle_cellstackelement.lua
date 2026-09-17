local this = class("cellStackElement", G_UIModuleBase)
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

function this.bind()
  return {
    img_icon = "",
    img_bgNormal = "",
    effect_fx = ""
  }
end

function this:refresh()
  self.element = self.bind.element
  if not self.element or self.element.free then
    return
  end
  local elementId = self.element.elementId
  local config = _battleDamageTpl:getTplById(elementId)
  local elemenType = _elementTypeTpl:getTplById(config.element)
  self.bind.img_icon = _elementTypeTpl:getPetPuzzleIcon(elemenType, 1)
  self.bind.img_bgNormal = BgBattleElement[config.element]
end

return this
