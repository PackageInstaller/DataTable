local UISignDiamondItem, Super = System.NewComponent("UISignDiamondItem")
local Vector2 = CS.UnityEngine.Vector2
local contentPosY = {
  [1] = 18,
  [2] = -48
}

function UISignDiamondItem:ctor(go, index, isLast, activityConfig, activityData, refrshFunc)
  Super.ctor(self)
  self.ui = UI_Events_Item_SignDiamondResource(go)
  self.obj = go
  self.index = index
  self.isLast = isLast
  self.activityConfig = activityConfig
  self.activityData = activityData
  self.refrshFunc = refrshFunc
end

function UISignDiamondItem:OnBind(binder)
  self.binder = binder
  self.iconItemModel = binder:createModel(CommonIconItemModel)
  local isFrist = 1 == self.index
  local isLast = self.isLast
  self.ui.Image_Rope_1:SetActive(1 == self.index % 2 and not isFrist)
  self.ui.Image_Rope_2:SetActive(0 == self.index % 2)
  self.ui.Image_Rope_3:SetActive(0 == (self.index - 1) % 2 and not isLast)
  self.ui.Image_Rope_4:SetActive(0 == self.index % 2 and not isLast)
  self.ui.Content.transform.anchoredPosition = Vector2(0, contentPosY[self.index % 2 + 1])
  
  local function _RedFunc()
    return false
  end
  
  local itemIdx = self.index * 2 - 1
  local itemTid = self.activityConfig.ActivityPara1[itemIdx]
  local itemCnt = self.activityConfig.ActivityPara1[itemIdx + 1]
  local state = self.activityData.prize[self.index]
  local itemCfg = DT.Item[itemTid]
  
  local function _OnClickAward()
    self:_OnGetAwakrd(binder, self.ui.WuPin_Type, self.index, itemTid)
  end
  
  local itemData = {
    tid = itemTid,
    num = itemCnt,
    model = self.iconItemModel,
    callback = _OnClickAward,
    activityPrizeState = state,
    redFunc = _RedFunc,
    showFullHead = true
  }
  local comp = binder:BindComponent(CommonIconItem(self.ui.WuPin_Type, itemData))
  comp:UpdateItemNum(ItemNumUtils.GetStr(LT.Text(itemCfg.Name), itemCnt))
  binder:SetText(self.ui.Text_Name, LT.Textf("ActivityRewardday", self.index))
  binder:BindToText(self.ui.Text_Day, function()
    if self.index < 10 then
      return "0" .. self.index
    end
    return self.index
  end)
  self.ui.Text_C_Receive:SetActive(state == CommonDefine.CommonState.Finish)
  self.ui.Text_Name:SetActive(state ~= CommonDefine.CommonState.Finish)
end

function UISignDiamondItem:_OnGetAwakrd(binder, obj, day, itemTid)
  local sevenLoginData = self.activityData
  local sevenLoginBaseData = sevenLoginData and sevenLoginData.base
  if not (sevenLoginData and sevenLoginData.prize) or not sevenLoginBaseData then
    return
  end
  local prizeState = sevenLoginData.prize[day] or CommonDefine.CommonState.Realy
  if prizeState ~= CommonDefine.CommonState.GainPrize then
    ItemDataUtils.ShowItemDetailTips(binder, obj, nil, itemTid)
    return
  end
  if sevenLoginBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    ActivityDataUtils.ReqGainAward(sevenLoginBaseData.tid, day, extraParams, function(result)
      if result then
        sevenLoginData.prize[day] = CommonDefine.CommonState.Finish
        self.refrshFunc()
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
        if onRequestCallback then
          onRequestCallback()
        end
      end
    end)
  end
  
  ToReqGainAward()
end

return UISignDiamondItem
