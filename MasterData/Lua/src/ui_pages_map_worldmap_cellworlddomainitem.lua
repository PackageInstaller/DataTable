local this = class("cellWorldDomainItem", G_UIModuleBase)

function this.bind()
  return {
    txt_name = nil,
    img_icon = nil,
    taskLocationList = {
      moduleName = "pages/map/worldMap/cellTaskLocationItem"
    },
    localPosition_position = Unity.Vector3.zero,
    select = false,
    goNew = false
  }
end

function this.methods()
  return {
    onClick_selectDomain = function(self)
      self:emit("onClick_selectDomain", self.bind.config)
    end
  }
end

function this:open()
  if not table.isEmpty(self.bind.taskLocation) then
    local data = {}
    local taskTpl = L_GameTpl:getTaskTpl()
    local taskTypeTpl = L_GameTpl:getTaskTypeTpl()
    for i, v in pairs(self.bind.taskLocation) do
      local tpl = taskTpl:getTplById(v.id)
      if tpl then
        if taskTpl:getType(tpl) == L_Const.taskType.main then
          data = {}
          table.insert(data, {
            img_icon = taskTpl:getMapTaskIcon(tpl)
          })
          break
        end
        table.insert(data, {
          img_icon = taskTpl:getMapTaskIcon(tpl)
        })
      end
    end
    self.bind.taskLocationList:clear()
    self.bind.taskLocationList:insert_array(data)
  end
end

function this:setSelect(b)
  self.bind.select = b
end

return this
