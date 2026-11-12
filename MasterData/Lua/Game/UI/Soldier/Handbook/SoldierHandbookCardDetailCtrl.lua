local SoldierHandbookCardDetailCtrl = class("SoldierHandbookCardDetailCtrl", BaseCtrl)
local RootPath = "Icon/SoldierBuffCard/"
SoldierHandbookCardDetailCtrl._mapNodeConfig = {
  img_detailIcon = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  txt_desc = {sComponentName = "TMP_Text"},
  go_charListRoot = {},
  txt_charTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Detail_CharTitle"
  },
  btnListChar = {},
  charList = {},
  Btn_ListChar = {nCount = 3},
  tc_char_small = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
  },
  sv_char = {
    sComponentName = "LoopScrollView"
  }
}
SoldierHandbookCardDetailCtrl._mapEventConfig = {}
SoldierHandbookCardDetailCtrl._mapRedDotConfig = {}

function SoldierHandbookCardDetailCtrl:Awake()
  self.mapCharItemCtrl = {}
end

function SoldierHandbookCardDetailCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookCardDetailCtrl:Clear()
  if self.mapCharItemCtrl ~= nil then
    for _, v in ipairs(self.mapCharItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.mapCharItemCtrl = {}
  end
end

function SoldierHandbookCardDetailCtrl:RefreshStarterCardDetail(nStarterCardId)
  if self.animator == nil then
    self.animator = self.gameObject:GetComponent("Animator")
  end
  self.animator:Play("StarterCardDetail_in")
  self.tbCharList = {}
  local starterCardConfig = ConfigTable.GetData("SoldierStarterCard", nStarterCardId)
  if starterCardConfig == nil then
    return
  end
  self:SetPngSprite(self._mapNode.img_detailIcon, RootPath .. starterCardConfig.Icon)
  NovaAPI.SetTMPText(self._mapNode.txt_name, starterCardConfig.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, UTILS.ParseDesc(starterCardConfig))
  self.tbCharList = starterCardConfig.CharacterShow
  self._mapNode.go_charListRoot:SetActive(#self.tbCharList > 0)
  if #self.tbCharList > 0 then
    self._mapNode.charList:SetActive(#self.tbCharList > 3)
    self._mapNode.btnListChar:SetActive(#self.tbCharList <= 3)
    if #self.tbCharList > 3 then
      self._mapNode.sv_char:Init(#self.tbCharList, self, self.OnCharRefreshGrid, self.OnCharGridBtnClick, false)
    else
      for i = 1, 3 do
        local btn_char = self._mapNode.Btn_ListChar[i]
        if i <= #self.tbCharList then
          local btn = self._mapNode.tc_char_small[i].gameObject:GetComponent("UIButton")
          local charId = self.tbCharList[i]
          self._mapNode.tc_char_small[i]:SetItemData(charId)
          self._mapNode.tc_char_small[i]:SetCharLevel(0)
          btn.onClick:RemoveAllListeners()
          btn.onClick:AddListener(function()
            local chessData = {nId = charId, nStar = 1}
            EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.tc_char_small[i].gameObject.transform, chessData)
          end)
        end
        btn_char:SetActive(i <= #self.tbCharList)
      end
    end
  end
end

function SoldierHandbookCardDetailCtrl:RefreshStrategyCardDetail(nStrategyCardId)
  if self.animator == nil then
    self.animator = self.gameObject:GetComponent("Animator")
  end
  self.animator:Play("SoldierHandbookPanelStrategyDetail_in")
  self.tbCharList = {}
  local strategyCardConfig = ConfigTable.GetData("SoldierStrategyCard", nStrategyCardId)
  if strategyCardConfig == nil then
    return
  end
  local imgBg_Gold = self.gameObject.transform:Find("AnimRoot/imgBg_Gold")
  local imgBg_Silver = self.gameObject.transform:Find("AnimRoot/imgBg_Silver")
  local imgBg_Copper = self.gameObject.transform:Find("AnimRoot/imgBg_Copper")
  imgBg_Gold.gameObject:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.R)
  imgBg_Silver.gameObject:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.M)
  imgBg_Copper.gameObject:SetActive(strategyCardConfig.Rarity == GameEnum.itemRarity.N)
  self:SetPngSprite(self._mapNode.img_detailIcon, RootPath .. strategyCardConfig.Icon)
  NovaAPI.SetTMPText(self._mapNode.txt_name, strategyCardConfig.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, strategyCardConfig.Desc)
  self.tbCharList = strategyCardConfig.CharacterShow
  self._mapNode.go_charListRoot:SetActive(#self.tbCharList > 0)
  if #self.tbCharList > 0 then
    self._mapNode.charList:SetActive(#self.tbCharList > 3)
    self._mapNode.btnListChar:SetActive(#self.tbCharList <= 3)
    if #self.tbCharList > 3 then
      self._mapNode.sv_char:Init(#self.tbCharList, self, self.OnCharRefreshGrid, self.OnCharGridBtnClick, false)
    else
      for i = 1, 3 do
        local btn_char = self._mapNode.Btn_ListChar[i]
        if i <= #self.tbCharList then
          local btn = self._mapNode.tc_char_small[i].gameObject:GetComponent("UIButton")
          local charId = self.tbCharList[i]
          self._mapNode.tc_char_small[i]:SetItemData(charId)
          self._mapNode.tc_char_small[i]:SetCharLevel(0)
          btn.onClick:RemoveAllListeners()
          btn.onClick:AddListener(function()
            local chessData = {nId = charId, nStar = 1}
            EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.tc_char_small[i].gameObject.transform, chessData)
          end)
        end
        btn_char:SetActive(i <= #self.tbCharList)
      end
    end
  end
end

function SoldierHandbookCardDetailCtrl:OnCharRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local charId = self.tbCharList[nIndex]
  local go_char = goGrid.transform:Find("tc_char_small")
  local nInstanceId = go_char:GetInstanceID()
  if not self.mapCharItemCtrl[nInstanceId] then
    self.mapCharItemCtrl[nInstanceId] = self:BindCtrlByNode(go_char, "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl")
  end
  self.mapCharItemCtrl[nInstanceId]:SetItemData(charId)
  self.mapCharItemCtrl[nInstanceId]:SetCharLevel(0)
  local btn = go_char.gameObject:GetComponent("UIButton")
  btn.onClick:RemoveAllListeners()
  btn.onClick:AddListener(function()
    local chessData = {nId = charId, nStar = 1}
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, goGrid.transform, chessData)
  end)
end

function SoldierHandbookCardDetailCtrl:OnCharGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local charId = self.tbCharList[nIndex]
  local chessData = {nId = charId, nStar = 1}
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, goGrid.transform, chessData)
end

function SoldierHandbookCardDetailCtrl:OnEvent_AAA()
end

return SoldierHandbookCardDetailCtrl
