local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local RU = require("Common/RedMarkUtil")
local PU = require("Common/PlatformUtil")
local DU = require("Common/DungeonUtil")
local m_activityManager = S:Get("ActivityManager")
local Msdk = CS.Msdk
local m_welfareOpened = {}
local m_defaultWlfName = "Checkin"
local m_repeatedContext = {}
local m_wlfTab, m_cacheMusic, m_lastRedMarkIndex
local m_cellHeigght = REF.TabGrid.UIGrid.cellHeight
local m_scrollViewInitY = REF.ScrollViewTab.UIPanel.finalClipRegion.w / 2

function SetupWindow()
  local welfareConfigs = PB.all("WelfareConfig")
  for _, config in ipairs(welfareConfigs) do
    InstantiateTabSlotPrefab(config.name)
  end
  WU.HandleGameObjectAttached(REF.root.gameObject)
  REF.TabGrid.UIGrid:Reposition()
  WU.BindButtonEvent(REF.ButtonNext, OnButtonNext)
  REF.ScrollViewTab.UIPanel:AddOnClipMoveListener(OnScrollViewMove)
end

function InitWindow()
  m_cacheMusic = CS.SoundManager.Instance:GetCurrentMusic()
  this:RegisterGameEvent("WelfareTabClicked", OnClickTab)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChange)
  local welfareConfigs = PB.all("WelfareConfig")
  for _, config in ipairs(welfareConfigs) do
    local initFunc = rawget(_ENV, "InitWlf" .. config.name)
    local acStatusMap = GetAcStatusMap(config.name)
    if initFunc then
      initFunc(acStatusMap)
    elseif config.relatedActivityType ~= 0 then
      DefaultInit(config.name, acStatusMap)
    end
  end
  this:Bind("WelfareTab", OnWlfTabChanage)
  REF.TabGrid.UIPlayTween:Play(true)
  OnScrollViewMove()
end

function UninitWindow()
  DeactiveTabs()
  this:SetData("WelfareTab", nil)
  m_wlfTab = nil
  local curMusic = CS.SoundManager.Instance:GetCurrentMusic()
  if curMusic ~= m_cacheMusic then
    CS.SoundManager.Instance:PlayMusic(m_cacheMusic)
  end
end

function SaveContext()
  table.insert(m_repeatedContext, {wlfTab = m_wlfTab})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("WelfareTab", context.wlfTab)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnWlfTabChanage(wlfName)
  if wlfName then
    if not m_welfareOpened[wlfName] then
      wlfName = m_defaultWlfName
    end
    ActiveTab(wlfName)
    local config = PB.get("WelfareConfig", wlfName)
    this:SetData("WelfareHelpTab", fif(config.helpTabName == "", wlfName, config.helpTabName))
    if config.music ~= "" then
      CS.SoundManager.Instance:PlayMusic(config.music)
    else
      local curMusic = CS.SoundManager.Instance:GetCurrentMusic()
      if curMusic ~= m_cacheMusic then
        CS.SoundManager.Instance:PlayMusic(m_cacheMusic)
      end
    end
  end
end

function OnClickTab(wlfName)
  local onClickFunc = rawget(_ENV, "OnClickWlf" .. wlfName)
  if onClickFunc then
    onClickFunc()
  end
  this:SetData("WelfareTab", wlfName)
end

function DeactiveTabs()
  for i = 0, #REF.TabGrid - 1 do
    REF.TabGrid[i]["$$SetSelected"](false)
  end
  for i = 0, #REF.Contents - 1 do
    WU.SetActive(REF.Contents[i].root)
  end
end

function ActiveTab(wlfName)
  if wlfName == m_wlfTab then
    return
  end
  DeactiveTabs()
  REF["TabSlot" .. wlfName]["$SetSelected"](true)
  local refContent = _ENV["$"](REF.root.transform:Find("WindowSize/Contents/" .. GetWlfPrefabName(wlfName))) or _ENV["$"](InstantiateContentPrefab(wlfName))
  WU.SetActive(refContent.root, true)
  refContent["$Animator"]:Play("Page", -1, 0)
  m_wlfTab = wlfName
end

function InstantiateTabSlotPrefab(wlfName)
  local goSlot = WU.InstantiateWindowPrefab(REF.TabGrid, "Welfare/WelfareTabSlot", "TabSlot" .. wlfName)
  _ENV["$"](goSlot)["$$Init"](wlfName)
  return goSlot
