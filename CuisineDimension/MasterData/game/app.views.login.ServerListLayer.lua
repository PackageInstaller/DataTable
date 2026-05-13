local uiData = {
  csbFile = "ui/login/ServerListLayer.csb",
  mask = true,
  widgets = {
    lastLoginBtn = "all_server/last_login/button",
    recommendBtn = "all_server/recommend/button",
    serverListView = "all_server/serverList"
  }
}
local ServerListLayer = class("ServerListLayer", UIBase)

function ServerListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ServerListLayer:showServerInfo(sender, serverId)
  local parentSize = sender:getContentSize()
  local serverIds = table.keys(self.serverList)
  table.sort(serverIds, function(a, b)
    return a < b
  end)
  local index = table.indexof(serverIds, serverId)
  local serverInfo = self.serverList[serverId]
  local color = serverInfo.free > 0.2 and UIHelper.hex2rgb("fb5311") or UIHelper.hex2rgb("19ec1e")
  display.newTTFLabel({
    text = string.format("%d区 %s", index, serverInfo.name),
    color = color
  }):anch(0, 0.5):pos(40, parentSize.height / 2):addTo(sender)
  local status = ""
  if serverInfo.free >= 0.8 then
    status = "爆满"
  elseif serverInfo.free >= 0.2 then
    status = "空闲"
  else
    status = "新服"
  end
  display.newTTFLabel({text = status, color = color}):anch(1, 0.5):pos(parentSize.width - 40, parentSize.height / 2):addTo(sender)
  sender:setCallback(function()
    UserData.lastServerId = serverId
    GameState.save(UserData)
    self.parent:showCurrentServer()
    self:close()
  end)
end

function ServerListLayer:init(params)
  self.serverList = params.serverList
  self.parent = params.parent
  for serverId, serverInfo in pairs(self.serverList) do
    if serverInfo.recommend then
      self.recommend = serverId
      break
    end
  end
  local serverIds = table.keys(self.serverList)
  table.sort(serverIds, function(a, b)
    return b < a
  end)
  local lastServerId = UserData.lastServerId
  if lastServerId and self.serverList[lastServerId] then
    self:showServerInfo(self.lastLoginBtn, lastServerId)
  end
  if self.recommend then
    self:showServerInfo(self.recommendBtn, self.recommend)
  end
  local cellSize = self.lastLoginBtn:getContentSize()
  local nodeSize = cc.size(self.serverListView:getContentSize().width - 20, cellSize.height)
  for index = 1, #serverIds, 2 do
    local node = ccui.Widget:create()
    node:size(nodeSize):addTo(self.serverListView)
    
    local function pinLocation(parent, serverId)
      if not UserData.lastServerId or UserData.lastServerId ~= serverId then
        return
      end
      display.newSprite("ui/login/location.png"):anch(0, 0.5):pos(5, cellSize.height / 2):addTo(parent)
    end
    
    local leftBtn = UIHelper.extend(ccui.Button:create())
    leftBtn:setImages("ui/login/", {
      "cell_normal.png",
      "cell_selected.png"
    })
    self:showServerInfo(leftBtn, serverIds[index])
    leftBtn:anch(0, 0):pos(20, 0):addTo(node)
    pinLocation(leftBtn, serverIds[index])
    if serverIds[index + 1] then
      local rightBtn = UIHelper.extend(ccui.Button:create())
      rightBtn:setImages("ui/login/", {
        "cell_normal.png",
        "cell_selected.png"
      })
      self:showServerInfo(rightBtn, serverIds[index + 1])
      rightBtn:anch(1, 0):pos(nodeSize.width - 20, 0):addTo(node)
      pinLocation(rightBtn, serverIds[index + 1])
    end
  end
end

return ServerListLayer
