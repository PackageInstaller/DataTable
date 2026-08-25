local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local GameObject = CS.UnityEngine.GameObject
local IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local Vector3 = CS.UnityEngine.Vector3
local CompPublicCoinCost, Super = NewViewComponent("CompPublicCoinCost")

function CompPublicCoinCost:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Group_CoinResource(uiNode)
  self.nowColorState = true
  self.oriColorState = true
end

function CompPublicCoinCost:OnEnterComponent()
  self:UpdateColor()
end

function CompPublicCoinCost:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompPublicCoinCost:UpdateColor()
  local colorType = self.nowColorState and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  self:SetTextColorType(self.ui.Text_Coin_Now, colorType)
  local colorType2 = self.oriColorState and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  self:SetTextColorType(self.ui.Text_Coin_Original, colorType2)
end

function CompPublicCoinCost:UpdateCoinCost(itemTid, costNum, costFormatOrNil, oriFormatOrNil)
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
  self:NowColorNormal(costNum <= ownNum)
end

function CompPublicCoinCost:UpdateItem(itemId)
  local config = DT.Item[itemId]
  self:SetImage(self.ui.Image_Coin_Icon, config.Icon)
end

function CompPublicCoinCost:UpdateNow(needStr)
  self:SetText(self.ui.Text_Coin_Now, LT.Text(needStr))
end

function CompPublicCoinCost:UpdateOriValue(oriValue)
  self:SetText(self.ui.Text_Coin_Original, LT.Text(oriValue))
end

function CompPublicCoinCost:NowColorNormal(value)
  self.nowColorState = value
end

function CompPublicCoinCost:OriColorNormal(value)
  self.oriColorState = value
end

return CompPublicCoinCost
