local DoubleDropInsItemCtrl = class("DoubleDropInsItemCtrl", BaseCtrl)
DoubleDropInsItemCtrl._mapNodeConfig = {
  imgIconDaily = {},
  imgIconRegionBoss = {},
  imgIconSkill = {},
  imgIconEquipment = {},
  txtTitle = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  goLock = {},
  txtLock = {sComponentName = "TMP_Text"}
}
DoubleDropInsItemCtrl._mapEventConfig = {}
DoubleDropInsItemCtrl._mapRedDotConfig = {}

function DoubleDropInsItemCtrl:InitItem(nFuncType)
  self.nType = nFuncType
  self._mapNode.imgIconDaily:SetActive(nFuncType == GameEnum.OpenFuncType.DailyInstance)
  self._mapNode.imgIconRegionBoss:SetActive(nFuncType == GameEnum.OpenFuncType.RegionBoss)
  self._mapNode.imgIconSkill:SetActive(nFuncType == GameEnum.OpenFuncType.SkillInstance)
  self._mapNode.imgIconEquipment:SetActive(nFuncType == GameEnum.OpenFuncType.CharGemInstance)
  local sDesc = ""
  if nFuncType == GameEnum.OpenFuncType.SkillInstance then
    sDesc = ConfigTable.GetUIText("LevelMenu_SSkill")
  elseif nFuncType == GameEnum.OpenFuncType.RegionBoss then
    sDesc = ConfigTable.GetUIText("LevelMenu_SRegion")
  elseif nFuncType == GameEnum.OpenFuncType.DailyInstance then
    sDesc = ConfigTable.GetUIText("LevelMenu_STime")
  elseif nFuncType == GameEnum.OpenFuncType.CharGemInstance then
    sDesc = ConfigTable.GetUIText("LevelMenu_SEquipment")
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType)
  self._mapNode.goLock:SetActive(not bUnlock)
  local mapFuncCfg = ConfigTable.GetData("OpenFunc", nFuncType)
  if mapFuncCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, mapFuncCfg.Name)
    if not bUnlock and mapFuncCfg.NeedWorldClass > 0 then
      NovaAPI.SetTMPText(self._mapNode.txtLock, orderedFormat(ConfigTable.GetUIText("Double_Drops_WorldClass_Lock"), mapFuncCfg.NeedWorldClass))
    end
  end
end

function DoubleDropInsItemCtrl:Awake()
end

function DoubleDropInsItemCtrl:OnEnable()
end

function DoubleDropInsItemCtrl:OnDisable()
end

function DoubleDropInsItemCtrl:OnDestroy()
end

return DoubleDropInsItemCtrl
