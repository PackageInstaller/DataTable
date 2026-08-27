local UINFmtTopNode = class("UINFmtTopNode", UIBaseNode)
local base = UIBaseNode
local FmtEnum = require("Game.Formation.FmtEnum")
local FormationUtil = require("Game.Formation.FormationUtil")
local UINTroopItem = require("Game.Formation.UI.2DFormation.UINTroopItem")
local UINBondNode = require("Game.Formation.UI.Bond.UINFormationBondNode")
local CS_MessageCommon = CS.MessageCommon
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UINFmtTopNode:OnInit()
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SwitchTeam, self, self.__OnClickSwitchTeam)
  UIUtil.AddButtonListener(self.ui.btn_closeSwitchTeamList, self, self.__OnClickCloseSwitchTeam)
  UIUtil.AddButtonListener(self.ui.btn_Recomme, self, self.OnClickRecomme)
  UIUtil.AddButtonListener(self.ui.Btn_InfiniteFrmCheck, self, self.OnClickShowSavingDataInfo)
  if CloseCustomBename then
    self.ui.btn_ChangeTeamName.interactable = false
    CS.EventTriggerListener.Get(self.ui.btn_ChangeTeamName.gameObject):onClick("+", function()
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    end)
  else
    self.ui.btn_ChangeTeamName.onEndEdit:AddListener(BindCallback(self, self.EditFormationName))
  end
  self.troopPool = UIItemPool.New(UINTroopItem, self.ui.switchTeamItem)
  self.ui.switchTeamItem:SetActive(false)
  self.__isInitedTroopPool = false
  self.characterLimit = self.ui.inputField.characterLimit
  self.bondNode = UINBondNode.New()
  self.bondNode:Init(self.ui.obj_bondGroup)
  self.bondNode:Hide()
end

