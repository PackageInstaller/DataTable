local UIEpBuffDetailItem = class("UIEpBuffDetailItem", UIBaseNode)
local UIEpBuffItem = require("Game.Exploration.UI.EpBuff.UIEpBuffItem")

function UIEpBuffDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.buffItem = UIEpBuffItem.New()
  self.buffItem:Init(self.ui.buffItem)
end

function UIEpBuffDetailItem:InitEpBuffDetail(epBuff)
  local buffCfg = ConfigData.exploration_buff[epBuff.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(epBuff.dataId))
    return
  end
  self.buffItem:InitEpBuffByCfg(epBuff, buffCfg)
  self.ui.tex_BuffName.text = LanguageUtil.GetLocaleText(buffCfg.name)
  self.ui.tex_BuffInfomation.text = LanguageUtil.GetLocaleText(buffCfg.describe)
  self.expireTm = epBuff.expireTm
  self.ui.tex_BuffTime.gameObject:SetActive(self.expireTm > 0)
end

function UIEpBuffDetailItem:RefershBuffDetailTime(curTime)
  if self.expireTm <= 0 then
    return
  end
  local lastTime = math.ceil(math.max(self.expireTm - curTime, 0))
  self.ui.tex_BuffTime.text = TimeUtil:TimestampToTime(lastTime)
end

return UIEpBuffDetailItem
