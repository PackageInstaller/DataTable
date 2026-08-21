local StoryBookCsv = require("csvdata.storybook")
local ItemCsv = require("csvdata.item")
local ChapterInfoCsv = require("csvdata.chapter_info")
local MoonInfoCsv = require("csvdata.moon_info")
local ActivityInfoCsv = require("csvdata.activity_story_info")
local GhostCsv = require("csvdata.ghost")
local UnitCsv = require("csvdata.unit")
local BookCsv = require("csvdata.handbook")
local EffectCsv = require("csvdata.love_effect")
local LovePlusCsv = require("csvdata.love_plus")
local ShopCsv = require("csvdata.shop")
local HeroRes = "ui/hero/"
local MainTalkRes = "ui/talk/main/"
local globalRes = "ui/global/"
local HeroStoryRes = "ui/talk/heroStory/"
local activityStoryRes = "ui/talk/activityStory/"
local specialRes = "ui/talk/specialStory/"
local entanglementRes = "ui/talk/entanglement/"
local uiData = {
  csbFile = "ui/talk/TalkLayer.csb",
  mask = true,
  widgets = {
    btnBar = "btnBar",
    downAction = "downAction",
    talk_bg = "talk_bg",
    content = "content",
    btns_bg_3 = "btns_bg_3"
  }
}
local TalkLayer = class("TalkLayer", UIBase)

function TalkLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local btnsData = {
  [1] = {
    name = "主线剧情",
    callback = function(self)
      self:showMainStory()
    end
  },
  [2] = {
    name = "食灵故事",
    callback = function(self, type)
      self:showHeroStory(type)
    end
  },
  [3] = {
    name = "异变传闻",
    callback = function(self, type)
      self:showSpecialStory(type)
    end
  },
  [4] = {
    name = "羁绊回忆",
    callback = function(self)
      self:showEntanglementStory()
    end
  },
  [5] = {
    name = "活动剧情",
    callback = function(self)
      self:showActivityStory()
    end
  },
  [6] = {
    name = "特别剧情",
    callback = function(self, type)
      self:showSpecialActivityStory(type)
    end
  }
}

function TalkLayer:init(params)
  self.group = MRadioGroup:create()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.talk_bg)
    UIHelper.fitForiPhoneX(self.downAction, true)
    self.content:setPositionX(self.content:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btns_bg_3:setPositionX(self.btns_bg_3:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnBar:setPositionX(self.btnBar:getPositionX() - UIHelper.getMoveXForX() + 50)
  end
  self.handlers = {}
  self.btns = {}
  local btnSize = UIHelper.newImageView(HeroRes .. "taocan_1.png"):getContentSize()
  for index, data in ipairs(btnsData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnBar)
    local btn = UIHelper.extend(ccui.Button:create()):center(viewNode):addTo(viewNode)
    btn:setImages(HeroRes, {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:setString({
      text = data.name,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    btn:setName("btn" .. index)
    btn:setCascadeOpacityEnabled(true)
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.selected = index
      self:showData()
    end)
    self.btns[index] = btn
    local bShow = checkbool(game.role.redPoints.story[index])
    UIHelper.showRedPoint(btn, bShow, cc.p(15, 5), nil, true)
    UIHelper.MoveToRight({
      node = btn,
      delay = (index - 1) * 0.1,
      time = 0.2
    })
  end
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "story" then
      for i = 1, #btnsData do
        local bShow = checkbool(game.role.redPoints.story[i])
        UIHelper.showRedPoint(self.btns[i], bShow, cc.p(15, 5), nil, true)
      end
    end
  end))
  self.selected = params.selected or 1
  self:showTopBar()
  TopBar:showAnimation(true)
end

function TalkLayer:showData(params)
  local type = params and params.type
  local backBtn = TopBar:getChildByName("heroStoryBack")
  if backBtn then
    backBtn:removeSelf()
  end
  self.tempCells = nil
  self.content:removeAllChildren()
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self, type)
end

function TalkLayer:showMainStory()
  local btnsBg = display.newSprite(MainTalkRes .. "btns_bg.png"):anch(0, 0):pos(0, 0):addTo(self.content)
  self.chapter = 101
  self.storyList = ccui.ListView:create()
  self.storyList:size(cc.size(660, 596))
  self.storyList:setInnerContainerSize(cc.size(660, 596))
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):pos(302, 0):addTo(self.content)
  local list = ccui.ListView:create()
  list:size(cc.size(230, 540))
  list:setInnerContainerSize(cc.size(230, 540))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(5, 0):addTo(btnsBg)
  local chapters, styles = {}, {}
  for _, data in ipairs(StoryBookCsv[1]) do
    if not chapters[data.style] then
      chapters[data.style] = true
      table.insert(styles, data.style)
    end
  end
  local chapterGroup = MRadioGroup:create()
  local yBegin, interval = 500, -60
  for index, style in ipairs(styles) do
    local lock = game.role.carbons[style * 100 + 1]
    local imageA = lock and "chapter_a.png" or "chapter_lock.png"
    local imageB = lock and "chapter_b.png" or "chapter_lock.png"
    local viewNode = ccui.Widget:create()
    viewNode:size(cc.size(200, 60)):addTo(list)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainTalkRes, {imageA, imageB})
    btn:anch(0, 0.5):pos(0, 30):addTo(viewNode)
    btn:setName(tostring(style))
    btn:setString({
      text = ChapterInfoCsv[style].name,
      size = 24,
      color = UIHelper.hex2rgb("#61270b")
    })
    btn:setGroup(chapterGroup)
    btn:setCallback(function()
      if not lock then
        chapterGroup:chooseByName(tostring(self.chapter))
        SysError(SYS_ERR_STORY_AREA_UNLOCK)
        return
      end
      self.chapter = style
      self:showMainStoryList(1, style)
    end)
    UIHelper.MoveToRight({
      node = btn,
      delay = (index - 1) * 0.1,
      time = 0.2
    })
  end
  self:showMainStoryList(1, self.chapter)
  chapterGroup:chooseByName(tostring(self.chapter))
