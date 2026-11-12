local MiningGameGuideCtrl = class("MiningGameGuideCtrl", BaseCtrl)
MiningGameGuideCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  txt_titleSSR = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_ItemType_SSR"
  },
  txt_titleSR = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_ItemType_SR"
  },
  ContentSSR = {
    sComponentName = "RectTransform"
  },
  ContentSR = {
    sComponentName = "RectTransform"
  },
  iconTra = {
    sNodeName = "img_icon",
    sComponentName = "RectTransform"
  },
  img_icon = {sComponentName = "Image"},
  txt_score = {sComponentName = "TMP_Text"},
  txt_name = {sComponentName = "TMP_Text"},
  txt_des = {sComponentName = "TMP_Text"},
  animator = {
    sNodeName = "-----Right-----",
    sComponentName = "Animator"
  }
}
MiningGameGuideCtrl._mapEventConfig = {
  MiningGame_SelectedCard = "OnEvent_SelectedCard"
}
MiningGameGuideCtrl._mapRedDotConfig = {}

function MiningGameGuideCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.miningData = PlayerData.Activity:GetActivityDataById(self.nActId)
  local idList = self.miningData:GetDicGroupId()
  self.cardPrefabPath = string.format("UI_Activity/_%s/CardCell.prefab", self.nActId)
  self.CardCtrl = {}
  self:InitList(idList)
end

function MiningGameGuideCtrl:OnDestroy()
  self:Unbind()
end

function MiningGameGuideCtrl:InitList(list)
  local firstId = 0
  for _, id in ipairs(list) do
    local go
    local config = ConfigTable.GetData("MiningTreasure", id)
    if config ~= nil then
      if config.MiningItemRarity == GameEnum.miningRewardRarity.miningSSR then
        go = self:CreatePrefabInstance(self.cardPrefabPath, self._mapNode.ContentSSR)
        if firstId == 0 then
          firstId = config.Id
        end
      elseif config.MiningItemRarity == GameEnum.miningRewardRarity.miningSR then
        go = self:CreatePrefabInstance(self.cardPrefabPath, self._mapNode.ContentSR)
        if firstId == 0 then
          firstId = config.Id
        end
      end
      if go ~= nil then
        go.name = config.Id
        local ctrl = self:BindCtrlByNode(go, "Game.UI.Activity.Mining.MiningGameGuideCardCtrl")
        ctrl:SetData(config.Id)
        table.insert(self.CardCtrl, ctrl)
      end
    end
  end
  if firstId ~= 0 then
    self:OnSelected(firstId)
    EventManager.Hit("MiningGame_SelectedCard", firstId)
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.ContentSSR)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.ContentSR)
end

function MiningGameGuideCtrl:OnSelected(id)
  local config = ConfigTable.GetData("MiningTreasure", id)
  if config == nil then
    return
  end
  if config.Icon ~= "" then
    self:SetPngSprite(self._mapNode.img_icon, config.Icon)
    self._mapNode.iconTra.localRotation = Quaternion.Euler(0, 0, config.SelfRotate)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_score, ConfigTable.GetUIText("MiningGame_Guide_Score") .. config.Score)
  NovaAPI.SetTMPText(self._mapNode.txt_name, config.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_des, config.Des)
  self._mapNode.animator:Play("MiningGameGuidePanel_R_in")
end

function MiningGameGuideCtrl:Unbind()
  for _, ctrl in pairs(self.CardCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
end

function MiningGameGuideCtrl:OnEvent_SelectedCard(id)
  self:OnSelected(id)
end

return MiningGameGuideCtrl
