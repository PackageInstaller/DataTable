local this = class("cellSituationStampSelectItem", G_UIModuleBase)

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
      self:deleteCurStamp()
      self:emit("onClickDel", self.bind.id)
    end
  }
end

function this:refreshNum()
  if not L_SituationManager.curSolution then
    return
  end
  local container = self:getCurStampContainer()
  if container and 0 < #container then
    self.bind.active_select = true
    self.bind.txt_num = string.format("%d", #container)
  elseif not container or #container <= 0 then
    self.bind.active_select = false
    self.bind.txt_num = ""
  end
end

function this:getCurStampContainer()
  if not L_SituationManager.curSolution then
    return nil
  end
  local stampContainers = {}
  for i, v in pairs(L_SituationManager.curSolution.stampContainers) do
    if v.data.configId == self.bind.id then
      table.insert(stampContainers, v)
    end
  end
  return stampContainers
end

function this:deleteCurStamp()
  local stampContainers = self:getCurStampContainer()
  local lastContainer = stampContainers[#stampContainers]
  local param = {
    guid = lastContainer.guid
  }
  L_SituationManager:addRemoveStampCommand(param)
end

function this:close()
end

return this
