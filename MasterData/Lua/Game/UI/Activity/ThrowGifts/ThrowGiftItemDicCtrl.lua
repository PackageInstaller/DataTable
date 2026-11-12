local ThrowGiftItemDicCtrl = class("ThrowGiftItemDicCtrl", BaseCtrl)
ThrowGiftItemDicCtrl._mapNodeConfig = {
  btnItemCtrl = {
    sNodeName = "btnItem",
    nCount = 8,
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftItemDicGridCtrl"
  },
  btnItem = {
    sComponentName = "UIButton",
    nCount = 8,
    callback = "OnBtnClick_Item"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnShortcutBg = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_CloseDesc"
  },
  txtTips2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  rtCardInfo = {},
  rtCardInfoAnim = {sNodeName = "rtCardInfo", sComponentName = "Animator"},
  AnimRootItemInfo = {sComponentName = "Animator"},
  imgItemIconInfo = {sComponentName = "Image"},
  TMPItemNameInfo = {sComponentName = "TMP_Text"},
  TMPItemDescInfo = {sComponentName = "TMP_Text"},
  btnRight = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Right"
  },
  btnLeft = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Left"
  }
}
ThrowGiftItemDicCtrl._mapEventConfig = {}
ThrowGiftItemDicCtrl._mapRedDotConfig = {}

function ThrowGiftItemDicCtrl:Awake()
end

function ThrowGiftItemDicCtrl:FadeIn()
end

function ThrowGiftItemDicCtrl:FadeOut()
end

function ThrowGiftItemDicCtrl:OnEnable()
  self.nActivityId = 0
  self.nPage = 1
  self.nTotalPage = 1
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActivityId = param[1]
  end
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActivityId)
  self.mapRecordItemData = {}
  if self.actData ~= nil then
    local mapCachedData = self.actData:GetActivityData()
    self.mapRecordItemData = mapCachedData.mapItems
  end
  self.tbItem = {}
  
  local function forEachItem(mapData)
    table.insert(self.tbItem, mapData)
  end
  
  ForEachTableLine(DataTable.ThrowGiftItem, forEachItem)
  
  local function sort(a, b)
    return a.Id < b.Id
  end
  
  table.sort(self.tbItem, sort)
  if 0 < #self.tbItem then
    self.nTotalPage = math.ceil(#self.tbItem / 8)
  end
  if 1 >= self.nTotalPage then
    self._mapNode.btnRight.gameObject:SetActive(false)
    self._mapNode.btnLeft.gameObject:SetActive(false)
  else
    self._mapNode.btnRight.gameObject:SetActive(true)
    self._mapNode.btnLeft.gameObject:SetActive(true)
  end
end

function ThrowGiftItemDicCtrl:RefreshPanel()
end

function ThrowGiftItemDicCtrl:OnDisable()
end

function ThrowGiftItemDicCtrl:OnDestroy()
end

function ThrowGiftItemDicCtrl:OnRelease()
end

function ThrowGiftItemDicCtrl:OpenPanel()
  self.gameObject:SetActive(true)
  self:RefreshItems(self.nPage)
end

function ThrowGiftItemDicCtrl:RefreshItems(nPage)
  self.nPage = nPage
  for i = 1, 8 do
    local nItemIdx = i + (self.nPage - 1) * 8
    if self.tbItem[nItemIdx] ~= nil then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.btnItemCtrl[i]:SetItem(self.tbItem[nItemIdx].Id, self.mapRecordItemData[self.tbItem[nItemIdx].Id] ~= nil and self.mapRecordItemData[self.tbItem[nItemIdx].Id] > 0)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function ThrowGiftItemDicCtrl:OnBtnClick_Item(btn, nIdx)
  local nIdx = nIdx + (self.nPage - 1) * 8
  local mapConfig = self.tbItem[nIdx]
  if mapConfig == nil then
    return
  end
  if self.mapRecordItemData[mapConfig.Id] ~= nil and self.mapRecordItemData[mapConfig.Id] > 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPItemNameInfo, mapConfig.Name)
    NovaAPI.SetTMPText(self._mapNode.TMPItemDescInfo, mapConfig.Desc)
    self:SetPngSprite(self._mapNode.imgItemIconInfo, mapConfig.Icon)
    self._mapNode.rtCardInfo:SetActive(true)
  end
end

function ThrowGiftItemDicCtrl:OnBtnClick_CloseDesc(btn)
  self._mapNode.rtCardInfoAnim:Play("rtCardInfo_out")
  
  local function wait()
    self._mapNode.rtCardInfo:SetActive(false)
  end
  
  self:AddTimer(1, 0.2, wait, true, true, true)
end

function ThrowGiftItemDicCtrl:OnBtnClick_Close(btn)
  self._mapNode.AnimRootItemInfo:Play("rtItemInfo_out")
  
  local function wait()
    self.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.2, wait, true, true, true)
end

function ThrowGiftItemDicCtrl:OnBtnClick_Right(btn)
  local nPage = self.nPage + 1
  if nPage > self.nTotalPage then
    nPage = 1
  end
  self:RefreshItems(nPage)
end

function ThrowGiftItemDicCtrl:OnBtnClick_Left(btn)
  local nPage = self.nPage - 1
  if nPage < 1 then
    nPage = self.nTotalPage
  end
  self:RefreshItems(nPage)
end

return ThrowGiftItemDicCtrl
