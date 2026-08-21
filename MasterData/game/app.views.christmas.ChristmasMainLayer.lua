local BattleCsv = require("csvdata.moon_chapter_battle")
local TaskCsv = require("csvdata.moon_task")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/christmas/main/"
local uiData = {
  csbFile = "ui/christmas/ChristmasMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    heroNode = "heroNode",
    btnInfo = "btnInfo",
    btnShop = "btnShop",
    bottom = "bottom",
    countBg = "countBg",
    value = "countBg/value",
    countBg1 = "countBg1",
    value1 = "countBg1/value",
    btnsBg = "btnsBg",
    btn1 = "btnsBg/btn1",
    btn2 = "btnsBg/btn2",
    panel = "panel",
    list = "panel/list"
  }
}
local btnData = {
  [1] = {
    name = "选择区域",
    red = "",
    func = function(self)
      self:showCarbon()
    end
  },
  [2] = {
    name = "活动任务",
    red = "taskNormal",
    func = function(self)
      self:showTaskNormal()
    end
  }
}
local ChristmasMainLayer = class("ChristmasMainLayer", UIBase)

function ChristmasMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChristmasMainLayer:init(params)
  TopBar:show(TopBarType.full, "圣诞活动")
  TopBar:showAnimation(true)
  game:playMusic(22)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX())
    self.bottom:setPositionX(self.bottom:getPositionX() + UIHelper.getMoveXForX())
    self.panel:setPositionX(self.panel:getPositionX() + UIHelper.getMoveXForX())
    self.countBg:setPositionX(self.countBg:getPositionX() + UIHelper.getMoveXForX())
    self.countBg1:setPositionX(self.countBg1:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToDown({
    node = self.btnsBg,
    time = 0.5
  })
  UIHelper.MoveToLeft({
    node = self.panel,
    time = 0.6,
    pos = {650, 0}
  })
  UIHelper.MoveToLeft({
    node = self.countBg,
    time = 0.6,
    pos = {350, 0}
  })
  UIHelper.MoveToLeft({
    node = self.countBg1,
    time = 0.6,
    pos = {350, 0}
  })
  display.newSprite(ItemCsv[45].icon):scale(0.6):pos(23, 19):addTo(self.countBg1)
  local snow = UIHelper.createSpineNodeByRes("spine/home_skin/sdzc_snow")
  snow:setAnimation(0, "idle", true)
  snow:center(self.mainBg):addTo(self.mainBg)
  self.countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg,
      itemType = 63,
      itemData = ItemCsv[63]
    })
  end)
  self.countBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.countBg1,
      itemType = 45,
      itemData = ItemCsv[45]
    })
  end)
  self.value:setString(game.role.items[63] or 0)
  self.value1:setString(game.role.items[45] or 0)
  self.selected = 1
  self.handlers = {}
  self.btns = {}
  self.cells = {}
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTTFConfig({
        fontFilePath = display.DEFAULT_TTF_FONT,
        fontSize = 26,
        outlineSize = 1
      })
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTTFConfig({
        fontFilePath = display.DEFAULT_TTF_FONT,
        fontSize = 20,
        outlineSize = 1
      })
    end
  })
  for i, data in ipairs(btnData) do
    local btn = self["btn" .. i]
    display.newTTFLabel({
      text = data.name,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#620707"), 1):pos(65, 40):addTo(btn):name("name")
    btn:setName(string.format("index%d", i))
    btn:setGroup(group)
    btn:setCallback(function()
      self.selected = i
      self:showData()
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.christmas[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
    end
  end
  group:chooseByName("index1")
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "christmas" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.christmas[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
    end
  end))
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = MainRes .. "image_rule.png"
    })
  end)
  self.btnShop:setTouchScale()
  self.btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 4})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "圣诞活动")
      layer:close()
      self.value:setString(game.role.items[63] or 0)
      self.value1:setString(game.role.items[45] or 0)
    end)
  end)
end

function ChristmasMainLayer:showData(params)
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
  self:initHero()
end

