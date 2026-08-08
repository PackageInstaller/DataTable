local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local m_allList = {}
local m_hollowList, m_notHasHollowList, m_mazeActivityId

function Awake()
  m_allList = PB.all("MazeEquipmentInfo")
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_hollowList and m_hollowList[dataIndex]
    end,
    updateSlot = OnRelicItemShow
  })
end

function OnEnable()
  REF.NodeEmpty.gameObject:SetActive(false)
  this:DelayInvokeInFrames(1, function()
    this:Bind("fci/mazeHollow/", OnRefreshHollows)
  end)
end

function OnRelicItemShow(ref, data)
  if data ~= nil then
    ref["$$SetData"](PB.enum.ResourceType.ResMazeHollow, data.id)
    ref["$$SetClickCallback"](function()
      WU.ShowResourceDetail(PB.enum.ResourceType.ResMazeHollow, data.id)
    end)
  else
    ref["$$ClearSlot"]()
  end
end

function OnRefreshHollows(result)
  m_hollowList = {}
  if result then
    for k, v in pairs(result) do
      if v.count > 0 then
        table.insert(m_hollowList, v)
      end
    end
    REF.NodeEmpty.gameObject:SetActive(#m_hollowList <= 0)
    local row = #REF.WrapContent[0]["$"]
    LU.Set(REF.WrapContent, math.ceil(#m_hollowList / row))
    REF.ScrollView.gameObject:SetActive(true)
  else
    REF.NodeEmpty.gameObject:SetActive(true)
    return
  end
end