end

function TalkLayer:showMainStoryList(page, style)
  self.storyList:removeAllChildren()
  local storySet = StoryBookCsv[page]
  local curPage = game.role.storyBook["1"] or {}
  local size = display.newSprite(MainTalkRes .. "cell.png"):getContentSize()
  size.width = self.storyList:getContentSize().width
  for id, data in ipairs(storySet) do
    if data.style == style then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.storyList)
      local content = UIHelper.newImageView(MainTalkRes .. "cell.png"):center(viewNode):addTo(viewNode)
      local dataSet = curPage[tostring(data.id)] or {}
      local status = dataSet.check
      display.newSprite(MainTalkRes .. (status and "play.png" or "lock.png")):pos(55, 34):addTo(content)
      if status and status == 0 then
        display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(10, 103):addTo(content):name("red")
      end
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(32, 99):addTo(content)
      display.newTTFLabel({
        text = status and data.content or data.unlockDesc,
        size = 18,
        color = UIHelper.hex2rgb("#7f2510")
      }):pos(size.width / 2, 54):addTo(content)
      local box = UIHelper.newImageView(MainTalkRes .. "box.png"):pos(size.width - 70, 51):addTo(content)
      box:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true
        })
      end)
      if status and status == 1 then
        display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
      end
      display.newTTFLabel({
        text = "回想奖励",
        size = 14,
        color = UIHelper.hex2rgb("#986e58")
      }):pos(size.width - 70, size.height - 27):addTo(content)
      content:setCallback(function()
        if not status then
          SysError(SYS_ERR_STORY_UNLOCK)
          return
        end
        if backBtn then
          backBtn:hide()
        end
        game:createView("talk.PlotTalkLayer", {
          talkId = data.play,
          csvNo = data.readcsv or 0,
          showSpeed = true,
          hideSkip = false,
          music = 4,
          onComplete = function()
            CommonHelper.playHomeBGM()
            if status == 1 then
              return
            end
            game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
              page = page,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
              UIHelper.removeWaiting()
              status = 1
              display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
              local red = content:getChildByName("red")
              if red then
                red:removeSelf()
              end
              MedalRewardLayer.new({
                items = data.gift:toNumMap()
              })
            end)
          end
        })
      end)
    end
  end
  self.storyList:requestDoLayout()
  self.storyList:jumpToTop()
end

function TalkLayer:showActivityStory()
  local btnsBg = display.newSprite(MainTalkRes .. "btns_bg.png"):anch(0, 0):pos(0, 0):addTo(self.content)
  self.chapter = nil
  self.storyList = ccui.ListView:create()
  self.storyList:size(cc.size(660, 596))
  self.storyList:setInnerContainerSize(cc.size(660, 596))
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):pos(302, 0):addTo(self.content)
  local list = ccui.ListView:create()
  list:size(cc.size(230, 540))
  list:setInnerContainerSize(cc.size(230, 540))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(5, 0):addTo(btnsBg)
  local cost = globalCsv.storyUnlockCost:toArray("=", true)
  local numBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):anch(0, 0.5):pos(10, 555):addTo(self.content)
  display.newSprite(ItemCsv[cost[1]].icon):scale(0.65):pos(20, 20):addTo(numBg)
  display.newTTFLabel({
    text = ItemCsv[cost[1]].name .. ":",
    size = 20,
    color = UIHelper.hex2rgb("#E6C5A5")
  }):pos(90, 20):addTo(numBg)
  self.keyNum = display.newTTFLabel({
    text = game.role.items[cost[1]] or 0,
    size = 20,
    color = UIHelper.hex2rgb("#3FF914")
  }):pos(150, 19):addTo(numBg)
  local chapters, styles = {}, {}
  for _, data in ipairs(StoryBookCsv[5]) do
    if not chapters[data.style] then
      if not self.chapter then
        self.chapter = data.style
      end
      chapters[data.style] = data.lockType == 1 and 1 or 2
      table.insert(styles, data.style)
    end
  end
  local chapterGroup = MRadioGroup:create()
  for index, style in ipairs(styles) do
    local viewNode = ccui.Widget:create()
    viewNode:size(cc.size(200, 60)):addTo(list)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainTalkRes, {
      "chapter_a.png",
      "chapter_b.png"
    })
    btn:anch(0, 0.5):pos(0, 30):addTo(viewNode)
    btn:setName(tostring(style))
    btn:setString({
      text = MoonInfoCsv[style].name,
      size = 24,
      color = UIHelper.hex2rgb("#61270b")
    })
    btn:setGroup(chapterGroup)
    btn:setCallback(function()
      self.chapter = style
      self:showActivityStoryList(5, style)
    end)
    if chapters[style] == 1 then
      display.newSprite(activityStoryRes .. "new_story.png"):pos(164, 40):addTo(btn)
    end
    UIHelper.MoveToRight({
      node = btn,
      delay = (index - 1) * 0.1,
      time = 0.2
    })
  end
  list:requestDoLayout()
  self:showActivityStoryList(5, self.chapter)
  chapterGroup:chooseByName(tostring(self.chapter))
end

