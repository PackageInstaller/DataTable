local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local DORM_MAX_FLOOR_LEVEL = math.max(table.unpack(PB.all("DormFloorConfig"):select(function(v)
  return v.level
end)))
local m_floor, m_dormInfo, m_f2level

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFloor1, function()
    OnClickFloor(1)
  end)
  WU.BindButtonEvent(REF.ButtonFloor2, function()
    OnClickFloor(2)
  end)
end

function InitWindow()
  local inVisitMode = this:GetData("Dorm/InVisitMode")
  if inVisitMode then
    m_dormInfo = this:GetData("Dorm/Host").dormInfo
  else
    m_dormInfo = this:GetData("fci/dorm/{playerId}").dormInfo
  end
  m_floor = this:GetData("Dorm/CurrentFloor")
  REF.ButtonFloor1.UISprite.spriteName = fif(m_floor == 1, "floor_on", "floor_off")
  REF.ButtonFloor2.UISprite.spriteName = fif(m_floor == 2, "floor_on", "floor_off")
  WU.SetActive(REF.NodeCurrent1, m_floor == 1)
  WU.SetActive(REF.NodeCurrent2, m_floor == 2)
  WU.SetActive(REF.NodeLockedHint, false)
  WU.SetActive(REF.NodeBuyHint, false)
  local config = PB.get("DormConfig", m_dormInfo.dormLevel)
  m_f2level = config.floorLevel[2]
  REF.ButtonFloor2.UISprite.color = CS.NGUIMath.HexToColor(fif(m_f2level == 0, 995593088, 4294967295))
  if inVisitMode then
    WU.SetActive(REF.SpriteCost, false)
  else
    WU.SetActive(REF.SpriteCost, m_f2level == 0)
    if m_f2level == 0 then
      local f1Level = config.floorLevel[1]
      if f1Level < DORM_MAX_FLOOR_LEVEL then
        WU.SetActive(REF.NodeLockedHint, true)
      else
        WU.SetActive(REF.NodeBuyHint, true)
      end
      local config = PB.get("DormExtensionCost", PB.enum.DormExtensionType.Floor, DORM_MAX_FLOOR_LEVEL + 1)
      local cost = config.cost[1]
      REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  end
end

function OnClickFloor(floor)
  if floor ~= m_floor then
    if this:GetData("Dorm/InVisitMode") then
      if floor == 2 and m_f2level == 0 then
        WU.ShowHintText(WU.GetString("Dorm_HostFloor2Locked"))
      else
        this:SetData("Dorm/CurrentFloor", floor)
        WU.RecycleWindow(this)
      end
    else
      local config = PB.get("DormConfig", m_dormInfo.dormLevel)
      local nextConfig = PB.get("DormConfig", m_dormInfo.dormLevel + 1)
      local floorLevel = config.floorLevel[floor]
      if floorLevel == 0 and nextConfig and nextConfig.floorLevel[floor] == 1 then
        DU.ShowExtendFloorMessage(function()
          WU.RecycleWindow(this)
        end)
      elseif 0 < floorLevel then
        this:SetData("Dorm/CurrentFloor", floor)
        WU.RecycleWindow(this)
      else
        WU.ShowHintText(WU.GetString("Dorm_FloorLocked"))
      end
    end
  end
end
