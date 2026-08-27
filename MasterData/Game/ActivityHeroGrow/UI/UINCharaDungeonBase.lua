local UINCharaDungeonBase = class("UINCharaDungeonBase", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINCharaDungeonBase:ctor(charDunWin)
  self.charDunWin = charDunWin
end

function UINCharaDungeonBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_NormalBattle, self, self.OnClickMainEp)
  UIUtil.AddButtonListener(self.ui.btn_EXBattle, self, self.OnClickChallengeEp)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self.OnClickHeroGrowShop)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickHeroGrowTask)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickActIntro)
  self.__ItemUpdateEvent = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateEvent)
  self.__RefreshChallengeBtnStateEvent = BindCallback(self, self.__RefreshChallengeBtnState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityTimePass, self.__RefreshChallengeBtnStateEvent)
  self.__OnShowCharacterDungeonUI = BindCallback(self, self.OnShowCharacterDungeonUI)
end

function UINCharaDungeonBase:InitCharaDungeonNode(heroGrowAct, enterSecotrFunc, resLoader)
  self.resloader = resLoader
  self.heroGrowAct = heroGrowAct
  self.heroGrowCfg = heroGrowAct:GetHeroGrowCfg()
  self.enterSecotrFunc = enterSecotrFunc
  self:__RefreshCoinShow()
  self:__InitDungeonShopRedot()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
  self:__RefreshChallengeBtnState()
  self:__RefreshOtherBtnState()
  self:__RefreshPreviewGroupState()
  self:__TimerCountdown()
  local mainSectorCfg = ConfigData.sector[self.heroGrowCfg.main_stage]
  local rechallengeSectorCfg = ConfigData.sector[self.heroGrowCfg.rechallenge_stage]
  self.ui.tex_MainEp_Name.text = LanguageUtil.GetLocaleText(mainSectorCfg.name)
  self.ui.tex_EXEP_Name.text = LanguageUtil.GetLocaleText(rechallengeSectorCfg.name)
  local nameStr = ""
  for i, heroId in ipairs(self.heroGrowCfg.friendship_heroList) do
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      error(" heroCfg is NIL id:" .. tostring(heroId))
    else
      nameStr = nameStr .. "[" .. LanguageUtil.GetLocaleText(heroCfg.name) .. "]"
    end
  end
  local friendship_display = tostring(self.heroGrowCfg.friendship_display) .. "%"
  self.ui.tex_Up.text = string.format(ConfigData:GetTipContent(6042), nameStr, friendship_display)
  local heroCfg = ConfigData.hero_data[self.heroGrowCfg.hero_id]
  if heroCfg == nil then
    error(" heroCfg is NIL id:" .. tostring(self.heroGrowCfg.hero_id))
    return
  end
  self.ui.tex_HeroName.text = self.heroGrowAct:GetActivityName()
  self.ui.tex_shop.text = LanguageUtil.GetLocaleText(self.heroGrowCfg.shop_name)
  self:__InitCharDunBackground()
  self.ui.tex_Main.text = ConfigData:GetTipContent(6034)
  self.ui.tex_Dun.text = ConfigData:GetTipContent(6035)
  self.ui.tex_ActEnd.text = ConfigData:GetTipContent(6033)
end

function UINCharaDungeonBase:__InitDungeonShopRedot()
  local shopNode = self.heroGrowAct:GetActivityHeroShopReddotNode()
  if self.__shopRedDotPath ~= nil and self.__shopRedDotFunc ~= nil then
    RedDotController:RemoveListener(self.__shopRedDotPath, self.__shopRedDotFunc)
  end
  
  function self.__shopRedDotFunc(node)
    self.ui.blueDot_Shop:SetActive(node:GetRedDotCount() > 0)
  end
  
  self.__shopRedDotFunc(shopNode)
  self.__shopRedDotPath = shopNode.nodePath
  RedDotController:AddListener(shopNode.nodePath, self.__shopRedDotFunc)
end

function UINCharaDungeonBase:OnClickMainEp()
  if self.enterSecotrFunc == nil then
    return
  end
  self:OnEnterHeroGrowSector(self.heroGrowCfg.main_stage)
end

function UINCharaDungeonBase:OnClickChallengeEp()
  if not self.heroGrowAct:IsActivityRunning() then
    return
  end
  self:OnEnterHeroGrowSector(self.heroGrowCfg.rechallenge_stage)
end

function UINCharaDungeonBase:OnEnterHeroGrowSector(sectorId)
  local isOpen = self.heroGrowAct:IsActivityOpen()
  if not isOpen then
    return
  end
  if self.enterSecotrFunc == nil then
    return
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  self:OnHideCharacterDungeonUI()
  self.enterSecotrFunc(sectorId, 1, nil, self.__OnShowCharacterDungeonUI, function()
    local sectorLevelWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    if sectorLevelWin ~= nil then
      sectorLevelWin:SetCustomEnterFmtCallback(function(enterFmtData)
        if enterFmtData ~= nil then
          enterFmtData:SetFmtForbidSupport(true)
          enterFmtData:SetIsShowSupportHolder(true)
        end
      end)
    end
  end)
