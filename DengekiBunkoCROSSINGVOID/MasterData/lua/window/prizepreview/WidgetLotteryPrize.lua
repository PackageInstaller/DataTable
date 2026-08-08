local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_config

function SetConfig(config)
  m_config = config
  SetLeftTitle()
  SetTopTitle()
  SetRewards()
end

function SetLeftTitle()
  local title = GetLeftTitleAffix()
  local count = #REF.LeftTitle
  for i = 0, count - 1 do
    if m_config.rewardOrderReverse then
      REF.LeftTitle[i]["$UILabel"].text = WU.GetString(title .. count - i)
    else
      REF.LeftTitle[i]["$UILabel"].text = WU.GetString(title .. i + 1)
    end
  end
end

function SetTopTitle()
  local title = GetTopTitleAffix()
  local count = #REF.TopTitle
  for i = 0, count - 1 do
    REF.TopTitle[i]["$UILabel"].text = WU.GetString(title .. i + 1)
  end
end

function SetRewards()
  local allCount = #REF.GridReward
  local col = REF.GridReward.UIGrid.maxPerLine
  local row = math.floor((allCount - 1) / col) + 1
  for i = 1, row do
    for j = 1, col do
      local ref = REF.GridReward[(i - 1) * col + (j - 1)]
      local rewardInfo = GetRewards(row - i + 1, j)
      for k = 0, #ref.root - 1 do
        if rewardInfo == nil then
          WU.SetActive(ref.root[k].root, false)
        else
          local reward = rewardInfo.reward[k + 1]
          WU.SetActive(ref.root[k].root, reward)
          if reward then
            ref.root[k].root["$SetData"](reward.type, reward.id, reward.count)
            ref.root[k].root["$SetClickCallback"](function()
              WU.ShowResourceDetail(reward.type, reward.id)
            end)
          end
        end
      end
    end
  end
end

function GetLeftTitleAffix()
  if m_config.name == "GameLottery" then
    return "Lottery_Luck_"
  end
end

function GetTopTitleAffix()
  if m_config.name == "GameLottery" then
    return "Lottery_Id_"
  end
end

function GetRewards(rowIndex, colIndex)
  if m_config.name == "GameLottery" then
    return PB.get(m_config.rewardsXlsx, colIndex, rowIndex)
  end
end
