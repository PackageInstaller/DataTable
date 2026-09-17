local this = class("moduleBattleBuffInfoBox", G_UIModuleBase)
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()

function this.bind()
  return {
    text_name = "",
    text_desc = "",
    text_typeName = "",
    text_layer = "",
    image_icon = "",
    img_mask = false,
    info_box = false
  }
end

function this.methods()
  return {}
end

function this:initModuleInfo(buffId, layer, elementType)
  self:refreshTitle(buffId, elementType)
  self:refreshContent(buffId, layer)
end

function this:refreshTitle(buffId, elementType)
  local tpl = _buffInfoTpl:getTplById(buffId)
  self.bind.text_name = _buffInfoTpl:getName(tpl)
  self.bind.text_typeName = _buffInfoTpl:getNote(tpl)
  self.bind.img_mask = elementType == 15
  self.bind.info_box = false
  self.bind.image_icon = _buffInfoTpl:getIcon(tpl)
end

function this:refreshContent(buffId, layer)
  local tpl = _buffInfoTpl:getTplById(buffId)
  self.bind.text_desc = _buffInfoTpl:getDesc(tpl)
  local stage = _buffInfoTpl:getStages(tpl)
  self.bind.text_layer = stage == 1 and string.concat(L_WordsTpl:getValue("ui_hintFight_01"), layer) or ""
end

return this
