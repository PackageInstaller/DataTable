local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local TU = require("Common/TextUtil")
local LU = require("Common/ListUtil")
local m_actor, m_links

function Awake()
  LU.Bind(REF.RelationContent, {
    updateRow = UpdateSlot
  })
  REF.RelationList.gameObject:SetActive(false)
end

function OnEnable()
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    local activeLinks = {
      AU.GetActorLinks(actor, this:GetData("fci/actor/"))
    }
    m_links = activeLinks[2]
    local linkCount = #m_links
    REF.NodeEmpty.gameObject:SetActive(linkCount == 0)
    REF.RelationList.gameObject:SetActive(0 < linkCount)
    LU.Set(REF.RelationContent, linkCount)
  end
end

function UpdateSlot(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil then
    local itemIndex = realIndex + 1
    if m_links and itemIndex <= #m_links then
      local slotRef = rowRef["$"][0]
      slotRef["$$SetData"](m_links[itemIndex], m_actor)
    end
  end
end
