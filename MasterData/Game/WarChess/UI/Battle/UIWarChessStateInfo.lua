local UIWarChessStateInfo = class("UIWarChessStateInfo", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINDungeonChipList = require("Game.CommonUI.DungeonState.UINDungeonChipList")
local UINDungeonBuffList = require("Game.CommonUI.DungeonState.UINDungeonBuffList")
local UINEpCampFetter = require("Game.Exploration.UI.CampFetter.UINEpCampFetter")
local UINEpResFlyAniPanel = require("Game.CommonUI.DungeonState.ResFly.UINEpResFlyAniPanel")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local CS_DOTween = CS.DG.Tweening.DOTween
local cs_Material = CS.UnityEngine.Material
local ScrambleMode = CS.DG.Tweening.ScrambleMode

function UIWarChessStateInfo:OnInit()
  self.resloader = CS_ResLoader.Create()
  self.chipList = UINDungeonChipList.New()
  self.chipList:Init(self.ui.obj_ChipList)
  self.buffList = UINDungeonBuffList.New()
  self.buffList:Init(self.ui.obj_BuffList)
  self.getChipOriginScale = self.ui.getChipItem.transform.localScale
  self.ui.getChipItem:SetActive(false)
  self.getChipPool = UIItemPool.New(UINChipItem, self.ui.getChipItem)
  self.getChipAniCache = {}
  self.__onMoneyChange = BindCallback(self, self.RefreshMoney)
  self.__onSaveMoneyChange = BindCallback(self, self.RefreshSaveMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:AddListener(eMsgEventId.EpSaveMoneyChange, self.__onSaveMoneyChange)
  self.__DungeonHeroListActiveSet = BindCallback(self, self.DungeonHeroListActiveSet)
  MsgCenter:AddListener(eMsgEventId.DungeonHeroListActiveSet, self.__DungeonHeroListActiveSet)
  self.isCampFetterUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CampConnection)
  self.epCampFetterNode = UINEpCampFetter.New()
  self.epCampFetterNode:Init(self.ui.obj_campBond)
  self.epCampFetterNode:Hide()
  self.epCampFetterNode:InitEpCampFetter(self.resloader)
  self.resFlyAniNode = UINEpResFlyAniPanel.New(self)
  self.resFlyAniNode:Init(self.ui.resFlyAnimation)
end

function UIDungeonStateInfo:InitHeroAndChip(dynPlayer)
  self.heroList:InitHeroList(dynPlayer.heroList, self.resloader, self.chipList.selectHeroCallback, dynPlayer:GetEpBuffList())
  self.chipList:InitChipList(dynPlayer, self.heroList.selectWithChipIdCallback, dynPlayer:GetChipLimitInfo())
  self.buffList:InitBuffList(dynPlayer:GetEpBuffList())
  self:UpdateAllCampFetter()
  self:RefreshMoney(true)
end

function UIDungeonStateInfo:ReInitDungeonHeroList(dynPlayer)
  self.heroList:InitHeroList(dynPlayer.heroList, self.resloader, self.chipList.selectHeroCallback, dynPlayer:GetEpBuffList())
end

function UIDungeonStateInfo:DungeonHeroListActiveSet(active)
  if active then
    local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
    if win ~= nil and win.active then
      self:SetHeroListActive(false)
      return
    end
  end
  self:SetHeroListActive(active)
  self.ui.obj_campBond:SetActive(self.isCampFetterUnlock and active)
end

function UIDungeonStateInfo:SetHeroListActive(isActive)
  if isActive then
    self.heroList:SetHpBarActive(true)
  end
  self.heroList:SetIsHideHeroList(not isActive)
end

function UIDungeonStateInfo:SetHeroListHpBar(isActive)
  self.heroList:SetHpBarActive(isActive)
end

function UIDungeonStateInfo:RefreshHeroListHp(isActive)
  self.heroList:RefreshHeroHp()
end

function UIDungeonStateInfo:ShowHero(hero)
  if hero == nil then
    self.heroList:Hide()
    return
  end
  self.heroList:Show()
  for index, value in ipairs(self.heroList.itemPool.listItem) do
    if value.dynHeroData.dataId == hero.dataId then
      self.heroList:OnHeroClick(self.heroList.itemPool.listItem[index])
      break
    end
  end
end

function UIDungeonStateInfo:RegisterHeroListCloseCallBack(callback)
  self.heroList:RegisterExrCloseCallBack(callback)
end

function UIDungeonStateInfo:CancleHeroListCloseCallBack()
  self.heroList:CancleExrCloseCallBack()
end

function UIDungeonStateInfo:OnHeroCoordChanged()
  self.heroList:OnHeroCoordChanged()
end

function UIDungeonStateInfo:TowerPlacementChange(dataId, isOn)
  self.heroList:TowerPlacementChange(dataId, isOn)
end

function UIDungeonStateInfo:SetMoneyActive(active)
  self.ui.obj_money:SetActive(active)
end

function UIDungeonStateInfo:RefreshMoney(isInit)
  local money = 0
  local dynplayer
  if ExplorationManager ~= nil then
    dynplayer = ExplorationManager:GetDynPlayer()
    if dynplayer ~= nil then
      local theMoney = dynplayer:GetMoneyCount()
      if theMoney ~= nil then
        money = theMoney
      end
    end
  end
  self.ui.tex_Money:DOKill(true)
  self.ui.tex_Money:DOText(tostring(money), 1, true, ScrambleMode.Numerals):SetLink(self.ui.tex_Money.gameObject)
  if isInit ~= true and self.active then
    AudioManager:PlayAudioById(1007)
  end
  if self.LoadMoneyIcon == nil and dynplayer ~= nil then
    local icon = dynplayer:GetMoneyIconId()
    self.ui.img_Money.sprite = CRH:GetSprite(icon)
    self.LoadMoneyIcon = true
  end
end

function UIDungeonStateInfo:SetSaveMoneyActive(active)
  self.ui.obj_saveMoney:SetActive(active)
  if active then
    self:RefreshSaveMoney()
  end
end

function UIDungeonStateInfo:RefreshSaveMoney()
  local money = 0
  if self.dynplayer ~= nil then
    local theMoney = self.dynplayer:GetEpSaveMoney()
    if theMoney ~= nil then
      money = theMoney
    end
  end
  self.ui.tex_SaveMoney.text = math.floor(money)
  self.ui.obj_saveMoney:SetActive(money ~= 0 and self.ui.obj_money.activeSelf)
end

function UIDungeonStateInfo:Show()
  if self.active then
    return
  end
  base.Show(self)
  self.chipList:ReFillList()
  self:__ClearFadeTween()
  self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 0, 1, 0.5)
  self:SetLoanMoneyActive(false)
