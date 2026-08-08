local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local DU = require("Common/DungeonUtil")
local ATU = require("Common/AutumnUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local fightDungeonType = 0
local dungeonReward, dungeonId, chapterId, dungeonMonster
local canClose = false

function SetupWindow()
  GetSettingVolume()
  WU.BindButtonEvent(REF.ButtonExit, OnUIExit)
  WU.BindButtonEvent(REF.ButtonRestart, DU.Restart)
  WU.BindButtonEvent(REF.ButtonSetting, OnUISettingOn)
  WU.BindButtonEvent(REF.ButtonSettingClose, OnUISettingOff)
  WU.BindKeyEvent(REF.ButtonSettingClose, OnUISettingOff)
  REF.ButtonContinue["$SetCallback"](OnUIContinue)
  CS.EventDelegate.Add(REF.BgmSlider.UISlider.onChange, OnAudioSettingChange)
  CS.EventDelegate.Add(REF.SfxSlider.UISlider.onChange, OnAudioSettingChange)
  REF.SfxSlider.UISlider.onDragFinished = PlaySampleSound
  fightDungeonType = this:GetData("FightDungeonType")
  WU.BindButtonEvent(REF.HighMask, OnClickMask)
  WU.BindButtonEvent(REF.UltimateMask, OnClickMask)
  WU.BindButtonEvent(REF.CustomMask, OnClickMask)
end

function InitWindow()
  local preferences = m_configDataManager.GetPreferences()
  dungeonId = this:GetData("WindowDungeon/DungeonId")
  chapterId = this:GetData("WindowDungeon/ChapterId")
  dungeonReward = PB.get("DungeonReward", dungeonId)
  dungeonMonster = PB.get("DungeonMonster", dungeonId)
  REF.Preset.UIToggleGroup.value = preferences.presetLevel
  REF.LabelTitle.UILabel.text = ""
  REF.LabelGoal.UILabel.text = ""
  if dungeonId == nil then
    REF.GoalSlot.gameObject:SetActive(false)
  else
    ShowContent()
    ShowTarget()
  end
  REF.ButtonSettingClose.gameObject:SetActive(false)
  REF.SettingContent.gameObject:SetActive(false)
  REF.InfoContent.gameObject:SetActive(true)
  if REF.LabelGoal.UILabel.text == "" then
    REF.SettingContent.gameObject:SetActive(true)
    REF.ButtonSetting.gameObject:SetActive(false)
  else
    REF.SettingContent.gameObject:SetActive(false)
    REF.ButtonSetting.gameObject:SetActive(true)
  end
end

function OnClickMask()
  WU.ShowHintText(WU.GetString("VideoSetting_PoorDeviceNotAllowed"))
end

function OnUIContinue()
  local sceneFight = CS.SceneFight.Instance
  if sceneFight ~= nil then
    sceneFight:PauseGame(false)
  end
  this:BroadcastGameEvent("OnFightGamePause")
  SaveGameSetting()
  WU.RecycleWindow(this)
end

function OnUIExit()
  SaveGameSetting()
  local exitText = ""
  if fightDungeonType == PB.enum.DungeonType.BurstLinkPvp or fightDungeonType == PB.enum.DungeonType.FriendPvp then
    exitText = WU.GetString("System_ExitBurstLinkFight")
  else
    exitText = WU.GetString("System_ExitFight")
  end
  WU.ShowMessageYesNo(exitText, function(result)
    if result == "YES" then
      if fightDungeonType == PB.enum.DungeonType.BurstLinkPvp or fightDungeonType == PB.enum.DungeonType.FriendPvp or fightDungeonType == PB.enum.DungeonType.TeamPve or fightDungeonType == PB.enum.DungeonType.RD then
        if CS.FightBase.Instance ~= nil then
          DU.LeavePVPNetDungeon()
          CS.FightBase.Instance:TimeOutLeaveGameLua("SceneCity", 8.0)
        end
      elseif this:GetData("uniqueWeaponTutorial") then
        this:SetData("uniqueWeaponTutorial", false)
        CS.FightBase.Instance:LeaveGameLua("SceneCity")
      else
        DU.LeaveDungeon(3)
      end
    end
  end)
end

function OnUISettingOn()
  canClose = true
  REF.InfoContent.gameObject:SetActive(false)
  ShowAnim(REF.SettingContent)
  REF.ButtonSettingClose.gameObject:SetActive(true)
  CS.UIWindowHelp.ChangeUIWidgetAlpha(REF.ButtonSettingClose.gameObject:GetComponent(typeof(CS.UIRect)), 0.002)
  CS.TweenAlpha.Begin(REF.ButtonSettingClose.gameObject, 0.3, 1.0)
end

function OnUISettingOff()
  if not canClose then
    return
  end
  canClose = false
  CS.TweenScale.Begin(REF.SettingContent.gameObject, 0.1, CS.UnityEngine.Vector3.one * 0.2)
  this:DelayInvokeInSeconds(0.1, function()
    REF.ButtonSettingClose.gameObject:SetActive(false)
    REF.SettingContent.gameObject:SetActive(false)
    REF.InfoContent.gameObject:SetActive(true)
  end)
end

function ShowAnim(obj)
  obj.gameObject:SetActive(true)
  CS.UIWindowHelp.ChangeUIWidgetAlpha(obj.gameObject:GetComponent(typeof(CS.UIRect)), 0.002)
  obj.transform.localScale = CS.UnityEngine.Vector3.one * 0.2
  CS.TweenScale.Begin(obj.gameObject, 0.12, CS.UnityEngine.Vector3.one)
  CS.TweenAlpha.Begin(obj.gameObject, 0.3, 1.0)
end

function ShowContent()
  local showRestart = false
  local noParam = false
  local titleText = ""
  REF.LabelDangerTip.gameObject:SetActive(false)
  local eventActivityType = DB:GetData("Event/ActivityType")
  if eventActivityType then
    showRestart = false
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.WeekActivity then
    showRestart = true
    local materialId = this:GetData("Activity/CurrentMaterialId")
    if materialId ~= nil then
      titleText = WU.GetString("Activity_Id_Name_" .. materialId) .. "\239\188\154" .. WU.GetString("DungeonName_" .. dungeonId)
    end
  elseif fightDungeonType == PB.enum.DungeonType.AsyncPvp then
    titleText = WU.GetString("WindowDungeon_Desc" .. fightDungeonType)
  elseif fightDungeonType == PB.enum.DungeonType.Tower or fightDungeonType == PB.enum.DungeonType.TowerNew then
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.Story then
    noParam = true
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.FriendPvp then
    titleText = WU.GetString("DungeonPauseTitle_FriendPvp")
  elseif fightDungeonType == PB.enum.DungeonType.Normal then
    showRestart = true
    titleText = WU.GetString("DungeonName_" .. dungeonId)
    if this:GetData("fci/baseinfo/") ~= nil then
      local testResult = DU.CultivationReachExpection(this:GetData("FightActorInfo")[1].actors, dungeonId)
      REF.LabelDangerTip.gameObject:SetActive(not testResult.isReach)
    end
  elseif fightDungeonType == PB.enum.DungeonType.Gold then
    showRestart = true
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.Training or fightDungeonType == PB.enum.DungeonType.Challenge then
    showRestart = true
    noParam = true
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.RacePVP then
    titleText = WU.GetString("DungeonPauseTitle_RacePvp")
  elseif fightDungeonType == PB.enum.DungeonType.BurstLinkPvp then
    titleText = WU.GetString("DungeonPauseTitle_BurstLinkPvp")
  elseif fightDungeonType == PB.enum.DungeonType.TeamPve then
    local activityInfo = DB:GetData("Activity/CurrentActivity")
    if activityInfo and activityInfo[1] and activityInfo[1].type == PB.enum.ActivityType.DungeonTeamWelfare then
      titleText = WU.GetString("DungeonPauseTitle_TeamPveWelfare")
    else
      titleText = WU.GetString("DungeonPauseTitle_TeamPve")
    end
  elseif fightDungeonType == PB.enum.DungeonType.Maze then
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.Triggered then
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.SemiFixed then
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.AssistGuild or fightDungeonType == PB.enum.DungeonType.ChallengeGuild then
    showRestart = true
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.MaidCafe then
    showRestart = false
    titleText = WU.GetString("DungeonName_" .. dungeonId)
  elseif fightDungeonType == PB.enum.DungeonType.AsyncPvpV2 then
    titleText = WU.GetString("WindowDungeon_Desc" .. fightDungeonType)
  end
  REF.LabelTitle.UILabel.text = titleText
  REF.ButtonRestart.gameObject:SetActive(showRestart)
  REF.Buttons.UIGrid:Reposition()
  if showRestart then
    local cost, param
    if not noParam then
      param = this:GetData("WindowDungeon/EnterParam")
    end
    if param ~= nil then
      if param.price ~= nil then
        if param.multiPower == nil then
          param.multiPower = 1
        end
        cost = {
          type = param.price.type,
          id = param.price.id,
          count = param.multiPower * param.price.count
        }
      end
    elseif dungeonReward and #dungeonReward.cost > 0 then
      local cost = dungeonReward.cost[1]
      local costWin = dungeonReward.costWin[1]
      cost = {
        type = cost.type,
        id = cost.id,
        count = cost.count + costWin.count
      }
    end
    if cost ~= nil then
      REF.ButtonRestart.UIButton.isEnabled = WU.TryToPayResource(cost, nil, function()
      end)
    end
  end
end

function ShowTarget()
  for i = 0, REF.GoalSlot.transform.childCount - 1 do
    REF.GoalSlot.transform:GetChild(i).gameObject:SetActive(false)
  end
  if fightDungeonType == PB.enum.DungeonType.Story or fightDungeonType == PB.enum.DungeonType.Normal or fightDungeonType == PB.enum.DungeonType.WeekActivity or fightDungeonType == PB.enum.DungeonType.Training or fightDungeonType == PB.enum.DungeonType.Challenge or fightDungeonType == PB.enum.DungeonType.SemiFixed then
    if dungeonMonster ~= nil then
      local winTypeResult = DU.GetDungeonWinTypeText(dungeonMonster.winParam)
      REF.LabelGoal.UILabel.text = WU.GetString("WinType_Title") .. tostring(winTypeResult[1])
    end
    if dungeonReward == nil then
      return
    end
    for i = 1, #dungeonReward.target do
      REF.GoalSlot.transform:GetChild(i - 1).gameObject:SetActive(true)
      REF["Text" .. i].UILabel.text = WU.GetDungeonTargetText(dungeonReward.target[i])
    end
    local result = CS.FightLuaLogic.Instance:GetTargetResultList()
    if #result == 0 then
      return
    end
    local dungeonRecord
    local eventActivityType = this:GetData("Event/ActivityType")
    if eventActivityType then
      if ATU.UsedForAutumn(eventActivityType) then
        local record = this:GetData("fci/event-dungeon/record/")
        local _
        _, dungeonRecord = _ENV["!"](record):find(function(k, v)
          return v.dungeonId == dungeonId
        end)
      else
        local record = this:GetData(string.format("fci/activity/record/%s/%s", eventActivityType, this:GetData("Event/ActivityId"))).records
        local _
        _, dungeonRecord = _ENV["!"](record):find(function(k, v)
          return v.dungeonId == dungeonId
        end)
      end
    elseif fightDungeonType == PB.enum.DungeonType.WeekActivity then
      local record = this:GetData("fci/activity-dungeon/record/")
      local _
      _, dungeonRecord = _ENV["!"](record):find(function(k, v)
        return v.dungeonId == dungeonId
      end)
    elseif fightDungeonType == PB.enum.DungeonType.SemiFixed then
      local recordUri = "fci/activity/record/" .. PB.enum.ActivityType.Carnival91 .. "/{SemiFixed/ActivityId}/"
      local result = this:GetData(recordUri)
      local _
      _, dungeonRecord = table.find(result.records, function(_, v)
        return v.dungeonId == dungeonId
      end)
    elseif chapterId ~= nil then
      dungeonRecord = this:GetData("fci/dungeon/chapter/" .. chapterId).recordDungeons[dungeonId]
    end
    for i = 1, #result do
      local val_table = result[i]
      local id = val_table[1]
      local self_val = val_table[2]
      local compare_val = val_table[3]
      local operation = val_table[4]
      local state = val_table[5]
      REF["BG" .. i].UISprite.color = CS.NGUIMath.HexToColor(4294967218)
      REF["Text" .. i].UILabel.color = CS.NGUIMath.HexToColor(4294967295)
      REF["State" .. i].UILabel.color = CS.NGUIMath.HexToColor(4294967295)
      REF["Star" .. i].UISprite.graify = false
      if dungeonRecord ~= nil and _ENV["!"](dungeonRecord.targetsDone):has(i) then
        REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_1")
      elseif id ~= 0 then
        if operation <= PB.enum.Operation.LessThanOrEqualTo then
          if operation == PB.enum.Operation.EqualTo then
            REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_1")
          elseif operation == PB.enum.Operation.NotEqualTo then
            if compare_val == 0 then
              REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_1")
            else
              REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_2")
            end
          elseif compare_val == 0 then
            REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_2")
          else
            REF["State" .. i].UILabel.text = self_val .. "/" .. compare_val
          end
        else
          REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_1")
        end
      elseif operation <= PB.enum.Operation.LessThanOrEqualTo then
        if operation ~= PB.enum.Operation.NotEqualTo then
          if operation == PB.enum.Operation.EqualTo then
            if self_val > compare_val then
              REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_0")
              REF["BG" .. i].UISprite.color = CS.NGUIMath.HexToColor(4294967140)
              REF["Text" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
              REF["State" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
              REF["Star" .. i].UISprite.graify = true
            else
              local target_type = dungeonReward.target[i].type
              local not_show_num = false
              if target_type == PB.enum.DungeonTarget.KillWinType or target_type == PB.enum.DungeonTarget.KillBySkill or target_type == PB.enum.DungeonTarget.KillBySequence then
                not_show_num = true
              end
              if compare_val == 0 or not_show_num then
                REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_2")
              else
                REF["State" .. i].UILabel.text = self_val .. "/" .. compare_val
              end
            end
          else
            REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_0")
            REF["BG" .. i].UISprite.color = CS.NGUIMath.HexToColor(4294967140)
            REF["Text" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
            REF["State" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
            REF["Star" .. i].UISprite.graify = true
          end
        else
          local target_type = dungeonReward.target[i].type
          if target_type == PB.enum.DungeonTarget.KillWinType or target_type == PB.enum.DungeonTarget.KillBySequence then
            REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_0")
            REF["BG" .. i].UISprite.color = CS.NGUIMath.HexToColor(4294967140)
            REF["Text" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
            REF["State" .. i].UILabel.color = CS.NGUIMath.HexToColor(3031741695)
            REF["Star" .. i].UISprite.graify = true
          else
            REF["State" .. i].UILabel.text = WU.GetString("TargetType_State_2")
          end
        end
      else
        REF["State" .. i].UILabel.text = self_val .. "/" .. compare_val
      end
    end
  end
end

function GetSettingVolume()
  local preferences = m_configDataManager.GetPreferences()
  REF.BgmSlider.UISlider.value = preferences.audioSetting.bgmVolume
  REF.SfxSlider.UISlider.value = preferences.audioSetting.sfxVolume
end

function OnAudioSettingChange()
  local preferences = m_configDataManager.GetPreferences()
  preferences.audioSetting = {
    bgmVolume = REF.BgmSlider.UISlider.value,
    sfxVolume = REF.SfxSlider.UISlider.value
  }
  m_configDataManager.SetPreferences(preferences)
end

function PlaySampleSound()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_OK")
end

function SaveGameSetting()
  if WU.IsPreCommit() then
    return
  end
  local presetLevel = REF.Preset.UIToggleGroup.value
  local preferences = m_configDataManager.GetPreferences()
  preferences.presetLevel = presetLevel
  m_configDataManager.SetPreferences(preferences)
end
