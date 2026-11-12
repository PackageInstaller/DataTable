local GoldenSpyBuffSelectCtrl = class("GoldenSpyBuffSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local BuffSpritePath = "UI_Activity/_%s/SpriteAtlas/Buff/"
local ItemSpritePath = "UI_Activity/_%s/SpriteAtlas/Item/"
local bg_buff = {
  [1] = "bg_goldenspy_game_buff_04",
  [2] = "bg_goldenspy_game_buff_02",
  [3] = "bg_goldenspy_game_buff_03",
  [4] = "bg_goldenspy_game_buff_01"
}
local bg_type = {
  [1] = "db_goldenspy_tips_buff_01",
  [2] = "db_goldenspy_tips_buff_02",
  [3] = "db_goldenspy_tips_buff_03",
  [4] = "db_goldenspy_tips_buff_04"
}
local buff_type_lang = {
  [1] = "GoldenSpyBuffType1",
  [2] = "GoldenSpyBuffType2",
  [3] = "GoldenSpyBuffType3",
  [4] = "GoldenSpyBuffType4"
}
GoldenSpyBuffSelectCtrl._mapNodeConfig = {
  root = {
    sNodeName = "----SafeAreaRoot----"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  btnBuff = {
    sComponentName = "NaviButton",
    nCount = 3,
    callback = "OnBtnClick_BuffItem"
  },
  rtBtnBuff = {
    sNodeName = "btnBuff",
    sComponentName = "RectTransform",
    nCount = 3
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    nCount = 3,
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Select_Confirm",
    nCount = 3
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform",
    nCount = 3
  },
  lsv_item = {
    sComponentName = "LoopScrollView"
  },
  lsv_buff = {
    sComponentName = "LoopScrollView"
  },
  txt_toolBox = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_ToolBox_Title"
  },
  btn_Refresh = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Refresh",
    sAction = "Roll"
  },
  txt_Refresh = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Refresh_Title"
  },
  txt_num = {sComponentName = "TMP_Text"}
}
GoldenSpyBuffSelectCtrl._mapEventConfig = {
  GM_GoldenSpy_RefeshBuff = "OnEvent_GM_GoldenSpy_RefeshBuff"
}
GoldenSpyBuffSelectCtrl._mapRedDotConfig = {}

function GoldenSpyBuffSelectCtrl:Awake()
  self._mapNode.root:SetActive(false)
  self._mapNode.blur:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.AddGamepadUINode("GoldenSpyBuffSelect", self.tbGamepadUINode)
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.tbShowItem = param[1]
    self.tbBuff = param[2]
    self.tbBuffPool = param[3]
    self.selectedCallback = param[4]
    self.getRefreshCallback = param[5]
    self.refreshCallback = param[6]
    self.nActId = param[7]
  end
  self.mapBuffCellCtrl = {}
  self.tbSelectBuff = self:RandomSelectBuff()
  self:ShowBuffSelect(self.tbShowItem, self.tbBuff, self.tbSelectBuff, self.selectedCallback)
  self.bConfirmed = false
  self:RefreshRefreshCount()
end

function GoldenSpyBuffSelectCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.blur:SetActive(true)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.root:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnBuff) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_BuffItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function GoldenSpyBuffSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnBuff) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function GoldenSpyBuffSelectCtrl:OnDestroy()
  for k, v in pairs(self.mapBuffCellCtrl) do
    self:UnbindCtrlByNode(v)
    self.mapBuffCellCtrl[k] = nil
  end
  self.mapBuffCellCtrl = {}
end

function GoldenSpyBuffSelectCtrl:RandomSelectBuff()
  local tbSelectBuff = {}
  local tempPool = self:CopyTable(self.tbBuffPool)
  for i = 1, 3 do
    local buff, index = self:RandomBuff(tempPool)
    table.insert(tbSelectBuff, buff.buffId)
    table.remove(tempPool, index)
  end
  return tbSelectBuff
end

function GoldenSpyBuffSelectCtrl:RandomBuff(tbBuffPool)
  local tbBuffCount = {}
  local tbRemoveBuffIds = {}
  for _, v in ipairs(self.tbBuff) do
    tbBuffCount[v.buffData.buffId] = (tbBuffCount[v.buffData.buffId] or 0) + 1
  end
  for k, v in pairs(tbBuffCount) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", k)
    if buffCfg ~= nil and v >= buffCfg.MaxCount then
      table.insert(tbRemoveBuffIds, k)
    end
  end
  for i = #tbBuffPool, 1, -1 do
    for _, v in ipairs(tbRemoveBuffIds) do
      if tbBuffPool[i].buffId == v then
        table.remove(tbBuffPool, i)
        break
      end
    end
  end
  local nTotalWeight = 0
  for i, v in ipairs(tbBuffPool) do
    nTotalWeight = nTotalWeight + math.floor(v.weight)
  end
  local nRandom = math.random(1, nTotalWeight)
  local nSum = 0
  local nIndex = 0
  local buffData
  for i, v in ipairs(tbBuffPool) do
    nSum = nSum + v.weight
    if nRandom <= nSum then
      buffData = v
      nIndex = i
      break
    end
  end
  if NovaAPI.IsEditorPlatform() then
    print("GoldenSpyLevelCtrl: tbBuffPool:--------------------------------")
    for i, v in ipairs(tbBuffPool) do
      local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
      print("GoldenSpyLevelCtrl: buffId:", v.buffId, " Name:", buffCfg.Name, " weight:", v.weight, " TotalWeight:", nTotalWeight, " 概率：", v.weight / nTotalWeight * 100, "%")
    end
  end
  return buffData, nIndex
