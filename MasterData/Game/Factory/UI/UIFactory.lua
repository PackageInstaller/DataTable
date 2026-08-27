local UIFactory = class("UIFactory", UIBaseWindow)
local base = UIBaseWindow
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderListNode = require("Game.Factory.UI.UINFactoryOrderListNode")
local UINFactoryOrderNode = require("Game.Factory.UI.UINFactoryOrderNode")
local UINOasisBuildDetail = require("Game.Oasis.UI.Detail.UINOasisBuildDetail")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local JumpManager = require("Game.Jump.JumpManager")
local eWareHouseType = require("Game.Warehouse.eWareHouseType")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local OFFSET = Vector3.New(0, 2, 0)

function UIFactory:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.lockDic = {}
  self.lastSelectRoomIndex = nil
  self.isOpenOrder = false
  local energyId = ConfigData.game_config.factoryEnergyItemId
  UIUtil.SetTopStatus(self, self.CloseFactory, {1002, energyId}, nil, {
    [energyId] = function()
      local ShopEnum = require("Game.Shop.ShopEnum")
      local quickBuyData = ShopEnum.eQuickBuy.factoryEnergy
      local shopId = quickBuyData.shopId
      local shelfId = quickBuyData.shelfId
      local goodData
      local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      ctrl:GetShopData(shopId, function(shopData)
        goodData = shopData.shopGoodsDic[shelfId]
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
          if win == nil then
            error("can't open QuickBuy win")
            return
          end
          win:SlideIn()
          win:InitBuyFixedCountGood(1, goodData, true, quickBuyData.resourceIds)
        end)
      end)
    end
  })
  self.orderListNode = UINFactoryOrderListNode.New()
  self.orderListNode:Init(self.ui.obj_orderListNode)
  self.orderListNode:Hide()
  self.orderNode = UINFactoryOrderNode.New()
  self.orderNode:Init(self.ui.obj_orderNode)
  self.orderNode:Hide()
  self.m_OnClickRoom = BindCallback(self, self.OnClickRoom)
  self.m_OnClick3DBGWithPop = BindCallback(self, self.OnClick3DBG, true)
  self.m_ShowOrderDetail = BindCallback(self, self.ShowOrderDetail)
  self.m_OnRoomMove = BindCallback(self, self.OnRoomMove)
  self.m_OnClick3DBG = BindCallback(self, self.OnClick3DBG)
  self.ui.tween_OrderList.onRewind:AddListener(BindCallback(self, self.OrderNodesPlayBackwardsOver))
  self.ui.tween_OrderList.onComplete:AddListener(BindCallback(self, self.OrderNodesPlayOver))
  self.ui.tween_OrderList.onUpdate:AddListener(BindCallback(self, self.OrderNodesPlayUpdate))
  UIUtil.AddButtonListener(self.ui.btn_ProductDetial, self, self.OnClickProductDetial)
  UIUtil.AddButtonListener(self.ui.btn_Warehouse, self, self.OnClickWarehouse)
  UIUtil.AddButtonListener(self.ui.btn_ProductList, self, self.OnClickFactoryProduceList)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickFactoryGetAll)
  UIUtil.AddButtonListener(self.ui.btn_Repeat, self, self.OnClickQuickTimeProduct)
  self.__ConfirmOver = BindCallback(self, self.UpgradeConfirmOver)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  self:RefreshFactoryDetailBlueDot()
end

function UIFactory:OnClickRoom(roomEntity)
  if roomEntity.type == FactoryEnum.eRoomType.locked or roomEntity.type == FactoryEnum.eRoomType.notOpen then
    if roomEntity.type == FactoryEnum.eRoomType.locked then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(roomEntity.unlcokDes)
    end
    return
  else
    if NoticeManager:GetIsHaveThisTypeNotice(NoticeManager.eNoticeType.FactoryUnlockNewFactory) then
      NoticeManager:DeleteNoticeByFunc(function(noticeData)
        if noticeData.type == NoticeManager.eNoticeType.FactoryUnlockNewFactory and noticeData.extraData ~= nil and noticeData.extraData.id == roomEntity.index then
          return true
        end
        return false
      end)
    end
    if self.lastSelectRoomEntity ~= nil then
      self.lastSelectRoomEntity:SetSelected(false)
    end
    roomEntity:SetSelected(true)
    if self.lastSelectRoomIndex ~= roomEntity.index then
      if self.lastSelectRoomIndex == nil then
        self.lastSelectRoomIndex = roomEntity.index
        self.lastSelectRoomEntity = roomEntity
        self:OnClickProduction(roomEntity)
      else
        self.lastSelectRoomIndex = roomEntity.index
        self.lastSelectRoomEntity = roomEntity
        self.orderNode:InitOrderNode(self.lastSelectRoomIndex)
        self.orderListNode:InitList(self.lastSelectRoomIndex, self.m_ShowOrderDetail)
        if self.isOpenOrder then
          self.ui.tween_factoryOrderNode:DOPlayBackwardsAllById("orderOpen")
          AudioManager:PlayAudioById(1071)
          self.isOpenOrder = false
          self.orderListNode:DeSelect()
          UIUtil.PopFromBackStackByUiTab(self)
          return
        end
      end
      AudioManager:PlayAudioById(1122)
    end
  end
