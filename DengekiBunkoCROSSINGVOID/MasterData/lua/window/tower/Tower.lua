local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local IU = require("Common/ItemUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_summary, m_drops, m_hasMoreFloor
local m_hasValidGroup = true

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonStory, function()
  end)
  WU.BindButtonEvent(REF.ButtonPrepare, OnPrepareClick)
  WU.BindButtonEvent(REF.ButtonFreeWipe, function()
    DoWipe(this:GetData("fci/tower/summary/").wipeFloorFree)
  end)
  WU.BindButtonEvent(REF.ButtonPaidWipe, OnPaidWipeClick)
  WU.BindButtonEvent(REF.ButtonScoreAward, OnScoreAwardClick)
end

function InitWindow()
  REF.Content.gameObject:SetActive(false)
  this:SetData("fci/tower/summary/", nil)
  this:BindRemote(DB:GameRequest("fci/tower/summary/"), OnTowerSummary)
  LU.Bind(REF.WrapContent, {
    updateRow = OnDropItemShow
  })
end

function OnPrepareClick()
  if not m_hasValidGroup then
    WU.ShowHintText(WU.GetString("WindowTower_ActivityOver"))
    return
  end
  if m_summary.selectActorGroupId == 0 then
    this:GameRequest("fci/SelectedGroupId/tower"):Patch({selectActorGroupId = 1}, function(response)
      this:SetData("fci/SelectedGroupId/tower", response)
      m_summary.selectActorGroupId = response.selectActorGroupId
      WU.AcquireWindowAsync("TowerActorSelect")
    end)
  else
    WU.AcquireWindowAsync("TowerActorGroup")
  end
end

function OnTowerSummary(result)
  if result == nil then
    return
  end
  REF.Content.gameObject:SetActive(true)
  m_summary = result
  if m_summary.locked then
    this:BindRemote(DB:GameRequest("fci/tower/actorgroup-confirm/"), OnActorGroupChange)
  end
  REF.ScoreAwardEffect.gameObject:SetActive(DU.IsTowerAwardCanGet(m_summary))
  REF.SpriteRed.gameObject:SetActive(DU.IsTowerAwardCanGet(m_summary))
  local recordText = WU.GetString("WindowTower_NoRecord")
  if m_summary.towerFloorRecord ~= 0 then
    recordText = WU.GetString("WindowTower_FloorNumber", m_summary.towerFloorRecord)
  end
  REF.LabelRecord.UILabel.text = recordText
  SetDungeonInfo()
end

function OnActorGroupChange(groups)
  if groups == nil then
    return
  end
  m_hasValidGroup = false
  for groupId = 1, _ENV["!"](groups):count() do
    local members = groups[tostring(groupId)].members
    local OK = GU.GroupIsOK(members)
    if OK then
      local _, member = _ENV["!"](members):find(function(k, v)
        return not v.dead
      end)
      if member ~= nil then
        m_hasValidGroup = true
        return
      end
    end
  end
end

function OnPaidWipeClick()
  local cost = PB.get("TowerFloor", m_summary.wipeFloorPay).wipeCost
  WU.TryToPayResource(cost, function()
    DoWipe(m_summary.wipeFloorPay)
  end)
end

function DoWipe(floor)
  this:GameRequest("fci/tower/wipe/"):Post({wipeToFloor = floor}, function(result)
    DBH.ResChange(result.resChange)
    m_summary.towerFloor = result.towerFloor
    SetDungeonInfo()
    WU.ShowRewards(result.resChange)
  end)
end

function OnScoreAwardClick()
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("Tower", {
      playerRecord = m_summary.towerFloorRecord
    })
  end)
end

function OnDropItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_drops == nil or realIndex >= #m_drops then
    return
  end
  local award = m_drops[realIndex + 1]
  rowRef.root["$SetData"](award.type, award.id, award.count)
  rowRef.root["$SetClickCallback"](function()
    WU.ShowResourceDetail(award.type, award.id)
  end)
end

function SetDungeonInfo()
  local allFloor = PB.all("TowerFloor")
  local maxFloor = allFloor[#allFloor].floor
  local canWipe = m_summary.wipeFloorFree ~= 0 and m_summary.towerFloor == 0
  m_hasMoreFloor = maxFloor >= m_summary.towerFloor
  local floorValid = not canWipe and m_hasMoreFloor
  REF.TopFloor.gameObject:SetActive(not m_hasMoreFloor)
  REF.Drops.gameObject:SetActive(floorValid)
  REF.Opponents.gameObject:SetActive(floorValid)
  REF.AffixWidget.gameObject:SetActive(floorValid)
  if floorValid then
    local floor = m_summary.towerFloor
    if floor == 0 then
      floor = 1
    end
    SetDrops(floor)
    SetOpponents(floor)
  end
  REF.Fight.gameObject:SetActive(m_hasMoreFloor)
  if m_hasMoreFloor then
    SetPrepareButtonInfo(canWipe)
    SetWipeInfo(canWipe)
  end
end

function SetPrepareButtonInfo(canWipe)
  REF.ButtonPrepare.gameObject:SetActive(not canWipe)
  local showPrepare = m_summary.towerFloor == 0
  REF.LabelPrepare.gameObject:SetActive(showPrepare)
  REF.LabelContinue.gameObject:SetActive(not showPrepare)
  if not showPrepare then
    REF.LabelCurrentFloor.UILabel.text = WU.GetString("WindowTower_CurrentFloor", m_summary.towerFloor)
  end
end

function SetWipeInfo(canWipe)
  REF.Wipe.gameObject:SetActive(canWipe)
  if canWipe then
    REF.LabelFreeFloor.UILabel.text = WU.GetString("WindowTower_ToFloor", m_summary.wipeFloorFree)
    REF.ButtonPaidWipe.gameObject:SetActive(m_summary.wipeFloorPay ~= 0)
    if m_summary.wipeFloorPay ~= 0 then
      REF.LabelPaidFloor.UILabel.text = WU.GetString("WindowTower_ToFloor", m_summary.wipeFloorPay)
      local cost = PB.get("TowerFloor", m_summary.wipeFloorPay).wipeCost
      REF.LabelWipeCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  end
end

function SetDrops(floor)
  local dungeonId = PB.get("TowerFloor", floor).dungeonId
  m_drops = PB.get("DungeonReward", dungeonId).dropDisplay
  LU.Set(REF.WrapContent, math.ceil(#m_drops))
end

function SetOpponents(floor)
  local dungeonId = PB.get("TowerFloor", floor).dungeonId
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  if dungeonMonster == nil then
    error("Tower", "no dungeonId " .. dungeonId .. " in DungeonMonster! ")
    return
  end
  local actors = GU.MonsterGroup(dungeonMonster.monsterId)
  REF.WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
  REF.AffixWidget["$ShowAffixWidget"](dungeonId)
end
