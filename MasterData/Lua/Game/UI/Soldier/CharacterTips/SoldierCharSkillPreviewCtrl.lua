local SoldierCharSkillPreviewCtrl = class("SoldierCharSkillPreviewCtrl", BaseCtrl)
SoldierCharSkillPreviewCtrl._mapNodeConfig = {
  rtToggleStar = {},
  btnLevel = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_BtnLevel"
  },
  imgOn = {nCount = 3},
  imgOff = {nCount = 3},
  ScrollRoot = {
    sComponentName = "LoopScrollView"
  },
  bgClosePanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  grid = {
    sComponentName = "RectTransform"
  }
}
SoldierCharSkillPreviewCtrl._mapEventConfig = {}
SoldierCharSkillPreviewCtrl._mapRedDotConfig = {}

function SoldierCharSkillPreviewCtrl:Awake()
  self._tbItems = {}
  self._nCharId = 0
  self._nCurLevel = 0
  self.mapSkillItemCtrl = {}
  self._nSkillIndex = 2
end

function SoldierCharSkillPreviewCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self._nCharId = tbParam[1]
    self._nSkillIndex = tbParam[2]
  end
  self:SetData()
end

function SoldierCharSkillPreviewCtrl:OnDisable()
end

function SoldierCharSkillPreviewCtrl:OnDestroy()
end

function SoldierCharSkillPreviewCtrl:SetData()
  local bShowToggle = self._nCurLevel == nil or self._nCurLevel == 0
  if bShowToggle then
    self._nCurLevel = 1
  end
  self._mapNode.rtToggleStar.gameObject:SetActive(bShowToggle)
  if bShowToggle then
    self:_RefreshLevelTabUI()
  end
  self:_RefreshSkillList()
end

function SoldierCharSkillPreviewCtrl:Show(bShow)
  if self.gameObject ~= nil and self.gameObject:IsNull() == false then
    self.gameObject:SetActive(bShow == true)
  end
end

function SoldierCharSkillPreviewCtrl:OnBtnClick_BtnLevel(btn, nIdx)
  if type(nIdx) ~= "number" then
    return
  end
  if nIdx < 1 or 3 < nIdx then
    return
  end
  if self._nCurLevel == nIdx then
    return
  end
  self._nCurLevel = nIdx
  self:_RefreshLevelTabUI(nIdx)
  self:_RefreshSkillList(nIdx)
end

function SoldierCharSkillPreviewCtrl:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierCharSkillPreview)
end

function SoldierCharSkillPreviewCtrl:_RefreshLevelTabUI()
  if type(self._mapNode.imgOn) == "table" then
    for i, goImgOn in ipairs(self._mapNode.imgOn) do
      goImgOn.gameObject:SetActive(i == self._nCurLevel)
    end
  end
  if type(self._mapNode.imgOff) == "table" then
    for i, goImgOff in ipairs(self._mapNode.imgOff) do
      goImgOff.gameObject:SetActive(i ~= self._nCurLevel)
    end
  end
end

function SoldierCharSkillPreviewCtrl:_RefreshSkillList()
  if self._nCharId == nil or self._nCharId == 0 then
    return
  end
  self.tbAllSkillIds = {}
  local mapCfg = ConfigTable.GetData("SoldierCharacter", self._nCharId)
  local tbSkillId = {}
  if self._nSkillIndex == 2 then
    tbSkillId = {
      mapCfg.Skill
    }
  else
    tbSkillId = {
      mapCfg.Support
    }
  end
  for nIndex, nSkillId in ipairs(tbSkillId) do
    if nSkillId ~= nil and nSkillId ~= 0 then
      table.insert(self.tbAllSkillIds, {
        nId = nSkillId,
        nIndex = self._nSkillIndex
      })
    end
  end
  self:CalGridHeight()
  self._mapNode.ScrollRoot:InitEx(self.tbAllSkillIdHeight, self, self.OnRefreshSkillItem)
end

function SoldierCharSkillPreviewCtrl:CalGridHeight()
  self.tbAllSkillIdHeight = {}
  for _, skill in ipairs(self.tbAllSkillIds) do
    local nSkillId = skill.nId
    local skillCfg = ConfigTable.GetData("Skill", nSkillId)
    local sDesc = UTILS.ParseDesc(skillCfg, GameEnum.levelTypeData.SoldierLevel, nil, false, self._nCurLevel)
    local txtDesc = self._mapNode.grid.transform:Find("ImgdescBg/txt_desc"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtDesc, sDesc)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.grid)
    local nHeight = self._mapNode.grid.sizeDelta.y
    table.insert(self.tbAllSkillIdHeight, nHeight)
  end
end

function SoldierCharSkillPreviewCtrl:OnRefreshSkillItem(goGrid, gridIndex)
  local index = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapSkillItemCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.CharacterTips.Items.SoldierCharSkillDetailItemCtrl")
    self.mapSkillItemCtrl[nInstanceId] = objCtrl
  end
  objCtrl:SetData(self.tbAllSkillIds[index].nId, self.tbAllSkillIds[index].nIndex, self._nCurLevel, index == #self.tbAllSkillIds)
end

return SoldierCharSkillPreviewCtrl
