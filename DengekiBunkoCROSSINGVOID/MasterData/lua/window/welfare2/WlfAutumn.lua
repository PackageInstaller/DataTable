local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local ATU = require("Common/AutumnUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_taskRedMark

function Start()
  WU.BindButtonEvent(REF.ButtonGacha, OnButtonGacha)
  WU.BindButtonEvent(REF.ButtonExchange, OnButtonExchange)
  WU.BindButtonEvent(REF.ButtonAutumnStage, OnButtonAutumnStage)
end

function OnEnable()
  RU.BindRedMark(this, "Welfare/Autumn/Dungeon", function(flag)
    REF.SpriteRedAutumnTask.gameObject:SetActive(flag)
  end)
end

function OnDisable()
  RU.UnbindRedMark(this, "Welfare/Autumn/Dungeon")
end

function OnButtonGacha()
  WU.AcquireWindowAsync("GachaEventAutumn")
end

function OnButtonExchange()
  WU.AcquireWindowAsync("EventAutumnExchange")
end

function OnButtonAutumnStage()
  local isOpenOnlyShop = false
  m_activityManager.GetActivityByType(PB.enum.ActivityType.EventDungeon_Autumn2018, function(acList)
    if acList then
      for i = 1, #acList do
        if ACU.IsOpenForDoing(acList[i], true) then
          if acList[i].category == 1 then
            isOpenOnlyShop = false
            break
          else
            isOpenOnlyShop = true
          end
        end
      end
      if isOpenOnlyShop then
        WU.ShowHintText(WU.GetString("Window_Activity_Close"))
      elseif not WU.WindowIsLocked(WU.ActivityTypeToUnlockWindowType(PB.enum.ActivityType.EventDungeon_Autumn2018), PB.enum.UnlockWindow.EventDungeon_Autumn2018) then
        WU.AcquireWindowAsync("Activity")
      end
    else
      WU.ShowHintText(WU.GetString("Window_Activity_Close"))
    end
  end)
end
