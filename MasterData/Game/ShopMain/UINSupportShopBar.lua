local UINSupportShopBar = class("UINSupportShopBar", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINSupportShopBar:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  self.shopNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Shop)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickClollectSupportPoint)
  self.ui.redDot:SetActive(false)
  
  function self.__onReddotChangeDotEvent(node)
    if ShopEnum.ShopId.supportShop == node:GetParentNodeId() then
      self.ui.redDot:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.ShopFriendSupportBtnPath, self.__onReddotChangeDotEvent)
  self.__RefreshSupportValueNum = BindCallback(self, self.RefreshSupportValueNum)
end

function UINSupportShopBar:OnShow()
  self:RefreshSupportValueNum()
  self.shopCtrl:AddShopTimerCallback(self.__RefreshSupportValueNum, "SupportShopBar")
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, ShopEnum.ShopId.supportShop, RedDotStaticTypeId.ShopFriendSupportBtn)
  self.ui.redDot:SetActive(ok and node:GetRedDotCount() > 0)
end

function UINSupportShopBar:HeadBarCommonInit(uiShop)
end

function UINSupportShopBar:RefreshHeadBarNode(shopData)
  self:RefreshSupportValueNum()
end

function UINSupportShopBar:RefreshSupportValueNum()
  local curPoint = PlayerDataCenter.inforData:GetCurSupportPoint()
  local maxPoint = ConfigData.game_config.supportPointMaxNum
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportPointPick, 0)
  if counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp then
    self.ui.btn_Refresh.gameObject:SetActive(false)
    self.ui.obj_img_Timer:SetActive(true)
    self.ui.tex_Timer.text = TimeUtil:TimestampToTime(counterElem.nextExpiredTm - PlayerDataCenter.timestamp)
    return
  end
  self.ui.btn_Refresh.gameObject:SetActive(true)
  self.ui.obj_img_Timer:SetActive(false)
  if curPoint <= 0 then
    self.ui.btn_Refresh.interactable = false
  else
    self.ui.btn_Refresh.interactable = true
  end
  local isReachMax = curPoint >= maxPoint
  self.ui.tex_CoinCount.gameObject:SetActive(not isReachMax)
  self.ui.tex_limit.gameObject:SetActive(isReachMax)
  if not isReachMax then
    self.ui.tex_CoinCount.text = tostring(curPoint) .. "/" .. tostring(maxPoint)
  end
end

function UINSupportShopBar:OnClickClollectSupportPoint()
  local curPoint = PlayerDataCenter.inforData:GetCurSupportPoint()
  if curPoint <= 0 then
    return
  end
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterMoudleSupportPointPick, 0)
  if counterElem ~= nil and counterElem.nextExpiredTm >= PlayerDataCenter.timestamp then
    return
  end
  self.shopNetCtrl:CS_ASSISTANT_PickAstPoint(function(dataList)
    if dataList.Count == 0 then
      return
    end
    local gettedPointNum = dataList[0]
    local pointItemId = ConfigData.game_config.supportPointItemId
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList({pointItemId}, {gettedPointNum})
      window:AddAndTryShowReward(CRData)
    end)
    self:RefreshSupportValueNum()
    local maxPoint = ConfigData.game_config.supportPointMaxNum
    local curPoint = PlayerDataCenter.inforData:GetCurSupportPoint()
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, ShopEnum.ShopId.supportShop, RedDotStaticTypeId.ShopFriendSupportBtn)
    if maxPoint <= curPoint then
      node:SetRedDotCount(1)
    else
      node:SetRedDotCount(0)
    end
  end)
end

function UINSupportShopBar:OnHide()
  self.shopCtrl:RemoveShopTimerCallback(self.__RefreshSupportValueNum)
end

function UINSupportShopBar:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.ShopFriendSupportBtnPath, self.__onReddotChangeDotEvent)
  base.OnDelete(self)
end

return UINSupportShopBar
