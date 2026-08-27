local UINLtrSHNode = class("UINLtrSHNode", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UINLtrSHNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickClose)
  self:_InitSwithTween()
end

function UINLtrSHNode:InitLtrSHNode(itemId, curHeroCfg, ltrCfg, ltrCtrl)
  self.itemId = itemId
  self.curHeroCfg = curHeroCfg
  self.ltrCfg = ltrCfg
  self.ltrCtrl = ltrCtrl
  self.showSeq:Rewind()
  UIUtil.SetTopStatus(self, self.BackAction, {1001, 1002})
  UIUtil.SetCurButtonGroupActive(false)
  self.heroItem = UINHeroHeadItem:New()
  self.heroItem:Init(self.ui.obj_heroHeadItem)
  self:ReFreshLtrSHUI()
end

function UINLtrSHNode:ReFreshLtrSHUI()
  self.heroItem:InitHeroHeadItemWithId(self.curHeroCfg.id)
  local rankCfg = ConfigData.hero_rank[self.curHeroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(self.curHeroCfg.rank))
  end
  self:__RefreshStar(rankCfg.star)
  local name = LanguageUtil.GetLocaleText(self.curHeroCfg.name)
  local costNum = self.ltrCfg.costNum4
  local itemCount = PlayerDataCenter:GetItemCount(self.ltrCfg.costId4)
  local info = string.format(ConfigData:GetTipContent(311), costNum, name)
  self.ui.tex_Title.text = ConfigData:GetTipContent(310)
  self.ui.tex_Name.text = name
  self.ui.tex_Info.text = info
  self.ui.tex_PtFrom.text = itemCount
  self.ui.tex_PtTo.text = itemCount - costNum
end

function UINLtrSHNode:__RefreshStar(heroStar)
  local half = heroStar % 2
  local rankImgIndex = (heroStar - half) / 2 - 1
  if 0 <= rankImgIndex then
    self.ui.img_Star.gameObject:SetActive(true)
    self.ui.img_Star:SetIndex(rankImgIndex)
    local vec = self.ui.img_Star.image.rectTransform.sizeDelta
    vec.x = self.ui.img_Star.image.sprite.rect.width
    self.ui.img_Star.image.rectTransform.sizeDelta = vec
  else
    self.ui.img_Star.gameObject:SetActive(false)
  end
  self.ui.img_Half.gameObject:SetActive(half == 1)
end

function UINLtrSHNode:_OnClickConfirm()
  self.ltrCtrl:LtrFreeSelect(self.itemId)
  self:_OnClickClose()
end

function UINLtrSHNode:BindCloseFun(closeFun)
  self.__closeFun = closeFun
end

function UINLtrSHNode:_InitSwithTween()
  self:_KillTween()
  local sequence = cs_DoTween.Sequence()
  sequence:SetEase(cs_Ease.InQuad)
  sequence:SetAutoKill(false)
  sequence:Pause()
  self.showSeq = sequence
end

function UINLtrSHNode:_KillTween()
  if self.showSeq ~= nil then
    self.showSeq:Kill(true)
    self.showSeq = nil
  end
end

function UINLtrSHNode:BackAction()
  self:Hide()
  if self.__closeFun ~= nil then
    self.__closeFun()
  end
end

function UINLtrSHNode:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINLtrSHNode:OnDelete()
  self:_KillTween()
  base.OnDelete(self)
end

return UINLtrSHNode
