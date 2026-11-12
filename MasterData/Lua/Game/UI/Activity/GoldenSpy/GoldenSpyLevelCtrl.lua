local GoldenSpyLevelCtrl = class("GoldenSpyLevelCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local ItemSpritePath = "UI_Activity/_%s/SpriteAtlas/Item/"
local SpritePath = "UI_Activity/_%s/SpriteAtlas/"
local PrefabPath = "UI_Activity/_%s/"
local BoomSkillId = 1001
local FrozenSkillId = 1002
local PlayerActivityData = PlayerData.Activity
GoldenSpyLevelCtrl._mapNodeConfig = {
  img_bg = {sComponentName = "Image"},
  platformRoot = {
    sComponentName = "RectTransform"
  },
  txt_Time = {sComponentName = "TMP_Text"},
  txt_SubtractionScore = {sComponentName = "TMP_Text"},
  txt_AddTimeScore = {sComponentName = "TMP_Text"},
  anim_time = {sComponentName = "Animator", sNodeName = "img_time"},
  txt_targetTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Target"
  },
  txt_targetScore = {sComponentName = "TMP_Text"},
  txt_curScore = {sComponentName = "TMP_Text"},
  anim_curScore = {
    sComponentName = "Animator",
    sNodeName = "txt_curScore"
  },
  txt_floor = {sComponentName = "TMP_Text"},
  go_AddScore = {sComponentName = "GameObject"},
  txt_AddScore = {sComponentName = "TMP_Text"},
  btn_Pause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "Map"
  },
  PausePanel = {
    sNodeName = "PausePanel",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyPauseCtrl"
  },
  floorCtrl = {
    sNodeName = "FloorRoot",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyFloorCtrl"
  },
  btn_Hook = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Hook",
    sAction = "GoldenSpy_Hook"
  },
  img_hook = {sComponentName = "Image"},
  btn_Skill1 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill1",
    sAction = "GoldenSpy_Boom"
  },
  btn_Skill2 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill2",
    sAction = "GoldenSpy_Frozen"
  },
  btn_ToolBox = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ToolBox",
    sAction = "GoldenSpy_ToolBox"
  },
  txt_ToolBox = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_ToolBox_Title"
  },
  ToolBoxPanel = {
    sNodeName = "ToolBoxPanel",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyToolBoxCtrl"
  },
  go_Task = {},
  target = {nCount = 3, sComponentName = "Image"},
  txt_taskScore = {sComponentName = "TMP_Text"},
  ActorAnimRoot = {sComponentName = "Animator"},
  rtEffectRoot = {},
  HookEffectParent = {
    sComponentName = "RectTransform"
  },
  imgWarning = {},
  skill_Boom = {},
  go_CompanionAddScore = {},
  txt_CompanionAddScore = {sComponentName = "TMP_Text"},
  targetScoreCtrl = {
    sNodeName = "TargetScorePanel",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyTargetScoreCtrl"
  }
}
GoldenSpyLevelCtrl._mapEventConfig = {
  GoldenSpy_Exit_OnClick = "GoldenSpy_Exit_OnClick",
  GoldenSpy_Restart_OnClick = "GoldenSpy_Restart_OnClick",
  GoldenSpy_Continue_OnClick = "GoldenSpy_Continue_OnClick",
  GoldenSpy_OpenDic_OnClick = "GoldenSpy_OpenDic_OnClick",
  GoldenSpy_UpdateTaskScore = "OnEvent_UpdateTaskScore",
  GoldenSpy_UpdateSkillCount = "OnEvent_UpdateSkillCount",
  GoldenSpy_FinishFloor = "OnEvent_FinishFloor",
  GoldenSpy_CompanionAddScore = "OnEvent_CompanionAddScore",
  [EventId.ClosePanel] = "OnEvent_CloseDic",
  GoldenSpyHookResumeSwing = "OnEvent_GoldenSpyHookResumeSwing",
  GoldenSpyHookStartExtend = "OnEvent_GoldenSpyHookStartExtend",
  GoldenSpy_TargetScore_Close = "OnEvent_GoldenSpy_TargetScore_Close",
  GM_GoldenSpy_RefreshTask = "OnEvent_GM_GoldenSpy_RefreshTask",
  GM_GoldenSpy_AddSkill = "OnEvent_GM_GoldenSpy_AddSkill",
  GM_GoldenSpy_AddBuff = "OnEvent_GM_GoldenSpy_AddBuff",
  GM_GoldenSpy_AddScore = "OnEvent_GM_GoldenSpy_AddScore"
}

function GoldenSpyLevelCtrl:Awake()
  self._mapNode.PausePanel.gameObject:SetActive(false)
  self._mapNode.ToolBoxPanel.gameObject:SetActive(false)
  self._mapNode.targetScoreCtrl.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nGroupId = param[2]
    self.nLevelId = param[3]
  end
  self.animator = self.gameObject:GetComponent("Animator")
  self.originAddScorePos = self._mapNode.go_AddScore:GetComponent("RectTransform").anchoredPosition
  self.tbTimer = {}
  self.AddScoreTimer = nil
  self.GoldenSpyActData = PlayerActivityData:GetActivityDataById(self.nActId)
  self.GoldenSpyLevelData = self.GoldenSpyActData:GetGoldenSpyLevelData()
  self.GoldenSpyFloorData = self.GoldenSpyActData:GetGoldenSpyFloorData()
  self.levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.nLevelId)
  if self.levelCfg == nil then
    return
  end
  if self.lightPrefab ~= nil then
    destroy(self.lightPrefab)
    self.lightPrefab = nil
  end
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self.nGroupId)
  if groupCfg ~= nil then
    local goLightPerfab = self:LoadAsset(string.format(PrefabPath, self.nActId) .. groupCfg.LightName .. ".prefab")
    self.lightPrefab = instantiate(goLightPerfab, self._mapNode.platformRoot)
    local tr = self.lightPrefab.transform:GetComponent("RectTransform")
    tr.anchoredPosition = Vector2.zero
  end
  self.bInPause = false
  if self._panel.bFirstInCtrl then
    self:Init()
    self:InitSkill(true)
    self._mapNode.floorCtrl:Init(self.nLevelId, self.nCurFloorId, self)
    self:EnterGame()
    self._panel.bFirstInCtrl = false
  end
end

function GoldenSpyLevelCtrl:OnEnable()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("GoldenSpy", self.tbGamepadUINode)
end

function GoldenSpyLevelCtrl:OnDisable()
  GamepadUIManager.DisableGamepadUI("GoldenSpy")
  GamepadUIManager.QuitAdventure()
end

function GoldenSpyLevelCtrl:EnterGame()
  self._mapNode.ActorAnimRoot:Play("ActorPanel_Jump")
  self.bInCharAnimator = false
  self:AddTimer(1, 1.7, function()
    self:ShowTargetScore()
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 1.7)
  if self.nLevelType == GameEnum.GoldenSpyLevelType.Quest or self.nLevelType == GameEnum.GoldenSpyLevelType.Random then
    self.GoldenSpyLevelData:RefreshTask()
    self:UpdateTaskUI()
  end
