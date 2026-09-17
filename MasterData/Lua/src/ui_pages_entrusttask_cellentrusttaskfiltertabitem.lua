local module = class("cellEntrustTaskFilterTabItem", G_UIModuleBase)
local _dungeonEntrustTagTpl = L_GameTpl:getDungeonEntrustTagTpl()
local _trainTaskGroup = L_GameTpl:getTrainTaskGroupTpl()

function module.bind()
  return {
    txt_selectName = "",
    txt_unSelectName = "",
    img_selectIcon = "",
    img_unSelectIcon = "",
    tabId = -1,
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    }
  }
end

function module:checkIsSpecialFilter(id)
  local cfg = _dungeonEntrustTagTpl:getTplById(id)
  return _dungeonEntrustTagTpl:checkIsSpecial(cfg)
end

function module:open()
  self.bind.tabId = self.bind.id
  if self.bind.tabId ~= -1 then
    local tpl = _dungeonEntrustTagTpl:getTplById(self.bind.id)
    if not tpl then
      return
    end
    self.bind.txt_selectName = _dungeonEntrustTagTpl:getName(tpl)
    self.bind.txt_unSelectName = _dungeonEntrustTagTpl:getName(tpl)
    if self:checkIsSpecialFilter(self.bind.id) then
      self.bind.img_selectIcon = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_fyqb.png"
      self.bind.img_unSelectIcon = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_fyqb.png"
    else
      self.bind.img_selectIcon = _dungeonEntrustTagTpl:getIcon(tpl)
      self.bind.img_unSelectIcon = _dungeonEntrustTagTpl:getIcon(tpl)
    end
  else
    local tpl = _trainTaskGroup:getTplById(self.bind.type)
    self.bind.txt_selectName = _trainTaskGroup:getTrainTaskName(tpl)
    self.bind.txt_unSelectName = _trainTaskGroup:getTrainTaskName(tpl)
    self.bind.tabId = self.bind.type
    local imgPath = _trainTaskGroup:getImgPath(tpl)
    self.bind.img_selectIcon = imgPath
    self.bind.img_unSelectIcon = imgPath
  end
  self.modules.moduleRewardUp:setEntrustType(self.bind.id)
end

return module
