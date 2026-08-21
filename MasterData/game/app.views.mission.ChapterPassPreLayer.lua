local Activity_80_taskCsv = require("csvdata.activity_80_task")
local LastTarget = Activity_80_taskCsv[7].condition
local ChapterPassPreLayer = {}
local activityType = "80"
local ResPath = "ui/activity/80/"
local CardCellDatas = {}
local startPos = {}
startPos.X = -395
for i = 1, 7 do
  CardCellDatas[i] = {
    id = i,
    x = startPos.X + i * 110,
    y = -120,
    target = Activity_80_taskCsv[i].condition
  }
end

function ChapterPassPreLayer:init(content, msg)
  self.dataMsg = msg
  self.dataMsg.score = self.dataMsg.score and tonumber(self.dataMsg.score) or 0
  self.actStatus = game.role.activityStatus[activityType] or {}
  self.finishAllBg = display.newSprite(ResPath .. "main_bg_2.png"):anch(0, 0):pos(-455, -254):addTo(content)
  local box = display.newSprite(ResPath .. "box.png"):anch(0, 0):pos(300, 188):addTo(self.finishAllBg)
  local progressBarBg = display.newSprite(ResPath .. "bar_bg.png"):pos(5, -220):addTo(content)
  local barContent = display.newSprite(ResPath .. "bar_content.png")
  self.progressBar = cc.ProgressTimer:create(barContent):pos(5, -220):addTo(content)
  self.progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  self.progressBar:setMidpoint(cc.p(0, 0))
  self.progressBar:setBarChangeRate(cc.p(1, 0))
  self.progressBarLabel = display.newTTFLabel({text = "", size = 18}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(0, -218):addTo(content)
  local progressContent = "活动期间累计通关“中华大陆”及以上关卡次数达到 "
  for i = 1, 6 do
    local condi = Activity_80_taskCsv[i].condition
    progressContent = progressContent .. condi .. "/"
  end
  progressContent = progressContent .. LastTarget
  display.newTTFLabel({
    text = progressContent,
    size = 20,
    color = UIHelper.hex2rgb("#630c07")
  }):pos(0, -250):enableOutline(UIHelper.hex2rgb("#fff4e6"), 1):addTo(content)
  self.timeLabel = display.newTTFLabel({
    text = "",
    size = 22,
    color = UIHelper.hex2rgb("#fff4e6")
  }):anch(0, 0.5):enableOutline(UIHelper.hex2rgb("#3c220c"), 3):pos(-445, 240):addTo(content)
  self.countLabel = display.newTTFLabel({
    text = string.format("个人每日贡献：%s", self.actStatus.dailyCount or 0),
    size = 22,
    color = UIHelper.hex2rgb("#fff4e6")
  }):anch(0, 0.5):enableOutline(UIHelper.hex2rgb("#3c220c"), 3):pos(-445, 210):addTo(content)
  self.countALLabel = display.newTTFLabel({
    text = string.format("个人总计贡献：%s", self.dataMsg.score or 0),
    size = 22,
    color = UIHelper.hex2rgb("#fff4e6")
  }):anch(0, 0.5):enableOutline(UIHelper.hex2rgb("#3c220c"), 3):pos(-445, 180):addTo(content)
  self.diamondAll = MRichText.new({
    text = string.format("<div outline=2,#3c220c>奖池累计：</div><div outline=2,#3c220c size=28>%s</div>", self.dataMsg.total or 0),
    color = UIHelper.hex2rgb("#ffff66"),
    size = 24
  }):anch(0, 0.5):pos(-445, 140):addTo(content)
  self.rewardBox = UIHelper.extend(ccui.Button:create()):addTo(content):pos(0, 40)
  self.rewardBox:setImages(ResPath, {
    "main_get.png",
    "main_get.png"
  })
  self.rewardBox:setCallback(function()
    self:clickBox()
  end)
  self.rewardBox:hide()
  if self:isComplete() then
    self.rewardBox:show()
  end
  if self:isGetedFinalBox() then
    self.rewardBox:setImages(ResPath, {
      "main_got.png",
      "main_got.png"
    })
    self.rewardBox:show()
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(ResPath, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_80"
    })
  end)
  btnInfo:pos(400, 230):addTo(content)
  self.cardCells = {}
  for i = 1, #CardCellDatas do
    self:createCell(content, CardCellDatas[i])
  end
  self:updateAll()
  self:updateTime()
end

function ChapterPassPreLayer:createCell(frame, data)
  local cardCell = UIHelper.extend(ccui.ImageView:create())
  cardCell:setImage(ResPath .. "tag_bg.png")
  cardCell:anch(0.5, 0.5)
  cardCell:pos(data.x, data.y):addTo(frame)
  cardCell:setCallback(function()
    self:clickCell(data.id)
  end)
  local giftImage = UIHelper.newImageView(string.format("ui/carbon/chooseTravel/box_%d.png", math.min(7, data.id))):pos(55, 100):addTo(cardCell)
  cardCell.tag_incomplete = UIHelper.extend(ccui.ImageView:create()):pos(55, 82):addTo(cardCell):hide()
  cardCell.tag_incomplete:setImage(ResPath .. "tag_incomplete.png")
  cardCell.tag_received = UIHelper.extend(ccui.ImageView:create()):pos(55, 82):addTo(cardCell):hide()
  cardCell.tag_received:setImage(ResPath .. "tag_received.png")
  cardCell.tag_complete = UIHelper.extend(ccui.ImageView:create()):pos(55, 82):addTo(cardCell):hide()
  cardCell.tag_complete:setImage(ResPath .. "tag_complete.png")
  self.cardCells[data.id] = cardCell
  return cardCell
