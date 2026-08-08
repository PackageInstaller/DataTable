local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local ACU = require("Common/ActivityUtil")
local m_activityManager = S:Get("ActivityManager")
local m_ac, m_timesLeft, m_btnCallBack
local m_setBtnB4 = false
local m_ctList = {}
local m_opList = {}
local m_chipItems = {}
local m_exchangeInfo
local m_inPreheat = false
local m_isLastDay = false
local m_dungeonList = {}

function Start()
  m_dungeonList = DU.GetActorChipList()
  REF.TogglesChips.gameObject:SetActive(false)
  this:Bind("fci/chipexchange/", ChipExchangeCallBack)
  local data = DB:GetData("fci/chipexchange/")
  if data == nil then
    this:GameRequest("fci/chipexchange/"):Get(function(resp)
      this:SetData("fci/chipexchange/", resp)
    end)
  end
  WU.BindButtonEvent(REF.ButtonHelp, function()
    WU.AcquireWindowAsync("RuleWelfare")
  end)
  this:RegisterGameEvent("RefreshChipExchangeDungeon", CustomizeDungeonList)
end

function OnEnable()
  SetBtnCallBack(m_timesLeft)
  SetOptionalList()
  CustomizeDungeonList()
end

function ChipExchangeCallBack(resp)
  if resp == nil then
    return
  end
  m_exchangeInfo = resp
  m_timesLeft = PB.all("Misc")[1].chipExchangeMaxModifyCount - resp.modifyCount
  SetBtnCallBack(m_timesLeft)
  SetChipsCustom(resp)
  CustomizeDungeonList()
end

function SetBtnCallBack(timeLeft)
  if timeLeft == nil then
    return
  end
  REF.Btn.UISprite.graify = false
  m_activityManager.GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity == nil then
      return
    end
    m_ac = activity[1]
    REF.Btn.UISprite.graify = false
    m_inPreheat = ACU.GetStatus(m_ac) == PB.enum.ActivityStatus.PreHeat
    m_isLastDay = CS.GameTime.UtcToLocal(m_ac.timestampEnd):AddDays(-1).Date == CS.GameTime.serverNow.Date or CS.GameTime.UtcToLocal(m_ac.timestampEnd).Date == CS.GameTime.serverNow.Date
    local hourNow = CS.GameTime.UtcToLocal(CS.GameTime.serverUtc).Hour
    local in4to6 = 4 <= hourNow and hourNow < 6
    if m_inPreheat then
      REF.LabelBtn.UIHtmlLabel.text = WU.GetString("Window_Preview")
      REF.Btn.UISprite.spriteName = "blue_button_01"
      REF.Btn.UIButton.normalSprite = "blue_button_01"
    else
      REF.LabelBtn.UIHtmlLabel.text = WU.GetString("Window_ActorChipExchange") .. " " .. timeLeft .. "/" .. PB.all("Misc")[1].chipExchangeMaxModifyCount
      REF.Btn.UISprite.spriteName = "yellow_button_fight"
      REF.Btn.UIButton.normalSprite = "yellow_button_fight"
    end
    if m_isLastDay then
      ManageBtnFunc(true, "Window_ActorChipExchangeDisable", nil)
    elseif in4to6 then
      ManageBtnFunc(true, "Window_CannotSetIn4To6", nil)
    elseif timeLeft <= 0 then
      ManageBtnFunc(true, "Window_NoTimeForChipExchange", function()
        WU.AcquireWindowAsync("ActorChipExchangeCustom", function(w)
          _ENV["$"](w)["$$SetDesc"](m_inPreheat)
        end)
      end)
    else
      ManageBtnFunc(false, nil, function()
        WU.AcquireWindowAsync("ActorChipExchangeCustom", function(w)
          _ENV["$"](w)["$$SetDesc"](m_inPreheat)
        end)
      end)
    end
  end)
end

function ManageBtnFunc(graify, textKey, func)
  REF.Btn.UISprite.graify = graify
  if textKey then
    REF.LabelBtn.UIHtmlLabel.text = WU.GetString(textKey)
  end
  m_btnCallBack = func
  WU.ClearButtonEvent(REF.Btn)
  WU.BindButtonEvent(REF.Btn, m_btnCallBack)
end

