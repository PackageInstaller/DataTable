local SkillSucBarCtrl = class("SkillSucBarCtrl", BaseCtrl)
SkillSucBarCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  SuccessBar = {
    sCtrlName = "Game.UI.SuccessBarEx.SuccessBarCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  txtNextLevel = {sComponentName = "TMP_Text"},
  txtLvCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skill_Level"
  },
  txtAddLv = {sComponentName = "TMP_Text"},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"},
  ani2 = {sNodeName = "imgDescBg", sComponentName = "Animator"}
}
SkillSucBarCtrl._mapEventConfig = {}

function SkillSucBarCtrl:Open()
  self:RefreshContent()
  self._mapNode.SuccessBar.gameObject:SetActive(true)
  self._mapNode.SuccessBar:PlayAni(AllEnum.SuccessBar.Blue, self.tbAni)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
end

function SkillSucBarCtrl:RefreshContent()
  self.tbAni = {
    self._mapNode.ani1,
    self._mapNode.ani2
  }
  local nId = self._panel.mapData.nSkillId
  local nLevel = self._panel.mapData.nNextLevel
  local sName = self._panel.mapData.sSkillName
  local mapCfgData_Skill = ConfigTable.GetData_Skill(nId)
  local sDesc = ""
  if mapCfgData_Skill ~= nil then
    sDesc = UTILS.ParseDesc(mapCfgData_Skill, GameEnum.levelTypeData.SkillSlot)
  end
  local nAddLv = self._panel.mapData.nAddLevel
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel, nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtName, string.format("「%s」", sName))
  NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.txtDesc.gameObject:SetActive(false)
    self._mapNode.txtDesc.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.txtAddLv.gameObject:SetActive(0 < nAddLv)
  if 0 < nAddLv then
    NovaAPI.SetTMPText(self._mapNode.txtAddLv, "(+" .. nAddLv .. ")")
  end
end

function SkillSucBarCtrl:Awake()
end

function SkillSucBarCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function SkillSucBarCtrl:OnDisable()
end

function SkillSucBarCtrl:OnDestroy()
end

function SkillSucBarCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.SkillSucBar)
end

function SkillSucBarCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SkillSucBarCtrl
