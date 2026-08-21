local AchieveCsv = require("csvdata.achievement")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/achieve/main/"
local uiData = {
  csbFile = "ui/achieve/AchievementMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    list = "mainBg/list",
    mainFram = "mainFram",
    btnSelect = "mainFram/btnSelect",
    allNum = "mainFram/allNum"
  }
}
local btnNames = {
  [1] = "关卡净化",
  [2] = "食灵收集",
  [3] = "食灵培养",
  [4] = "装备收集",
  [5] = "装备培养",
  [6] = "好感培养",
  [7] = "资源收集",
  [8] = "全部"
}
local AchievementMainLayer = class("AchievementMainLayer", UIBase)

function AchievementMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function AchievementMainLayer:init(params)
  TopBar:show(TopBarType.full, "成就")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.size = display.newSprite(MainRes .. "cell_1.png"):getContentSize()
  self.size.height = self.size.height + 20
  self.half = self.size.width / 2
  self.selected = params.selected or #btnNames
  self.show = {}
  self.btnSelect:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4f2a07"), 1)
  self.btnSelect:setTouchScale()
  self.btnSelect:setCallback(function()
    self.selected = self.selected % #btnNames + 1
    self.btnSelect:setString({
      text = btnNames[self.selected],
      size = 18
    })
    self:showData()
  end)
  self:checkAchieveNum()
end

function AchievementMainLayer:showData(params)
  self.list:removeAllChildren()
  self.show = {}
  for _, data in pairs(AchieveCsv) do
    if data.flag == self.selected or self.selected == #btnNames and data.id < 10000 then
      table.insert(self.show, data)
    end
  end
  table.sort(self.show, function(a, b)
    local curA, allA, _ = self:getProgress(a)
    local curB, allB, _ = self:getProgress(b)
    local factorA = (allA <= curA and 1000 or 0) - a.order
    local factorB = (allB <= curB and 1000 or 0) - b.order
    return factorA > factorB
  end)
  self:showList()
end

function AchievementMainLayer:showList()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.curRow = 1
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:refreshListWithDelay()
  end, 0.016666666666666666)
end

function AchievementMainLayer:refreshListWithDelay()
  for row = self.curRow, self.curRow + 10 do
    if row > #self.show then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      self.list:requestDoLayout()
      return
    end
    local data = self.show[row]
    local viewNode = ccui.Widget:create()
    viewNode:size(self.size):addTo(self.list)
    display.newSprite(MainRes .. "image_mask.png"):anch(0.5, 1):pos(self.half, self.size.height):addTo(viewNode)
    local image = display.newSprite(data.res):anch(0.5, 1):pos(55, self.size.height + 1):addTo(viewNode)
    local cell = display.newSprite(MainRes .. "cell_1.png"):anch(0.5, 0):pos(self.half, 0):addTo(viewNode)
    display.newSprite(MainRes .. "image_line.png"):pos(250, 60):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 30,
      color = UIHelper.hex2rgb("#703802")
    }):pos(240, 82):addTo(viewNode)
    display.newTTFLabel({
      text = data.goal,
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):pos(240, 43):addTo(viewNode)
    local gifts = data.item:toNumMap()
    local xPos, yPos, interval = 860, 50, -60
    for index = 4, 1, -1 do
      if gifts[index] then
        local iconBg = display.newSprite("ui/mission/item_bg.png"):pos(xPos, yPos):addTo(cell)
        display.newSprite(ItemCsv[index].icon):scale(0.5):center(iconBg):addTo(iconBg)
        display.newTTFLabel({
          text = gifts[index],
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(46, -2):addTo(iconBg)
        xPos = xPos + interval
      end
    end
    for itemId, count in pairs(gifts) do
      if 4 < itemId then
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(xPos, yPos):addTo(cell)
        display.newTTFLabel({text = count, size = 32}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 18):addTo(icon)
        xPos = xPos + interval
      end
    end
    local cur, all, result = self:getProgress(data)
    if result == 0 then
      image:setColor(cc.c3b(140, 140, 140))
      local progressBg = display.newSprite(MainRes .. "progress_bg.png"):pos(995, 62):addTo(cell)
      display.newTTFLabel({
        text = "成就进度",
        size = 20,
        color = UIHelper.hex2rgb("#703802")
      }):pos(70, 37):addTo(progressBg)
      display.newTTFLabel({
        text = cur .. "/" .. all,
        size = 20,
        color = UIHelper.hex2rgb("#703802")
      }):pos(70, 17):addTo(progressBg)
    elseif result == 1 then
      cell:setTexture(MainRes .. "cell_2.png")
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages("ui/carbon/boss/", {
        "anniu_1.png",
        "anniu_1.png"
      })
      btn:pos(985, 62):addTo(cell):setTouchScale()
      btn:setString({text = "领取", size = 24})
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
      btn:setCallback(function()
        game:sendData(actionCodes.Role_missionRpc, MsgPack.pack({
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_missionRpc, function(event)
          UIHelper.removeWaiting()
          self:checkAchieveNum()
          btn:removeSelf()
          display.newSprite(MainRes .. "image_done.png"):pos(985, 62):addTo(cell)
          MedalRewardLayer.new({items = gifts})
        end)
      end)
    else
      cell:setTexture(MainRes .. "cell_2.png")
      display.newSprite(MainRes .. "image_done.png"):pos(985, 62):addTo(cell)
    end
  end
  self.curRow = self.curRow + 10
end

function AchievementMainLayer:getProgress(data)
  local cur = game.role.missionTaskStatus:getv(data.id, 0)
  local all = data.condition1
  if cur == -1 then
    return cur, all, -1
  end
  return cur, all, cur >= all and 1 or 0
end

function AchievementMainLayer:checkAchieveNum()
  local cur, all = 0, 0
  for _, data in pairs(AchieveCsv) do
    if data.id < 10000 then
      local _, _, result = self:getProgress(data)
      if result == -1 then
        cur = cur + 1
      end
      all = all + 1
    end
  end
  self.allNum:setString(cur .. "/" .. all)
end

function AchievementMainLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return AchievementMainLayer
