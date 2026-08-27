local UIChristmas22Main = class("UIChristmas22Main", UIBaseWindow)
local base = UIBaseWindow
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")
local UINChristmasBtn = require("Game.ActivityChristmas.UI.UINChristmasBtn")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_MessageCommon = CS.MessageCommon
local cs_Material = CS.UnityEngine.Material
local cs_UIParticle = CS.Coffee.UIExtensions.UIParticle
local cs_ParticleSystemRenderer = CS.UnityEngine.ParticleSystemRenderer
local CS_LanguageGlobal = CS.LanguageGlobal
local BtnEnum = {
  StorySector = 1,
  Tech = 2,
  Bonus = 3,
  GuideSector = 4,
  Task = 5,
  Dungeon = 6
}
local BtnFuncEnum = {
  [BtnEnum.StorySector] = "OnClickStorySector",
  [BtnEnum.Tech] = "OnClickTech",
  [BtnEnum.Bonus] = "OnClickBonus",
  [BtnEnum.GuideSector] = "OnClickGuideSector",
  [BtnEnum.Task] = "OnClickTask",
  [BtnEnum.Dungeon] = "OnClickDungeon"
}

function UIChristmas22Main:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChristmas)
  UIUtil.AddButtonListener(self.ui.btn_StartListen, self, self.OnClickSeason)
  self:_InitTitleTex()
  if table.count(BtnEnum) ~= #self.ui.array_btnNode then
    if isGameDev then
      error(" btn count error")
    end
    return
  end
  self._btnNodeDic = {}
  for _, index in pairs(BtnEnum) do
    local go = self.ui.array_btnNode[index]
    local btnNode = UINChristmasBtn.New()
    btnNode:Init(go)
    local funcName = BtnFuncEnum[index]
    btnNode:InitChristmasBtn(BindCallback(self, self[funcName]))
    self._btnNodeDic[index] = btnNode
  end
  self.__RefreshCallback = BindCallback(self, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.ActivityHallowmas, self.__RefreshCallback)
  MsgCenter:AddListener(eMsgEventId.WCS_ExitAndClear, self.__RefreshCallback)
end

function UIChristmas22Main:InitChristmas22Main(hallowmasData, enterFunc, backCallback)
  AudioManager:PlayAudioById(3360)
  self._data = hallowmasData
  self._enterFunc = enterFunc
  self._backCallback = backCallback
  self._cfg = self._data:GetHallowmasMainCfg()
  self:__Refresh()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__OnTimeDown, self)
  self:__OnTimeDown()
  self._reddot = self._data:GetActivityReddot()
  if self._reddot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self._reddot.nodePath, self._reddotFunc)
    self:__RefreshReddot(self._reddot)
  end
  if self._cfg.guide_id > 0 then
    UIUtil.SetTopStateInfoFunc(self, function()
      local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
      GuidePicture.OpenGuidePicture(self._cfg.guide_id, nil)
    end)
  end
  local avgid = self._cfg.first_avg
  if 0 < avgid then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgid)
    if not played and self._data:IsActivityRunning() then
      self:Hide()
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgid, function()
        if IsNull(self.transform) then
          return
        end
        self:Show()
      end)
      return
    end
  end
  self:__TryOpenNewUnlock()
end

function UIChristmas22Main:_InitTitleTex()
  local languageInt = CS_LanguageGlobal.GetLanguageInt()
  local texture = self.ui.titleTexList[languageInt + 1]
  if IsNull(texture) then
    error(string.format("christmas22Main title texture %s is null", CS_LanguageGlobal.GetLanguageStr()))
    return
  end
  if self.titleMats ~= nil then
    self:_DestroyMats()
  end
  self.titleMats = {}
  local particleSystemRenderers = self.ui.obj_titleFxp.transform:GetComponentsInChildren(typeof(cs_ParticleSystemRenderer))
  for i = 0, particleSystemRenderers.Length - 1 do
    local render = particleSystemRenderers[i]
    local mat = cs_Material(render.material)
    render.material = mat
    table.insert(self.titleMats, mat)
    mat:SetTexture("_MainTex", texture)
  end
end

function UIChristmas22Main:_DestroyMats()
  if self.titleMats == nil then
    return
  end
  for _, mat in ipairs(self.titleMats) do
    DestroyUnityObject(mat)
  end
  self.titleMats = nil
end

function UIChristmas22Main:__TryOpenNewUnlock()
  local actUnlockInfo = self._data:GetActHallowmasUnlockInfo()
  if actUnlockInfo:IsExistActUnlockInfo() then
    UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Unlock, function(window)
      if window == nil then
        return
      end
      window:Christmas22UnlockBindFunc(BindCallback(self, self.OnClickStorySector), BindCallback(self, self.OnClickSeason), BindCallback(self, self.OnClickDungeon))
      window:InitChristmas22NewUnlock(actUnlockInfo, self._data)
    end)
  end
end

function UIChristmas22Main:EnterChristmas22Sector(selectSector)
  if selectSector == self._cfg.story_stage then
    self:OnClickStorySector()
  elseif selectSector == self._cfg.guide_stage then
    self:OnClickGuideSector()
  end
end

function UIChristmas22Main:__OnTimeDown()
  if self._expireTime == nil or self._expireTime > PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._data)
    self.ui.title.text = title
    self.ui.tex_Timer.text = timeStr
    self._expireTime = expireTime
  end
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime)
  self.ui.tex_Days.text = diffStr
  if diff <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIChristmas22Main:__Refresh()
  self.ui.tex_bound_Progress:SetIndex(0, tostring(self._data:GetHallowmasLv()), tostring(self._data:GetHallowmasCurExp()), tostring(self._data:GetHallowmasCurExpLimit()))
  local taskCount = table.count(self._data:GetHallowmasDailyTaskIdDic())
  self.ui.tex_task_Progress.text = tostring(taskCount) .. "/" .. tostring(self._cfg.task_limit)
  local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
  self.ui.img_ListeningBg:SetActive(isUnComplete)
