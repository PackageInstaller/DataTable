local ThrowGiftItemSelectCtrl = class("ThrowGiftItemSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftItemSelectCtrl._mapNodeConfig = {
  btnItemSelect = {
    nCount = 2,
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Item"
  },
  btnItemSelectCtrl = {
    sNodeName = "btnItemSelect",
    nCount = 2,
    sCtrlName = "Game.UI.Activity.ThrowGifts.ItemSelect.ThrowGiftItemSelectGridCtrl"
  },
  rtPos = {nCount = 2}
}
ThrowGiftItemSelectCtrl._mapEventConfig = {
  ThrowGiftItemSelectConfirmClick = "OnEvent_ThrowGiftItemSelectConfirmClick",
  GamepadUIChange = "OnEvent_GamepadUIChange"
}
ThrowGiftItemSelectCtrl._mapRedDotConfig = {}

function ThrowGiftItemSelectCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function ThrowGiftItemSelectCtrl:FadeIn()
end

function ThrowGiftItemSelectCtrl:FadeOut()
end

function ThrowGiftItemSelectCtrl:OnEnable()
  self.animator = self.gameObject:GetComponent("Animator")
  self.bSelected = false
  self.curIdx = 0
  self.tbOriginPos = {}
  self.tbOriginPos[1] = self._mapNode.btnItemSelectCtrl[1].gameObject.transform.position
  self.tbOriginPos[2] = self._mapNode.btnItemSelectCtrl[2].gameObject.transform.position
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnItemSelect) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_Item, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function ThrowGiftItemSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnItemSelect) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function ThrowGiftItemSelectCtrl:OnDestroy()
end

function ThrowGiftItemSelectCtrl:OnRelease()
end

function ThrowGiftItemSelectCtrl:Refresh(tbItem)
  self.animator:Play("rtItemSelect_in")
  self._mapNode.btnItemSelectCtrl[1]:Refresh(tbItem[1])
  self._mapNode.btnItemSelectCtrl[2]:Refresh(tbItem[2])
  self._mapNode.btnItemSelectCtrl[1].gameObject.transform.position = self.tbOriginPos[1]
  self._mapNode.btnItemSelectCtrl[2].gameObject.transform.position = self.tbOriginPos[2]
  self._mapNode.btnItemSelectCtrl[1].gameObject.transform.localEulerAngles = Vector3(0, 0, 0)
  self._mapNode.btnItemSelectCtrl[2].gameObject.transform.localEulerAngles = Vector3(0, 0, 0)
  self._mapNode.btnItemSelectCtrl[1].gameObject:SetActive(true)
  self._mapNode.btnItemSelectCtrl[2].gameObject:SetActive(true)
  WwiseAudioMgr:PostEvent("Mode_Present_intensify")
  self:ResetSelect(self._mapNode.btnItemSelect)
end

function ThrowGiftItemSelectCtrl:OpenPanel(tbItem, callback, curIdx)
  GamepadUIManager.EnableGamepadUI("ThrowGiftItemSelectCtrl", self.tbGamepadUINode)
  self.curPosIdx = curIdx
  self.gameObject:SetActive(true)
  self.callback = callback
  self.bSelected = false
  self.curIdx = 0
  self.tbItems = tbItem
  self.nCurItemsIdx = 1
  self.tbResultIdx = {}
  self:Refresh(self.tbItems[self.nCurItemsIdx])
end

function ThrowGiftItemSelectCtrl:ResetSelect(tbUI)
  self.curIdx = 0
  GamepadUIManager.SetNavigation(tbUI)
  local animTime = 0.4
  self:AddTimer(1, animTime, function()
    if self.curIdx == 0 then
      local nSelect = 1
      GamepadUIManager.ClearSelectedUI()
      GamepadUIManager.SetSelectedUI(self._mapNode.btnItemSelect[nSelect].gameObject)
      self.curIdx = nSelect
      self._mapNode.btnItemSelectCtrl[nSelect]:SetSelect(true)
      self._mapNode.btnItemSelectCtrl[nSelect == 2 and 1 or 2]:SetDefault()
    end
  end, true, true, true)
end

function ThrowGiftItemSelectCtrl:OnBtnClick_Item(btn, nIdx)
  WwiseAudioMgr:PostEvent("Mode_Present_intensify_choose")
  if self.bSelected then
    return
  end
  if self.curIdx == nIdx then
    return
  end
  self._mapNode.btnItemSelectCtrl[1]:SetSelect(nIdx == 1)
  self._mapNode.btnItemSelectCtrl[2]:SetSelect(nIdx == 2)
  self.curIdx = nIdx
end

function ThrowGiftItemSelectCtrl:OnBtnSelect_Item(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    self:OnBtnClick_Item(btn, nIndex)
  end
end

function ThrowGiftItemSelectCtrl:OnEvent_ThrowGiftItemSelectConfirmClick()
  if self.bSelected then
    return
  end
  if self.curIdx == 0 then
    return
  end
  self.bSelected = true
  table.insert(self.tbResultIdx, self.curIdx)
  if self.nCurItemsIdx < #self.tbItems then
    self._mapNode.btnItemSelectCtrl[1]:SetDefault()
    self._mapNode.btnItemSelectCtrl[2]:SetDefault()
    self.nCurItemsIdx = self.nCurItemsIdx + 1
    self.curIdx = 0
    self:Refresh(self.tbItems[self.nCurItemsIdx])
    self.bSelected = false
  else
    self._mapNode.btnItemSelectCtrl[self.curIdx]:PlaySelectAnim()
    WwiseAudioMgr:PostEvent("Mode_Present_intensify_ok")
    local endPos = self._mapNode.rtPos[self.curPosIdx].transform.position
    local beginPos = self._mapNode.btnItemSelectCtrl[self.curIdx].gameObject.transform.position
    local controlPos = Vector3(3, 5, 0)
    for i = 1, 2 do
      self._mapNode.btnItemSelectCtrl[i].gameObject:SetActive(i == self.curIdx)
    end
    
    local function wait()
      local totalMoveTime = 0.3
      local moveTime = 0
      local normalizedTime = 0
      while normalizedTime < 1 do
        moveTime = moveTime + CS.UnityEngine.Time.unscaledDeltaTime
        normalizedTime = moveTime / totalMoveTime
        normalizedTime = normalizedTime <= 1 and normalizedTime or 1
        local x, y, z = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
        local angleZ = -180 * normalizedTime
        self._mapNode.btnItemSelectCtrl[self.curIdx].gameObject.transform.localEulerAngles = Vector3(0, 0, angleZ)
        self._mapNode.btnItemSelectCtrl[self.curIdx].gameObject.transform.position = Vector3(x, y, z)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if self == nil or self.gameObject == nil or not self.gameObject then
          return
        end
      end
      if self.callback ~= nil and type(self.callback) == "function" then
        self.callback(self.tbResultIdx)
      end
      self.gameObject:SetActive(false)
      GamepadUIManager.DisableGamepadUI("ThrowGiftItemSelectCtrl")
    end
    
    if #self.tbResultIdx <= 1 then
      cs_coroutine.start(wait)
    else
      if self.callback ~= nil and type(self.callback) == "function" then
        self.callback(self.tbResultIdx)
      end
      self.gameObject:SetActive(false)
      GamepadUIManager.DisableGamepadUI("ThrowGiftItemSelectCtrl")
    end
  end
end

function ThrowGiftItemSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "ThrowGiftItemSelectCtrl" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.curIdx ~= 0 and self.curIdx or 1
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnItemSelect[nSelect].gameObject)
  end
end

return ThrowGiftItemSelectCtrl
