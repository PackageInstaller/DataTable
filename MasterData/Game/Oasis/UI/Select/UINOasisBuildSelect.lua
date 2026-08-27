local UINOasisBuildSelect = class("UINOasisBuildSelect", UIBaseNode)
local base = UIBaseNode

function UINOasisBuildSelect:ctor(oasisMain)
  self.oasisMain = oasisMain
end

function UINOasisBuildSelect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Information, self, self._OnClickInfo)
  UIUtil.AddButtonListener(self.ui.btn_LevelUp, self, self._OnClickLevelUp)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancel)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self._OnClickJump)
  self._defaltJumpBtnPos = self.ui.btn_Jump.transform.anchoredPosition
end

function UINOasisBuildSelect:InitOasisBuildSelect(buildingData, buildingItem, dontShowBtn, isInfo)
  self.buildingData = buildingData
  self.buildingItem = buildingItem
  self.ui.img_Icon.sprite = CRH:GetSprite(buildingData.dynData.stcData.small_icon)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.name)
  self.ui.tex_EnName.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.name_en)
  self:RefreshOasisSelectState()
  if dontShowBtn then
    self.ui.select.gameObject:SetActive(false)
    self.ui.editor.gameObject:SetActive(false)
  else
    self.ui.select.gameObject:SetActive(isInfo)
    self.ui.editor.gameObject:SetActive(not isInfo)
  end
  self:Show()
  self:RefreshOasisSelectPos()
  self.ui.showTween:DORestart()
end

function UINOasisBuildSelect:SetOasisBuildSelectFunc(confirmFunc, cancelFunc)
  self._confirmFunc = confirmFunc
  self._cancelFunc = cancelFunc
end

function UINOasisBuildSelect:RefreshOasisSelectState()
  local buildingData = self.buildingData
  self.ui.tex_Level.text = tostring(buildingData.level or 1)
  if buildingData.isBuild then
    local isMaxLv = buildingData:IsMaxLevel()
    self.ui.btn_LevelUp.gameObject:SetActive(not isMaxLv)
    local showJump = false
    if buildingData.id == eBuildingId.OasisFactory and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory) then
      showJump = true
    elseif buildingData.id == eBuildingId.SkyBuilding then
      showJump = true
    end
    self.ui.btn_Jump.gameObject:SetActive(showJump)
    if showJump then
      self.ui.layout_btn_Jump.ignoreLayout = not isMaxLv
      if not isMaxLv then
        self.ui.btn_Jump.transform.anchoredPosition = self._defaltJumpBtnPos
      end
    end
  end
end

function UINOasisBuildSelect:RefreshOasisSelectPos()
  if self.active and not IsNull(self.buildingItem) then
    local anchorPos = UIManager:World2UIPosition(self.buildingItem:GetBuildSelectUIPos())
    self.transform.anchoredPosition = anchorPos
  end
end

function UINOasisBuildSelect:_OnClickInfo()
  self.oasisMain.buildDetailNode:InitOasisBuildDetail(self.buildingData, true)
end

function UINOasisBuildSelect:_OnClickLevelUp()
  self.oasisMain.buildDetailNode:InitOasisBuildDetail(self.buildingData, false)
end

function UINOasisBuildSelect:_OnClickCancel()
  if self._cancelFunc ~= nil then
    self._cancelFunc()
  end
end

function UINOasisBuildSelect:_OnClickJump()
  if self.buildingData.id == eBuildingId.OasisFactory then
    ControllerManager:GetController(ControllerTypeId.Factory, true):OpenFactory()
  elseif self.buildingData.id == eBuildingId.SkyBuilding then
    self.oasisMain.oasisCtrl:EnterOasisSkyMode()
  end
end

function UINOasisBuildSelect:_OnClickConfirm()
  if self._confirmFunc ~= nil then
    self._confirmFunc()
  end
end

function UINOasisBuildSelect:EnableBuildConfirmBtn(enable)
  self.ui.img_Confirm:SetIndex(enable and 1 or 0)
end

function UINOasisBuildSelect:OnHide()
  self.buildingItem = nil
end

function UINOasisBuildSelect:OnDelete()
  base.OnDelete(self)
end

return UINOasisBuildSelect
