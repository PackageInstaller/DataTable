local UINFmtEnvBuffNode = class("UINFmtEnvBuffNode", UIBaseNode)
local base = UIBaseNode

function UINFmtEnvBuffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onCloseSelectUI = BindCallback(self, self.__OnCloseSelectUI)
  self.__onUpdateSelectedDebuff = BindCallback(self, self.__OnUpdateSelectedDebuff)
  UIUtil.AddButtonListener(self.ui.btn_RoomBuff, self, self.OnClickBuffSelect)
  self._RefreshBlueDotFunc = BindCallback(self, self.RefreshBlueDot)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self._RefreshBlueDotFunc)
end

function UINFmtEnvBuffNode:RefreshEnvBuffNode(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  local buffIds = fmtBuffSelect:GetFmtBuffSelect()
  self.fmtCtrl:OnFmtCtrlUpdateWCDebuffSelect(buffIds or {})
  self:RefreshBuffState()
end

function UINFmtEnvBuffNode:OnClickBuffSelect()
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.PeriodicEnvBuffSelect, function(window)
    if window ~= nil then
      window:InitDebuffSelectNew(fmtBuffSelect, self.__onUpdateSelectedDebuff, self.__onCloseSelectUI)
    end
  end)
end

function UINFmtEnvBuffNode:RefreshBuffState()
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  local permillageAll = fmtBuffSelect:GetFmtBuffCurAddScoreRate()
  permillageAll = permillageAll or 0
  local totalNum = fmtBuffSelect:GetBaseAddRate() + permillageAll
  self.ui.tex_Percent:SetIndex(0, tostring(totalNum))
  local ids = fmtBuffSelect:GetFmtBuffSelect()
  self.ui.tex_Num:SetIndex(0, tostring(#ids), tostring(fmtBuffSelect:GetMaxSelectBuff()))
  self:RefreshBlueDot()
end

function UINFmtEnvBuffNode:RefreshBlueDot()
  local fmtBuffSelect = self.enterFmtData:GetPeridicFmtBuffSelect()
  if fmtBuffSelect == nil then
    return
  end
  local isHaveBlueDot = fmtBuffSelect:GetIsHaveTaskComplete()
  self.ui.blueDot:SetActive(isHaveBlueDot)
end

function UINFmtEnvBuffNode:__OnUpdateSelectedDebuff(selectedBuffIds)
  self.fmtCtrl:OnFmtCtrlUpdateWCDebuffSelect(selectedBuffIds)
end

function UINFmtEnvBuffNode:__OnCloseSelectUI()
  self.fmtCtrl:OnFmtCtrlSelectWCDebuffOver()
  self:RefreshBuffState()
end

function UINFmtEnvBuffNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self._RefreshBlueDotFunc)
  base.OnDelete(self)
end

return UINFmtEnvBuffNode
