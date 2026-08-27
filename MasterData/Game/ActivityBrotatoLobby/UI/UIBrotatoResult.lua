local UIBrotatoResult = class("UIBrotatoResult", UIBaseWindow)
local base = UIBaseWindow
local FmtEnum = require("Game.Formation.FmtEnum")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local UINShareCommonBtn = require("Game.Share.UI.UINShareCommonBtn")
local eShare = require("Game.Share.eShare")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader

function UIBrotatoResult:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_confirm, self, self.OnConfirmBtnClick)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
  self._chipItemPool = UIItemPool.New(UINChipItemPress, self.ui.obj_ChipItem)
  self._buffItemPool = UIItemPool.New(UINDungeonBuffItem, self.ui.obj_BuffItem)
  self.ui.obj_ChipItem:SetActive(false)
  self.ui.obj_BuffItem:SetActive(false)
  self._shareBtn = UINShareCommonBtn.New()
  self._shareBtn:Init(self.ui.shareCommonButton)
  self._shareBtn:Hide()
end

function UIBrotatoResult:InitBrotatoResult(scoreShow, isWin, closeCallback)
  self.closeCallback = closeCallback
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer ~= nil then
    local chipList = dynPlayer:GetChipList()
    if table.count(chipList) == 0 then
      self.ui.obj_ChipEmpty:SetActive(true)
    else
      self.ui.obj_ChipEmpty:SetActive(false)
    end
    table.sort(chipList, function(chipA, chipB)
      local levelA = chipA:GetChipRealLevel()
      local levelB = chipB:GetChipRealLevel()
      if levelA ~= levelB then
        return levelA > levelB
      end
      local chipAId = chipA:GetChipCfg().id
      local chipBId = chipB:GetChipCfg().id
      return chipAId > chipBId
    end)
    for index, chipData in ipairs(chipList) do
      local chipItem = self._chipItemPool:GetOne()
      chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    end
    local buffList = dynPlayer:GetEpBuffList()
    if table.count(buffList) == 0 then
      self.ui.obj_BuffEmpty:SetActive(true)
    else
      self.ui.obj_BuffEmpty:SetActive(false)
    end
    table.sort(buffList, function(epBuffA, epBuffB)
      local epBuffACfg = epBuffA:GetBuffCfg()
      local epBuffBCfg = epBuffB:GetBuffCfg()
      if epBuffACfg.buff_type ~= epBuffBCfg.buff_type then
        if epBuffACfg.buff_type == eBuffType.Debeneficial then
          return true
        elseif epBuffACfg.buff_type == eBuffType.Beneficial then
          return false
        elseif epBuffBCfg.buff_type == eBuffType.Debeneficial then
          return false
        else
          return true
        end
      end
      return epBuffA:GetBuffDataId() > epBuffB:GetBuffDataId()
    end)
    for index, buffData in ipairs(buffList) do
      if buffData:IsBuffNeedShowOnBuffList() then
        local buffItem = self._buffItemPool:GetOne()
        buffItem:InitBuffByCfg(buffData, buffData:GetBuffCfg(), self.__ShowBuffDescription, self.__HideBuffDetail)
      end
    end
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.obj_BuffList)
    if ExplorationManager.epMvpData ~= nil then
      local heroId, MvpType, diggestRate = ExplorationManager.epMvpData:GetEpMvpData()
      local heroData = dynPlayer.heroDic[heroId]
      if heroData == nil then
        local heroCfg = ConfigData.hero_data[heroId]
        heroData = HeroData.New({
          basic = {
            id = heroId,
            level = 1,
            exp = 0,
            star = heroCfg.rank,
            potentialLvl = 0,
            ts = -1,
            career = heroCfg.career,
            company = heroCfg.camp,
            skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
          }
        })
      end
      ExplorationManager:PlayMVPVoice(heroId)
      if self.bigImgResloader ~= nil then
        self.bigImgResloader:Put2Pool()
      end
      self.bigImgResloader = cs_ResLoader.Create()
      self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResPicName(), SkinEnum.fromWhere.mpv), function(prefab)
        DestroyUnityObject(self.bigImgGameObject)
        self.bigImgGameObject = prefab:Instantiate(self.ui.rect_heroHolder)
        local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
        commonPicCtrl:SetPosType("HeroList")
      end)
    end
  end
  self.ui.obj_Clear:SetActive(isWin)
  local curLevel = ExplorationManager:GetCurLevelIndex() + 1
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  if sectorStageCfg ~= nil then
    self.ui.tex_Progress.text = LanguageUtil.GetLocaleText(sectorStageCfg.name)
  end
  local isCanShowNewRecord = false
  if scoreShow ~= nil then
    local curScore = scoreShow.show[24].score
    self.ui.tex_hurtValue:SetIndex(0, tostring(curScore))
    self.ui.tex_levelValue:SetIndex(0, tostring(math.ceil(scoreShow.buffRateFix * 0.01)))
    self.ui.tex_scoreRateValue:SetIndex(0, tostring(scoreShow.buffRateFix * 0.1))
    self.ui.tex_point.text = tostring(scoreShow.score)
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    if activityCtrl ~= nil then
      local brotataoData = activityCtrl:GetBrotataoData()
      if brotataoData ~= nil then
        local highestScore = brotataoData:GetBrotatoGameHistoryScore()
        if highestScore ~= -1 and curScore > highestScore then
          isCanShowNewRecord = true
        end
      end
    end
  end
  self.ui.obj_NewRecord:SetActive(isCanShowNewRecord)
  local shareCtr = ControllerManager:GetController(ControllerTypeId.Share, true)
  if shareCtr:IsShareUnlock() then
    self._shareId = eShare.eShareType.CommonReward
    self._shareBtn:Show()
    self._shareBtn:InitShareCommonBtn(BindCallback(self, self._OnClickShare), self._shareId)
  end
