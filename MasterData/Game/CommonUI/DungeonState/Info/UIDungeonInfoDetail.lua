local UIDungeonInfoDetail = class("UIDungeonInfoDetail", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINDungeonInfoChipDetail = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetail")
local UINDungeonInfoHeroDetail = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetail")
local UINBattleGirdInfoNode = require("Game.Battle.UI.Grid.UINBattleGirdInfoNode")
local CS_ResLoader = CS.ResLoader

function UIDungeonInfoDetail:OnInit()
  self.resloader = CS_ResLoader.Create()
  self.chipDetailNode = UINDungeonInfoChipDetail.New(self)
  self.chipDetailNode:Init(self.ui.obj_chipDetail)
  self.chipDetailNode:Hide()
  self.heroDetailNode = UINDungeonInfoHeroDetail.New()
  self.heroDetailNode:Init(self.ui.obj_heroDetail)
  self.heroDetailNode:Hide()
  self.battleGirdInfoNode = UINBattleGirdInfoNode.New()
  self.battleGirdInfoNode:Init(self.ui.battleGirdInfoNode)
  self.isShowingChipDetail = false
  self.isShowingHeroDetail = false
  UIUtil.AddButtonListener(self.ui.btn_Retreat, self, self.OnClickRetreat)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBlank)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.OnClickLeftButton)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.OnClickRightButton)
  self.ui.obj_DetailTips:SetActive(self.isShowingChipDetail)
  self.ui.activeAlgTitle:SetActive(false)
end

function UIDungeonInfoDetail:ShowChipDetail(chipDataList, index, DeselectAllItemCallBack, SelectItemCallBack, isGainActiveAlg)
  if self.isShowingHeroDetail then
    self:OnClickRetreat()
    DeselectAllItemCallBack()
    return
  end
  self.chipDetailNode:InitChipInfo(chipDataList, index, isGainActiveAlg)
  self.chipDetailNode:Show()
  self.battleGirdInfoNode:Hide()
  self.deselectChipCallBack = DeselectAllItemCallBack
  self.SelectChipByIndexCallBack = SelectItemCallBack
  if not self.isShowingChipDetail then
    MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, true)
  end
  self.isShowingChipDetail = true
  self.ui.obj_DetailTips:SetActive(self.isShowingChipDetail and not isGainActiveAlg)
  self.ui.activeAlgTitle:SetActive(isGainActiveAlg)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
end

function UIDungeonInfoDetail:HideChipDetail()
  self.isShowingChipDetail = false
  self.ui.obj_DetailTips:SetActive(self.isShowingChipDetail)
  self.ui.activeAlgTitle:SetActive(false)
  self.chipDetailNode:Hide()
  if self.deselectChipCallBack ~= nil then
    self.deselectChipCallBack()
  end
end

function UIDungeonInfoDetail:SwitchChip(bool)
  local index = self.chipDetailNode:SwitchChip(bool)
  self.SelectChipByIndexCallBack(index - 1)
end

function UIDungeonInfoDetail:ShowHeroDetail(dynHeroData, deselectCallBack, switchBack)
  if self.isShowingChipDetail then
    self:OnClickRetreat()
    deselectCallBack()
    return
  end
  self.heroDetailNode:InitHeroInfo(dynHeroData, self.resloader)
  self.heroDetailNode:Show()
  self:__CommonShowHeroDetail(dynHeroData, deselectCallBack, switchBack)
end

function UIDungeonInfoDetail:ShowHeroDetailInBattle(entity, deselectCallBack, switchBack)
  if self.isShowingChipDetail then
    self:OnClickRetreat()
    deselectCallBack()
    return
  end
  self.heroDetailNode:InitHeroInfoInBattle(entity, self.resloader)
  self.heroDetailNode:Show()
  self:__CommonShowHeroDetail(entity.character, deselectCallBack, switchBack)
end

function UIDungeonInfoDetail:__CommonShowHeroDetail(dynHeroData, deselectCallBack, switchBack)
  AudioManager:PlayAudioById(1080)
  self:__ShowHeroEffctGrid(dynHeroData)
  self.deselectHeroCallBack = deselectCallBack
  self.switchHeroCallBack = switchBack
  if not self.isShowingHeroDetail then
    MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, true)
    UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  end
  self.isShowingHeroDetail = true
end

function UIDungeonInfoDetail:HideHeroDetail()
  self.heroDetailNode:Hide()
  self.isShowingHeroDetail = false
  if self.deselectHeroCallBack ~= nil then
    self.deselectHeroCallBack()
  end
end

function UIDungeonInfoDetail:SwitchHero(bool)
  self.switchHeroCallBack(bool)
end

function UIDungeonInfoDetail:__ShowHeroEffctGrid(dynHeroData)
  local needShowGridInfo = false
  if CS.BattleManager.Instance.IsInBattle then
    local battleCtrl = CS.BattleManager.Instance.CurBattleController
    local effectGrid = battleCtrl.EfcGridController:GetHeroEffectGrid(dynHeroData.dataId)
    if effectGrid ~= nil then
      needShowGridInfo = true
      self.battleGirdInfoNode:InitBattleGridInfo(effectGrid.gridData)
    end
  end
  if needShowGridInfo then
    self.battleGirdInfoNode:Show()
  else
    self.battleGirdInfoNode:Hide()
  end
end

function UIDungeonInfoDetail:BackAction()
  self:HideChipDetail()
  self:HideHeroDetail()
  self:Hide()
  MsgCenter:Broadcast(eMsgEventId.OnDungeonDetailWinChange, false)
  self.deselectChipCallBack = nil
  self.SelectChipByIndexCallBack = nil
  self:__ReshowLastCharacterInfoBtn()
end

function UIDungeonInfoDetail:OnClickRetreat()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonInfoDetail:__ReshowLastCharacterInfoBtn()
  local characterInfoUI = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if characterInfoUI ~= nil and characterInfoUI.active then
    characterInfoUI.gameObject:SetActive(true)
  end
end

function UIDungeonInfoDetail:OnClickBlank()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonInfoDetail:OnClickLeftButton()
  if self.isShowingChipDetail then
    self:SwitchChip(false)
  end
  if self.isShowingHeroDetail then
    self:SwitchHero(false)
  end
end

function UIDungeonInfoDetail:OnClickRightButton()
  if self.isShowingChipDetail then
    self:SwitchChip(true)
  end
  if self.isShowingHeroDetail then
    self:SwitchHero(true)
  end
end

function UIDungeonInfoDetail:SetSwitchBtnActive(active)
  self.ui.btn_Left.gameObject:SetActive(active)
  self.ui.btn_Right.gameObject:SetActive(active)
end

function UIDungeonInfoDetail:OnDelete()
  self.chipDetailNode:Delete()
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UIDungeonInfoDetail
