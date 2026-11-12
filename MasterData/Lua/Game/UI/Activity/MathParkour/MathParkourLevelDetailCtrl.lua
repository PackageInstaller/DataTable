local MathParkourLevelDetailCtrl = class("MathParkourLevelDetailCtrl", BaseCtrl)
local AssetPath = "UI_Activity/_400018/SpriteAtlas/"
MathParkourLevelDetailCtrl._mapNodeConfig = {
  txt_LevelName = {sComponentName = "TMP_Text"},
  txt_detailDesc = {sComponentName = "TMP_Text"},
  txt_ScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_ScoreTitle"
  },
  txt_MaxScore = {sComponentName = "TMP_Text"},
  txt_Title1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Title1"
  },
  txt_Title2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Title2"
  },
  listReward = {
    sComponentName = "LoopScrollView"
  },
  rtReward1 = {},
  btn_item = {nCount = 4},
  btn_firstPassItem = {sComponentName = "UIButton"},
  firstPassItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btn_threePassItem = {sComponentName = "UIButton"},
  threePassItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btn_Go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MathParkour_Go"
  }
}
MathParkourLevelDetailCtrl._mapEventConfig = {}
MathParkourLevelDetailCtrl._mapRedDotConfig = {}

function MathParkourLevelDetailCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function MathParkourLevelDetailCtrl:OnEnable()
end

function MathParkourLevelDetailCtrl:OnDisable()
end

function MathParkourLevelDetailCtrl:OnDestroy()
  self:Clear()
end

function MathParkourLevelDetailCtrl:Clear()
  if self.tbItemCtrl ~= nil then
    for _, ctrl in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemCtrl = {}
end

function MathParkourLevelDetailCtrl:ShowPanel(nActId, levelData)
  self.nActId = nActId
  self.levelData = levelData
  local config = ConfigTable.GetData("MathParkourLevel", levelData.nId)
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txt_LevelName, config.Title)
  NovaAPI.SetTMPText(self._mapNode.txt_detailDesc, config.Desc)
  NovaAPI.SetTMPText(self._mapNode.txt_MaxScore, levelData.nScore)
  local buffItem = config.DropItemList
  self._mapNode.listReward.gameObject:SetActive(4 < #buffItem)
  self._mapNode.rtReward1.gameObject:SetActive(#buffItem <= 4)
  if 4 < #buffItem then
    self._mapNode.listReward:Init(#buffItem, self, self.OnGridRefresh, self.OnGridBtnClick, false)
  else
    for i = 1, 4 do
      if i <= #buffItem then
        local btn_item = self._mapNode.btn_item[i]
        btn_item.gameObject:SetActive(true)
        local itemId = buffItem[i]
        local buffCfg = ConfigTable.GetData("MathParkourBuffItem", itemId)
        if buffCfg ~= nil then
          local imgIcon = btn_item.transform:Find("AnimRoot/item/AnimRoot/imgIcon"):GetComponent("Image")
          if buffCfg.Icon ~= "" then
            self:SetPngSprite(imgIcon, AssetPath .. buffCfg.Icon)
          end
          local btn = btn_item.gameObject:GetComponent("UIButton")
          btn.onClick:RemoveAllListeners()
          btn.onClick:AddListener(function()
            local msgData = {
              Title = buffCfg.Name,
              Desc = {
                buffCfg.Desc or ""
              }
            }
            EventManager.Hit(EventId.OpenPanel, PanelId.DescTips, btn.transform, msgData)
          end)
        end
      else
        self._mapNode.btn_item[i].gameObject:SetActive(false)
      end
    end
  end
  self._mapNode.btn_firstPassItem.gameObject:SetActive(config.Reward1Id)
  if config.Reward1Id > 0 then
    self._mapNode.firstPassItem:SetItem(config.Reward1Id, nil, config.Reward1Count, false, 0 < levelData.nStar, true)
    self._mapNode.btn_firstPassItem.onClick:RemoveAllListeners()
    self._mapNode.btn_firstPassItem.onClick:AddListener(function()
      UTILS.ClickItemGridWithTips(config.Reward1Id, self._mapNode.btn_firstPassItem.transform, true, true, false)
    end)
  end
  self._mapNode.btn_threePassItem.gameObject:SetActive(config.Reward3Id)
  if 0 < config.Reward3Id then
    self._mapNode.threePassItem:SetItem(config.Reward3Id, nil, config.Reward3Count, false, levelData.nStar >= 3, false, true)
    self._mapNode.btn_threePassItem.onClick:RemoveAllListeners()
    self._mapNode.btn_threePassItem.onClick:AddListener(function()
      UTILS.ClickItemGridWithTips(config.Reward3Id, self._mapNode.btn_threePassItem.transform, true, true, false)
    end)
  end
  self.gameObject:SetActive(true)
  if self.animator ~= nil then
    self.animator:Play("LevelDetailsPanel_in")
  end
end

function MathParkourLevelDetailCtrl:ClosePanel()
  self.gameObject:SetActive(false)
  self:Clear()
end

function MathParkourLevelDetailCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local item = goGrid.transform:Find("btn_itemTemp/AnimRoot/item")
  if not self.tbItemCtrl[nInstanceId] then
    self.tbItemCtrl[nInstanceId] = self:BindCtrlByNode(item, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local config = ConfigTable.GetData("MathParkourLevel", self.levelData.nId)
  if config == nil then
    return
  end
  local itemId = config.DropItemList[nIndex]
  self.tbItemCtrl[nInstanceId]:SetItem(itemId)
end

function MathParkourLevelDetailCtrl:OnGridBtnClick(go, nIndex)
  local nIndex = nIndex + 1
  local config = ConfigTable.GetData("MathParkourLevel", self.levelData.nId)
  if config == nil then
    return
  end
  local itemId = config.DropItemList[nIndex]
  UTILS.ClickItemGridWithTips(itemId, go.transform, true, true, false)
end

function MathParkourLevelDetailCtrl:OnBtnClick_Go()
  local param = {}
  table.insert(param, tostring(self.nActId))
  table.insert(param, tostring(self.levelData.nId))
  table.insert(param, tostring(0))
  CS.MiniGameHelper.SetMiniGameData(param)
  NovaAPI.EnterModule("MathParkourModuleScene", true, 56)
  EventManager.Hit(EventId.OpenPanel, PanelId.MathParkourPanel, self.nActId, self.levelData.nId)
end

return MathParkourLevelDetailCtrl
