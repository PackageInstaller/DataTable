local DailyTaskCsv = require("csvdata.loop_activity.daily_task")
local AchieveCsv = require("csvdata.loop_activity.goal_task")
local ItemCsv = require("csvdata.item")
local DailyRes = "ui/taptap/daily/"
local AchieveRes = "ui/taptap/achieve/"
local uiData = {
  csbFile = "ui/taptap/TapTapMainLayer.csb",
  widgets = {
    upBar = "upBar",
    image1 = "image1",
    mainBg = "mainBg",
    btnShop = "btnShop",
    colorBg = "colorBg",
    btnDaily = "colorBg/btnDaily",
    btnAchieve = "colorBg/btnAchieve",
    content = "colorBg/content",
    moneyBg = "moneyBg",
    money = "moneyBg/money",
    imageDown = "imageDown",
    panel1 = "imageDown/panel1",
    image2 = "imageDown/panel1/image2",
    image3 = "imageDown/panel1/image3",
    image4 = "imageDown/panel1/image4",
    panel2 = "imageDown/panel2",
    image5 = "imageDown/panel2/image5",
    image6 = "imageDown/panel2/image6"
  }
}
local btnDatas = {
  [1] = {
    name = "btnDaily",
    red = "daily",
    func = function(self)
      self:showDailyLayer()
    end
  },
  [2] = {
    name = "btnAchieve",
    red = "goal",
    func = function(self)
      self:showAchieveLayer()
    end
  }
}
local TapTapMainLayer = class("TapTapMainLayer", UIBase)

function TapTapMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TapTapMainLayer:init(params)
  TopBar:show(TopBarType.full, "像素游园季")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.image1:setPositionX(self.image1:getPositionX() - UIHelper.getMoveXForX())
    self.btnShop:setPositionX(self.btnShop:getPositionX() + UIHelper.getMoveXForX())
    self.panel1:setPositionX(self.panel1:getPositionX() - UIHelper.getMoveXForX())
    self.panel2:setPositionX(self.panel2:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.upBar
  })
  UIHelper.MoveToUp({
    node = self.imageDown,
    pos = {0, 120}
  })
  UIHelper.MoveToDown({
    node = self.image1,
    pos = {0, 90}
  })
  UIHelper.MoveToLeft({
    node = self.btnShop,
    pos = {90, 0}
  })
  for i = 2, 6 do
    local image = self["image" .. i]
    local yPos = i % 2 == 0 and 15 or -15
    image:runAction(cc.RepeatForever:create(transition.sequence({
      cc.MoveBy:create(5, cc.p(0, yPos)),
      cc.MoveBy:create(5, cc.p(0, -yPos)),
      cc.MoveBy:create(5, cc.p(0, -yPos)),
      cc.MoveBy:create(5, cc.p(0, yPos))
    })))
  end
  self.selectType = 1
  self.infoData = {}
  self.handlers = {}
  self.btns = {}
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "taptap" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.taptap[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(-65, 20))
        local new = btn:getChildByTag(9797)
        if new then
          new:setScaleX(-1)
        end
      end
    end
  end))
  local group = MRadioGroup:create()
  for index, btnData in ipairs(btnDatas) do
    local btn = self[btnData.name]
    btn:setLocalZOrder(-1)
    btn:setName("btn" .. index)
    btn:setGroup(group)
    btn:setCallback(function()
      btnData.func(self)
    end)
    if btnData.red ~= "" then
      self.btns[btnData.red] = btn
      local bShow = checkbool(game.role.redPoints.taptap[btnData.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(-65, 20))
      local new = btn:getChildByTag(9797)
      if new then
        new:setScaleX(-1)
      end
    end
  end
  group:chooseByName("btn" .. self.selectType)
  self.btnShop:setTouchScale()
  self.btnShop:setCallback(function()
    self:hide()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 6})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "像素游园季")
      self:updateMoney()
      self:show()
      layer:close()
    end)
  end)
end

function TapTapMainLayer:showData(params)
  self:updateMoney()
  btnDatas[self.selectType].func(self)
end

