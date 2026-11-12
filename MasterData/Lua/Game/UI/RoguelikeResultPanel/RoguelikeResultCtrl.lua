local RoguelikeResultCtrlEx = class("RoguelikeResultCtrlEx", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
RoguelikeResultCtrlEx._mapNodeConfig = {
  img_TitleComplete = {sComponentName = "GameObject"},
  img_TitleFaild = {sComponentName = "GameObject"},
  Mask = {
    sComponentName = "CanvasGroup"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  imgBlurredBg = {sComponentName = "GameObject"},
  txt_FloorProcess = {sComponentName = "Text"},
  txt_PerkCount = {sComponentName = "Text"},
  ButtonClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txt_RogueLevelName = {sComponentName = "Text"},
  RewardPanel = {sComponentName = "GameObject"},
  uieffectBg = {sComponentName = "GameObject"},
  getPanel = {sComponentName = "GameObject"},
  tempItem = {sComponentName = "GameObject"},
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseReward"
  },
  goBg = {sNodeName = "----BG----"},
  panel_1 = {sComponentName = "GameObject"},
  ItemRoot = {sComponentName = "Transform"},
  img_PerkIcon = {},
  panel_2 = {sComponentName = "GameObject"},
  GetContent = {
    sComponentName = "RectTransform"
  }
}
RoguelikeResultCtrlEx._mapEventConfig = {}

function RoguelikeResultCtrlEx:ShowReward(mapChangeInfo, strength)
  local tbReward = {}
  if type(mapChangeInfo["proto.Res"]) == "table" then
    for _, mapCoin in ipairs(mapChangeInfo["proto.Res"]) do
      table.insert(tbReward, {
        id = mapCoin.Tid,
        Qty = mapCoin.Qty
      })
    end
  end
  if type(mapChangeInfo["proto.Presents"]) == "table" then
    for _, mapInfo in ipairs(mapChangeInfo["proto.Presents"]) do
      table.insert(tbReward, {
        id = mapInfo.Info.Tid,
        Qty = mapInfo.Info.Qty
      })
    end
  end
  if type(mapChangeInfo["proto.Item"]) == "table" then
    for _, mapItem in ipairs(mapChangeInfo["proto.Item"]) do
      table.insert(tbReward, {
        id = mapItem.Tid,
        Qty = mapItem.Qty
      })
    end
  end
  if type(mapChangeInfo["proto.Outfit"]) == "table" then
    for _, mapInfo in ipairs(mapChangeInfo["proto.Outfit"]) do
      table.insert(tbReward, {
        id = mapInfo.Info.Tid,
        Qty = mapInfo.Qty
      })
    end
  end
  if type(mapChangeInfo["proto.Disc"]) == "table" then
    for _, mapInfo in ipairs(mapChangeInfo["proto.Disc"]) do
      table.insert(tbReward, {
        id = mapInfo.Id,
        count = 1
      })
    end
  end
  if strength ~= 0 then
    table.insert(tbReward, 1, {id = 4, Qty = strength})
  end
  if #tbReward == 0 then
    self:OnBtnClick_CloseReward()
    return
  end
  for _, v in ipairs(tbReward) do
    local nItemId = v.id
    local cfgDataItem = ConfigTable.GetData_Item(nItemId)
    local goItem
    if #tbReward <= 6 then
      goItem = instantiate(self._mapNode.tempItem, self._mapNode.ItemRoot)
    else
      goItem = instantiate(self._mapNode.tempItem, self._mapNode.GetContent)
    end
    goItem.name = tostring(nItemId)
    local tr = goItem.transform
    local imgBg = goItem:GetComponent("Image")
    local imgIcon = tr:Find("itemIcon"):GetComponent("Image")
    local txtItemCount = tr:Find("itemCount"):GetComponent("Text")
    self:SetSprite_FrameColor(imgBg, cfgDataItem.Rarity, AllEnum.FrameType_New.ItemS)
    self:SetPngSprite(imgIcon, cfgDataItem.Icon)
    NovaAPI.SetText(txtItemCount, v.Qty)
    goItem:SetActive(true)
    local btnSelect = tr:Find("itemBtn"):GetComponent("Button")
    btnSelect.onClick:RemoveAllListeners()
    
    local function cbSelect()
      self:OnSelectItem(nItemId, imgBg.gameObject:GetComponent("RectTransform"))
    end
    
    btnSelect.onClick:AddListener(cbSelect)
  end
  if #tbReward <= 6 then
    self._mapNode.panel_1:SetActive(true)
  else
    self._mapNode.panel_2:SetActive(true)
  end
  self._mapNode.RewardPanel:SetActive(true)
  self._mapNode.uieffectBg:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.getPanel:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function RoguelikeResultCtrlEx:Awake()
  EventManager.Hit(EventId.AvgBubbleShutDown)
  NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", false)
end

function RoguelikeResultCtrlEx:OnEnable()
  local tbParam = self:GetPanelParam()
  local nResultState = tbParam[1]
  self.mapChangeInfo = tbParam[2]
  self.strength = tbParam[3]
  self.mapBuild = tbParam[4]
  local curFloor = tbParam[5]
  local totalFloor = tbParam[6]
  local perkCount = tbParam[7]
  self.tbBonus = tbParam[8]
  if PlayerData.nCurGameType ~= AllEnum.WorldMapNodeType.Roguelike then
    self._mapNode.goBg:SetActive(true)
    local nFloor = 1
    local mapFloorData = ConfigTable.GetData("RoguelikeFloor", nFloor)
    local nRoguelikeId = mapFloorData.RoguelikeId
    local mapRoguelike = ConfigTable.GetData("Roguelike", nRoguelikeId)
    NovaAPI.SetText(self._mapNode.txt_RogueLevelName, mapRoguelike.Name)
    NovaAPI.SetText(self._mapNode.txt_FloorProcess, string.format("%d/%d", mapFloorData.Floor, totalFloor))
    NovaAPI.SetText(self._mapNode.txt_PerkCount, "?")
    NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", true)
  else
    local nRoguelikeId = PlayerData.Roguelike:GetCurRoguelikeId()
    local mapRoguelike = ConfigTable.GetData("Roguelike", nRoguelikeId)
    NovaAPI.SetText(self._mapNode.txt_RogueLevelName, mapRoguelike.Name)
    NovaAPI.SetText(self._mapNode.txt_FloorProcess, string.format("%d/%d", curFloor, totalFloor))
    NovaAPI.SetText(self._mapNode.txt_PerkCount, tostring(perkCount))
  end
  self._mapNode.imgBlurredBg:SetActive(true)
  local captainID, teamMemberid = PlayerData.Team:GetTeamData(5)
  if nResultState == 1 then
    self._mapNode.img_TitleFaild:SetActive(false)
    self._mapNode.img_TitleComplete:SetActive(true)
    Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, teamMemberid[math.random(1, 3)], nil, true)
    self.gameObject:GetComponent("Animator"):Play("transition_in_complete")
  else
    self._mapNode.img_TitleFaild:SetActive(true)
    self._mapNode.img_TitleComplete:SetActive(false)
    Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, teamMemberid[math.random(1, 3)], nil, false)
    self.gameObject:GetComponent("Animator"):Play("transition_in_faild")
  end
  self._mapNode.Mask.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.AdventureModuleHelper.PauseLogic()
    NovaAPI.SetComponentEnableByName(self.gameObject, "Canvas", true)
  end
  
  cs_coroutine.start(wait)
