local this = class("moduleProfession", G_UIModuleBase)
local _professionTpl = L_GameTpl:getProfessionTpl()
local heroTpl = L_GameTpl:getHeroTpl()
local groupsTpl = L_GameTpl:getGroupsTpl()

function this.bind()
  return {
    img_groupIcon = "",
    txt_groupName = "",
    professionList = {
      moduleName = "pages/elementalRestraint/cellProfessionDescription"
    },
    focusIndex = 1
  }
end

function this:open()
  self.bind.focusIndex = 1
end

function this:initModule(tplId)
  local tpl = heroTpl:getTplById(tplId)
  local position = heroTpl:getPosition(tpl)
  local professions = _professionTpl:getProfessions()
  local index = 1
  local data = {}
  for k, v in ipairs(professions) do
    local isHighLight = false
    if _professionTpl:getId(v) == position then
      isHighLight = true
    end
    table.insert(data, {
      id = _professionTpl:getId(v),
      isHighLight = isHighLight
    })
    if isHighLight then
      index = k
    end
  end
  self.bind.professionList:clear()
  self.bind.professionList:insert_array(data)
  self.bind.focusIndex = index
  local professionId = _professionTpl:getId(professions[self.bind.focusIndex])
  local professionTpl = _professionTpl:getTplById(professionId)
  self.bind.txt_groupName = _professionTpl:getName(professionTpl)
  self.bind.img_groupIcon = _professionTpl:getIcon(professionTpl, 3)
end

function this:playAnim()
  self.parent.bindComponents.anim:Play("anim_elementalrestraint_toprofession")
end

return this