end

function GoldenSpyLevelCtrl:Init()
  self.nCurFloorId = self.GoldenSpyFloorData:GetCurFloor()
  self.floorCfg = self.GoldenSpyFloorData:GetFloorConfig()
  if self.floorCfg == nil then
    return
  end
  self:SetPngSprite(self._mapNode.img_bg, string.format(SpritePath, self.nActId) .. self.floorCfg.BgName)
  local nFloor = self.GoldenSpyLevelData:GetCurFloor()
  local nTotalFloor = self.GoldenSpyLevelData:GetTotalFloor()
  local sFloorText = orderedFormat(ConfigTable.GetUIText("GoldenSpy_Floor"), nFloor, nTotalFloor)
  NovaAPI.SetTMPText(self._mapNode.txt_floor, sFloorText)
  self.nLevelType = self.levelCfg.LevelType
  if self.nLevelType == GameEnum.GoldenSpyLevelType.Normal then
    self._mapNode.go_Task:SetActive(false)
    self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.Normal, 0, true)
    self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_game_01")
  elseif self.nLevelType == GameEnum.GoldenSpyLevelType.Quest then
    self._mapNode.go_Task:SetActive(true)
    self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.Normal, 0, true)
    self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_game_01")
  elseif self.nLevelType == GameEnum.GoldenSpyLevelType.Random then
    self._mapNode.go_Task:SetActive(true)
    self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.Normal, 0, true)
    self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_game_01")
  elseif self.nLevelType == GameEnum.GoldenSpyLevelType.FishingHook then
    self._mapNode.go_Task:SetActive(false)
    self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.FishingHook, self.levelCfg.Param1, true)
    self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_level_task_02")
  end
  for _, v in ipairs(self.tbTimer) do
    if v ~= nil then
      v:Cancel()
    end
  end
  if self.addTween ~= nil then
    self.addTween:Kill(false)
    self.addTween = nil
  end
  self.tbTimer = {}
  self:SetTimeText(self.floorCfg.TimeLimit)
  self.nCurTime = self.floorCfg.TimeLimit
  self:ClearTimer()
  self:UpdateScoreText()
  self._mapNode.txt_AddScore.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txt_targetScore, self.floorCfg.GoalScore)
  self.bCanBoom = false
  self.bStartFloor = false
  self.bChangeTime = false
  self.bInFrozen = false
  self.bInFishingHook = false
  self:ResetEffect()
end

function GoldenSpyLevelCtrl:InitSkill(bNewLevel)
  local skillData = self.GoldenSpyLevelData:GetSkillData()
  if bNewLevel then
    for i = 1, 2 do
      local btn_Skill = self._mapNode["btn_Skill" .. i]
      btn_Skill.gameObject:SetActive(false)
    end
    self.skillList = {}
    for k, v in pairs(skillData) do
      table.insert(self.skillList, k)
    end
    table.sort(self.skillList, function(a, b)
      return a < b
    end)
  else
  end
  for i = 1, #self.skillList do
    local skillId = self.skillList[i]
    local skillCfg = ConfigTable.GetData("GoldenSpySkill", skillId)
    if skillCfg ~= nil then
      local btn_Skill = self._mapNode["btn_Skill" .. i]
      local img_icon = btn_Skill.transform:Find("AnimRoot/icon"):GetComponent("Image")
      self:SetPngSprite(img_icon, string.format(SpritePath, self.nActId) .. skillCfg.icon)
      local btn_Skill = self._mapNode["btn_Skill" .. i]
      local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txt_count, string.format("%d", skillData[skillId]))
      local mask = btn_Skill.transform:Find("AnimRoot/mask"):GetComponent("Image")
      mask.gameObject:SetActive(skillData[skillId] <= 0)
      local img_cd = btn_Skill.transform:Find("AnimRoot/img_CD"):GetComponent("Image")
      img_cd.gameObject:SetActive(false)
      btn_Skill.gameObject:SetActive(true)
    end
  end
  self._mapNode.skill_Boom:SetActive(false)
  self._mapNode.skill_Boom.transform:SetParent(self._mapNode.rtEffectRoot.transform)
  self._mapNode.skill_Boom:GetComponent("RectTransform").anchoredPosition = Vector2.zero
  self._mapNode.go_CompanionAddScore.gameObject:SetActive(false)
end

function GoldenSpyLevelCtrl:ResetEffect()
  self._mapNode.imgWarning.gameObject:SetActive(false)
  if self.FrozenTweener ~= nil then
    self.FrozenTweener:Kill()
    self.FrozenTweener = nil
  end
  if self.FishingHookTweener ~= nil then
    self.FishingHookTweener:Kill()
    self.FishingHookTweener = nil
  end
  for i = 1, 2 do
    local btn_Skill = self._mapNode["btn_Skill" .. i]
    local img_cd = btn_Skill.transform:Find("AnimRoot/img_CD"):GetComponent("Image")
    img_cd.gameObject:SetActive(false)
  end
  local hookMask = self._mapNode.btn_Hook.transform:Find("AnimRoot/mask"):GetComponent("Image")
  hookMask.gameObject:SetActive(false)
  self._mapNode.skill_Boom:GetComponent("RectTransform").anchoredPosition = Vector2.zero
  self._mapNode.skill_Boom:SetActive(false)
end

function GoldenSpyLevelCtrl:StartFloor()
  self.bStartFloor = true
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  self.timer = self:AddTimer(0, 1, function()
    self.nCurTime = self.nCurTime - 1
    self.nCurTime = math.max(self.nCurTime, 0)
    if not self.bChangeTime and self.nCurTime <= 5 then
      self._mapNode.anim_time:Play("txt_Time_in")
    end
    if self.nCurTime <= 0 then
      self.timer:Cancel()
      self.timer = nil
      self:FinishFloor()
      return
    end
    self:SetTimeText(self.nCurTime)
  end, true, true, true)
  table.insert(self.tbTimer, self.timer)
  self._mapNode.floorCtrl:StartFloor()
  local bNewFloor = self.GoldenSpyActData:GetFloorIsNew(self.nCurFloorId)
  if bNewFloor and self.floorCfg.DictionaryID ~= 0 then
    self:Pause()
    self.GoldenSpyActData:EnterFloor(self.nCurFloorId)
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.floorCfg.DictionaryID, true)
  end
end

