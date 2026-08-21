local Activity95Manager = require("app.views.activity.Activity95Manager")
local CarbonManager = require("app.models.CarbonManager")
local Activity95Layer = {}
local ResPath = "ui/activity/95/"
local ItemCsv = require("csvdata.item")
local activity95InfoCsv = require("csvdata.activity_95_info")
local btnNames = {
  [1] = "第一章",
  [2] = "第二章",
  [3] = "第三章",
  [4] = "第四章",
  [5] = "第五章",
  [6] = "第六章",
  [7] = "第七章",
  [8] = "第八章",
  [9] = "第九章"
}
local Groups = {}
Groups[1] = {
  name = "华夏功名箓·上",
  id = 1,
  x = -345,
  y = -162
}
Groups[2] = {
  name = "华夏功名箓·下",
  id = 2,
  x = -166,
  y = -162
}
Groups[3] = {
  name = "华夏荣华箓·上",
  id = 3,
  x = -345,
  y = -218,
  needBuy = true
}
Groups[4] = {
  name = "华夏荣华箓·下",
  id = 4,
  x = -166,
  y = -218,
  needBuy = true
}
local CardWidth = 142
local CardHeight = 142
local Padding = 17
local CardCellDatas = {}
for i = 1, 9 do
  local y = math.modf((i - 1) / 3)
  local x = (i - 1) % 3
  y = y * (CardHeight + Padding)
  x = x * (CardWidth + Padding)
  CardCellDatas[i] = {
    id = i,
    x = x + 36,
    y = y - 166
  }
end
local Colors = {}
Colors.Normal = UIHelper.hex2rgb("#fff6ce")
Colors.Yellow = UIHelper.hex2rgb("#ffcb40")
Colors.Red = UIHelper.hex2rgb("#ff4040")
Colors.Green = UIHelper.hex2rgb("#8cff40")

function Activity95Layer:init(content)
  self.mapId = 1
  local mainBg = display.newSprite(ResPath .. "main_bg.png"):anch(0, 0):pos(-455, -266):addTo(content)
  self.mainBg = mainBg
  self.bigHero = HeroBigCard.new({
    type = globalCsv.Activity95HeroIds[self.mapId],
    showPic = true
  }):scale(0.75):pos(220, 240):addTo(mainBg)
  local progressBarBg = display.newSprite(ResPath .. "progress_bg.png"):pos(195, -250):addTo(content)
  local barContent = display.newSprite(ResPath .. "progress.png")
  self.progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(26, -265):addTo(content)
  self.progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  self.progressBar:setMidpoint(cc.p(0, 0))
  self.progressBar:setBarChangeRate(cc.p(1, 0))
  self.progressBarLabel = display.newTTFLabel({text = "", size = 18}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(195, -248):addTo(content)
  self.btnSelected = display.newSprite(ResPath .. "btn_selected.png"):pos(0, 0):addTo(content)
  self.cardCells = {}
  for i = 1, #CardCellDatas do
    self:createCard(content, CardCellDatas[i])
  end
  self.ChapterBtns = {}
  self:showChapterBtns(content)
  local btn_info = UIHelper.extend(ccui.Button:create())
  btn_info:setImages(ResPath, {
    "btn_info.png",
    "btn_info.png"
  })
  btn_info:pos(-90, 215):addTo(content)
  btn_info:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_95"
    })
  end)
  self:showMapId(content)
  self:createQuestion(content)
end

function Activity95Layer:showChapterBtns(content)
  if next(self.ChapterBtns) then
    for _, _btn in pairs(self.ChapterBtns) do
      _btn:removeSelf()
    end
  end
  self.ChapterBtns = {}
  for i = 1, #Groups do
    local btn = self:createChapterBtn(content, Groups[i])
    table.insert(self.ChapterBtns, btn)
  end
  self:select(1)
end

