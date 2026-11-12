local DepotInfoSkillCtrl = class("DepotInfoSkillCtrl", BaseCtrl)
DepotInfoSkillCtrl._mapNodeConfig = {
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_Info_Skill"
  },
  txtSkillName = {sComponentName = "TMP_Text"},
  txtSkillDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  }
}
DepotInfoSkillCtrl._mapEventConfig = {}

function DepotInfoSkillCtrl:Awake()
end

function DepotInfoSkillCtrl:OnEnable()
end

function DepotInfoSkillCtrl:OnDisable()
end

function DepotInfoSkillCtrl:OnDestroy()
end

function DepotInfoSkillCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DepotInfoSkillCtrl
