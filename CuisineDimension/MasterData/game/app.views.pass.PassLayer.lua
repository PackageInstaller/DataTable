local taskCsv = require("csvdata.battlepass_task")
local levelCsv = require("csvdata.battlepass_level")
local rewardCsv = require("csvdata.battlepass_reward")
local passRes = "ui/pass/pass1/"
local PassLayer = {}
local text1 = "赠送主城皮肤兑换券，可在商城中兑换任意主城皮肤"
local text2 = "赠送主城皮肤兑换券、精选酱料盒，通行证等级直升50级"
local text3 = "两种凭证只可购买一种，购买任意凭证赠送主城皮肤兑换券"
PassLayer.mainLayer = nil

function PassLayer:initView(mainLayer)
  PassLayer.mainLayer = mainLayer
  self.mainNode = PassLayer.mainLayer.passNode
  self:init()
end

function PassLayer:init()
  PassLayer.mainLayer.bg:setImage(passRes .. "bg.png")
  self.curStatus = game.role.activityStatus["63"] or {
    level = 0,
    exp = 0,
    status = "",
    reward = ""
  }
  self:initLeft()
  self:initRight()
end

function PassLayer:initLeft()
  self:initHero()
  local timeStr = CommonHelper.calculateActRemain()
  self.timerHandler = scheduler.scheduleGlobal(function()
    timeStr = CommonHelper.calculateActRemain()
    if self.timeLabel then
      self.timeLabel:setString("本期剩余时间：" .. timeStr)
    end
  end, 1)
  local dateBg = UIHelper.newImageView(passRes .. "bg_date.png"):anch(0, 0):pos(200, 40):addTo(self.mainNode)
  self.timeLabel = display.newTTFLabel({
    text = "本期剩余时间：" .. timeStr,
    size = 18,
    align = ui.TEXT_ALIGNMENT_CENTER
  }):center(dateBg):addTo(dateBg)
end