end

function UIDungeonStateInfo:Hide(withTween)
  if not self.active then
    return
  end
  base.Hide(self)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if win ~= nil then
    win:OnClickRetreat()
  end
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.5)
  end
end

function UIDungeonStateInfo:__ClearFadeTween()
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
    self.__fadeTween = nil
  end
end

function UIDungeonStateInfo:OnHide()
  self.__startGetChipAni = false
  if self.getChipTween ~= nil then
    self.getChipTween:Kill()
    self.getChipTween = nil
  end
  self.getChipAniCache = {}
  self.ui.eff_GetItem.gameObject:SetActive(false)
  self.getChipPool:HideAll()
  self.chipList:SetListBlocksRaycasts(true)
  self.chipList:SetChipGetEffectEnable(false)
end

function UIDungeonStateInfo:ShowGetChipAni(chipData, position, scale, chipReturnMoney)
  if not self.chipList.gameObject.activeInHierarchy then
    return
  end
  table.insert(self.getChipAniCache, {
    chipData = chipData,
    position = position,
    scale = scale,
    chipReturnMoney = chipReturnMoney or 0
  })
  if not self.__startGetChipAni then
    self:__StartShowGetChipAni()
  end
end

function UIDungeonStateInfo:__StartShowGetChipAni()
  if #self.getChipAniCache == 0 then
    self.__startGetChipAni = false
    self.chipList:SetListBlocksRaycasts(true)
    return
  end
  self.chipList:SetListBlocksRaycasts(false)
  self.__startGetChipAni = true
  local getChipData = table.remove(self.getChipAniCache, 1)
  local chipData, position, scale, chipReturnMoney = getChipData.chipData, getChipData.position, getChipData.scale, getChipData.chipReturnMoney
  if not self.chipList:ListContainChip(chipData.dataId) then
    self:__StartShowGetChipAni()
  end
  self.chipList:ScrollChipItemInScreen(chipData, function(targetChipItem)
    if targetChipItem ~= nil then
      self.chipList:SetChipGetEffectEnable(true)
      local destPosition = self.transform:InverseTransformPoint(targetChipItem:GetChipItemWorldPos())
      local chipItem = self.getChipPool:GetOne()
      chipItem:InitChipItem(chipData)
      chipItem:Show()
      chipItem.transform.localPosition = position
      local curScale = scale or self.getChipOriginScale
      chipItem.transform.localScale = curScale
      self.ui.eff_GetItem.gameObject:SetActive(true)
      self.ui.eff_GetItem.transform.localPosition = destPosition
      self.ui.eff_GetItem.material:SetFloat("_UI_Player", 0)
      local sequence = CS_DOTween.Sequence()
      sequence:Append(chipItem.transform:DOLocalMove(destPosition, ConfigData.game_config.getChipMoveTime))
      sequence:Join(chipItem.transform:DOScale(self.getChipOriginScale, ConfigData.game_config.getChipMoveTime))
      sequence:AppendCallback(function()
        self.getChipPool:HideOne(chipItem)
      end)
      sequence:Append(self.ui.eff_GetItem.material:DOFloat(1, "_UI_Player", ConfigData.game_config.getChipEffectTime))
      sequence:AppendCallback(function()
        self.chipList:SetChipGetEffectEnable(false)
        self.getChipTween = nil
        self.ui.eff_GetItem.gameObject:SetActive(false)
        if 0 < chipReturnMoney then
          self:StartResFxFlyAni(1, destPosition, self.ui.img_Money.transform.position, 15)
        end
        self:__StartShowGetChipAni()
      end)
      self.getChipTween = sequence
      AudioManager:PlayAudioById(1009)
    else
      self:__StartShowGetChipAni()
    end
  end)