function GoldenSpyLevelCtrl:FinishFloor()
  if self.bInPause then
    self:GoldenSpy_Continue_OnClick()
  end
  WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
  self:ClearTimer()
  self.bStartFloor = false
  self:ResetEffect()
  self._mapNode.floorCtrl:FinishFloor()
  local nCurFloorId = self.GoldenSpyLevelData:GetCurFloorId()
  local nFloor = self.GoldenSpyLevelData:GetCurFloor()
  local nTotalFloor = self.GoldenSpyLevelData:GetTotalFloor()
  self.nCurScore = self.GoldenSpyLevelData:GetCurScore()
  local bFinish = nFloor == nTotalFloor or self.nCurScore < self.floorCfg.GoalScore
  self:UpdateScoreText()
  
  local function finishCallback(callback)
    local data = {
      nFloor = nFloor,
      nScore = self.nCurScore,
      nTaskCompleteCount = self.GoldenSpyLevelData:GetCompleteTaskCount(),
      tbItems = self.GoldenSpyLevelData:GetCatchItemData(),
      tbSkills = self.GoldenSpyLevelData:GetUsedSkillData()
    }
    self.GoldenSpyActData:FinishLevel(self.nLevelId, data, function(msgData)
      if callback ~= nil then
        local nextGroupId, nextLevelId = self.GoldenSpyActData:GetNextLevel(self.nGroupId, self.nLevelId)
        callback(msgData, nextGroupId, nextLevelId)
      end
      EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
    end)
  end
  
  local function goNextCallback()
    self:GoNextFloor()
  end
  
  local bSuccess = false
  if nFloor == nTotalFloor then
    bSuccess = self.nCurScore >= self.levelCfg.Score
  else
    bSuccess = self.nCurScore >= self.floorCfg.GoalScore
  end
  
  local function goNextLevelCallback(nextGroupId, nextLevelId)
    if nextGroupId == nil or nextLevelId == nil then
      return
    end
    
    local function wait()
      self.GoldenSpyActData:EnterGroupSelect(nextGroupId)
      self.GoldenSpyActData:StartLevel(nextGroupId, nextLevelId)
    end
    
    cs_coroutine.start(wait)
  end
  
  local data = {
    bResult = bFinish,
    nLevelId = self.nLevelId,
    nCurFloorId = nCurFloorId,
    nFloor = nFloor,
    nTotalFloor = nTotalFloor,
    nCurScore = self.nCurScore,
    finishCallback = finishCallback,
    goNextCallback = goNextCallback,
    bSuccess = bSuccess,
    goNextLevelCallback = goNextLevelCallback
  }
  if not self.GoldenSpyActData:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_End_Notice"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    })
    return
  end
  if bSuccess then
    if self.animator ~= nil then
      self.animator:Play("GoldenSpyPanel_out")
      self:AddTimer(1, 1.4, function()
        EventManager.Hit(EventId.OpenPanel, self._panel.nResultPanelId, data, self.nActId)
      end, true, true, true)
    else
      EventManager.Hit(EventId.OpenPanel, self._panel.nResultPanelId, data, self.nActId)
    end
  else
    EventManager.Hit(EventId.OpenPanel, self._panel.nResultPanelId, data, self.nActId)
  end
end

function GoldenSpyLevelCtrl:GoNextFloor()
  self.GoldenSpyLevelData:NextFloor()
  self:Init()
  self:InitSkill(false)
  self._mapNode.floorCtrl:Init(self.nLevelId, self.nCurFloorId, self)
  self:EnterGame()
end

function GoldenSpyLevelCtrl:SetTimeText(nTime)
  nTime = math.max(nTime, 0)
  local sTimeText = string.format("%02d:%02d", math.floor(nTime / 60), nTime % 60)
  NovaAPI.SetTMPText(self._mapNode.txt_Time, sTimeText)
end

function GoldenSpyLevelCtrl:UpdateScoreText()
  self.nCurScore = self.GoldenSpyLevelData:GetCurScore()
  self.nCurScore = math.floor(self.nCurScore)
  NovaAPI.SetTMPText(self._mapNode.txt_curScore, self.nCurScore)
end

function GoldenSpyLevelCtrl:CatchedItem(tbItemCtrl)
  if tbItemCtrl == nil or #tbItemCtrl == 0 then
    return
  end
  self.bCanBoom = true
end

function GoldenSpyLevelCtrl:CatchedComplete(tbItemCtrl)
  WwiseAudioMgr:PostEvent("Mode_steal_coin")
  local oldScore = self.nCurScore
  local bFinishTask, addScore = self.GoldenSpyLevelData:CatchedItem(tbItemCtrl)
  addScore = math.floor(addScore or 0)
  if NovaAPI.IsEditorPlatform() then
    print("GoldenSpyLevelCtrl:抓到的道具分", addScore)
  end
  self.nCurScore = self.GoldenSpyLevelData:GetCurScore()
  self.nCurScore = math.floor(self.nCurScore)
  local newAddScore = self.nCurScore - oldScore
  self._mapNode.go_AddScore:GetComponent("RectTransform").anchoredPosition = self.originAddScorePos
  NovaAPI.SetTMPText(self._mapNode.txt_AddScore, "+" .. newAddScore)
  self._mapNode.txt_AddScore.gameObject:SetActive(true)
  if self.AddScoreTimer ~= nil then
    self.AddScoreTimer:Cancel()
    self.AddScoreTimer = nil
  end
  self.AddScoreTimer = self:AddTimer(1, 0.8, function()
    if not self.bStartFloor then
      return
    end
    if self._mapNode.go_AddScore == nil then
      return
    end
    local beginPos = self._mapNode.go_AddScore.transform.position
    local endPos = self._mapNode.txt_curScore.transform.position
    endPos.x = endPos.x - 1
    endPos.y = endPos.y - 0.01
    self.addTween = self._mapNode.go_AddScore.transform:DOMove(endPos, 0.2):SetUpdate(true)
    local timer = self:AddTimer(1, 0.2, function()
      self._mapNode.txt_AddScore.gameObject:SetActive(false)
      self:UpdateScoreText()
      self._mapNode.anim_curScore:Play("txt_curScore_in")
    end, true, true, true)
    table.insert(self.tbTimer, timer)
    self.AddScoreTimer = nil
  end, true, true, true)
  local tbTempItemCtrl = clone(tbItemCtrl)
  self:CatchedItemProcess(tbTempItemCtrl, bFinishTask)
end

function GoldenSpyLevelCtrl:CatchedItemProcess(tbTempItemCtrl, bFinishTask)
  if #tbTempItemCtrl <= 0 then
    return
  end
  local tempItemCtrl = tbTempItemCtrl[1]
  table.remove(tbTempItemCtrl, 1)
  local itemCfg = tempItemCtrl:GetItemCfg()
  if itemCfg.ItemType == GameEnum.GoldenSpyItem.BuffItem then
    local buffId = itemCfg.Params[1]
    if buffId == 0 then
      self:AddRandomBuff(self.levelCfg.BuffCardPoolId, function()
        self:CatchedItemProcessCallback(tbTempItemCtrl, tempItemCtrl, bFinishTask)
      end)
    else
      self:AddRandomBuff(buffId, function()
        self:CatchedItemProcessCallback(tbTempItemCtrl, tempItemCtrl, bFinishTask)
      end)
    end
  else
    self:CatchedItemProcessCallback(tbTempItemCtrl, tempItemCtrl, bFinishTask)
  end
