local UIHeroTalentMain = class("UIHeroTalentMain", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local talentShowRes = {
  1901,
  1902,
  1903,
  1900
}
local scaleRange = {0.5, 1}
local defaultScale = Vector3.New(0.87, 0.87, 1)
local UINHeroTalentHeroInfo = require("Game.HeroTalent.UI.UINHeroTalentHeroInfo")
local UINHeroTalentMap = require("Game.HeroTalent.UI.UINHeroTalentMap")
local UINHeroTalentNodeDetail = require("Game.HeroTalent.UI.UINHeroTalentNodeDetail")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_DOTween = CS.DG.Tweening.DOTween
local waitRecorverNUM = 0

function UIHeroTalentMain:OnInit()
  self._heroInfoUI = UINHeroTalentHeroInfo.New()
  self._heroInfoUI:Init(self.ui.heroNode)
  self._mapUI = UINHeroTalentMap.New()
  self._mapUI:Init(self.ui.map)
  self._nodeDetailUI = UINHeroTalentNodeDetail.New()
  self._nodeDetailUI:Init(self.ui.talentDetailNode)
  self._nodeDetailUI:BindLvUpClickCallback(BindCallback(self, self.__OnLvUpClick))
  self._nodeDetailUI:BindBranchCallback(BindCallback(self, self.__OnBranchSelectClick))
  self._mapUI:InitHeroTalentMap(BindCallback(self, self.OnSelectTalentNode), self.ui.talentDetailNode.transform.rect.width, BindCallback(self, self.OnSelectTalentNodeMain), BindCallback(self, self.OnSelectTalentNodeCancle))
  self.__TalentLvListenEvent = BindCallback(self, self.__TalentLvListen)
  MsgCenter:AddListener(eMsgEventId.HeroTalentLvUp, self.__TalentLvListenEvent)
  self.__HeroLvUpListenEvent = BindCallback(self, self.__HeroLvUpListen)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroLvUpListenEvent)
  self.__ItemUpdateEvent = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateEvent)
  self.__OnGesture = BindCallback(self, self.OnGesture)
  CS_LeanTouch.OnGesture("+", self.__OnGesture)
  self._infoFunc = nil
  if 0 < (ConfigData.game_config.heroTalentTipsId or 0) then
    function self._infoFunc()
      local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
      
      GuidePicture.OpenGuidePicture(ConfigData.game_config.heroTalentTipsId, nil, true)
    end
  end
  self._mapUI:SetTouchAreaScale(defaultScale)
  self._materialTable = {}
end

function UIHeroTalentMain:GenCoverJumpReturnCallback()
  local dataTable = {
    closeCallback = self._closeCallback,
    heroData = self._heroInfo
  }
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    waitRecorverNUM = waitRecorverNUM - 1
    self:Show()
    self._closeCallback = dataTable.closeCallback
    self._heroInfo = dataTable.heroData
    self:__Init()
  end
end

function UIHeroTalentMain:InitHeroTalentMain(heroData, closeCallback)
  UIUtil.SetTopStatus(self, self.OnTalentClose, talentShowRes, self._infoFunc)
  self._closeCallback = closeCallback
  self._heroInfo = heroData
  self:__Init()
end

function UIHeroTalentMain:__Init()
  self._talent = self._heroInfo:GetHeroDataTalent()
  self._nodeDetailUI:Hide()
  if self._talent == nil then
    error("talent is NIL")
    return
  end
  local campId = self._heroInfo.career
  local particleColor = self.ui.particleColorArray[campId]
  for _, material in ipairs(self._materialTable) do
    DestroyUnityObject(material)
  end
  table.removeall(self._materialTable)
  for _, particleReder in ipairs(self.ui.particleCampArray) do
    local mat = particleReder:GetMaterial()
    if not IsNull(mat) then
      local newMat = CS.UnityEngine.Object.Instantiate(mat)
      newMat:SetColor("_Color", particleColor)
      particleReder.material = newMat
      table.insert(self._materialTable, newMat)
    end
  end
  local color = self.ui.campColorArray[campId]
  self._mapUI:SetCampColor(color)
  self._mapUI:UpdateHeroTalentMap(self._talent)
  self._heroInfoUI:UpdateHeroTalentHeroInfo(self._heroInfo)
  local careerCfg = self._heroInfo:GetCareerCfg()
  self.ui.img_career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local campCfg = self._heroInfo:GetCampCfg()
  self.ui.img_Camp.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
end

function UIHeroTalentMain:OnSelectTalentNode(talentNode)
  if talentNode == nil then
    return
  end
  self._talentNode = talentNode
  self._nodeDetailUI:Show()
  self._nodeDetailUI:UpdateHeroTalentDetailNode(self._talentNode)
  self._heroInfoUI:SetHeroTalentNode(self._talentNode)
end

function UIHeroTalentMain:OnSelectTalentNodeMain()
  self._talentNode = nil
  self._nodeDetailUI:Hide()
  self._heroInfoUI:ShowHeroTalentAllAddtion(self._talent)
end

