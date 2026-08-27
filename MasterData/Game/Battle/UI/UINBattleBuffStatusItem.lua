local UINBattleBuffStatusItem = class("UINBattleBuffStatusItem", UIBaseNode)

function UINBattleBuffStatusItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBattleBuffStatusItem:InitCSBattleBuff(csBattleBuff)
  local battleBuffCfg = ConfigData.battle_buff[csBattleBuff.dataId]
  self.ui.image.sprite = CRH:GetSprite(battleBuffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(battleBuffCfg.name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(battleBuffCfg.describe)
  self.ui.title.color = battleBuffCfg.buff_type == eBuffType.Debeneficial and self.ui.red or self.ui.green
  local curDurationTime = csBattleBuff.curDurationTime
  if 0 < curDurationTime then
    self.ui.time:SetActive(true)
    self.ui.tex_Time:SetIndex(0, tostring(BattleUtil.FrameToTime(curDurationTime)))
  else
    self.ui.time:SetActive(false)
  end
end

return UINBattleBuffStatusItem