end

function GoldenSpyLevelCtrl:CatchedItemProcessCallback(tbTempItemCtrl, itemCtrl, bFinishTask)
  if #tbTempItemCtrl <= 0 then
    if bFinishTask then
      local taskAnimator = self._mapNode.go_Task.transform:Find("AnimRoot"):GetComponent("Animator")
      self:UpdateScoreText()
      taskAnimator:Play("go_Task_switch")
      self:UpdateTaskIcon()
      local timer = self:AddTimer(1, 0.75, function()
        if not self.bStartFloor then
          return
        end
        self:UpdateTaskUI()
      end, true, true, true)
      table.insert(self.tbTimer, timer)
    else
      self:UpdateTaskUI()
    end
    self.bCanBoom = false
    local itemCfg = itemCtrl:GetItemCfg()
    if itemCfg.ItemType == GameEnum.GoldenSpyItem.BuffItem then
      local nCount = 0
      local items = self.GoldenSpyFloorData:GetItems()
      for k, v in pairs(items) do
        local itemCfg = ConfigTable.GetData("GoldenSpyItem", k)
        if itemCfg ~= nil and itemCfg.ItemType ~= GameEnum.GoldenSpyItem.Boom then
          nCount = nCount + v.itemCount
        end
      end
      if items == nil or nCount <= 0 then
        self:FinishFloor()
      end
    end
  end
  self:CatchedItemProcess(tbTempItemCtrl, bFinishTask)
end

function GoldenSpyLevelCtrl:UpdateTaskIcon()
  for i = 1, 3 do
    local img_icon = self._mapNode.target[i].transform:Find("img_icon"):GetComponent("Image")
    local icon_cg = img_icon:GetComponent("CanvasGroup")
    local imgGet = self._mapNode.target[i].transform:Find("img_get"):GetComponent("Image")
    NovaAPI.SetCanvasGroupAlpha(icon_cg, 0.3)
    imgGet.gameObject:SetActive(true)
  end
end

function GoldenSpyLevelCtrl:UpdateTaskUI()
  local taskData = self.GoldenSpyLevelData:GetTaskData()
  if taskData == nil or #taskData.tbItems <= 0 then
    self._mapNode.go_Task:SetActive(false)
    return
  end
  self._mapNode.go_Task:SetActive(true)
  for i = 1, 3 do
    self._mapNode.target[i].gameObject:SetActive(i <= #taskData.tbItems)
  end
  for i, v in ipairs(taskData.tbItems) do
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", v.nItemId)
    if itemCfg ~= nil then
      local img_icon = self._mapNode.target[i].transform:Find("img_icon"):GetComponent("Image")
      local icon_cg = img_icon:GetComponent("CanvasGroup")
      local imgGet = self._mapNode.target[i].transform:Find("img_get"):GetComponent("Image")
      self:SetPngSprite(img_icon, string.format(ItemSpritePath, self.nActId) .. itemCfg.IconPath .. "_s")
      if v.bFinish then
        imgGet.gameObject:SetActive(true)
        NovaAPI.SetCanvasGroupAlpha(icon_cg, 0.3)
      else
        imgGet.gameObject:SetActive(false)
        NovaAPI.SetCanvasGroupAlpha(icon_cg, 1)
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txt_taskScore, "+" .. taskData.nScore)
end

function GoldenSpyLevelCtrl:AddBuff(nBuffId)
  self.GoldenSpyLevelData:AddBuff(nBuffId)
  local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", nBuffId)
  if buffCfg == nil then
    return
  end
  if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddTimeInFloor then
    self.nCurTime = self.nCurTime + buffCfg.Params[1]
    NovaAPI.SetTMPText(self._mapNode.txt_AddTimeScore, "+" .. string.format("%d", buffCfg.Params[1]))
    if not self.bChangeTime then
      self.bChangeTime = true
      local addtimeTimer = self:AddTimer(1, 0.8, function()
        self.bChangeTime = false
      end, true, true, true)
      table.insert(self.tbTimer, addtimeTimer)
      self._mapNode.anim_time:Play("txt_Time_Add")
    end
  end
end

function GoldenSpyLevelCtrl:AddRandomBuff(nPoolId, callback)
  local tbBuffPool = {}
  
  local function forEachLine_BuffPool(mapLineData)
    if mapLineData.PoolId == nPoolId then
      table.insert(tbBuffPool, {
        buffId = mapLineData.CardId,
        weight = mapLineData.Weight
      })
    end
  end
  
  ForEachTableLine(DataTable.GoldenSpyBuffCardPool, forEachLine_BuffPool)
  local tbBuffData = self.GoldenSpyLevelData:GetBuffData()
  for i, v in ipairs(tbBuffPool) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil then
      for _, n in ipairs(tbBuffData) do
        local hasBuffCfg = ConfigTable.GetData("GoldenSpyBuffCard", n.buffId)
        if hasBuffCfg ~= nil and hasBuffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.LabelAddPercentage then
          local bIsLabel = false
          local nLabel = hasBuffCfg.Params[1]
          for _, k in ipairs(buffCfg.Label) do
            if k == nLabel then
              bIsLabel = true
              break
            end
          end
          if bIsLabel and self.GoldenSpyLevelData:CheckBuffActive(n) then
            v.weight = v.weight * (1 + hasBuffCfg.Params[2] / 100.0)
          end
        end
      end
    end
  end
  self:ShowBuffSelect(tbBuffPool, callback)
end

function GoldenSpyLevelCtrl:ShowBuffSelect(tbBuffPool, callback)
  self:Pause()
  local tbShowItem = {}
  local tbItems = self.GoldenSpyFloorData:GetItems()
  local tbHasBuff = self.GoldenSpyLevelData:GetBuffData()
  for _, v in pairs(tbItems) do
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", v.itemId)
    if itemCfg ~= nil and itemCfg.ShowValue ~= false then
      local nScore = itemCfg.Score
      for _, n in ipairs(tbHasBuff) do
        local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", n.buffId)
        if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and self.GoldenSpyLevelData:CheckBuffActive(n) and buffCfg.Params[1] == itemCfg.ItemType then
          nScore = nScore + buffCfg.Params[2]
        end
      end
      local itemData = {
        itemId = v.itemId,
        score = nScore
      }
      table.insert(tbShowItem, itemData)
    end
  end
  
  local function selectedCallback(buffId)
    self:Resume()
    self:AddBuff(buffId)
    if callback ~= nil then
      callback()
    end
  end
  
  local tbSortBuff = self:SortBuff(tbHasBuff)
  
  local function getRefreshCallback()
    return self.GoldenSpyLevelData:GetRefreshCount()
  end
  
  local function refreshCallback()
    self.GoldenSpyLevelData:UseRefreshCount()
  end
  
  EventManager.Hit(EventId.OpenPanel, self._panel.nBuffSelectPanelId, tbShowItem, tbSortBuff, tbBuffPool, selectedCallback, getRefreshCallback, refreshCallback, self.nActId)
