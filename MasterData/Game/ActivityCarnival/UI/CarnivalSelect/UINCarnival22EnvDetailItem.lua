local UINCarnival22EnvDetailItem = class("UINCarnival22EnvDetailItem", UIBaseNode)
local base = UIBaseNode
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")

function UINCarnival22EnvDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.selectedBg, self, self.OnClickItem)
  self._defaultOutputColor = self.ui.img_outputBg.color
end

function UINCarnival22EnvDetailItem:InitEnvDetailItem(carnival, envCfg, hideline, clickFunc)
  self._carnival = carnival
  self._envCfg = envCfg
  self._clickFunc = clickFunc
  self.ui.tex_EnviroNO.text = LanguageUtil.GetLocaleText(self._envCfg.env_name)
  self.ui.tex_ENEnviroNO:SetIndex(0, tostring(self._envCfg.id))
  self.ui.tex_Details.text = LanguageUtil.GetLocaleText(self._envCfg.env_des)
  local extraContent = LanguageUtil.GetLocaleText(self._envCfg.env_des_extra)
  self.ui.obj_outputBg:SetActive(not string.IsNullOrEmpty(extraContent))
  self.ui.tex_Output.text = extraContent
  self.ui.line:SetActive(not hideline)
  local unlock = self._carnival:IsCarnivalUnlockEnv(self._envCfg.id)
  self.ui.obj_Locked:SetActive(not unlock)
  self.ui.selectedBg.gameObject:SetActive(unlock)
  if not unlock then
    local unlockLevel = self._envCfg.exp_level
    local lockStr = string.format(ConfigData:GetTipContent(7122), tostring(unlockLevel))
    local lockDeslist = CheckCondition.GetUnlockAndInfoList(self._envCfg.pre_condition, self._envCfg.pre_para1, self._envCfg.pre_para2)
    for i = 1, #lockDeslist do
      lockStr = lockStr .. "\n" .. lockDeslist[i].lockReason
    end
    self.ui.tex_Locked.text = lockStr
    self.ui.enviroBg.color = self.ui.color_locked_img
    self.ui.tex_output_title.color = self.ui.color_locked_text
    self.ui.tex_ENEnviroNO.text.color = self.ui.color_locked_text
    self.ui.tex_Details.color = self.ui.color_locked_text
    self.ui.img_outputBg.color = self.ui.color_locked_img
  else
    self.ui.enviroBg.color = Color.white
    self.ui.tex_output_title.color = Color.white
    self.ui.tex_ENEnviroNO.text.color = Color.white
    self.ui.tex_Details.color = Color.white
    self.ui.img_outputBg.color = self._defaultOutputColor
  end
  local reddot = self._carnival:GetActivityReddot()
  if reddot == nil then
    return
  end
  reddot = reddot:GetChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  if reddot == nil then
    return
  end
  reddot = reddot:GetChild(tostring(self._envCfg.id))
  self.ui.redDot:SetActive(reddot ~= nil and 0 < reddot:GetRedDotCount())
end

function UINCarnival22EnvDetailItem:GetEnvDetailItemCfg()
  return self._envCfg
end

function UINCarnival22EnvDetailItem:SetEvnDetailItemCurrent(flag)
  self.ui.now:SetActive(flag)
  if flag then
    self.ui.selectedBg.gameObject:SetActive(false)
  end
end

function UINCarnival22EnvDetailItem:OnClickItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self._envCfg.id)
  end
end

return UINCarnival22EnvDetailItem
