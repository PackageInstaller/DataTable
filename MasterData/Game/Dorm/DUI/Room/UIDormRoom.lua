local UIDormRoom = class("UIDormRoom", UIBaseWindow)
local base = UIBaseWindow
local UINDmRoomEdit = require("Game.Dorm.DUI.Room.Edit.UINDmRoomEdit")
local DormEnum = require("Game.Dorm.DormEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_MessageCommon = CS.MessageCommon

function UIDormRoom:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Edit, self, self._OnClickEditRoom)
  UIUtil.AddButtonListener(self.ui.btn_hero, self, self._OnClickCheckIn)
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self._OnClickHideUI)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self._OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Visit, self, self._OnClickVisit)
  UIUtil.AddButtonListener(self.ui.btn_setShowRoom, self, self._OnSetShowRoom)
  UIUtil.AddButtonListener(self.ui.btn_Like, self, self._OnClickLike)
  self.dmRoomEditNode = UINDmRoomEdit.New()
  self.dmRoomEditNode:Init(self.ui.editorNode)
  self.dmRoomEditNode:Hide()
  self.__OnDormRoomEditDataChange = BindCallback(self, self.OnDormRoomEditDataChange)
  MsgCenter:AddListener(eMsgEventId.DormRoomEditDataChange, self.__OnDormRoomEditDataChange)
  self:_InitDormRoomSequene()
  self.__isHideState = true
  self.dormRoomState = DormEnum.DormRoomState.normal
end

function UIDormRoom:InitUIDormRoom(dormRoomCtrl)
  self.roomCtrl = dormRoomCtrl
  self:SwitchToDormRoomState(dormRoomCtrl.dormCtrl:IsSelfDorm() and DormEnum.DormRoomState.Normal or DormEnum.DormRoomState.Visitee)
  self:RefreshDormRoomBaseInfo()
  self:RefreshDormRoomVisitUI()
  self:RefreshSetVisitRoomBtnState()
end

function UIDormRoom:RefreshDormRoomBaseInfo()
  local roomData = self.roomCtrl.roomEntity.roomData
  self.ui.tex_ComfortPoint.text = tostring(roomData:GetComfort())
end

function UIDormRoom:RefreshDormRoomVisitUI()
  local roomData = self.roomCtrl.roomEntity.roomData
  local dormVisitCtrl = self.roomCtrl.dormCtrl.dormVisitCtrl
  local isvisit = not self.roomCtrl.dormCtrl:IsSelfDorm()
  self.ui.visitNode:SetActive(isvisit)
  local roomOwnerUserId = self.roomCtrl.dormCtrl:GetDormOwnerUserId()
  local hasLike = dormVisitCtrl:IsHasLike(roomOwnerUserId)
  self.ui.tex_Like:SetIndex(hasLike and 1 or 0)
  local colors = {}
  UIUtil.LuaUIBindingTable(self.ui.btn_Like, colors)
  self.ui.img_Like.color = hasLike and colors.liked or colors.like
  local ownerName = self.roomCtrl.dormCtrl:GetDormOwnerName()
  self.ui.tex_RoomName.text = ConfigData:GetTipContent(9366, ownerName, roomData:GetName())
  self.ui.tex_LikeTimes:SetIndex(0, dormVisitCtrl:GetLikeRewardTimeAndMaxTimeText())
  self.ui.tex_LikePoint.transform.parent.gameObject:SetActive(isvisit)
  if isvisit then
    self.ui.tex_LikePoint.text = dormVisitCtrl:GetVisitRoomLikeCountText(roomOwnerUserId)
  end
end

function UIDormRoom:OnDormRoomEditDataChange()
  self:RefreshDormRoomBaseInfo()
end

function UIDormRoom:RefreshSetVisitRoomBtnState()
  local roomData = self.roomCtrl.roomEntity.roomData
  local dormVisitCtrl = self.roomCtrl.dormCtrl.dormVisitCtrl
  local isSelfRoom = self.roomCtrl.dormCtrl:IsSelfDorm()
  local isShowVisitRoom = dormVisitCtrl:IsShowVisitRoom(roomData)
  self.ui.img_IsShowVisitRoom.gameObject:SetActive(isShowVisitRoom and isSelfRoom)
end

function UIDormRoom:_OnClickEditRoom()
  self.roomCtrl:EnterDormRoomEdit()
end

function UIDormRoom:_OnClickCheckIn()
  self.roomCtrl.dormCtrl.characterCtrl:EndOperateCharacter()
  local fromRoomSpos = self.roomCtrl.roomEntity.spos
  self.roomCtrl.dormCtrl.dmCheckInCtrl:InitDmCheckInCtrl(fromRoomSpos, self.OnEnterFunc, self.OnExitFunc)
end

function UIDormRoom:_OnClickHideUI()
  self.__isHideState = true
  self:Hide()
  UIManager:HideWindow(UIWindowTypeID.DormInput)
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  UIManager:HideWindow(UIWindowTypeID.DormInteract)
end

