local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_allList = {}
local m_abilityList, m_mazeActivityId

function Awake()
  for i = 1, #REF.NodeList do
    WU.BindButtonEvent(REF.NodeList[i - 1]["$"], function()
      WU.AcquireWindowAsync("MazeHintItem", function(window)
        _ENV["$"](window)["$$SetAbility"](m_abilityList[i])
      end)
    end)
  end
  local allList = PB.all("MazeAbilityResearch")
  table.copy(allList, m_allList, true)
end

function OnEnable()
  m_mazeActivityId = this:GetData("MazeActivityId")
  this:BindRemote(DB:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"), OnRefreshData)
end

function OnDisable()
  this:Unbind("fci/Maze/Research/" .. m_mazeActivityId .. "/", OnRefreshData)
end

function OnRefreshData(result)
  if result and result.researchAbility then
    OnRefreshResearchAbility(result.researchAbility)
  end
end

function OnRefreshResearchAbility(result)
  m_abilityList = {}
  for i = 1, #m_allList do
    local index = table.find(m_abilityList, function(k, v)
      return v.type == m_allList[i].type
    end)
    if index == nil then
      table.insert(m_abilityList, m_allList[i])
    end
  end
  for i = 1, #m_abilityList do
    if result[m_abilityList[i].type] then
      m_abilityList[i].progress = result[m_abilityList[i].type]
    else
      m_abilityList[i].progress = 0
    end
  end
  for i = 1, #REF.NodeList - 1 do
    if m_abilityList[i] then
      local isUnlocked = m_abilityList[i].progress >= 0
      REF.NodeList[i - 1].LabelProgress.gameObject:SetActive(isUnlocked)
      REF.NodeList[i - 1].LabelLock.gameObject:SetActive(not isUnlocked)
      REF.NodeList[i - 1].Mask.gameObject:SetActive(not isUnlocked)
      REF.NodeList[i - 1].LabelProgress.UILabel.text = "Lv." .. m_abilityList[i].progress
      REF.NodeList[i - 1].root.gameObject:SetActive(true)
    else
      REF.NodeList[i - 1].root.gameObject:SetActive(false)
    end
  end
end
