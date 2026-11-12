local CharAttrDetailCtrl = class("CharAttrDetailCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
CharAttrDetailCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  goProperty = {nCount = 3},
  Content = {sComponentName = "Transform"},
  aniBox = {
    sNodeName = "t_window_04",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Char_AttrDetail"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
CharAttrDetailCtrl._mapEventConfig = {}

function CharAttrDetailCtrl:InitData(attrList, eet)
  self.tbAttr = {}
  for i = 1, 29 do
    local nEET = AllEnum.CharAttr[i].nEET
    if not nEET or eet == nEET then
      local nGroup = AllEnum.CharAttr[i].nGroup
      if not self.tbAttr[nGroup] then
        self.tbAttr[nGroup] = {}
      end
      table.insert(self.tbAttr[nGroup], {
        mapCharAttr = AllEnum.CharAttr[i],
        mapAttrData = attrList[i],
        bSimple = i <= 3
      })
    end
  end
end

function CharAttrDetailCtrl:Refresh()
  delChildren(self._mapNode.Content)
  for _, tbGroup in pairs(self.tbAttr) do
    local nGroupCount = #tbGroup
    local goItemObj = instantiate(self._mapNode.goProperty[nGroupCount], self._mapNode.Content)
    goItemObj:SetActive(true)
    for i = 1, nGroupCount do
      local goBar = goItemObj.transform:Find("goBar" .. i).gameObject
      local ctrlItem = self:BindCtrlByNode(goBar, "Game.UI.CharacterInfoEx.CharAttrDetailPropertyCtrl")
      ctrlItem:SetProperty(tbGroup[i].mapCharAttr, tbGroup[i].mapAttrData, i == 1, tbGroup[i].bSimple)
    end
  end
end

function CharAttrDetailCtrl:Awake()
  local tbParam = self:GetPanelParam()
  local attrList, eet
  if type(tbParam) == "table" then
    attrList = tbParam[1]
    eet = tbParam[2]
  end
  self:InitData(attrList, eet)
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function CharAttrDetailCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("CharAttrDetailCtrl", self:GetGamepadUINode(), nil, true)
  end
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self._mapNode.aniBox:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:Refresh()
end

function CharAttrDetailCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("CharAttrDetailCtrl")
  end
end

function CharAttrDetailCtrl:OnDestroy()
end

function CharAttrDetailCtrl:OnBtnClick_Close()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self._mapNode.aniBox:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.CharAttrDetail)
  end, true, true, true)
end

return CharAttrDetailCtrl