function UIDormRoom:_OnClickVisit()
  local currentDormRoomState = self:GetDormRoomState()
  if currentDormRoomState ~= DormEnum.DormRoomState.Visitee then
    return
  end
  self.roomCtrl.dormCtrl.characterCtrl:EndOperateCharacter()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormVisit, function(window)
    if window == nil then
      return
    end
    self:OnEnterFunc()
    local dormVisitCtrl = self.roomCtrl.dormCtrl.dormVisitCtrl
    local visitorPageList = ConfigData.oasis_building_dorm_visit_list
    window:InitDormVisit(dormVisitCtrl, visitorPageList, self.OnExitFunc)
  end)
end

function UIDormRoom:_OnSetShowRoom()
  local currentDormRoomState = self:GetDormRoomState()
  if currentDormRoomState ~= DormEnum.DormRoomState.Normal then
    return
  end
  local dormVisitCtrl = self.roomCtrl.dormCtrl.dormVisitCtrl
  local roomData = self.roomCtrl.roomEntity.roomData
  local houseId = roomData.belongtohouseid
  local pos = roomData.spos
  if dormVisitCtrl:IsShowVisitRoom(roomData) then
    ConfigData:GetTipContent(9365)
    return
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(9359), function()
    dormVisitCtrl:SetShowVisitRoom(houseId, pos, function()
      self:RefreshSetVisitRoomBtnState()
    end)
  end, nil)
end

function UIDormRoom:_OnClickLike()
  local currentDormRoomState = self:GetDormRoomState()
  if currentDormRoomState ~= DormEnum.DormRoomState.Visitee then
    return
  end
  local ownerUserId = self.roomCtrl.dormCtrl:GetDormOwnerUserId()
  if self.roomCtrl.dormCtrl.dormVisitCtrl:IsHasLike(ownerUserId) then
    return
  end
  self.roomCtrl.dormCtrl.dormVisitCtrl:AddLikeVisitRoom(ownerUserId, function()
    self:RefreshDormRoomVisitUI()
  end)
end

function UIDormRoom:IsRoomUIHideState()
  return self.__isHideState
end

function UIDormRoom:GetDormRoomState()
  return self.dormRoomState
end

function UIDormRoom:SetDormRoomState(dormRoomState)
  self.dormRoomState = dormRoomState
end

function UIDormRoom:_OnClickBuy()
  JumpManager:DirectShowShop(nil, nil, ShopEnum.ShopId.dormFnt, true)
end

function UIDormRoom:OnDRoomEidtMode(isEnter)
  local currentDormRoomState = self:GetDormRoomState()
  if currentDormRoomState == DormEnum.DormRoomState.Visitee then
    self.dmRoomEditNode:Hide()
    return
  end
  self:SwitchToDormRoomState(isEnter and DormEnum.DormRoomState.Editor or DormEnum.DormRoomState.Normal)
  if isEnter then
    self.dmRoomEditNode:InitDmRoomtEdit(self.roomCtrl)
    self.dmRoomEditNode:Show()
  else
    self.dmRoomEditNode:Hide()
  end
end

function UIDormRoom:SwitchToDormRoomState(dormRoomState)
  self:SetDormRoomState(dormRoomState)
  local currentDormRoomState = self:GetDormRoomState()
  local stateEnum = DormEnum.DormRoomState
  self.ui.btn_Edit.gameObject:SetActive(currentDormRoomState == stateEnum.Normal)
  self.ui.btn_hero.gameObject:SetActive(currentDormRoomState == stateEnum.Normal)
  self.ui.btn_HideUI.gameObject:SetActive(currentDormRoomState ~= stateEnum.Editor)
  self.ui.btn_buy.gameObject:SetActive(currentDormRoomState == stateEnum.Editor)
  local is_hide = ConfigData.oasis_building_dorm_visit[1].is_hide
  self.ui.btn_Visit.gameObject:SetActive(not is_hide and currentDormRoomState == stateEnum.Visitee)
  self.ui.btn_setShowRoom.gameObject:SetActive(currentDormRoomState == stateEnum.Normal and not is_hide)
  self.ui.btn_Like.gameObject:SetActive(currentDormRoomState == stateEnum.Visitee)
  self.ui.obj_RoomName:SetActive(currentDormRoomState == stateEnum.Visitee)
end

function UIDormRoom:_InitDormRoomSequene()
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

function UIDormRoom:Hide()
  self._winSeq:Complete()
  self._winSeq:PlayBackwards()
  self.ui.canvasGroup.blocksRaycasts = false
end

function UIDormRoom:OnShow()
  self.__isHideState = false
  self.dmRoomEditNode:TryRefreshDmRoomEditList()
  base.OnShow(self)
  self._winSeq:PlayForward()
  self.ui.canvasGroup.blocksRaycasts = true
end

function UIDormRoom:OnEnterFunc()
  UIManager:HideWindow(UIWindowTypeID.DormInput)
  UIManager:HideWindow(UIWindowTypeID.DormRoom)
  UIManager:HideWindow(UIWindowTypeID.DormInteract)
end

function UIDormRoom:OnExitFunc()
  UIManager:ShowWindowOnly(UIWindowTypeID.DormInput)
  UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
  UIManager:ShowWindowOnly(UIWindowTypeID.DormInteract)
end

function UIDormRoom:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.DormRoomEditDataChange, self.__OnDormRoomEditDataChange)
  self.dmRoomEditNode:Delete()
  if self._winSeq ~= nil then
    self._winSeq:Kill()
    self._winSeq = nil
  end
  base.OnDelete(self)
end

return UIDormRoom
