local base = UIBaseNode
local UINRfCardSetSelectSetNodeList2Item = class("UINRfCardSetSelectSetNodeList2Item", base)
local UINRfCardFacSmall = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSmall")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")

function UINRfCardSetSelectSetNodeList2Item:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Card, self, self.OnClickCard)
  UIUtil.AddButtonListener(self.ui.Btn_Details, self, self.OnClickDetails)
  UIUtil.AddButtonListener(self.ui.Btn_Set, self, self.OnClickSet)
  UIUtil.AddButtonListener(self.ui.Btn_Remove, self, self.OnClickRemove)
  UIUtil.AddButtonListener(self.ui.btn_CheckBg, self, self.OnClickUserInfo)
  self.cardNode = UINRfCardFacSmall.New()
  self.cardNode:Init(self.ui.UINRfCardFacSmall)
  self.cardNode:SetRfCardFacSmallClickFunc(BindCallback(self, self.OnClickCard))
  self.cardNode:Hide()
  self.ui.cardBottom:SetActive(false)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.UINUserHead)
end

function UINRfCardSetSelectSetNodeList2Item:InitList2Item(setNode, dataAll, actFrameId, resloader)
  self.setNode = setNode
  self.dataAll = dataAll
  self.actFrameId = actFrameId
  self.resloader = resloader
end

function UINRfCardSetSelectSetNodeList2Item:RefreshList2Item(isSelf, cardData, indx, isEquip)
  self.isSelf = isSelf
  self.cardData = cardData
  self.indx = indx
  self.isEquip = isEquip
  self.ui.Tex_Top:SetIndex(self.isSelf and 0 or 1)
  self.ui.SelectedTex:SetActive(isEquip)
  self.ui.Img_Selected:SetActive(isEquip)
  self.ui.Obj_UnSelect:SetActive(not isEquip)
  if isEquip then
    self.ui.Tex_Order:SetIndex(0, tostring(indx))
  end
  self:RefreshFriendInfo()
  local hasCardData = cardData ~= nil
  self.ui.Img_Empty:SetActive(not hasCardData)
  self.ui.cardBottom:SetActive(hasCardData)
  if hasCardData then
    self.cardNode:InitRfCardFacSmall(cardData, self.resloader, false)
    self.cardNode:Show()
    self.ui.Img_Dot.color = Color.New(0.7058824, 0.1372549, 0.1333333, 1)
  else
    self.cardNode:Hide()
    local num, maxNum = self.setNode:GetCurrentInstallNumAndMaxNum()
    if num < maxNum then
      self.ui.Tex_SetNum:SetIndex(0, tostring(0), tostring(1))
    else
      self.ui.Tex_SetNum:SetIndex(1)
    end
    self.ui.Img_Dot.color = Color.New(0.4745098, 0.4745098, 0.4745098, 1)
  end
end

function UINRfCardSetSelectSetNodeList2Item:OnClickCard()
  if self.isSelf then
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardStorage, function(window)
      window:InitRfCardFacStorage4Select(self.dataAll, function(selectFacCatdData, isInstall)
        if isInstall then
          self.setNode:SetCardEquip(selectFacCatdData)
        else
          self.setNode:RemoveCardEquip(selectFacCatdData)
        end
      end, function(selectFacCatdData)
        return self.setNode:GetDataIsInAlSelectList(selectFacCatdData) ~= nil
      end)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardFriendSup, function(window)
      window:InitReinforceCardFriendSupport(self.actFrameId, self.dataAll, nil, function(selectFacCatdData, isInstall)
        if isInstall then
          self.setNode:SetCardEquip(selectFacCatdData)
        else
          self.setNode:RemoveCardEquip(selectFacCatdData)
        end
      end)
    end)
  end
end

function UINRfCardSetSelectSetNodeList2Item:RefreshFriendInfo()
  if self.isSelf or not self.isEquip then
    self.ui.Deco:SetActive(true)
    self.ui.Frinend:SetActive(false)
    return
  end
  self.ui.Deco:SetActive(false)
  self.ui.Frinend:SetActive(true)
  local userInfoData = self.cardData:GetSupportCardUserInfoData()
  local userUId = userInfoData:GetUserUID()
  local isStranger = PlayerDataCenter.friendDataCenter:TryGetFriendData(userUId) == nil
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), self.resloader)
  self.ui.Tex_PlayerName.text = userInfoData:GetAlias()
  if isStranger then
    self.ui.Tex_Friend:SetIndex(0)
    self.ui.Image_friend.color = self.ui.friend_blue
  else
    self.ui.Tex_Friend:SetIndex(1)
    self.ui.Image_friend.color = self.ui.friend_red
  end
end

function UINRfCardSetSelectSetNodeList2Item:OnClickUserInfo()
  local userInfoData = self.cardData:GetSupportCardUserInfoData()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    if win == nil then
      return
    end
    win:InitUserInfoView(userInfoData, eFriendEnum.eFriendApplyWay.Assist)
  end)
end

function UINRfCardSetSelectSetNodeList2Item:OnClickDetails()
  if self.cardData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    local hideSwitch = not self.isSelf
    win:InitRfCardDetailFac(self.cardData, false, hideSwitch)
    UIUtil.PopFromBackStackByWinId(UIWindowTypeID.UIReinforceCardDetailFac)
    self.setNode:SetDetailWin(self, win)
    win:SetBkClose()
    local trans = win.transform
    trans.offsetMin = Vector2.zero
    trans.offsetMax = Vector2.zero
  end)
end

function UINRfCardSetSelectSetNodeList2Item:CloseCheck()
end

function UINRfCardSetSelectSetNodeList2Item:OnClickSet()
  self:OnClickCard()
end

function UINRfCardSetSelectSetNodeList2Item:OnClickRemove()
  if self.cardData == nil then
    return
  end
  self.setNode:RemoveCardEquip(self.cardData)
end

function UINRfCardSetSelectSetNodeList2Item:OnDelete()
end

return UINRfCardSetSelectSetNodeList2Item
