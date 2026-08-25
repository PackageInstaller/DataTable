local CommonCoinCostCom, Super = System.NewComponent("CommonCoinCostCom")

function CommonCoinCostCom:ctor(go)
  Super.ctor(self)
  self.ui = UI_Common_Group_CoinResource(go)
end

function CommonCoinCostCom:OnBind(binder)
  self.binder = binder
  self.tState = Vue.reactive({})
  self.tState.nowColorState = true
  self.tState.oriColorState = true
  self.binder:BindToTextColor(self.ui.Text_Coin_Now, function()
    return self.tState.nowColorState and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  end)
  self.binder:BindToTextColor(self.ui.Text_Coin_Original, function()
    return self.tState.oriColorState and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  end)
end

function CommonCoinCostCom:UpdateCoinCost(itemTid, costNum, costFormatOrNil, oriFormatOrNil)
  self:UpdateItem(itemTid)
  local ownNum = ItemDataUtils.GetItemNum(itemTid)
  local nowStr = costFormatOrNil or "{2}/{1}"
  for i = 1, 2 do
    nowStr = string.gsub(nowStr, "{" .. i .. "}", 1 == i and costNum or ownNum)
  end
  self:UpdateNow(nowStr)
  local oriStr = oriFormatOrNil or ""
  for i = 1, 2 do
    oriStr = string.gsub(oriStr, "{" .. i .. "}", 1 == i and costNum or ownNum)
  end
  self:UpdateOriValue(oriStr)
  self.ui.Text_Coin_Original:SetActive("" ~= oriStr)
  self:NowColorNormal(costNum <= ownNum)
end

function CommonCoinCostCom:UpdateItem(itemId)
  local config = DT.Item[itemId]
  self.binder:SetImage(self.ui.Image_Coin_Icon, config.Icon)
end

function CommonCoinCostCom:UpdateNow(needStr)
  self.binder:SetText(self.ui.Text_Coin_Now, LT.Text(needStr))
end

function CommonCoinCostCom:UpdateOriValue(oriValue)
  self.binder:SetText(self.ui.Text_Coin_Original, LT.Text(oriValue))
end

function CommonCoinCostCom:NowColorNormal(value)
  self.tState.nowColorState = value
end

function CommonCoinCostCom:OriColorNormal(value)
  self.tState.oriColorState = value
end

return CommonCoinCostCom
