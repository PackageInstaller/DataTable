local base = UIBaseNode
local UINActLbQuickEntrance = class("UINActLbQuickEntrance", base)
local UINLbQuickEntranceItem = require("Game.ActivityLobby.UI.Main.QuickEntrance.UINLbQuickEntranceItem")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local UINActivityTimer = require("Game.ActivityFrame.UI.UINActivityTimer")
local UINLobbyCommonShare = require("Game.ActivityLobby.UI.CommonUI.UINLobbyCommonShare")
local cs_ResLoader = CS.ResLoader
local animNameIn = "UI_ActivityLobbyMainQuickEntranceList"
local animNameOut = "UI_ActivityLobbyMainQuickEntranceListOut"

function UINActLbQuickEntrance:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:AddButtonNormal()
  self._actTimerNode = UINActivityTimer.New()
  self._actTimerNode:Init(self.ui.time)
  self._actTimerNode:Hide()
  self._shareNode = UINLobbyCommonShare.New()
  self._shareNode:Init(self.ui.btn_Share)
  self._shareNode:Hide()
  self._resloader = cs_ResLoader.Create()
  self:SetPoolNormal()
end

function UINActLbQuickEntrance:AddButtonNormal()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_CloseBg, self, self._OnClickClose)
end

function UINActLbQuickEntrance:SetPoolNormal()
  self._entranceItemPool = UIItemPool.New(UINLbQuickEntranceItem, self.ui.item, false)
end

function UINActLbQuickEntrance:InitLbQuickEntrance(actionList, enterCallback)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl:SetActLbState(ActLbEnum.eActLbState.ShowQuickEntrance)
  end
  TimerManager:StopTimer(self._HideTimer)
  self.ui.canvasGroup_root.blocksRaycasts = true
  self.ui.anim_root:Play(animNameIn)
  self:Show()
  self._entranceItemDic = {}
  self._entranceItemPool:HideAll()
  for k, actionData in ipairs(actionList) do
    local item = self._entranceItemPool:GetOne()
    item:InitLbQuickEntranceItem(actionData)
    local actionId = actionData:GetLbIntrctActionId()
    self._entranceItemDic[actionId] = item
  end
end

function UINActLbQuickEntrance:UpdActLbQuickEntranceItemState()
  for k, item in ipairs(self._entranceItemPool.listItem) do
    item:UpdLbQuickEntranceItemLock()
    item:UpdLbQuickEntranceItemBlueDot()
  end
end

function UINActLbQuickEntrance:UpdActLbQuickEntranceItemUnlockById(actionId)
  if self._entranceItemDic == nil then
    return
  end
  local entranceItem = self._entranceItemDic[actionId]
  if entranceItem then
    entranceItem:UpdLbQuickEntranceItemLock()
  end
end

function UINActLbQuickEntrance:UpdActLbQuickEntranceItemBludotById(actionId)
  if self._entranceItemDic == nil then
    return
  end
  local entranceItem = self._entranceItemDic[actionId]
  if entranceItem then
    entranceItem:UpdLbQuickEntranceItemBlueDot()
  end
end

function UINActLbQuickEntrance:UpdActLbQuickEntranceActTimer(tile, timer, days)
  self._actTimerNode:Show()
  self._actTimerNode:UpdActTimer(tile, timer, days)
end

function UINActLbQuickEntrance:_OnClickClose()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl:SetActLbState(ActLbEnum.eActLbState.Normal)
  end
  self.ui.canvasGroup_root.blocksRaycasts = false
  local animState = self.ui.anim_root:get_Item(animNameOut)
  self.ui.anim_root:Play(animNameOut)
  self._HideTimer = TimerManager:StartTimer(animState.length, self.Hide, self)
end

function UINActLbQuickEntrance:SetActivityShareId(shareId)
  self._shareId = shareId
  local shareCfg = ConfigData.share[shareId]
  if shareCfg == nil then
    self._shareNode:Hide()
    return
  end
  if string.IsNullOrEmpty(shareCfg.picture_route) then
    self.isShowPrtScNode = false
    self._shareNode:InitShareCommonBtn(BindCallback(self, self.__OpenAcitivityShare), shareId)
  else
    self._resloader:LoadABAssetAsync(PathConsts:GetShareRoutePic(shareCfg.picture_route), function(texture)
      if IsNull(texture) or IsNull(self.transform) then
        return
      end
      self.isShowPrtScNode = true
      self.ui.img_PrtSc.texture = texture
      self._shareNode:InitShareCommonBtn(BindCallback(self, self.__OpenAcitivityShare), shareId)
    end)
  end
end

function UINActLbQuickEntrance:__RefreshActivityShareBtn()
  self._shareNode:RefreshLobbyShareNode()
end

function UINActLbQuickEntrance:__OpenAcitivityShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      UIUtil.HideTopStatus()
      self.ui.obj_PrtScNode:SetActive(self.isShowPrtScNode)
    end):SetShareAfterCaptureFunc(function()
      UIUtil.ReShowTopStatus()
      self.ui.obj_PrtScNode:SetActive(false)
    end):SetShareGetRewardFunc(function()
      self:__RefreshActivityShareBtn()
    end):InitShare(self._shareId)
  end)
end

function UINActLbQuickEntrance:OnDelete()
  if self._HideTimer then
    TimerManager:StopTimer(self._HideTimer)
    self._HideTimer = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self._shareNode ~= nil then
    self._shareNode:Delete()
    self._shareNode = nil
  end
  base.OnDelete(self)
end

return UINActLbQuickEntrance