end

function UINCharaDungeonBase:OnClickHeroGrowShop()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharacterDungeonShop, function(window)
    window:InitCharacterDungeonShop(self.heroGrowAct)
  end)
end

function UINCharaDungeonBase:OnClickHeroGrowTask()
  local isOpen = self.heroGrowAct:IsActivityOpen()
  if isOpen then
    JumpManager:Jump(JumpManager.eJumpTarget.DynTask, nil, nil, {
      TaskEnum.eTaskType.HeroActivityTask
    }, true)
  end
end

function UINCharaDungeonBase:__TimerCountdown()
  if (self._nextTime or 0) < PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.heroGrowAct)
    self.ui.tex_TimerDes.text = title
    self.ui.tex_Timer.text = timeStr
    self._nextTime = expireTime
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._nextTime)
  self.ui.tex_Days.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UINCharaDungeonBase:__RefreshChallengeBtnState()
  local inTime = self.heroGrowAct:IsActivityRunning()
  self.ui.obj_challenge_Lock:SetActive(not inTime)
  if not inTime then
    self.ui.obj_challenge_ActEnd:SetActive(not self.heroGrowAct:IsActivityPreview())
  end
  local hasLimitTimes = self.heroGrowAct:IsHeroGrowLimiTimes()
  self.ui.tex_challenge_Times.gameObject:SetActive(inTime and hasLimitTimes)
  if hasLimitTimes then
    local battleCount = self.heroGrowAct:GetHeroGrowChallengeCount()
    self.ui.tex_challenge_Times.text = string.format(ConfigData:GetTipContent(6040), tostring(battleCount))
    self.ui.blueDot_battle:SetActive(0 < battleCount)
  else
    self.ui.blueDot_battle:SetActive(false)
  end
end

function UINCharaDungeonBase:__RefreshPreviewGroupState()
  self._previewOpenTime = nil
  local preivewOpenTime = self.heroGrowCfg.preview_start
  if not string.IsNullOrEmpty(self.heroGrowCfg.preview_pic) and preivewOpenTime <= PlayerDataCenter.timestamp then
    self.ui.obj_Preview:SetActive(true)
    local str = LanguageUtil.GetLocaleText(self.heroGrowCfg.preview_text)
    if str == nil or #str == 0 then
      str = ConfigData:GetTipContent(6039)
    end
    self.ui.tex_Preview.text = str
    self.ui.img_Preview.gameObject:SetActive(false)
    self.resloader:LoadABAssetAsync(PathConsts:GetCharDunPath(self.heroGrowCfg.preview_pic), function(texture)
      if texture == nil or IsNull(self.ui.img_Preview) then
        return
      end
      self.ui.img_Preview.texture = texture
      self.ui.img_Preview.gameObject:SetActive(true)
    end)
  else
    self._previewOpenTime = preivewOpenTime
    self.ui.obj_Preview:SetActive(false)
  end
end

function UINCharaDungeonBase:__RefreshOtherBtnState()
  local inPreview = self.heroGrowAct:IsActivityPreview()
  self.ui.obj_task_Lock:SetActive(inPreview)
  self.ui.obj_main_Lock:SetActive(inPreview)
end

function UINCharaDungeonBase:OnClickActIntro()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self.heroGrowCfg.rule_content), ConfigData:GetTipContent(self.heroGrowCfg.rule_title))
  end)
end

function UINCharaDungeonBase:OnHideCharacterDungeonUI()
  if self._timerId ~= nil then
    TimerManager:PauseTimer(self._timerId)
  end
  self:Hide()
end

function UINCharaDungeonBase:OnShowCharacterDungeonUI()
  self:Show()
  if self._timerId ~= nil then
    TimerManager:ResumeTimer(self._timerId)
  end
end

function UINCharaDungeonBase:__RefreshCoinShow()
  self.ui.tex_Count.text = "x" .. tostring(PlayerDataCenter:GetItemCount(self.heroGrowCfg.token))
end

function UINCharaDungeonBase:__ItemUpdate(itemUpdate)
  if itemUpdate[self.heroGrowCfg.token] ~= nil then
    self:__RefreshCoinShow()
  end
end

function UINCharaDungeonBase:__InitCharDunBackground()
  self.ui.img_background.enabled = false
  local path = PathConsts:GetCharDunPath(self.heroGrowCfg.shop_bg)
  self.resloader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_background.enabled = true
    self.ui.img_background.texture = texture
  end)
end

function UINCharaDungeonBase:OnDelete()
  if self.__shopRedDotPath ~= nil and self.__shopRedDotFunc ~= nil then
    RedDotController:RemoveListener(self.__shopRedDotPath, self.__shopRedDotFunc)
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemUpdateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityTimePass, self.__RefreshChallengeBtnStateEvent)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnDelete(self)
end

return UINCharaDungeonBase
