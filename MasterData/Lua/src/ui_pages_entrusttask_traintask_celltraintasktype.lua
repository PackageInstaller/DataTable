local this = class("cellTrainTaskType", G_UIModuleBase)
local _trainTaskGroup = L_GameTpl:getTrainTaskGroupTpl()

function this.bind()
  return {
    tabId_type = 1,
    txt_name = "",
    text_nameoff = "",
    img_icon = nil,
    img_iconoff = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  if not self.isBind then
    return
  end
  self:initCell()
end

function this:initCell()
  local tpl = _trainTaskGroup:getTplById(self.bind.type)
  self.bind.txt_name = _trainTaskGroup:getTrainTaskName(tpl)
  self.bind.text_nameoff = _trainTaskGroup:getTrainTaskName(tpl)
  self.bind.tabId_type = self.bind.type
  local imgPath = _trainTaskGroup:getImgPath(tpl)
  self.bind.img_icon = imgPath
  self.bind.img_iconoff = imgPath
end

return this
