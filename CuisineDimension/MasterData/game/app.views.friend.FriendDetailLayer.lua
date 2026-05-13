local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local MedalCsv = require("csvdata.medal")
local uiData = {
  csbFile = "ui/friend/FriendDetailLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    roleNode = "popAction/roleNode",
    name = "popAction/name",
    id = "popAction/id",
    medal = "popAction/medal",
    btnClose = "popAction/btnClose",
    addBtn = "popAction/addBtn",
    informBtn = "popAction/informBtn"
  }
}
local FriendDetailLayer = class("FriendDetailLayer", UIBase)

function FriendDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FriendDetailLayer:init(params)
  self.role = params.role
  self.btnClose:setTouchScale()
  self.addBtn:setTouchScale()
  self.informBtn:setTouchScale()
  self.addBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.informBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btnClose:setCallback(function()
    if params.callback then
      params.callback()
    end
    self:close()
  end)
  self.addBtn:setCallback(function()
    game:sendData(actionCodes.Friend_applyRpc, MsgPack.pack({
      roleId = self.role.roleId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Friend_applyRpc, function(event)
      UIHelper.removeWaiting()
      local msgRes = MsgPack.unpack(event.data)
      if not msgRes.result then
        SysError(SYS_ERROR_FRIEND_APPLIED)
        self.addBtn:setTitleText("已申请")
        self.addBtn:setTouchEnabled(false)
        return
      end
      self.addBtn:setCallback(function()
        SysError(msgRes.result)
      end)
      SysError(msgRes.result)
    end)
  end)
  if not params.showAdd or self.role.roleId == game.role.id then
    self.addBtn:hide()
    self.informBtn:hide()
  end
  if self.role.isFriend then
    self.addBtn:setTitleText("已是好友")
    self.addBtn:setTouchEnabled(false)
  elseif self.role.hadApply then
    self.addBtn:setTitleText("已申请")
    self.addBtn:setTouchEnabled(false)
  end
  if not params.chatData then
    self.informBtn:hide()
    self.addBtn:setPositionX(338)
  end
  self.informBtn:setCallback(function()
    local layer = game:createView("chat.InformLayer", {
      role = self.role,
      chatData = params.chatData
    })
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
    end)
  end)
end

function FriendDetailLayer:showData(params)
  self.name:setString(self.role.name)
  self.id:setString(self.role.union == 0 and self.role.roleId or string.format("%s 协会：%s", self.role.roleId, self.role.unionName))
  self.name:anch(0.5, 0.5):setPositionX(376)
  if self.name:getContentSize().width > 210 then
    self.name:anch(0, 0.5):setPositionX(267)
  end
  UIHelper.makeFontClear(self.name)
  local bg = UIHelper.newImageView(PicCsv[self.role.headIconTag].res):addTo(self.roleNode)
  display.newSprite(FramCsv[self.role.headFrameTag].res):center(bg):addTo(bg)
  local medals = json.decode(self.role.medals) or {}
  if next(medals) then
    local sortMedals = {}
    for style, id in pairs(medals) do
      local data = MedalCsv[tonumber(style)]
      if data and data[id] then
        table.insert(sortMedals, data[id])
      end
    end
    table.sort(sortMedals, function(a, b)
      return a.order < b.order
    end)
    for idx, data in ipairs(sortMedals) do
      UIHelper.newImageView(data.res):anch(0.5, 1):pos(30 + (idx - 1) * 43, 1):scale(0.6):addTo(self.medal)
    end
  else
    display.newTTFLabel({
      text = "未展示勋章",
      size = 18,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 1):pos(0, -2):addTo(self.medal)
  end
end

return FriendDetailLayer
