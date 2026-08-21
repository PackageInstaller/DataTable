_class("UIStageItem", UICustomWidget)
UIStageItem = UIStageItem

function UIStageItem:OnShow()
  self._tgl = self:GetUIComponent("Toggle", "tgl")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  local starsYellow = self:GetUIComponent("UISelectObjectPath", "starsYellow")
  local starsBlue = self:GetUIComponent("UISelectObjectPath", "starsBlue")
  local starsBlueGo = self:GetGameObject("starsBlue")
  starsYellow:SpawnObjects("UIStarItem", 3)
  starsBlue:SpawnObjects("UIStarItem", 3)
  self._starsItemYellow = starsYellow:GetAllSpawnList()
  self._starsItemBlue = starsBlue:GetAllSpawnList()
  self._v = nil
  self._ctrl = nil
  self._idx = 0
  
  function self.OnValueChanged(isOn)
    self._txtName.color = isOn and Color.black or Color.white
    starsBlueGo:SetActive(isOn)
  end
  
  self._tgl.onValueChanged:AddListener(self.OnValueChanged)
end

function UIStageItem:OnHide()
  self._tgl.onValueChanged:RemoveListener(self.OnValueChanged)
  self._tgl = nil
end

function UIStageItem:Init(idx, tglGroup, ctrl)
  self._idx = idx
  self._tgl.group = tglGroup
  self._ctrl = ctrl
end

function UIStageItem:Flush(v)
  self._v = v
  self._txtName.text = self._v.stageIdx .. " " .. self._v.name
  for i, v in ipairs(self._starsItemYellow) do
    v:Flush(i <= self._v.star)
  end
  for i, v in ipairs(self._starsItemBlue) do
    v:Flush(i <= self._v.star)
  end
end

function UIStageItem:Select()
  self._tgl.isOn = true
end

function UIStageItem:tglOnClick(go)
  if self._tgl.isOn then
    self._ctrl:Flush(self._idx)
  end
end