end

function RoguelikeResultCtrlEx:OnDisable()
  Actor2DManager.UnsetActor2D()
end

function RoguelikeResultCtrlEx:OnDestroy()
end

function RoguelikeResultCtrlEx:OnBtnClick_Close(btn)
  self:ShowReward(self.mapChangeInfo, self.strength)
end

function RoguelikeResultCtrlEx:OnBtnClick_CloseReward(btn)
  CS.AdventureModuleHelper.ResumeLogic()
  if self.mapBuild ~= nil then
    if self.mapBuild.BuildCoin ~= nil and self.mapBuild.BuildCoin > 0 then
      EventManager.Hit(EventId.OpenPanel, PanelId.RoguelikeBuildSave, self.mapBuild.BuildCoin)
      return
    elseif self.mapBuild.Brief ~= nil then
      PlayerData.Build:CacheRogueBuild(self.mapBuild)
      
      local function buildDetailcallback(mapBuild)
        EventManager.Hit(EventId.OpenPanel, PanelId.RoguelikeBuildSave, mapBuild, self.tbBonus)
      end
      
      PlayerData.Build:GetBuildDetailData(buildDetailcallback, self.mapBuild.Brief.BuildId)
      return
    end
  end
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    EventManager.Hit(EventId.CloesCurPanel)
    EventManager.Hit("CloseRoguelikeResultCtrlEx")
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.Mask, 0)
    self._mapNode.Mask.gameObject:SetActive(true)
    local sequence = DOTween.Sequence()
    sequence:Append(self._mapNode.Mask:DOFade(1, 0.5):SetUpdate(true))
    sequence:AppendCallback(function()
      CS.AdventureModuleHelper.LevelStateChanged(true)
      self._mapNode.imgBlurredBg:SetActive(false)
    end)
    sequence:SetUpdate(true)
  end
end

function RoguelikeResultCtrlEx:OnSelectItem(itemId, rtIcon)
  local mapItemCfgData = ConfigTable.GetData_Item(itemId)
  if mapItemCfgData.Stype == GameEnum.itemStype.Outfit then
  else
    if mapItemCfgData.Stype == GameEnum.itemStype.Present then
    else
    end
  end
end

return RoguelikeResultCtrlEx
