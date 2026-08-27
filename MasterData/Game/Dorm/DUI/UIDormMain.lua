local UIDormMain = class("UIDormMain", UIBaseWindow)
local base = UIBaseWindow
local UIDormEditNode = require("Game.Dorm.DUI.UIDormEditNode")
local UINDormRoomState = require("Game.Dorm.DUI.RoomState.UINDormRoomState")
local UINDmRoomOutput = require("Game.Dorm.DUI.ResOutput.UINDmRoomOutput")
local UINSwitchHouse = require("Game.Dorm.DUI.UINSwitchHouse")
local DormEnum = require("Game.Dorm.DormEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local ActivityWhiteDayUtil = require("Game.ActivityWhiteDay.ActivityWhiteDayUtil")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UIDormMain:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self.OnHideUIClicked)
  UIUtil.AddButtonListener(self.ui.btn_Editor, self, self.OnEditorClicked)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnDormButClicked)
  UIUtil.AddButtonListener(self.ui.btn_Hero, self, self.OnCheckInClicked)
  UIUtil.AddButtonListener(self.ui.btn_Comfort, self, self.OnDormComfortClicked)
  UIUtil.AddButtonListener(self.ui.btn_Visit, self, self._OnClickVisit)
  self.__editorNode = UIDormEditNode.New()
  self.__editorNode:Init(self.ui.editorNode)
  self.__editorNode:Hide()
  self.dmRoomStateNode = UINDormRoomState.New(self)
  self.dmRoomStateNode:Init(self.ui.stateNode)
  self.dmResOutputNode = UINDmRoomOutput.New(self)
  self.dmResOutputNode:Init(self.ui.resNode)
  self.swtichHouseNode = UINSwitchHouse.New(self)
  self.swtichHouseNode:Init(self.ui.houseNode)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnDormMainReturnClicked):SetTopStatusInfoFunc(DormEnum.ShowMainInfoFunc):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.__OnDormMaxComfortChanged = BindCallback(self, self.OnDormMaxComfortChanged)
  MsgCenter:AddListener(eMsgEventId.DormMaxComfortChanged, self.__OnDormMaxComfortChanged)
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  self:_InitDormMainSequene()
end

function UIDormMain:InitDormMainUI()
  local curHouse = self.dormCtrl:GetCurHouse()
  if curHouse == nil then
    return
  end
  self.allDormData = self.dormCtrl.allDormData
  self:RefreshDormUIState()
  self:ShowDormEditMode(false)
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormComfort)
  if ok then
    self.ui.redDot_Comfort:SetActive(comfortNode:GetRedDotCount() > 0)
    if self.__RefreshRedDotComfort == nil then
      function self.__RefreshRedDotComfort(node)
        self.ui.redDot_Comfort:SetActive(node:GetRedDotCount() > 0)
      end
      
      RedDotController:AddListener(comfortNode.nodePath, self.__RefreshRedDotComfort)
    end
  end
  self:ShowDmStateNode(false)
  self.swtichHouseNode:InitSwitchNode(self.dormCtrl, curHouse)
  self:_UpdCheckInBtn()
end

function UIDormMain:RefreshDormWindow()
  self:RefreshDormUIState()
  self.swtichHouseNode:UpdDmSwitchUI(self.dormCtrl:GetCurHouse())
  self:_UpdCheckInBtn()
end

function UIDormMain:RefreshDormUIState()
  local curLevel = PlayerDataCenter.dormBriefData:GetDormComfortLevel()
  self.ui.tex_ComfortLv:SetIndex(0, tostring(curLevel))
end

function UIDormMain:RefreshDormStateNode()
  self.dmRoomStateNode:InitDormRoomState()
  self.dmResOutputNode:InitDmRoomOutput()
end

function UIDormMain:ShowDmStateNode(show)
  if show then
    self.dmRoomStateNode:Show()
    self.dmResOutputNode:Show()
  else
    self.dmRoomStateNode:Hide()
    self.dmResOutputNode:Hide()
  end
end

function UIDormMain:OnDormMaxComfortChanged()
  self:RefreshDormUIState()
end

function UIDormMain:GetDormEditUI()
  return self.__editorNode
end

function UIDormMain:ShowDormEditMode(edit)
  self.ui.btn_WhiteDayAlbum.gameObject:SetActive(false)
  self.ui.mainNode:SetActive(not edit)
  if edit then
    self.__editorNode:Show()
  else
    self.__editorNode:Hide()
  end
  self:_UpdCheckInBtn()
  self:_UpdVisitBtn()
end

