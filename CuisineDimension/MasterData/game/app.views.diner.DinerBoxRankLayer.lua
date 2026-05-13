local rankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local DressCsv = require("csvdata.hero_skin")
local uiData = {
  csbFile = "ui/diner/DinerBoxRankLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    title = "popAction/title",
    rankList = "popAction/clip/rankList",
    me = "popAction/me"
  }
}
local DinerBoxRankLayer = class("DinerBoxRankLayer", UIBase)

function DinerBoxRankLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxRankLayer:init(params)
  self.title:setString("满足度排行榜")
end

function DinerBoxRankLayer:showData(params)
  self.me:removeAllChildren()
  self.rankList:removeAllChildren()
  self.inRank = false
  self.listData = params.rankList or {}
  for idx, data in ipairs(self.listData) do
    self:createOne(idx, data):addTo(self.rankList)
  end
  if not next(self.listData) then
    display.newTTFLabel({
      text = "还没有人装扮便当盒",
      size = 22,
      color = UIHelper.hex2rgb("#b26b3f")
    }):center(self.rankList):addTo(self.rankList)
  end
  display.newTTFLabel({
    text = "我的排名：" .. (self.inRank or "未上榜"),
    size = 16,
    color = UIHelper.hex2rgb("#f2ce88")
  }):addTo(self.me)
  self.rankList:requestDoLayout()
  self.rankList:jumpToTop()
end

function DinerBoxRankLayer:createOne(idx, data)
  local isSelf = data.roleId == game.role.id
  local rankColor = (idx <= 3 or isSelf) and "#ffe13c" or "#ffffff"
  local di = UIHelper.newImageView(rankRes .. (isSelf and "phb3.png" or "phb2.png"))
  if isSelf then
    self.inRank = idx
  end
  local bg = UIHelper.newImageView(PicCsv[data.headIconTag].res):addTo(di):pos(94, 30):scale(0.38)
  display.newSprite(FramCsv[data.headFrameTag].res):center(bg):addTo(bg)
  display.newTTFLabel({
    text = idx,
    size = 42,
    color = UIHelper.hex2rgb(rankColor)
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(35, 30):addTo(di)
  display.newTTFLabel({
    text = data.name,
    size = 20,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(130, 28):addTo(di)
  display.newTTFLabel({
    text = "满足度:",
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(370, 28):addTo(di)
  display.newTTFLabel({
    text = data.comfortPoint,
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(450, 28):addTo(di)
  display.newSprite("ui/diner/box/like_small.png"):anch(0, 0.5):pos(570, 28):addTo(di)
  display.newTTFLabel({
    text = data.like,
    size = 20,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(600, 28):addTo(di)
  if not isSelf then
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/diner/box/", {
      "btn_box_small.png",
      "btn_box_small.png"
    })
    btn:pos(710, 28):addTo(di):setTouchScale()
    btn:setCallback(function()
      game:sendData(actionCodes.Diner_getBoxDataRpc, MsgPack.pack({
        roleId = data.roleId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Diner_getBoxDataRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.boxData then
          if not msg.boxData.boxes[1].box then
            SysError(SYS_ERROR_FRIEND_NO_BOX)
            return
          end
          msg.boxData.allList = self:getList()
          if not next(msg.boxData.allList) then
            return
          end
          game:enterScene("DinerScene", {
            boxData = msg.boxData,
            layerType = "look"
          })
          BackManager:push(function()
            game:enterScene("DinerScene")
            BackManager:push(function()
              game:enterScene("MainScene", {})
            end)
          end)
        else
          SysError(SYS_ERROR_FRIEND_NO_PLAYER)
        end
      end)
    end)
  end
  return di
end

function DinerBoxRankLayer:getList()
  local list = {}
  for _, data in ipairs(self.listData) do
    if data.roleId ~= game.role.id then
      table.insert(list, data.roleId)
    end
  end
  return list
end

return DinerBoxRankLayer