end

function InstantiateContentPrefab(wlfName)
  local prefabName = GetWlfPrefabName(wlfName)
  local goContent = WU.InstantiateWindowPrefabAttached(REF.Contents, "Welfare/" .. prefabName, prefabName)
  WU.HandleGameObjectAttached(goContent)
  return goContent
end

function NotifyWelfareStatucChange(wlfName, open)
  m_welfareOpened[wlfName] = open
  WU.SetActive(REF["TabSlot" .. wlfName], open)
  REF.TabGrid.UIGrid:Reposition()
  REF.ScrollViewTab.UIScrollView:ResetPosition()
  if m_wlfTab == wlfName and not open then
    this:SetData("WelfareTab", m_defaultWlfName)
  end
end

function OnActivityStatusChange(category, id, status, type)
  local relatedConfigs = PB.all("WelfareConfig"):where(function(_, v)
    return v.relatedActivityType == type
  end)
  for _, config in pairs(relatedConfigs) do
    local handleFunc = rawget(_ENV, "OnAcChange" .. config.name)
    local acStatusMap = GetAcStatusMap(config.name)
    if handleFunc then
      handleFunc(acStatusMap)
    else
      DefaultOnAcChange(config.name, acStatusMap)
    end
  end
end

function GetAcStatusMap(wlfName)
  local xlsxConfig = PB.get("WelfareConfig", wlfName)
  local acStatusMap = {}
  if xlsxConfig then
    acStatusMap = _ENV["!"](m_activityManager.GetActivitiesStatus(xlsxConfig.relatedActivityType))
    if #xlsxConfig.relatedActivityIds > 0 then
      acStatusMap = _ENV["!"](acStatusMap):where(function(k, v)
        return table.has(xlsxConfig.relatedActivityIds, k)
      end)
    end
  end
  return acStatusMap
end

function DefaultInit(wlfName, acStatusMap)
  DefaultOnAcChange(wlfName, acStatusMap)
end

function DefaultOnAcChange(wlfName, acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  NotifyWelfareStatucChange(wlfName, open)
end

function GetWlfPrefabName(wlfName)
  if wlfName then
    local prefabName = PB.get("WelfareConfig", wlfName).prefabName
    if prefabName == "" then
      return "Wlf" .. wlfName
    else
      return prefabName
    end
  end
end

function OnScrollViewMove()
  local entryBottomHeight = (ActiveTabNum() - 1) * m_cellHeigght
  local scrollViewOffsetY = REF.ScrollViewTab.transform.localPosition.y - m_scrollViewInitY
  local entryOffsetYFromViewTop = entryBottomHeight - scrollViewOffsetY
  local showButton = entryOffsetYFromViewTop > REF.ScrollViewTab.UIPanel.finalClipRegion.w
  WU.SetActive(REF.ButtonNext, showButton)
end

function ActiveTabNum()
  local num = 0
  WU.TraverseChildren(REF.TabGrid, function(g)
    if g.activeInHierarchy then
      num = num + 1
    end
  end)
  return num
end

function OnButtonNext()
  local entryBottomHeight = (NextTabIndex() - 1) * m_cellHeigght
  local newOffsetY = entryBottomHeight - REF.ScrollViewTab.UIPanel.finalClipRegion.w + m_scrollViewInitY
  local offset = CS.UnityEngine.Vector3(0, newOffsetY - REF.ScrollViewTab.transform.localPosition.y, 0)
  REF.ScrollViewTab.UIScrollView:SpringRelative(offset, 20)
end

function NextTabIndex()
  local visibleContentHeight = REF.ScrollViewTab.transform.localPosition.y - m_scrollViewInitY + REF.ScrollViewTab.UIPanel.finalClipRegion.w
  local bottomDataIndex = math.floor(visibleContentHeight / m_cellHeigght) + 1
  local index = 0
  for i = 0, #REF.TabGrid - 1 do
    local g = REF.TabGrid[i].root.gameObject
    if g.activeInHierarchy then
      index = index + 1
      local flag = RU.GetRedMark("Welfare/" .. string.sub(g.name, string.len("TabSlot") + 1))
      if flag and bottomDataIndex < index then
        break
      end
    end
  end
  return index
end

function InitWlfViewNoviceGift()
  local acList = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.NewPlayerSignIn)
  if acList and acList[1] and ACU.IsOpenForDoing(acList[1]) then
    local detail = this:GetData("fci/NewPlayerSignIn/")
    local maxLoginDayNum = #PB.all("NewPlayerSignReward")
    if detail and maxLoginDayNum > detail.rewardDays then
      local endTime = detail.endTime
      if endTime >= CS.GameTime.serverUtc then
        NotifyWelfareStatucChange("ViewNoviceGift", true)
        return
      end
    end
  end
  NotifyWelfareStatucChange("ViewNoviceGift", false)
