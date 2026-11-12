local SkillDisplayCtrl = class("SkillDisplayCtrl", BaseCtrl)
SkillDisplayCtrl._mapNodeConfig = {
  TMP_SkillName = {sComponentName = "TMP_Text"},
  imgSubSkillIcon = {sComponentName = "Image"}
}
SkillDisplayCtrl._mapEventConfig = {}

function SkillDisplayCtrl:Awake()
end

function SkillDisplayCtrl:FadeIn()
end

function SkillDisplayCtrl:FadeOut()
end

function SkillDisplayCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.gameObject:SetActive(false)
  end
  
  cs_coroutine.start(wait)
end

function SkillDisplayCtrl:OnDisable()
end

function SkillDisplayCtrl:OnDestroy()
end

function SkillDisplayCtrl:OnRelease()
end

function SkillDisplayCtrl:ShowSkillTips(nSkillId, nCharId, callback)
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.animRoot.enabled = true
    self.animRoot:Play("SubSkillDisplay_skill_1")
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
  end
  
  self.animRoot.enabled = false
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
  cs_coroutine.start(wait)
  local mapSkillCfgData = ConfigTable.GetData_Skill(nSkillId)
  if mapSkillCfgData == nil then
    printError("Skill Data Missing:" .. nSkillId)
    NovaAPI.SetTMPText(self._mapNode.TMP_SkillName, "")
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_SkillName, mapSkillCfgData.Title)
  end
  local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  self:SetPngSprite(self._mapNode.imgSubSkillIcon, mapSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
  self.ShowEndCallback = callback
  self.gameObject:SetActive(true)
  self.timer = self:AddTimer(1, 1.5, "ShowEnd", true, true, true, true)
  self.bPlaying = true
end

function SkillDisplayCtrl:ShowEnd()
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgSubSkillIcon, nil)
  NovaAPI.SetTMPText(self._mapNode.TMP_SkillName, "")
  if self.ShowEndCallback ~= nil and type(self.ShowEndCallback) == "function" then
    self.ShowEndCallback()
  end
  self.ShowEndCallback = nil
  self.gameObject:SetActive(false)
  self.timer = nil
  self.bPlaying = false
end

function SkillDisplayCtrl:InterrputAnim()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgSubSkillIcon, nil)
  NovaAPI.SetTMPText(self._mapNode.TMP_SkillName, "")
  self.ShowEndCallback = nil
  self.gameObject:SetActive(false)
  self.timer = nil
  self.bPlaying = false
end

return SkillDisplayCtrl