function TalkLayer:showActivityStoryList(page, style)
  self.storyList:removeAllChildren()
  local storySet = StoryBookCsv[page]
  local curPage = game.role.storyBook["5"] or {}
  local cost = globalCsv.storyUnlockCost:toArray("=", true)
  local size = display.newSprite(MainTalkRes .. "cell.png"):getContentSize()
  size.width = self.storyList:getContentSize().width
  for id, data in ipairs(storySet) do
    if data.style == style then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.storyList)
      local content = UIHelper.newImageView(MainTalkRes .. "cell.png"):center(viewNode):addTo(viewNode)
      local dataSet = curPage[tostring(data.id)] or {}
      local status = dataSet.check
      local lock = display.newSprite(MainTalkRes .. (status and "play.png" or "lock.png")):pos(55, 34):addTo(content)
      if status and status == 0 then
        display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(10, 103):addTo(content):name("red")
      end
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(32, 99):addTo(content)
      local desc = status and data.content or data.unlockDesc
      if not status and data.lockType == 2 then
        desc = string.format("消耗<img src='%s' scale=0.6 />x%d 解锁该剧情", ItemCsv[cost[1]].icon, cost[2])
      end
      local descLabel = MRichText.new({
        text = desc,
        size = 18,
        color = UIHelper.hex2rgb("#7f2510")
      }):anch(0.5, 0.5):pos(size.width / 2, 54):addTo(content)
      local box = UIHelper.newImageView(MainTalkRes .. "box.png"):pos(size.width - 70, 51):addTo(content)
      box:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true
        })
      end)
      if status and status == 1 then
        display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
      end
      display.newTTFLabel({
        text = "回想奖励",
        size = 14,
        color = UIHelper.hex2rgb("#986e58")
      }):pos(size.width - 70, size.height - 27):addTo(content)
      content:setCallback(function()
        local function sendData()
          game:createView("talk.PlotTalkLayer", {
            talkId = data.play,
            
            csvNo = data.readcsv or 0,
            showSpeed = true,
            hideSkip = false,
            music = 4,
            onComplete = function()
              CommonHelper.playHomeBGM()
              if status == 1 then
                return
              end
              game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
                page = page,
                id = data.id
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
                UIHelper.removeWaiting()
                status = 1
                display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
                local red = content:getChildByName("red")
                if red then
                  red:removeSelf()
                end
                MedalRewardLayer.new({
                  items = data.gift:toNumMap()
                })
              end)
            end
          })
        end
        
        if status then
          sendData()
          return
        end
        if data.lockType == 1 then
          if not status then
            SysError(SYS_ERR_STORY_UNLOCK)
            return
          end
        else
          local function sendUnlockActivityStory()
            MDialog:double({
              title = "提示",
              
              text = string.format("确认消耗<img src='%s' scale=0.6 />x%d 解锁该剧情吗？", ItemCsv[cost[1]].icon, cost[2]),
              okCallback = function()
                game:sendData(actionCodes.Role_unlockActivityStory, MsgPack.pack({
                  page = page,
                  id = data.id
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Role_unlockActivityStory, function(event)
                  UIHelper.removeWaiting()
                  lock:setTexture(MainTalkRes .. "play.png")
                  descLabel:setString(data.content)
                  self:updateNum(cost[1])
                  sendData()
                end)
                return true
              end,
              cancelCallback = function()
                return true
              end
            })
          end
          
          if (game.role.items[cost[1]] or 0) < cost[2] then
            if not ShopCsv[1020] then
              SysError(SYS_ERR_STORY_UNLOCK)
              return
            end
            local str = string.format("主厨 您的 <img src='%s' scale=0.75 /> %s 不足，是否购买?", ItemCsv[cost[1]].icon, ItemCsv[cost[1]].name)
            MDialog:double({
              title = "提示",
              text = str,
              okCallback = function()
                local giftData = ShopCsv[1020]
                game:createView("global.BuyItemLayer", {
                  itemId = cost[1],
                  costId = 5,
                  count = 1,
                  limit = giftData.overBuy,
                  price = giftData.cost,
                  callback = function(num)
                    if num < 1 then
                      return
                    end
                    if (game.role.diamond or 0) < num * giftData.cost then
                      UIHelper.showDiamondTip({parent = self})
                      return
                    end
                    game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({index = 1020, num = num}))
                    UIHelper.showWaiting()
                    game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
                      UIHelper.removeWaiting()
                      self:updateNum(cost[1])
                      local msg = MsgPack.unpack(event.data)
                      MedalRewardLayer.new({
                        items = msg.items,
                        callback = function()
                          sendUnlockActivityStory()
                        end
                      })
                    end)
                    return true
                  end
                })
                return true
              end,
              cancelCallback = function()
                return true
              end
            })
          else
            sendUnlockActivityStory()
          end
        end
      end)
    end
  end
  self.storyList:requestDoLayout()
  self.storyList:jumpToTop()
end

function TalkLayer:updateNum(itemId)
  if not tolua.isnull(self.keyNum) then
    self.keyNum:setString(game.role.items[itemId] or 0)
  end
end

