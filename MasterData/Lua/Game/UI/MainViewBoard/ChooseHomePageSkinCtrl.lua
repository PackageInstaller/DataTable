local ChooseHomePageSkinCtrl = class("ChooseHomePageSkinCtrl", BaseCtrl)
local PlayerCharSkinData = PlayerData.CharSkin
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local tableInsert = table.insert
ChooseHomePageSkinCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  btnGotoBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GotoBuy"
  },
  btnUseSkin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UseSkin"
  },
  txtBtnUseSkin = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Use_Skin"
  },
  btnGotoAdvance = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GotoAdvance"
  },
  txtBtnGotoAdvance = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Skin_Advance"
  },
  txtBtnGotoBuy = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Skin_Buy"
  },
  txtSkinEquipped = {sComponentName = "TMP_Text"},
  txtSkinName = {sComponentName = "TMP_Text"},
  goFavorCGLockTip = {},
  txtLockTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Board_Skin_CG_Lock"
  },
  imgEquipped = {}
}
ChooseHomePageSkinCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnBtnClick_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}

function ChooseHomePageSkinCtrl:SortSkinList()
  self.tbSortSkinList = {}
  for _, v in pairs(self.tbSkinList) do
    if true == v:CheckSkinShow() or true == v:CheckUnlock() then
      tableInsert(self.tbSortSkinList, v)
    end
  end
  table.sort(self.tbSortSkinList, function(a, b)
    return a:GetId() < b:GetId()
  end)
end

function ChooseHomePageSkinCtrl:RefreshSelectSkinInfo()
  local skinData = self.tbSortSkinList[self.nSelectIndex]
  if nil == skinData then
    return
  end
  self._mapNode.goFavorCGLockTip.gameObject:SetActive(false)
  local skinCfg = skinData:GetCfgData()
  self.nSkinId = skinData:GetId()
  NovaAPI.SetTMPText(self._mapNode.txtSkinName, skinCfg.Name)
  self._mapNode.btnGotoBuy.gameObject:SetActive(false)
  self._mapNode.btnGotoAdvance.gameObject:SetActive(false)
  self._mapNode.btnUseSkin.gameObject:SetActive(self.nSkinId ~= self.nUsingSkinId and skinData:CheckUnlock())
  self._mapNode.imgEquipped.gameObject:SetActive(skinData:CheckUnlock() and self.nSkinId == self.nUsingSkinId)
  local bEquipped = self.nSkinId == self.nUsingSkinId and skinData:CheckUnlock()
  local bNotHave = not skinData:CheckUnlock() and self.nSkinId ~= self.nUsingSkinId and skinCfg.SourceDesc ~= nil
  self._mapNode.imgEquipped.gameObject:SetActive(bEquipped or bNotHave)
  if bNotHave then
    local sText = AllEnum.CharSkinSource[skinCfg.SourceDesc]
    if sText ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtSkinEquipped, ConfigTable.GetUIText(sText))
    else
      self._mapNode.imgEquipped.gameObject:SetActive(false)
    end
  else
    NovaAPI.SetTMPText(self._mapNode.txtSkinEquipped, ConfigTable.GetUIText("Skin_Equipped"))
  end
  self:RefreshActor2D()
end

function ChooseHomePageSkinCtrl:RefreshActor2D()
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, self.nCharId, self.nSkinId)
end

function ChooseHomePageSkinCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateSkinCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetSkinData(self.tbSortSkinList[nIndex], false)
  self.tbGridCtrl[nInstanceId]:RefreshChoseSkin(self.nUsingSkinId)
  if self.nSelectIndex == nIndex then
    self.tbGridCtrl[nInstanceId]:SetSelect(true)
  else
    self.tbGridCtrl[nInstanceId]:SetSelect(false)
  end
end

function ChooseHomePageSkinCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.tbGridCtrl[nInstanceId]:SetSelect(true)
  self.nSelectIndex = nIndex
  self._mapNode.sv:SetScrollGridPos(nIndex - 1, 0, 0)
  self:RefreshSelectSkinInfo()
end

function ChooseHomePageSkinCtrl:ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.ChooseHomePageSkinPanel)
end

function ChooseHomePageSkinCtrl:BackToHome()
  if nil == self.tbTmpSelectList or nil == next(self.tbTmpSelectList) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Board_Select_Empty"))
    return
  end
  
  local function sucCallback()
    PanelManager.Home()
  end
  
  PlayerData.Board:SendBoardSet(sucCallback)