end

function GoldenSpyLevelCtrl:GetHookBaseSpeed()
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.nLevelId)
  if levelCfg == nil then
    return 0
  end
  local cfg = ConfigTable.GetData("GoldenSpyConfig", levelCfg.ConfigId)
  if cfg == nil then
    return 0
  end
  local nSpeed = cfg.BaseSpeed
  for _, v in ipairs(self.GoldenSpyLevelData:GetBuffData()) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddSpeed and self.GoldenSpyLevelData:CheckBuffActive(v) then
      nSpeed = nSpeed + buffCfg.Params[1]
    end
  end
  return nSpeed
end

function GoldenSpyLevelCtrl:GetHookRadius()
  local cfg = ConfigTable.GetData("GoldenSpyConfig", self.levelCfg.ConfigId)
  if cfg == nil then
    return 0
  end
  local nRadius = cfg.BaseRadius
  for _, v in ipairs(self.GoldenSpyLevelData:GetBuffData()) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddHookRadius and self.GoldenSpyLevelData:CheckBuffActive(v) then
      nRadius = nRadius + buffCfg.Params[1]
    end
  end
  return nRadius
end

function GoldenSpyLevelCtrl:SubTime(nTime)
  self.nCurTime = self.nCurTime - nTime
  NovaAPI.SetTMPText(self._mapNode.txt_SubtractionScore, "-" .. nTime)
  self:SetTimeText(self.nCurTime)
  if not self.bChangeTime then
    self._mapNode.imgWarning.gameObject:SetActive(true)
    self.bChangeTime = true
    local subtimeTimer = self:AddTimer(1, 0.4, function()
      self._mapNode.imgWarning.gameObject:SetActive(false)
      self.bChangeTime = false
    end, true, true, true)
    table.insert(self.tbTimer, subtimeTimer)
    self._mapNode.anim_time:Play("txt_Time_Subtraction")
  end
end

function GoldenSpyLevelCtrl:Pause()
  WwiseAudioMgr:PostEvent("Mode_steal_get_pause")
  self._mapNode.floorCtrl:Pause()
  for _, v in ipairs(self.tbTimer) do
    if v ~= nil then
      v:Pause(true)
    end
  end
  if self.FrozenTweener ~= nil then
    self.FrozenTweener:Pause()
  end
  if self.FishingHookTweener ~= nil then
    self.FishingHookTweener:Pause()
  end
end

function GoldenSpyLevelCtrl:Resume()
  WwiseAudioMgr:PostEvent("Mode_steal_go")
  self._mapNode.floorCtrl:Continue()
  for _, v in ipairs(self.tbTimer) do
    if v ~= nil then
      v:Pause(false)
    end
  end
  if self.FrozenTweener ~= nil then
    self.FrozenTweener:Play()
  end
  if self.FishingHookTweener ~= nil then
    self.FishingHookTweener:Play()
  end
end

function GoldenSpyLevelCtrl:DropItem()
  WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
end

function GoldenSpyLevelCtrl:SortBuff(tbBuff)
  local tbSortBuff = {}
  local tbActiveBuff = {}
  local tbDelayBuff = {}
  local tbUnactiveBuff = {}
  for _, v in ipairs(tbBuff) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil then
      if buffCfg.BuffType == GameEnum.GoldenSpyBuffType.TemporaryBuff then
        if v.bActive then
          if table.indexof(v.tbActiveFloor, self.GoldenSpyLevelData:GetCurFloor()) > 0 then
            table.insert(tbActiveBuff, {
              buffData = v,
              nState = AllEnum.GoldenSpyBuffType.ActiveBuff
            })
          else
            table.insert(tbUnactiveBuff, {
              buffData = v,
              nState = AllEnum.GoldenSpyBuffType.UnactiveBuff
            })
          end
        else
          table.insert(tbUnactiveBuff, {
            buffData = v,
            nState = AllEnum.GoldenSpyBuffType.UnactiveBuff
          })
        end
      elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.DelayBuff then
        if v.bActive then
          if table.indexof(v.tbActiveFloor, self.GoldenSpyLevelData:GetCurFloor()) > 0 then
            table.insert(tbActiveBuff, {
              buffData = v,
              nState = AllEnum.GoldenSpyBuffType.ActiveBuff
            })
          else
            local bWaitActive = false
            for _, v in ipairs(v.tbActiveFloor) do
              if v > self.GoldenSpyLevelData:GetCurFloor() then
                bWaitActive = true
                break
              end
            end
            if bWaitActive then
              table.insert(tbDelayBuff, {
                buffData = v,
                nState = AllEnum.GoldenSpyBuffType.DelayBuff
              })
            else
              table.insert(tbUnactiveBuff, {
                buffData = v,
                nState = AllEnum.GoldenSpyBuffType.UnactiveBuff
              })
            end
          end
        else
          table.insert(tbUnactiveBuff, {
            buffData = v,
            nState = AllEnum.GoldenSpyBuffType.UnactiveBuff
          })
        end
      elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.PermanentBuff then
        table.insert(tbActiveBuff, {
          buffData = v,
          nState = AllEnum.GoldenSpyBuffType.ActiveBuff
        })
      elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.SkillCountBuff then
        table.insert(tbUnactiveBuff, {
          buffData = v,
          nState = AllEnum.GoldenSpyBuffType.UnactiveBuff
        })
      end
    end
  end
  if 0 < #tbActiveBuff then
    for _, v in ipairs(tbActiveBuff) do
      table.insert(tbSortBuff, v)
    end
  end
  if 0 < #tbDelayBuff then
    for _, v in ipairs(tbDelayBuff) do
      table.insert(tbSortBuff, v)
    end
  end
  if 0 < #tbUnactiveBuff then
    for _, v in ipairs(tbUnactiveBuff) do
      table.insert(tbSortBuff, v)
    end
  end
  return tbSortBuff
end

function GoldenSpyLevelCtrl:StartRetract()
  self._mapNode.ActorAnimRoot:SetBool("Is_PullSlow", false)
  WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
  self._mapNode.floorCtrl:StartRetract(function()
    self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_end")
  end)
end

function GoldenSpyLevelCtrl:UseSkill(skillId)
  if skillId == nil then
    return
  end
  local skillCfg = ConfigTable.GetData("GoldenSpySkill", skillId)
  if skillCfg == nil then
    return
  end
  if skillCfg.SkillType == GameEnum.GoldenSpySkillType.Boom then
    self:OnBtnClick_Boom()
  elseif skillCfg.SkillType == GameEnum.GoldenSpySkillType.Frozen then
    self:OnBtnClick_Frozen()
  elseif skillCfg.SkillType == GameEnum.GoldenSpySkillType.FishingHook then
    self:OnBtnClick_FishingHook()
  end
end