function TalkLayer:showHeroStory(choose)
  self.info = display.newNode():pos(130, 0):addTo(self.content)
  local panel = display.newSprite("ui/farm/plant/heros_bg.png"):anch(0, 0):pos(535, 60):addTo(self.content)
  local listBg = display.newSprite(HeroStoryRes .. "list_bg.png"):anch(0, 0):pos(1030, 37):addTo(self.content)
  if UIHelper.isiPhoneX() then
    panel:setPositionX(panel:getPositionX() + UIHelper.getMoveXForX() + 50)
    listBg:setPositionX(listBg:getPositionX() + UIHelper.getMoveXForX() + 55)
  end
  display.newTTFLabel({
    text = "食灵故事",
    size = 22
  }):pos(210, 452):addTo(panel)
  self.tempCards = {}
  local heroList = ccui.ListView:create()
  heroList:size(cc.size(400, 400))
  heroList:setInnerContainerSize(cc.size(400, 400))
  heroList:setClippingEnabled(true)
  heroList:setBounceEnabled(true)
  heroList:anch(0, 0):pos(20, 19):addTo(panel)
  self.storyList = ccui.ListView:create()
  self.storyList:size(cc.size(416, 506))
  self.storyList:setInnerContainerSize(cc.size(416, 506))
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):pos(7, 6):addTo(listBg)
  local cellSize = display.newSprite("ui/global/item_bg.png"):getContentSize()
  local nodeSize = cc.size(cellSize.width * 4 + 25, cellSize.height + 12)
  
  local function autoTo(Type, card)
    if self.image then
      self.image:removeSelf()
    end
    self.image = display.newSprite(HeroStoryRes .. "selected.png"):center(card):addTo(card)
    panel:runAction(cc.MoveBy:create(0.3, cc.p(500, 0)))
    listBg:runAction(cc.MoveBy:create(0.3, cc.p(-450, 0)))
    BackManager:push(function()
      if not tolua.isnull(panel) then
        panel:runAction(cc.MoveBy:create(0.3, cc.p(-500, 0)))
        listBg:runAction(cc.MoveBy:create(0.3, cc.p(450, 0)))
      else
        BackManager:pop()
      end
    end)
    self:showHeroDetail(Type)
    self:showHeroStoryList(2, Type)
  end
  
  local index, viewNode = 0
  local bookCsv = game.role.storyBook["2"] or {}
  for _, data in ipairs(StoryBookCsv[2]) do
    if 0 < LovePlusCsv[data.style].limit and game.role.heroBook[tostring(data.style)] then
      local bookData = bookCsv[tostring(data.id)] or {}
      local card = self.tempCards[data.style]
      if not card then
        index = index + 1
        if index % 4 == 1 then
          viewNode = ccui.Widget:create()
          viewNode:size(nodeSize):addTo(heroList)
        end
        local xPos = index % 4 == 0 and 304 or (index % 4 - 1) * 100 + 4
        card = HeroItem.new({
          type = data.style
        }):anch(0, 0):pos(xPos, 10):addTo(viewNode)
        if choose == data.style or not choose and index == 1 then
          self.image = display.newSprite(HeroStoryRes .. "selected.png"):center(card):addTo(card)
          self:showHeroDetail(data.style)
        end
        if choose == data.style then
          autoTo(data.style, card)
        end
        card:setCallback(function()
          local oldX = 535
          if UIHelper.isiPhoneX() then
            oldX = oldX + UIHelper.getMoveXForX() + 50
          end
          if panel:getPositionX() ~= oldX then
            return
          end
          autoTo(data.style, card)
        end)
        self.tempCards[data.style] = card
      end
      if bookData.check == 0 then
        local red = card:getChildByName("red")
        if not red then
          display.newSprite(globalRes .. "story_new.png"):pos(80, 80):addTo(card):name("red"):setLocalZOrder(100)
        end
      end
    end
  end
  if not next(self.tempCards) then
    display.newSprite(HeroStoryRes .. "no_tip.png"):anch(0.5, 0):pos(210, 0):addTo(heroList)
  end
  if not choose then
    UIHelper.MoveToLeft({node = panel, ease = true})
  end
end

