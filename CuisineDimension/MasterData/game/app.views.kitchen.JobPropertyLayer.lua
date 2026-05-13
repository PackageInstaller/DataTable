local jobBonusCsv = require("csvdata.hero_job_bonus")
local jobStageCsv = require("csvdata.hero_job_stage")
local ItemCsv = require("csvdata.item")
local jobRes = "ui/hero/job/"
local jobStageRes = "ui/hero/job/stage/"
local uiData = {
  csbFile = "ui/kitchen/JobPropertyLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    title = "popAction/title",
    closeBtn = "popAction/closeBtn",
    title_1 = "popAction/title_1",
    title_2 = "popAction/title_2",
    curProNode = "popAction/title_1/curProNode",
    nextProNode = "popAction/title_2/nextProNode",
    tip = "popAction/tip"
  }
}
local proDesPos = {
  [1] = {0, 0},
  [2] = {200, 0},
  [3] = {380, 0},
  [4] = {0, -30},
  [5] = {200, -30},
  [6] = {380, -30}
}
local JobPropertyLayer = class("JobPropertyLayer", UIBase)

function JobPropertyLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JobPropertyLayer:init(params)
  self.jobId = params.jobId
  self.stageLevel = params.stageLevel
  self.level = params.level
  local titleStr = {
    [1] = "主食",
    [2] = "主菜",
    [3] = "副菜",
    [4] = "甜点",
    [5] = "头盘",
    [6] = "汤饮"
  }
  self.title:setString(titleStr[self.jobId] .. "属性加成")
  local curData = jobBonusCsv[self.jobId][self.stageLevel][self.level]
  self:showPro(self.jobId, curData, self.curProNode, 1)
  self:showPro(self.jobId, curData, self.nextProNode, 2)
  self.closeBtn:setTouchScale()
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function JobPropertyLayer:showPro(jobId, csvData, node, type)
  local stage = csvData.stage
  local bonusData = jobBonusCsv[jobId][stage]
  if type == 2 and stage + 1 <= #jobStageCsv and csvData.level == #bonusData then
    stage = stage + 1
  end
  local stage = display.newSprite(jobRes .. string.format("stage_%d.png", stage)):pos(160, 18):addTo(self["title_" .. type])
  local desc = type == 1 and csvData.desc or csvData.nextDesc
  local datas = desc:toArray("=")
  for i, value in pairs(datas) do
    local textStr = value
    display.newTTFLabel({
      text = textStr,
      size = 20,
      color = UIHelper.hex2rgb("#7a6d69")
    }):anch(0, 0.5):pos(proDesPos[i][1], proDesPos[i][2]):addTo(node)
  end
end

return JobPropertyLayer
