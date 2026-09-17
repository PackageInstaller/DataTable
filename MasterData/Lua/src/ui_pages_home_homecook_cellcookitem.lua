local this = class("cellCookItem", G_UIModuleBase)
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()

function this.bind()
  return {
    active_content = true,
    active_needPet = false,
    active_lock = false,
    img_icon = "",
    txt_name = "",
    txt_lock = "",
    active_select = true
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback and not self.bind.active_lock then
        self.bind.callback()
      end
    end
  }
end

function this:open()
  local groupId = self.bind.groupId
  local tpl = _foodGroupTpl:getTplById(groupId)
  self.bind.active_content = tpl ~= nil
  if not tpl then
    return
  end
  self.bind.active_lock = self.bind.isLock
  self.bind.active_needPet = _foodGroupTpl:getIsNeedPet(tpl)
  self.bind.img_icon = _foodGroupTpl:getIcon(tpl)
  self.bind.txt_name = _foodGroupTpl:getName(tpl)
  local unlockLvMap = _foodGroupTpl:getUnlockLevel(tpl)
  self.bind.txt_lock = L_WordsTpl:getValue("notice_cellCookItem", {
    [0] = unlockLvMap[groupId]
  })
end

function this:setSelect(isSelect)
  self.bind.active_select = isSelect
end

return this