function TalkLayer:showHeroDetail(type)
  self.info:removeAllChildren()
  local hero = UnitCsv[type]
  if not hero then
    return
  end
  local love, loveBreak = 0, 0
  local heroBooks = game.role.storyBook["2"] or {}
  for id, data in pairs(heroBooks) do
    local storySet = StoryBookCsv[2][tonumber(id)]
    if storySet.style == type then
      love = data.love
      loveBreak = data.loveBreak
      break
    end
  end
  HeroBigCard.new({type = type, showPic = true}):pos(150, 180):addTo(self.info)
  local infoBg = display.newSprite("ui/kitchen/love/info_bg.png"):anch(0, 0):pos(-55, 0):addTo(self.info)
  display.newSprite(string.format("ui/kitchen/love/profession_%d.png", hero.profession)):pos(23, 75):addTo(infoBg)
  display.newTTFLabel({
    text = hero.name,
    size = 22,
    color = UIHelper.hex2rgb("#A84807")
  }):anch(0, 0.5):pos(38, 78):addTo(infoBg)
  display.newTTFLabel({
    text = "偏爱:",
    size = 16,
    color = UIHelper.hex2rgb("#A84807")
  }):anch(0, 0.5):pos(11, 51):addTo(infoBg)
  display.newTTFLabel({
    text = LovePlusCsv[hero.type].desc,
    size = 16,
    color = UIHelper.hex2rgb("#A84807")
  }):anch(0, 0.5):pos(52, 51):addTo(infoBg)
  display.newTTFLabel({
    text = "好感度:",
    size = 18,
    color = UIHelper.hex2rgb("#FF474F")
  }):anch(0, 0.5):pos(11, 29):addTo(infoBg)
  if loveBreak >= LovePlusCsv[hero.type].limit then
    display.newTTFLabel({
      text = "MAX",
      size = 18,
      color = UIHelper.hex2rgb("#ff474f")
    }):anch(0, 0.5):pos(75, 29):addTo(infoBg)
  else
    MRichText.new({
      text = string.format("<div color=4ea409>%d</div>/%d", math.floor(love), EffectCsv[loveBreak].fullValue),
      size = 18,
      color = UIHelper.hex2rgb("#ff474f")
    }):anch(0, 0.5):pos(75, 29):addTo(infoBg)
    local barBg = display.newSprite("ui/kitchen/love/bar_bg.png"):pos(153, 13):addTo(infoBg)
    local bar = display.newProgressTimer("ui/kitchen/love/bar.png", 1):center(barBg):addTo(barBg)
    bar:setMidpoint(cc.p(0, 0.5))
    bar:setBarChangeRate(cc.p(1, 0))
    bar:setPercentage(love / EffectCsv[loveBreak].fullValue * 100)
  end
  local heart = display.newSprite("ui/global/heart.png"):pos(265, 39):addTo(infoBg)
  display.newTTFLabel({
    text = math.min(loveBreak, LovePlusCsv[hero.type].limit),
    size = 24,
    color = UIHelper.hex2rgb("#5b0a15")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
end

function TalkLayer:showHeroStoryList(page, style)
  self.storyList:removeAllChildren()
  local storySet = StoryBookCsv[page]
  local curPage = game.role.storyBook["2"] or {}
  local num = 0
  local size, selected = display.newSprite(HeroStoryRes .. "cell.png"):getContentSize(), 0
  size.width = self.storyList:getContentSize().width
  local tempStory = {}
  for id, data in ipairs(storySet) do
    if data.style == style and data.play ~= 0 then
      table.insert(tempStory, data)
    end
  end
  table.sort(tempStory, function(a, b)
    if a.unlockData == b.unlockData then
      return a.id < b.id
    else
      return a.unlockData < b.unlockData
    end
  end)
  for _, data in ipairs(tempStory) do
    num = num + 1
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.storyList)
    local content = UIHelper.newImageView(HeroStoryRes .. "cell.png"):center(viewNode):addTo(viewNode)
    local dataSet = curPage[tostring(data.id)] or {}
    local status = dataSet.check
    display.newSprite(HeroStoryRes .. (status and "play.png" or "lock.png")):pos(35, 25):addTo(content)
    display.newTTFLabel({
      text = data.title,
      size = 22,
      color = UIHelper.hex2rgb("#532c1b")
    }):anch(0, 0.5):pos(24, 70):addTo(content)
    display.newTTFLabel({
      text = "解锁好感度：",
      size = 18,
      color = UIHelper.hex2rgb("#703802")
    }):pos(170, 36):addTo(content)
    local heart = display.newSprite("ui/global/heart.png"):pos(255, 37):addTo(content)
    display.newTTFLabel({
      text = data.unlockData,
      size = 24,
      color = UIHelper.hex2rgb("#5b0a15")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
    if data.unlockData >= 5 then
      display.newSprite("ui/global/marry.png"):center(heart):addTo(heart)
    end
    local box = UIHelper.newImageView(MainTalkRes .. "box.png"):scale(0.74):pos(size.width - 80, 35):addTo(content)
    box:setCallback(function()
      ItemRewardLayer.new({
        items = data.gift:toTableArray(),
        preView = true
      })
    end)
    if status and status == 1 then
      selected = data.id
      display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 80, 20):addTo(content)
    end
    display.newTTFLabel({
      text = "回想奖励",
      size = 14,
      color = UIHelper.hex2rgb("#986e58")
    }):pos(size.width - 82, size.height - 22):addTo(content)
    if status and status == 0 then
      display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(5, 70):addTo(content):name("red")
    end
    content:setCallback(function()
      if not status then
        SysError(SYS_ERR_STORY_UNLOCK)
        return
      end
      if backBtn then
        backBtn:hide()
      end
      game:createView("talk.PlotTalkLayer", {
        talkId = data.play,
        csvNo = data.readcsv or 0,
        showSpeed = true,
        hideSkip = false,
        onComplete = function()
          CommonHelper.playHomeBGM()
          if status == 1 then
            return
          end
          game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
            page = page,
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
            UIHelper.removeWaiting()
            local red = content:getChildByName("red")
            if red then
              red:removeSelf()
            end
            self:checkHeroCardRed(data.style)
            MedalRewardLayer.new({
              items = data.gift:toNumMap()
            })
            self:showHeroStoryList(page, style)
          end)
        end
      })
    end)
  end
  if num == 0 then
    display.newTTFLabel({
      text = "这个食灵的故事遗失了，正在努力搜寻...",
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(210, 300):addTo(self.storyList)
  end
  self.storyList:requestDoLayout()
end

function TalkLayer:checkHeroCardRed(style)
  local bookCsv = game.role.storyBook["2"] or {}
  local new = false
  for id, data in pairs(bookCsv) do
    local storyData = StoryBookCsv[2][tonumber(id)]
    if data.check == 0 and storyData.style == style then
      new = true
      break
    end
  end
  if not new then
    local card = self.tempCards[style]
    local red = card:getChildByName("red")
    if red then
      red:removeSelf()
    end
  end
end

function TalkLayer:showSpecialStory(type)
  self.tempCards = {}
  self.heroNode = display.newNode():pos(300, 0):addTo(self.content)
  local btnsBg = display.newSprite(MainTalkRes .. "btns_bg.png"):anch(0, 0):pos(0, 0):addTo(self.content)
  local listBg = display.newSprite(HeroStoryRes .. "list_bg.png"):anch(0, 0):pos(582, 40):addTo(self.content)
  UIHelper.MoveToLeft({node = listBg, time = 0.3})
  self.storyList = ccui.ListView:create()
  self.storyList:size(cc.size(416, 506))
  self.storyList:setInnerContainerSize(cc.size(416, 506))
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):pos(7, 6):addTo(listBg)
  local list = ccui.ListView:create()
  list:size(cc.size(180, 588))
  list:setInnerContainerSize(cc.size(90, 588))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(15, 0):addTo(btnsBg)
  local storySet = StoryBookCsv[3]
  local storyBoss = game.role.storyBook["3"] or {}
  local active = {}
  local news = {}
  for key, data in pairs(storyBoss) do
    local storyData = storySet[tonumber(key)]
    active[storyData.style] = true
    if data.check == 0 then
      news[storyData.style] = true
    end
  end
  local tag, circle
  local size = cc.size(90, 82)
  for id, data in ipairs(GhostCsv) do
    local viewNode = self.tempCards[data.killTag]
    if not viewNode and data.story1 ~= 0 then
      viewNode = ccui.Widget:create()
      viewNode:size(size):addTo(list)
      UIHelper.getClipNode({
        steRes = globalRes .. "mask_2.png",
        clipRes = UIHelper.getCardRes("book", data.killTag)
      }):scale(0.6):center(viewNode):addTo(viewNode)
      local fram = UIHelper.newImageView(specialRes .. "fram.png"):center(viewNode):addTo(viewNode, 100)
      if not active[data.killTag] then
        display.newSprite(specialRes .. "lock.png"):center(viewNode):addTo(viewNode)
        fram:setCallback(function()
          SysError(SYS_ERR_STORY_GHOST_UNLOCK)
        end)
      else
        if not (type or circle) or type == data.killTag then
          tag = data.killTag
          circle = display.newSprite(specialRes .. "select.png"):center(viewNode):addTo(viewNode)
        end
        fram:setCallback(function()
          if tag == data.killTag then
            return
          end
          tag = data.killTag
          circle:removeSelf()
          circle = display.newSprite(specialRes .. "select.png"):center(viewNode):addTo(viewNode)
          self:showSpecialDetail(tag)
          self:showSpecialStoryList(3, tag)
        end)
      end
      self.tempCards[data.killTag] = viewNode
    end
    if viewNode then
      local red = viewNode:getChildByName("red")
      if news[data.killTag] and not red then
        display.newSprite(globalRes .. "story_new.png"):pos(95, 65):addTo(viewNode):name("red"):setLocalZOrder(10)
      end
    end
  end
  list:doLayout()
  if not next(active) then
    listBg:hide()
    local tip = display.newSprite(HeroRes .. "tip_bg.png"):pos(575, 320):addTo(self.content)
    display.newTTFLabel({
      text = "主厨您还没有发现任何异变食灵",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(445, 160):addTo(tip)
  else
    self:showSpecialDetail(tag)
    self:showSpecialStoryList(3, tag)
  end
end

function TalkLayer:showEntanglementStory()
  self.content:removeAllChildren()
  self.storyList = ccui.ListView:create()
  self.storyList:size(cc.size(786, 595))
  self.storyList:setInnerContainerSize(cc.size(786, 595))
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):pos(180, 0):addTo(self.content)
  local storySet = StoryBookCsv[4]
  local curPage = game.role.storyBook["4"] or {}
  local size = display.newSprite(entanglementRes .. "jiban_1.png"):getContentSize()
  size.width = self.storyList:getContentSize().width
  for id, data in ipairs(storySet) do
    local dataSet = curPage[tostring(data.id)] or {}
    local status = dataSet.check
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.storyList)
    local content = UIHelper.newImageView(entanglementRes .. "jiban_1.png"):center(viewNode):addTo(viewNode)
    display.newSprite(MainTalkRes .. (status and "play.png" or "lock.png")):pos(55, 34):addTo(content)
    if status and status == 0 then
      display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(10, 103):addTo(content):name("red")
    end
    display.newTTFLabel({
      text = data.title,
      size = 22,
      color = UIHelper.hex2rgb("#532c1b")
    }):anch(0, 0.5):pos(32, 99):addTo(content)
    local box = UIHelper.newImageView(MainTalkRes .. "box.png"):pos(size.width - 70, 51):addTo(content)
    box:setCallback(function()
      ItemRewardLayer.new({
        items = data.gift:toTableArray(),
        preView = true
      })
    end)
    if status and status == 1 then
      display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
    end
    local interval = 6
    local heroInfo = data.content:toNumMap()
    local num = 0
    
    local function getQuality(heroType)
      local quality = -1
      for _, hero in pairs(game.role.heros) do
        if hero.type == heroType and quality < hero.quality then
          quality = hero.quality
        end
      end
      return quality
    end
    
    for heroType, quality in pairs(heroInfo) do
      local card = HeroHead.new({
        type = heroType,
        quality = quality,
        showTalkTip = true
      }):scale(0.85)
      card:anch(0.5, 0.5):pos(283 + (card:getContentSize().width * 0.85 + interval) * num, 59):addTo(content)
      if not status and quality > getQuality(heroType) then
        display.newSprite(entanglementRes .. "jiban_2.png"):anch(1, 0):pos(card:getContentSize().width, 0):addTo(card)
        display.newSprite(entanglementRes .. "wdc.png"):pos(card:getContentSize().width / 2, 15):addTo(card)
      end
      num = num + 1
    end
    display.newTTFLabel({
      text = "回想奖励",
      size = 14,
      color = UIHelper.hex2rgb("#986e58")
    }):pos(size.width - 70, size.height - 27):addTo(content)
    content:setCallback(function()
      if not status then
        SysError(SYS_ERR_STORY_UNLOCK)
        return
      end
      if backBtn then
        backBtn:hide()
      end
      game:createView("talk.PlotTalkLayer", {
        talkId = data.play,
        csvNo = data.readcsv or 0,
        showSpeed = true,
        hideSkip = false,
        music = 4,
        onComplete = function()
          CommonHelper.playHomeBGM()
          if status == 1 then
            return
          end
          game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({page = 4, id = id}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
            UIHelper.removeWaiting()
            MedalRewardLayer.new({
              items = data.gift:toNumMap()
            })
            self:showEntanglementStory()
          end)
        end
      })
    end)
  end
end

function TalkLayer:showSpecialDetail(tag)
  self.heroNode:removeAllChildren()
  local data
  for index, heroData in ipairs(GhostCsv) do
    if heroData.killTag == tag then
      data = heroData
      break
    end
  end
  local times = game.role.BossKillStatus:getv(tag) or 0
  local Spine = UIHelper.createSpineNodeByRes(data.cardSpine):pos(0, -100):addTo(self.heroNode)
  Spine:setAnimation(0, "moren", true)
  local heartBg = display.newSprite(HeroStoryRes .. "heart_bg.png"):pos(165, 60):addTo(self.heroNode)
  local nameBg = display.newSprite("ui/hero/preset/name_bg.png"):pos(153, 108):addTo(self.heroNode)
  display.newSprite(specialRes .. "image.png"):pos(10, 19):addTo(nameBg)
  display.newTTFLabel({
    text = data.name,
    size = 20,
    color = UIHelper.hex2rgb("#3e1413")
  }):pos(113, 20):addTo(nameBg)
  display.newTTFLabel({
    text = "成功净化次数",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(83, 45):addTo(heartBg)
  display.newTTFLabel({
    text = times,
    size = 20,
    color = UIHelper.hex2rgb("#13f302")
  }):pos(83, 20):addTo(heartBg)
end

function TalkLayer:showSpecialStoryList(page, style)
  self.storyList:removeAllChildren()
  local storySet = StoryBookCsv[page]
  local curPage = game.role.storyBook["3"] or {}
  local size, selected = display.newSprite(HeroStoryRes .. "cell.png"):getContentSize(), 0
  size.width = self.storyList:getContentSize().width
  for id, data in ipairs(storySet) do
    if data.style == style then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(size):addTo(self.storyList)
      local content = UIHelper.newImageView(HeroStoryRes .. "cell.png"):center(viewNode):addTo(viewNode)
      local dataSet = curPage[tostring(data.id)] or {}
      local status = dataSet.check
      display.newSprite(HeroStoryRes .. (status and "play.png" or "lock.png")):pos(35, 25):addTo(content)
      display.newTTFLabel({
        text = data.title,
        size = 22,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(24, 70):addTo(content)
      local box = UIHelper.newImageView(MainTalkRes .. "box.png"):scale(0.74):pos(size.width - 80, 35):addTo(content)
      box:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true
        })
      end)
      if status and status == 1 then
        selected = id
        display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 80, 20):addTo(content)
      end
      display.newTTFLabel({
        text = "回想奖励",
        size = 14,
        color = UIHelper.hex2rgb("#986e58")
      }):pos(size.width - 82, size.height - 22):addTo(content)
      if status and status == 0 then
        display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(5, 70):addTo(content):name("red")
      end
      content:setCallback(function()
        if not status then
          SysError(SYS_ERR_STORY_UNLOCK)
          return
        end
        if backBtn then
          backBtn:hide()
        end
        game:createView("talk.PlotTalkLayer", {
          talkId = data.play,
          csvNo = data.readcsv or 0,
          showSpeed = true,
          hideSkip = false,
          onComplete = function()
            CommonHelper.playHomeBGM()
            if status == 1 then
              return
            end
            game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
              page = page,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
              UIHelper.removeWaiting()
              local red = content:getChildByName("red")
              if red then
                red:removeSelf()
              end
              self:checkSpecialCardRed(style)
              MedalRewardLayer.new({
                items = data.gift:toNumMap()
              })
              self:showSpecialStoryList(page, style)
            end)
          end
        })
      end)
    end
  end
  self.storyList:requestDoLayout()
end

function TalkLayer:checkSpecialCardRed(style)
  local bookCsv = game.role.storyBook["3"] or {}
  local new = false
  for id, data in pairs(bookCsv) do
    local storyData = StoryBookCsv[3][tonumber(id)]
    if data.check == 0 and storyData.style == style then
      new = true
      break
    end
  end
  if not new then
    local card = self.tempCards[style]
    local red = card:getChildByName("red")
    if red then
      red:removeSelf()
    end
  end
end

function TalkLayer:showSpecialActivityStory(intype)
  local btnsBg = display.newSprite(MainTalkRes .. "btns_bg.png"):anch(0, 0):pos(0, 0):addTo(self.content)
  self.storyList = ccui.ListView:create()
  self.storyList:setClippingEnabled(true)
  self.storyList:setBounceEnabled(true)
  self.storyList:anch(0, 0):addTo(self.content)
  local numBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):anch(0, 0.5):pos(10, 555):addTo(self.content)
  local costSpr = display.newSprite():scale(0.65):pos(20, 20):addTo(numBg)
  local costLab = display.newTTFLabel({
    text = "",
    size = 20,
    color = UIHelper.hex2rgb("#E6C5A5")
  }):pos(90, 20):addTo(numBg)
  self.keyNum = display.newTTFLabel({
    text = "",
    size = 20,
    color = UIHelper.hex2rgb("#3FF914")
  }):pos(150, 19):addTo(numBg)
  
  local function showCost(style)
    if globalCsv["storyUnlockCost_" .. style] then
      local cost = globalCsv["storyUnlockCost_" .. style]:toArray("=", true)
      numBg:show()
      costSpr:setTexture(ItemCsv[cost[1]].icon)
      costLab:setString(ItemCsv[cost[1]].name .. ":")
      self:updateNum(cost[1])
    else
      numBg:hide()
    end
  end
  
  local chapterGroup = MRadioGroup:create()
  local yBegin, interval = 500, -60
  for index, data in ipairs(ActivityInfoCsv) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainTalkRes, {
      "chapter_a.png",
      "chapter_b.png"
    })
    btn:anch(0, 0.5):pos(5, yBegin + (index - 1) * interval):addTo(btnsBg)
    btn:setName(tostring(index))
    btn:setString({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#61270b")
    })
    btn:setGroup(chapterGroup)
    btn:setCallback(function()
      self:showSpecialActivityStoryList(index)
      showCost(index)
    end)
    UIHelper.MoveToRight({
      node = btn,
      delay = (index - 1) * 0.1,
      time = 0.2
    })
  end
  local iniIndex = intype or 1
  self:showSpecialActivityStoryList(iniIndex)
  showCost(iniIndex)
  chapterGroup:chooseByName(tostring(iniIndex))
