local MissionCsv = require("csvdata.mission")
local LoopCsv = require("csvdata.loop_task")
local ItemCsv = require("csvdata.item")
local LoveCsv = require("csvdata.love_task")
local LovePlusCsv = require("csvdata.love_plus")
local RandomTaskCsv = require("csvdata.random_task")
local AchieveCsv = require("csvdata.achievement")
local ChapterInfoCsv = require("csvdata.chapter_info")
local MainRes = "ui/mission/main/"
local HeroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/mission/MissionLayer.csb",
  widgets = {
    up = "up",
    center = "center",
    btnList = "btnList",
    btnsBg = "btnsBg",
    btnChange = "btnChange",
    btnBg = "btnBg",
    list = "mainBg/list",
    achieveNum = "mainBg/achieveNum"
  }
}
local MissionLayer = class("MissionLayer", UIBase)

function MissionLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local MissionNames = {
  [1] = {name = "日常", red = "daily"},
  [2] = {name = "周常", red = "week"},
  [3] = {name = "主线", red = "main"},
  [4] = {name = "好感度", red = "love"}
}
local AchieveNames = {
  [1] = {
    name = "关卡净化",
    red = "carbon"
  },
  [2] = {
    name = "食灵收集",
    red = "collectH"
  },
  [3] = {
    name = "食灵培养",
    red = "growH"
  },
  [4] = {
    name = "装备收集",
    red = "collectE"
  },
  [5] = {
    name = "装备培养",
    red = "growE"
  },
  [6] = {
    name = "好感培养",
    red = "love"
  },
  [7] = {
    name = "资源收集",
    red = "source"
  },
  [8] = {
    name = "餐车便当盒",
    red = "sell"
  },
  [9] = {
    name = "食灵升华",
    red = "tree"
  },
  [10] = {name = "酱料", red = "sauce"},
  [11] = {
    name = "食灵觉醒",
    red = "awake"
  },
  [12] = {
    name = "梦境呼唤",
    red = "dream"
  }
}

function MissionLayer:init(params)
  params = params or {}
  TopBar:show(TopBarType.full, "任务")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnChange:setPositionX(self.btnChange:getPositionX() - UIHelper.getMoveXForX())
    self.btnBg:setPositionX(self.btnBg:getPositionX() - UIHelper.getMoveXForX())
    self.btnList:setPositionX(self.btnList:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX() + 50)
  end
  UIHelper.MoveToDown({
    node = self.up
  })
  self.handlers = {}
  self.btns = {}
  self.selectType = params.type or 1
  self.selectIndex = params.index or 1
  self.first = true
  self.size = display.newSprite(MainRes .. "cell_achieve_1.png"):getContentSize()
  self.size.height = self.size.height + 20
  self.half = self.size.width / 2
  self.btnChange:setCallback(function()
    if self.selectType == 1 then
      self.selectType = 2
    else
      self.selectType = 1
    end
    self.selectIndex = 1
    self:showData()
  end)
  if game:nowTime() <= 1654286400 then
    self:runAction(cc.RepeatForever:create(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if game:nowTime() >= 1654286400 then
          self.refresh = 1
          self:showData()
        end
      end)
    })))
  end
end