end

function UIDungeonStateInfo:StartResFxFlyAni(resId, origin, dest, count)
  self.resFlyAniNode:StartNewResFlyAni(resId, origin, dest, count)
end

function UIDungeonStateInfo:ChipListWeakenTween(weaken)
  if weaken then
    self.ui.topWeakenTween:DORestart()
  else
    self.ui.topWeakenTween:DOPlayBackwards()
  end
end

function UIDungeonStateInfo:OnlyShowChipList(oblyShow, showHeroListAndHpBar)
  if showHeroListAndHpBar == nil then
    showHeroListAndHpBar = not oblyShow
  end
  if oblyShow then
    self:Show()
    self:DungeonHeroListActiveSet(showHeroListAndHpBar)
    self:SetHeroListHpBar(showHeroListAndHpBar)
    self:SetMoneyActive(false)
    self:SetSaveMoneyActive(false)
    self:SetLoanMoneyActive(false)
    self:SetRareMoneyActive(false)
  else
    self:DungeonHeroListActiveSet(showHeroListAndHpBar)
    self:SetHeroListHpBar(showHeroListAndHpBar)
    self:SetMoneyActive(true)
    self:SetSaveMoneyActive(true)
    self:SetRareMoneyActive(true)
  end
end

function UIDungeonStateInfo:ShowTopInfo(enable)
  if self.ui.top_info == nil then
    return
  end
  if enable and not self.ui.top_info.activeInHierarchy then
    self.ui.top_info:SetActive(true)
    return
  end
  if not enable and self.ui.top_info.activeInHierarchy then
    self.ui.top_info:SetActive(false)
  end
end

function UIDungeonStateInfo:CheckChipListBgShow(check)
  self.chipList:CheckChipListContainerShow(check)
end

function UIDungeonStateInfo:SetLoanMoneyActive(active, couldLoanNum)
  self.ui.obj_loansMoney:SetActive(active)
  if couldLoanNum ~= nil then
    self.ui.tex_LoanMoney.text = tostring(couldLoanNum)
  end
end

function UIDungeonStateInfo:StopUseChipEffect()
  if self.chipList ~= nil then
    self.chipList:StopAllUseChipEffect()
  end
end

function UIDungeonStateInfo:UpdateAllCampFetter()
  if not self.isCampFetterUnlock then
    self.epCampFetterNode:Hide()
    return
  else
    self.epCampFetterNode:Show()
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  local usingCampFetterList, totalUsingNum = ExplorationManager.epCtrl.campFetterCtrl:GetUsingCampFetterList()
  self.epCampFetterNode:RefreshAllCampFetter(usingCampFetterList, totalUsingNum, self.resloader)
end

function UIDungeonStateInfo:GetEpCampFetterNode()
  return self.epCampFetterNode
end

function UIDungeonStateInfo:SetBuffListActive(active)
  if active then
    self.buffList:Show()
  else
    self.buffList:Hide()
  end
end

function UIDungeonStateInfo:TrySetLimitSellBtnActive(active)
  self.chipList:SetLimitSellBtnActive(active)
end

function UIDungeonStateInfo:OnDelete()
  self:__ClearFadeTween()
  if self.getChipTween ~= nil then
    self.getChipTween:Kill()
    self.getChipTween = nil
  end
  self.resloader:Put2Pool()
  self.resloader = nil
  self.chipList:Delete()
  self.heroList:Delete()
  self.buffList:Delete()
  if self.ui.eff_GetItem ~= nil then
    DestroyUnityObject(self.ui.eff_GetItem.material)
  end
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.EpSaveMoneyChange, self.__onSaveMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.DungeonHeroListActiveSet, self.__DungeonHeroListActiveSet)
  base.OnDelete(self)
end

return UIDungeonStateInfo