function Activity95Layer:showMapId(content)
  local btnSize = UIHelper.newImageView(ResPath .. "btn_1.png"):getContentSize()
  local list = ccui.ListView:create()
  list:size(cc.size(104, 200))
  list:setInnerContainerSize(cc.size(104, 200))
  list:setClippingEnabled(true)
  list:anch(0, 0):pos(-450, 40):addTo(content)
  local group = MRadioGroup:create()
  for index, _value in ipairs(globalCsv.Activity95MapIds) do
    local open = _value == 1
    local infoData = activity95InfoCsv[index][1]
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(btnSize.width, btnSize.height + 2)):addTo(list)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ResPath, {
      open and "btn_1.png" or "btn_3.png",
      open and "btn_2.png" or "btn_3.png"
    })
    btn:center(viewNode):addTo(viewNode)
    btn:setString({
      text = btnNames[index],
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:setCallback(function()
      if not open then
        group:chooseByName("btn" .. self.mapId)
        MFlashMsg:show({
          text = "该章节暂未开启，敬请期待~"
        })
        return
      end
      self.mapId = index
      self:showChapterBtns(content)
      if self.bigHero then
        self.bigHero:removeSelf()
        self.bigHero = HeroBigCard.new({
          type = globalCsv.Activity95HeroIds[self.mapId],
          showPic = true
        }):scale(0.75):pos(220, 240):addTo(self.mainBg)
      end
    end)
    btn:setName(string.format("btn%d", index))
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    btn:setGroup(group)
  end
  group:chooseByName("btn1")
end

function Activity95Layer:createQuestion(content)
  local questionBg = UIHelper.extend(ccui.Layout:create()):anch(0.5, 0.5):pos(0, 0):scale(0):addTo(content)
  questionBg:setLocalZOrder(5)
  questionBg:size(display.width, display.height)
  questionBg:setBackGroundColorType(1)
  questionBg:setBackGroundColor(cc.c3b(1, 1, 1))
  questionBg:setBackGroundColorOpacity(200)
  questionBg:setTouchEnabled(true)
  questionBg:setSwallowTouches(true)
  self.questionBg = questionBg
  self.frame = display.newSprite(ResPath .. "test_bg.png"):anch(0.5, 0.5):pos(display.width * 0.5, display.height * 0.5):addTo(questionBg)
  self.questionCloseBtn = UIHelper.extend(ccui.Button:create())
  self.questionCloseBtn:setImages(ResPath, {
    "test_btn_exit.png",
    "test_btn_exit.png"
  })
  self.questionCloseBtn:pos(620, 350):addTo(self.frame)
  self.questionCloseBtn:setCallback(function()
    self.questionBg:scale(0)
    self.isFinishAnswer = false
    self.selectAnswer = nil
  end)
  self.titleLabel = display.newTTFLabel({
    size = 23,
    color = Colors.Normal
  }):pos(50, 280):anch(0, 0.5):addTo(self.frame)
  self.titleAnswerBtns = {}
  local answerBtnDatas = {}
  answerBtnDatas[1] = {x = 50, y = 100}
  answerBtnDatas[2] = {x = 350, y = 100}
  answerBtnDatas[3] = {x = 50, y = 30}
  answerBtnDatas[4] = {x = 350, y = 30}
  for k, v in pairs(answerBtnDatas) do
    local btn = UIHelper.extend(ccui.Layout:create()):pos(v.x, v.y):addTo(self.frame)
    btn:size(280, 66)
    btn:setBackGroundColorType(1)
    btn:setBackGroundColor(cc.c3b(0, 0, 0))
    btn:setBackGroundColorOpacity(0)
    btn:setTouchEnabled(true)
    btn:setSwallowTouches(true)
    btn:setCallback(function()
      self:trySelectAnswer(k)
    end)
    local lable = display.newTTFLabel({text = "", size = 30}):pos(0, 33):anch(0, 0.5):addTo(btn)
    self.titleAnswerBtns[k] = lable
  end
  self.isFinishAnswer = false
end

function Activity95Layer:createChapterBtn(frame, data)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(ResPath, {
    string.format("btn_draw_%d.png", data.id),
    string.format("btn_draw_%d.png", data.id)
  })
  btn:pos(data.x, data.y):addTo(frame)
  btn:setCallback(function()
    self:select(data.id)
  end)
  btn.dataId = data.id
  local infoData = activity95InfoCsv[self.mapId][data.id]
  local label = display.newTTFLabel({
    text = infoData.title,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#541c06"), 1):name("LabelText"):center(btn):addTo(btn)
  return btn
end

function Activity95Layer:select(groupId)
  local group = Groups[groupId]
  self.selectedGroupId = groupId
  self.btnSelected:pos(group.x, group.y)
  self:updateAllCard()
end

function Activity95Layer:createCard(frame, data)
  local cardCell = UIHelper.extend(ccui.ImageView:create())
  cardCell:setImage(ResPath .. "card_open.png")
  cardCell:anch(0.5, 0.5)
  cardCell:pos(data.x, data.y):addTo(frame)
  cardCell:setCallback(function()
    self:tryGetAward(data.id)
  end)
  cardCell.itemIcon = UIHelper.extend(ccui.ImageView:create()):anch(0.5, 0.5):pos(70, 70):scale(0):addTo(cardCell)
  cardCell.itemIcon:setImage(ResPath .. "card_close.png")
  cardCell.statuImage = UIHelper.extend(ccui.ImageView:create()):anch(0.5, 0.5):pos(70, 70):addTo(cardCell)
  cardCell.statuImage:setImage(ResPath .. "card_statu_lock.png")
  self.cardCells[data.id] = cardCell
  return cardCell
end

function Activity95Layer:updateAllCard()
  local chapterId = 0
  self.cardDatas, chapterId = Activity95Manager:getCardDatas(self.mapId, self.selectedGroupId)
  local now = CarbonManager:getMapStar(chapterId)
  self.canFinishNewTask, self.canFinishNewTaskId = Activity95Manager:getRewardTaskId(self.mapId, self.selectedGroupId, now)
  self.isUnLockGroup = Activity95Manager:isUnlockGroup(self.mapId, self.selectedGroupId)
  if not self.isUnLockGroup then
    self.canFinishNewTask = false
  end
  for k, v in pairs(self.cardDatas) do
    self:updateCard(v)
  end
  local all = Activity95Manager:getTaskProgressMax(self.mapId, self.selectedGroupId, now)
  self:changeProgress(now, all)
end

function Activity95Layer:updateCard(data)
  local cardCell = self.cardCells[data.cardIndex]
  if not cardCell then
    print("zhege card meiyou " .. data.cardIndex)
    return
  end
  if data.isgeted then
    cardCell:setImage(ResPath .. "card_open.png")
  else
    cardCell:setImage(ResPath .. "card_close.png")
  end
  if self.canFinishNewTask and not data.isgeted then
    cardCell.statuImage:setImage(ResPath .. "card_statu_canGet.png")
  end
  if not self.canFinishNewTask then
    cardCell.statuImage:setImage(ResPath .. "card_statu_lock.png")
  end
  if data.isgeted and not data.istested then
    cardCell.statuImage:setImage(ResPath .. "card_statu_test.png")
  end
  cardCell.itemIcon:setScale(0)
  if data.isgeted and data.istested then
    cardCell.statuImage:setImage(ResPath .. "card_statu_geted.png")
    cardCell.itemIcon:setImage(data.itemIconPath)
    cardCell.itemIcon:setScale(data.isHeadIcon and 0.6 or 1)
  end
end

function Activity95Layer:tryGetAward(taskId, answerIndex)
  local data = self.cardDatas[taskId]
  if not self.isUnLockGroup then
    self:openBuy(data.groupId)
    return
  end
  if data.istested then
    return
  end
  local rewardId = -1
  if answerIndex then
    taskId = data.id
  else
    if data.isgeted then
      self.selectCardIndex = data.cardIndex
      self:openQuestion(data.id)
      return
    end
    if not self.canFinishNewTask then
      SysError(SYS_ERR_CARBON_PASS_NOT_ENOUGH)
      return
    end
    taskId = self.canFinishNewTaskId
  end
  game:sendData(actionCodes.Activity_act95TaskRpc, MsgPack.pack({
    index = self.mapId,
    groupId = data.groupId,
    taskId = taskId,
    selectIndex = data.cardIndex,
    answerIndex = answerIndex
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act95TaskRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    self.selectAnswer = nil
    self:updateAllCard()
  end)
end

function Activity95Layer:trySelectAnswer(answerIndex)
  if self.isFinishAnswer then
    return
  end
  if self.selectAnswer and self.selectAnswer == answerIndex then
    self:updateQuestionColors(true)
    self:tryAnswer(answerIndex)
  else
    self.selectAnswer = answerIndex
    self:updateQuestionColors(false)
  end
end

function Activity95Layer:tryAnswer(answerIndex)
  self:tryGetAward(self.selectCardIndex, answerIndex)
end

function Activity95Layer:openQuestion(questionId)
  local question = Activity95Manager:getQuestion(self.mapId, questionId)
  self.question = question
  self.titleLabel:setString(question.question)
  self.titleAnswerBtns[1]:setString("A: " .. question.chooseA)
  self.titleAnswerBtns[2]:setString("B: " .. question.chooseB)
  self.titleAnswerBtns[3]:setString("C: " .. question.chooseC)
  self.titleAnswerBtns[4]:setString("D: " .. question.chooseD)
  self.questionBg:scale(1)
  self:updateQuestionColors(false)
end

function Activity95Layer:updateQuestionColors(isDoubleCheck)
  for i = 1, 4 do
    local color = Colors.Normal
    if not self.selectAnswer then
    elseif isDoubleCheck then
      if self.question.answer == i then
        color = Colors.Green
      end
      if self.selectAnswer == i and self.question.answer ~= i then
        color = Colors.Red
      end
      self.isFinishAnswer = true
    elseif self.selectAnswer == i then
      color = Colors.Yellow
    end
    self.titleAnswerBtns[i]:setColor(color)
  end
end

function Activity95Layer:changeProgress(now, all)
  self.progressBar:setPercentage(now / all * 100)
  self.progressBarLabel:setString(string.format("已收集蛋糕(%d/%d)", now, all))
end

function Activity95Layer:openBuy(groupId)
  local infoData = activity95InfoCsv[self.mapId][groupId]
  local name = infoData.title
  local iconPath = ItemCsv[60].icon
  local cost = globalCsv.Activity79Cost[groupId - 2]
  MDialog:double({
    title = "解锁",
    text = string.format("是否要消耗 <img src='%s' scale=0.5 />X68 解锁 %s？", iconPath, name),
    okCallback = function()
      if (game.role.items[60] or 0) < cost then
        SysError(SYS_ERR_SKIN_TICKET_ENOUGH)
        return
      end
      game:sendData(actionCodes.Activity_act95BuyUnlockRpc, MsgPack.pack({
        index = self.mapId,
        groupId = groupId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_act95BuyUnlockRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self:updateAllCard()
      end)
      return true
    end,
    cancelCallback = function()
      return true
    end
  })
end

return Activity95Layer