function SetChipsCustom(chips)
  this:SetData("ActorChipExchange/CustomChipList", chips.settlePosInfo)
  if ACU.GetStatus(m_ac) == PB.enum.ActivityStatus.Started then
    m_ctList = chips.exchangePosInfo
  end
  WU.TraverseChildren(REF.TogglesChips, function(go, index)
    local gasket = _ENV["$"](go).root
    if m_ctList and m_ctList[index + 1] then
      SetChipTexture(gasket, m_ctList[index + 1])
    else
      SetChipTexture(gasket, m_opList[index + 1])
    end
    gasket.index = index + 1
    if not m_setBtnB4 then
      WU.BindButtonEvent(gasket.UIButton, function()
        GotoExchangeCustom(index + 1)
      end)
    end
  end)
  m_setBtnB4 = true
  REF.TogglesChips.gameObject:SetActive(true)
end

function SetChipTexture(gasket, id)
  gasket.UITexture.mainTexturePath = "Texture/ActorChipIcon/ResItem_" .. id
end

function SetOptionalList()
  local opList = {}
  local actors = this:GetData("fci/actor/")
  m_opList = PB.index("Misc", 1).chipExchangeSet
  for i = 1, #m_opList do
    local this_id = m_opList[i]
    local this_cul = 0
    local this_actor, this_actorId
    local this_owe = false
    local roleId = AU.GetRoleIdByChipId(this_id)
    local actorList = {}
    for k, v in pairs(actors) do
      if v.role == roleId then
        table.insert(actorList, v)
      end
    end
    if 1 <= #actorList then
      table.sort(actorList, function(a, b)
        return AU.GetActorCultivationDegree(a) > AU.GetActorCultivationDegree(b)
      end)
      this_actor = actorList[1]
      this_cul = AU.GetActorCultivationDegree(this_actor)
      this_owe = true
      this_actorId = this_actor.id
    end
    local this_count = this:GetData("fci/item/" .. this_id).count
    table.insert(opList, {
      id = this_id,
      type = PB.enum.ResourceType.ResItem,
      cultivation = this_cul,
      owe = this_owe,
      actorId = this_actorId,
      count = this_count
    })
  end
  local listNoOrder = _ENV["!"]({})
  _ENV["!"](opList):copy(listNoOrder)
  this:SetData("ActorChipExchange/OptionalChipListNoOrder", listNoOrder)
  table.sort(opList, function(a, b)
    if a.owe == false and b.owe then
      return false
    elseif a.owe and b.owe == false then
      return true
    elseif a.owe and b.owe then
      return a.cultivation > b.cultivation
    end
  end)
  this:SetData("ActorChipExchange/OptionalChipList", opList)
  return opList
end

function CustomizeDungeonList()
  for k, v in pairs(m_dungeonList) do
    local reward = PB.get("DungeonReward", v.dungeonId)
    local allChapter = PB.all("ChapterInfo")
    local chapter
    for key, val in pairs(allChapter) do
      local _, id = table.find(val.dungeonId, function(_k, _v)
        return _v == v.dungeonId
      end)
      if id ~= nil then
        chapter = val
        break
      end
    end
    v.maxTimes = reward.enterTimes
    v.restTimes = reward.enterTimes
    local recordInfo
    if chapter then
      recordInfo = this:GetData("fci/dungeon/chapter/" .. chapter.chapterId)
    end
    if recordInfo then
      local record = recordInfo.recordDungeons[v.dungeonId]
      if record then
        v.restTimes = math.max(0, reward.enterTimes - record.doneTimes)
      end
    end
    for _k, _v in pairs(reward.dropDisplay) do
      if _v.id then
        local info = PB.get("ItemInfo", _v.id)
        if info and info.funcType == PB.enum.ItemType.ActorChip then
          v.drop = _v
        end
      end
    end
  end
  this:SetData("ActorChipExchange/DungeonList", m_dungeonList)
end

function GotoExchangeCustom(index)
  if #m_exchangeInfo.settlePosInfo <= 0 then
    if not m_isLastDay then
      WU.ShowMessageOK(WU.GetString("Window_SetChipFirst"))
    else
      WU.ShowMessageOK(WU.GetString("Window_WaitNextChip"))
    end
  elseif m_inPreheat then
    WU.ShowMessageOK(WU.GetString("Window_WaitForActorChipOpen"))
  elseif 0 >= #m_exchangeInfo.exchangePosInfo then
    WU.ShowMessageOK(WU.GetString("Window_WaitChip"))
  else
    WU.AcquireWindowAsync("ActorChipDungeon", function(ui)
      _ENV["$"](ui)["$$SetContent"](index)
    end)
  end
end
