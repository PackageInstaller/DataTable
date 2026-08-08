local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local m_itemSlotInfo
local m_itemSlotList = {}
local RewardStatus_CanGet = 0
local RewardStatus_CannotGet = 1
local RewardStatus_Got = 2
local m_winNum

function Start()
end

function SetData(itemSlotInfo, winNum)
  m_itemSlotInfo = itemSlotInfo
  m_winNum = winNum
  local newItemSlotCount = #m_itemSlotInfo - #m_itemSlotList
  if 0 < newItemSlotCount then
    CreateItemSlot(newItemSlotCount)
  end
  SetItemSlot()
  SetProgressBar()
end

function CreateItemSlot(newItemSlotCount)
  for i = 0, newItemSlotCount - 1 do
    local newItemSlot = CS.UnityEngine.GameObject.Instantiate(REF.NodeWidgetIconSlotTemplate.gameObject, REF.NodeIcons.transform)
    newItemSlot:SetActive(true)
    table.insert(m_itemSlotList, newItemSlot)
    WU.BindButtonEvent(_ENV["$"](newItemSlot).ItemSlot, function(go)
      local index = _ENV["$"](go.transform.parent)["@index"]
      local canGet = table.has(ACU.GetAllLeftAsyncPvpRecord(), m_itemSlotInfo[index].winNum)
      if canGet then
        this:GameRequest("fci/tournament/winreward/"):Post({
          tournamentId = this:GetData("fci/tournament/curId"),
          activityType = this:GetData("fci/tournament/curActivityType"),
          winNum = m_itemSlotInfo[index].winNum
        }, function(result)
          if result then
            this:SetData("fci/asyncpvprecord/", result.asyncPvpRecord)
            DBH.ResChange(result.resChange)
            WU.ShowRewards(result.resChange, function()
              if result.asyncPvpRecord.canRefresh then
                this:BroadcastGameEvent("AsyncPvpDailyRefresh")
              end
            end)
          end
        end)
      else
        local title = WU.GetString("Tournament_RewardPreviewTitle")
        local content = WU.GetString("Tournament_WinNumStatus") .. m_winNum .. "/" .. m_itemSlotInfo[index].winNum
        local extraRewardParams = {
          type = PB.enum.ActivityExtraRewardRuleType.AsyncPVP,
          winNum = m_itemSlotInfo[index].winNum
        }
        AM.GetTimeLimitExtraReward(extraRewardParams, function(extra)
          local reward = {}
          table.insert(reward, m_itemSlotInfo[index].reward)
          if #extra ~= 0 then
            for i = 1, #extra do
              table.insert(reward, extra[i])
            end
          end
          WU.AcquireWindowAsync("RewardPreview", function(ui)
            _ENV["$"](ui)["$$SetView"](reward, title, content, false)
          end)
        end)
      end
    end)
  end
end

function SetItemSlot()
  local width = REF.ProgressBar.UISprite.width
  local stepLenth = width / (m_itemSlotInfo[#m_itemSlotInfo].winNum - 1)
  for i = 1, #m_itemSlotList do
    if i <= #m_itemSlotInfo then
      local itemREF = _ENV["$"](m_itemSlotList[i])
      itemREF["@index"] = i
      if table.has(ACU.GetAllLeftAsyncPvpRecord(), m_itemSlotInfo[i].winNum) then
        SetReawrdStatus(itemREF, RewardStatus_CanGet)
      elseif m_winNum >= m_itemSlotInfo[i].winNum then
        SetReawrdStatus(itemREF, RewardStatus_Got)
      else
        SetReawrdStatus(itemREF, RewardStatus_CannotGet)
      end
      itemREF.LabelNum.UILabel.text = WU.GetString("Tournament_WinTimes", m_itemSlotInfo[i].winNum)
      local posX = stepLenth * (m_itemSlotInfo[i].winNum - 1) - width * 0.5
      m_itemSlotList[i].transform.localPosition = {
        x = posX,
        y = 0,
        z = 0
      }
      m_itemSlotList[i].gameObject:SetActive(true)
    else
      m_itemSlotList[i].gameObject:SetActive(false)
    end
  end
end

function SetReawrdStatus(itemREF, status)
  if status == RewardStatus_CanGet then
    WU.ToggleRendering(itemREF.EffectCanGet, true)
    WU.ToggleRendering(itemREF.SpriteUnGet, false)
    WU.ToggleRendering(itemREF.SpriteGot, false)
  elseif status == RewardStatus_CannotGet then
    WU.ToggleRendering(itemREF.EffectCanGet, false)
    WU.ToggleRendering(itemREF.SpriteUnGet, true)
    WU.ToggleRendering(itemREF.SpriteGot, false)
  elseif status == RewardStatus_Got then
    WU.ToggleRendering(itemREF.EffectCanGet, false)
    WU.ToggleRendering(itemREF.SpriteUnGet, false)
    WU.ToggleRendering(itemREF.SpriteGot, true)
  end
end

function SetProgressBar()
  REF.ProgressBar.UIProgressBar.value = (m_winNum - 1) / (m_itemSlotInfo[#m_itemSlotInfo].winNum - 1)
end