function MissionLayer:showData(params)
  if next(self.handlers) then
    for _, tag in pairs(self.handlers) do
      game.role:removeEventListener(tag)
    end
  end
  self.handlers = {}
  self.btns = {}
  self.btnList:removeAllChildren()
  self.list:removeAllChildren()
  local btnData
  if self.selectType == 1 then
    self.achieveNum:hide()
    self.btnChange:setImage(MainRes .. "btn_mission.png")
    btnData = MissionNames
    local bShow = checkbool(next(game.role.redPoints.achieve))
    UIHelper.showRedPoint(self.btnChange, bShow, cc.p(0, -11), 0.7)
  else
    self.achieveNum:show()
    self.btnChange:setImage(MainRes .. "btn_achieve.png")
    btnData = AchieveNames
    UIHelper.showRedPoint(self.btnChange, false, cc.p(0, -11), 0.7)
  end
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(HeroRes .. "taocan_1.png"):getContentSize()
  btnSize.height = btnSize.height + 4
  local delay = 0.4
  for index, data in ipairs(btnData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(HeroRes, {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:center(viewNode):addTo(viewNode)
    btn:setCascadeOpacityEnabled(true)
    btn:setCallback(function()
      self.selectIndex = index
      if self.selectType == 1 then
        self:showMissionData()
      else
        self:showAchieveData()
      end
    end)
    btn:setName(string.format("name%d", index))
    btn:setGroup(self.group)
    display.newTTFLabel({
      text = data.name,
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(56, 26):addTo(btn)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local resPoints = self.selectType == 1 and game.role.redPoints.mission or game.role.redPoints.achieve
      local bShow = checkbool(resPoints[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
    end
    if self.first then
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.18
      })
      delay = delay + 0.1
    end
  end
  local di = ccui.Widget:create()
  di:setContentSize(cc.size(btnSize.width, btnSize.height - 20)):addTo(self.btnList)
  self.btnList:requestDoLayout()
  self.btnList:jumpToTop()
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "mission" and self.selectType == 1 or event.type == "achieve" and self.selectType == 2 then
      local resPoints = self.selectType == 1 and game.role.redPoints.mission or game.role.redPoints.achieve
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(resPoints[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(15, 5))
      end
    end
    if event.type == "mission" and self.selectType == 1 then
      local bShow = checkbool(next(game.role.redPoints.achieve))
      UIHelper.showRedPoint(self.btnChange, bShow, cc.p(0, -11), 0.7)
    end
  end))
  if self.selectType == 1 then
    self:showMissionData()
  else
    self:showAchieveData()
  end
  self.group:chooseByName("name" .. self.selectIndex)
  if self.first then
    self.first = false
  end
end

function MissionLayer:showMissionData()
  self.finalCsv = {}
  local Str = {
    [1] = "dailyTaskStatusNew",
    [2] = "weekTaskStatusNew",
    [4] = "loveTaskNew"
  }
  if Str[self.selectIndex] then
    local statusStr = game.role[Str[self.selectIndex]] or ""
    self.status = statusStr:toNumMap()
  end
  if self.selectIndex == 1 then
    for _, data in pairs(table.values(LoopCsv[1])) do
      if (data.unlock == 0 or game.role.carbons[data.unlock]) and self.status[data.id] ~= -1 and (data.pre == 0 or self.status[data.pre] == -1) then
        table.insert(self.finalCsv, data)
      end
    end
    for id, count in pairs(self.status) do
      if 1000 <= id and count ~= -1 then
        local data = RandomTaskCsv[1][id]
        if data.unlock == 0 or game.role.carbons[data.unlock] then
          table.insert(self.finalCsv, data)
        end
      end
    end
  elseif self.selectIndex == 2 then
    for _, data in pairs(table.values(LoopCsv[2])) do
      if game.role.carbons[data.unlock] and self.status[data.id] ~= -1 and (data.pre == 0 or self.status[data.pre] == -1) then
        table.insert(self.finalCsv, data)
      end
    end
    for id, count in pairs(self.status) do
      if 1000 <= id and count ~= -1 then
        local data = RandomTaskCsv[2][id]
        if data.unlock == 0 or game.role.carbons[data.unlock] then
          table.insert(self.finalCsv, data)
        end
      end
    end
  elseif self.selectIndex == 3 then
    for index, data in ipairs(MissionCsv) do
      local carbon = game.role.carbons[data.condition1]
      local mapId = math.floor(data.unlock / 100)
      if carbon and 0 < ChapterInfoCsv[mapId].open then
        local tasks = carbon.task:toNumMap()
        if not tasks[data.condition2] then
          table.insert(self.finalCsv, data)
        end
      end
    end
  elseif self.selectIndex == 4 then
    for id, cur in pairs(self.status) do
      local hero = game.role.heros[id]
      if hero then
        local LoveData = LoveCsv[hero.type] or {}
        for _, data in pairs(LoveData) do
          if data.unlock == hero.love then
            local temp = clone(data)
            temp.heroId = id
            table.insert(self.finalCsv, temp)
            break
          end
        end
      end
    end
  end
  table.sort(self.finalCsv, function(a, b)
    local processA, processB
    if self.selectIndex == 3 then
      local curA, allA = table.nums(game.role.carbons[a.condition1].achievement:toNumMap()), a.condition2
      local curB, allB = table.nums(game.role.carbons[b.condition1].achievement:toNumMap()), b.condition2
      processA = math.floor(curA / allA)
      processB = math.floor(curB / allB)
      processA = 0 < processA and a.order or 0
      processB = 0 < processB and b.order or 0
    elseif self.selectIndex == 4 then
      local curA, allA = self.status[a.heroId], a.condition2 ~= 0 and a.condition2 or a.condition1
      local curB, allB = self.status[b.heroId], b.condition2 ~= 0 and b.condition2 or b.condition1
      processA = math.floor(curA / allA * 10000)
      processB = math.floor(curB / allB * 10000)
    else
      local curA, allA = self.status[a.id] or 0, a.condition2 ~= 0 and a.condition2 or a.condition1
      local curB, allB = self.status[b.id] or 0, b.condition2 ~= 0 and b.condition2 or b.condition1
      processA = math.floor(curA / allA * 10000)
      processB = math.floor(curB / allB * 10000)
    end
    local factorA = processA - (a.order or 0)
    local factorB = processB - (b.order or 0)
    if factorA == factorB then
      return -(a.order or 0) > -(b.order or 0)
    end
    return factorA > factorB
  end)
  if self.selectIndex == 1 then
    self:showDailyMission(self.selectIndex)
  elseif self.selectIndex == 2 then
    self:showWeekMission(self.selectIndex)
  elseif self.selectIndex == 3 then
    self:showMainMission(self.selectIndex)
  elseif self.selectIndex == 4 then
    self:showLoveMission(self.selectIndex)
  end
end

function MissionLayer:showMainMission(selected)
  self.list:removeAllChildren()
  local cellSize = UIHelper.newImageView(MainRes .. "cell_mission.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  
  local function createCell(cellData, cellIndex)
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_mission.png"):center(viewNode):addTo(viewNode)
    display.newSprite(MainRes .. "image.png"):pos(60, 62):addTo(cell)
    display.newTTFLabel({
      text = cellData.name,
      size = 24,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 110):addTo(cell)
    display.newTTFLabel({
      text = cellData.desc,
      size = 20,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 75):addTo(cell)
    if cellData.roleExp ~= 0 then
      if game.role.level < 30 then
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp * 2 .. " (30级以前经验翻倍)",
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      else
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp,
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      end
    end
    local gifts = cellData.gift:toNumMap()
    local xPos, yPos, interval, slot = 695, 32, -60, 0
    for index = 4, 1, -1 do
      if gifts[index] then
        local iconBg = display.newSprite(MainRes .. "item_bg.png"):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newSprite(ItemCsv[index].icon):scale(0.5):center(iconBg):addTo(iconBg)
        display.newTTFLabel({
          text = gifts[index],
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(46, -2):addTo(iconBg)
        slot = slot + 1
      end
    end
    for itemId, count in pairs(gifts) do
      if 4 < itemId then
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newTTFLabel({text = count, size = 32}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 18):addTo(icon)
        slot = slot + 1
      end
    end
    local cur = game.role.carbons[cellData.condition1].starNum or 0
    local all = cellData.condition2
    local process = math.floor(cur / all * 100)
    local Done = 100 <= process
    local color = Done and "#5f8500" or "#500303"
    local image = Done and "anniu_1.png" or "anniu_2.png"
    local text = Done and "领取" or "前往"
    display.newTTFLabel({
      text = string.format("%d/%d", cur, all),
      size = 26,
      color = UIHelper.hex2rgb(color)
    }):pos(830, 90):addTo(cell)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {image, image})
    btn:pos(834, 50):addTo(cell):setTouchScale()
    btn:name("drawBtn" .. cellIndex)
    btn:setString({text = text, size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      if Done then
        game:sendData(actionCodes.Role_mainTaskRpc, MsgPack.pack({
          taskId = cellData.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_mainTaskRpc, function(event)
          UIHelper.removeWaiting()
          if tolua.isnull(viewNode) then
            return
          end
          viewNode:runAction(transition.sequence({
            cc.MoveBy:create(0.3, cc.p(950, 0)),
            cc.CallFunc:create(function()
              self:showMissionData()
            end)
          }))
          MedalRewardLayer.new({
            items = gifts,
            callback = function()
              if game.role.majorGuideStep == 13 then
                game.role.minorGuideStep = 5
                NewGuideLayer.new({
                  step = 13,
                  callback = function()
                    game:enterScene("MainScene")
                  end
                })
              end
            end
          })
        end)
      else
        self:showForward(cellData, selected, 1)
      end
    end)
  end
  
  local num = 0
  for index, data in ipairs(self.finalCsv) do
    if 20 <= num then
      break
    end
    createCell(data, index)
    num = num + 1
  end
  if not next(self.finalCsv) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "主线任务已全部完成",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function MissionLayer:showDailyMission(selected)
  self.list:removeAllChildren()
  local cellSize = UIHelper.newImageView(MainRes .. "cell_mission.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  
  local function createCell(cellData)
    if cellData.id == 3001 and game:nowTime() >= 1614369600 then
      return
    end
    if (cellData.id == 3002 or cellData.id == 3003) and game:nowTime() >= 1617307200 then
      return
    end
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_mission.png"):center(viewNode):addTo(viewNode)
    display.newSprite(MainRes .. "image.png"):pos(60, 62):addTo(cell)
    display.newTTFLabel({
      text = cellData.name,
      size = 24,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 110):addTo(cell)
    display.newTTFLabel({
      text = cellData.desc,
      size = 20,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 75):addTo(cell)
    if cellData.roleExp ~= 0 then
      if game.role.level < 30 then
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp * 2 .. " (30级以前经验翻倍)",
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      else
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp,
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      end
    end
    local gifts = cellData.gift:toNumMap()
    local xPos, yPos, interval, slot = 695, 32, -60, 0
    for index = 4, 1, -1 do
      if gifts[index] then
        local iconBg = display.newSprite(MainRes .. "item_bg.png"):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newSprite(ItemCsv[index].icon):scale(0.5):center(iconBg):addTo(iconBg)
        display.newTTFLabel({
          text = gifts[index],
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(46, -2):addTo(iconBg)
        slot = slot + 1
      end
    end
    for itemId, count in pairs(gifts) do
      if 4 < itemId then
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newTTFLabel({text = count, size = 32}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 18):addTo(icon)
        slot = slot + 1
      end
    end
    local cur = self.status[cellData.id] or 0
    local all = cellData.condition2 ~= 0 and cellData.condition2 or cellData.condition1
    local process = math.floor(cur / all * 100)
    local Done = 100 <= process
    local color = Done and "#5f8500" or "#500303"
    local image = Done and "anniu_1.png" or "anniu_2.png"
    local text = Done and "领取" or "前往"
    display.newTTFLabel({
      text = string.format("%d/%d", cur, all),
      size = 26,
      color = UIHelper.hex2rgb(color)
    }):pos(830, 90):addTo(cell)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {image, image})
    btn:pos(834, 50):addTo(cell):setTouchScale()
    btn:setString({text = text, size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      if Done then
        game:sendData(actionCodes.Role_dailyTaskRpc, MsgPack.pack({
          index = cellData.id,
          part = cellData.part
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_dailyTaskRpc, function(event)
          UIHelper.removeWaiting()
          if tolua.isnull(viewNode) then
            return
          end
          local msg = MsgPack.unpack(event.data)
          viewNode:runAction(transition.sequence({
            cc.MoveBy:create(0.3, cc.p(950, 0)),
            cc.CallFunc:create(function()
              self:showMissionData()
            end)
          }))
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      else
        self:showForward(cellData, selected)
      end
    end)
  end
  
  for index, data in ipairs(self.finalCsv) do
    createCell(data)
  end
  if not next(self.finalCsv) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "日常任务已全部完成",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function MissionLayer:showWeekMission(selected)
  self.list:removeAllChildren()
  local cellSize = UIHelper.newImageView(MainRes .. "cell_mission.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  
  local function createCell(cellData)
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_mission.png"):center(viewNode):addTo(viewNode)
    display.newSprite(MainRes .. "image.png"):pos(60, 62):addTo(cell)
    display.newTTFLabel({
      text = cellData.name,
      size = 24,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 110):addTo(cell)
    display.newTTFLabel({
      text = cellData.desc,
      size = 20,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 75):addTo(cell)
    if cellData.roleExp ~= 0 then
      if game.role.level < 30 then
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp * 2 .. " (30级以前经验翻倍)",
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      else
        display.newTTFLabel({
          text = "主厨经验 +" .. cellData.roleExp,
          size = 20,
          color = UIHelper.hex2rgb("#500303")
        }):anch(0, 0.5):pos(130, 30):addTo(cell)
      end
    end
    local gifts = cellData.gift:toNumMap()
    local xPos, yPos, interval, slot = 695, 32, -60, 0
    for index = 4, 1, -1 do
      if gifts[index] then
        local iconBg = display.newSprite(MainRes .. "item_bg.png"):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newSprite(ItemCsv[index].icon):scale(0.5):center(iconBg):addTo(iconBg)
        display.newTTFLabel({
          text = gifts[index],
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(46, -2):addTo(iconBg)
        slot = slot + 1
      end
    end
    for itemId, count in pairs(gifts) do
      if 4 < itemId then
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(xPos + slot * interval, yPos):addTo(cell)
        display.newTTFLabel({text = count, size = 32}):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 18):addTo(icon)
        slot = slot + 1
      end
    end
    local cur = self.status[cellData.id] or 0
    local all = cellData.condition2 ~= 0 and cellData.condition2 or cellData.condition1
    local process = math.floor(cur / all * 100)
    local Done = 100 <= process
    local color = Done and "#5f8500" or "#500303"
    local image = Done and "anniu_1.png" or "anniu_2.png"
    local text = Done and "领取" or "前往"
    display.newTTFLabel({
      text = string.format("%d/%d", cur, all),
      size = 26,
      color = UIHelper.hex2rgb(color)
    }):pos(830, 90):addTo(cell)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {image, image})
    btn:pos(834, 50):addTo(cell):setTouchScale()
    btn:setString({text = text, size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      if Done then
        game:sendData(actionCodes.Role_dailyTaskRpc, MsgPack.pack({
          index = cellData.id,
          part = cellData.part
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_dailyTaskRpc, function(event)
          UIHelper.removeWaiting()
          if tolua.isnull(viewNode) then
            return
          end
          local msg = MsgPack.unpack(event.data)
          viewNode:runAction(transition.sequence({
            cc.MoveBy:create(0.3, cc.p(950, 0)),
            cc.CallFunc:create(function()
              self:showMissionData()
            end)
          }))
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      else
        self:showForward(cellData, selected)
      end
    end)
  end
  
  for index, data in ipairs(self.finalCsv) do
    createCell(data)
  end
  if not next(self.finalCsv) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "周常任务已全部完成",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function MissionLayer:showLoveMission(selected)
  self.list:removeAllChildren()
  local cellSize = UIHelper.newImageView(MainRes .. "cell_mission.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  
  local function createCell(cellData)
    local viewNode = ccui.Widget:create()
    viewNode:size(cellSize):addTo(self.list)
    local cell = UIHelper.newImageView(MainRes .. "cell_mission.png"):center(viewNode):addTo(viewNode)
    local bg = display.newSprite(MainRes .. "hero_bg.png"):pos(60, 62):addTo(cell)
    local hero = game.role.heros[cellData.heroId]
    UIHelper.getClipNode({
      steRes = "ui/global/mask_2.png",
      clipRes = UIHelper.getCardRes("book", hero.type, nil, hero.quality)
    }):scale(0.7):center(bg):addTo(bg)
    display.newSprite(MainRes .. "hero_fram.png"):center(bg):addTo(bg)
    display.newTTFLabel({
      text = cellData.name,
      size = 24,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 110):addTo(cell)
    display.newTTFLabel({
      text = cellData.desc,
      size = 20,
      color = UIHelper.hex2rgb("#500303")
    }):anch(0, 0.5):pos(130, 75):addTo(cell)
    local cur = self.status[cellData.heroId]
    local all = cellData.condition2 ~= 0 and cellData.condition2 or cellData.condition1
    local process = math.floor(cur / all * 100)
    local Done = 100 <= process
    local color = Done and "#5f8500" or "#500303"
    local image = Done and "anniu_1.png" or "anniu_2.png"
    local text = Done and "完成" or "前往"
    display.newTTFLabel({
      text = string.format("%d/%d", cur, all),
      size = 25,
      color = UIHelper.hex2rgb(color)
    }):pos(830, 90):addTo(cell)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {image, image})
    btn:pos(834, 50):addTo(cell):setTouchScale()
    btn:setString({text = text, size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      if Done then
        game:sendData(actionCodes.Hero_finishLoveTaskRpc, MsgPack.pack({
          heroId = cellData.heroId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Hero_finishLoveTaskRpc, function(event)
          UIHelper.removeWaiting()
          btn:setTouchEnabled(false)
          if tolua.isnull(viewNode) then
            return
          end
          viewNode:runAction(transition.sequence({
            cc.MoveBy:create(0.3, cc.p(950, 0)),
            cc.CallFunc:create(function()
              self:showMissionData()
            end)
          }))
          
          local function showTip()
            local hero = game.role.heros[cellData.heroId]
            local tip = LovePlusCsv[hero.type]["break" .. hero.loveBreak]
            if tip ~= "" then
              MFlashMsg:show({text = tip})
            end
          end
          
          if cellData.story1 ~= 0 then
            game:createView("talk.PlotTalkLayer", {
              talkId = cellData.story1,
              csvNo = cellData.readcsv or 0,
              showSpeed = true,
              hideSkip = false,
              onComplete = function()
                CommonHelper.playHomeBGM()
                showTip()
              end
            })
          else
            showTip()
          end
        end)
      else
        self:showLoveForward(cellData, selected)
      end
    end)
  end
  
  for index, data in ipairs(self.finalCsv) do
    createCell(data)
  end
  if not next(self.finalCsv) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "好感度任务已全部完成",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function MissionLayer:showLoveForward(data, selected)
  local jumpType, cond
  if data.type == 1 then
    jumpType = 4
    if data.condition1 ~= 0 then
      cond = data.condition1
    end
  elseif data.type == 2 then
    jumpType = 19
  elseif data.type == 3 then
    local toIdx = {
      8,
      4,
      7
    }
    jumpType = toIdx[data.condition1]
  elseif data.type == 4 then
    jumpType = 4
  end
  CommonHelper.jumpLayer(jumpType, function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "活动")
    self:show()
    self:showMissionData()
    TopBar:show(TopBarType.full, "任务")
    CommonHelper.playHomeBGM()
  end, cond)
end

function MissionLayer:showForward(data, selected, type)
  local jumpType = data.type and data.type or 4
  jumpType = jumpType == 10 and 5 or jumpType
  local cond = data.type and (data.condition2 ~= 0 and data.condition1 or 0) or data.link
  CommonHelper.jumpLayer(jumpType, function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "活动")
    self:show()
    self:showMissionData()
    TopBar:show(TopBarType.full, "任务")
    CommonHelper.playHomeBGM()
  end, cond, type)
end

function MissionLayer:showAchieveData()
  self.list:removeAllChildren()
  self.finalCsv = {}
  for _, data in pairs(AchieveCsv) do
    if data.flag == self.selectIndex then
      table.insert(self.finalCsv, data)
    end
  end
  table.sort(self.finalCsv, function(a, b)
    local curA, allA, _ = self:getProgress(a)
    local curB, allB, _ = self:getProgress(b)
    local factorA = (allA <= curA and 1000 or 0) - a.order
    local factorB = (allB <= curB and 1000 or 0) - b.order
    return factorA > factorB
  end)
  self:showAchieveList()
end

function MissionLayer:showAchieveList()
  for index, data in ipairs(self.finalCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:size(self.size):addTo(self.list)
    display.newSprite(MainRes .. "image_mask.png"):anch(0.5, 1):pos(self.half, self.size.height):addTo(viewNode)
    local image
    if data.res ~= "" then
      image = display.newSprite(data.res):anch(0.5, 1):pos(55, self.size.height + 1):addTo(viewNode)
    end
    local cell = display.newSprite(MainRes .. "cell_achieve_1.png"):anch(0.5, 0):pos(self.half, 0):addTo(viewNode)
    display.newSprite(MainRes .. "image_line.png"):pos(250, 60):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 26,
      color = UIHelper.hex2rgb("#703802")
    }):pos(240, 82):addTo(viewNode)
    display.newTTFLabel({
      text = data.goal,
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):pos(240, 43):addTo(viewNode)
    local gifts = data.item:toTableArray()
    local xPos, yPos, interval = 750, 50, -60
    for _, set in ipairs(gifts) do
      local itemId = tonumber(set[1])
      if itemId <= 4 then
        local iconBg = display.newSprite(MainRes .. "item_bg.png"):pos(xPos, yPos):addTo(cell)
        display.newSprite(ItemCsv[itemId].icon):scale(0.5):center(iconBg):addTo(iconBg)
        display.newTTFLabel({
          text = tonumber(set[2]),
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(46, -2):addTo(iconBg)
      else
        local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(xPos, yPos):addTo(cell)
        display.newTTFLabel({
          text = tonumber(set[2]),
          size = 32
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 18):addTo(icon)
      end
      xPos = xPos + interval
    end
    local cur, all, result = self:getProgress(data)
    if result == 0 then
      if image then
        image:setColor(cc.c3b(140, 140, 140))
      end
      local progressBg = display.newSprite(MainRes .. "progress_bg.png"):pos(865, 62):addTo(cell)
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
      cell:setTexture(MainRes .. "cell_achieve_2.png")
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages("ui/carbon/boss/", {
        "anniu_1.png",
        "anniu_1.png"
      })
      btn:pos(855, 62):addTo(cell):setTouchScale()
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
          display.newSprite(MainRes .. "image_done.png"):pos(855, 62):addTo(cell)
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({items = msg})
        end)
      end)
    else
      cell:setTexture(MainRes .. "cell_achieve_2.png")
      display.newSprite(MainRes .. "image_done.png"):pos(855, 62):addTo(cell)
    end
  end
  if not next(self.finalCsv) then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
    display.newTTFLabel({
      text = "此类型的成就敬请期待哦",
      size = 22,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  end
  self:checkAchieveNum()
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function MissionLayer:getProgress(data)
  local cur = game.role.missionTaskStatus:getv(data.id, 0)
  local all = data.condition1
  if cur == -1 then
    return cur, all, -1
  end
  cur = game.role.achievementTypeStatus:getv(data.type, 0)
  return cur, all, all <= cur and 1 or 0
end

function MissionLayer:checkAchieveNum()
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
  self.achieveNum:setString(string.format("成就达成 %d/%d", cur, all))
end

function MissionLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return MissionLayer
