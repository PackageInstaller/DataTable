local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_allMedals, m_medalList, m_baseInfo, m_medalListNotFight, m_isMySelfSpace, m_selfPlayerId

function Awake()
  m_allMedals = PB.all("MedalInfo"):select(function(m)
    return {
      id = m.id,
      category = m.category,
      order = m.order,
      hide = m.hide,
      quality = m.quality
    }
  end)
  table.sort(m_allMedals, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  m_selfPlayerId = this:GetData("playerId")
end

function Start()
end

function OnEnable()
end

function OnDestroy()
end

function OnDisable()
end

function OnListChange(list, fightMedalId)
  if list == nil then
    return
  end
  WU.ToggleRendering(REF.WrapContent, true)
  m_medalList = {}
  m_medalListNotFight = {}
  local isPreCommit = WU.IsPreCommit()
  for _, m in pairs(m_allMedals) do
    local _, obtainedMedal = table.find(list, function(k, v)
      return v == m.id
    end)
    if obtainedMedal then
      m.obtained = true
      local hideSpecial = false
      hideSpecial = m.id == 80005
      if m.obtained and not hideSpecial then
        if m_medalList == nil then
          m_medalList = {}
          m_medalListNotFight = {}
        end
        if isPreCommit then
          if m.category ~= 4 then
            if m.id ~= fightMedalId then
              table.insert(m_medalListNotFight, m)
            else
              table.insert(m_medalList, m)
            end
          end
        elseif m.id ~= fightMedalId then
          table.insert(m_medalListNotFight, m)
        else
          table.insert(m_medalList, m)
        end
      end
    end
  end
  table.sort(m_medalListNotFight, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  for i = 1, #m_medalListNotFight do
    table.insert(m_medalList, m_medalListNotFight[i])
  end
end

function SetMedals(fightMedalId)
  SetMedal(REF.WidgetIconSlotFight, fightMedalId, nil, true)
  REF.SpriteSlotFightBG.gameObject:SetActive(true)
  for i = 1, #REF.NodeMedalsGrid do
    local medalId
    if m_medalListNotFight[i] and m_medalListNotFight[i].id then
      medalId = m_medalListNotFight[i].id
    end
    SetMedal(REF.NodeMedalsGrid[i - 1].WidgetIconSlotShow, medalId, nil, false)
    REF.NodeMedalsGrid[i - 1].SpriteSlotBG.gameObject:SetActive(true)
  end
end

function SetMedal(medalRef, medalId, pos, isFight)
  local hasMedal = medalId ~= nil and medalId ~= 0
  medalRef.gameObject:SetActive(hasMedal)
  if hasMedal then
    medalRef["$SetData"](PB.enum.ResourceType.ResMedal, medalId)
    medalRef["$ShowCustom"]({name = false})
  else
    medalRef["$SetEmpty"](1)
  end
  medalRef["$SetClickCallback"](function()
    if m_isMySelfSpace and isFight then
      this:SetData("SelectedMedal", {id = medalId, pos = pos})
      WU.AcquireWindowAsync("MedalSelection")
    elseif hasMedal then
      WU.ShowMedalDetail(medalId, false)
    end
  end)
end

function SetData(list, fightMedalId)
  OnListChange(list, fightMedalId)
  SetMedals(fightMedalId)
end
