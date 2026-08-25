local Text = CS.UnityEngine.UI.Text
local AwakerNewLevelUpComp, Super = System.NewComponent("AwakerNewLevelUpComp", AwakerBasePageComp)

function AwakerNewLevelUpComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Topped_DetailUpResource(uiNode)
  self.awakerModel = model
end

function AwakerNewLevelUpComp:OnBind(binder)
  self.levelUpModel = binder:createModel(AwakerLevelUpModel, self.awakerModel)
  self.binder = binder
  self:BindCurrency()
  self:BindAboutAwaker()
  self:BindAboutExp()
  self:BindAttrScroll()
  self:BindMaterialScroll()
  self:BindCost()
  self:BindButton()
  self:BindVisible()
  self:_HideItemTips()
end

function AwakerNewLevelUpComp:BindVisible()
  local binder = self.binder
  binder:BindToVisible(self.ui.UpPart, function()
    local currLv = self.levelUpModel.level
    local newLv = self:GetTargetLv()
    return currLv ~= newLv
  end)
end

function AwakerNewLevelUpComp:BindButton()
  local binder = self.binder
  binder:BindZ1Button(self.ui.UI_Awaker_Button_Addition, function()
    if self.levelUpModel:GetTotalCurrencyCost() > 0 then
      self:Clear()
    else
      self.levelUpModel:AutoSetExpItem()
    end
    self:_HideItemTips()
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    local bSetItem = self.levelUpModel:GetTotalCurrencyCost() > 0
    local cleanStr = LT.Text("NewLevelUp_alllClean")
    local setStr = LT.Text("NewLevelUp_autoSet")
    local str = bSetItem and cleanStr or setStr
    return str
  end)
  binder:BindZ1Button(self.ui.Btn_Breakthrough, function()
    local tid = self:GetAwakerId()
    local currLv = self.levelUpModel.level
    local newLv = self:GetTargetLv()
    local improveList = AwakerDataUtils.GetAwakerLevelChangeAttrImprove(tid, currLv, newLv)
    
    local function OnReqSuccess(svrData)
      self:Clear()
      if currLv == newLv then
        return
      end
      local sceneType = SceneMgr.Instance:GetSceneType()
      UIManager.Instance:InsertUIQueue(sceneType, true, Urls.AwakerCommonUpSuccessPanel, LT.Text("Awaker_LevelUp_Success"), currLv, newLv, improveList, tid, function()
        for _, v in pairs(svrData.backItems) do
          v.changedNum = v.num
        end
        local title = LT.Text("ItemGain_String_LevelUpGet_CHN")
        ItemDataUtils.ShowRewardPanel(title, "", svrData.backItems)
      end)
      if self.levelUpModel.isMaxLevel then
        self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.Detail)
      end
      local backBtn = GuidePanelUtils.GetNodeGo("UI_Awaker_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon")
      if backBtn then
        NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_AwakerLvUpBackBtn", backBtn, Urls.AwakerBasePanel)
      end
    end
    
    self.levelUpModel:ReqAwakerLevelUp(OnReqSuccess)
    self:_HideItemTips()
  end, function()
    local currencyItemId = DT.GetConstant("GeneralCultivationNeedCurreny")
    local own = ItemDataUtils.GetItemNum(currencyItemId)
    local need = self.levelUpModel:GetTotalCurrencyCost()
    if own < need or 0 == need then
      return CommonDefine.BtnType.Unclickable
    else
      EventMgr.Instance.NewbieGuideClick:Dispatch()
      return CommonDefine.BtnType.High
    end
  end)
  binder:SetActive(self.ui.UI_Common_Mask, false)
end

function AwakerNewLevelUpComp:BindAttrScroll()
  local binder = self.binder
  binder:BindToCircularListView(self.ui.ScrollView_AttrAdd, function()
    do return self.levelUpModel.GetImproveAttrList end
    return self.levelUpModel.GetImproveAttrList, self.levelUpModel
  end, function(itemBinder, obj, index)
    local list = self.levelUpModel:GetImproveAttrList()
    local data = list[index]
    itemBinder:BindComponent(AwakerLevelUpAttrItem(obj, data))
  end)
end

function AwakerNewLevelUpComp:BindMaterialScroll()
  local binder = self.binder
  binder:BindToCircularListView(self.ui.ScrollView, function()
    do return self.levelUpModel.GetExpItemSlotDatas end
    return self.levelUpModel.GetExpItemSlotDatas, self.levelUpModel
  end, function(itemBinder, obj, index)
    local function onClick(itemTid, relativeNode)
      if not self:_IsShowingTips(itemTid) then
        self:_HideItemTips()
        
        self:_ShowItemTips(itemTid, relativeNode)
      end
    end
    
    local function onClickSubBtn()
      self:_HideItemTips()
    end
    
    itemBinder:BindComponent(AwakerNewLevelUpMaterialItem(obj, index, self.levelUpModel, onClick, onClickSubBtn))
  end)
end

function AwakerNewLevelUpComp:BindCost()
  local binder = self.binder
  local com = binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
  local currencyItemId = DT.GetConstant("GeneralCultivationNeedCurreny")
  com:UpdateItem(currencyItemId)
  com:UpdateOriValue("")
  binder:BindToRaw(function(_, need, _)
    local own = ItemDataUtils.GetItemNum(currencyItemId)
    local oriCost = self.levelUpModel:GetTotalOriCost()
    local oriStr = oriCost == need and "" or oriCost
    com:NowColorNormal(need <= own)
    com:UpdateNow(need)
    com:UpdateOriValue(oriStr)
  end, function()
    do return self.levelUpModel.GetTotalCurrencyCost end
    return self.levelUpModel.GetTotalCurrencyCost, self.levelUpModel
  end)
  binder:BindToText(self.ui.Text_Addition, function()
  end)