end

function UIBrotatoResult:ShowFirstGetReward(getRewardList, overflowInfo)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseDic(getRewardList):SetCRNotHandledGreat(true):SetCRItemCustomTransDic(overflowInfo)
    window:AddAndTryShowReward(CRData)
  end)
end

function UIBrotatoResult:_OnClickShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      self:_ShareShow(false)
    end):SetShareAfterCaptureFunc(function()
      self:_ShareShow(true)
    end):InitShare(self._shareId)
  end)
end

function UIBrotatoResult:_ShareShow(show)
  self._shareBtn.gameObject:SetActive(show)
  self.ui.btn_confirm.gameObject:SetActive(show)
end

function UIBrotatoResult:OnConfirmBtnClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBrotatoResult:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIBrotatoResult:ShowBuffDescription(item, buffCfg)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local des = buffCfg.describe
  if not self.__eHAType then
    self.__eHAType = HAType.autoCenter
  end
  if not self.__eVAtype then
    self.__eVAtype = VAType.up
  end
  if not self.__shiftX then
    self.__shiftX = 0
  end
  if not self.__shiftY then
    self.__shiftY = 0.5
  end
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(des))
  win:FloatTo(item.transform, self.__eHAType, self.__eVAtype, self.__shiftX, self.__shiftY)
end

function UIBrotatoResult:SetBuffDetailFloatAlign(eHAType, eVAtype, shiftX, shiftY)
  self.__eHAType = eHAType
  self.__eVAtype = eVAtype
  self.__shiftX = shiftX
  self.__shiftY = shiftY
end

function UIBrotatoResult:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UIBrotatoResult:_ShowChipDesc(chipData, chipItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDesc))
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

function UIBrotatoResult:_HideChipDesc(chipData, chipItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIBrotatoResult:OnDelete()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self._chipItemPool ~= nil then
    self._chipItemPool:DeleteAll()
    self._chipItemPool = nil
  end
  if self._buffItemPool ~= nil then
    self._buffItemPool:DeleteAll()
    self._buffItemPool = nil
  end
  self.closeCallback = nil
  base.OnDelete(self)
end

return UIBrotatoResult
