local base = UIBaseNode
local UINWCSSelectNubIconItem = class("UINWCSSelectNubIconItem", base)
local eWarChessUIEnum = require("Game.WarChess.UI.eWarChessUIEnum")

function UINWCSSelectNubIconItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.uiDownTextColor = {}
  UIUtil.LuaUIBindingTable(self.ui.img_Num.transform, self.uiDownTextColor)
  self._lastBarItemType = nil
end

function UINWCSSelectNubIconItem:InitWCSNubState(barItemType, nub, hasFlg)
  self.ui.obj_Next:SetActive(false)
  if self._lastBarItemType == barItemType then
    return
  end
  self._lastBarItemType = barItemType
  if barItemType == eWarChessUIEnum.WCSBarItemType.Lobby then
    self.ui.img_BgSmall:SetIndex(1)
    self.ui.img_BgItemInfo:SetIndex(1)
    self.ui.icon_Boss.gameObject:SetActive(false)
    self.ui.img_Num.gameObject:SetActive(false)
    self.ui.img_BgSmall.transform.localScale = Vector3.Temp(1, 1, 1)
  elseif barItemType == eWarChessUIEnum.WCSBarItemType.Boss then
    self.ui.img_BgSmall:SetIndex(0)
    self.ui.img_BgItemInfo:SetIndex(0)
    self.ui.icon_Boss.gameObject:SetActive(true)
    self.ui.img_Num.gameObject:SetActive(false)
    self.ui.img_BgSmall.transform.localScale = Vector3.Temp(1.43, 1.43, 1)
  else
    self.ui.img_BgSmall:SetIndex(0)
    self.ui.img_BgItemInfo:SetIndex(0)
    self.ui.icon_Boss.gameObject:SetActive(false)
    self.ui.img_Num.gameObject:SetActive(true)
    self.ui.img_BgSmall.transform.localScale = Vector3.Temp(1, 1, 1)
    self.ui.img_Num.color = self.ui.color_WhiteBackground
    self.ui.img_Num.text = tostring(nub)
  end
  if hasFlg then
    self.ui.obj_Flag:SetActive(true)
  else
    self.ui.obj_Flag:SetActive(false)
  end
end

function UINWCSSelectNubIconItem:WCSNubIconGrey()
  self.ui.img_BgItemInfo.gameObject:SetActive(false)
  self.ui.img_Num.color = self.ui.color_GreyBackground
  self.ui.icon_Boss.color = self.ui.color_GreyBackground
end

function UINWCSSelectNubIconItem:WCSNubIconLight()
  self.ui.img_BgItemInfo.gameObject:SetActive(true)
  self.ui.img_Num.color = self.ui.color_WhiteBackground
  self.ui.icon_Boss.color = self.ui.color_WhiteBackground
end

function UINWCSSelectNubIconItem:WCSPlayNextTips()
  self.ui.obj_Next:SetActive(true)
  self.ui.obj_Next.transform:DOPunchPosition(Vector3.New(0, 10, 0), 1, 1):SetLoops(-1):SetLink(self.ui.obj_Next)
end

function UINWCSSelectNubIconItem:WCSAppendIconComplete(seq)
  self.ui.img_BgItemInfo.gameObject:SetActive(true)
  self.ui.img_BgItemInfo.image.color = Color.New(1, 1, 1, 0)
  seq:Append(self.ui.img_BgItemInfo.image:DOFade(1, 0.6):SetLink(self.gameObject))
  seq:Join(self.ui.img_Num:DOColor(self.ui.color_WhiteBackground, 0.6):SetLink(self.gameObject))
end

function UINWCSSelectNubIconItem:WCSGetBarItemType()
  return self._lastBarItemType
end

function UINWCSSelectNubIconItem:AddWCSBarItemCompleteOutlineExpand(seq)
  seq:AppendCallback(function()
    self.ui.img_BgCompleteOutline.gameObject:SetActive(true)
  end):Append(self.ui.img_BgCompleteOutline:DOFade(0, 0.2):From()):Join(self.ui.img_BgCompleteOutline.transform:DOScale(Vector3.New(2, 2, 2), 0.16)):Join(self.ui.img_BgCompleteOutline:DOFade(0, 0.2):SetDelay(0.1))
end

function UINWCSSelectNubIconItem:AddWCSBarItemExpand(seq, delay)
  self:Show()
  self.ui.cg_item.alpha = 0
  seq:Insert(delay, self.ui.cg_item:DOFade(1, 0.2))
  seq:Insert(delay, self.transform:DOScale(Vector3.zero, 0.3):From())
end

function UINWCSSelectNubIconItem:WCSAppendIconFlag(seq)
  seq:AppendCallback(function()
    self.ui.obj_Flag:SetActive(true)
  end)
  seq:Append(self.ui.obj_Flag.transform:DOLocalMove(Vector3.New(0, 10, 0), 0.2):From())
end

return UINWCSSelectNubIconItem