function UIHeroTalentMain:OnSelectTalentNodeCancle()
  self._talentNode = nil
  self._nodeDetailUI:Hide()
  self._heroInfoUI:CancleHeroTalentShow()
end

function UIHeroTalentMain:__TalentLvListen(heroId)
  if self._talentNode == nil or self._heroInfo.dataId ~= heroId then
    return
  end
  self._nodeDetailUI:RefreshHeroTalentDetailUI()
  self._heroInfoUI:RefreshHeroTalentHeroInfoUI()
  self._mapUI:LvUpHeroTalentMap(self._heroInfo.dataId, self._talentNode:GetHeroTalentNodeId())
end

function UIHeroTalentMain:__HeroLvUpListen()
  self._heroInfoUI:RefreshHeroTalentHeroInfoUI()
end

function UIHeroTalentMain:__ItemUpdate()
  if self._nodeDetailUI.active then
    self._nodeDetailUI:RefreshHeroTalentDetailUI()
  end
  self._mapUI:UpdateItemTalentMap()
end

function UIHeroTalentMain:OnGesture(fingerList)
  if fingerList.Count ~= 2 then
    return
  end
  local touch1 = fingerList[0]
  local touch2 = fingerList[1]
  local lastDiffX = touch1.LastScreenPosition.x - touch2.LastScreenPosition.x
  local lastDiffY = touch1.LastScreenPosition.y - touch2.LastScreenPosition.y
  local curDiffX = touch1.ScreenPosition.x - touch2.ScreenPosition.x
  local curDiffY = touch1.ScreenPosition.y - touch2.ScreenPosition.y
  local diff = Mathf.Sqrt(Mathf.Pow(curDiffX, 2) + Mathf.Pow(curDiffY, 2)) - Mathf.Sqrt(Mathf.Pow(lastDiffX, 2) + Mathf.Pow(lastDiffY, 2))
  local touchAreaX = self._mapUI:GetTouchAreaScaleX()
  local scale = touchAreaX + diff / 100
  scale = math.clamp(scale, scaleRange[1], scaleRange[2])
  self._mapUI:SetTouchAreaScale(Vector3.New(scale, scale, scale))
end

function UIHeroTalentMain:__OnLvUpClick(nodeData)
  if not nodeData:IsHeroTalentNodeCanLeveUp() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(44))
    return
  end
  local heroId = nodeData:GetHeroTalentNodeHeroId()
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  self._tempPower = heroData:GetFightingPower()
  local heroNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtrl:CS_HERO_TALENT_Upgrade(heroId, nodeData:GetHeroTalentNodeId(), function()
    self:__LvUpEffectShow(heroId, nodeData:GetHeroTalentNodeId())
  end)
end

function UIHeroTalentMain:__LvUpEffectShow(heroId, nodeId)
  self._mapUI:ShowHeroTalentMapLvupEffect(nodeId)
  if self._delayShowPowerTween ~= nil then
    self._delayShowPowerTween:Kill()
    self._delayShowPowerTween = nil
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= self._heroInfo then
    self._tempPower = nil
    return
  end
  local newPower = heroData:GetFightingPower()
  if newPower == self._tempPower then
    self._tempPower = nil
    return
  end
  self._delayShowPowerTween = CS_DOTween.Sequence()
  self._delayShowPowerTween:AppendInterval(0.8)
  self._delayShowPowerTween:AppendCallback(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
      if win == nil then
        return
      end
      win:InitHeroPowerUpSuccess(self._tempPower, newPower)
      self._tempPower = nil
    end)
    self._delayShowPowerTween = nil
  end)
  self._delayShowPowerTween:SetAutoKill(true)
end

function UIHeroTalentMain:__OnBranchSelectClick(branchId)
  if self._talentNode == nil then
    return
  end
  local flag, selectId = self._talentNode:GetHeroTalentNodeBranchId()
  if not flag then
    return
  end
  local heroId = self._talentNode:GetHeroTalentNodeHeroId()
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= self._heroInfo then
    return
  end
  local heroNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetCtrl:CS_HERO_TALENT_CHOICE(heroId, self._talentNode:GetHeroTalentNodeId(), branchId)
end

function UIHeroTalentMain:OnTalentClose()
  if waitRecorverNUM <= 0 then
    self:Delete()
  else
    self:Hide()
  end
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIHeroTalentMain:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroLvUpListenEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroTalentLvUp, self.__TalentLvListenEvent)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemUpdateEvent)
  CS_LeanTouch.OnGesture("-", self.__OnGesture)
  if self._delayShowPowerTween ~= nil then
    self._delayShowPowerTween:Kill()
    self._delayShowPowerTween = nil
  end
  self._mapUI:OnDelete()
  self._nodeDetailUI:OnDelete()
  self._heroInfoUI:OnDelete()
end

function UIHeroTalentMain:OnDeleteEntity()
  base.OnDeleteEntity(self)
  for _, material in ipairs(self._materialTable) do
    DestroyUnityObject(material)
  end
  table.removeall(self._materialTable)
end

return UIHeroTalentMain
