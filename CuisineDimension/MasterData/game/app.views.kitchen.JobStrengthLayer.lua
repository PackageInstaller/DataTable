local jobBonusCsv = require("csvdata.hero_job_bonus")
local jobStageCsv = require("csvdata.hero_job_stage")
local jobItemCsv = require("csvdata.hero_job_item")
local ItemCsv = require("csvdata.item")
local jobRes = "ui/hero/job/"
local jobStageRes = "ui/hero/job/stage/"
local uiData = {
  csbFile = "ui/kitchen/JobStrengthLayer.csb",
  widgets = {mainBg1 = "mainBg", jobNode = "jobNode"}
}
local cellData = {
  [1] = {
    id = 1,
    name = "主食",
    pos = {-246, 176}
  },
  [2] = {
    id = 2,
    name = "主菜",
    pos = {246, 176}
  },
  [3] = {
    id = 3,
    name = "副菜",
    pos = {-246, 0}
  },
  [4] = {
    id = 4,
    name = "甜点",
    pos = {246, 0}
  },
  [5] = {
    id = 5,
    name = "头盘",
    pos = {-246, -176}
  },
  [6] = {
    id = 6,
    name = "汤饮",
    pos = {246, -176}
  }
}
local JobStrengthLayer = class("JobStrengthLayer", UIBase)

function JobStrengthLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JobStrengthLayer:init(params)
  self:showJobList()
end

function JobStrengthLayer:showJobList()
  self.jobStage = game.role.jobStage or ""
  self.jobExp = game.role.jobExp or ""
  self.useList = {}
  self.richLabelList = {}
  self.jobNode:removeAllChildren()
  for i, data in ipairs(cellData) do
    self:createJobCell(data)
  end
  local infoBtn = UIHelper.extend(ccui.Button:create())
  infoBtn:setImages(jobRes, {
    "btn_info.png",
    "btn_info.png"
  })
  infoBtn:pos(1010, 595):addTo(self.mainBg1)
  infoBtn:setTouchScale()
  infoBtn:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "herojob"})
  end)
end