function UIDormMain:_UpdCheckInBtn()
  local curHouse = self.dormCtrl:GetCurHouse()
  local houseLock = curHouse and curHouse:IsDmHouseLock()
  local inEditMode = self.__editorNode.active
  self.ui.btn_Hero.gameObject:SetActive(not houseLock and not inEditMode)
end

function UIDormMain:_UpdVisitBtn()
  local inEditMode = self.__editorNode.active
  local is_hide = ConfigData.oasis_building_dorm_visit[1].is_hide
  self.ui.btn_Visit.gameObject:SetActive(not is_hide and not inEditMode)
end

function UIDormMain:RefreshDormHeroList()
end

function UIDormMain:OnDormMainReturnClicked()
  if self.dormCtrl == nil then
    return
  end
  if self.dormCtrl:IsDormState(DormEnum.eDormState.House) or self.dormCtrl:IsDormState(DormEnum.eDormState.Room2House) or self.dormCtrl:IsDormState(DormEnum.eDormState.Room) then
    self.dormCtrl:ExitDorm()
  elseif self.dormCtrl:IsDormState(DormEnum.eDormState.HouseEdit) then
    self:ShowDormEditMode(false)
    self.dormCtrl.houseCtrl:ExitDormEditMode()
  end
end

function UIDormMain:OnHideUIClicked()
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  self:Hide()
end

function UIDormMain:OnEditorClicked()
  self.dormCtrl:EnterDormEditor()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnDormMainReturnClicked):SetTopStatusInfoFunc(DormEnum.ShowMainInfoFunc):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
end

function UIDormMain:OnDormButClicked()
  JumpManager:DirectShowShop(nil, nil, ShopEnum.ShopId.dormFnt)
end

function UIDormMain:OnCheckInClicked()
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    
    UIManager:HideWindow(UIWindowTypeID.DormMain)
  end
  
  local function exitFunc()
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
    UIManager:ShowWindowOnly(UIWindowTypeID.DormMain)
  end
  
  self.dormCtrl.dmCheckInCtrl:InitDmCheckInCtrl(nil, self.EnterFunc, self.ExitFunc)
end

function UIDormMain:OnDormComfortClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormComfort, function(comfortWindow)
    if comfortWindow == nil then
      return
    end
    comfortWindow:InitDormComfortUI()
  end)
end

function UIDormMain:_OnClickVisit()
  self.dormCtrl.characterCtrl:EndOperateCharacter()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormVisit, function(window)
    if window == nil then
      return
    end
    self:EnterFunc()
    local dormVisitCtrl = self.dormCtrl.dormVisitCtrl
    local visitorPageList = ConfigData.oasis_building_dorm_visit_list
    window:InitDormVisit(dormVisitCtrl, visitorPageList, self.ExitFunc)
  end)
end

function UIDormMain:EnterFunc()
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  UIManager:HideWindow(UIWindowTypeID.DormMain)
end

function UIDormMain:ExitFunc()
  UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  UIManager:ShowWindowOnly(UIWindowTypeID.DormMain)
end

function UIDormMain:SetBaseNodeActive(active)
  if active ~= nil then
    self.ui.baseNode:SetActive(active)
  else
    error("条件为空")
  end
end

function UIDormMain:_InitDormMainSequene()
  local seq = cs_DoTween.Sequence()
  seq:SetAutoKill(false)
  seq:SetUpdate(true)
  seq:Append(self.transform:DOSizeDelta(Vector2.New(0, 500), 0.25):From():SetRelative(true):SetEase(cs_Ease.Linear))
  seq:Join(self.ui.canvasGroup:DOFade(0, 0.25):From():SetEase(cs_Ease.Linear))
  seq:OnRewind(function()
    base.Hide(self)
  end)
  self._winSeq = seq
end

function UIDormMain:Hide()
  self._winSeq:Complete()
  self._winSeq:PlayBackwards()
end

function UIDormMain:OnShow()
  base.OnShow(self)
  self._winSeq:PlayForward()
end

function UIDormMain:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.DormMaxComfortChanged, self.__OnDormMaxComfortChanged)
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormComfort)
  if ok then
    RedDotController:RemoveListener(comfortNode.nodePath, self.__RefreshRedDotComfort)
  end
  self.dormCtrl = nil
  self.dmRoomStateNode:Delete()
  self.dmResOutputNode:Delete()
  self.swtichHouseNode:Delete()
  if self._winSeq ~= nil then
    self._winSeq:Kill()
    self._winSeq = nil
  end
  base.OnDelete(self)
end

return UIDormMain
