local rankDesRes = "ui/pvp/rankDes/"
local PvpRes = "ui/pvp/main/"
local PvpRandCsv = require("csvdata.pvp_rank")
local uiData = {
  csbFile = "ui/pvp/PvpRankDesLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    node = "popAction/node"
  }
}
local PvpRankDesLayer = class("PvpRankDesLayer", UIBase)

function PvpRankDesLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpRankDesLayer:init(params)
end

function PvpRankDesLayer:showData(params)
  local detal = 103.5
  for group, data in ipairs(PvpRandCsv) do
    self:createOne(data):pos((group - 1) * detal, 0):addTo(self.node)
    if 0 < data.show then
      break
    end
  end
end

function PvpRankDesLayer:createOne(data)
  local bg = display.newSprite(rankDesRes .. "fd" .. data.group .. ".png"):anch(0.5, 0)
  local size = bg:getContentSize()
  display.newSprite(data.res):anch(0.5, 0):pos(size.width / 2, size.height - 27):addTo(bg)
  local scoreDi = display.newSprite(rankDesRes .. "fd8.png"):pos(size.width / 2, size.height - 60):addTo(bg)
  display.newTTFLabel({
    text = "学园点数",
    size = 15,
    color = UIHelper.hex2rgb("#ffd698")
  }):anch(0.5, 0):pos(scoreDi:getContentSize().width / 2, scoreDi:getContentSize().height + 4):addTo(scoreDi)
  display.newTTFLabel({
    text = data.score:toArray("=", true)[1] .. "+",
    size = 18
  }):pos(scoreDi:getContentSize().width / 2, scoreDi:getContentSize().height / 2 + 1):addTo(scoreDi)
  if 0 < data.show then
    local count, detal = 0, 55
    for i = data.group, #PvpRandCsv do
      self:createKingOne(PvpRandCsv[i]):pos(size.width / 2, 3 + count * detal):addTo(bg)
      count = count + 1
    end
  else
    self:createReward(data):addTo(bg):pos(size.width / 2, 17)
  end
  if game.role.pvpInfo.group == data.group or 0 < data.show and game.role.pvpInfo.group > data.group then
    display.newSprite(rankDesRes .. "me.png"):anch(0.5, 0):pos(size.width / 2, 0):addTo(bg, -1)
  end
  return bg
end

function PvpRankDesLayer:createReward(data)
  local count = 0
  if data and data.resetGift then
    count = data.resetGift:toArray("=", true)[2]
  end
  local moneyBg = display.newSprite(PvpRes .. "money_bg.png")
  display.newTTFLabel({
    text = count or 0,
    size = 18,
    color = UIHelper.hex2rgb("#ff8549")
  }):pos(45, 13):addTo(moneyBg)
  return moneyBg
end

function PvpRankDesLayer:createKingOne(data)
  local str = ""
  if data and data.rank then
    if data.rank ~= "" then
      str = "前" .. data.rank:toArray("=", true)[2] .. "名"
    else
      str = "其他"
    end
  end
  local bg = display.newSprite(rankDesRes .. "fd10.png"):anch(0.5, 0)
  local size = bg:getContentSize()
  display.newTTFLabel({text = str, size = 18}):pos(size.width / 2, size.height - 12):addTo(bg)
  self:createReward(data):addTo(bg):pos(size.width / 2, 15)
  return bg
end

return PvpRankDesLayer