end

function GoldenSpyBuffSelectCtrl:RefreshRefreshCount()
  local nRefreshCount = self.getRefreshCallback() or 0
  NovaAPI.SetTMPText(self._mapNode.txt_num, string.format("%d", nRefreshCount))
end

function GoldenSpyBuffSelectCtrl:ShowBuffSelect(tbShowItem, tbBuff, tbSelectBuff, selectedCallback)
  self.selectedCallback = selectedCallback
  self:RefreshItemList(tbShowItem)
  self:RefreshBuffList(tbBuff)
  self:RefreshBuffSelectList(tbSelectBuff)
  self:ResetSelect(self._mapNode.btnBuff)
end

function GoldenSpyBuffSelectCtrl:OnRefreshItemGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local itemId = self.tbShowItem[nIndex].itemId
  local itemScore = self.tbShowItem[nIndex].score
  itemScore = math.floor(itemScore)
  local itemCfg = ConfigTable.GetData("GoldenSpyItem", itemId)
  if itemCfg == nil then
    return
  end
  local img_icon = goGrid.transform:Find("db/icon"):GetComponent("Image")
  local txt_score = goGrid.transform:Find("db/txt_score"):GetComponent("TMP_Text")
  self:SetPngSprite(img_icon, string.format(ItemSpritePath, self.nActId) .. itemCfg.IconPath .. "_s")
  NovaAPI.SetTMPText(txt_score, itemScore)
end

function GoldenSpyBuffSelectCtrl:RefreshBuffSelectList(tbSelectBuff)
  self.tbSelectBuff = tbSelectBuff
  for k, v in ipairs(self._mapNode.btnBuff) do
    v.gameObject:SetActive(false)
  end
  for i = 1, #self.tbSelectBuff do
    local buffId = self.tbSelectBuff[i]
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", buffId)
    if buffCfg ~= nil then
      local btn = self._mapNode.btnBuff[i]
      btn.gameObject:SetActive(true)
      local goSelect = btn.transform:Find("AnimRoot/CardRoot/go_select").gameObject
      local img_db = btn.transform:Find("AnimRoot/CardRoot/img_db"):GetComponent("Image")
      local img_icon = btn.transform:Find("AnimRoot/CardRoot/img_icon"):GetComponent("Image")
      local txt_name = btn.transform:Find("AnimRoot/CardRoot/txt_name"):GetComponent("TMP_Text")
      local txt_des = btn.transform:Find("AnimRoot/CardRoot/txt_des"):GetComponent("TMP_Text")
      local db_type = btn.transform:Find("AnimRoot/CardRoot/db_type"):GetComponent("Image")
      local txt_type = btn.transform:Find("AnimRoot/CardRoot/db_type/txt_type"):GetComponent("TMP_Text")
      self:SetSprite(img_db, string.format("UI_Activity/_%s/SpriteAtlas/", self.nActId) .. bg_buff[buffCfg.BuffType])
      self:SetPngSprite(img_icon, string.format(BuffSpritePath, self.nActId) .. buffCfg.Icon .. "_m")
      NovaAPI.SetTMPText(txt_name, buffCfg.Name)
      NovaAPI.SetTMPText(txt_des, buffCfg.Desc)
      self:SetPngSprite(db_type, string.format("UI_Activity/_%s/SpriteAtlas/", self.nActId) .. bg_type[buffCfg.BuffType])
      NovaAPI.SetTMPText(txt_type, ConfigTable.GetUIText(buff_type_lang[buffCfg.BuffType]))
      goSelect:SetActive(false)
      local tbEffectItem = buffCfg.ConnectItems
      local tbItemGO = {}
      for i = 1, 3 do
        local goItem = btn.transform:Find("AnimRoot/CardRoot/EffectItem" .. i).gameObject
        goItem:SetActive(false)
        table.insert(tbItemGO, goItem)
      end
      for i = 1, #tbEffectItem do
        local goItem = tbItemGO[i]
        local itemCfg = ConfigTable.GetData("GoldenSpyItem", tbEffectItem[i])
        local img_icon = goItem.transform:Find("itemIcon"):GetComponent("Image")
        self:SetPngSprite(img_icon, string.format(ItemSpritePath, self.nActId) .. itemCfg.IconPath .. "_s")
        goItem:SetActive(true)
      end
    end
  end
end

