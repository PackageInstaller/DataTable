local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_slotLimit = PB.all("CostumeInfo"):last().maxCount
local rowCount = (m_slotLimit + 1) // 2

function SetupWindow()
  LU.Bind(REF.WrapContentMatch, {
    updateRow = UpdateMatchSlot
  })
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
end

function InitWindow()
  LU.Set(REF.WrapContentMatch, rowCount)
  this:RegisterGameEvent("EventLoadEquipMatch", OnEventLoadEquipMatch)
  this:RegisterGameEvent("EventSaveEquipMatch", OnEventSaveEquipMatch)
end

function UpdateMatchSlot(slotRef, wrapIndex, rowIndex)
  if rowIndex and rowIndex < rowCount then
    local leftIndex = rowIndex * 2 + 1
    slotRef["$"][0]["$$BindMatchIndex"](leftIndex)
    local rightIndex = rowIndex * 2 + 2
    WU.SetActive(slotRef["$"], rightIndex <= m_slotLimit)
    if rightIndex <= m_slotLimit then
      slotRef["$"][1]["$$BindMatchIndex"](rowIndex * 2 + 2)
    end
  end
end

function OnCloseClick()
  WU.RecycleWindow(this)
end

function OnEventLoadEquipMatch(matchIndex)
  local currentActor = this:GetData("ActorInfo/CurrentActor")
  if currentActor then
    local availableEquipCount = 0
    local moveEquipBetweenActor = false
    local match = this:GetData("Equip/Match/" .. matchIndex)
    for _, equipUid in pairs(match.matchEquipUids) do
      local equip = this:GetData("fci/equip/" .. equipUid)
      if equip and equip.requireLevel <= currentActor.level then
        availableEquipCount = availableEquipCount + 1
        if equip.actorUid ~= 0 and equip.actorUid ~= currentActor.uid then
          moveEquipBetweenActor = true
        end
      end
    end
    if 0 < availableEquipCount then
      if moveEquipBetweenActor then
        WU.ShowMessageYesNo(WU.GetString("WindowActorEquip_MoveEquipBetweenActors"), function(result)
          if result == "YES" then
            LoadEquipMatchImpl(currentActor.uid, matchIndex)
          end
        end)
      else
        LoadEquipMatchImpl(currentActor.uid, matchIndex)
      end
    else
      WU.ShowHintText(WU.GetString("WindowActorEquip_LoadLevelLimit"))
    end
  end
end

function LoadEquipMatchImpl(actorUid, matchIndex)
  local param = {actorUid = actorUid, matchIndex = matchIndex}
  this:GameRequest("fci/equip/apply-match"):Post(param, function(result)
    DBH.UpdateEquips(result.changeEquips)
    DBH.UpdateActors(result.changeActors)
    WU.RecycleWindow(this)
  end)
end

function OnEventSaveEquipMatch(matchIndex)
  local currentActor = this:GetData("ActorInfo/CurrentActor")
  if currentActor then
    local equipUids = _ENV["!"](currentActor.bodyEquips):values()
    local moveEquipBetweenMatch = false
    for _, equipUid in pairs(equipUids) do
      local equip = this:GetData("fci/equip/" .. equipUid)
      if equip.matchIndex and equip.matchIndex ~= 0 and equip.matchIndex ~= matchIndex then
        moveEquipBetweenMatch = true
        break
      end
    end
    if moveEquipBetweenMatch then
      WU.ShowMessageYesNo(WU.GetString("WindowActorEquip_MoveEquipBetweenMatch"), function(result)
        if result == "YES" then
          SaveEquipMatchImpl(equipUids, matchIndex)
        end
      end)
    else
      SaveEquipMatchImpl(equipUids, matchIndex)
    end
  end
end

function SaveEquipMatchImpl(equipUids, matchIndex)
  local param = {equipUids = equipUids, matchIndex = matchIndex}
  this:GameRequest("fci/equip/custom-match"):Post(param, function(result)
    DBH.UpdateEquips(result.changeEquips)
    for index, match in pairs(result.equipCustomMatch) do
      this:SetData("Equip/Match/" .. index, match)
    end
    WU.ShowHintText(WU.GetString("WindowActorEquip_MatchSaved"))
    WU.RecycleWindow(this)
  end)
end
