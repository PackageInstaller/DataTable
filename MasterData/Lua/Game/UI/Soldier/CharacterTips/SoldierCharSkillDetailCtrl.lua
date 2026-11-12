local CommonTipsBaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local SoldierCharSkillDetailCtrl = class("SoldierCharSkillDetailCtrl", CommonTipsBaseCtrl)
SoldierCharSkillDetailCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  TipsView = {sComponentName = "ScrollRect"},
  goSkillDetailItem = {
    sNodeName = "SoldierCharSkillDetailItem",
    ComponentName = "Transform"
  }
}
SoldierCharSkillDetailCtrl._mapEventConfig = {}
SoldierCharSkillDetailCtrl._mapRedDotConfig = {}
SoldierCharSkillDetailCtrl.maxTipHeight = 896

function SoldierCharSkillDetailCtrl:Awake()
  self._tbItems = {}
  self._nCharId = 0
  self._nStar = 1
  self._mapNode.goSkillDetailItem.gameObject:SetActive(false)
end

function SoldierCharSkillDetailCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self._nCharId = tbParam[2]
    self._nStar = tbParam[3] or 1
    self._bFront = tbParam[4] or false
  end
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  if self._mapNode.btnShortcutClose ~= nil then
    self:EnableGamepadUI(self._mapNode.btnShortcutClose, true)
  end
  self:_RefreshSkillList()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil then
      return
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.TipsContent)
    local nContentHeight = self._mapNode.TipsContent.rect.height
    local bExceed = nContentHeight > self.maxTipHeight
    if bExceed then
      nContentHeight = self.maxTipHeight
    end
    if self._mapNode.TipsView ~= nil then
      NovaAPI.SetScrollRectVertical(self._mapNode.TipsView, bExceed)
    end
    if self._mapNode.imgTipsBg ~= nil then
      self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight)
    end
    if self.rtTarget ~= nil and self._mapNode.rtContent ~= nil and self._mapNode.safeAreaRoot ~= nil then
      self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    end
  end
  
  cs_coroutine.start(wait)
end

function SoldierCharSkillDetailCtrl:OnDisable()
  self:DisableGamepadUI()
  self:_ClearItems()
end

function SoldierCharSkillDetailCtrl:OnDestroy()
end

function SoldierCharSkillDetailCtrl:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
end

function SoldierCharSkillDetailCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function SoldierCharSkillDetailCtrl:_RefreshSkillList()
  if self._nCharId == nil or self._nCharId == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData("SoldierCharacter", self._nCharId)
  if mapCfg == nil then
    printError("[SoldierCharSkillDetailCtrl] SoldierCharacter 表找不到数据，id=" .. tostring(self._nCharId))
    return
  end
  local tbSlots = self._bFront and {
    {
      nSkillId = mapCfg.Skill,
      nIndex = 2
    }
  } or {
    {
      nSkillId = mapCfg.Support,
      nIndex = 3
    }
  }
  for _, slot in ipairs(tbSlots) do
    if slot.nSkillId ~= nil and slot.nSkillId ~= 0 then
      local goItem = instantiate(self._mapNode.goSkillDetailItem.gameObject, self._mapNode.TipsContent)
      goItem:SetActive(true)
      local objCtrl = self:BindCtrlByNode(goItem, "Game.UI.Soldier.CharacterTips.Items.SoldierCharSkillDetailItemCtrl")
      objCtrl:SetData(slot.nSkillId, slot.nIndex, self._nStar)
      table.insert(self._tbItems, objCtrl)
    end
  end
end

function SoldierCharSkillDetailCtrl:_ClearItems()
  if type(self._tbItems) ~= "table" then
    return
  end
  for _, objCtrl in ipairs(self._tbItems) do
    local goItem = objCtrl.gameObject
    self:UnbindCtrlByNode(objCtrl)
    if goItem ~= nil and goItem:IsNull() == false then
      destroy(goItem)
    end
  end
  self._tbItems = {}
end

return SoldierCharSkillDetailCtrl
