local BuildDiscCtrl = class("BuildDiscCtrl", BaseCtrl)
BuildDiscCtrl._mapNodeConfig = {
  goDiscSkill = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Build.BuildDiscSkillCtrl"
  },
  btnDisc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  },
  txtDiscName = {sComponentName = "TMP_Text"},
  imgDiscIcon = {sComponentName = "Image"}
}
BuildDiscCtrl._mapEventConfig = {}

function BuildDiscCtrl:Refresh(tbDisc, nIndex)
end

function BuildDiscCtrl:Awake()
end

function BuildDiscCtrl:OnEnable()
end

function BuildDiscCtrl:OnDisable()
end

function BuildDiscCtrl:OnDestroy()
end

function BuildDiscCtrl:OnRelease()
end

function BuildDiscCtrl:OnBtnClick_Disc(btn)
  local nIdx = 0
  local nDiscId = 0
  local tbAllDisc = {}
  for nId, v in pairs(self.tbDisc) do
    nIdx = nIdx + 1
    if nIdx == self.nIndex then
      nDiscId = nId
    end
    table.insert(tbAllDisc, nId)
  end
  if nDiscId ~= 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.Disc, nDiscId, tbAllDisc)
  end
end

return BuildDiscCtrl
