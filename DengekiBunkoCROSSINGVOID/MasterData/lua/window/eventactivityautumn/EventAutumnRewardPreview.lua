local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local ATU = require("Common/AutumnUtil")
local m_activityManager = S:Get("ActivityManager")
local m_allRewards = {}
local m_allRecords = {}
local m_dataSource = {
  source = {}
}
local m_curMode

function SetMode(mode)
  m_curMode = mode
  SetContent()
end

function SetContent()
  _ENV["Get" .. m_curMode]()
  REF.NodeAddress.gameObject:SetActive(false)
  if m_curMode == "Record" then
    REF.LabelTitle.UILabel.text = WU.GetString("EventActivity_RewardRecord")
  else
    REF.LabelNoRecord.gameObject:SetActive(false)
    REF.LabelTitle.UILabel.text = WU.GetString("EventActivity_RewardLeft")
  end
end

function SetWrapContent()
  REF.WrapContent.gameObject:SetActive(#m_dataSource.source > 0)
  LU.Bind(REF.WrapContent, {
    updateRow = _ENV["On" .. m_curMode .. "ItemShow"]
  })
  LU.Set(REF.WrapContent, #m_dataSource.source)
end

function GetReward()
  m_allRewards = {}
  DB:GameRequest("fci/ClawCranePrize/"):Get(function(resp)
    if resp then
      local info = resp.limitInfo
      local craneInfo = PB.all("ClawCrane")
      local allProbaCount = ATU.GetAutumnClawCount()
      for k, v in pairs(info) do
        local item = PB.get("ClawCrane", v.id)
        item.leftCount = v.leftCount
        item.actualProbty = item.probability / allProbaCount
        item.stockReal = v.stock
        table.insert(m_allRewards, item)
      end
      for k, v in pairs(craneInfo) do
        if not v.isCountLimit then
          local item = v
          item.actualProbty = item.probability / allProbaCount
          table.insert(m_allRewards, v)
        end
      end
      m_dataSource.source = m_allRewards
      SetWrapContent()
    end
  end)
end

function OnRewardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allRewards == nil or realIndex >= #m_allRewards then
    return
  end
  local award = m_allRewards[realIndex + 1]
  rowRef.WidgetIconSlot["$SetData"](award.res.type, award.res.id)
  rowRef.WidgetIconSlot["$SetClickCallback"](function()
    WU.ShowResourceDetail(award.res.type, award.res.id)
  end)
  rowRef.LabelName.UILabel.text = WU.GetString(fif(WU.IsResource(award.res.type), "ResourceTypeName_" .. award.res.type, "ItemName_" .. award.res.id))
  rowRef.LabelProbability.UILabel.text = award.actualProbty * 100 .. "%"
  local flagHasLeft = award.leftCount ~= nil and award.actualProbty ~= nil
  if flagHasLeft then
    rowRef.LabelAmountLeft.UILabel.text = award.leftCount .. "/" .. award.stockReal
    rowRef.SpriteSellOut.gameObject:SetActive(0 >= award.leftCount)
  else
    rowRef.SpriteSellOut.gameObject:SetActive(false)
  end
  rowRef.NodeLimit.gameObject:SetActive(flagHasLeft)
  rowRef.NodeNoLimit.gameObject:SetActive(not flagHasLeft)
  ManageSlot(rowRef)
end

function GetRecord()
  this:GameRequest("fci/ClawCraneRecord/"):Get(function(resp)
    if resp then
      m_allRecords = resp.peripheralRecord
      table.sort(m_allRecords, function(a, b)
        return a.getTime > b.getTime
      end)
      m_dataSource.source = m_allRecords
      REF.LabelNoRecord.gameObject:SetActive(#m_allRecords <= 0)
      SetWrapContent()
    end
  end)
end

function OnRecordItemShow(rowRef, wrapIndex, realIndex)
  if m_allRecords and realIndex < #m_allRecords then
    local record = m_allRecords[realIndex + 1].peripheralRes
    rowRef.WidgetIconSlot["$SetData"](record.type, record.id)
    rowRef.WidgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(record.type, record.id)
    end)
    rowRef.LabelTime.UILabel.text = WU.RenderTime2(m_allRecords[realIndex + 1].getTime, true, false, true)
    ManageSlot(rowRef)
  end
end

function ManageSlot(rowRef)
  rowRef.NodeRecord.gameObject:SetActive(false)
  rowRef.NodeReward.gameObject:SetActive(false)
  rowRef["Node" .. m_curMode].gameObject:SetActive(true)
end

function GetStock(id)
  local ac
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ActivityType_ClawCrane, function(acList)
    if acList then
      ac = acList[1]
    end
  end)
  local time = CS.GameTime.serverUtc - ac.timestampStart
  local seconds = math.max(time, 0)
  local timeSpan = CS.System.TimeSpan(0, 0, seconds)
  local item = PB.get("ClawCraneStock", id, timeSpan.Days + 1)
  if item and item.stock then
    return item.stock
  else
    return nil
  end
end
