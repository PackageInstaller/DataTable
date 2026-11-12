local BoardPlotCtrl = class("BoardPlotCtrl", BaseCtrl)
local PlayerHandbookData = PlayerData.Handbook
local PlayerBoardData = PlayerData.Board
local LimitWidth = 270
BoardPlotCtrl._mapNodeConfig = {
  imgChose = {},
  imgChoseMask = {},
  imgAnimMask = {},
  imgItemIcon = {sComponentName = "Image"},
  imgItemRare = {sComponentName = "Image"},
  imgChoseBg = {},
  imgSelectIndex = {sComponentName = "Image"},
  txtSelected = {
    sComponentName = "TMP_Text",
    sLanguageId = "HomePage_Selected"
  },
  goAnim = {},
  txtName = {sComponentName = "TMP_Text"},
  hintHorLayout = {
    sNodeName = "goName",
    sComponentName = "HorizontalLayoutGroup"
  },
  layoutElement = {
    sNodeName = "goName",
    sComponentName = "LayoutElement"
  },
  goName = {
    sComponentName = "RectTransform"
  }
}

function BoardPlotCtrl:RefreshItemData(bShowFavorite)
  self._mapNode.goAnim.gameObject:SetActive(false)
  self._mapNode.txtName.gameObject:SetActive(false)
  local handbookData = PlayerHandbookData:GetHandbookDataById(self.nId)
  local plotCfgData = handbookData:GetPlotCfgData()
  local scrollerCS = self._mapNode.txtName.gameObject:GetComponent("TextScroll")
  if nil ~= plotCfgData then
    local tbResourcePath = PlayerData.Handbook:GetPlotResourcePath(self.nId)
    self:SetPngSprite(self._mapNode.imgItemIcon, tbResourcePath.ListImg)
    self:SetHintLayout(true)
    self._mapNode.txtName.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtName, plotCfgData.Name)
    local rectTra = self._mapNode.txtName.gameObject:GetComponent("RectTransform")
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rectTra)
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goName)
      local width = rectTra.sizeDelta.x
      if width >= LimitWidth then
        self:SetHintLayout(false)
        scrollerCS:StartScroll(self._mapNode.txtName)
      else
        self:SetHintLayout(true)
        scrollerCS:StopScroll()
      end
    end
    
    cs_coroutine.start(wait)
  else
    scrollerCS:StopScroll()
  end
end

function BoardPlotCtrl:SetItemData(itemData)
  local nMaxCount = PlayerBoardData:GetMaxSelectCount()
  self.nId = itemData.data:GetId()
  self:RefreshItemData(true)
  local nSelect = itemData.nSelect > 0 and nMaxCount - itemData.nSelect + 1 or 0
  self:SetSelect(nSelect)
end

function BoardPlotCtrl:SetItemSortData(nId, nIndex)
  self.nId = nId
  self:RefreshItemData(false)
  self._mapNode.imgChose.gameObject:SetActive(false)
  self._mapNode.imgChoseMask.gameObject:SetActive(false)
  self._mapNode.imgChoseBg.gameObject:SetActive(false)
  self._mapNode.imgAnimMask.gameObject:SetActive(false)
end

function BoardPlotCtrl:SetSelect(nSelectIdx)
  self.bSelect = nil ~= nSelectIdx and 0 < nSelectIdx
  self._mapNode.imgChose.gameObject:SetActive(self.bSelect)
  self._mapNode.imgChoseMask.gameObject:SetActive(self.bSelect)
  self._mapNode.imgChoseBg.gameObject:SetActive(self.bSelect)
  self._mapNode.imgAnimMask.gameObject:SetActive(self.bSelect)
  if self.bSelect then
    self:SetAtlasSprite(self._mapNode.imgSelectIndex, "11_ico", "zs_team_select_" .. nSelectIdx)
  end
end

function BoardPlotCtrl:CheckSelect(tbSelected)
  local nSelectIdx
  for k, v in ipairs(tbSelected) do
    if v == self.nId then
      nSelectIdx = k
      break
    end
  end
  self:SetSelect(nSelectIdx)
end

function BoardPlotCtrl:SetHintLayout(bEnabled)
  self._mapNode.hintHorLayout.enabled = bEnabled
  self._mapNode.layoutElement.enabled = not bEnabled
end

return BoardPlotCtrl
