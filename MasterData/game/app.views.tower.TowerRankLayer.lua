local rankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local DressCsv = require("csvdata.hero_skin")
local uiData = {
  csbFile = "ui/tower/TowerRankLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    rankList = "popAction/clip/rankList",
    me = "popAction/me"
  }
}
local TowerRankLayer = class("TowerRankLayer", UIBase)

function TowerRankLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TowerRankLayer:init(params)
end

function TowerRankLayer:showData(params)
  local rankList = params.rankList
  self.me:removeAllChildren()
  self.rankList:removeAllChildren()
  self.lastChoose = nil
  if not next(rankList) then
    display.newTTFLabel({
      text = "哇，主厨是第一个来道馆的人",
      size = 22,
      color = UIHelper.hex2rgb("#b26b3f")
    }):center(self.rankList):addTo(self.rankList)
    display.newTTFLabel({
      text = "我的排名：未上榜",
      size = 16,
      color = UIHelper.hex2rgb("#f2ce88")
    }):addTo(self.me)
    return
  end
  local isHave = false
  local temList = {}
  for idx, _data in ipairs(rankList) do
    table.insert(temList, _data)
  end
  table.sort(temList, function(a, b)
    local dataA = json.decode(a)
    local dataB = json.decode(b)
    local aValue = (dataA.battleValue or 0) + CommonHelper.getOtherBattleValue(dataA.formatData, dataA.jobExp, dataA.jobStage)
    local bValue = (dataB.battleValue or 0) + CommonHelper.getOtherBattleValue(dataB.formatData, dataB.jobExp, dataB.jobStage)
    print("sort aVlue:", aValue, bValue)
    if a.floorId ~= b.floorId then
      return a.floorId > b.floorId
    end
    return aValue > bValue
  end)
  for idx, _data in pairs(temList) do
    local data = json.decode(_data)
    if data.roleId == game.role.id then
      isHave = true
      display.newTTFLabel({
        text = "我的排名：" .. idx,
        size = 16,
        color = UIHelper.hex2rgb("#f2ce88")
      }):addTo(self.me)
    end
    self:createOne(idx, data):addTo(self.rankList)
  end
  if not isHave then
    display.newTTFLabel({
      text = "我的排名：未上榜",
      size = 16,
      color = UIHelper.hex2rgb("#f2ce88")
    }):addTo(self.me)
  end
  self.rankList:requestDoLayout()
  self.rankList:jumpToTop()
end

function TowerRankLayer:createOne(idx, data)
  local di
  local rankColor = "#ffffff"
  if data.roleId == game.role.id then
    di = UIHelper.newImageView(rankRes .. "phb3.png")
    data.headIconTag = game.role.headIconTag
    data.headFrameTag = game.role.headFrameTag
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
    text = data.name,
    size = 20,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(130, 28):addTo(di)
  display.newTTFLabel({
    text = data.floorId .. "胜",
    size = 28,
    color = UIHelper.hex2rgb("#703802")
  }):anch(1, 0.5):pos(450, 30):addTo(di)
  local time = CommonHelper.date(data.time)
  local timeStr = time.year .. "/" .. time.month .. "/" .. time.day
  display.newTTFLabel({
    text = timeStr,
    size = 24,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(575, 30):addTo(di)
  local bg = UIHelper.newImageView(PicCsv[data.headIconTag].res):addTo(di):pos(94, 30):scale(0.38)
  display.newSprite(FramCsv[data.headFrameTag].res):center(bg):addTo(bg)
  return di
end

function TowerRankLayer:createDetail(data)
  local di = UIHelper.newImageView(rankRes .. "detail_bg.png")
  local battleValue = (data.battleValue or 0) + CommonHelper.getOtherBattleValue(data.formatData, data.jobExp, data.jobStage)
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
    local heroData = data.formatData[tostring(slot)]
    if heroData then
      HeroHead.new({
        type = getDressType(heroData.type, heroData.dress),
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

return TowerRankLayer
