local GoldenSpyToolBoxCtrl = class("GoldenSpyToolBoxCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local BuffSpritePath = "UI_Activity/_%s/SpriteAtlas/Buff/"
local ItemSpritePath = "UI_Activity/_%s/SpriteAtlas/Item/"
GoldenSpyToolBoxCtrl._mapNodeConfig = {
  txt_toolBox = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_ToolBox_Title"
  },
  sv_item = {
    sComponentName = "LoopScrollView"
  },
  sv_buff = {
    sComponentName = "LoopScrollView"
  },
  btn_close = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txt_None = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpyBoxEmpty"
  }
}
GoldenSpyToolBoxCtrl._mapEventConfig = {}
GoldenSpyToolBoxCtrl._mapRedDotConfig = {}

function GoldenSpyToolBoxCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.mapBuffCellCtrl = {}
end

function GoldenSpyToolBoxCtrl:OnEnable()
end

function GoldenSpyToolBoxCtrl:OnDisable()
end

function GoldenSpyToolBoxCtrl:OnDestroy()
end

function GoldenSpyToolBoxCtrl:Show(tbItem, tbBuff, callback, nActId, tipsPanelId)
  self.gameObject:SetActive(true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self.nActId = nActId
  self.nTipsPanelId = tipsPanelId
  self:RefreshBuffList(tbBuff)
  self:RefreshItemList(tbItem)
  self.callback = callback
  GamepadUIManager.EnableGamepadUI("GoldenSpyToolBoxCtrl", self.tbGamepadUINode)
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function GoldenSpyToolBoxCtrl:RefreshBuffList(tbBuff)
  self.tbBuff = tbBuff
  if self.tbBuff == nil or #self.tbBuff == 0 then
    self._mapNode.sv_buff.gameObject:SetActive(false)
    self._mapNode.txt_None.gameObject:SetActive(true)
    return
  end
  self._mapNode.txt_None.gameObject:SetActive(false)
  self._mapNode.sv_buff.gameObject:SetActive(true)
  self._mapNode.sv_buff:Init(#self.tbBuff, self, self.OnRefreshBuffGrid)
end

function GoldenSpyToolBoxCtrl:OnRefreshBuffGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapBuffCellCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Activity.GoldenSpy.GoldenSpyBuffCellCtrl")
    self.mapBuffCellCtrl[nInstanceId] = objCtrl
  end
  objCtrl:SetData(self.tbBuff[nIndex], self.nActId, self.nTipsPanelId)
end

function GoldenSpyToolBoxCtrl:RefreshItemList(tbItem)
  self.tbShowItem = tbItem
  if self.tbShowItem == nil or #self.tbShowItem == 0 then
    self._mapNode.sv_item.gameObject:SetActive(false)
    return
  end
  self._mapNode.sv_item:Init(#self.tbShowItem, self, self.OnRefreshItemGrid)
  self._mapNode.sv_item.gameObject:SetActive(true)
end

function GoldenSpyToolBoxCtrl:OnRefreshItemGrid(goGrid, gridIndex)
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

function GoldenSpyToolBoxCtrl:OnBtnClick_Close()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.gameObject:SetActive(false)
  for k, v in pairs(self.mapBuffCellCtrl) do
    self:UnbindCtrlByNode(v)
    self.mapBuffCellCtrl[k] = nil
  end
  self.mapBuffCellCtrl = {}
  if self.callback ~= nil then
    self.callback()
  end
  GamepadUIManager.DisableGamepadUI("GoldenSpyToolBoxCtrl")
end

function GoldenSpyToolBoxCtrl:OnEvent_AAA()
end

return GoldenSpyToolBoxCtrl