function GoldenSpyLevelCtrl:OnBtnClick_Pause()
  if not self.bStartFloor then
    return
  end
  self.bInPause = true
  self:Pause()
  local bHasDic = self.floorCfg.DictionaryID ~= 0
  self._mapNode.PausePanel:Open(bHasDic)
end

function GoldenSpyLevelCtrl:ShowTargetScore()
  self._mapNode.targetScoreCtrl:ShowPanel(self.floorCfg.GoalScore, self.nCurScore)
end

function GoldenSpyLevelCtrl:OnBtnClick_Hook()
  if self.bInCharAnimator then
    return
  end
  if not self.bStartFloor then
    return
  end
  local cfg = ConfigTable.GetData("GoldenSpyConfig", self.levelCfg.ConfigId)
  if cfg == nil then
    return
  end
  local nSpeed = cfg.BaseSpeed
  local nRadius = cfg.BaseRadius
  local nFactor = cfg.BaseFactor
  local nMinSpeed = cfg.MinSpeed
  for _, v in ipairs(self.GoldenSpyLevelData:GetBuffData()) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and self.GoldenSpyLevelData:CheckBuffActive(v) then
      if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.SpeedUpHook then
        nSpeed = nSpeed + buffCfg.Params[1]
      end
      if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddHookRadius then
        nRadius = nRadius + buffCfg.Params[1]
      end
      if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddHookK then
        nFactor = nFactor + buffCfg.Params[1]
      end
    end
  end
  
  local function finishCallback()
  end
  
  local function catchedCallback(tbItemCtrl)
    if tbItemCtrl == nil or #tbItemCtrl == 0 then
      WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
      return
    end
    if tbItemCtrl[1]:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
      WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
      return
    end
    self:CatchedItem(tbItemCtrl)
    WwiseAudioMgr:PostEvent("Mode_steal_get")
    local nTotalWeight = 0
    for _, itemCtrl in ipairs(tbItemCtrl) do
      local itemNormalWeight = itemCtrl:GetWeight()
      for _, v in ipairs(self.GoldenSpyLevelData:GetBuffData()) do
        local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
        if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.ReduceItemWeight and self.GoldenSpyLevelData:CheckBuffActive(v) and itemCtrl:GetItemCfg().ItemType == buffCfg.Params[1] then
          itemNormalWeight = itemNormalWeight - buffCfg.Params[2]
        end
      end
      nTotalWeight = nTotalWeight + itemNormalWeight
    end
    local cfg = ConfigTable.GetData("GoldenSpyConfig", self.levelCfg.ConfigId)
    if cfg ~= nil then
      self._mapNode.ActorAnimRoot:SetBool("Is_PullSlow", nTotalWeight > cfg.PullSlowWeight)
    end
    self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_start")
  end
  
  local function catchedCompleteCallback(tbItemCtrl)
    if tbItemCtrl == nil or #tbItemCtrl == 0 then
      self._mapNode.floorCtrl:ResumeHookSwing()
      self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_end")
      return
    end
    if tbItemCtrl[1]:GetItemCfg().ItemType == GameEnum.GoldenSpyItem.Boom then
      self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_end")
      return
    end
    local cfg = ConfigTable.GetData("GoldenSpyConfig", self.levelCfg.ConfigId)
    if cfg == nil then
      return
    end
    local nTotalScore = 0
    for _, itemCtrl in ipairs(tbItemCtrl) do
      local itemCfg = itemCtrl:GetItemCfg()
      local nScore = itemCfg.Score
      for _, v in ipairs(self.GoldenSpyLevelData:GetBuffData()) do
        local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
        if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and buffCfg.Params[1] == itemCfg.ItemType then
          if self.GoldenSpyLevelData:CheckBuffActive(v) then
            nScore = nScore + buffCfg.Params[2]
          end
          nTotalScore = nTotalScore + nScore
        end
      end
    end
    if nTotalScore >= cfg.GetHighValue then
      self._mapNode.ActorAnimRoot:Play("ActorPanel_Win")
      WwiseAudioMgr:PostEvent("Mode_steal_nice")
      self.bInCharAnimator = true
      local timer = self:AddTimer(1, 0.7, function()
        self._mapNode.floorCtrl:ResumeHookSwing()
        self.bInCharAnimator = false
        self:CatchedComplete(tbItemCtrl)
      end, true, true, true)
      table.insert(self.tbTimer, timer)
    else
      self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_end")
      self._mapNode.floorCtrl:ResumeHookSwing()
      self:CatchedComplete(tbItemCtrl)
    end
    WwiseAudioMgr:PostEvent("Mode_steal_get_stop")
  end
  
  if NovaAPI.IsEditorPlatform() then
    print("GoldenSpyLevelCtrl:nSpeed=", nSpeed)
    print("GoldenSpyLevelCtrl:nRadius=", nRadius)
    print("GoldenSpyLevelCtrl:nFactor=", nFactor)
    print("GoldenSpyLevelCtrl:nMinSpeed=", nMinSpeed)
  end
  self._mapNode.floorCtrl:Shoot(nSpeed, nRadius, nFactor, nMinSpeed, finishCallback, catchedCallback, catchedCompleteCallback)
end

function GoldenSpyLevelCtrl:OnBtnClick_Skill1()
  if #self.skillList < 1 then
    return
  end
  self:UseSkill(self.skillList[1])
end

function GoldenSpyLevelCtrl:OnBtnClick_Skill2()
  if #self.skillList < 2 then
    return
  end
  self:UseSkill(self.skillList[2])
end

