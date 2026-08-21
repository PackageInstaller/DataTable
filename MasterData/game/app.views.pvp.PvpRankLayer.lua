local rankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local UnitCsv = require("csvdata.unit")
local DressCsv = require("csvdata.hero_skin")
local uiData = {
  csbFile = "ui/pvp/PvpRankLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    rankList = "popAction/clip/rankList",
    me = "popAction/me"
  }
}
local PvpRankLayer = class("PvpRankLayer", UIBase)

function PvpRankLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpRankLayer:init(params)
end

function PvpRankLayer:showData(params)
  local rankList = params.rankList
  self.me:removeAllChildren()
  self.rankList:removeAllChildren()
  self.lastChoose = nil
  if not next(rankList) then
    display.newTTFLabel({
      text = "还没有人成为烹饪家",
      size = 22,
      color = UIHelper.hex2rgb("#b26b3f")
    }):center(self.rankList):addTo(self.rankList)
  end
  display.newTTFLabel({
    text = "我的排名：" .. (game.role.pvpInfo.rank or "未上榜"),
    size = 16,
    color = UIHelper.hex2rgb("#f2ce88")
  }):addTo(self.me)
  for idx, data in ipairs(rankList) do
    self:createOne(idx, data):addTo(self.rankList)
  end
  self.rankList:requestDoLayout()
  self.rankList:jumpToTop()
end

function PvpRankLayer:createOne(idx, data)
  local di
  data.player = data.player or {}
  local rankColor = "#ffffff"
  if data.roleId == game.role.id then
    di = UIHelper.newImageView(rankRes .. "phb3.png")
    data.player.headIconTag = game.role.headIconTag
    data.player.headFrameTag = game.role.headFrameTag
    rankColor = "#ffe13c"
  else
    di = UIHelper.newImageView(rankRes .. "phb2.png")
    if idx <= 3 then
      rankColor = "#ffe13c"
    end
  end
  display.newSprite(rankRes .. "detail_close.png"):pos(730, 30):addTo(di):name("tag")
  di.idx = idx
  di:setCallback(function()
    local oldY = self.rankList:getInnerContainerPosition().y
    local oldHeight = self.rankList:getInnerContainerSize().height
    
    local function updatePos()
      self.rankList:doLayout()
      local newHeight = self.rankList:getInnerContainerSize().height
      local newY = oldY - (newHeight - oldHeight)
      if 0 < newY then
        newY = 0
      end
      if newY < self.rankList:getContentSize().height - newHeight then
        newY = self.rankList:getContentSize().height - newHeight
      end
      self.rankList:stopAutoScroll()
      self.rankList:setInnerContainerPosition({x = 0, y = newY})
    end
    
    if self.lastChoose then
      self.rankList:removeItem(self.rankList:getIndex(self.lastChoose) + 1)
      self.lastChoose:getChildByName("tag"):setTexture(rankRes .. "detail_close.png")
      if self.lastChoose.idx == idx then
        self.lastChoose = nil
        updatePos()
        return
      end
    end
    self.rankList:insertCustomItem(self:createDetail(data), idx)
    di:getChildByName("tag"):setTexture(rankRes .. "detail_open.png")
    updatePos()
    self.lastChoose = di
  end)
  display.newTTFLabel({
    text = idx,
    size = 42,
    color = UIHelper.hex2rgb(rankColor)
  }):anch(0.5, 0.5):pos(35, 30):addTo(di):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  display.newTTFLabel({
    text = data.player.name,
    size = 20,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(130, 28):addTo(di)
  display.newTTFLabel({
    text = (data.player.winCount or 0) .. "连胜",
    size = 20,
    color = UIHelper.hex2rgb("#f44111")
  }):anch(0, 0.5):pos(300, 28):addTo(di)
  display.newTTFLabel({
    text = data.score .. "点",
    size = 28,
    color = UIHelper.hex2rgb("#f44111")
  }):anch(1, 0.5):pos(550, 30):addTo(di)
  local time = CommonHelper.date(data.player.time)
  local timeStr = time.year .. "/" .. time.month .. "/" .. time.day
  display.newTTFLabel({
    text = timeStr,
    size = 24,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(585, 30):addTo(di)
  local bg = UIHelper.newImageView(PicCsv[data.player.headIconTag].res):addTo(di):pos(94, 30):scale(0.38)
  display.newSprite(FramCsv[data.player.headFrameTag].res):center(bg):addTo(bg)
  display.newSprite("icon/pvp/rank_7.png"):pos(405, 30):addTo(di):scale(0.8)
  return di
end

function PvpRankLayer:createDetail(data)
  local di = UIHelper.newImageView(rankRes .. "detail_bg.png")
  local battleValue = (data.player.battleValue or 0) + CommonHelper.getOtherBattleValue(data.player.formatData, data.player.jobExp, data.player.jobStage)
  display.newTTFLabel({
    text = "美味度: " .. battleValue,
    size = 24,
    color = UIHelper.hex2rgb("#784627")
  }):anch(0.5, 0.5):pos(630, 48):addTo(di)
  
  local function getDressType(type, dress)
    local dressId = type * 10 + dress
    local dressSet = DressCsv[dressId]
    if not dressSet then
      return type
    else
      return dressSet.hero
    end
  end
  
  local xPos, yPos, interval = 95, 48, 85
  local count = 0
  for slot = 1, 5 do
    local heroData = data.player.formatData[tostring(slot)]
    if heroData then
      HeroHead.new({
        type = getDressType(heroData.type, heroData.dress),
        awake = heroData.awake,
        star = UnitCsv[heroData.type].star,
        treeMax = heroData.treeMax,
        sauceMax = heroData.isBest,
        level = heroData.level,
        quality = heroData.quality,
        loveEffect = true,
        loveBreak = heroData.loveBreak
      }):scale(0.8):pos(xPos + interval * count, yPos):addTo(di)
      count = count + 1
    end
  end
  return di
end

return PvpRankLayer