function UINFmtTopNode:InitFmtTopNode(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  self.__offset = FormationUtil.GetFmtIdOffsetByFmtFromModule(self.enterFmtData:GetFmtCtrlFromModule(), self.enterFmtData:GetFmtCtrlFmtIdStageId())
  self:RefreshChangeFmt()
  self:RefreshFixedTip()
  self:RefreshFmtRecommendBtn()
  self:RefreshEpInfinityFmtBtn()
  if self.enterFmtData:IsBondModule() then
    self.bondNode:InitBondNode(fmtCtrl, enterFmtData)
  end
end

function UINFmtTopNode:RefreshChangeFmt()
  if self.enterFmtData:GetIsOpenChangeFmt() then
    local isFixed = self.enterFmtData:IsFmtCtrlFiexd()
    self.ui.btn_ChangeTeamName.gameObject:SetActive(not isFixed)
    self.ui.btn_SwitchTeam.gameObject:SetActive(true)
    self.fmtCtrl:SetCouldUseSwitchBtn(true)
    local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
    if fmtData ~= nil and not string.IsNullOrEmpty(fmtData.name) then
      self.ui.btn_ChangeTeamName.text = fmtData.name
    else
      local showFmtId = self.enterFmtData:GetFmtCtrlFmtId() - self.__offset
      self.ui.btn_ChangeTeamName.text = self.ui.tex_troopName:GetIndex(0, tostring(showFmtId))
    end
  else
    self.ui.btn_ChangeTeamName.gameObject:SetActive(false)
    self.ui.btn_SwitchTeam.gameObject:SetActive(false)
    self.fmtCtrl:SetCouldUseSwitchBtn(false)
  end
end

function UINFmtTopNode:RefreshFixedTip()
  if self.enterFmtData:IsFmtCtrlFiexd() then
    local isFixedCouldChangeTeam = self.enterFmtData:IsFmtFixedCouldChangeTeam()
    self.fmtCtrl:SetCouldUseSwitchBtn(isFixedCouldChangeTeam)
    self.ui.topNornal:SetActive(isFixedCouldChangeTeam)
    self.ui.obj_FixedTips:SetActive(not isFixedCouldChangeTeam)
    if not isFixedCouldChangeTeam then
      if self.enterFmtData:HasFmtFixedExtra() then
        self.ui.tex_FixedTips:SetIndex(1)
      else
        self.ui.tex_FixedTips:SetIndex(0)
      end
    end
  elseif self.enterFmtData:GetIsEpInifinity() then
    self.fmtCtrl:SetCouldUseSwitchBtn(false)
    self.ui.topNornal:SetActive(false)
    self.ui.obj_FixedTips:SetActive(true)
    self.ui.tex_FixedTips:SetIndex(1)
  elseif self.enterFmtData:GetIsEpInifinity424Act() then
    self.fmtCtrl:SetCouldUseSwitchBtn(false)
    self.ui.topNornal:SetActive(false)
    self.ui.obj_FixedTips:SetActive(false)
    self.ui.tex_FixedTips:SetIndex(1)
  end
end

function UINFmtTopNode:RefreshCurrentFmtPow(totalFtPower, totalBenchPower)
  for _, item in pairs(self.troopPool.listItem) do
    local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
    if item.id == formationData.id then
      item:RefreshPower(totalFtPower, totalBenchPower)
    end
  end
  if self.enterFmtData:IsBondModule() then
    self.bondNode:RefreshUIBond()
  end
end

function UINFmtTopNode:RefreshFmtItemPow(formationData)
  for _, item in pairs(self.troopPool.listItem) do
    if item.id == formationData.id then
      local ftpower, benchPower = self.fmtCtrl:CalculatePower(formationData)
      item:RefreshPower(ftpower, benchPower)
    end
  end
end

function UINFmtTopNode:RefreshFmtRecommendBtn()
  local bool = self.enterFmtData:GetCouldShowFmtRecommendBtn()
  self.ui.btn_Recomme.gameObject:SetActive(bool)
end

function UINFmtTopNode:RefreshEpInfinityFmtBtn()
  local isInfinity = self.enterFmtData:GetIsEpInifinity()
  local isInfinity424Act = self.enterFmtData:GetIsEpInifinity424Act() and self.enterFmtData:GetFactCardData424Act() ~= nil
  self.ui.Btn_InfiniteFrmCheck.gameObject:SetActive(isInfinity or isInfinity424Act)
end

function UINFmtTopNode:__OnClickSwitchTeam()
  self.ui.switchTeamList:SetActive(true)
  self.ui.img_SwitchTeamArrow.localScale = Vector3.New(1, 1, 1)
  self.fmtCtrl:SetCouldUseSwitchBtn(false)
  self:__TryInitTroopItems()
  local curFmtData = self.fmtCtrl:GetFmtCtrlFmtData()
  for _, item in pairs(self.troopPool.listItem) do
    if not item:IsCalcutedPower() then
      local formationData
      if curFmtData.id == item.id then
        formationData = curFmtData
      else
        formationData = PlayerDataCenter.formationDic[item.id]
      end
      if formationData ~= nil then
        local ftpower, benchPower = self.fmtCtrl:CalculatePower(formationData)
        item:RefreshPower(ftpower, benchPower)
      else
        item:RefreshPower(0, 0)
      end
    end
  end
end

function UINFmtTopNode:OnClickRecomme()
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  local sectorStageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
  if self.enterFmtData:GetFmtCtrlGameType() == FmtEnum.eFmtGamePlayType.Dungeon then
    recommeCtr:ReqDunRecommeFormation(sectorStageId, true)
  else
    recommeCtr:ReqRecommeFormationNew(sectorStageId, true)
  end
  recommeCtr:SetTopStatusHide(false)
end

function UINFmtTopNode:__OnClickCloseSwitchTeam()
  self.ui.switchTeamList:SetActive(false)
  self.ui.img_SwitchTeamArrow.localScale = Vector3.New(1, -1, 1)
  self.fmtCtrl:SetCouldUseSwitchBtn(true)
end

function UINFmtTopNode:__TryInitTroopItems()
  if self.__isInitedTroopPool then
    return
  end
  self.__isInitedTroopPool = true
  self.troopPool:HideAll()
  
  local function __SelectFmt(id, index)
    self.fmtCtrl:FmtCtrlSwitchFmt(id, index)
  end
  
  local isFixedCouldChangeTeam = self.enterFmtData:IsFmtFixedCouldChangeTeam() and self.enterFmtData:GetIsOpenChangeFmt()
  for index = 1, self.enterFmtData:GetFmtTeamSize() do
    local fmtId
    if isFixedCouldChangeTeam then
      fmtId = self.enterFmtData:GetFmtFixedChangeTeamFmtId(index)
    end
    if fmtId == nil then
      fmtId = index + self.__offset
    end
    local troopItem = self.troopPool:GetOne()
    troopItem:InitTroopItem(fmtId, __SelectFmt, self.__offset, index)
  end
end

function UINFmtTopNode:EditFormationName(fmtName)
  if string.IsNullOrEmpty(fmtName) then
    self:OnEditFormationNameError()
    return
  end
  local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
  if fmtData ~= nil and fmtData.name == fmtName then
    return
  end
  local inputLength = RenameHelper:GetNameLength(fmtName)
  if inputLength > self.characterLimit then
    fmtName = RenameHelper:ClampNameInLength(fmtName, self.characterLimit)
    self.ui.inputField.text = fmtName
  end
  if self.__OnEditFormationName == nil then
    self.__OnEditFormationName = BindCallback(self, self.__OnEditFormationNameComplete)
  end
  self.heroNetwork:CS_HERO_FormationNameFresh(self.enterFmtData:GetFmtCtrlFmtId(), fmtName, self.__OnEditFormationName)
end

function UINFmtTopNode:__OnEditFormationNameComplete()
  local name = self.ui.btn_ChangeTeamName.text
  local troopItem = self.troopPool.listItem[self.enterFmtData:GetFmtCtrlFmtId() - self.__offset]
  if troopItem ~= nil then
    troopItem:RefreshTroopName(name)
  end
  self.fmtCtrl:ModifyFormationName(name)
end

function UINFmtTopNode:OnEditFormationNameError()
  local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
  if fmtData ~= nil and not string.IsNullOrEmpty(fmtData.name) then
    self.ui.btn_ChangeTeamName.text = fmtData.name
  else
    self.ui.btn_ChangeTeamName.text = self.ui.tex_troopName:GetIndex(0, tostring(self.enterFmtData:GetFmtCtrlFmtId()))
  end
end

function UINFmtTopNode:OnClickShowSavingDataInfo()
  if self.enterFmtData:GetIsEpInifinity() then
    UIManager:ShowWindowAsync(UIWindowTypeID.InfinityFmtCheck, function(win)
      if win == nil then
      end
      win:InitFmtSaveChipPanel(self.enterFmtData:GetEpInifinitySavingData())
    end)
    return
  end
  if self.enterFmtData:GetIsEpInifinity424Act() then
    local factCardData = self.enterFmtData:GetFactCardData424Act()
    if factCardData == nil then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
      if win == nil then
      end
      win:InitRfCardDetailFac(factCardData, true)
    end)
    return
  end
end

function UINFmtTopNode:OnDelete()
  self.bondNode:Delete()
end

return UINFmtTopNode
