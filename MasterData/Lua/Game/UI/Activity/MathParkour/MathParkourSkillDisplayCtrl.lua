local MathParkourSkillDisplayCtrl = class("MathParkourSkillDisplayCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local Path = require("path")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
MathParkourSkillDisplayCtrl._mapNodeConfig = {
  DisplayParent = {},
  imgBgChar = {sComponentName = "Image"},
  imgBgPortrait = {sComponentName = "Image"},
  DisplayL2d = {sComponentName = "RawImage"},
  animRoot = {sComponentName = "Animator", sNodeName = "animove"},
  imgBgCharL2d = {}
}
MathParkourSkillDisplayCtrl._mapEventConfig = {
  MathParkour_CastAssistSkill = "OnEvent_CastAssistSkill",
  MathParkour_CastAssistSkillPause = "OnEvent_CastAssistSkillPause"
}
MathParkourSkillDisplayCtrl._mapRedDotConfig = {}

function MathParkourSkillDisplayCtrl:Awake()
end

function MathParkourSkillDisplayCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.DisplayParent:SetActive(true)
    NovaAPI.SetMaskAllDirty(self._mapNode.imgBgCharL2d)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.DisplayParent:SetActive(false)
  end
  
  cs_coroutine.start(wait)
end

function MathParkourSkillDisplayCtrl:OnDisable()
end

function MathParkourSkillDisplayCtrl:OnDestroy()
  self.tbInterruptedDisplay = nil
  Actor2DManager.UnsetActor2D(false, 1, true)
end

function MathParkourSkillDisplayCtrl:InterrputAllDisplay()
  self:InterrputAnim()
end

function MathParkourSkillDisplayCtrl:InterrputAnim()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  Actor2DManager.UnsetActor2D(false, 1, true)
  self.callback = nil
  self._mapNode.DisplayParent:SetActive(false)
end

function MathParkourSkillDisplayCtrl:UltimateDisplay(nCharId, nSkinId)
  self:InitL2dRes(nCharId, nSkinId)
  self:ShowSkill(nCharId, nSkinId)
end

function MathParkourSkillDisplayCtrl:InitL2dRes(nCharId, nSkinId)
  local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  local sBodyName = string.format("%s_001", nSkinId)
  self.LoadSprite(self._mapNode.imgBgPortrait, mapSkin.Portrait, sBodyName)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharId)
  local sColor
  if mapCharDescCfg == nil then
    sColor = ""
  else
    sColor = mapCharDescCfg.CharSkillColor == "" and mapCharDescCfg.CharColor or mapCharDescCfg.CharSkillColor
  end
  local _b, _color = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgBgChar, _color)
end

function MathParkourSkillDisplayCtrl.LoadSprite(imgObj, sPath, sName)
  local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPath), sName)
  NovaAPI.SetImageSprite(imgObj, Settings.AB_ROOT_PATH .. _sPath)
end

function MathParkourSkillDisplayCtrl:ShowSkill(nCharId, nSkinId, callback)
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  WwiseAudioMgr:PostEvent("ui_tip_support_ult")
  self._mapNode.DisplayParent:SetActive(true)
  NovaAPI.SetMaskAllDirty(self._mapNode.imgBgCharL2d)
  self._mapNode.animRoot:Play("Empty")
  self._mapNode.animRoot:Play("SubskillDisplay_moves_1")
  self.gameObject.transform.localScale = Vector3.one
  Actor2DManager.SetActor2D_ForSubSKill(PanelId.SubSkillDisplay, self._mapNode.DisplayL2d, nCharId, nSkinId, nil, nIdx)
  Actor2DManager.PlayAnim("ultra", true, 1)
  self.callback = callback
  self.timer = self:AddTimer(1, 1.5, "ShowEnd", true, true, true, true)
end

function MathParkourSkillDisplayCtrl:ShowEnd()
  if self.callback ~= nil and type(self.callback) == "function" then
    self.callback()
  end
  Actor2DManager.UnsetActor2D(false, 1)
  self.callback = nil
  self._mapNode.DisplayParent:SetActive(false)
  self.timer = nil
end

function MathParkourSkillDisplayCtrl:OnEvent_CastAssistSkillPause(bPause)
  if bPause then
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback()
    end
    self:InterrputAllDisplay()
  end
end

function MathParkourSkillDisplayCtrl:OnEvent_CastAssistSkill(nCharId, nSkinId)
  self:UltimateDisplay(nCharId, nSkinId)
end

return MathParkourSkillDisplayCtrl
