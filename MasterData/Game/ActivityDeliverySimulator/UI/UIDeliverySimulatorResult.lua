local base = UIBaseWindow
local UIDeliverySimulatorResult = class("UIDeliverySimulatorResult", base)
local UIDeliverySimulatorKnapsackGoodsItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorKnapsackGoodsItem")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local util = require("XLua.Common.xlua_util")

function UIDeliverySimulatorResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.OnBtnComfirmClick)
  UIUtil.AddButtonListener(self.ui.MaskSkip, self, self.SkipResultAnim)
  self.goodsItemPool = UIItemPool.New(UIDeliverySimulatorKnapsackGoodsItem, self.ui.obj_goodsItem, false)
  self.ui.tex_oredrNum.text = 0
  self.ui.tex_OrderPrice.text = 0
  self.ui.tex_TotalPrice.text = 0
  self.resloader = CS.ResLoader.Create()
  self.orderWaitFrame = 15
end

function UIDeliverySimulatorResult:InitPerformanceResult(goodsList, orderList, dsCtrl)
  self.dsCtrl = dsCtrl
  self.animTotalMoney = 0
  self.animDelayGoodsCount = 0
  self.totalMoney = 0
  self.goodsDic = {}
  self.completedOrderCount = 0
  self.orderMoney = 0
  self.orderList = orderList
  
  function self.ui.tween_fade.tween.onComplete()
    self:RefreshHandInGoodsList(goodsList)
    local delayefreshCompletedOrderListTime = table.count(goodsList) * 0.8 + self.animDelayGoodsCount * 0.16666666666666666
    self.orderResultTimerId = TimerManager:StartTimer(delayefreshCompletedOrderListTime, function()
      self:RefreshCompletedOrderList()
      self.orderResultTimerId = nil
    end, self, true, false)
  end
  
  local skinId = dsCtrl.dsRoleCfg.skin_id
  local heroId = dsCtrl.dsRoleCfg.hero_id
  local l2dCfg = ConfigData.skin_live2d[skinId]
  if l2dCfg == nil then
    self:__LoadPic(heroId, skinId)
  else
    self:__LoadL2D(heroId, skinId)
  end
end

function UIDeliverySimulatorResult:RefreshHandInGoodsList(goodsList)
  if goodsList ~= nil then
    local index = 0
    for goodsId, count in pairs(goodsList) do
      local goodsCfg = ConfigData.delivery_goods_spawn[goodsId]
      local atlas = self.dsCtrl:GetDeliveryAtlas()
      self:AddHandInGoodsItem(goodsCfg, atlas, count, index)
      self.totalMoney = self.totalMoney + goodsCfg.price * count
      index = index + 1
      self.animDelayGoodsCount = self.animDelayGoodsCount + count
    end
  end
end

function UIDeliverySimulatorResult:AddHandInGoodsItem(goodsCfg, atlas, count, index)
  local goodsItem = self.goodsDic[goodsCfg.goods_spawn_id]
  if goodsItem == nil then
    goodsItem = self.goodsItemPool:GetOne()
    local sprite = AtlasUtil.GetResldSprite(atlas, goodsCfg.icon)
    goodsItem:InitDeliverySimulatorKnapsackGoodsItem(sprite, goodsCfg.price, function()
      self:AddTotalMoney(goodsCfg.price)
    end)
    self.goodsDic[goodsCfg.goods_spawn_id] = goodsItem
  end
  goodsItem:Show()
  local delayTime = index * 0.8 + self.animDelayGoodsCount * 0.16666666666666666
  goodsItem:PlayShowAnim(delayTime, count)
end

function UIDeliverySimulatorResult:RefreshCompletedOrderList()
  local orderList = self.orderList
  local animOrderCount = 0
  local animOrderMoney = 0
  local waitFrame = 0
  
  local function AddOrderMoneyFunc()
    for index, order in pairs(orderList) do
      while 0 < waitFrame do
        waitFrame = waitFrame - 1
        coroutine.yield(nil)
      end
      animOrderCount = animOrderCount + 1
      animOrderMoney = animOrderMoney + order:GetOredrReward()
      self:RefreshOrderMoney(animOrderCount, animOrderMoney)
      self.totalMoney = self.totalMoney + order:GetOredrReward()
      self:AddTotalMoney(order:GetOredrReward())
      waitFrame = self.orderWaitFrame * 1 / (30 * Time.deltaTime)
    end
    self:ShowComfirmBtn(0.2)
  end
  
  if self._addOrderMoneyCoutCo ~= nil then
    GR.StopCoroutine(self._addOrderMoneyCoutCo)
  end
  self._addOrderMoneyCoutCo = GR.StartCoroutine(util.cs_generator(AddOrderMoneyFunc))
end

function UIDeliverySimulatorResult:AddCompletedOredr(order)
  self.completedOrderCount = self.completedOrderCount + 1
  self.orderMoney = self.orderMoney + order:GetOredrReward()
end

function UIDeliverySimulatorResult:AddTotalMoney(addMoney)
  self.animTotalMoney = self.animTotalMoney + addMoney
  self.ui.tex_TotalPrice.text = tostring(self.animTotalMoney)
  self.ui.tween_TotalPrice:DORestart()
end

function UIDeliverySimulatorResult:RefreshOrderMoney(completedOrderCount, orderMoney)
  self.ui.tex_oredrNum.text = completedOrderCount
  self.ui.tween_OrderNum:DORestart()
  self.ui.tex_OrderPrice.text = orderMoney
  self.ui.tween_OrderPrice:DORestart()
end

function UIDeliverySimulatorResult:ShowComfirmBtn(delay)
  TimerManager:StartTimer(delay, function()
    self.ui.tween_Comfirm:DORestart()
    self.ui.MaskSkip.gameObject:SetActive(false)
  end, self, true, false)
end

function UIDeliverySimulatorResult:__LoadL2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, 0, true)
      self.heroCubismInteration:SetL2DPosType("HeroList", false)
      self.heroCubismInteration:SetInterationOpenWait(false)
    end
  end)
end

function UIDeliverySimulatorResult:__LoadPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("GetHero")
  end)
end

function UIDeliverySimulatorResult:OnBtnComfirmClick()
  local function func()
    if self.dsCtrl ~= nil then
      self.dsCtrl:ExitDeliverySimulatorGame()
    end
  end
  
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  if actCtrl == nil then
    func()
    return
  end
  actCtrl:ResultExFunc(self.dsCtrl, func)
end

function UIDeliverySimulatorResult:SkipResultAnim()
  if not IsNull(self.ui.tween_fade.tween) then
    self.ui.tween_fade.tween:Complete()
  end
  self.orderWaitFrame = 0
  for key, goodsItem in pairs(self.goodsDic) do
    goodsItem:SkipShowAnim()
  end
  if self.orderResultTimerId ~= nil then
    TimerManager:StopTimer(self.orderResultTimerId)
    self:RefreshCompletedOrderList()
    self.orderResultTimerId = nil
  end
  self.ui.MaskSkip.gameObject:SetActive(false)
end

function UIDeliverySimulatorResult:OnDelete()
  if self._addOrderMoneyCoutCo ~= nil then
    GR.StopCoroutine(self._addOrderMoneyCoutCo)
  end
  self.resloader:Put2Pool()
  self.resloader = nil
end

return UIDeliverySimulatorResult
