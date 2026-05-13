local rankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local UnitCsv = require("csvdata.unit")
local DressCsv = require("csvdata.hero_skin")
local UnionBattleRes = "ui/union/battle/"
local uiData = {
  csbFile = "ui/union/UnionBattleRankLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    rankList = "popAction/clip/rankList",
    title = "popAction/title",
    closeBtn = "closeBtn"
  }
}
local UnionBattleRankLayer = class("UnionBattleRankLayer", UIBase)

function UnionBattleRankLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionBattleRankLayer:init(params)
end

function UnionBattleRankLayer:showData(params)
  local rankList = params.rankList
  local rankType = params.msyType
  local titleText = ""
  if rankType == 1 then
    titleText = "个人积分榜"
  elseif rankType == 2 then
    titleText = "协会积分榜"
  elseif rankType == 3 then
    titleText = "协会成员积分榜"
  end
  self.title:setString(titleText)
  self.rankList:removeAllChildren()
  self.lastChoose = nil
  if not next(rankList) then
    display.newTTFLabel({
      text = "暂时没有数据",
      size = 22,
      color = UIHelper.hex2rgb("#b26b3f")
    }):center(self.rankList):addTo(self.rankList)
  end
  if rankType == 1 or rankType == 3 then
    for idx, data in ipairs(rankList) do
      self:createPlayercell(data, idx)
    end
  elseif rankType == 2 then
    for idx, data in ipairs(rankList) do
      self:createUnionCell(data)
    end
  end
  self.closeBtn:setCallback(function()
    self:close()
  end)
  self.rankList:requestDoLayout()
  self.rankList:jumpToTop()
end

function UnionBattleRankLayer:createPlayercell(data, idx)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(600, 60)):addTo(self.rankList)
  local isSelf = game.role.name == data.name
  local rankColor = isSelf and "#ffe13c" or "#ffffff"
  local cell = UIHelper.newImageView(UnionBattleRes .. (isSelf and "playerCellSelf.png" or "playerCell.png")):pos(305, 32):addTo(viewNode)
  display.newTTFLabel({
    text = idx,
    size = 40,
    color = UIHelper.hex2rgb(rankColor)
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(35, 30):addTo(cell)
  local bg = UIHelper.newImageView(PicCsv[tonumber(data.head)].res):addTo(cell):pos(94, 28):scale(0.38)
  display.newSprite(FramCsv[tonumber(data.headFrame)].res):center(bg):addTo(bg)
  local nameLabel = display.newTTFLabel({
    text = data.name,
    size = 20,
    color = UIHelper.hex2rgb("#78644e")
  }):anch(0, 0.5):pos(130, 28):addTo(cell)
  MRichText.new({
    text = string.format("等级:%d", data.level),
    size = 22,
    color = UIHelper.hex2rgb("#78644e")
  }):anch(0, 0.5):pos(350, 28):addTo(cell)
  MRichText.new({
    text = string.format("积分:%d", data.score),
    size = 22,
    color = UIHelper.hex2rgb("#78644e")
  }):anch(0, 0.5):pos(500, 28):addTo(cell)
end

function UnionBattleRankLayer:createUnionCell(data)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(600, 104)):addTo(self.rankList)
  local cell = display.newSprite(UnionBattleRes .. "unionCell.png"):pos(305, 54):addTo(viewNode)
  local iconBg = display.newSprite(UnionBattleRes .. string.format("icon_bg_%d.png", data.headId)):scale(0.8):pos(55.5, 50):addTo(cell)
  display.newSprite(UnionBattleRes .. string.format("icon_%d.png", data.headId)):center(iconBg):addTo(iconBg)
  display.newTTFLabel({
    text = data.name,
    size = 26,
    color = UIHelper.hex2rgb("#78644e")
  }):anch(0, 0.5):pos(117, 72):addTo(cell)
  display.newTTFLabel({
    text = data.desc == "" and "~無~" or data.desc,
    size = 18,
    dimensions = cc.size(640, 0)
  }):anch(0, 0.5):pos(124, 29):addTo(cell)
  display.newTTFLabel({
    text = string.format("总积分:%d", data.score),
    size = 24,
    color = UIHelper.hex2rgb("#78644e")
  }):anch(0, 0.5):pos(430, 72):addTo(cell)
end

return UnionBattleRankLayer