end

function InitWlfRolePresent()
  local showRolePresent = 9
  local roleList = this:GetData("fci/RoleNotePad/")
  local find = table.find(roleList, function(_, v)
    return v.favourLevel >= showRolePresent
  end)
  NotifyWelfareStatucChange("RolePresent", find)
end

function InitWlfCultivationPvP(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  NotifyWelfareStatucChange("CultivationPvP", open)
  if this:GetData("PopupCultivationPVP") and open then
    this:SetData("WelfareTab", "CultivationPvP")
    this:SetData("PopupCultivationPVP", false)
  end
end

function InitWlfMaidCafe(acStatusMap)
  local activatedId, _ = table.find(acStatusMap, function(k, v)
    return v == PB.enum.ActivityStatus.Started
  end)
  NotifyWelfareStatucChange("MaidCafe", activatedId)
end

function InitWlfAutumn(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  NotifyWelfareStatucChange("Autumn", open)
end

function OnAcChangeWlfMaidCafe(acStatusMap)
  local activatedId, _ = table.find(acStatusMap, function(k, v)
    return v == PB.enum.ActivityStatus.Started
  end)
  NotifyWelfareStatucChange("MaidCafe", activatedId)
end

function InitWlfHalloween(acStatusMap)
  OnAcChangeHalloween(acStatusMap)
end

function InitWlfQuestionReward(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  NotifyWelfareStatucChange("QuestionReward", open)
  if open then
    this:SetData("WelfareTab", "QuestionReward")
  end
end

function InitWlfPringlesGift(Welfare)
  local pringlesGift = this:GetData("fci/WlfPringlesGift")
  if pringlesGift ~= nil and (pringlesGift.rewardTimes == 0 or WU.IsToday(CS.GameTime.UtcToLocal(pringlesGift.rewardTime))) then
    NotifyWelfareStatucChange("PringlesGift", true)
    return
  end
  NotifyWelfareStatucChange("PringlesGift", false)
end

function OnAcChangeHalloween(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("Halloween", open)
end

function InitWlfCoffeePostcard(acStatusMap)
  OnAcChangeCoffeePostcard(acStatusMap)
end

function OnAcChangeCoffeePostcard(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("CoffeePostcard", open)
end

function InitWlfMikuPostcard(acStatusMap)
  OnAcChangeMikuPostcard(acStatusMap)
end

function OnAcChangeMikuPostcard(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("MikuPostcard", open)
end

function InitWlfSwimV2Postcard(acStatusMap)
  OnAcChangeSwimV2Postcard(acStatusMap)
end

function OnAcChangeSwimV2Postcard(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("SwimV2Postcard", open)
end

function InitWlfConditionReward()
  OnAcChangeConditionReward()
end

function OnAcChangeConditionReward()
  NotifyWelfareStatucChange("ConditionReward", this:GetData("shouldActiveCondition"))
end

function InitWlfActorChipExchange(acStatusMap)
  OnAcChangeActorChipExchange(acStatusMap)
end

function OnAcChangeActorChipExchange(acStatusMap)
  NotifyWelfareStatucChange("ActorChipExchange", ShowChipExchangeAble(acStatusMap))
end

function ShowChipExchangeAble(acStatusMap)
  local dungeonUnlock = false
  DU.IsDungeonUnlocked(this:GetData("fci/dungeon/chapter-summary"), 5102, function(unlocked)
    dungeonUnlock = unlocked
  end)
  local acOpen = (table.has(acStatusMap, PB.enum.ActivityStatus.PreHeat) or table.has(acStatusMap, PB.enum.ActivityStatus.Started)) and dungeonUnlock
  return acOpen
end

function InitWlfEveryDayCheckin(acStatusMap)
  local open = false
  for k, v in pairs(acStatusMap) do
    if v == PB.enum.ActivityStatus.Started then
      open = true
      if k == 46001 or k == 46004 then
        _ENV["$"](REF.TabSlotEveryDayCheckin).LabelButton.UILabel.text = WU.GetString("WindowEveryDayCheckin_Name1")
        break
      end
      if k == 46003 then
        _ENV["$"](REF.TabSlotEveryDayCheckin).LabelButton.UILabel.text = WU.GetString("WindowEveryDayCheckin_Name3")
      end
      break
    end
  end
  NotifyWelfareStatucChange("EveryDayCheckin", open)
end

function InitWlfSeal(acStatusMap)
  OnAcChangeSeal(acStatusMap)
end

function OnAcChangeSeal(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("Seal", open)
end

function InitWlfCoupleActorCultivation(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("CoupleActorCultivation", open)
end

function InitWlfHalfYearBack(acStatusMap)
  OnAcChangeHalfYearBack(acStatusMap)
end

function InitWlfNotPlayerBack()
  local unlocked = this:GetData("halfYearNotBackFlag")
  NotifyWelfareStatucChange("NotPlayerBack", unlocked)
end

function OnAcChangeHalfYearBack(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  local unlocked = this:GetData("halfyearbackinactive")
  local isActive = this:GetData("fci/half-year-back-activity/") ~= nil
  NotifyWelfareStatucChange("HalfYearBack", unlocked and isActive and open)
end

function OnAcChangeNotPlayerBack(acStatusMap)
  local open = false
  if table.has(acStatusMap, PB.enum.ActivityStatus.Started) then
    this:SetData("halfYearNotBackFlag", true)
    open = true
  end
  if table.has(acStatusMap, PB.enum.ActivityStatus.Close) then
    this:SetData("halfYearNotBackFlag", false)
    open = false
  end
  NotifyWelfareStatucChange("NotPlayerBack", open)
end

function InitWlfActorCultivation5(acStatusMap)
  OnAcChangeActorCultivation5(acStatusMap)
  local activityId = PB.get("WelfareConfig", "ActorCultivation5").relatedActivityIds[1]
  if this:GetData("PopupActorCultivation") then
    local acId = this:GetData("ActorCultivaton/PopupActivity")
    if acId and acId == activityId then
      this:SetData("WelfareTab", "ActorCultivation5")
      this:SetData("PopupActorCultivation", false)
    end
  end
end

function OnAcChangeActorCultivation5(acStatusMap)
  local actorId = tonumber(PB.get("WelfareConfig", "ActorCultivation5").params[1])
  NotifyWelfareStatucChange("ActorCultivation5", ShowActorCultivationAble(acStatusMap, actorId))
end

function InitWlfActorCultivation6(acStatusMap)
  OnAcChangeActorCultivation6(acStatusMap)
  local activityId = PB.get("WelfareConfig", "ActorCultivation6").relatedActivityIds[1]
  if this:GetData("PopupActorCultivation") then
    local acId = this:GetData("ActorCultivaton/PopupActivity")
    if acId and acId == activityId then
      this:SetData("WelfareTab", "ActorCultivation6")
      this:SetData("PopupActorCultivation", false)
    end
  end
end

function OnAcChangeActorCultivation6(acStatusMap)
  local actorId = tonumber(PB.get("WelfareConfig", "ActorCultivation6").params[1])
  NotifyWelfareStatucChange("ActorCultivation6", ShowActorCultivationAble(acStatusMap, actorId))
end

function ShowActorCultivationAble(acStatusMap, actorId)
  local activityIsOpen = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  local ownActor = false
  local data = this:GetData("fci/actor-cultivation")
  for _, v in pairs(data) do
    if v.actorId == actorId then
      ownActor = true
      break
    end
  end
  return activityIsOpen and ownActor
end

function InitWlfHalfYearBack2(acStatusMap)
  OnAcChangeHalfYearBack2(acStatusMap)
end

function OnAcChangeHalfYearBack2(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  local unlocked = this:GetData("halfyearbackinactive")
  local isActive = this:GetData("fci/half-year-back-activity/") ~= nil
  NotifyWelfareStatucChange("HalfYearBack2", unlocked and isActive and open)
end

function InitWlfPropExchange(acStatusMap)
  OnAcChangePropExchange(acStatusMap)
end

function OnAcChangePropExchange(acStatusMap)
  local open = table.has(acStatusMap, PB.enum.ActivityStatus.Started) or table.has(acStatusMap, PB.enum.ActivityStatus.Finished)
  NotifyWelfareStatucChange("PropExchange", open)
end
