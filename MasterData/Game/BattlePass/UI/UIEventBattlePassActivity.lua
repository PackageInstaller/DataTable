local UIEventBattlePass = require("Game.BattlePass.UI.UIEventBattlePass")
local base = UIEventBattlePass
local UIEventBattlePassActivity = class("UIEventBattlePassActivity", base)
local UINBattlePassTableActivity = require("Game.BattlePass.UI.UINBattlePassTableActivity")
local UIHeroSkinShowTool = require("Game.CommonUI.Skin.UIHeroSkinShowTool")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINBattlePassTaskActivity = require("Game.BattlePass.UI.UINBattlePassTaskActivity")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UIEventBattlePassActivity:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.SetTopStatusBtnShow(false, false)
  self._resLoader = CS_ResLoader.Create()
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:OpenOtherWin()
    self:SetFromWhichUI(eBaseWinFromWhere.home)
  end
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnBtnTaskClicked)
  UIUtil.AddButtonListener(self.ui.btn_BuyLevel, self, self.OnBtnBuyLevelClicked)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBtnBuyClicked)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnBtnGetAllClicked)
  UIUtil.AddButtonListener(self.ui.btn_Tips, self, self.OnBtnTipsClicked)
  UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self._OnClickShowRoleModel)
  UIUtil.AddButtonListener(self.ui.btn_skinUpJump, self, self._OnClickSkinUpJump)
  UIUtil.AddButtonListener(self.ui.btn_switch, self, self._OnClickBtnSwitch)
  self.originExpWidth = self.ui.img_ExpFill.transform.sizeDelta.x
  self.originExpHeight = self.ui.img_ExpFill.transform.sizeDelta.y
  self.passTableNode = UINBattlePassTableActivity.New()
  self.passTableNode:Init(self.ui.passTable)
  self.skinTool = UIHeroSkinShowTool.New()
  self.skinTool:InitSkinShow(self.ui.heroHolder, self.ui.picHolder, self:GetWindowSortingLayer(), "BattlePass")
  self.taskNode = UINBattlePassTaskActivity.New()
  self.taskNode:Init(self.ui.taskNode)
  self.__onBattlePassDataChange = BindCallback(self, self.OnBattlePassDataChange)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  self.__BpTaskUpdateCallback = BindCallback(self, self.RefreshBattlePassActivityRedDot)
  self.__BpSkinUpgradeCallback = BindCallback(self, self.__BpSkinUpgrade)
  MsgCenter:AddListener(eMsgEventId.BattlePassTaskUpdate, self.__BpTaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.BattlePassRunningEnd, self.__BpTaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__BpSkinUpgradeCallback)
end

function UIEventBattlePassActivity:InitBattlePassUI(activityId)
  local passInfo = PlayerDataCenter.battlepassData.passInfos[activityId]
  self.passInfo = passInfo
  if self.passInfo == nil then
    return
  end
  self.passInfoCfg = self.passInfo:GetPassCfg()
  if not string.IsNullOrEmpty(self.passInfoCfg.bp_title_image) then
    self.ui.img_Title.gameObject:SetActive(false)
    local path = PathConsts:GetActivityBattlePassPath(self.passInfoCfg.bp_title_image)
    self._resLoader:LoadABAssetAsync(path, function(texture)
      if texture == nil then
        return
      end
      if IsNull(self.transform) then
        return
      end
      self.ui.img_Title.texture = texture
      self.ui.img_Title.gameObject:SetActive(true)
    end)
  end
  local color = self.passInfoCfg.color
  self.mainColor = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  self._defaultColor1 = self.mainColor
  self._defaultColor2 = self.ui.tex_BuyLevel.color
  self._disableColor1 = Color.New(0.41, 0.41, 0.41)
  self._disableColor2 = Color.New(0.76, 0.76, 0.76)
  self.ui.img_GetAll.color = self.mainColor
  self.ui.img_SliderBar.color = self.mainColor
  self.ui.img_HeroName.color = self.mainColor
  self.ui.img_HeadLine.color = self.mainColor
  self.skinListCount = #self.passInfoCfg.banner_skinList
  self.skinIndex = math.random(0, self.skinListCount - 1)
  if 1 >= self.skinListCount then
    self.ui.btn_switch.gameObject:SetActive(false)
  end
  self:UpdateBattlePassSkin()
  self:InitBattlePassStaticUI()
  self:UpdateBattlePassBase(passInfo)
  self.passTableNode:InitBattlePassTable(self.passInfo)
  self:_UpdSkinUpgrade()
end

function UIEventBattlePassActivity:UpdateBattlePassSkin()
  local tempSkinId = self.passInfoCfg.banner_skinList[self.skinIndex + 1]
  if tempSkinId == self._skinId then
    return
  end
  self._skinId = tempSkinId
  local skinCfg = ConfigData.skin[self._skinId]
  if skinCfg ~= nil then
    self._heroId = PlayerDataCenter.skinData:GetHeroIdBySkinId(self._skinId)
    local heroCfg = ConfigData.hero_data[self._heroId]
    self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
    self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  end
  self.ui.tex_ActivityName.text = LanguageUtil.GetLocaleText(self.passInfoCfg.name)
  self.skinIndex = (self.skinIndex + 1) % self.skinListCount
end