function PassLayer:initRight()
  local upBg = display.newSprite(passRes .. "hd_1.png"):pos(800, 540):addTo(self.mainNode)
  local rank = display.newTTFLabel({
    text = "Rank:",
    size = 47,
    color = UIHelper.hex2rgb("#FFFFFF")
  }):enableOutline(UIHelper.hex2rgb("#4A1406"), 2):anch(0, 0.5):pos(19, 67):addTo(upBg)
  local level = display.newTTFLabel({
    text = self.curStatus.level,
    size = 47,
    color = UIHelper.hex2rgb("#f3dboc")
  }):enableOutline(UIHelper.hex2rgb("#4A1406"), 2):anch(0, 0.5):pos(128, 67):addTo(upBg)
  local barBg = display.newSprite(passRes .. "bar_bg.png"):pos(142, 30):addTo(upBg)
  local bar = display.newProgressTimer(passRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(self.curStatus.exp / levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp * 100)
  local lab = display.newTTFLabel({
    text = string.format("%d/%d", self.curStatus.exp, levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp)
  }):enableOutline(UIHelper.hex2rgb("#4A1406"), 1):pos(125, 14):addTo(bar)
  local addBtn = UIHelper.newImageView(passRes .. "btn_2.png"):anch(0, 0.5):pos(273, 44):addTo(upBg)
  addBtn:setCallback(function()
    if self.curStatus.level >= #levelCsv then
      return
    end
    local data = {
      title = "资格证等级",
      cost = globalCsv.LevelCost,
      desc = "提升1级需要消耗50钻"
    }
    game:createView("shop.CommonItemCountLayer", {
      data = data,
      showType = "level",
      left = #levelCsv - self.curStatus.level,
      callback = function(num)
        if game.role.diamond < num * globalCsv.LevelCost then
          UIHelper.showDiamondTip()
          return
        end
        game:sendData(actionCodes.Activity_passTaskRpc, MsgPack.pack({index = 5, count = num}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_passTaskRpc, function(event)
          UIHelper.removeWaiting()
          self.curStatus = game.role.activityStatus["63"]
          level:setString(self.curStatus.level)
          bar:setPercentage(self.curStatus.exp / levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp * 100)
          lab:setString(string.format("%d/%d", self.curStatus.exp, levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp))
          self:initList()
        end)
      end
    })
  end)
  local tipBtn = UIHelper.newImageView(passRes .. "btn_3.png"):anch(0, 0.5):pos(328, 44):addTo(upBg)
  tipBtn:setCallback(function()
    local mask, bg = UIHelper.showOnleImgTip(passRes .. "bg_1.png")
    display.newTTFLabel({text = "通行证", size = 30}):enableOutline(UIHelper.hex2rgb("#4a1506"), 2):pos(345, 325):addTo(bg)
    local list = ccui.ListView:create()
    list:size(cc.size(676, 298))
    list:setInnerContainerSize(cc.size(676, 298))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(10, 10):addTo(bg)
    local rows = math.ceil(#taskCsv / 2)
    for row = 1, rows do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(676, 108)):addTo(list)
      for col = 1, 2 do
        local xPos = (col - 1) * 334
        local data = taskCsv[(row - 1) * 2 + col]
        if not data then
          break
        end
        local cell = display.newSprite(passRes .. "cell.png"):anch(0, 0.5):pos(xPos, 50):addTo(viewNode)
        display.newTTFLabel({
          text = data.desc,
          size = 22
        }):enableOutline(UIHelper.hex2rgb("#734211"), 2):anch(0, 0.5):pos(18, 75):addTo(cell)
        display.newTTFLabel({
          text = string.format("获得赛季经验值x%s", data.gift),
          size = 18,
          color = UIHelper.hex2rgb("#8e450f")
        }):pos(168, 33):addTo(cell)
      end
    end
    list:requestDoLayout()
  end)
  local receiveBtn = UIHelper.newImageView(passRes .. "btn_1.png"):anch(0, 0.5):pos(382, 44):addTo(upBg)
  display.newTTFLabel({
    text = "一键领取",
    size = 24,
    color = UIHelper.hex2rgb("#FFFFFF")
  }):enableOutline(UIHelper.hex2rgb("#8A450E"), 1):anch(0, 0.5):pos(13, 31):addTo(receiveBtn)
  receiveBtn:setCallback(function()
    local canSend = false
    for _, data in pairs(rewardCsv) do
      if data.level <= self.curStatus.level and data.reward ~= "" and self.curStatus.reward:getv(data.id, 0) ~= -1 and (data.need == 0 or self.curStatus.reward:getv(0, 0) == -1) then
        canSend = true
        break
      end
    end
    if not canSend then
      SysError(SYS_ERR_PASS_NOTCANGET)
      return
    end
    game:sendData(actionCodes.Activity_passTaskRpc, MsgPack.pack({index = 4}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_passTaskRpc, function(event)
      UIHelper.removeWaiting()
      self.curStatus = game.role.activityStatus["63"]
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self:initList()
    end)
  end)
  self.panelBg = display.newSprite(passRes .. "hd_2.png"):pos(800, 313):addTo(self.mainNode)
  display.newTTFLabel({
    text = "赛季奖励预览",
    size = 24,
    color = UIHelper.hex2rgb("#FFFFFF")
  }):enableOutline(UIHelper.hex2rgb("#7f3710"), 2):pos(262, 312):addTo(self.panelBg)
  self.list = ccui.ListView:create()
  self.list:size(cc.size(517, 280))
  self.list:setInnerContainerSize(cc.size(500, 280))
  self.list:setClippingEnabled(true)
  self.list:setBounceEnabled(true)
  self.list:anch(0.5, 0.5):pos(253, 151):addTo(self.panelBg)
  self:initList()
  local chefData = {
    [1] = {
      name = "高级凭证",
      text = text1,
      func = "",
      logoPath = "senior.png"
    },
    [2] = {
      name = "豪华凭证",
      text = text2,
      func = "",
      logoPath = "luxurious.png"
    }
  }
  local posX = 539
  for k, v in ipairs(chefData) do
    local btnBg = UIHelper.newImageView(passRes .. "hd_4.png"):anch(0, 0.5):pos(posX, 90):addTo(self.mainNode)
    display.newTTFLabel({
      text = v.name,
      size = 23,
      color = UIHelper.hex2rgb("#ffcf2a")
    }):anch(0, 0.5):pos(18, 79):addTo(btnBg)
    local labelText = MRichText.new({
      text = v.text,
      color = UIHelper.hex2rgb("#fdfce7"),
      size = 16,
      maxWidth = 155,
      lineSpace = 1
    })
    labelText:anch(0, 0.5):pos(18, 33):addTo(btnBg)
    local chefBtn = UIHelper.newImageView(passRes .. v.logoPath):pos(216, 70):addTo(btnBg)
    UIHelper.newImageView(passRes .. "btn_buy.png"):anch(0, 0.5):pos(171, 28):addTo(btnBg)
    btnBg:setCallback(function()
      if self.curStatus.reward:getv(0, 0) == -1 then
        SysError(SYS_ERR_PASS_ONLYONE)
        return
      end
      game:createView("shop.ShopChefPassLayer", {
        index = k,
        func = function()
          self.curStatus = game.role.activityStatus["63"]
          level:setString(self.curStatus.level)
          bar:setPercentage(self.curStatus.exp / levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp * 100)
          lab:setString(string.format("%d/%d", self.curStatus.exp, levelCsv[math.min(self.curStatus.level + 1, #levelCsv)].exp))
          self:initList()
        end
      })
    end)
    posX = posX + 264
  end
  local downLabelBg = display.newSprite(passRes .. "hd_5.png"):pos(800, 21):addTo(self.mainNode)
  display.newTTFLabel({
    text = text3,
    size = 17,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(40, 19):addTo(downLabelBg)
end

function PassLayer:initList()
  self.list:removeAllChildren()
  local sortData = {}
  for _, data in ipairs(rewardCsv) do
    if not sortData[data.level] then
      sortData[data.level] = {}
    end
    table.insert(sortData[data.level], #sortData[data.level] + 1, data)
  end
  local index, rewardStatus = 0, self.curStatus.reward or ""
  for idx, set in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(500, 95)):addTo(self.list)
    local cell = UIHelper.newImageView(passRes .. "hd_3.png"):pos(268, 46):addTo(viewNode)
    display.newTTFLabel({
      text = "赛季 RANK" .. idx,
      size = 32,
      color = UIHelper.hex2rgb("#FFFFFF")
    }):enableOutline(UIHelper.hex2rgb("#4A1406"), 2):anch(0, 0.5):pos(12, 65):addTo(cell)
    local xPos = 340
    for _, data in ipairs(set) do
      if data.reward ~= "" then
        local gift = data.reward:toArray("=", true)
        local icon = ItemIcon.new({
          type = gift[1],
          count = gift[2],
          showTip = true
        }):scale(0.8):pos(xPos, 48):addTo(cell)
        local status = rewardStatus:getv(data.id, 0)
        if status ~= -1 and self.curStatus.level >= data.level and (data.need == 0 or rewardStatus:getv(0, 0) == -1) then
          if index == 0 then
            index = idx
          end
          icon:setCallback(function()
            if status == -1 then
              return
            end
            game:sendData(actionCodes.Activity_passTaskRpc, MsgPack.pack({
              index = 3,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_passTaskRpc, function(event)
              UIHelper.removeWaiting()
              status = -1
              display.newSprite("ui/activity/level/had.png"):center(icon):addTo(icon)
              self.curStatus = game.role.activityStatus["63"]
              local msg = MsgPack.unpack(event.data)
              MedalRewardLayer.new({
                items = msg.reward
              })
            end)
          end)
        end
        if status == -1 then
          display.newSprite("ui/activity/level/had.png"):center(icon):addTo(icon)
        end
        if data.level > self.curStatus.level or data.need ~= 0 and rewardStatus:getv(0, 0) == 0 then
          display.newSprite("ui/global/lock.png"):center(icon):addTo(icon)
        end
      end
      xPos = xPos + 100
    end
  end
  self.list:doLayout()
  if 0 < index then
    self.list:runAction(transition.sequence({
      cc.DelayTime:create(0.1),
      cc.CallFunc:create(function()
        self.list:scrollToItem(index - 1, cc.p(0, 0.5), cc.p(0, 0))
      end)
    }))
  else
    self.list:requestDoLayout()
  end
end

function PassLayer:initHero()
  local texts = {
    [1] = textByKey("pass_Hero_1"),
    [2] = textByKey("pass_Hero_2"),
    [3] = textByKey("pass_Hero_3")
  }
  local heroGet = globalCsv.pass_hero_select or 420
  self.card = UIHelper.newImageView(UIHelper.getCardRes("normal", heroGet, false)):pos(321, 173):scale(1):addTo(self.mainNode)
end

function PassLayer:closeTimerHandler()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return PassLayer
