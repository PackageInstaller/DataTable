local this = class("pagePetTalentUpgradeSuccess", G_UIPageBase)
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local attId = {
  L_Const.battleAtt.MAXHP,
  L_Const.battleAtt.ATK,
  L_Const.battleAtt.DEF,
  L_Const.battleAtt.MDEF
}

function this.bind()
  return {
    scrollList_att = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPetPage(options)
  self._callback = options.callback or nil
end

function this:initPetPage(options)
  local data = options.data or {}
  local tmp = {}
  local pet = L_PetStore:getPetItem(options.petId)
  self.bind.txt_mainAtt_value_new = tostring(pet.lv)
  for i, v in ipairs(data) do
    local tpl = battleInfoTpl:getTplById(v.enumId)
    local isBgShow = math.floor(i % 2) > 0
    local element = {
      toggle_state = isBgShow,
      curAttr = battleInfoTpl:getShowTxtComma(v.enumId, v.oldValue),
      nextAttr = battleInfoTpl:getShowTxtComma(v.enumId, v.newValue),
      name = battleInfoTpl:getName(tpl),
      icon = battleInfoTpl:getIcon(tpl),
      active_icon = true,
      id = v.enumId
    }
    table.insert(tmp, element)
  end
  self.bind.scrollList_att:clear()
  self.bind.scrollList_att:insert_array(tmp)
end

function this:close(options)
  this.super.close(self, options)
  if self._callback then
    self._callback()
  end
end

return this
