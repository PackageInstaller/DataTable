local UINSctNewbeeInfo = class("UINSctNewbeeInfo", UIBaseNode)

function UINSctNewbeeInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_STNewbee, self, self.OnSctNewbeeClicked)
end

function UINSctNewbeeInfo:InitSctNewbeeInfo(sectorId, clickFunc)
  self.__clickFunc = clickFunc
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    return
  end
  self.sectorCfg = sectorCfg
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  self.ui.img_Newbee:SetIndex(completeIntro and 1 or 0)
  self.ui.tex_nBeeIsComplete.enabled = completeIntro
  if completeIntro then
    self.ui.tex_Newbee.fontSize = self.ui.size_complete
  end
end

function UINSctNewbeeInfo:OnSctNewbeeClicked()
  if self.__clickFunc ~= nil then
    self.__clickFunc(self.sectorCfg.id)
  end
end

return UINSctNewbeeInfo
