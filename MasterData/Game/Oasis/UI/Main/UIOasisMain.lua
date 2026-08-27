local UIOasisMain = class("UIOasisMain", UIBaseWindow)
local base = UIBaseWindow
local UINOasisResOutput = require("Game.Oasis.UI.ResOutput.UINOasisResOutput")
local UINOasisBuildSelect = require("Game.Oasis.UI.Select.UINOasisBuildSelect")
local UINOasisBuildDetail = require("Game.Oasis.UI.Detail.UINOasisBuildDetail")
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local UINPaticleNode = require("Game.Oasis.UI.Particle.UINOasisParticle")
local cs_ResLoader = CS.ResLoader
local resourceItems = {
  1003,
  1004,
  3005
}

function UIOasisMain:OnInit()
  self.resLoader = cs_ResLoader.Create()
  self.oasisResNode = UINOasisResOutput.New()
  self.oasisResNode:Init(self.ui.resNode)
  self.oasisSelectNode = UINOasisBuildSelect.New(self)
  self.oasisSelectNode:Init(self.ui.selectNode)
  self.oasisSelectNode:Hide()
  self.buildDetailNode = UINOasisBuildDetail.New(self, self.resLoader)
  self.buildDetailNode:Init(self.ui.detailNode)
  self.buildDetailNode:Hide()
  self.buildPreviewNode = UINBuildLogicLvPreview.New()
  self.buildPreviewNode:Init(self.ui.logicPreviewNode)
  self.buildPreviewNode:Hide()
  self.paticleNode = UINPaticleNode.New(self)
  self.paticleNode:Init(self.ui.particlesNode)
  self.paticleNode:Hide()
  local unlockFactory = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if unlockFactory then
    resourceItems = {
      1003,
      1004,
      3005,
      1201
    }
  end
  UIUtil.SetTopStatus(self, self._BackToHome, resourceItems, nil, nil)
  UIUtil.AddButtonListener(self.ui.btn_SkySetting, self, self._OnClickSkySetting)
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self._OnClickHideUI)
  UIUtil.AddButtonListener(self.ui.btn_Editor, self, self._OnClickEditor)
  UIUtil.AddButtonListener(self.ui.btn_Collect, self, self._OnClickCollectRes)
end

function UIOasisMain:InitOasisMain(oasisCtrl)
  self.oasisCtrl = oasisCtrl
  self.oasisResNode:InitOasisResOutput(oasisCtrl)
  self:RefreshOasisEditRedDot()
  self:_RefreshSkySettingShow(true)
end

function UIOasisMain:OnEnterOasisEditMode(enter)
  self.ui.btn_Editor.gameObject:SetActive(not enter)
  self:_RefreshSkySettingShow(not enter)
  self.ui.btn_HideUI.gameObject:SetActive(not enter)
  self.inEditor = enter
  self:_RefreshCollectResBtn()
  if enter then
    self.oasisResNode:Hide()
  else
    self.oasisResNode:Show()
  end
end

function UIOasisMain:_RefreshSkySettingShow(show)
  local unlockSkySetting = PlayerDataCenter.AllBuildingData.built[eBuildingId.SkyBuilding] ~= nil
  self.ui.btn_SkySetting.gameObject:SetActive(show and unlockSkySetting)
end

function UIOasisMain:RefreshOasisEditRedDot()
  local canBuildNew = false
  for k, dynData in pairs(PlayerDataCenter.AllBuildingData.unbuilt) do
    if dynData.belong == BuildingBelong.Oasis and dynData:CanBuild() then
      canBuildNew = true
      break
    end
  end
  self.ui.obj_RedDot:SetActive(canBuildNew)
end

function UIOasisMain:_OnClickSkySetting()
  self.oasisCtrl:EnterOasisSkyMode()
end

function UIOasisMain:_OnClickHideUI()
  self.oasisCtrl:ShowOasisUI(false)
end

function UIOasisMain:_OnClickEditor()
  self.oasisCtrl:EnterEditMode()
  self:OnEnterOasisEditMode(true)
end

function UIOasisMain:_OnClickCollectRes()
  self.oasisCtrl:CollectAllOasisBuildingRes()
end

function UIOasisMain:ShowOasisMainCollectResBtn(show)
  self.showCollectRes = show
  self:_RefreshCollectResBtn()
end

function UIOasisMain:_RefreshCollectResBtn()
  local show = self.showCollectRes and not self.inEditor
  if self.ui.btn_Collect.gameObject.activeInHierarchy ~= show then
    self.ui.btn_Collect.gameObject:SetActive(show)
  end
end

function UIOasisMain:OnShow()
  base.OnShow(self)
  self.oasisResNode:Show()
end

function UIOasisMain:OnHide()
  self.oasisResNode:Hide()
  base.OnHide(self)
end

function UIOasisMain:_BackToHome()
  self.oasisCtrl:OasisBackToHome()
end

function UIOasisMain:OnDelete()
  self.oasisResNode:Delete()
  self.oasisSelectNode:Delete()
  self.buildDetailNode:Delete()
  self.buildPreviewNode:Delete()
  self.paticleNode:Delete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIOasisMain
