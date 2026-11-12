local ReengagementBDPreviewCtrl = class("ReengagementBDPreviewCtrl", BaseCtrl)
ReengagementBDPreviewCtrl._mapNodeConfig = {
  window = {},
  animRoot = {sNodeName = "window", sComponentName = "Animator"},
  goBlur = {},
  btnShortcutClose = {sComponentName = "NaviButton", callback = "ClosePanel"},
  btnClose = {sComponentName = "UIButton", callback = "ClosePanel"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrialPreview_Title"
  },
  txtLevelInterval = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrialPreview_LevelInterval"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_BDTrialPreview_Tip"
  },
  txtCurLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_TitleCurLevel"
  },
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_WorldClass_Level"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  imgExpBar = {sComponentName = "Image"},
  svAll = {
    sComponentName = "LoopScrollView"
  }
}
ReengagementBDPreviewCtrl._mapEventConfig = {}

function ReengagementBDPreviewCtrl:OpenPanel()
  self.gameObject:SetActive(true)
  self._mapNode.window:SetActive(false)
  
  local function wait()
    self._mapNode.goBlur:SetActive(true)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.window:SetActive(true)
    self._mapNode.btnShortcutClose.gameObject:SetActive(true)
    self:InitPanel()
    self._mapNode.animRoot:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
end

function ReengagementBDPreviewCtrl:InitPanel()
  self.tbLevelInterval = {}
  
  local function foreachData(mapData)
    table.insert(self.tbLevelInterval, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeTrialBuildGroup"), foreachData)
  table.sort(self.tbLevelInterval, function(a, b)
    return a.LevelMin < b.LevelMin
  end)
  self.nWorldLevel = PlayerData.Base:GetWorldClass()
  NovaAPI.SetTMPText(self._mapNode.txtLevel, self.nWorldLevel)
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", self.nWorldLevel + 1, true)
  local nFullExp = 0
  if mapCfg ~= nil then
    nFullExp = mapCfg.Exp
    NovaAPI.SetImageFillAmount(self._mapNode.imgExpBar, nCurExp / nFullExp)
  end
  self._mapNode.svAll:Init(#self.tbLevelInterval, self, self.OnGridRefresh)
end

function ReengagementBDPreviewCtrl:OnGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local mapData = self.tbLevelInterval[nIndex]
  local imgOnBg = goGrid.transform:Find("imgOnBg").gameObject
  local imgOffBg = goGrid.transform:Find("imgOffBg").gameObject
  local imgSelect = goGrid.transform:Find("imgSelect").gameObject
  if self.nWorldLevel >= mapData.LevelMin and (mapData.LevelMax == -1 or self.nWorldLevel <= mapData.LevelMax) then
    imgOnBg:SetActive(true)
    imgOffBg:SetActive(false)
    imgSelect:SetActive(true)
  else
    imgOnBg:SetActive(false)
    imgOffBg:SetActive(true)
    imgSelect:SetActive(false)
  end
  local txtDesc = goGrid.transform:Find("txtDesc"):GetComponent("TMP_Text")
  if txtDesc ~= nil then
    local nLevelMin = math.max(1, mapData.LevelMin)
    local nLevelMax = PlayerData.Base:GetMaxWorldClass()
    if mapData.LevelMax ~= -1 then
      nLevelMax = math.min(nLevelMax, mapData.LevelMax)
    end
    local sText = ConfigTable.GetUIText("Reengagement_BDTrialPreview_WorldClass")
    sText = sText .. nLevelMin .. "~" .. nLevelMax
    NovaAPI.SetTMPText(txtDesc, sText)
  end
  local imgIcon = goGrid.transform:Find("imgIcon"):GetComponent("Image")
  if imgIcon ~= nil then
    local rank = PlayerData.Build:CalBuildRank(mapData.Score)
    local sScore = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(imgIcon, sScore)
  end
end

function ReengagementBDPreviewCtrl:ClosePanel()
  self._mapNode.animRoot:Play("t_window_04_t_out")
  local animLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "t_window_04_t_out"
  })
  self:AddTimer(1, animLength, function()
    self.gameObject:SetActive(false)
  end, true, true, true)
end

return ReengagementBDPreviewCtrl
