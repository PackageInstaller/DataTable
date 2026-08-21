local StoryBookCsv = require("csvdata.storybook")
local GiftCsv = require("csvdata.shop_score1")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/lover/main/"
local NewYearRes = "ui/newyear/main/"
local uiData = {
  csbFile = "ui/lover/LoverDayLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    mainBg = "mainBg",
    node = "node",
    num = "num",
    list = "mainBg/list",
    btn1 = "mainBg/btn1",
    btn2 = "mainBg/btn2"
  }
}
local btnData = {
  [1] = {
    name = "剧情",
    red = "story",
    func = function(self)
      self:showStoryLayer()
    end
  },
  [2] = {
    name = "兑换",
    red = "",
    func = function(self)
      self:showGiftLayer()
    end
  }
}
local LoverDayLayer = class("LoverDayLayer", UIBase)

function LoverDayLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LoverDayLayer:init(params)
  self.select = params.select or 1
  self.typeLove = {}
  self.handlers = {}
  self.btns = {}
  display.newSprite(MainRes .. "image_tip.png"):addTo(self.node)
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 8)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 8)
    end
  })
  for index, data in ipairs(btnData) do
    local btn = self["btn" .. index]
    btn:setName("btn" .. index)
    btn:setGroup(group)
    btn:setCallback(function()
      self.select = index
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):pos(42, 30):addTo(btn)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.loverDay[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
    end
  end
  group:chooseByName("btn" .. self.select)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "loverDay" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.loverDay[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
      end
    end
  end))
  self:getHerosLove()
  self:updateNum()
  local closeBtn = UIHelper.extend(ccui.Button:create())
  closeBtn:setImages(NewYearRes, {
    "area_btn_close.png",
    "area_btn_close.png"
  })
  closeBtn:pos(930, 510):addTo(self.mainBg)
  closeBtn:setCallback(function()
    self:close()
  end)
end

function LoverDayLayer:showData(params)
  btnData[self.select].func(self)
end

function LoverDayLayer:showStoryLayer()
  self.list:removeAllChildren()
  local status = game.role.storyBook["6"] or {}
  local showData = {}
  for _, data in pairs(StoryBookCsv[6]) do
    if data.style == 1 and data.showLove == 1 then
      local temp = clone(data)
      temp.state = status[data.id]
      table.insert(showData, temp)
    end
  end
  table.sort(showData, function(a, b)
    local factorA = a.state and (a.state == 1 and 1000 or 0) or 2000
    local factorB = b.state and (b.state == 1 and 1000 or 0) or 2000
    return a.id + factorA < b.id + factorB
  end)
  local xPos, viewNode
  for i, data in ipairs(showData) do
    if i % 4 == 1 then
      viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(900, 100)):addTo(self.list)
      xPos = 4
    end
    local card = HeroItem.new({
      type = data.unlockType
    }):anch(0, 0):pos(xPos, 3):addTo(viewNode)
    if not data.state then
      display.newSprite(MainRes .. "image_lock.png"):pos(47, 18):addTo(card)
    elseif data.state == 0 then
      display.newSprite("ui/global/story_new.png"):pos(80, 80):addTo(card)
      card:setCallback(function()
        self:hide()
        game:createView("talk.PlotTalkLayer", {
          talkId = data.play,
          csvNo = data.readcsv or 0,
          showSpeed = true,
          hideSkip = false,
          onComplete = function()
            CommonHelper.playHomeBGM()
            self:show()
            game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
              page = 6,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
              UIHelper.removeWaiting()
              MedalRewardLayer.new({
                items = data.gift:toNumMap()
              })
              self:showStoryLayer()
              self:updateNum()
            end)
          end
        })
      end)
    else
      card:setCallback(function()
        self:hide()
        game:createView("talk.PlotTalkLayer", {
          talkId = data.play,
          csvNo = data.readcsv or 0,
          showSpeed = true,
          hideSkip = false,
          onComplete = function()
            CommonHelper.playHomeBGM()
            self:show()
          end
        })
      end)
    end
    xPos = xPos + 97
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function LoverDayLayer:showGiftLayer()
  self.list:removeAllChildren()
  local status = game.role.activityStatus["37"].gift
  local xPos, viewNode
  for i, data in ipairs(GiftCsv) do
    if i % 3 == 1 then
      viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(900, 187)):addTo(self.list)
      xPos = 68
    end
    local cell = UIHelper.newImageView(MainRes .. "cell.png"):pos(xPos, 93):addTo(viewNode)
    local gift = data.gift:toArray("=", true)
    ItemIcon.new({
      type = gift[1],
      count = gift[2]
    }):pos(63, 115):addTo(cell)
    display.newTTFLabel({
      text = data.cost,
      size = 20,
      color = UIHelper.hex2rgb("#622115")
    }):pos(76, 34):addTo(cell)
    local left = data.limit - status:getv(data.id, 0)
    if 0 < left then
      display.newTTFLabel({
        text = string.format("可兑换%d次", left),
        size = 14,
        color = UIHelper.hex2rgb("#7e1d00")
      }):pos(63, 59):addTo(cell)
      cell:setCallback(function()
        game:createView("global.BuyItemLayer", {
          itemId = gift[1],
          costId = data.costId,
          desc = data.detail,
          count = gift[2],
          limit = 1,
          price = data.cost,
          callback = function(num)
            if (game.role.items[data.costId] or 0) < data.cost then
              SysError(SYS_ERR_ACTIVITY_LOVERDAY_MONEY_NOT_ENOUGH)
              return
            end
            game:sendData(actionCodes.Activity_loveDayRpc, MsgPack.pack({
              type = self.select,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_loveDayRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self:showGiftLayer()
              self:updateNum()
            end)
            return true
          end
        })
      end)
    else
      display.newSprite(MainRes .. "image_out.png"):scale(0.85):pos(66, 80):addTo(cell)
    end
    xPos = xPos + 130
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function LoverDayLayer:updateNum()
  self.num:setString(game.role.items[14] or 0)
end

function LoverDayLayer:getHerosLove()
  for _, hero in pairs(game.role.heros) do
    if not self.typeLove[hero.type] or hero.love > self.typeLove[hero.type] then
      self.typeLove[hero.type] = hero.love
    end
  end
end

function LoverDayLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return LoverDayLayer