function GoldenSpyBuffSelectCtrl:RefreshItemList(tbShowItem)
  self.tbShowItem = tbShowItem
  if self.tbShowItem == nil or #self.tbShowItem == 0 then
    self._mapNode.lsv_item.gameObject:SetActive(false)
    return
  end
  self._mapNode.lsv_item:Init(#self.tbShowItem, self, self.OnRefreshItemGrid)
  self._mapNode.lsv_item.gameObject:SetActive(true)
end

function GoldenSpyBuffSelectCtrl:RefreshBuffList(tbBuff)
  self.tbBuff = tbBuff
  if self.tbBuff == nil or #self.tbBuff == 0 then
    self._mapNode.lsv_buff.gameObject:SetActive(false)
    return
  end
  self._mapNode.lsv_buff.gameObject:SetActive(true)
  self._mapNode.lsv_buff:Init(#self.tbBuff, self, self.OnRefreshBuffGrid)
end

function GoldenSpyBuffSelectCtrl:OnRefreshBuffGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapBuffCellCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Activity.GoldenSpy.GoldenSpyBuffCellCtrl")
    self.mapBuffCellCtrl[nInstanceId] = objCtrl
  end
  objCtrl:SetData(self.tbBuff[nIndex], self.nActId, self._panel.nTipsPanelId)
end

function GoldenSpyBuffSelectCtrl:ResetSelect(tbUI)
  self.nSelectIdx = 0
  GamepadUIManager.SetNavigation(tbUI)
  local nCardAnimTime = 0
  local nPanelAnimTime = 0
  local nAnimTime = nCardAnimTime > nPanelAnimTime and nCardAnimTime or nPanelAnimTime
  nAnimTime = nAnimTime + 0.4
  self:AddTimer(1, nAnimTime, function()
    if self.nSelectIdx == 0 then
      GamepadUIManager.ClearSelectedUI()
      GamepadUIManager.SetSelectedUI(self._mapNode.btnBuff[1].gameObject)
      if GamepadUIManager.GetCurUIType() == AllEnum.GamepadUIType.Mouse then
        self:OnBtnClick_BuffItem(self._mapNode.btnBuff[1].gameObject, 1)
      end
    end
  end, true, true, true)
end

function GoldenSpyBuffSelectCtrl:CopyTable(tb)
  local tbTemp = {}
  for _, v in ipairs(tb) do
    table.insert(tbTemp, v)
  end
  return tbTemp
end

function GoldenSpyBuffSelectCtrl:OnBtnClick_BuffItem(btn, nIndex)
  if nil == self.tbSelectBuff[nIndex] or self.nSelectIdx == nIndex then
    return
  end
  for k, v in ipairs(self._mapNode.btnBuff) do
    local goSelect = v.transform:Find("AnimRoot/CardRoot/go_select").gameObject
    local animator = v.transform:Find("AnimRoot"):GetComponent("Animator")
    if k == nIndex then
      goSelect:SetActive(true)
      animator:Play("btnBuff_up")
    elseif k == self.nSelectIdx then
      goSelect:SetActive(false)
      animator:Play("btnBuff_down")
    end
  end
  self.nSelectIdx = nIndex
end

function GoldenSpyBuffSelectCtrl:OnBtnSelect_BuffItem(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    self:OnBtnClick_BuffItem(btn, nIndex)
  end
end

function GoldenSpyBuffSelectCtrl:OnBtnClick_Confirm(btn, nIndex)
  if self.bConfirmed then
    return
  end
  if self.nSelectIdx ~= 0 and self.selectedCallback ~= nil then
    self.bConfirmed = true
    for k, v in ipairs(self._mapNode.btnBuff) do
      if k ~= self.nSelectIdx then
        v.gameObject:SetActive(false)
      end
    end
    local selectBtn = self._mapNode.btnBuff[self.nSelectIdx]
    local animator = selectBtn.transform:Find("AnimRoot"):GetComponent("Animator")
    animator:Play("btnBuff_get")
    self._mapNode.animCtrl:Play("GoldenSpyBuffSelectPanel_out")
    self:AddTimer(1, 0.6, function()
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self.selectedCallback(self.tbSelectBuff[self.nSelectIdx])
      end
      
      cs_coroutine.start(wait)
    end, true, true, true, nil)
  end
end

function GoldenSpyBuffSelectCtrl:OnBtnClick_Refresh(btn, nIndex)
  local nRefreshCount = self.getRefreshCallback() or 0
  if nRefreshCount <= 0 then
    return
  end
  self.tbSelectBuff = self:RandomSelectBuff()
  self:RefreshBuffSelectList(self.tbSelectBuff)
  self:ResetSelect(self._mapNode.btnBuff)
  if self.refreshCallback ~= nil then
    self.refreshCallback()
  end
  self:RefreshRefreshCount()
  self._mapNode.animCtrl:Play("GoldenSpyBuffSelectPanel_in1Empty")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function GoldenSpyBuffSelectCtrl:OnEvent_GM_GoldenSpy_RefeshBuff()
  self.tbSelectBuff = self:RandomSelectBuff()
  self:RefreshBuffSelectList(self.tbSelectBuff)
  self:ResetSelect(self._mapNode.btnBuff)
  self._mapNode.animCtrl:Play("GoldenSpyBuffSelectPanel_in1Empty")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

return GoldenSpyBuffSelectCtrl