end

function UIFactory:OnClick3DBG(isNeedPop)
  if self.lastSelectRoomIndex ~= nil then
    if self.isOpenOrder then
      self.ui.tween_factoryOrderNode:DOPlayBackwardsAllById("orderOpen")
      AudioManager:PlayAudioById(1071)
      self.isOpenOrder = false
      self.orderListNode:DeSelect()
      if isNeedPop == true then
        UIUtil.ForcePopFromBackStack()
      end
      return
    end
    self.lastSelectRoomIndex = nil
    self:_CloseOrderNodes()
    if isNeedPop == true then
      UIUtil.ForcePopFromBackStack()
    end
  end
end

function UIFactory:OnClickProduction(roomEntity)
  self.ui.tween_OrderList:DOPlayForwardAllById("orderListOpen")
  self.factoryController:StartMoveRoomToLeftMin(self.ui.obj_posPointEnd, self.lastSelectRoomIndex)
  self.orderNode:Show()
  self.orderNode:InitOrderNode(self.lastSelectRoomIndex)
  self.orderListNode:Show()
  self.orderListNode:InitList(self.lastSelectRoomIndex, self.m_ShowOrderDetail)
  UIUtil.Push2BackStack(self, self.m_OnClick3DBG)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
end

function UIFactory:OrderNodesPlayUpdate()
  local rate = self.ui.orderListNode.alpha
  self.factoryController:OnMoveRoomToLeftMin(self.m_OnRoomMove, rate)
end

