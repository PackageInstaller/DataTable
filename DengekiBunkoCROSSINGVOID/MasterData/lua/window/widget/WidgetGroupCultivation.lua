local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")

function Start()
  REF.LabelCultivation.UIHtmlLabel.text = ""
end

function SetGroupMembers(members, ratios)
  local totalDegree = 0
  if ratios and ratios ~= 1 then
    totalDegree = ReCalculateCultivationDegree(members, ratios)
  else
    for _, member in pairs(members) do
      if member.isNpc then
        local actor = PB.get("DungeonNPC", member.npcId)
        if actor then
          AU.RenameDungeonNPCFields(actor)
          totalDegree = totalDegree + AU.GetActorCultivationDegree(actor)
        end
      elseif 0 < member.actorUid and this:GetData("fci/actor/" .. member.actorUid) then
        if this:GetData("fci/actor/" .. member.actorUid).cultivationTotal then
          totalDegree = totalDegree + this:GetData("fci/actor/" .. member.actorUid).cultivationTotal
        else
          warning("WidgetGroupCultivation", "actorUid -> " .. member.actorUid .. " cultivationTotal is nil?")
        end
      end
    end
  end
  REF.LabelCultivation.UIHtmlLabel.text = totalDegree
end

function ReCalculateCultivationDegree(members, ratios)
  local degree = 0
  for i = 1, 6 do
    local member = members[i]
    if member.actorUid ~= 0 then
      local ratio = ratios[member.index]
      degree = degree + AU.GetActorCultivationDegree(this:GetData("fci/actor/" .. member.actorUid), ratio)
    end
  end
  return degree
end

function SetDungeonGuildGroupMembers(members)
  local totalDegree = 0
  for _, member in pairs(members) do
    if not member.isGuildActor then
      if 0 < member.actorUid and this:GetData("fci/actor/" .. member.actorUid) then
        totalDegree = totalDegree + this:GetData("fci/actor/" .. member.actorUid).cultivationTotal
      end
    elseif 0 < member.actorGuildUid then
      local rentActors = DB:GetData("DungeonGuild/RentActors") or _ENV["!"]({})
      local _, v = table.find(rentActors, function(k1, v1)
        return v1.uid == member.actorGuildUid
      end)
      local memberInfo = v
      if memberInfo then
        totalDegree = totalDegree + (memberInfo.cultivationTotal or 0)
      end
    end
  end
  REF.LabelCultivation.UIHtmlLabel.text = totalDegree
end