function JobStrengthLayer:createJobCell(data)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(480, 160)):addTo(self.jobNode):pos(data.pos[1], data.pos[2])
  local bg = display.newSprite(jobRes .. "Job_bg.png"):center(viewNode):addTo(viewNode)
  display.newTTFLabel({
    text = data.name,
    size = 26,
    color = UIHelper.hex2rgb("#6c4239")
  }):anch(0, 0.5):pos(105, 128):addTo(bg)
  local stageData = self:getJobStage(data.id)
  local icon = display.newSprite(jobRes .. string.format("stage_%d.png", stageData.stage)):anch(0, 0.5):pos(167, 128):addTo(bg)
  local stageBg = display.newSprite(jobStageRes .. string.format("job_%d_%d.png", data.id, stageData.stage)):anch(0, 0.5):pos(6, 90):addTo(bg)
  local level, exp, needExp = self:getJobLevel(data.id)
  local tuPo = self:checkCanTuPo(data.id)
  local level_bg = display.newSprite(jobRes .. "level_bg.png"):pos(46, 0):addTo(stageBg)
  local levelText = string.format("LV.<div size=22>%d</div>", level)
  local richLabel1 = MRichText.new({text = levelText, size = 14}):pos(27, 10):addTo(level_bg)
  richLabel1:setAnchorPoint(cc.p(0.5, 0.5))
  local expBarBg = display.newSprite(jobRes .. "exp_bg.png"):anch(0, 0):pos(105, 70):addTo(bg)
  local expBar = display.newProgressTimer(jobRes .. "ext_bar.png", 1):center(expBarBg):addTo(expBarBg)
  expBar:setBarChangeRate(cc.p(1, 0))
  expBar:setMidpoint(cc.p(0, 0.5))
  expBar:setPercentage(tuPo and 100 or exp / needExp * 100)
  self.richLabelList[data.id] = MRichText.new({
    text = "",
    size = 22,
    color = UIHelper.hex2rgb("#8d7d80")
  }):pos(0, 36):addTo(expBarBg)
  self:showExpLabel(data.id, exp, needExp, self.useList[data.id])
  local btnName = tuPo and "stageUp_btn.png" or "levelUp_btn.png"
  local upBtn = UIHelper.extend(ccui.Button:create())
  upBtn:setImages(jobRes, {btnName, btnName})
  upBtn:pos(395, 35):addTo(bg)
  upBtn:setTouchScale()
  upBtn:setCallback(function()
    if not tuPo then
      local costs = self:getCosts(data.id, self.useList[data.id])
      if next(costs) then
        self:levelUp(data.id, costs)
      else
        SysError(SYS_ERR_NOT_COST_ITEMS)
      end
    else
      self:stageUp(data.id, stageData.cost:toNumMap())
    end
  end)
  if self:checkMax(data.id) then
    upBtn:hide()
  end
  local proBtn = UIHelper.extend(ccui.Button:create())
  proBtn:setImages(jobRes, {
    "pro_btn.png",
    "pro_btn.png"
  })
  proBtn:pos(431, 130):addTo(bg)
  proBtn:setTouchScale()
  proBtn:setCallback(function()
    game:createView("kitchen.JobPropertyLayer", {
      jobId = data.id,
      stageLevel = stageData.stage,
      level = level
    })
  end)
  local offsetx = 0
  local items = {}
  if not self:checkMax(data.id) then
    if not tuPo then
      for i, _data in pairs(jobItemCsv) do
        if _data.jobId == data.id then
          table.insert(items, _data)
        end
      end
    else
      local costs = stageData.cost:toNumMap()
      for k, v in pairs(costs) do
        table.insert(items, {id = k, count = v})
      end
    end
  end
  table.sort(items, function(a, b)
    return a.id < b.id
  end)
  for i, _data in pairs(items) do
    local itemData = ItemCsv[_data.id]
    local icon = ItemIcon.new({
      type = _data.id,
      count = game.role.items[_data.id] or 0,
      needCount = tuPo and _data.count or 0,
      showTip = true,
      needShowCount = true
    }):anch(0, 0.5):scale(0.42):pos(105 + offsetx, 35):addTo(bg)
    offsetx = offsetx + 41
  end
  local btnAdd = UIHelper.extend(ccui.Button:create())
  btnAdd:setImages(jobRes, {
    "other_btn.png",
    "other_btn.png"
  })
  btnAdd:pos(128 + offsetx, 35):addTo(bg)
  btnAdd:setTouchScale()
  btnAdd:setCallback(function()
    game:createView("kitchen.JobStrengthUpLayer", {
      userList = self.useList[data.id] or {},
      callBack = function(useList)
        self.useList[data.id] = useList
        self:showExpLabel(data.id, exp, needExp, self.useList[data.id])
      end
    })
  end)
  if tuPo or self:checkMax(data.id) then
    btnAdd:hide()
  end
end

function JobStrengthLayer:showExpLabel(jobId, exp, needExp, useList)
  local tupo = self:checkCanTuPo(jobId)
  local costs = self:getCosts(jobId, useList)
  local addExp = 0
  for id, count in pairs(costs) do
    local csvdata = jobItemCsv[id]
    addExp = addExp + csvdata.addExp * count
  end
  if self.richLabelList[jobId] then
    local str = string.format("<div color=#e58556>%d</div><div color=#8d7d80>/%d</div><div size=14> (当前选择材料可增加<div size=14 color=#e58556>%d</div>经验)</div>", exp, needExp, addExp)
    if tupo then
      local stage = self.jobStage:getv(jobId, 1)
      local csvData = jobStageCsv[stage + 1]
      local stageStr = ""
      if csvData then
        str = string.format("<div color=#e58556>%d</div><div color=#8d7d80>/%d</div><div size=14> (可使用材料突破至<div size=14 color=#e58556>%s</div>)</div>", exp, needExp, csvData.stageName)
      end
    end
    if self:checkMax(jobId) then
      str = string.format("MAX")
    end
    self.richLabelList[jobId]:setString(str)
  end