function GoldenSpyLevelCtrl:OnBtnClick_Boom()
  if self.bInCharAnimator then
    return
  end
  if not self.bStartFloor then
    return
  end
  local skillData = self.GoldenSpyLevelData:GetSkillData()
  if skillData[BoomSkillId] == nil or skillData[BoomSkillId] <= 0 then
    return
  end
  local bUsed = self._mapNode.floorCtrl:StartBoom(function()
    self._mapNode.ActorAnimRoot:SetBool("Is_PullSlow", false)
    self._mapNode.ActorAnimRoot:Play("ActorPanel_Boom")
  end, function()
    self._mapNode.ActorAnimRoot:Play("ActorPanel_Pull_end")
  end)
  if bUsed then
    local BoomSkillId = 0
    local btn_Skill
    for i = 1, #self.skillList do
      local skillId = self.skillList[i]
      local skillCfg = ConfigTable.GetData("GoldenSpySkill", skillId)
      if skillCfg ~= nil and skillCfg.SkillType == GameEnum.GoldenSpySkillType.Boom then
        BoomSkillId = skillId
        btn_Skill = self._mapNode["btn_Skill" .. i]
        break
      end
    end
    if BoomSkillId == 0 or btn_Skill == nil then
      return
    end
    self.GoldenSpyLevelData:UseSkill(BoomSkillId)
    local newSkillData = self.GoldenSpyLevelData:GetSkillData()
    local mask = btn_Skill.transform:Find("AnimRoot/mask"):GetComponent("Image")
    if newSkillData[BoomSkillId] == nil or newSkillData[BoomSkillId] <= 0 then
      mask.gameObject:SetActive(true)
      local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txt_count, 0)
    else
      mask.gameObject:SetActive(false)
      local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txt_count, string.format("%d", newSkillData[BoomSkillId]))
    end
    self._mapNode.skill_Boom:SetActive(true)
    self._mapNode.skill_Boom.transform:SetParent(self._mapNode.HookEffectParent.transform)
    self._mapNode.skill_Boom:GetComponent("RectTransform").anchoredPosition = Vector2.zero
    self._mapNode.skill_Boom.transform:SetParent(self._mapNode.rtEffectRoot.transform)
    local timer = self:AddTimer(1, 0.6, function()
      self._mapNode.skill_Boom:GetComponent("RectTransform").anchoredPosition = Vector2.zero
      self._mapNode.skill_Boom:SetActive(false)
      local nCount = 0
      local items = self.GoldenSpyFloorData:GetItems()
      for k, v in pairs(items) do
        local itemCfg = ConfigTable.GetData("GoldenSpyItem", k)
        if itemCfg ~= nil and itemCfg.ItemType ~= GameEnum.GoldenSpyItem.Boom then
          nCount = nCount + v.itemCount
        end
      end
      if items == nil or nCount <= 0 then
        self:FinishFloor()
      end
    end, true, true, true)
    table.insert(self.tbTimer, timer)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("GoldenSpy_NoneBoom"))
  end
end

function GoldenSpyLevelCtrl:OnBtnClick_Frozen()
  if self.bInFrozen then
    return
  end
  if self.bInCharAnimator then
    return
  end
  if not self.bStartFloor then
    return
  end
  local skillData = self.GoldenSpyLevelData:GetSkillData()
  if skillData[FrozenSkillId] == nil or skillData[FrozenSkillId] <= 0 then
    return
  end
  if not self._mapNode.floorCtrl:CheckHasFrozenItem() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("GoldenSpy_NoneFrozen"))
    return
  end
  WwiseAudioMgr:PostEvent("Mode_steal_ice_boom")
  self._mapNode.floorCtrl:StartFrozen()
  self.bInFrozen = true
  local FrozenSkillId = 0
  local btn_Skill
  for i = 1, #self.skillList do
    local skillId = self.skillList[i]
    local skillCfg = ConfigTable.GetData("GoldenSpySkill", skillId)
    if skillCfg ~= nil and skillCfg.SkillType == GameEnum.GoldenSpySkillType.Frozen then
      FrozenSkillId = skillId
      btn_Skill = self._mapNode["btn_Skill" .. i]
      break
    end
  end
  if FrozenSkillId == 0 or btn_Skill == nil then
    self.bInFrozen = false
    return
  end
  self.GoldenSpyLevelData:UseSkill(FrozenSkillId)
  local newSkillData = self.GoldenSpyLevelData:GetSkillData()
  local mask = btn_Skill.transform:Find("AnimRoot/mask"):GetComponent("Image")
  if newSkillData[FrozenSkillId] == nil or newSkillData[FrozenSkillId] <= 0 then
    mask.gameObject:SetActive(true)
    local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_count, 0)
  else
    mask.gameObject:SetActive(false)
    local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_count, string.format("%d", newSkillData[FrozenSkillId]))
  end
  local skillcfg = ConfigTable.GetData("GoldenSpySkill", FrozenSkillId)
  local nTime = skillcfg.Params[1]
  if nTime <= 0 then
    self.bInFrozen = false
    return
  end
  local timer = self:AddTimer(1, nTime, function()
    self._mapNode.floorCtrl:StopFrozen()
    self.bInFrozen = false
    if self._mapNode.floorCtrl:CheckHasFrozenItem() then
      WwiseAudioMgr:PostEvent("Mode_steal_ice_break")
    end
  end, true, true, true)
  table.insert(self.tbTimer, timer)
  local img_frozenCD = btn_Skill.transform:Find("AnimRoot/img_CD"):GetComponent("Image")
  img_frozenCD.fillAmount = 1
  img_frozenCD.gameObject:SetActive(true)
  self.FrozenTweener = DOTween.To(function()
    return img_frozenCD.fillAmount
  end, function(value)
    img_frozenCD.fillAmount = value
  end, 0, nTime):OnComplete(function()
    img_frozenCD.gameObject:SetActive(false)
  end)
end

function GoldenSpyLevelCtrl:OnBtnClick_FishingHook()
  if self.bInCharAnimator then
    return
  end
  if not self.bStartFloor then
    return
  end
  if not self._mapNode.floorCtrl:CheckCanChangeHook() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("GoldenSpy_CanNotChangeHook"))
    return
  end
  if self.bInFishingHook then
    return
  end
  self.bInFishingHook = true
  local FishingHookSkillId = 0
  local btn_Skill
  for i = 1, #self.skillList do
    local skillId = self.skillList[i]
    local skillCfg = ConfigTable.GetData("GoldenSpySkill", skillId)
    if skillCfg ~= nil and skillCfg.SkillType == GameEnum.GoldenSpySkillType.FishingHook then
      FishingHookSkillId = skillId
      btn_Skill = self._mapNode["btn_Skill" .. i]
      break
    end
  end
  if FishingHookSkillId == 0 or btn_Skill == nil then
    self.bInFishingHook = false
    return
  end
  local skillData = self.GoldenSpyLevelData:GetSkillData()
  if skillData[FishingHookSkillId] == nil or skillData[FishingHookSkillId] <= 0 then
    self.bInFishingHook = false
    return
  end
  self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_level_task_02")
  self.GoldenSpyLevelData:UseSkill(FishingHookSkillId)
  local newSkillData = self.GoldenSpyLevelData:GetSkillData()
  local mask = btn_Skill.transform:Find("AnimRoot/mask"):GetComponent("Image")
  if newSkillData[FishingHookSkillId] == nil or newSkillData[FishingHookSkillId] <= 0 then
    mask.gameObject:SetActive(true)
    local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_count, 0)
  else
    mask.gameObject:SetActive(false)
    local txt_count = btn_Skill.transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_count, string.format("%d", newSkillData[FishingHookSkillId]))
  end
  local skillcfg = ConfigTable.GetData("GoldenSpySkill", FishingHookSkillId)
  self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.FishingHook, tonumber(skillcfg.Params[1]))
  local nTime = skillcfg.Params[2]
  if nTime <= 0 then
    self.bInFishingHook = false
    return
  end
  local timer = self:AddTimer(1, nTime, function()
    self._mapNode.floorCtrl:SetHookType(AllEnum.GoldenSpyHookType.Normal, 0)
    self:SetPngSprite(self._mapNode.img_hook, string.format(SpritePath, self.nActId) .. "btn_goldenspy_game_01")
    self.bInFishingHook = false
  end, true, true, true)
  table.insert(self.tbTimer, timer)
  local img_FishingHookCD = btn_Skill.transform:Find("AnimRoot/img_CD"):GetComponent("Image")
  img_FishingHookCD.fillAmount = 1
  img_FishingHookCD.gameObject:SetActive(true)
  self.FishingHookTweener = DOTween.To(function()
    return img_FishingHookCD.fillAmount
  end, function(value)
    img_FishingHookCD.fillAmount = value
  end, 0, nTime):OnComplete(function()
    img_FishingHookCD.gameObject:SetActive(false)
  end)
