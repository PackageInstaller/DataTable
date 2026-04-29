_class("UIActivityN29DetectivePieceTab", UICustomWidget)
UIActivityN29DetectivePieceTab = UIActivityN29DetectivePieceTab

function UIActivityN29DetectivePieceTab:OnShow(uiParams)
  self:_GetComponent()
end

function UIActivityN29DetectivePieceTab:_GetComponent()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._tabObj = self:GetGameObject("tab")
  self._emptyObj = self:GetGameObject("Empty")
  self._anim = self:GetUIComponent("Animation", "tab")
end

function UIActivityN29DetectivePieceTab:SetData(data)
  self._info = data
  self:InitContent()
end

function UIActivityN29DetectivePieceTab:InitContent()
  local list = self._info.fragment_list
  if #list == 0 then
    self._emptyObj:SetActive(true)
  else
    self._emptyObj:SetActive(false)
    self._widgets = self._content:SpawnObjects("UIActivityN29DetectivePieceItem", #list)
    for i, v in pairs(list) do
      local widget = self._widgets[i]
      local cfg = Cfg.cfg_component_detective_item[v]
      widget:SetData(cfg, i)
    end
  end
end

function UIActivityN29DetectivePieceTab:SetActive(isActive)
  self:StartTask(self._ActiveAnim, self, isActive)
end

function UIActivityN29DetectivePieceTab:_ActiveAnim(TT, isActive)
  if isActive then
    self._tabObj:SetActive(true)
  else
    self._anim:Play("uieff_UIN29DetectivePieceTab_out")
    YIELD(TT, 200)
    self._tabObj:SetActive(false)
  end
end

function UIActivityN29DetectivePieceTab:CloseBtnOnClick()
  self._anim:Play("uieff_UIN29DetectivePieceTab_out")
  local controller = GameGlobal.UIStateManager():GetController("UIActivityN29DetectiveBagController")
  if controller then
    controller:Close()
  else
    Log.fatal("不存在UIActivityN29DetectiveBagController，请检查！！！")
  end
end
