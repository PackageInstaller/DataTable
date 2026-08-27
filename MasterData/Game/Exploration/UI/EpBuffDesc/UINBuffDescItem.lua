local UINBuffDescItem = class("UINBuffDescItem", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease
local cs_MessageCommon = CS.MessageCommon

function UINBuffDescItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickBtnRoot)
end

function UINBuffDescItem:InitBuffDescItem(epBuff)
  if epBuff == nil then
    return
  end
  local cfg = epBuff:GetBuffCfg()
  self:InitBuffDescItemByCfg(cfg)
end

function UINBuffDescItem:InitBuffDescItemForWCBuff(wcBuff)
  if wcBuff == nil then
    return
  end
  local cfg = wcBuff:GetBuffCfg()
  self:InitBuffDescItemByCfg(cfg)
end

function UINBuffDescItem:InitBuffDescItemByCfg(cfg)
  self.ui.img_Buff.sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.ExplorationIcon)
  local colIndex = cfg.buff_type + 1
  self.ui.img_Col.color = self.ui.array_Col[colIndex]
  self.ui.tex_BuffName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(cfg.describe)
end

function UINBuffDescItem:InitBuffDescItemSelect(epBuff, lock, onClickFunc)
  self._onClickFunc = onClickFunc
  self._epBuff = epBuff
  self:SetBuffDescItemSelect(false)
  self:InitBuffDescItem(epBuff)
  self.ui.obj_lock:SetActive(lock)
  self._lock = lock
end

function UINBuffDescItem:SetBuffDescItemSelect(select)
  self.ui.obj_selectFrame:SetActive(select)
end

function UINBuffDescItem:_OnClickBtnRoot()
  if self._lock then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(409))
    return
  end
  if self._onClickFunc ~= nil then
    self._onClickFunc(self, self._epBuff)
  end
end

function UINBuffDescItem:StartBuffDescFlySeq(seq, pos, curPos)
  self.ui.ly_Item.ignoreLayout = true
  self.transform.localPosition = curPos
  seq:Join(self.ui.fade:DOFade(0, 0.5):SetEase(cs_Ease.InOutQuad))
  seq:Join(self.transform:DOScale(0.5, 0.5):SetEase(cs_Ease.InQuad))
  seq:Join(self.transform:DOMove(pos, 0.5):SetEase(cs_Ease.InQuad))
end

function UINBuffDescItem:OnDelete()
  base.OnDelete(self)
end

return UINBuffDescItem