end

function ChapterPassPreLayer:updateAll()
  local activity = game.role.activityStatus[activityType] or {}
  self.scoreCount = self.dataMsg.score or 0
  self.getedRewardStr = activity.getedReward or ""
  
  local function getPercent(count)
    local percent = 0
    if count >= Activity_80_taskCsv[7].condition then
      return 100
    end
    if count < Activity_80_taskCsv[1].condition then
      percent = count * 100 / (Activity_80_taskCsv[1].condition * 7)
      return percent
    end
    for i = 1, 6 do
      if count >= Activity_80_taskCsv[i].condition and count < Activity_80_taskCsv[i + 1].condition then
        percent = percent + i * 100 / 7
        percent = percent + (count - Activity_80_taskCsv[i].condition) * 100 / ((Activity_80_taskCsv[i + 1].condition - Activity_80_taskCsv[i].condition) * 7)
        return percent
      end
    end
  end
  
  self.progressBar:setPercentage(getPercent(self.scoreCount))
  self.progressBarLabel:setString(string.format("%d/%d", self.scoreCount, LastTarget))
  for i = 1, 7 do
    self:updateCell(i)
  end
  local isTimeUp = game:nowTime() >= globalCsv.Activity80GiftTime
  if not isTimeUp then
    return
  end
end

function ChapterPassPreLayer:updateCell(cellIndex)
  local cell = self.cardCells[cellIndex]
  local data = CardCellDatas[cellIndex]
  cell.tag_incomplete:hide()
  cell.tag_received:hide()
  cell.tag_complete:hide()
  local passed = self.scoreCount >= data.target
  if passed then
    local geted = 0 < self.getedRewardStr:getv(data.id, 0)
    if geted then
      cell.tag_received:show()
    else
      cell.tag_complete:show()
    end
  else
    cell.tag_incomplete:show()
  end
  return self.dataMsg.score or 0
end

function ChapterPassPreLayer:clickCell(index)
  local activity = game.role.activityStatus[activityType] or {}
  activity.getedReward = activity.getedReward or ""
  if 0 < activity.getedReward:getv(index, 0) then
    return
  end
  self.scoreCount = self.dataMsg.score or 0
  local data = CardCellDatas[index]
  if self.scoreCount < data.target then
    local gift = Activity_80_taskCsv[data.id].gift
    ItemRewardLayer.new({
      items = gift:toTableArray(),
      preView = true,
      ignore = true
    })
  else
    game:sendData(actionCodes.Activity_chapterPassPreGetRewardRpc, MsgPack.pack({taskId = index}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_chapterPassPreGetRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      self:updateAll()
    end)
  end
end

function ChapterPassPreLayer:clickBox()
  if game:nowTime() < globalCsv.Activity80GiftTime then
    SysError(SYS_ERR_ACTIVITY80_TIME_NOT)
    return
  end
  if not self:isComplete() then
    SysError(SYS_ERR_ACTIVITY80_NOT_FINISH)
    return
  end
  if self:isGetedFinalBox() then
    return
  end
  game:sendData(actionCodes.Activity_chapterPassPreGetFinalBoxRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_chapterPassPreGetFinalBoxRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    self:updateAll()
    self.rewardBox:setImages(ResPath, {
      "main_got.png",
      "main_got.png"
    })
  end)
end

function ChapterPassPreLayer:isComplete()
  local isTimeUp = game:nowTime() >= globalCsv.Activity80GiftTime
  if not isTimeUp then
    return false
  end
  return tonumber(self.dataMsg.score) >= 600
end

function ChapterPassPreLayer:isGetedFinalBox()
  local activity = game.role.activityStatus[activityType] or {}
  self.finalBox = activity.finalBox or ""
  return self.finalBox == "1"
end

function ChapterPassPreLayer:updateTime()
  local time = globalCsv.Activity80GiftTime - game:nowTime()
  if time < 0 then
    self.timeLabel:setString("")
    return
  end
  local date = CommonHelper.crossTimeForDHMS(time)
  if date.day == 0 and 0 < date.hour then
    self.timeLabel:setString(string.format("挑战剩余时间：%d小时%d分", date.hour, date.minute))
    return
  end
  if date.day == 0 and date.hour == 0 then
    self.timeLabel:setString(string.format("挑战剩余时间：%d分%d秒", date.minute, date.second))
    return
  end
  self.timeLabel:setString(string.format("挑战剩余时间：%d天%d小时", date.day, date.hour))
end

return ChapterPassPreLayer
