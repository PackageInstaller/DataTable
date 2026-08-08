local WU, DB, REF = require("Common/WindowUtil")(this)
local LU = require("Common/ListUtil")
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_randomInfo
local m_allPrizes = {}
local m_reward2Get = {}

function SetupWindow()
  LU.Bind(REF.WrapContentReward, {
    updateRow = OnAwardItemShow
  })
  WU.BindButtonEvent(REF.ButtonReceiveAll, function()
    GetReq(m_reward2Get)
  end)
end

function InitWindow()
  m_allPrizes = {}
  WU.ToggleRendering(REF.WrapContentReward, false)
end

function SetPrizes(prizes)
  if m_allPrizes then
    m_reward2Get = {}
    m_allPrizes = prizes
    m_randomInfo = this:GetData("fci/RDPVPInfo/")
    WU.ToggleRendering(REF.WrapContentReward, true)
    for k, v in pairs(prizes) do
      local winReach = m_randomInfo.baseInfo.winNum >= v.winCnt
      local _, Got = table.find(m_randomInfo.rewardGot, function(key, val)
        return val == v.winCnt
      end)
      if not Got and winReach then
        table.insert(m_reward2Get, v.winCnt)
      end
    end
    LU.Set(REF.WrapContentReward, #m_allPrizes)
  end
end

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allPrizes == nil or realIndex >= #m_allPrizes then
    return
  end
  local awards = m_allPrizes[realIndex + 1]
  local data = {}
  local state
  data.reward = awards.reward
  local winReach = m_randomInfo.baseInfo.winNum >= awards.winCnt
  local _, Got = table.find(m_randomInfo.rewardGot, function(key, val)
    return val == awards.winCnt
  end)
  local _, toGet = table.find(m_reward2Get, function(key, val)
    return val == awards.winCnt
  end)
  if toGet then
    state = PB.enum.RewardState.CanGet
  end
  if Got then
    state = PB.enum.RewardState.HasGot
  end
  data.rewardState = state
  _ENV["$"](rowRef.root).StateNode.gameObject:SetActive(state ~= nil)
  rowRef["$$SetData"](data)
  rowRef["$$SetRewardView"]()
  rowRef["$$SetStateView"]()
  WU.ClearButtonEvent(_ENV["$"](rowRef.root).BtnGet)
  if state == PB.enum.RewardState.CanGet then
    WU.BindButtonEvent(_ENV["$"](rowRef.root).BtnGet, function()
      local param = {
        awards.winCnt
      }
      GetReq(param)
    end)
  end
  rowRef.LabelTitle.UILabel.text = WU.GetString("Tournament_WinTimes", awards.winCnt)
end

function GetReq(list)
  if list == nil or #list <= 0 then
    WU.ShowHintText(WU.GetString("Window_GetAllRewardsFailed"))
    return
  end
  this:GameRequest("fci/RDPVPReward/"):Post({winNumList = list}, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    m_randomInfo.rewardGot = result.rewardGot
    this:SetData("fci/RDPVPInfo/", m_randomInfo)
    SetPrizes(m_allPrizes)
    this:BroadcastGameEvent("RandomCall/RewardRefresh")
  end)
end
