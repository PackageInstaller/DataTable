local BdConvertCellCtrl = class("BdConvertCellCtrl", BaseCtrl)
local minHeight = 85.26
BdConvertCellCtrl._mapNodeConfig = {
  bg = {
    sComponentName = "RectTransform"
  },
  img_unOpen = {
    sComponentName = "RectTransform"
  },
  txt_unOpenTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_UnopenTips"
  },
  txt_unOpen = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_Unopen"
  },
  txt_finishTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_Finish"
  },
  icon = {sComponentName = "Image"},
  txt_title = {sComponentName = "TMP_Text"},
  bg_reward = {
    sComponentName = "RectTransform"
  },
  txt_reward = {sComponentName = "TMP_Text"},
  svItem = {
    sComponentName = "LoopScrollView"
  },
  icon_com = {},
  img_finish = {},
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  btnGrid_None = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  txt_btn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_ToBuild"
  },
  txt_tip = {sComponentName = "TMP_Text"},
  icon_star = {},
  Content = {
    sComponentName = "RectTransform"
  },
  target = {nCount = 3}
}

function BdConvertCellCtrl:Awake()
  self.tbItemIns = {}
end

function BdConvertCellCtrl:OnDisable()
  if self.tbItemIns ~= nil then
    for _, ctrl in pairs(self.tbItemIns) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemIns = {}
end

function BdConvertCellCtrl:SetData(actId, optionId)
  self.nActId = actId
  self.nOptionId = optionId
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.contentData = self.actData:GetBdDataBy(self.nOptionId)
  local contentCfg = ConfigTable.GetData("BdConvertContent", self.nOptionId)
  if contentCfg == nil then
    return
  end
  local data = self.actData:GetBdDataBy(optionId)
  if data == nil then
    return
  end
  self._mapNode.img_unOpen.gameObject:SetActive(data.bIsOpen == false)
  if contentCfg.Icon ~= "" then
    self:SetPngSprite(self._mapNode.icon, contentCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_title, contentCfg.Des)
  NovaAPI.SetTMPText(self._mapNode.txt_reward, ConfigTable.GetUIText("BdConvert_RewardTitle") .. " " .. data.nCurSub .. "/" .. data.nMaxSub)
  self.tbItem = {}
  local tbReward = decodeJson(contentCfg.BasicReward)
  local tbTemp = {}
  for key, value in pairs(tbReward) do
    tbTemp[tonumber(key)] = tonumber(value)
  end
  for _, rewardId in ipairs(contentCfg.BasicRewardPreview) do
    table.insert(self.tbItem, {
      itemId = rewardId,
      itemCount = tbTemp[rewardId]
    })
  end
  self._mapNode.svItem:Init(#self.tbItem, self, self.OnRewardItemGridRefresh, self.OnGridBtnClick)
  self._mapNode.icon_com:SetActive(data.nCurSub == data.nMaxSub)
  self._mapNode.img_finish:SetActive(data.nCurSub == data.nMaxSub)
  self._mapNode.icon_star:SetActive(data.nCurSub ~= data.nMaxSub)
  self._mapNode.txt_unOpen.gameObject:SetActive(data.bIsOpen == false)
  for i = 1, 3 do
    self._mapNode.target[i].gameObject:SetActive(false)
  end
  for index, optionId in ipairs(contentCfg.ConvertConditionList) do
    if index <= 3 then
      local txt_target = self._mapNode.target[index].transform:Find("txt_target"):GetComponent("TMP_Text")
      local targetCfg = ConfigTable.GetData("BdConvertCondition", optionId)
      if targetCfg ~= nil then
        NovaAPI.SetTMPText(txt_target, targetCfg.RequestDes)
        self._mapNode.target[index].gameObject:SetActive(true)
      end
    end
  end
  local nCount = 0
  local tbAllbuild = self.actData:GetAllBuildByOpId(self.nOptionId)
  if tbAllbuild ~= nil then
    nCount = #tbAllbuild
  end
  self._mapNode.btnGrid_None.gameObject:SetActive(nCount == 0)
  self._mapNode.btnGrid.gameObject:SetActive(nCount ~= 0)
  if nCount == 0 then
    NovaAPI.SetTMPText(self._mapNode.txt_tip, ConfigTable.GetUIText("BdConvert_BuildCountTips1"))
  else
    NovaAPI.SetTMPText(self._mapNode.txt_tip, orderedFormat(ConfigTable.GetUIText("BdConvert_BuildCountTips2"), nCount))
  end
  local bGet = self.contentData.nCurSub == self.contentData.nMaxSub
  if bGet then
    self._mapNode.btnGrid_None.gameObject:SetActive(false)
    self._mapNode.btnGrid.gameObject:SetActive(false)
    self._mapNode.txt_tip.gameObject:SetActive(false)
    self._mapNode.txt_finishTips.gameObject:SetActive(true)
  else
    self._mapNode.txt_finishTips.gameObject:SetActive(false)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local curHeight = self._mapNode.Content.sizeDelta.y
    local rectTransform = self.gameObject:GetComponent("RectTransform")
    rectTransform.sizeDelta = Vector2(rectTransform.sizeDelta.x, rectTransform.sizeDelta.y + curHeight - minHeight)
    self._mapNode.bg.sizeDelta = Vector2(self._mapNode.bg.sizeDelta.x, self._mapNode.bg.sizeDelta.y + curHeight - minHeight)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.bg)
  end
  
  cs_coroutine.start(wait)
end

function BdConvertCellCtrl:OnRewardItemGridRefresh(goGrid, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbItem[nDataIndex].itemId
  local goItem = goGrid.transform:Find("btnGrid/AnimRoot/tcItem").gameObject
  local instanceId = goItem:GetInstanceID()
  if self.tbItemIns[instanceId] == nil then
    self.tbItemIns[instanceId] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local bGet = self.contentData.nCurSub == self.contentData.nMaxSub
  self.tbItemIns[instanceId]:SetItem(itemId, nil, self.tbItem[nDataIndex].itemCount, nil, bGet)
end

function BdConvertCellCtrl:OnGridBtnClick(goGrid, nIndex)
  local nDataIndex = nIndex + 1
  local itemId = self.tbItem[nDataIndex].itemId
  UTILS.ClickItemGridWithTips(itemId, goGrid.transform:Find("btnGrid").transform, true, true, false)
end

function BdConvertCellCtrl:OnBtnClick_JumpTo()
  EventManager.Hit("BdConvert_JumpToBuildPanel", self.nOptionId)
end

return BdConvertCellCtrl