function ChristmasMainLayer:showCarbon()
  self.list:removeAllChildren()
  local selected = 0
  local sortData = {}
  local maxCarbonId = 1
  for _, data in pairs(BattleCsv) do
    if data.id % 10 == 1 then
      local open, count = self:getCarbonStatus(data)
      local temp = clone(data)
      temp.open = open
      temp.count = count
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    return a.id < b.id
  end)
  local size = cc.size(510, 98)
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height + 4):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_1_lock.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#900808"), 2):anch(0, 0.5):pos(20, 74):addTo(cell)
    if data.open then
      maxCarbonId = index
      cell:setImage(MainRes .. "cell_1_open.png")
      display.newTTFLabel({
        text = "推荐美味度: " .. data.enterPower,
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#900808"), 1):anch(0, 0.5):pos(20, 45):addTo(cell)
      display.newTTFLabel({
        text = "净化程度:",
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#900808"), 1):anch(0, 0.5):pos(20, 21):addTo(cell)
      local mapId = math.floor(data.id / 10)
      if game.role.moonBattle.carbonId and mapId == math.floor(game.role.moonBattle.carbonId / 10) then
        display.newSprite("ui/autumn/main/battle.png"):pos(461, 85):addTo(cell)
        selected = index
      end
      local xPos = 135
      for i = 1, 3 do
        local tempCount = game.role.midBattleCount:getv(mapId * 10 + i, 0)
        display.newSprite(MainRes .. (1 <= tempCount and "tree_w.png" or "tree_r.png")):pos(xPos, 21):addTo(cell)
        xPos = xPos + 30
      end
      cell:setCallback(function()
        game:createView("christmas.ChristmasDetailLayer", {id = mapId})
      end)
    else
      display.newSprite(MainRes .. "image_lock_1.png"):pos(248, 23):addTo(cell)
      cell:setCallback(function()
        MFlashMsg:show({
          text = "请完成 " .. BattleCsv[data.openLevel].name
        })
      end)
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if maxCarbonId < #sortData - 3 then
    self.list:scrollToItem(maxCarbonId - 1, cc.p(0, 0.65), cc.p(0, -0.5))
  else
    self.list:jumpToBottom()
  end
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.65), cc.p(0, -0.5))
  end
  self:initBuffUse()
end

function ChristmasMainLayer:initBuffUse()
  local items = {45}
  local idx = 1
  local btn = UIHelper.newImageView(MainRes .. "btn_use_bg.png"):pos(405, 30):addTo(self.bottom)
  
  local function updateUse()
    local useId = game.role.midBattleCount:getv(1, 0)
    btn:removeAllChildren()
    display.newTTFLabel({
      text = "自动消耗",
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#7f3710"), 1):pos(108, 27):addTo(btn)
    if useId == items[idx] then
      display.newSprite(MainRes .. "btn_use_yes.png"):pos(23, 24):addTo(btn)
    end
    local btnAdd = UIHelper.newImageView(MainRes .. "btn_add.png"):pos(228, 26):addTo(btn)
    btnAdd:setCallback(function()
      game:createView("shop.CommonItemCountLayer", {
        showType = "moon",
        data = {itemId = 45},
        callback = function(num)
          game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
            type = 5,
            itemId = items[idx],
            count = num
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
            UIHelper.removeWaiting()
            self.value1:setString(game.role.items[45] or 0)
            MedalRewardLayer.new({
              items = {
                [45] = num
              }
            })
          end)
        end
      })
    end)
  end
  
  btn:setCallback(function()
    if (game.role.items[items[idx]] or 0) < 1 then
      SysError(SYS_ERR_MOON_CARBON_QUAN_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_midAutRewardRpc, MsgPack.pack({
      type = 4,
      itemId = items[idx]
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_midAutRewardRpc, function(event)
      UIHelper.removeWaiting()
      updateUse()
    end)
  end)
  updateUse()
end

function ChristmasMainLayer:showTaskNormal()
  self.list:removeAllChildren()
  local selected = 0
  local sortData = {}
  self.cells = {}
  for _, data in pairs(TaskCsv) do
    if data.openTime == "" then
      local open, count = self:getTaskStatus(data)
      local temp = clone(data)
      temp.open = open
      temp.count = count
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    local factorA = a.count == -1 and 10000 or 0
    local factorB = b.count == -1 and 10000 or 0
    return a.id + factorA < b.id + factorB
  end)
  local size = cc.size(510, 98)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height + 4):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_2.png"):center(viewNode):addTo(viewNode)
    if data.open then
      display.newTTFLabel({
        text = data.desc,
        size = 18,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      local xPos = 362
      for _, set in ipairs(data.gift:toTableArray()) do
        ItemIcon.new({
          type = tonumber(set[1]),
          count = tonumber(set[2]),
          showTip = true
        }):scale(0.64):pos(xPos, 45):addTo(cell)
        xPos = xPos - 65
      end
      if data.count == -1 then
        display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
      elseif data.count >= data.condition1 then
        local label = display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#ba471a")
        }):pos(440, 67):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create())
        btn:setImages(MainRes, {
          "btn_get.png",
          "btn_get.png"
        })
        btn:pos(440, 39):addTo(cell):setTouchScale()
        btn:setString({text = "领取", size = 18})
        btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
        btn:setCallback(function()
          if not game.role:activityIsOpen(31) then
            SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
            return
          end
          game:sendData(actionCodes.Activity_christmasRewardRpc, MsgPack.pack({
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_christmasRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            btn:removeFromParent()
            label:removeFromParent()
            display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
            MedalRewardLayer.new({
              items = msg.reward,
              callback = function()
                self:refresh("#ba471a")
              end
            })
          end)
        end)
      else
        display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#ba471a")
        }):pos(440, 60):addTo(cell)
        display.newTTFLabel({
          text = "完成进度",
          size = 18,
          color = UIHelper.hex2rgb("#ba471a")
        }):pos(440, 38):addTo(cell)
      end
    else
      display.newSprite(MainRes .. "image_lock_2.png"):pos(248, 23):addTo(cell)
      display.newTTFLabel({
        text = data.unlockDesc,
        size = 18,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      self.cells[data.id] = cell
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if 0 < selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.5), cc.p(0, -0.5))
  end
end

function ChristmasMainLayer:showTaskSpecial()
  self.list:removeAllChildren()
  self.cells = {}
  local sortData = {}
  for _, data in pairs(TaskCsv) do
    if data.openTime ~= "" then
      local open, count = self:getTaskStatus(data)
      local temp = clone(data)
      temp.open = open
      temp.count = count
      table.insert(sortData, temp)
    end
  end
  table.sort(sortData, function(a, b)
    local factorA = a.count == -1 and 10000 or 0
    local factorB = b.count == -1 and 10000 or 0
    return a.id + factorA < b.id + factorB
  end)
  local size = cc.size(510, 98)
  for _, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width, size.height + 4):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_3.png"):center(viewNode):addTo(viewNode)
    if data.open then
      display.newTTFLabel({
        text = data.desc,
        size = 18,
        color = UIHelper.hex2rgb("#d7f4ff")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      local xPos = 362
      for _, set in ipairs(data.gift:toTableArray()) do
        ItemIcon.new({
          type = tonumber(set[1]),
          count = tonumber(set[2]),
          showTip = true
        }):scale(0.64):pos(xPos, 45):addTo(cell)
        xPos = xPos - 65
      end
      if data.count == -1 then
        display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
      elseif data.count >= data.condition1 then
        local label = display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#d7f4ff")
        }):pos(440, 67):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create())
        btn:setImages(MainRes, {
          "btn_get.png",
          "btn_get.png"
        })
        btn:pos(440, 39):addTo(cell):setTouchScale()
        btn:setString({text = "领取", size = 18})
        btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
        btn:setCallback(function()
          if not game.role:activityIsOpen(31) then
            SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
            return
          end
          game:sendData(actionCodes.Activity_christmasRewardRpc, MsgPack.pack({
            id = data.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_christmasRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            btn:removeFromParent()
            label:removeFromParent()
            display.newSprite(MainRes .. "image_done.png"):pos(440, 45):addTo(cell)
            MedalRewardLayer.new({
              items = msg.reward,
              callback = function()
                self:refresh("#d7f4ff")
              end
            })
          end)
        end)
      else
        display.newTTFLabel({
          text = data.count .. "/" .. data.condition1,
          size = 18,
          color = UIHelper.hex2rgb("#d7f4ff")
        }):pos(440, 60):addTo(cell)
        display.newTTFLabel({
          text = "完成进度",
          size = 18,
          color = UIHelper.hex2rgb("#d7f4ff")
        }):pos(440, 38):addTo(cell)
      end
    else
      display.newSprite(MainRes .. "image_lock_1.png"):pos(248, 23):addTo(cell)
      display.newTTFLabel({
        text = data.unlockDesc,
        size = 18,
        color = UIHelper.hex2rgb("#d7f4ff")
      }):anch(0, 0.5):pos(10, 64):addTo(cell)
      self.cells[data.id] = cell
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
end

function ChristmasMainLayer:refresh(color)
  for taskId, cell in pairs(self.cells) do
    local data = TaskCsv[taskId]
    local open, count = self:getTaskStatus(data)
    if open then
      local flash = display.newSprite(MainRes .. "cell_flash.png"):center(cell):addTo(cell)
      flash:setOpacity(0)
      flash:runAction(transition.sequence({
        cc.FadeIn:create(0.4),
        cc.CallFunc:create(function()
          cell:removeAllChildren()
          display.newTTFLabel({
            text = data.desc,
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):anch(0, 0.5):pos(10, 64):addTo(cell)
          local xPos = 362
          for _, set in ipairs(data.gift:toTableArray()) do
            ItemIcon.new({
              type = tonumber(set[1]),
              count = tonumber(set[2]),
              showTip = true
            }):scale(0.64):pos(xPos, 45):addTo(cell)
            xPos = xPos - 65
          end
          display.newTTFLabel({
            text = count .. "/" .. data.condition1,
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):pos(440, 60):addTo(cell)
          display.newTTFLabel({
            text = "完成进度",
            size = 18,
            color = UIHelper.hex2rgb(color)
          }):pos(440, 38):addTo(cell)
        end),
        cc.FadeOut:create(0.2),
        cc.RemoveSelf:create()
      }))
    end
  end
end

function ChristmasMainLayer:initHero()
  self.heroNode:removeAllChildren()
  local texts1 = {
    [1] = "圣者？真是的……无论是我还是你，看起来都不太像的吧……",
    [2] = "想要更多的笔记？你这个人……还真是忠于欲望，明明上面写的都是你的缺点……",
    [3] = "童话的结局要么是美好的，要么是悲惨的，而现实往往对半折中。能克服这种无趣的人才是真正的圣人吧。",
    [4] = "我倒是也想去多见识些新的食灵呢，不过困难可不等人……继续前进吧。"
  }
  local texts2 = {
    [1] = "怎么回事啊，这回的冒险居然没有我出场的机会……！那我只好用魔术换掉看板娘了！",
    [2] = "什么什么？表演一下可以轻松获得奖励的魔术？好啊好啊交给我！主厨主厨，白天睡觉催眠术——砰！",
    [3] = "喂喂，任务版可要看仔细了哟！最好截个图！小心我用魔术变换掉完成条件~",
    [4] = "快去看有没有新的奖励啦，如果这一年来有做好孩子，说不定真的会有圣诞老人送礼物呢！"
  }
  local heroId = self.selected == 1 and 321 or 34121
  local texts = self.selected == 1 and texts1 or texts2
  local card = UIHelper.newImageView(UIHelper.getCardRes("normal", heroId, false)):addTo(self.heroNode)
  card:setCallback(function()
    if not tolua.isnull(self.talkBg) then
      return
    end
    self.talkBg = display.newSprite("ui/home/talk_bg.png"):pos(-85, -120):addTo(self.heroNode)
    self.talkBg:setCascadeOpacityEnabled(true)
    self.talkBg:setOpacity(0)
    self.talkBg:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 50))),
      cc.CallFunc:create(function()
        local index = math.random(1, #texts)
        local label = MRichText.new({
          text = texts[index],
          color = UIHelper.hex2rgb("#000000"),
          size = 18,
          maxWidth = 265
        }):pos(20, 100):addTo(self.talkBg)
        label:playAnimation(20, nil, nil)
      end),
      cc.DelayTime:create(7),
      cc.Spawn:create(cc.FadeOut:create(0.5), cc.MoveBy:create(0.5, cc.p(0, 70))),
      cc.RemoveSelf:create()
    }))
  end)
end

function ChristmasMainLayer:getCarbonStatus(chapter)
  local count = game.role.midBattleCount:getv(chapter.id, 0)
  if chapter.openLevel ~= 0 and game.role.midBattleCount:getv(chapter.openLevel, 0) == 0 then
    return false, count
  end
  return true, count
end

function ChristmasMainLayer:getTaskStatus(task)
  local count = game.role.midAutAreaTask:getv(task.id, 0)
  if task.openTime ~= "" and game:nowTime() < CommonHelper.toUnixtime(task.openTime .. string.format("%02x", RESET_TIME)) then
    return false, count
  end
  if task.openTask ~= 0 then
    local temp = TaskCsv[task.openTask]
    local tempCount = game.role.midAutAreaTask:getv(temp.id, 0)
    if tempCount ~= -1 then
      return false, count
    end
  end
  return true, count
end

function ChristmasMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return ChristmasMainLayer
