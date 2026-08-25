local Z1ButtonState = CS.Z1Client.Z1ButtonState
local BtnState = CommonDefine.BtnType
local typeof = _ENV.typeof
local Z1Button = CS.Z1Client.Z1Button
local Button = typeof(CS.UnityEngine.UI.Button)
local BtnTips, Super = System.NewComponent("BtnTips")

function BtnTips:ctor(obj, resource, clickFunc, stateFunc, text, redFunc, modelData)
  Super.ctor(self)
  self.ui = resource(obj)
  self.clickFunc = clickFunc
  self.stateFunc = stateFunc
  self.text = text
  self.redFunc = redFunc
  self.state = nil
  self.modelData = modelData
end

function BtnTips:OnBind(binder)
  self.binder = binder
  if binder:GetButton(self.ui.uiNode) then
    binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnClick))
    local btnComp = binder:GetButton(self.ui.Btn_Click)
    if btnComp then
      btnComp.enabled = false
    end
  else
    binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  end
  local redObj = self.ui.Com_RedDot
  if redObj then
    if self.redFunc then
      binder:SetActive(redObj, true)
      binder:BindComponent(RedDotComponent(redObj, nil, nil, function()
        do return end
        return self.redFunc, nil
      end))
    else
      binder:SetActive(redObj, false)
    end
  end
  if not self.modelData then
    binder:BindToRaw(function(_, state)
      self:UpdateBtnShowByState(state)
    end, System.fn(self, self.StateFunc))
    self:SetBtnText()
  else
    local model = binder:createModel(BtnItemModel, self.modelData)
    local textTb = {
      "Text_Unclick",
      "Text_Normal",
      "Text_High"
    }
    for _, uiNodeKey in pairs(textTb) do
      local textObj = self.ui[uiNodeKey]
      if not textObj then
      else
        binder:BindToText(textObj, function()
          return model.btnItemData.text
        end)
      end
    end
    binder:BindToVisible(self.ui.Group_Unclickable, function()
      return model.btnItemData.state == BtnState.Unclickable
    end)
    binder:BindToVisible(self.ui.Group_Normal, function()
      return model.btnItemData.state == BtnState.Normal
    end)
    binder:BindToVisible(self.ui.Group_High, function()
      return model.btnItemData.state == BtnState.High
    end)
  end
end

function BtnTips:SetBtnText(text)
  local binder = self.binder
  if not text then
    text = self.text or ""
  else
    self.text = text
  end
  if "" == text then
    return
  end
  local tb = {
    "Text_Unclick",
    "Text_Normal",
    "Text_High"
  }
  for _, textObjName in ipairs(tb) do
    local textObj = self.ui[textObjName]
    if textObj then
      binder:SetText(textObj, text)
    end
  end
end

function BtnTips:StateFunc()
  self.state = CommonDefine.BtnType.Normal
  if self.stateFunc then
    self.state = self.stateFunc()
  end
  return self.state
end

function BtnTips:SetState(newState)
  self.state = newState
  self:UpdateBtnShowByState(newState)
end

function BtnTips:EnableButtonInteract(enable)
  self.ui.Btn_Click:GetComponent(Button).interactable = enable
end

function BtnTips:UpdateBtnShowByState(state)
  if nil == state then
    return
  end
  local z1BtnObj = self.ui.Btn_Click:GetComponent(typeof(Z1Button))
  if z1BtnObj then
    local btnStateMap = {
      [CommonDefine.BtnType.Unclickable] = CommonDefine.Z1ButtonState.Unclickable,
      [CommonDefine.BtnType.Normal] = CommonDefine.Z1ButtonState.Normal,
      [CommonDefine.BtnType.High] = CommonDefine.Z1ButtonState.High
    }
    local newState = btnStateMap[state] or CommonDefine.Z1ButtonState.Default
    z1BtnObj.BtnState = newState
  else
    self.binder:SetActive(self.ui.Group_Unclickable, state == CommonDefine.BtnType.Unclickable)
    self.binder:SetActive(self.ui.Group_Normal, state == CommonDefine.BtnType.Normal)
    self.binder:SetActive(self.ui.Group_High, state == CommonDefine.BtnType.High)
  end
end

function BtnTips:OnClick()
  if self.clickFunc then
    self.clickFunc()
  end
end

return BtnTips
