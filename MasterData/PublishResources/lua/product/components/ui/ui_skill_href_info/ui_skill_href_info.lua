_class("UISkillHrefInfo", UIController)
UISkillHrefInfo = UISkillHrefInfo

function UISkillHrefInfo:OnShow(uiParams)
  self._offset = self:GetGameObject("offset")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self:Flush(uiParams[1])
end

function UISkillHrefInfo:OnHide()
  self._offset = nil
  self._txtName = nil
  self._imgIcon = nil
  self._txtDesc = nil
end

function UISkillHrefInfo:Flush(hrefName)
  if not hrefName then
    self:CloseSelfDialog()
    return
  end
  local id = tonumber(hrefName)
  local cfgv = Cfg.cfg_href_desc[id]
  if not cfgv then
    self:CloseSelfDialog()
    return
  end
  local name, icon, desc = self:GetInfo(cfgv)
  self._txtName:SetText(name)
  if string.isnullorempty(icon) then
    self._imgIcon.gameObject:SetActive(false)
  else
    self._imgIcon.gameObject:SetActive(true)
    self._imgIcon:LoadImage(icon)
  end
  self._txtDesc:SetText(desc)
end

function UISkillHrefInfo:bgOnClick()
  self:CloseSelfDialog()
end

function UISkillHrefInfo:CloseSelfDialog()
  GameGlobal.UIStateManager():CloseDialog(self:GetName())
end

function UISkillHrefInfo:GetInfo(cfgv)
  local name = ""
  local icon = ""
  local desc = ""
  if cfgv.type == SkillHrefInfoType.Buff then
    local buffId = cfgv.typeParam.buffId
    local cfgBuff = Cfg.cfg_buff[buffId]
    if cfgBuff then
      name = StringTable.Get(cfgBuff.Name)
      icon = cfgBuff.Icon
      desc = StringTable.Get(cfgBuff.Desc, cfgBuff.DescParams)
    end
  elseif cfgv.type == SkillHrefInfoType.Trap then
    local trapId = cfgv.typeParam.trapId
    local cfg = Cfg.cfg_trap[trapId]
    if cfg then
      name = StringTable.Get(cfg.NameStr)
      icon = cfg.CardResPath
      desc = StringTable.Get(cfg.InnerDesc)
    end
  elseif cfgv.type == SkillHrefInfoType.Global then
    local cfg = cfgv.typeParam
    if cfg then
      name = StringTable.Get(cfg.name)
      icon = cfg.icon
      desc = StringTable.Get(cfg.desc)
    end
  else
    Log.fatal("### unknown type")
  end
  return name, icon, desc
end

SkillHrefInfoType = {
  Buff = 1,
  Trap = 2,
  Global = 3
}