end

function ChooseHomePageSkinCtrl:Awake()
  self.nSelectIndex = nil
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nCharId = param[1]
    self.nUsingSkinId = param[2]
    self.tbTmpSelectList = param[3]
  end
end

function ChooseHomePageSkinCtrl:FadeIn()
  self._mapNode.animRoot:Play("ChooseHomePageSkin_in")
end

function ChooseHomePageSkinCtrl:OnEnable()
  self.tbGridCtrl = {}
  self.tbSkinList = PlayerCharSkinData:GetSkinListByCharacterId(self.nCharId)
  self:SortSkinList()
  for nIndex = 1, #self.tbSortSkinList do
    if self.nUsingSkinId == self.tbSortSkinList[nIndex]:GetId() then
      self.nSelectIndex = nIndex
      break
    end
  end
  if self.nSelectIndex == nil then
    self.nSelectIndex = 1
  end
  self._mapNode.sv:Init(#self.tbSortSkinList, self, self.OnGridRefresh, self.OnGridBtnClick)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.sv:SetScrollGridPos(self.nSelectIndex - 1, 0, 0)
    self:RefreshSelectSkinInfo()
  end
  
  cs_coroutine.start(wait)
end

function ChooseHomePageSkinCtrl:FadeOut()
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "ChooseHomePageSkin_out"
  })
  self._mapNode.animRoot:Play("ChooseHomePageSkin_out")
  return nAnimTime
end

function ChooseHomePageSkinCtrl:OnDisable()
  Actor2DManager.UnsetActor2D()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ChooseHomePageSkinCtrl:OnDestroy()
  self.tbSkinList = nil
  self.tbSortSkinList = nil
  self.tbGridCtrl = nil
end

function ChooseHomePageSkinCtrl:OnBtnClick_GotoBuy()
end

function ChooseHomePageSkinCtrl:OnBtnClick_UseSkin()
  self.nUsingSkinId = self.nSkinId
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv:Init(#self.tbSortSkinList, self, self.OnGridRefresh, self.OnGridBtnClick)
  self._mapNode.sv:SetScrollGridPos(self.nSelectIndex - 1, 0, 0)
  self:RefreshSelectSkinInfo()
  local skinData = self.tbSkinList[self.nUsingSkinId]
  if nil ~= skinData then
    local handbookId = skinData:GetHandbookId()
    PlayerData.Board:ChangeTmpCharSkin(self.nCharId, handbookId)
  end
  Actor2DManager.SetActor2DTypeByPanel(PanelId.MainView, self.nCharId, AllEnum.Actor2DType.Normal)
  self:ClosePanel()
end

function ChooseHomePageSkinCtrl:OnBtnClick_GotoAdvance()
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId)
end

function ChooseHomePageSkinCtrl:OnBtnClick_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.nUsingSkinId ~= self.nSkinId then
    local skinData = self.tbSortSkinList[self.nSelectIndex]
    if skinData:CheckUnlock() then
      self.nUsingSkinId = self.nSkinId
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Board_Change_Skin"),
        callbackConfirm = function()
          local skinData = self.tbSkinList[self.nUsingSkinId]
          if nil ~= skinData then
            local handbookId = skinData:GetHandbookId()
            PlayerData.Board:ChangeTmpCharSkin(self.nCharId, handbookId)
          end
          self:ClosePanel()
        end,
        callbackCancel = function()
          self:ClosePanel()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  self:ClosePanel()
end

function ChooseHomePageSkinCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.nUsingSkinId ~= self.nSkinId then
    local skinData = self.tbSortSkinList[self.nSelectIndex]
    if skinData:CheckUnlock() then
      self.nUsingSkinId = self.nSkinId
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Board_Change_Skin"),
        callbackConfirm = function()
          local skinData = self.tbSkinList[self.nUsingSkinId]
          if nil ~= skinData then
            local handbookId = skinData:GetHandbookId()
            PlayerData.Board:ChangeTmpCharSkin(self.nCharId, handbookId)
          end
          self:BackToHome()
        end,
        callbackCancel = function()
          self:BackToHome()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  self:BackToHome()
end

return ChooseHomePageSkinCtrl
