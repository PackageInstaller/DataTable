local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local GU = require("Common/GuildUtil")
local LU = require("Common/ListUtil")
local PU = require("Common/PlatformUtil")
local m_recordData
local m_selectCnt = 0
local m_totalCnt = 0

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonVideo, GenerateVideo)
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.SpriteHelp, OnButtonRule)
end

function OnButtonRule()
  WU.AcquireWindowAsync("RuleCommon", function(ui)
    _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_RecordVideo"))
  end)
end

function GenerateVideo()
  CS.RecordVideoManager.Instance:ClearRecordTime()
  local data = this:GetData("RecordVideoList")
  local startTime = this:GetData("RecordVideoStartTime")
  local bSelect = false
  if data and select then
    for i, v in ipairs(data) do
      if v.check then
        bSelect = true
        CS.RecordVideoManager.Instance:AddRecordTime(v.startTime - startTime, v.endTime - startTime)
      end
    end
  end
  if bSelect then
    this:BroadcastGameEvent("RecordVideoExit", bSelect)
    local screenOffsetPix, buttomOffsetPix = PU.GetScreenOffsetPix(190)
    local screenHeightPix = CS.UnityEngine.Screen.height
    local verticalRatio = (screenOffsetPix + buttomOffsetPix) / screenHeightPix
    CS.RecordVideoManager.Instance:SetDefaultUploadShareDialogPosition(0, verticalRatio)
    CS.RecordVideoManager.Instance:GenerateMomentsVideo(WU.GetString("Platform_RecordVideoFightTitle"))
    WU.RecycleWindow(this)
  else
    WU.ShowHintText(WU.GetString("LocalVideo_Tips5"))
  end
end

function UpdateWidget(refRow, wrapIndex, realIndex)
  refRow["$$SetData"](m_recordData[realIndex + 1], realIndex + 1)
end

function InitWindow()
  m_selectCnt = 0
  m_totalCnt = 0
  this:RegisterGameEvent("SelectVideo", function(b)
    if b then
      m_selectCnt = m_selectCnt + 1
    else
      m_selectCnt = m_selectCnt - 1
    end
    REF.LabelSelect.UILabel.text = WU.GetString("LocalVideo_Tips4", m_selectCnt, m_totalCnt)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
  local collectionVideo = {}
  local videoList = this:GetData("RecordVideoList")
  for i, v in ipairs(videoList) do
    local temp = collectionVideo[v.round]
    if temp == nil then
      temp = {}
      temp.round = v.round
      temp.recordData = {}
      collectionVideo[v.round] = temp
    end
    v.check = false
    temp.recordData[#temp.recordData + 1] = v
    m_totalCnt = m_totalCnt + 1
  end
  m_recordData = {}
  for k, v in pairs(collectionVideo) do
    m_recordData[#m_recordData + 1] = v
  end
  table.sort(m_recordData, function(a, b)
    return a.round < b.round
  end)
  if 0 < #m_recordData then
    m_recordData[#m_recordData].isLast = true
  end
  REF.LabelSelect.UILabel.text = WU.GetString("LocalVideo_Tips4", m_selectCnt, m_totalCnt)
  LU.Set(REF.WrapContent, #m_recordData)
end