function UIFactory:OrderNodesPlayOver()
  self.factoryController:ForceMoveToLeft(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

function UIFactory:CloseOrderNodesSafe()
  if self.lastSelectRoomIndex ~= nil then
    self:_CloseOrderNodes()
  end
end

function UIFactory:_CloseOrderNodes()
  self.lastSelectRoomIndex = nil
  if self.lastSelectRoomEntity ~= nil then
    self.lastSelectRoomEntity:SetSelected(false)
  end
  self.ui.obj_enterhNode:SetActive(false)
  self.ui.tween_OrderList:DOPlayBackwardsAllById("orderListOpen")
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
end

function UIFactory:OrderNodesPlayBackwardsOver()
  self.orderListNode:Hide()
  self.orderNode:Hide()
  self.factoryController:MoveRoomToMid(self.m_OnRoomMove)
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

function UIFactory:ShowOrderDetail(orderCfg)
  self.orderNode:ShowOrder(orderCfg)
  if not self.isOpenOrder then
    self.ui.tween_factoryOrderNode:DOPlayForwardAllById("orderOpen")
    AudioManager:PlayAudioById(1070)
    self.isOpenOrder = true
    UIUtil.Push2BackStack(self, self.m_OnClick3DBG)
  end
end

function UIFactory:UpdateEnergy()
  if self.orderListNode.active then
    self.orderListNode:UpdateEnergy()
  end
  if self.orderNode.active then
    self.orderNode:UpdateEnergy()
  end
end

function UIFactory:OnRoomMove()
end

function UIFactory:RefreshFactoryDetailBlueDot()
  local factoryBuildingData = PlayerDataCenter.AllBuildingData.built[eBuildingId.OasisFactory]
  if factoryBuildingData ~= nil then
    self.ui.blueDotDetial:SetActive(factoryBuildingData:CanUpgrade())
  end
end

function UIFactory:RefreshProduceLineInfo()
  local have = self.factoryController:FactoryQuickPickAllState()
  self.ui.btn_GetAll.gameObject:SetActive(have)
  local quickProduct = self.factoryController:FactoryQuickTimeProductState()
  self.ui.btn_Repeat.gameObject:SetActive(quickProduct)
  local curOrderNum, maxOrderNum, isHaveFinished = self.factoryController:GetCurOrderAndMaxOrderNum()
  self.ui.tex_ProductNum:SetIndex(0, tostring(curOrderNum), tostring(maxOrderNum))
  if curOrderNum == 0 then
    self.ui.tex_State:SetIndex(2)
    return
  end
  if isHaveFinished then
    self.ui.tex_State:SetIndex(1)
  else
    self.ui.tex_State:SetIndex(0)
  end
end

function UIFactory:OnClickProductDetial()
  if PlayerDataCenter.AllBuildingData.unbuilt[eBuildingId.OasisFactory] ~= nil then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Factory_BuildingNotBuilt), function()
      JumpManager:Jump(JumpManager.eJumpTarget.Oasis, nil, nil)
    end, nil)
  else
    local factoryBuildingData = PlayerDataCenter.AllBuildingData.built[eBuildingId.OasisFactory]
    if self.detailNode == nil then
      self.buildPreviewNode = UINBuildLogicLvPreview.New()
      self.buildPreviewNode:Init(self.ui.logicPreviewNode)
      self.buildPreviewNode:Hide()
      local factoryTable = {
        buildPreviewNode = self.buildPreviewNode,
        levelUpFunc = function(buildingData)
          local nextLevel = buildingData.level + 1
          if nextLevel > buildingData.maxLevel then
            cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_LevelFull))
            return
          end
          if PlayerDataCenter.AllBuildingData:FullOasisBuildQue() then
            cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
            return
          end
          if not buildingData:CanUpgrade() then
            cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_NotFitUpgradeStatue))
            return
          end
          NetworkManager:GetNetwork(NetworkTypeID.Building):SendBuildingUpgrade(buildingData.id, function()
            if factoryBuildingData:CanUpgrade() then
              self.detailNode:InitOasisBuildDetail(factoryBuildingData, false)
            else
              self.detailNode:InitOasisBuildDetail(factoryBuildingData, true)
            end
            self:RefreshFactoryDetailBlueDot()
          end)
          return
        end
      }
      self.detailNode = UINOasisBuildDetail.New(nil, self.resloader, factoryTable)
      self.detailNode:Init(self.ui.detailNode)
    end
    if factoryBuildingData:CanUpgrade() then
      self.detailNode:InitOasisBuildDetail(factoryBuildingData, false)
    elseif factoryBuildingData:IsMaxLevel() then
      self.detailNode:InitOasisBuildDetail(factoryBuildingData, true)
    else
      self.detailNode:InitOasisBuildDetail(factoryBuildingData, false)
    end
  end
end

function UIFactory:UpgradeConfirmOver(id)
  if id ~= eBuildingId.OasisFactory then
    return
  end
  local factoryBuildingData = PlayerDataCenter.AllBuildingData.built[eBuildingId.OasisFactory]
  local tipsId
  if factoryBuildingData.level == 1 then
    tipsId = 5001
  else
    tipsId = 5002
  end
  cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(tipsId), factoryBuildingData.name))
end

function UIFactory:OnClickWarehouse()
  JumpManager:Jump(JumpManager.eJumpTarget.DynWarehouse, nil, nil, {
    [2] = eWareHouseType.wharehouseType.factory
  }, true)
end

function UIFactory:OnClickFactoryProduceList()
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryProduceLine, function(win)
    if win ~= nil then
      win:InitAllLines()
    end
  end)
end

function UIFactory:CloseFactory()
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.factoryController:FadeFactory()
  self.ui.canvasGroup:DOFade(0, 0.5):SetLink(self.ui.canvasGroup.gameObject)
end

function UIFactory:OnClickFactoryGetAll()
  self.factoryController:FactoryReqQuickPickAll()
end

function UIFactory:OnClickQuickTimeProduct()
  self.factoryController:FactoryReqQuickTimeProduct()
end

function UIFactory:OnDelete()
  if self.updateFunc ~= nil then
    UpdateManager:RemoveUpdate(self.updateFunc)
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.orderListNode:Delete()
  self.selRoomTween = nil
  self.orderNode:Delete()
  base.OnDelete(self)
end

return UIFactory
