local TowerDefenseGiveUpCtrl = class("TowerDefenseGiveUpCtrl", BaseCtrl)
TowerDefenseGiveUpCtrl._mapNodeConfig = {}
TowerDefenseGiveUpCtrl._mapEventConfig = {}
TowerDefenseGiveUpCtrl._mapRedDotConfig = {}

function TowerDefenseGiveUpCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.callback = param[1]
  end
end

function TowerDefenseGiveUpCtrl:FadeIn()
end

function TowerDefenseGiveUpCtrl:FadeOut()
end

function TowerDefenseGiveUpCtrl:OnEnable()
end

function TowerDefenseGiveUpCtrl:OnDisable()
  if self.callback ~= nil then
    self.callback()
  end
end

function TowerDefenseGiveUpCtrl:OnDestroy()
end

function TowerDefenseGiveUpCtrl:OnRelease()
end

function TowerDefenseGiveUpCtrl:OnBtnClick_AAA()
end

function TowerDefenseGiveUpCtrl:OnEvent_AAA()
end

return TowerDefenseGiveUpCtrl
