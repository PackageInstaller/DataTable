local ChapterPassManager = require("app.models.ChapterPassManager")
local CarbonManager = require("app.models.CarbonManager")
local ChapterPassTaskLayer = {}
local ResPath = "ui/activity/79/"
local Type = 79
local ChapterPassTaskCsv = require("csvdata.chapter_pass_task")
local ChapterPassReward = require("csvdata.chapter_pass_reward")
local ChapterPassQuestionCsv = require("csvdata.chapter_pass_question")
local ItemCsv = require("csvdata.item")
local AwakeCsv = require("csvdata.awaken_draw")
local originDungeonNum = require("csvdata.awaken_draw")
local Groups = {}
Groups[1] = {
  name = "华夏功名箓·上",
  id = 1,
  x = -345,
  y = -32
}
Groups[2] = {
  name = "华夏功名箓·下",
  id = 2,
  x = -166,
  y = -32
}
Groups[3] = {
  name = "华夏荣华箓·上",
  id = 3,
  x = -345,
  y = -88,
  needBuy = true
}
Groups[4] = {
  name = "华夏荣华箓·下",
  id = 4,
  x = -166,
  y = -88,
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

function ChapterPassTaskLayer:init(content)
  local mainBg = display.newSprite(ResPath .. "main_bg.png"):anch(0, 0):pos(-455, -266):addTo(content)
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
  for i = 1, #Groups do
    self:createChapterBtn(content, Groups[i])
  end
  self:select(1)
  local btn_info = UIHelper.extend(ccui.Button:create())
  btn_info:setImages(ResPath, {
    "btn_info.png",
    "btn_info.png"
  })
  btn_info:pos(-110, -245):addTo(content)
  btn_info:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_79"
    })
  end)
  self:createQuestion(content)
end

function ChapterPassTaskLayer:createQuestion(content)
  local questionBg = UIHelper.extend(ccui.Layout:create()):anch(0.5, 0.5):pos(0, 0):scale(0):addTo(content)
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

function ChapterPassTaskLayer:createChapterBtn(frame, data)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(ResPath, {
    string.format("btn_draw_%d.png", data.id),
    string.format("btn_draw_%d.png", data.id)
  })
  btn:pos(data.x, data.y):addTo(frame)
  btn:setCallback(function()
    self:select(data.id)
  end)
  return btn
end

function ChapterPassTaskLayer:select(groupId)
  local group = Groups[groupId]
  self.selectedGroupId = groupId
  self.btnSelected:pos(group.x, group.y)
  self:updateAllCard()
end

function ChapterPassTaskLayer:createCard(frame, data)
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

function ChapterPassTaskLayer:updateAllCard()
  local chapterId = 0
  self.cardDatas, chapterId = ChapterPassManager:getCardDatas(self.selectedGroupId)
  local now = CarbonManager:getMapStar(chapterId)
  self.canFinishNewTask, self.canFinishNewTaskId = ChapterPassManager:getRewardTaskId(self.selectedGroupId, now)
  self.isUnLockGroup = ChapterPassManager:isUnlockGroup(self.selectedGroupId)
  if not self.isUnLockGroup then
    self.canFinishNewTask = false
  end
  for k, v in pairs(self.cardDatas) do
    self:updateCard(v)
  end
  local all = ChapterPassManager:getTaskProgressMax(self.selectedGroupId, now)
  self:changeProgress(now, all)
end

function ChapterPassTaskLayer:updateCard(data)
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

function ChapterPassTaskLayer:tryGetAward(taskId, answerIndex)
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
  game:sendData(actionCodes.Activity_chapterPassTaskRpc, MsgPack.pack({
    groupId = data.groupId,
    taskId = taskId,
    selectIndex = data.cardIndex,
    answerIndex = answerIndex
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_chapterPassTaskRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    self.selectAnswer = nil
    self:updateAllCard()
  end)
end

function ChapterPassTaskLayer:trySelectAnswer(answerIndex)
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

function ChapterPassTaskLayer:tryAnswer(answerIndex)
  self:tryGetAward(self.selectCardIndex, answerIndex)
end

function ChapterPassTaskLayer:openQuestion(questionId)
  local question = ChapterPassManager:getQuestion(questionId)
  self.question = question
  self.titleLabel:setString(question.question)
  self.titleAnswerBtns[1]:setString("A: " .. question.chooseA)
  self.titleAnswerBtns[2]:setString("B: " .. question.chooseB)
  self.titleAnswerBtns[3]:setString("C: " .. question.chooseC)
  self.titleAnswerBtns[4]:setString("D: " .. question.chooseD)
  self.questionBg:scale(1)
  self:updateQuestionColors(false)
end

function ChapterPassTaskLayer:updateQuestionColors(isDoubleCheck)
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

function ChapterPassTaskLayer:changeProgress(now, all)
  self.progressBar:setPercentage(now / all * 100)
  self.progressBarLabel:setString(string.format("已收集蛋糕(%d/%d)", now, all))
end

function ChapterPassTaskLayer:openBuy(groupId)
  local name = Groups[groupId].name
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
      game:sendData(actionCodes.Activity_chapterPassBuyUnlockRpc, MsgPack.pack({groupId = groupId}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_chapterPassBuyUnlockRpc, function(event)
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

return ChapterPassTaskLayer
