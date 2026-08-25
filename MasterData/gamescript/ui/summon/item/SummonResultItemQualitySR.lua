local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonResultItemQualitySR, Super = System.NewComponent("SummonResultItemQualitySR")

function SummonResultItemQualitySR:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Show_SRLogoResource(uiNode)
end

function SummonResultItemQualitySR:OnBind(binder)
  self.binder = binder
end

function SummonResultItemQualitySR:Display(tid, onEndOfAnimation)
  local normalLogo = ""
  local glowLogo = ""
  local itemCfg = DT.Item[tid]
  if itemCfg.Type == CommonDefine.ItemType.Weapon then
    local itemLogo = CommonDefine.SummonItemLogo.Purple
    normalLogo = itemLogo.Normal
    glowLogo = itemLogo.Glow
  elseif itemCfg.Type == CommonDefine.ItemType.AwakerItem then
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(tid)
    local awakerCfg = DT.AwakerConfig[awakerTid]
    local schoolCfg = DT.SchoolConfig[awakerCfg.School]
    local schoolLogo = CommonDefine.SummonSchoolLogo[schoolCfg.NameEn].Purple
    normalLogo = schoolLogo.Normal
    glowLogo = schoolLogo.Glow
  end
  self.binder:SetImage(self.ui.Popup_Show_Logo01, normalLogo)
  self.binder:SetImage(self.ui.glow, glowLogo)
  local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  animController:PlayMultiState("UI_Summon_Popup_Show_SRLogo", function()
    onEndOfAnimation()
  end, 1, false)
end

function SummonResultItemQualitySR:StopDisplay()
  local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  animController:ClearCompleteCb()
  animController:StopPlayableGraph()
end

return SummonResultItemQualitySR
