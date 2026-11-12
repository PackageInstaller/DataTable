local RogueBonusCtrl = class("RogueBonusCtrl", BaseCtrl)
RogueBonusCtrl._mapNodeConfig = {
  Grid = {
    sCtrlName = "Game.UI.BuildPanelEx.PerkBonusItemCtrl",
    nCount = 5
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  text_mergeInfo = {
    sComponentName = "Text",
    sLanguageId = "Bonus_Merge_Hint"
  }
}
RogueBonusCtrl._mapEventConfig = {}

function RogueBonusCtrl:OpenPanel(tbPerkInfo)
  self._mapNode.text_mergeInfo.gameObject:SetActive(false)
  
  local function sort(a, b)
    if a.bOverLimit ~= b.bOverLimit then
      return a.bOverLimit
    end
    if a.nStar + a.nNewStar ~= b.nStar + b.nNewStar then
      return a.nStar + a.nNewStar > b.nStar + b.nNewStar
    end
    return a.nTid > b.nTid
  end
  
  table.sort(tbPerkInfo, sort)
  for i = 1, 5 do
    if i <= #tbPerkInfo then
      if tbPerkInfo[i].bNew and tbPerkInfo[i].nNewStar > 0 then
        self._mapNode.text_mergeInfo.gameObject:SetActive(true)
      end
      self._mapNode.Grid[i].gameObject:SetActive(true)
      self._mapNode.Grid[i]:SetGrid(tbPerkInfo[i])
    else
      self._mapNode.Grid[i].gameObject:SetActive(false)
    end
  end
  self.gameObject:SetActive(true)
end

function RogueBonusCtrl:Awake()
end

function RogueBonusCtrl:OnEnable()
end

function RogueBonusCtrl:OnDisable()
end

function RogueBonusCtrl:OnDestroy()
end

function RogueBonusCtrl:OnRelease()
end

function RogueBonusCtrl:OnBtnClick_Close(btn)
  self.gameObject:SetActive(false)
end

return RogueBonusCtrl
