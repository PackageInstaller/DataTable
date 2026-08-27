local UINSltChipSuitItemIntro = class("UINSltChipSuitItemIntro", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")

function UINSltChipSuitItemIntro:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.transform.anchoredPosition = Vector2.zero
  self.ui.suitDescItem:SetActive(false)
  self.suitDescPool = UIItemPool.New(UINEpChipSuitDescItem, self.ui.suitDescItem)
  self._onDescribeChange = BindCallback(self, self._OnDescribeChange)
end

function UINSltChipSuitItemIntro:OnShow()
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
  base.OnShow(self)
end

function UINSltChipSuitItemIntro:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
  base.OnHide(self)
end

function UINSltChipSuitItemIntro:InitSltChipSuitItemIntro(chipTagId)
  self.chipTagId = chipTagId
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  self.suitDescPool:HideAll()
  local tagSuitCfg = ConfigData.chip_tag.tag_suits[chipTagId]
  for _, tag_suit in pairs(tagSuitCfg) do
    local chipDescItem = self.suitDescPool:GetOne()
    chipDescItem:InitSuitDescItem(tag_suit.number, true, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
  end
end

function UINSltChipSuitItemIntro:_OnDescribeChange()
  if not self.gameObject.activeSelf then
    return
  end
  self:InitSltChipSuitItemIntro(self.chipTagId)
end

function UINSltChipSuitItemIntro:OnDelete()
  self.suitDescPool:DeleteAll()
  base.OnDelete(self)
end

return UINSltChipSuitItemIntro