end

function UIChristmas22Main:__RefreshReddot(reddot)
  local taskRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.DailyTask)
  local expRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Exp)
  local achievementRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Achievement)
  local sectorAvgRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.SectorAvg)
  local techRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Tech)
  local techItemRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.TechItemLimit)
  local taskRedCount = taskRed ~= nil and taskRed:GetRedDotCount() or 0
  local expRedCount = expRed ~= nil and expRed:GetRedDotCount() or 0
  local achievementRedCount = achievementRed ~= nil and achievementRed:GetRedDotCount() or 0
  local sectorAvgRedCount = sectorAvgRed ~= nil and sectorAvgRed:GetRedDotCount() or 0
  local techRedCount = techRed ~= nil and techRed:GetRedDotCount() or 0
  local techItemRedCount = techItemRed ~= nil and techItemRed:GetRedDotCount() or 0
  self._btnNodeDic[BtnEnum.StorySector]:SetChristmasBtnRed(0 < sectorAvgRedCount)
  self._btnNodeDic[BtnEnum.Tech]:SetChristmasBtnRed(0 < techRedCount)
  self._btnNodeDic[BtnEnum.Tech]:SetChristmasBtnBlue(techRedCount == 0 and 0 < techItemRedCount)
  self._btnNodeDic[BtnEnum.Bonus]:SetChristmasBtnRed(0 < expRedCount)
  self._btnNodeDic[BtnEnum.Task]:SetChristmasBtnRed(0 < taskRedCount or 0 < achievementRedCount)
end

function UIChristmas22Main:OnClickStorySector()
  if not SectorStageDetailHelper.IsSectorNoCollide(self._cfg.story_stage, true) then
    return
  end
  if self._enterFunc == nil then
    return
  end
  self._enterFunc(self._cfg.story_stage, 1, nil, function()
    if not IsNull(self.transform) then
      self:Show()
    end
  end, function()
    if not IsNull(self.transform) then
      self:Hide()
    end
  end)
end

function UIChristmas22Main:OnClickTech()
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22StrategyOverview, function(win)
    if win == nil then
      return
    end
    win:InitChristmas22StrategyOverview(self._data:GetHallowmasTechTree(), self._cfg.tech_special_branch, function()
      if not IsNull(self.transform) then
        self:Hide()
        self:Show()
      end
    end)
  end)
end

function UIChristmas22Main:OnClickBonus()
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Bonus, function(win)
    if win == nil then
      return
    end
    self:Hide()
    win:InitHalloween22Bouns(self._data, function(tohome)
      if tohome then
        return
      end
      if not IsNull(self.transform) then
        self:Show()
        self:__TryOpenNewUnlock()
      end
    end)
  end)
end

function UIChristmas22Main:OnClickGuideSector()
  if not SectorStageDetailHelper.IsSectorNoCollide(self._cfg.guide_stage, true) then
    return
  end
  local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
  if isUnComplete then
    local tips = ConfigData:GetTipContent(self._cfg.ban_guide_tip)
    cs_MessageCommon.ShowMessageTips(tips)
    return
  end
  if self._enterFunc == nil then
    return
  end
  self._enterFunc(self._cfg.guide_stage, 1, nil, function()
    if not IsNull(self.transform) then
      self:Show()
    end
  end, function()
    if not IsNull(self.transform) then
      self:Hide()
    end
  end)
end

function UIChristmas22Main:OnClickTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Task, function(win)
    if win == nil then
      return
    end
    self:Hide()
    win:InitChristmas22Task(self._data, function(tohome)
      if tohome then
        return
      end
      if not IsNull(self.transform) then
        self:Show()
        self:__TryOpenNewUnlock()
      end
    end)
  end)
end

function UIChristmas22Main:OnClickDungeon()
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22Repeat, function(win)
    if win == nil then
      return
    end
    if self.xMasDunCallback then
      self.xMasDunCallback()
      self.xMasDunCallback = nil
    end
    win:InitXMas22DunRepeat(self._data, function()
      if not IsNull(self.transform) then
        self:Show()
      end
    end, function()
      if not IsNull(self.transform) then
        self:Hide()
      end
    end)
  end)
end

function UIChristmas22Main:SetXMasDunSectorCallback(callback)
  self.xMasDunCallback = callback
end

function UIChristmas22Main:OnClickSeason()
  local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
  if isUnComplete then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    ctrl:ContinuehallowmasSeason()
    return
  end
  if not SectorStageDetailHelper.IsWarchessSeasonNoCollide(self._cfg.warchess_season_id, true) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Christmas22ModeSelect, function(window)
    if window == nil then
      return
    end
    window:InitChristmas22ModeSelect(self._data)
  end)
end

function UIChristmas22Main:OnCloseChristmas()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:PlaySectorBgm()
  end
  self:Delete()
  if self._backCallback then
    self._backCallback(false)
  end
end

function UIChristmas22Main:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self._reddotFunc)
    self._reddot = nil
  end
  self:_DestroyMats()
  MsgCenter:RemoveListener(eMsgEventId.ActivityHallowmas, self.__RefreshCallback)
  MsgCenter:RemoveListener(eMsgEventId.WCS_ExitAndClear, self.__RefreshCallback)
  base.OnDelete(self)
end

return UIChristmas22Main