end

function AwakerNewLevelUpComp:BindCurrency()
  local binder = self.binder
  local currencyList = DT.GetOriginalConstant("GeneralCultivationNeedCurreny")
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, currencyList, false, true))
end

function AwakerNewLevelUpComp:BindAboutAwaker()
  local binder = self.binder
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self:GetAwakerId()
    local config = AwakerDataUtils.GetAwakerConfig(tid)
    local iconPath = AwakerDataUtils.GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self:GetAwakerId()
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, tid
  end)
end

function AwakerNewLevelUpComp:GetExpShowParams()
  local tid = self:GetBaseTypeAwakerId()
  local currLv = self.levelUpModel.level
  local newLv = self:GetTargetLv() + 1
  local totalNeedExp = AwakerDataUtils.GetExpUpgradeEx(tid, currLv, newLv)
  local totalEatExp = self.levelUpModel:Get_ItemUsedProvide_Exp() + self.levelUpModel.exp
  local singleLvNeed = AwakerDataUtils.GetExpUpgradeEx(tid, newLv - 1, newLv)
  local leftExp = singleLvNeed - (totalNeedExp - totalEatExp)
  return leftExp, singleLvNeed
end

function AwakerNewLevelUpComp:BindAboutExp()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Number_Old, function()
    do return LT.Textf, "RoleInterfaceSort_Str_Level" end
    return LT.Textf, "RoleInterfaceSort_Str_Level", self.levelUpModel.level
  end)
  binder:BindToText(self.ui.Text_Number_New, function()
    if self.levelUpModel.hasReqLevelUp then
      local textComp = self.ui.Text_Level_Next:GetComponent(typeof(Text))
      return textComp.text
    end
    local tid = self:GetAwakerId()
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    local currLevelLimit = AwakerDataUtils.GetAwakerCurrLevelLimit(awaker)
    local fixLv = math.min(self:GetTargetLv(), currLevelLimit)
    local str = LT.Textf("RoleInterfaceSort_Str_Level", fixLv)
    return str
  end)
  binder:BindToText(self.ui.Text_Experience, function()
    if self.levelUpModel.canMaxLevel then
      do return LT.Text end
      return LT.Text, "Max", nil, nil, nil, nil, nil
    else
      local formatStr = "{s1}/{s2}"
      local leftExp, singleLvNeed = self:GetExpShowParams()
      local moneyStateStr = LT.Textf(formatStr, leftExp, singleLvNeed)
      return moneyStateStr
    end
  end)
  binder:BindToImageFillAmount(self.ui.Image_Love_Progress_Frame, function()
    if self.levelUpModel.canMaxLevel then
      return 1
    else
      local leftExp, singleLvNeed = self:GetExpShowParams()
      return leftExp / singleLvNeed
    end
  end)
end

function AwakerNewLevelUpComp:GetAwakerId()
  do return self.levelUpModel.GetSelectAwakerId end
  return self.levelUpModel.GetSelectAwakerId, self.levelUpModel
end

function AwakerNewLevelUpComp:GetBaseTypeAwakerId()
  do return self.levelUpModel.GetBaseTypeAwakerId end
  return self.levelUpModel.GetBaseTypeAwakerId, self.levelUpModel
end

function AwakerNewLevelUpComp:GetTargetLv()
  do return self.levelUpModel.GetTargetLevel end
  return self.levelUpModel.GetTargetLevel, self.levelUpModel
end

function AwakerNewLevelUpComp:Clear()
  self.levelUpModel:CleanAutoSetExp()
  self.levelUpModel:SetTargetLevel(self.levelUpModel.level)
  self:_HideItemTips()
end

function AwakerNewLevelUpComp:_IsShowingTips(itemTid)
  return itemTid == self.currShowTipsItemTid
end

function AwakerNewLevelUpComp:_ShowItemTips(itemTid, relativeNode)
  if itemTid == self.currShowTipsItemTid then
    return
  end
  self:_TeardownTipsBinder()
  self:_CreateTips(itemTid, relativeNode)
  self.currShowTipsItemTid = itemTid
end

function AwakerNewLevelUpComp:_HideItemTips()
  self:_TeardownTipsBinder()
  self.currShowTipsItemTid = nil
end

function AwakerNewLevelUpComp:_TeardownTipsBinder()
  if self.tipsBinder then
    self.tipsBinder:teardown()
    self.tipsBinder = nil
  end
end

function AwakerNewLevelUpComp:_CreateTips(itemTid)
  self.tipsBinder = self.binder:createChild(self.binder)
  ItemDataUtils.ShowItemDetailTips(self.tipsBinder, self.ui.uiNode, nil, itemTid, true, {
    posX = 370,
    posY = -140,
    closeCb = function()
      self:_HideItemTips()
    end
  })
end

function AwakerNewLevelUpComp:OnEnterDetail()
  self.ui.uiNode:SetActive(true)
end

function AwakerNewLevelUpComp:OnExitDetail()
  self:Clear()
  self.ui.uiNode:SetActive(false)
end

function AwakerNewLevelUpComp:GetOpenAnim()
end

function AwakerNewLevelUpComp:GetCloseAnim()
end

function AwakerNewLevelUpComp:GetEnterDetailAnim()
  return "UI_Awaker_Item_Topped_DetailUp_Open"
end

function AwakerNewLevelUpComp:GetExitDetailAnim()
  return "UI_Awaker_Item_Topped_DetailUp_Close"
end

return AwakerNewLevelUpComp