end

function GoldenSpyLevelCtrl:OnBtnClick_ToolBox()
  self:Pause()
  local tbShowItem = {}
  local tbItems = self.GoldenSpyFloorData:GetItems()
  local tbHasBuff = self.GoldenSpyLevelData:GetBuffData()
  for _, v in pairs(tbItems) do
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", v.itemId)
    if itemCfg ~= nil and itemCfg.ShowValue ~= false then
      local nScore = itemCfg.Score
      for _, n in ipairs(tbHasBuff) do
        local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", n.buffId)
        if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and self.GoldenSpyLevelData:CheckBuffActive(n) and buffCfg.Params[1] == itemCfg.ItemType then
          nScore = nScore + buffCfg.Params[2]
        end
      end
      local itemData = {
        itemId = v.itemId,
        score = nScore
      }
      table.insert(tbShowItem, itemData)
    end
  end
  
  local function callback()
    self:Resume()
  end
  
  local tbSortBuff = self:SortBuff(tbHasBuff)
  self._mapNode.ToolBoxPanel:Show(tbShowItem, tbSortBuff, callback, self.nActId, self._panel.nTipsPanelId)
end

function GoldenSpyLevelCtrl:GoldenSpy_Exit_OnClick()
  self.bInPause = false
  self._mapNode.floorCtrl:Exit()
  self:ClearTimer()
  self._mapNode.PausePanel:Close()
  self:FinishFloor()
end

function GoldenSpyLevelCtrl:GoldenSpy_Restart_OnClick()
  self.bInPause = false
  self._mapNode.floorCtrl:Exit()
  self:ClearTimer()
  self.GoldenSpyLevelData:RestartCurrentFloor()
  self.animator:Play("GoldenSpyPanel_in")
  self:Init()
  self:InitSkill(true)
  self._mapNode.floorCtrl:Init(self.nLevelId, self.nCurFloorId, self)
  self:EnterGame()
  self._mapNode.PausePanel:Close()
end

function GoldenSpyLevelCtrl:GoldenSpy_Continue_OnClick()
  self.bInPause = false
  self._mapNode.PausePanel:Close()
  self:Resume()
end

function GoldenSpyLevelCtrl:GoldenSpy_OpenDic_OnClick()
  if self.floorCfg.DictionaryID ~= 0 then
    self:Pause()
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.floorCfg.DictionaryID, true)
  end
end

function GoldenSpyLevelCtrl:ClearTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  if self.addTween ~= nil then
    self.addTween:Kill(false)
    self.addTween = nil
  end
  if self.AddScoreTimer ~= nil then
    self.AddScoreTimer:Cancel()
    self.AddScoreTimer = nil
  end
  if self.FrozenTweener ~= nil then
    self.FrozenTweener:Kill()
    self.FrozenTweener = nil
  end
  if self.FishingHookTweener ~= nil then
    self.FishingHookTweener:Kill()
    self.FishingHookTweener = nil
  end
  for _, v in ipairs(self.tbTimer) do
    if v ~= nil then
      v:Cancel()
    end
  end
  self.tbTimer = {}
  self.bInCharAnimator = false
end

function GoldenSpyLevelCtrl:OnEvent_UpdateTaskScore(nScore)
  self:UpdateTaskUI()
end

function GoldenSpyLevelCtrl:OnEvent_UpdateSkillCount(nSkillId, nCount)
  nCount = nCount or 0
  nCount = math.floor(nCount)
  for i = 1, #self.skillList do
    local skillId = self.skillList[i]
    if skillId == nSkillId then
      local txt_count = self._mapNode["btn_Skill" .. i].transform:Find("AnimRoot/db_skillCount/txt_skillCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txt_count, string.format("%d", nCount))
      local mask = self._mapNode["btn_Skill" .. i].transform:Find("AnimRoot/mask"):GetComponent("Image")
      mask.gameObject:SetActive(nCount == 0)
      break
    end
  end
end

function GoldenSpyLevelCtrl:OnEvent_FinishFloor()
  self:FinishFloor()
end

function GoldenSpyLevelCtrl:OnEvent_CompanionAddScore(nScore, vPos)
  NovaAPI.SetTMPText(self._mapNode.txt_CompanionAddScore, string.format("+%d", nScore))
  self._mapNode.go_CompanionAddScore.gameObject:SetActive(true)
  vPos = vPos + Vector2(50, 100)
  self._mapNode.go_CompanionAddScore:GetComponent("RectTransform").anchoredPosition = vPos
  self:AddTimer(1, 0.8, function()
    self._mapNode.go_CompanionAddScore.gameObject:SetActive(false)
  end, true, true, true)
end

function GoldenSpyLevelCtrl:OnEvent_CloseDic(panelId)
  if self.bInPause then
    return
  end
  if panelId == PanelId.DictionaryEntry then
    self:Resume()
  end
end

function GoldenSpyLevelCtrl:OnEvent_GoldenSpyHookResumeSwing()
  local hookMask = self._mapNode.btn_Hook.transform:Find("AnimRoot/mask"):GetComponent("Image")
  hookMask.gameObject:SetActive(false)
end

function GoldenSpyLevelCtrl:OnEvent_GoldenSpyHookStartExtend()
  local hookMask = self._mapNode.btn_Hook.transform:Find("AnimRoot/mask"):GetComponent("Image")
  hookMask.gameObject:SetActive(true)
end

function GoldenSpyLevelCtrl:OnEvent_GoldenSpy_TargetScore_Close()
  self:StartFloor()
end

function GoldenSpyLevelCtrl:OnEvent_GM_GoldenSpy_RefreshTask()
  if self.nLevelType == GameEnum.GoldenSpyLevelType.Quest or self.nLevelType == GameEnum.GoldenSpyLevelType.Random then
    self.GoldenSpyLevelData:RefreshTask()
    self:UpdateTaskUI()
  end
end

function GoldenSpyLevelCtrl:OnEvent_GM_GoldenSpy_AddSkill(nSkillId, nCount)
  self.GoldenSpyLevelData:AddSkill(nSkillId, nCount)
end

function GoldenSpyLevelCtrl:OnEvent_GM_GoldenSpy_AddBuff(nBuffId)
  self:AddBuff(nBuffId)
end

function GoldenSpyLevelCtrl:OnEvent_GM_GoldenSpy_AddScore()
  self:UpdateScoreText()
end

return GoldenSpyLevelCtrl
