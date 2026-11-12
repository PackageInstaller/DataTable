local DepotDiscMainSkillItemCtrl = class("DepotDiscMainSkillItemCtrl", BaseCtrl)
DepotDiscMainSkillItemCtrl._mapNodeConfig = {
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgRareBg = {sComponentName = "Image"},
  imgIconBg = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  goStar = {sComponentName = "Image"},
  txtDiscSkillName = {sComponentName = "TMP_Text"},
  imgChoose = {}
}
DepotDiscMainSkillItemCtrl._mapEventConfig = {
  SelectDepotDiscSkill = "OnEvent_SelectDepotDiscSkill"
}
DepotDiscMainSkillItemCtrl._mapRedDotConfig = {}

function DepotDiscMainSkillItemCtrl:Refresh(nSkillId, nRarity, nDiscId, nStar)
  self.nSkillId = nSkillId
  self.nDiscId = nDiscId
  local mainSkillCfg = ConfigTable.GetData("MainSkill", nSkillId)
  if mainSkillCfg == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgIconBg, mainSkillCfg.IconBg)
  self:SetPngSprite(self._mapNode.imgIcon, mainSkillCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtDiscSkillName, mainSkillCfg.Name)
  self:SetAtlasSprite(self._mapNode.imgRareBg, "12_rare", AllEnum.FrameType_New.HarmonySkillS .. AllEnum.FrameColor_New[nRarity])
  self:SetAtlasSprite(self._mapNode.goStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[nRarity] .. "_0" .. nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.goStar)
end

function DepotDiscMainSkillItemCtrl:OnBtnClick_Item()
  EventManager.Hit("SelectDepotDiscSkill", self.nDiscId, self.nSkillId)
end

function DepotDiscMainSkillItemCtrl:OnEvent_SelectDepotDiscSkill(nDiscId, nMainSkillId, nSubSkillId, _)
  self._mapNode.imgChoose:SetActive(self.nSkillId and self.nSkillId == nMainSkillId)
end

return DepotDiscMainSkillItemCtrl
