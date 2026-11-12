local SwapCharCtrl = class("SwapCharCtrl", BaseCtrl)
SwapCharCtrl._mapNodeConfig = {
  imgHeadSelectSwap = {sComponentName = "Image"},
  imgCharBgSwap = {nCount = 3},
  imgProhibit = {nCount = 3},
  imgHead = {sComponentName = "Image", nCount = 3},
  imgMask = {nCount = 3}
}
SwapCharCtrl._mapEventConfig = {
  SwapCharIn = "OnEvent_SwapIn",
  SwapCharOut = "OnEvent_SwapOut",
  CloseSwap = "OnEvent_ClosePanel"
}

function SwapCharCtrl:Awake()
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
end

function SwapCharCtrl:FadeIn()
end

function SwapCharCtrl:FadeOut()
end

function SwapCharCtrl:OnEnable()
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
  self.gameObject:SetActive(false)
end

function SwapCharCtrl:OnDisable()
end

function SwapCharCtrl:OnDestroy()
end

function SwapCharCtrl:OnRelease()
end

function SwapCharCtrl:ShowSwapChar(tbChar, nSelectCharId, callback)
  self.gameObject:SetActive(true)
  self.tbChar = tbChar
  self.nSelectCharId = nSelectCharId
  self.nSelectedIdx = table.indexof(self.tbChar, self.nSelectCharId)
  self.nCurSwapIdx = 0
  self.callback = callback
  for i = 1, 3 do
    if i == self.nSelectedIdx or self.tbChar[i] == 0 then
      self._mapNode.imgCharBgSwap[i]:SetActive(false)
      self._mapNode.imgProhibit[i]:SetActive(true)
    else
      local mapCharCfg = ConfigTable.GetData_Character(self.tbChar[i])
      local nSkinId = PlayerData.Char:GetCharSkinId(self.tbChar[i])
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
      self:SetPngSprite(self._mapNode.imgHead[i], mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
      self._mapNode.imgCharBgSwap[i]:SetActive(true)
      self._mapNode.imgProhibit[i]:SetActive(false)
      self._mapNode.imgMask[i]:SetActive(false)
    end
  end
  local mapCharCfg = ConfigTable.GetData_Character(nSelectCharId)
  local nSkinId = PlayerData.Char:GetCharSkinId(nSelectCharId)
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  self:SetPngSprite(self._mapNode.imgHeadSelectSwap, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
  end
  
  cs_coroutine.start(wait)
end

function SwapCharCtrl:OnEvent_ClosePanel()
  self.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
  if self.callback ~= nil then
    self.callback(self.nCurSwapIdx)
  end
end

function SwapCharCtrl:OnEvent_SwapIn(nIdx)
  if nIdx == self.nSelectCharId then
    return
  end
  if nIdx == self.nCurSwapIdx then
    return
  end
  if 0 == self.tbChar[nIdx] then
    return
  end
  if self.nCurSwapIdx ~= 0 then
    self._mapNode.imgMask[self.nCurSwapIdx]:SetActive(false)
  end
  self.nCurSwapIdx = nIdx
  self._mapNode.imgMask[nIdx]:SetActive(true)
end

function SwapCharCtrl:OnEvent_SwapOut()
  if self.nCurSwapIdx ~= 0 then
    self._mapNode.imgMask[self.nCurSwapIdx]:SetActive(false)
  end
  self.nCurSwapIdx = 0
end

return SwapCharCtrl
