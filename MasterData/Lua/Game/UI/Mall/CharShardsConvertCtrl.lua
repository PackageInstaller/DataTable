local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharShardsConvertCtrl = class("CharShardsConvertCtrl", BaseCtrl)
CharShardsConvertCtrl._mapNodeConfig = {
  got_fullscreen_blur_blue = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  anit_window = {sNodeName = "t_window", sComponentName = "Animator"},
  btnConfirm = {
    sNodeName = "btnConfirm2",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  loopsv = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  imgItem_ = {nCount = 2, sComponentName = "Image"},
  txtItemNum_ = {nCount = 2, sComponentName = "TMP_Text"},
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  Item_ = {nCount = 2, sComponentName = "GameObject"},
  goEmpty = {}
}
CharShardsConvertCtrl._mapEventConfig = {}

function CharShardsConvertCtrl:Awake()
  self.tbAllCharFragmentsList = {}
end

function CharShardsConvertCtrl:OnEnable()
  self._mapNode.got_fullscreen_blur_blue:SetActive(true)
  self._mapNode.anit_window:Play("t_window_04_t_in")
  self.tbGridCtrl = {}
  self:OnRefreshPanel()
end

function CharShardsConvertCtrl:OnRefreshPanel()
  local allChar = PlayerData.Char:GetDataForCharList()
  for k, v in pairs(allChar) do
    local fragmentsCount = PlayerData.Talent:GetOverFragments(v.nId)
    if 0 < fragmentsCount then
      table.insert(self.tbAllCharFragmentsList, {
        v.nId,
        fragmentsCount
      })
    end
  end
  local allFragments = PlayerData.Item:GetCharFragmentsData()
  for k, v in pairs(allFragments) do
    local fragmentsCount = PlayerData.Talent:GetOverFragments(v.nId)
    if 0 < fragmentsCount then
      table.insert(self.tbAllCharFragmentsList, {
        v.nId,
        fragmentsCount
      })
    end
  end
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.loopsv:Init(#self.tbAllCharFragmentsList, self, self.OnRefreshGrid)
  self:OnRefreshConvertItem()
  self._mapNode.goEmpty:SetActive(0 >= #self.tbAllCharFragmentsList)
end

function CharShardsConvertCtrl:OnRefreshConvertItem()
  self.tbConvertItem = {}
  local data = ConfigTable.GetData("CharGrade", GameEnum.characterGrade.SSR)
  if data ~= nil then
    if data.SubstituteItemId1 ~= 0 and self.tbConvertItem[data.SubstituteItemId1] == nil then
      self.tbConvertItem[data.SubstituteItemId1] = 0
    end
    if data.SubstituteItemId2 ~= 0 and self.tbConvertItem[data.SubstituteItemId2] == nil then
      self.tbConvertItem[data.SubstituteItemId2] = 0
    end
  end
  for k, v in ipairs(self.tbAllCharFragmentsList) do
    local mapData = ConfigTable.GetData_Character(v[1])
    if mapData ~= nil then
      local gradeData = ConfigTable.GetData("CharGrade", mapData.Grade)
      if gradeData ~= nil then
        if gradeData.SubstituteItemId1 ~= 0 then
          if self.tbConvertItem[gradeData.SubstituteItemId1] == nil then
            self.tbConvertItem[gradeData.SubstituteItemId1] = 0
          end
          self.tbConvertItem[gradeData.SubstituteItemId1] = self.tbConvertItem[gradeData.SubstituteItemId1] + gradeData.SubstituteItemQty1 * v[2]
        end
        if gradeData.SubstituteItemId2 ~= 0 then
          if self.tbConvertItem[gradeData.SubstituteItemId2] == nil then
            self.tbConvertItem[gradeData.SubstituteItemId2] = 0
          end
          self.tbConvertItem[gradeData.SubstituteItemId2] = self.tbConvertItem[gradeData.SubstituteItemId2] + gradeData.SubstituteItemQty2 * v[2]
        end
      end
    end
  end
  local index = 1
  for k, v in pairs(self.tbConvertItem) do
    self._mapNode.Item_[index]:SetActive(true)
    self:SetPngSprite(self._mapNode.imgItem_[index], ConfigTable.GetData_Item(k).Icon)
    NovaAPI.SetTMPText(self._mapNode.txtItemNum_[index], v)
    index = index + 1
  end
end

function CharShardsConvertCtrl:OnRefreshGrid(go)
  local index = tonumber(go.name) + 1
  local nInstanceId = go:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(go, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local mapData = ConfigTable.GetData_Character(self.tbAllCharFragmentsList[index][1])
  if mapData ~= nil then
    self.tbGridCtrl[nInstanceId]:SetItem(mapData.FragmentsId, nil, self.tbAllCharFragmentsList[index][2])
  end
end

function CharShardsConvertCtrl:OnPanelClose()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  EventManager.Hit(EventId.ClosePanel, PanelId.CharShardsConvert)
end

function CharShardsConvertCtrl:OnBtnClick_Close()
  self._mapNode.anit_window:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true)
end

function CharShardsConvertCtrl:OnBtnClick_Confirm()
  if #self.tbAllCharFragmentsList <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CharShard_Not_Enough"))
    return
  end
  
  local function callBack(_, mapChangeInfo)
    UTILS.OpenReceiveByChangeInfo(mapChangeInfo)
    self:OnPanelClose()
  end
  
  PlayerData.Mall:SendCharFragmentConvertReq(callBack)
end

return CharShardsConvertCtrl
