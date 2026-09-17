local this = class("moduleExploreGroup_sight", G_UIModuleBase)
local _exploreTpl = L_GameTpl:getExploreTpl()

function this.bind()
  return {
    toggle_finish = false,
    txt_nameOn = "",
    txt_nameOff = "",
    list_sightDetail = {
      moduleName = "pages/explore/cell/cellExploreSight"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refresh()
end

function this:initGroupContent(data)
  local cur = 0
  local total = 0
  local dataList = {}
  for i, v in pairs(data.groupData) do
    local isFinish = false
    local serverData = L_WorldExploreStore:getMissionInfoById(_exploreTpl:getId(v))
    if not table.isEmpty(serverData) then
      isFinish = serverData.complete
    end
    if isFinish then
      cur = cur + 1
    end
    table.insert(dataList, {
      img_sightOn = _exploreTpl:getExploreIcon(v),
      img_sightOff = _exploreTpl:getExploreIcon(v),
      toggle_finish = isFinish,
      id = _exploreTpl:getId(v),
      data = v
    })
    total = total + 1
  end
  self.bind.toggle_finish = cur >= total and not math.isEmpty(cur)
  local limit = cur > total and total or cur
  self.bind.txt_nameOn = string.format("%s【%d/%d】", data.name, limit, total)
  self.bind.txt_nameOff = self.bind.txt_nameOn
  self.bind.list_sightDetail:clear()
  self.bind.list_sightDetail:insert_array(dataList)
end

return this