end

function JobStrengthLayer:getCosts(jobId, useList)
  local costs = {}
  useList = useList or {}
  for i, _data in pairs(jobItemCsv) do
    local count = game.role.items[_data.id] or 0
    if _data.jobId == jobId and 0 < count then
      costs[_data.id] = (costs[_data.id] or 0) + count
    end
  end
  for itemId, count in pairs(useList) do
    costs[itemId] = (costs[itemId] or 0) + count
  end
  return costs
end

function JobStrengthLayer:levelUp(jobId, costs)
  game:sendData(actionCodes.Role_useJobExpItemRpc, MsgPack.pack({costs = costs, job = jobId}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Role_useJobExpItemRpc, function(event)
    UIHelper.removeWaiting()
    self.useList[jobId] = nil
    MFlashMsg:show({
      text = "经验书使用成功"
    })
    self:showJobList()
    game.role:setJobLevel()
  end)
end

function JobStrengthLayer:stageUp(jobId, costs)
  local canUp = true
  for id, value in pairs(costs) do
    if value > (game.role.items[id] or 0) then
      canUp = false
    end
  end
  if not canUp then
    SysError(SYS_ERR_NOT_CANUP)
    return
  end
  MDialog:double({
    title = "提示",
    text = "确定消耗材料进行突破？",
    okCallback = function()
      game:sendData(actionCodes.Role_jobStageBreakRpc, MsgPack.pack({job = jobId}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Role_jobStageBreakRpc, function(event)
        UIHelper.removeWaiting()
        self:showJobList()
        game.role:setJobLevel()
      end)
      return true
    end,
    cancelCallback = function()
      return true
    end
  })
end

function JobStrengthLayer:getJobStage(jobId)
  self.jobStage = game.role.jobStage or ""
  local stage = self.jobStage:getv(jobId, 1)
  stage = math.min(stage, #jobStageCsv)
  local csvData = jobStageCsv[stage]
  return csvData
end

function JobStrengthLayer:getJobLevel(jobId)
  local curExp = self.jobExp:getv(jobId, 0)
  local jobStage = self.jobStage:getv(jobId, 1)
  jobStage = math.min(jobStage, #jobStageCsv)
  local curData, nextData
  local csvData = jobBonusCsv[jobId][jobStage]
  for index, levelData in ipairs(csvData) do
    if curExp >= levelData.exp then
      curData = levelData
    end
  end
  nextData = self:getNextData(curData)
  local needExp = 0
  if nextData then
    needExp = nextData.exp - curData.exp
  end
  game.role.jobLevel = game.role.jobLevel or ""
  game.role.jobLevel:setv(jobId, curData.level)
  return curData.level, curExp - curData.exp, needExp
end

function JobStrengthLayer:getNextData(curData)
  local jobData = jobBonusCsv[curData.jobId]
  local stageData = jobData[curData.stage]
  local nextLevelData = stageData[curData.level + 1]
  if nextLevelData then
    return nextLevelData
  end
  stageData = jobData[curData.stage + 1]
  if stageData then
    return stageData[1]
  end
  return nil
end

function JobStrengthLayer:checkCanTuPo(jobId)
  self.jobStage = game.role.jobStage or ""
  local stage = self.jobStage:getv(jobId, 1)
  stage = math.min(stage, #jobStageCsv)
  local curExp = self.jobExp:getv(jobId, 0)
  if jobStageCsv[stage].allExp == 0 then
    return false
  end
  return curExp >= jobStageCsv[stage].allExp
end

function JobStrengthLayer:checkMax(jobId)
  local stage = self.jobStage:getv(jobId, 1)
  stage = math.min(stage, #jobStageCsv)
  local jobData = jobBonusCsv[jobId]
  local levelData = jobBonusCsv[jobId][stage]
  local level = self:getJobLevel(jobId)
  return stage == #jobData and level >= #levelData
end

return JobStrengthLayer