end

function TalkLayer:showSpecialActivityStoryList(style)
  self.storyList:removeAllChildren()
  local storySet = StoryBookCsv[6]
  local curPage = game.role.storyBook["6"] or {}
  local curSet = {}
  for _, data in ipairs(storySet) do
    if data.style == style then
      table.insert(curSet, data)
    end
  end
  local size = display.newSprite(entanglementRes .. "jiban_1.png"):getContentSize()
  self.storyList:size(cc.size(786, 596))
  self.storyList:setInnerContainerSize(cc.size(786, 596))
  self.storyList:pos(style == 1 and 180 or 210, 0)
  size.width = self.storyList:getContentSize().width
  local unlockCost
  if globalCsv["storyUnlockCost_" .. style] then
    unlockCost = globalCsv["storyUnlockCost_" .. style]:toArray("=", true)
  end
  for _, data in ipairs(curSet) do
    local status = curPage[data.id]
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.storyList)
    local descLabel
    local content = UIHelper.newImageView(entanglementRes .. "jiban_1.png"):center(viewNode):addTo(viewNode)
    HeroHead.new({
      type = data.unlockType
    }):scale(0.85):pos(285, 59):addTo(content)
    display.newSprite(activityStoryRes .. "desc_bg.png"):pos(490, 56):addTo(content)
    if style == 1 then
      descLabel = display.newTTFLabel({
        text = data.unlockDesc,
        size = 20,
        color = UIHelper.hex2rgb("#9e4b0a")
      }):pos(490, 56):addTo(content)
    else
      local desc = status and data.content or data.unlockDesc
      if not status and unlockCost then
        desc = string.format("消耗<img src='%s' scale=0.6 />x%d 解锁该剧情", ItemCsv[unlockCost[1]].icon, unlockCost[2])
      end
      descLabel = MRichText.new({
        text = desc,
        size = 18,
        color = UIHelper.hex2rgb("#7f2510")
      }):anch(0.5, 0.5):pos(490, 56):addTo(content)
    end
    local lock = display.newSprite(MainTalkRes .. (status and "play.png" or "lock.png")):pos(55, 34):addTo(content)
    if status and status == 0 then
      display.newSprite(globalRes .. "story_new.png"):setFlippedX(true):pos(10, 103):addTo(content):name("red")
    end
    display.newTTFLabel({
      text = data.title,
      size = 22,
      color = UIHelper.hex2rgb("#532c1b")
    }):anch(0, 0.5):pos(32, 99):addTo(content)
    local box = UIHelper.newImageView(MainTalkRes .. "box.png"):pos(size.width - 70, 51):addTo(content)
    box:setCallback(function()
      ItemRewardLayer.new({
        items = data.gift:toTableArray(),
        preView = true
      })
    end)
    if status and status == 1 then
      display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
    end
    display.newTTFLabel({
      text = "回想奖励",
      size = 14,
      color = UIHelper.hex2rgb("#986e58")
    }):pos(size.width - 70, size.height - 27):addTo(content)
    content:setCallback(function()
      local function sendData()
        game:createView("talk.PlotTalkLayer", {
          talkId = data.play,
          
          csvNo = data.readcsv or 0,
          showSpeed = true,
          hideSkip = false,
          music = 4,
          onComplete = function()
            CommonHelper.playHomeBGM()
            if status == 1 then
              return
            end
            game:sendData(actionCodes.Role_finishTalkRpc, MsgPack.pack({
              page = 6,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Role_finishTalkRpc, function(event)
              UIHelper.removeWaiting()
              status = 1
              display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
              local red = content:getChildByName("red")
              if red then
                red:removeSelf()
              end
              display.newSprite(MainTalkRes .. "txt_done.png"):pos(size.width - 70, 25):addTo(content)
              MedalRewardLayer.new({
                items = data.gift:toNumMap()
              })
            end)
          end
        })
      end
      
      if status then
        sendData()
        return
      end
      if not unlockCost then
        if not status then
          SysError(SYS_ERR_STORY_UNLOCK)
          return
        end
      else
        local function sendUnlockActivityStory()
          MDialog:double({
            title = "提示",
            
            text = string.format("确认消耗<img src='%s' scale=0.6 />x%d 解锁该剧情吗？", ItemCsv[unlockCost[1]].icon, unlockCost[2]),
            okCallback = function()
              game:sendData(actionCodes.Role_unlockActivityStory, MsgPack.pack({
                page = 6,
                id = data.id
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Role_unlockActivityStory, function(event)
                UIHelper.removeWaiting()
                lock:setTexture(MainTalkRes .. "play.png")
                descLabel:setString(data.content)
                self:updateNum(unlockCost[1])
                sendData()
              end)
              return true
            end,
            cancelCallback = function()
              return true
            end
          })
        end
        
        if (game.role.items[unlockCost[1]] or 0) < unlockCost[2] then
          SysError(SYS_ERR_STORY_UNLOCK)
          return
        else
          sendUnlockActivityStory()
        end
      end
    end)
  end
  self.storyList:requestDoLayout()
end

function TalkLayer:showTopBar()
  TopBar:show(TopBarType.full, "剧情")
end

function TalkLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return TalkLayer
