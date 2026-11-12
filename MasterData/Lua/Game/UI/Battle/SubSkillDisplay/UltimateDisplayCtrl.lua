local UltimateDisplayCtrl = class("UltimateDisplayCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local Path = require("path")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
UltimateDisplayCtrl._mapNodeConfig = {
  imgBgChar = {sComponentName = "Image"},
  imgBgPortrait = {sComponentName = "Image"},
  DisplayL2d = {sComponentName = "RawImage"},
  animRoot = {sComponentName = "Animator", sNodeName = "animove"},
  imgBgCharL2d = {}
}
UltimateDisplayCtrl._mapEventConfig = {}

function UltimateDisplayCtrl:Awake()
end

function UltimateDisplayCtrl:FadeIn()
end

function UltimateDisplayCtrl:FadeOut()
end

function UltimateDisplayCtrl:OnEnable()
  self.bPlaying = false
  self.bSecond = false
  self.animScale = self.gameObject:GetComponent("Animator")
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.gameObject:SetActive(true)
    NovaAPI.SetMaskAllDirty(self._mapNode.imgBgCharL2d)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.gameObject:SetActive(false)
  end
  
  cs_coroutine.start(wait)
end

function UltimateDisplayCtrl:OnDisable()
end

function UltimateDisplayCtrl:OnDestroy()
end

function UltimateDisplayCtrl:OnRelease()
end

function UltimateDisplayCtrl:ShowSkill(nCharId, nIdx, callback)
  if self.bPlaying then
    printError("上一个技能未播放完毕")
    return
  end
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  WwiseAudioMgr:PostEvent("ui_tip_support_ult")
  self.gameObject:SetActive(true)
  NovaAPI.SetMaskAllDirty(self._mapNode.imgBgCharL2d)
  self.bSecond = false
  self.animScale:Play("Empty")
  self._mapNode.animRoot:Play("SubskillDisplay_moves_1")
  self.gameObject.transform.localScale = Vector3.one
  self.gameObject.transform:SetAsFirstSibling()
  self.nIdx = nIdx
  local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  Actor2DManager.SetActor2D_ForSubSKill(PanelId.SubSkillDisplay, self._mapNode.DisplayL2d, nCharId, nSkinId, nil, nIdx)
  Actor2DManager.PlayAnim("ultra", true, nIdx)
  self.callback = callback
  self.timer = self:AddTimer(1, 1.5, "ShowEnd", true, true, true, true)
  self.bPlaying = true
end

function UltimateDisplayCtrl:ReShowSkill(callback, nIdx)
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.animRoot:Play("SubskillDisplay_moves_1")
    Actor2DManager.PlayAnim("ultra", true, nIdx)
  end
  
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  WwiseAudioMgr:PostEvent("ui_tip_support_ult")
  self.gameObject:SetActive(true)
  NovaAPI.SetMaskAllDirty(self._mapNode.imgBgCharL2d)
  self.bSecond = false
  self._mapNode.animRoot:Play("Empty")
  self.animScale:Play("Empty")
  cs_coroutine.start(wait)
  self.gameObject.transform:SetAsFirstSibling()
  self.gameObject.transform.localScale = Vector3.one
  self.callback = callback
  self.timer = self:AddTimer(1, 1.5, "ShowEnd", true, true, true, true)
  self.bPlaying = true
end

function UltimateDisplayCtrl:Set2SecondSkill()
  if self.bSecond then
    return
  end
  self.bSecond = true
  if self.bPlaying then
    self.animScale:Play("SubskillDisplay_scale_1")
  else
    return
  end
end

function UltimateDisplayCtrl:ShowEnd()
  if self.callback ~= nil and type(self.callback) == "function" then
    self.callback()
  end
  Actor2DManager.UnsetActor2D(false, self.nIdx)
  self.callback = nil
  self.gameObject:SetActive(false)
  self.bSecond = false
  self.timer = nil
  self.bPlaying = false
  self.nIdx = 0
end

function UltimateDisplayCtrl:InterrputAnim()
  if not self.bPlaying then
    return
  end
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  Actor2DManager.UnsetActor2D(false, self.nIdx)
  self.callback = nil
  self.gameObject:SetActive(false)
  self.bPlaying = false
  self.nIdx = 0
end

function UltimateDisplayCtrl:InitL2dRes(nCharId, nIdx)
  local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  local sBodyName = string.format("%s_001", nSkinId)
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
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

function UltimateDisplayCtrl.LoadSprite(imgObj, sPath, sName)
  local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPath), sName)
  NovaAPI.SetImageSprite(imgObj, Settings.AB_ROOT_PATH .. _sPath)
end

return UltimateDisplayCtrl
