local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local m_grade, m_segList
local m_asyncPvpMiscInfo = {}

function SetupWindow()
  m_segList = PB.all("AsyncPvpRankReward")
  m_asyncPvpMiscInfo = PB.all("Misc"):first().asyncPvpV2Info
end

function InitWindow()
  local baseInfo = this:GetData("AsyncPvpNew/BaseInfo")
  m_grade = math.clamp(baseInfo.curSeg, 1, #m_segList)
  InitGradeInfo()
  InitCurrentGradeInfo()
end

function InitGradeInfo()
  if m_grade == nil then
    warning("AsyncPvpNew", "\230\156\141\229\138\161\229\153\168\230\178\161\230\156\137\232\191\148\229\155\158\230\149\176\230\141\174")
    return
  end
  if m_segList == nil then
    warning("AsyncPvpNew", "\230\178\161\230\156\137\230\174\181\228\189\141\231\154\132\230\149\176\230\141\174\230\161\163")
    return
  end
  WU.TraverseChildren(REF.WrapContent, function(go, index)
    local ref = _ENV["$"](go)
    local trueIndex = index + 1
    local mode = trueIndex
    local grade = math.clamp(m_grade - trueIndex + 2, 1, #m_segList)
    local upPercent = m_asyncPvpMiscInfo.upgradeSeg / 100
    local downPercent = m_asyncPvpMiscInfo.downSeg / 100
    local edgeL = upPercent + 1
    local edgeR = downPercent
    if m_grade == 1 and trueIndex == 3 then
      WU.SetActive(ref["$"], false)
    end
    if m_grade == #m_segList and trueIndex == 1 then
      WU.SetActive(ref["$"], false)
    end
    if m_grade == 1 or m_grade == #m_segList then
      if grade == 1 then
        edgeR = 100
      elseif grade == #m_segList then
        edgeL = 0
      end
      if grade == 1 or grade == #m_segList then
        mode = 2
      end
    end
    if mode == 1 then
      edgeL = 0
      edgeR = upPercent
    elseif mode == 3 then
      edgeL = downPercent + 1
      edgeR = 100
    end
    local conditionText = WU.GetString("NAsyncPvp_RankRange", math.floor(edgeL), math.floor(edgeR))
    ref["$$SetData"](m_segList[grade], mode, conditionText)
  end)
end

function InitCurrentGradeInfo()
  WU.SetActive(REF.Bottom, false)
  this:GameRequest("fci/asyncpvp_v2_rank_list/"):Get(function(result)
    WU.SetActive(REF.Bottom, true)
    local percent = result.rankPercent / 100
    local conditionText = WU.GetString("NAsyncPvp_CurrentRank", math.floor(percent))
    _ENV["$"](REF.Bottom).AsyncPvpNewRankSlot["$SetData"](m_segList[m_grade], 0, conditionText, m_segList[m_grade].weekRewards)
  end)
end
