local UIEpBuffItem = class("UIEpBuffItem", UIBaseNode)

function UIEpBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpBuffItem:InitEpBuffItem(epBuff)
  local buffCfg = ConfigData.exploration_buff[epBuff.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(epBuff.dataId))
    return
  end
  self:InitEpBuffByCfg(epBuff, buffCfg)
end

function UIEpBuffItem:InitEpBuffByCfg(epBuff, buffCfg)
  self.ui.img_Pic.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  if epBuff.cnt > 0 then
    self.ui.buffCount:SetActive(true)
    self.ui.tex_buffCount.text = tostring(epBuff.cnt)
  else
    self.ui.buffCount:SetActive(false)
  end
end

return UIEpBuffItem
