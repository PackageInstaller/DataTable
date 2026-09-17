local this = class("moduleExploreGroup_boss", G_UIModuleBase)
local _exploreTpl = L_GameTpl:getExploreTpl()
local shadowPath = "UI/Atlas/Explore/tex_explore_icon_%s_a.png"

function this.bind()
  return {
    toggle_finish = false,
    txt_nameOn = "",
    txt_nameOff = "",
    list_bossDetail = {
      moduleName = "pages/explore/cell/cellExploreBoss"
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
    local path = _exploreTpl:getExploreIcon(v)
    local shadow = string.format(shadowPath, string.match(path, "%d+_%d+"))
    table.insert(dataList, {
      img_bossOn = path,
      img_bossOff = shadow,
      toggle_finish = isFinish,
      id = _exploreTpl:getId(v),
      data = v
    })
    if isFinish then
      cur = cur + 1
    end
    total = total + _exploreTpl:getFillerCount(v)
  end
  self.bind.toggle_finish = cur >= total and not math.isEmpty(cur)
  local limit = cur > total and total or cur
  self.bind.txt_nameOn = string.format("%s【%d/%d】", data.name, limit, total)
  self.bind.txt_nameOff = self.bind.txt_nameOn
  self.bind.list_bossDetail:clear()
  self.bind.list_bossDetail:insert_array(dataList)
end

return this
