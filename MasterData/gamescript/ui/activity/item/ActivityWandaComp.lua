local ActivityWandaComp, Super = System.NewClass("ActivityWandaComp", ActivityMagicStoryComp)

function ActivityWandaComp:ctor(res, activityTid, model, params)
  self.ui = UI_Events_Panel_BanquetResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activtyDefine = ActivityDefine.ActivityCompClsInfo[self.activityConfig.ActivityType]
  self.resonanceGroupId = self.activtyDefine.resonanceGroup
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivityWandaComp:OnBind(binder)
  Super.OnBind(self, binder)
  self.ui.Image_Limit_Award:SetActive(false)
end

function ActivityWandaComp:BindLockState()
  Super.BindLockState(self)
end

function ActivityWandaComp:BindShopItem()
  local _, shopTypeId = table.unpack(self.activityConfig.ActivityPara1)
  local shopTypeCfg = shopTypeId and DT.ShopType[shopTypeId]
  if not shopTypeCfg then
    self.ui.Btn_Shop:SetActive(false)
    return
  end
  self.ui.Btn_Shop:SetActive(true)
  local shopList = ActivityDataUtils.GetShopList(self.activityTid)
  if not table.next(shopList) then
    return
  end
  local showMoneyGroup = {}
  for idx, tid in ipairs(shopList) do
    local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(tid)
    local shopMoney = shopTypeConfig and shopTypeConfig.ShowMoney or {}
    for _, itemId in ipairs(shopMoney) do
      if not table.contains(showMoneyGroup, itemId) then
        table.insert(showMoneyGroup, itemId)
      end
    end
  end
  self:BindCoin(showMoneyGroup)
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ShopController.Instance:OpenActivityShopView(self.activityTid)
  end)
end

function ActivityWandaComp:BindCoin(showMoneyGroup)
  for index = 1, 3 do
    local showMoneyId = showMoneyGroup[index]
    local imageGo = self.ui["Image_Currency_0" .. index]
    local numTextGo = self.ui["Text_Currency_0" .. index]
    if not showMoneyId then
      if imageGo then
        imageGo:SetActive(false)
      end
      if numTextGo then
        numTextGo:SetActive(false)
      end
    else
      if imageGo then
        imageGo:SetActive(true)
      end
      if numTextGo then
        numTextGo:SetActive(true)
      end
      local moneyItemCfg = showMoneyId and ItemDataUtils.GetItemConfig(showMoneyId)
      if moneyItemCfg and imageGo and numTextGo then
        self.binder:BindToText(numTextGo, function()
          do return ItemDataUtils.GetItemNum end
          return ItemDataUtils.GetItemNum, showMoneyId
        end)
        self.binder:SetImageSync(imageGo, ItemDataUtils.GetIcon(showMoneyId))
      end
    end
  end
  self.binder:BindToRaw(function()
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Currency)
  end, function()
    local listenedItemList = {}
    for index = 1, 3 do
      local showMoneyId = showMoneyGroup[index]
      table.insert(listenedItemList, ItemDataUtils.GetItemNum(showMoneyId))
    end
    return listenedItemList
  end)
end

function ActivityWandaComp:BindSubPlotRecord()
  Super.BindSubPlotRecord(self)
end

function ActivityWandaComp:BindBtnChallenge()
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivityWandaComp:OnOpenAnim(callback)
  if self.ui.UI_Events_Panel_Lily_Audio then
    self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  end
  if not self.audioPlay then
    self.audioPlay = true
  end
  if self.activtyDefine.openAnim then
    self.uiAnimController:PlayState(self.activtyDefine.openAnim, callback)
  else
    self.ui.uiNode:SetActive(true)
    if callback then
      callback()
    end
  end
end

function ActivityWandaComp:OnCloseAnim(callback)
  if self.ui.UI_Events_Panel_Lily_Audio then
    self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  end
  if self.activtyDefine.closeAnim then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
  else
    self.ui.uiNode:SetActive(false)
    if callback then
      callback()
    end
  end
end

return ActivityWandaComp
