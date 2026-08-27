local UINFmtDebuffNode = class("UINFmtDebuffNode", UIBaseNode)
local base = UIBaseNode

function UINFmtDebuffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onCloseSelectUI = BindCallback(self, self.__OnCloseSelectUI)
  self.__onUpdateSelectedDebuff = BindCallback(self, self.__OnUpdateSelectedDebuff)
  UIUtil.AddButtonListener(self.ui.btn_Layer, self, self.OnClickBuffSelect)
end

function UINFmtDebuffNode:RefreshDebuffNode(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  self.ui.enemyPower:SetActive(fmtBuffSelect:IsShowEmenyPowerInFmtBuff())
  local buffIds = fmtBuffSelect:GetFmtBuffSelect()
  self.fmtCtrl:OnFmtCtrlUpdateWCDebuffSelect(buffIds)
  self:RefreshBuffState()
end

function UINFmtDebuffNode:OnClickBuffSelect()
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.PeriodicDebuffSelect, function(window)
    if window ~= nil then
      window:InitDebuffSelect(fmtBuffSelect, self.__onUpdateSelectedDebuff, self.__onCloseSelectUI)
    end
  end)
end

function UINFmtDebuffNode:RefreshBuffState()
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  local permillageAll = fmtBuffSelect:GetFmtBuffCurAddScoreRate()
  self.ui.tex_Gain.text = tostring(math.floor(permillageAll / 10)) .. "%"
  local layer = math.floor(permillageAll / 100)
  layer = 0 < layer and layer or 0
  self.ui.tex_Layer:SetIndex(0, tostring(layer))
  self.ui.tex_EnemyPower.text = tostring(fmtBuffSelect:GetBuffEmenyPower(layer, 1))
end

function UINFmtDebuffNode:__OnUpdateSelectedDebuff(selectedBuffIds)
  self.fmtCtrl:OnFmtCtrlUpdateWCDebuffSelect(selectedBuffIds)
end

function UINFmtDebuffNode:__OnCloseSelectUI()
  self.fmtCtrl:OnFmtCtrlSelectWCDebuffOver()
  self:RefreshBuffState()
end

function UINFmtDebuffNode:OnDelete()
  base.OnDelete(self)
end

return UINFmtDebuffNode
