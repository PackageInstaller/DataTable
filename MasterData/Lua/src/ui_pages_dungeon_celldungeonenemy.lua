local this = class("cellDungeonEnemy", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    img_icon = nil,
    txt_level = nil,
    color_elementBg = nil,
    img_element = nil
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_ItemTplManager:showInfoTip(L_Const.resType.enemy, self.bind.id)
    end
  }
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  local tpl_enemy = _enemyTpl:getTplById(self.bind.id)
  self.bind.img_icon = _enemyTpl:getAvatarTexture(tpl_enemy)
  self.bind.txt_level = string.format("Lv.%s", self.bind.level)
  local ele = _enemyTpl:getElement(tpl_enemy)[1]
  local tpl_ele = _elementTypeTpl:getTplById(ele)
  local _, color = C_ColorUtility.TryParseHtmlString(_elementTypeTpl:getDungeonElementColor(tpl_ele))
  self.bind.color_elementBg = color
  self.bind.img_element = _elementTypeTpl:getDungeonElementIcon(tpl_ele)
end

return this