function TapTapMainLayer:showDailyLayer()
  self.content:removeAllChildren()
  local nowT = CommonHelper.date(game:nowTime(), nil, true)
  local endTime = CommonHelper.time({
    year = nowT.year,
    month = nowT.month,
    day = nowT.day,
    hour = 4,
    min = 0,
    sec = 0
  }) + 86400
  local label = display.newTTFLabel({
    text = "刷新时间: " .. UIHelper.getTimeStr(endTime - game:nowTime()),
    size = 24,
    color = UIHelper.hex2rgb("#11a7b5")
  }):anch(0, 0.5):pos(-450, 270):addTo(self.content)
  
  local function reflash()
    if tolua.isnull(label) then
      return
    end
    label:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        local left = endTime - game:nowTime()
        if left <= 0 then
          label:stopAllActions()
          self:showDailyLayer()
        else
          label:setString("刷新时间: " .. UIHelper.getTimeStr(left))
          reflash()
        end
      end)
    }))
  end
  
  reflash()
  local list = ccui.ListView:create()
  list:size(cc.size(928, 478))
  list:setInnerContainerSize(cc.size(928, 478))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.content)
  self:refreshList(list)
end

function TapTapMainLayer:refreshList(list)
  list:removeAllChildren()
  local set = DailyTaskCsv[self.infoData.dailyTime]
  local sortData = {}
  for _, data in ipairs(set) do
    local cur = self.infoData.dailyTask:getv(data.id, 0)
    if 0 <= cur then
      local preCur = self.infoData.dailyTask:getv(data.pre, 0)
      if data.pre == 0 or data.pre ~= 0 and preCur < 0 then
        table.insert(sortData, data)
      end
    elseif data.after == 0 then
      table.insert(sortData, data)
    end
  end
  table.sort(sortData, function(a, b)
    return a.order < b.order
  end)
  local cellSize = {928, 94}
  local viewNode
  for i, data in ipairs(sortData) do
    if i % 2 == 1 then
      viewNode = ccui.Widget:create()
      viewNode:size(cellSize[1], cellSize[2]):addTo(list)
    end
    local xPos = i % 2 == 0 and 467 or 11
    local cell = display.newSprite(DailyRes .. "cell.png"):anch(0, 0):pos(xPos, 2):addTo(viewNode)
    display.newTTFLabel({
      text = data.desc,
      size = 20,
      color = UIHelper.hex2rgb("#11a7b5")
    }):anch(0, 0.5):pos(18, 48):addTo(cell)
    local gift = data.gift:toArray("=", true)
    display.newSprite("ui/taptap/main/money_icon.png"):pos(272, 46):addTo(cell)
    display.newTTFLabel({
      text = "x" .. gift[2],
      size = 24,
      color = UIHelper.hex2rgb("#11a7b5")
    }):anch(0, 0.5):pos(290, 48):addTo(cell)
    local cur = self.infoData.dailyTask:getv(data.id, 0)
    if cur < 0 then
      display.newSprite(DailyRes .. "image_done.png"):pos(395, 48):addTo(cell)
    elseif cur < data.condition1 then
      display.newTTFLabel({
        text = string.format("%d/%d", cur, data.condition1),
        size = 24,
        color = UIHelper.hex2rgb("#11a7b5")
      }):pos(395, 48):addTo(cell)
    else
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(DailyRes, {
        "btn_get.png",
        "btn_get.png"
      })
      btn:pos(395, 48):addTo(cell):setTouchScale()
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_taptapRewardRpc, MsgPack.pack({
          id = data.id,
          type = 1
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_taptapRewardRpc, function(event)
          UIHelper.removeWaiting()
          self:updateMoney()
          self:refreshList(list)
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end)
    end
  end
end

function TapTapMainLayer:showAchieveLayer()
  self.content:removeAllChildren()
  local achieveBg = display.newSprite(AchieveRes .. "achieve_bg.png"):pos(-3, 3):addTo(self.content)
  self:initPanel(achieveBg, false)
end

function TapTapMainLayer:initPanel(parent, animat)
  if not animat then
    self:reflashPanel(parent)
    return
  end
  self.content:runAction(transition.sequence({
    cc.CallFunc:create(function()
      local flash = display.newSprite(AchieveRes .. "flash.png"):pos(0, 0):addTo(self.content)
      flash:setOpacity(0)
      flash:runAction(transition.sequence({
        cc.FadeIn:create(0.1),
        cc.DelayTime:create(0.2),
        cc.FadeOut:create(0.1),
        cc.RemoveSelf:create()
      }))
    end),
    cc.DelayTime:create(0.2),
    cc.CallFunc:create(function()
      self:reflashPanel(parent)
    end)
  }))
end

function TapTapMainLayer:reflashPanel(parent)
  parent:removeAllChildren()
  display.newSprite(AchieveRes .. "image_desc.png"):pos(450, 342):addTo(parent)
  local set = {}
  for _, data in pairs(AchieveCsv[self.infoData.goalTime]) do
    table.insert(set, data)
  end
  table.sort(set, function(a, b)
    return a.id < b.id
  end)
  local curCost = self.infoData.goalTask:getv(0, 0)
  local allCost = set[#set].conditon
  local progress = curCost / allCost
  local getNum = 0
  local barBg = display.newSprite(AchieveRes .. "bar_bg.png"):pos(447, 210):addTo(parent)
  local bar = display.newProgressTimer(AchieveRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(progress * 100)
  local longth = barBg:getContentSize().width
  display.newTTFLabel({
    text = string.format("%d/%d", curCost, set[#set].conditon),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#790c0c"), 1):pos(414, 15):addTo(barBg)
  for i, data in ipairs(set) do
    local xPos = longth * data.conditon / allCost
    local bReward = curCost >= data.conditon
    display.newSprite(AchieveRes .. (bReward and "arrow_1.png" or "arrow_2.png")):pos(xPos, -15):addTo(barBg)
    display.newTTFLabel({
      text = data.conditon,
      size = 24,
      color = UIHelper.hex2rgb("#11a7b5")
    }):pos(xPos - 15, -35):addTo(barBg)
    if bReward then
      local state = self.infoData.goalTask:getv(data.id, 0)
      if state == -1 then
        getNum = getNum + 1
        display.newSprite(AchieveRes .. "image_tip_1.png"):pos(xPos - 32, 99):addTo(barBg)
      else
        local btn = UIHelper.newImageView(AchieveRes .. "btn_get.png"):pos(xPos - 32, 70):addTo(barBg)
        local tip = display.newSprite(AchieveRes .. "image_tip_2.png"):pos(xPos - 32, 99):addTo(barBg)
        btn:setCallback(function()
          game:sendData(actionCodes.Activity_taptapRewardRpc, MsgPack.pack({
            id = data.id,
            type = 2
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_taptapRewardRpc, function(event)
            UIHelper.removeWaiting()
            getNum = getNum + 1
            self:updateMoney()
            tip:setTexture(AchieveRes .. "image_tip_1.png")
            btn:removeFromParent()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward,
              callback = function()
                if getNum == #set then
                  self:initPanel(parent, true)
                end
              end
            })
          end)
        end)
      end
    end
    local gift = data.gift:toArray("=", true)
    display.newSprite("ui/taptap/main/money_icon.png"):anch(1, 0.5):pos(xPos - 35, 70):addTo(barBg)
    display.newTTFLabel({
      text = "x" .. gift[2],
      size = 24,
      color = UIHelper.hex2rgb("#11a7b5")
    }):anch(0, 0.5):pos(xPos - 35, 70):addTo(barBg)
  end
  local descBg = display.newSprite(AchieveRes .. "desc_bg.png"):pos(450, 55):addTo(parent)
  display.newSprite(AchieveRes .. "image_tag.png"):pos(31, 48):addTo(descBg)
  display.newSprite(AchieveRes .. "image_tag.png"):pos(31, 17):addTo(descBg)
  local string1 = string.format("已达成阶段%d，共%d阶段", self.infoData.goalTime - 1, #AchieveCsv)
  if getNum == #set then
    string1 = string.format("已达成阶段%d，共%d阶段", self.infoData.goalTime, #AchieveCsv)
  elseif self.infoData.goalTime == 1 then
    string1 = string.format("目前尚未达成任何阶段，共%d阶段", #AchieveCsv)
  end
  display.newTTFLabel({
    text = string1,
    size = 20,
    color = UIHelper.hex2rgb("#11a7b5")
  }):anch(0, 0.5):pos(45, 48):addTo(descBg)
  display.newTTFLabel({
    text = self.infoData.goalTime == #AchieveCsv and "已开放所有阶段" or "完成当前阶段所有任务，即可开启下一阶段。",
    size = 20,
    color = UIHelper.hex2rgb("#11a7b5")
  }):anch(0, 0.5):pos(45, 17):addTo(descBg)
end

function TapTapMainLayer:updateMoney()
  self.infoData = game.role.activityStatus["36"]
  self.money:setString(game.role.items[globalCsv.Activity36ItemId] or 0)
end

function TapTapMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return TapTapMainLayer
