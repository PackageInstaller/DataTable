local StarTowerBookMainCtrl = class("StarTowerBookMainCtrl", BaseCtrl)
StarTowerBookMainCtrl._mapNodeConfig = {
  btnPotential = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Potential"
  },
  btnFateCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FateCard"
  },
  btnEvent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Event"
  },
  btnAffinity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Affinity"
  },
  txtPotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Title"
  },
  txtPotentialDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Desc"
  },
  txtFateCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_FateCard_Title"
  },
  txtFateCardDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_FateCard_Desc"
  },
  txtEvent = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Event_Title"
  },
  txtEventDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Event_Desc"
  },
  txtPosition = {sComponentName = "TMP_Text"},
  txtEntranceDesc = {sComponentName = "TMP_Text"},
  imgPhoto = {sComponentName = "Image"},
  txtAffinity = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Affinity_Title"
  },
  redDotPotential = {},
  redDotFateCard = {},
  redDotEvent = {},
  redDotAffinity = {}
}
StarTowerBookMainCtrl._mapEventConfig = {}
StarTowerBookMainCtrl._mapRedDotConfig = {
  [RedDotDefine.StarTowerBook_Potential] = {
    sNodeName = "redDotPotential"
  },
  [RedDotDefine.StarTowerBook_FateCard] = {
    sNodeName = "redDotFateCard"
  },
  [RedDotDefine.StarTowerBook_Event] = {
    sNodeName = "redDotEvent"
  },
  [RedDotDefine.StarTowerBook_Affinity] = {
    sNodeName = "redDotAffinity"
  }
}

function StarTowerBookMainCtrl:Init()
  self.animRoot:Play("StarTowerBookMain_in")
  local mapEntrance = PlayerData.StarTowerBook:GetRandomEntranceCfg()
  NovaAPI.SetTMPText(self._mapNode.txtPosition, mapEntrance.Position)
  NovaAPI.SetTMPText(self._mapNode.txtEntranceDesc, mapEntrance.Desc)
  if mapEntrance.Icon ~= "" then
    self:SetPngSprite(self._mapNode.imgPhoto, mapEntrance.Icon)
  end
end

function StarTowerBookMainCtrl:BackToMain()
  self.animRoot:Play("StarTowerBookMain_in1")
end

function StarTowerBookMainCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function StarTowerBookMainCtrl:OnEnable()
end

function StarTowerBookMainCtrl:OnDisable()
end

function StarTowerBookMainCtrl:OnDestroy()
end

function StarTowerBookMainCtrl:OnBtnClick_Potential()
  local function callback()
    EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Potential)
  end
  
  PlayerData.StarTowerBook:SendPotentialBriefListMsg(callback)
end

function StarTowerBookMainCtrl:OnBtnClick_FateCard()
  local function callback()
    EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.FateCard)
  end
  
  PlayerData.StarTowerBook:TryGetFateCardBook(callback)
end

function StarTowerBookMainCtrl:OnBtnClick_Event()
  EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Event)
end

function StarTowerBookMainCtrl:OnBtnClick_Affinity()
  EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Affinity)
end

return StarTowerBookMainCtrl
