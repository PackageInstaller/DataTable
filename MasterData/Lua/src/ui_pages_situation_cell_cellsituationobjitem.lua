local this = class("cellSituationObjItem", G_UIModuleBase)
local _situationTabTpl = L_GameTpl:getSituationTabTpl()

function this.bind()
  return {
    img_icon = "",
    txt_num = "",
    active_select = false
  }
end

function this.methods()
  return {
    onClickAdd = function(self)
      self:emit("onClickAdd", self.bind.id)
    end,
    onClickDel = function(self)
      self:deleteCurObj()
      self:emit("onClickDel", self.bind.id)
    end
  }
end

function this:init()
end

function this:open()
  self:getCurObjContainer()
end

function this:refresh()
  self:refreshIcon()
  self:refreshNum()
end

function this:refreshIcon()
end

function this:refreshSelect()
end

function this:refreshNum()
  if not L_SituationManager.curSolution then
    return
  end
  local container = self:getCurObjContainer()
  if container and 0 < #container then
    self.bind.active_select = true
    self.bind.txt_num = string.format("%d", #container)
  elseif not container or #container <= 0 then
    self.bind.active_select = false
    self.bind.txt_num = ""
  end
end

function this:getCurObjContainer()
  if not L_SituationManager.curSolution then
    return nil
  end
  local objContainers = {}
  for i, v in pairs(L_SituationManager.curSolution.objContainers) do
    if v.data.configId == self.bind.id then
      table.insert(objContainers, v)
    end
  end
  return objContainers
end

function this:deleteCurObj()
  local objContainers = self:getCurObjContainer()
  local lastContainer = objContainers[#objContainers]
  local param = {
    guid = lastContainer.guid
  }
  L_SituationManager:addRemoveObjCommand(param)
end

function this:close()
end

return this
