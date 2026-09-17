local cls = class("cellEntrustEnemy", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _eleTpl = L_GameTpl:getElementTypeTpl()

function cls.bind()
  return {
    txt_level = "",
    img_icon = "",
    active_select = false,
    img_ele_bg = "",
    img_ele_icon = "",
    active_boss_sign = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function cls:setSelect(bShow)
  self.bind.active_select = bShow
end

function cls:refresh()
  if self.bind.entrustType == L_Const.EntrustTypeEnum.PetDuel then
    local petCfg = _petTpl:getTplById(self.bind.id)
    self.bind.img_icon = _petTpl:getPetIcon(petCfg)
    self.bind.txt_level = tostring(self.bind.level)
    self:setSelect(self.bind.selectIndex == self.bind.index)
    local tpl = _petTpl:getTplById(self.bind.id)
    local firstElement = _petTpl:getFirstElement(tpl)
    local eTpl = _eleTpl:getTplById(firstElement)
    self.bind.img_ele_bg = _eleTpl:getProfessionColor(eTpl, L_Const.professionColorType.square)
    self.bind.img_ele_icon = _eleTpl:getPetPuzzleIcon(_eleTpl:getTplById(firstElement), 2)
    return
  end
  local enemyCfg = _enemyTpl:getTplById(self.bind.id)
  self.bind.img_icon = _enemyTpl:getAvatarTexture(enemyCfg)
  self.bind.txt_level = tostring(self.bind.level)
  local firstElement = _enemyTpl:getFirstElement(enemyCfg)
  local eTpl = _eleTpl:getTplById(firstElement)
  self.bind.img_ele_bg = _eleTpl:getProfessionColor(eTpl, L_Const.professionColorType.square)
  self.bind.img_ele_icon = _eleTpl:getPetPuzzleIcon(_eleTpl:getTplById(firstElement), 2)
  self:setSelect(self.bind.selectIndex == self.bind.index)
  local enemyType = _enemyTpl:getEnemyType(enemyCfg)
  self.bind.active_boss_sign = enemyType and enemyType == L_Const.enemyType.boss
end

return cls
