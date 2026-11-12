local TemplateExpBarCtrl = class("TemplateExpBarCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
TemplateExpBarCtrl._mapNodeConfig = {
  imgBar = {sComponentName = "Image"},
  imgBarAdd = {sComponentName = "Image"},
  txtCurExp = {sComponentName = "TMP_Text"},
  txtMaxCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_ExpBar_Max"
  }
}
TemplateExpBarCtrl._mapEventConfig = {}

function TemplateExpBarCtrl:Refresh(mapBefore, mapAfter)
  if not mapAfter then
    local bMaxLv = mapBefore.nLevel == mapBefore.nMaxLevel
    self._mapNode.imgBarAdd.gameObject:SetActive(false)
    self._mapNode.imgBar.gameObject:SetActive(true)
    NovaAPI.SetImageFillAmount(self._mapNode.imgBar, bMaxLv and 1 or mapBefore.nExp / mapBefore.nMaxExp)
    self._mapNode.txtMaxCn.gameObject:SetActive(bMaxLv)
    self._mapNode.txtCurExp.gameObject:SetActive(not bMaxLv)
    if not bMaxLv then
      NovaAPI.SetTMPText(self._mapNode.txtCurExp, mapBefore.nExp .. "/" .. mapBefore.nMaxExp)
    end
  else
    local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
    self._mapNode.imgBarAdd.gameObject:SetActive(true)
    NovaAPI.SetImageFillAmount(self._mapNode.imgBarAdd, bMaxLv and 1 or mapAfter.nExp / mapAfter.nMaxExp)
    self._mapNode.imgBar.gameObject:SetActive(mapBefore.nLevel == mapAfter.nLevel)
    if mapBefore.nLevel == mapAfter.nLevel then
      NovaAPI.SetImageFillAmount(self._mapNode.imgBar, bMaxLv and 1 or mapBefore.nExp / mapBefore.nMaxExp)
      self._mapNode.imgBarAdd.gameObject:SetActive(mapAfter.nExp > mapBefore.nExp)
    end
    self._mapNode.txtMaxCn.gameObject:SetActive(bMaxLv)
    self._mapNode.txtCurExp.gameObject:SetActive(not bMaxLv)
    if not bMaxLv then
      NovaAPI.SetTMPText(self._mapNode.txtCurExp, mapAfter.nExp .. "/" .. mapAfter.nMaxExp)
    end
  end
end

function TemplateExpBarCtrl:PlayAni(mapBefore, mapAfter, callback, txt)
  local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
  local nAddLevel = mapAfter.nLevel - mapBefore.nLevel
  local nAddCount = 0
  if nAddLevel == 0 then
    nAddCount = 1
  elseif 0 < mapAfter.nExp then
    nAddCount = nAddLevel + 1
  else
    nAddCount = nAddLevel
  end
  local nAniTime = 0.2
  if nAddCount < 6 then
    nAniTime = 0.2
  elseif 6 <= nAddCount and nAddCount < 11 then
    nAniTime = 0.06
  elseif 11 <= nAddCount then
    nAniTime = 0.03
  end
  local nBeforeToMaxTime = nAniTime * (1 - mapBefore.nExp / mapBefore.nMaxExp)
  local nBeforeToAfterTime = nAniTime * ((mapAfter.nExp - mapBefore.nExp) / mapAfter.nMaxExp)
  local nZeroToAfterTime = nAniTime * mapAfter.nExp / mapAfter.nMaxExp
  local nAllTime = 0
  local sequence = DOTween.Sequence()
  for i = 1, nAddCount - 1 do
    local nTime = i == 1 and nBeforeToMaxTime or nAniTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false))
    sequence:AppendCallback(function()
      NovaAPI.SetImageFillAmount(self._mapNode.imgBar, 0)
      NovaAPI.SetTMPText(txt, mapBefore.nLevel + i)
    end)
  end
  if bMaxLv then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false))
  elseif mapAfter.nExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, mapAfter.nExp / mapAfter.nMaxExp, nTime, false))
  elseif mapAfter.nExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false))
    sequence:AppendCallback(function()
      NovaAPI.SetImageFillAmount(self._mapNode.imgBar, 0)
    end)
  end
  sequence:SetUpdate(true)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function _cb()
    EventManager.Hit(EventId.BlockInput, false)
    if callback then
      callback()
    end
    if txt then
      NovaAPI.SetTMPText(txt, mapAfter.nLevel)
    end
  end
  
  sequence.onComplete = dotween_callback_handler(self, _cb)
end

return TemplateExpBarCtrl
