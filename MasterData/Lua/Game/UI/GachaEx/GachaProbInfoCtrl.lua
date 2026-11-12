local GachaProbInfoCtrl = class("GachaProbInfoCtrl", BaseCtrl)
local cellCount = 6
GachaProbInfoCtrl._mapNodeConfig = {
  txtWindowTitle = {sComponentName = "TMP_Text", sLanguageId = "Gacha_Prob"},
  btnCloseScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtProbInfo = {sComponentName = "Animator"},
  btn_PoolInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenPoolInfo"
  },
  txt_PoolInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_info"
  },
  btn_Left = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PrePage"
  },
  btn_Right = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextPage"
  },
  txt_Page = {sComponentName = "TMP_Text"},
  ProbCell = {nCount = 6},
  title_type = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Type"
  },
  title_rarity = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Rank"
  },
  title_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Name"
  },
  title_prob = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_ProbValue"
  },
  title_poolName = {sComponentName = "TMP_Text"},
  title_poolTime = {sComponentName = "TMP_Text"}
}
GachaProbInfoCtrl._mapEventConfig = {}

function GachaProbInfoCtrl:Awake()
end

function GachaProbInfoCtrl:FadeIn()
end

function GachaProbInfoCtrl:FadeOut()
end

function GachaProbInfoCtrl:OnEnable()
end

function GachaProbInfoCtrl:OnDisable()
end

function GachaProbInfoCtrl:OnDestroy()
end

function GachaProbInfoCtrl:OnRelease()
end

function GachaProbInfoCtrl:InitData()
  self.nCurPage = 1
  self.nTotalPage = 0
  self.upItemList = {}
  self.itemList = {}
end

function GachaProbInfoCtrl:OpenInfo()
  self.gameObject:SetActive(true)
  self._mapNode.rtProbInfo:Play("t_window_04_t_in")
end

function GachaProbInfoCtrl:Refresh(nPoolId)
  self:InitData()
  local upItemList, itemList = PlayerData.Gacha:GetPoolProbDetail(nPoolId)
  self.upItemList = upItemList
  self.itemList = itemList
  self.nTotalPage = math.ceil((#self.upItemList + #self.itemList) / cellCount)
  self:RefreshPage(self.nCurPage)
  local gachaConfig = ConfigTable.GetData("Gacha", nPoolId)
  NovaAPI.SetTMPText(self._mapNode.title_poolName, gachaConfig.Name)
  local bHideTimeText = gachaConfig.StartTime == ""
  self._mapNode.title_poolTime.gameObject:SetActive(not bHideTimeText)
  if bHideTimeText == false then
    local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(gachaConfig.StartTime)
    local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(gachaConfig.EndTime)
    local sStartTime = os.date("%Y-%m-%d %H:%M:%S", nStartTime)
    local sEndTime = os.date("%Y-%m-%d %H:%M:%S", nEndTime)
    local sTime = ConfigTable.GetUIText("Gacha_Prob_Time") .. sStartTime .. "~" .. sEndTime
    NovaAPI.SetTMPText(self._mapNode.title_poolTime, sTime)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_Page, self.nCurPage .. "/" .. self.nTotalPage)
end

function GachaProbInfoCtrl:RefreshPage(nPage)
  local min = (nPage - 1) * cellCount + 1
  local max = nPage * cellCount
  local dataMax = math.min(max, #self.upItemList + #self.itemList)
  local nCellIndex = 1
  for i = min, max do
    if i > dataMax then
      self._mapNode.ProbCell[nCellIndex]:SetActive(false)
      nCellIndex = nCellIndex + 1
    else
      local bIsUp, data
      if i <= #self.upItemList then
        data = self.upItemList[i]
        bIsUp = true
      else
        data = self.itemList[i - #self.upItemList]
        bIsUp = false
      end
      local itemConfig = ConfigTable.GetData_Item(data.nGoodsId)
      local cell = self._mapNode.ProbCell[nCellIndex]
      local txtType = cell.transform:Find("txtType")
      local img_char = cell.transform:Find("img_type_char")
      local img_outfit = cell.transform:Find("img_type_outfit")
      local str
      if itemConfig.Type == GameEnum.itemType.Char then
        str = ConfigTable.GetUIText("ItemStype_3")
      else
        str = ConfigTable.GetUIText("ItemStye_Outfit")
      end
      img_char.gameObject:SetActive(itemConfig.Type == GameEnum.itemType.Char)
      img_outfit.gameObject:SetActive(itemConfig.Type == GameEnum.itemType.Disc)
      NovaAPI.SetTMPText(txtType:GetComponent("TMP_Text"), str)
      local SSR = cell.transform:Find("ssr")
      local SR = cell.transform:Find("sr")
      local R = cell.transform:Find("r")
      SSR.gameObject:SetActive(itemConfig.Rarity == GameEnum.itemRarity.SSR)
      SR.gameObject:SetActive(itemConfig.Rarity == GameEnum.itemRarity.SR)
      R.gameObject:SetActive(itemConfig.Rarity == GameEnum.itemRarity.R)
      local up = cell.transform:Find("up")
      local bg_up = cell.transform:Find("bg_Up")
      up.gameObject:SetActive(bIsUp)
      bg_up.gameObject:SetActive(bIsUp)
      local txt_name = cell.transform:Find("txt_name")
      NovaAPI.SetTMPText(txt_name:GetComponent("TMP_Text"), itemConfig.Title)
      local txt_prob = cell.transform:Find("txt_prob")
      NovaAPI.SetTMPText(txt_prob:GetComponent("TMP_Text"), string.format("%.5f", data.nProbValue) .. "%")
      self._mapNode.ProbCell[nCellIndex]:SetActive(true)
      local line = cell.transform:Find("img_line")
      if dataMax < i + 1 then
        line.gameObject:SetActive(false)
      else
        line.gameObject:SetActive(true)
      end
      nCellIndex = nCellIndex + 1
    end
  end
  self._mapNode.btn_Left.gameObject:SetActive(1 < self.nCurPage)
  self._mapNode.btn_Right.gameObject:SetActive(self.nCurPage < self.nTotalPage)
end

function GachaProbInfoCtrl:OnBtnClick_Close()
  local function Close()
    self.gameObject:SetActive(false)
  end
  
  self._mapNode.rtProbInfo:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, Close, true, true, true)
end

function GachaProbInfoCtrl:OnBtnClick_OpenPoolInfo()
  EventManager.Hit("GachaOpenPoolInfo")
end

function GachaProbInfoCtrl:OnBtnClick_PrePage()
  if self.nCurPage > 1 then
    self.nCurPage = self.nCurPage - 1
    self:RefreshPage(self.nCurPage)
    self._mapNode.btn_Left.gameObject:SetActive(self.nCurPage > 1)
    self._mapNode.btn_Right.gameObject:SetActive(self.nCurPage < self.nTotalPage)
    NovaAPI.SetTMPText(self._mapNode.txt_Page, self.nCurPage .. "/" .. self.nTotalPage)
  end
end

function GachaProbInfoCtrl:OnBtnClick_NextPage()
  if self.nCurPage < self.nTotalPage then
    self.nCurPage = self.nCurPage + 1
    self:RefreshPage(self.nCurPage)
    self._mapNode.btn_Left.gameObject:SetActive(self.nCurPage > 1)
    self._mapNode.btn_Right.gameObject:SetActive(self.nCurPage < self.nTotalPage)
    NovaAPI.SetTMPText(self._mapNode.txt_Page, self.nCurPage .. "/" .. self.nTotalPage)
  end
end

return GachaProbInfoCtrl
