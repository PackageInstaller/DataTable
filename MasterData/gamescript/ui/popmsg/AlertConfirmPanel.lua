local Animator = CS.UnityEngine.Animator
local AlertConfirmPanel, Super = System.NewClass("AlertConfirmPanel", UIBasePanel)
AlertConfirmPanel.uiResCls = UI_Common_Popup_Tip_01Resource

function AlertConfirmPanel:ctor(data, callback)
  Super.ctor(self)
  self.data = data
  self.callback = callback
  local funcs = self.data.funcs
  self.leftBtnFunc = funcs.leftBtnFunc
  self.rightBtnFunc = funcs.rightBtnFunc
  self.isOn = false
  self.execFuncType = nil
  self.playingAnim = false
end

function AlertConfirmPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self.animator = self.ui.Animation:GetComponent(typeof(Animator))
  self:SetAnimEndBehavior()
  local tipConfig = DT.TipsType[self.data.tipTid]
  local btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc)
  local btnRightDesc = LT.Text(tipConfig.RightBtnDesc)
  local btnHighlight = tipConfig.HighLightBtn or 0
  local leftBtnType = 1 == btnHighlight and CommonDefine.BtnType.High or CommonDefine.BtnType.Normal
  local rightBtnType = 2 == btnHighlight and CommonDefine.BtnType.High or CommonDefine.BtnType.Normal
  local showDouble = tipConfig.LeftBtn and tipConfig.RightBtn
  if showDouble then
    binder:BindZ1Button(self.ui.Btn_Text_1, function()
      self:Close()
    end, function()
      return leftBtnType
    end, function()
      return btnLeftDesc
    end)
    binder:BindZ1Button(self.ui.Btn_Text_2, function()
      if self.playingAnim then
        return
      end
      if self.rightBtnFunc then
        self.rightBtnFunc()
        self.rightBtnFunc = nil
      end
      self.execFuncType = tipConfig.RightBtn
      self:CloseAnim()
    end, function()
      return leftBtnType
    end, function()
      return btnLeftDesc
    end)
  else
    local midBtnDesc = ""
    local midBtnFunc
    local midBtnType = 0
    local funcType
    if tipConfig.LeftBtn then
      midBtnDesc = btnLeftDesc
      midBtnFunc = self.leftBtnFunc
      midBtnType = leftBtnType
      funcType = tipConfig.LeftBtn
    elseif tipConfig.RightBtn then
      midBtnDesc = btnRightDesc
      midBtnFunc = self.rightBtnFunc
      midBtnType = rightBtnType
      funcType = tipConfig.RightBtn
    end
    binder:BindZ1Button(self.ui.Btn_Text_3, function()
      if self.playingAnim then
        return
      end
      if midBtnFunc then
        midBtnFunc()
        midBtnFunc = nil
      end
      self.execFuncType = funcType
      self:CloseAnim()
    end, function()
      return midBtnType
    end, function()
      return midBtnDesc
    end)
  end
  binder:SetActive(self.ui.Group_01, showDouble)
  binder:SetActive(self.ui.Group_02, not showDouble)
  binder:SetActive(self.ui.Group_Title, self.data.title ~= nil)
  binder:SetText(self.ui.Text_Title, self.data.title)
  binder:SetText(self.ui.Text_Desc, self.data.desc)
  local showToggle = nil ~= tipConfig.DonotRemind
  binder:SetActive(self.ui.Toggle_Screening, showToggle)
  if showToggle then
    binder:BindToToggleValueChange(self.ui.Toggle_Screening, System.fn(self, self.OnToggle))
  end
  binder:SetActive(self.ui.Text_Bottom_Desc, nil ~= self.data.bottonDesc)
  binder:SetText(self.ui.Text_Bottom_Desc, self.data.bottonDesc)
  self.playingAnim = true
  AnimatorUtils.PlayState(self.animator, "Base Layer.UA_Public_Tip_Level2_Open")
end

function AlertConfirmPanel:SetAnimEndBehavior()
  AnimatorUtils.SetStateEndInBehavior(self.animator, "open", function()
    self.playingAnim = false
  end)
  AnimatorUtils.SetStateEndInBehavior(self.animator, "return", function()
    self:ClosePanel()
  end)
end

function AlertConfirmPanel:OnToggle(isOn)
  self.isOn = isOn
end

function AlertConfirmPanel:CloseAnim()
  self.playingAnim = true
  AnimatorUtils.PlayState(self.animator, "Base Layer.UA_Public_Tip_Level2_Return")
end

function AlertConfirmPanel:Close()
  if self.playingAnim then
    return
  end
  if self.leftBtnFunc then
    self.leftBtnFunc()
    self.leftBtnFunc = nil
  end
  local tipConfig = DT.TipsType[self.data.tipTid]
  self.execFuncType = tipConfig.LeftBtn
  self:CloseAnim()
end

function AlertConfirmPanel:ClosePanel()
  if self.isOn then
    UIPopTipsDataUtils.SetTipDontRemind(self.data.tipTid, self.execFuncType, TimeUtils.GetServerTime())
  end
  Super.Close(self)
end

function AlertConfirmPanel:OnUnbind()
  if self.callback then
    self.callback()
    self.callback = nil
  end
end

return AlertConfirmPanel