function UIEventBattlePassActivity:UpdateBattlePassBase(passInfo)
  base.UpdateBattlePassBase(self, passInfo)
  self.ui.leftLockSenior:SetActive(not passInfo.unlockSenior)
  self.ui.obj_BuyedAdvance:SetActive(passInfo.unlockSenior)
  self:RefreshBattlePassActivityRedDot(passInfo)
end

function UIEventBattlePassActivity:_BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIEventBattlePassActivity:_OnClickShowRoleModel()
  if self._heroId == nil then
    return
  end
  local showCharacterSkinCtrl = ControllerManager:GetController(ControllerTypeId.ShowCharacterSkin, true)
  showCharacterSkinCtrl:InitShowCharacterSkinCtrl(self._heroId, self._skinId, nil, nil)
end

function UIEventBattlePassActivity:OnBtnBuyClicked()
  local hasBuy = self.passInfo.unlockSenior
  if hasBuy then
    return
  end
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:BuyBattlePass(self.passInfoCfg.id, BattlePassEnum.BuyQuality.Senior)
end

function UIEventBattlePassActivity:OnBtnTaskClicked()
  if not self.passInfo:IsBattlePassRunning() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(344))
    return
  end
  if self.passInfo:IsPassFullLevel() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(343))
    return
  end
  self.taskNode:Show()
  self.taskNode:InitBattlePassTask(self.passInfo)
end

function UIEventBattlePassActivity:UpdateBattlePassEndTime()
  local endTime = self.passInfo:GetBattlePassEndTime()
  local tipIndex = 0
  if endTime <= PlayerDataCenter.timestamp then
    endTime = self.passInfo:GetBattlePassRewardEndTime()
    tipIndex = 1
  end
  local lastTime = math.max(math.floor(endTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(lastTime, false, true)
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_TimeTips:SetIndex(tipIndex, tostring(d), tostring(h), tostring(m))
end

function UIEventBattlePassActivity:InitBattlePassStaticUI(isRestartTween)
  self.skinTool:ShowSkinById(self._skinId, nil, isRestartTween)
end

function UIEventBattlePassActivity:RefreshBattlePassActivityRedDot(passInfo)
  if passInfo ~= self.passInfo then
    return
  end
  self.ui.redDot_Task:SetActive(false)
  if self.passInfo == nil then
    return
  end
  if not self.passInfo:IsBattlePassRunning() then
    return
  end
  if self.passInfo:GetHasBpTaskComplete() and not self.passInfo:IsPassFullLevel() then
    self.ui.redDot_Task:SetActive(true)
  end
end

function UIEventBattlePassActivity:_OnClickSkinUpJump()
  local JumpManager = require("Game.Jump.JumpManager")
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    self._skinId,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UIEventBattlePassActivity:_OnClickBtnSwitch()
  self:UpdateBattlePassSkin()
  self:InitBattlePassStaticUI(true)
  self:OnUpgradeTimerEnd()
  self:_UpdSkinUpgrade()
end

function UIEventBattlePassActivity:_UpdSkinUpgrade()
  self:__OnUpgradeTimer()
  self.upgradeTimer = TimerManager:StartTimer(1, self.__OnUpgradeTimer, self)
end

function UIEventBattlePassActivity:__OnUpgradeTimer()
  local skinId = self._skinId
  local hasSkinUp = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
  local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinUpgrageOpen(skinId) and not PlayerDataCenter.skinData:IsSkinUpgrageEnd(skinId)
  skinUpOpen = isInTimeRange and skinUpOpen
  if not skinUpOpen then
    self:OnUpgradeTimerEnd()
  end
  self.ui.obj_skinUpgrade:SetActive(skinUpOpen)
  self.ui.btn_skinUpJump.gameObject:SetActive(hasSkinUp)
  self.ui.text_skinUpgrade:SetIndex(hasSkinUp and 0 or 1)
  local day, hour, minute = PlayerDataCenter.skinData:GetSkinUpgradeLimitTime(skinId)
  if minute < 0 then
    self.ui.obj_skinUpgrade:SetActive(false)
    return
  end
  if 0 < day then
    self.ui.text_skinUpgradeTime:SetIndex(0, tostring(day))
  elseif 0 < hour then
    self.ui.text_skinUpgradeTime:SetIndex(1, tostring(hour))
  elseif 0 <= minute then
    self.ui.text_skinUpgradeTime:SetIndex(2, tostring(minute))
  end
end

function UIEventBattlePassActivity:OnUpgradeTimerEnd()
  self.ui.obj_skinUpgrade:SetActive(false)
  if self.upgradeTimer ~= nil then
    TimerManager:StopTimer(self.upgradeTimer)
    self.upgradeTimer = nil
  end
end

function UIEventBattlePassActivity:__BpSkinUpgrade()
  self:InitBattlePassStaticUI(true)
end

function UIEventBattlePassActivity:OnDelete()
  if self.taskNode ~= nil then
    self.taskNode:Delete()
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self.upgradeTimer ~= nil then
    TimerManager:StopTimer(self.upgradeTimer)
    self.upgradeTimer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.BattlePassTaskUpdate, self.__BpTaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.BattlePassRunningEnd, self.__BpTaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__BpSkinUpgradeCallback)
  base.OnDelete(self)
end

return UIEventBattlePassActivity
