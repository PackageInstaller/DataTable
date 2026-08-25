local UILangPanel = {}
local GameObject = CS.UnityEngine.GameObject
local T_Text = typeof(CS.UnityEngine.UI.Text)
local T_Button = typeof(CS.UnityEngine.UI.Button)
local UITableview = CS.UITableview
local Languange = require("Lang.Language")
local LanguangeConfig = require("Lang.LanguageConfig")
local UpdateUtils = require("UpdateUtils")
local LangList = UpdateUtils.LangList

function UILangPanel:Create(cb)
  self.clickCallback = cb
  local uiParent = GameObject.Find("UIRoot/SafeArea/PopUpRoot").transform
  local panelAsset = CS.Framework.AssetLoadUtil.LoadGameObject("GameUpdate/Res/UI_Setting_Popup_ChooseLang.prefab")
  if not panelAsset then
    return false
  end
  self.rootNode = GameObject.Instantiate(panelAsset, uiParent)
  if not self.rootNode then
    return false
  end
  self.rootNode.name = "UI_Setting_Popup_ChooseLang"
  local goLangView = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/ScrollView_Lang")
  if not goLangView then
    return false
  end
  self.langView = goLangView.gameObject:GetComponent(typeof(UITableview))
  if not self.langView then
    return false
  end
  local viewItemGo = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/UI_Setting_Item_ChooseLang")
  if not viewItemGo then
    return false
  end
  self.viewItemGo = viewItemGo.gameObject
  self:_InitLangView()
  local goBtnClose = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Top/Btn_Close")
  if not goBtnClose then
    return false
  end
  self.btnClose = goBtnClose.gameObject:GetComponent(T_Button)
  self.btnClose.onClick:AddListener(function()
    if self.clickCallback then
      self.clickCallback(false)
    end
    self:Close()
  end)
  local goBtnConfirm = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/Btn_Confirm")
  if not goBtnConfirm then
    return false
  end
  self.btnConfirm = goBtnConfirm.gameObject:GetComponent(T_Button)
  self.btnConfirm.onClick:AddListener(function()
    if self.clickCallback then
      self.clickCallback(true)
    end
    pcall(Languange.SaveLanguage)
    self:Close()
  end)
  local txtTitle = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Top/Text_Title")
  if not txtTitle then
    return false
  end
  self.txtTitle = txtTitle.gameObject:GetComponent(T_Text)
  local textTip = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/Text_Tip")
  if not textTip then
    return false
  end
  self.textTip = textTip.gameObject:GetComponent(T_Text)
  local textBataTip = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/Text_BetaTip")
  if not textBataTip then
    return false
  end
  self.textBataTip = textBataTip.gameObject:GetComponent(T_Text)
  local txtConfirm = self.rootNode.transform:Find("UI_Common_Popup_Tips_L/Group_Popup/Group_Content/Btn_Confirm/Text_Name")
  if not txtConfirm then
    return false
  end
  self.txtConfirm = txtConfirm.gameObject:GetComponent(T_Text)
  return true
end

function UILangPanel:_RefreshPanelText()
  local cur_lang = Languange.cur_lang
  if self.txtTitle then
    self.txtTitle.text = LanguangeConfig[cur_lang].PlanText.SelectLangTitle
  end
  if self.textTip then
    self.textTip.text = LanguangeConfig[cur_lang].PlanText.SelectLangTips
  end
  if self.textBataTip then
    self.textBataTip.text = LanguangeConfig[cur_lang].PlanText.SelectLangBetaTips or ""
  end
  if self.txtConfirm then
    self.txtConfirm.text = LanguangeConfig[cur_lang].PlanText["确认"]
  end
  self:_UpdateTHFont(cur_lang)
end

function UILangPanel:_UpdateTHFont(cur_lang)
  local font = UpdateUtils.GetLangFont(cur_lang)
  if self.txtConfirm and font then
    self.txtTitle.font = font
    self.textTip.font = font
    self.textBataTip.font = font
    self.txtConfirm.font = font
  end
end

function UILangPanel:_InitLangView()
  function self.langView.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    
    cell = cell or view:AddChild(self.viewItemGo)
    local lang_type = LangList[index + 1]
    local nodeSel = cell.transform:Find("Group_Sel")
    local btnClick = cell.transform:Find("Btn_Click"):GetComponent(T_Button)
    btnClick.onClick:RemoveAllListeners()
    btnClick.onClick:AddListener(function()
      Languange.SetLanguage(lang_type)
      self:_RefreshPanelText()
      self.langView:Refresh()
    end)
    if nodeSel then
      nodeSel.gameObject:SetActive(lang_type == Languange.cur_lang)
    end
    local Text_Lang = cell.transform:Find("Text_Lang"):GetComponent(T_Text)
    Text_Lang.text = LanguangeConfig[lang_type].PlanText.LanguangeName
    local font = UpdateUtils.GetLangFont(lang_type)
    Text_Lang.font = font
    return cell
  end
  
  function self.langView.numberCellsInTableview()
    return #LangList
  end
end

function UILangPanel:Open()
  if not self.langView then
    return false
  end
  self:_RefreshPanelText()
  self.langView:ReloadData()
  return true
end

function UILangPanel:Close()
  if self.langView then
    self.langView:Travel(function(cell)
      local btnClick = cell.transform:Find("Btn_Click"):GetComponent(T_Button)
      btnClick.onClick:RemoveAllListeners()
    end)
  end
  if self.rootNode then
    self.rootNode:SetActive(false)
  end
  if self.btnConfirm then
    self.btnConfirm.onClick:RemoveAllListeners()
  end
  if self.btnClose then
    self.btnClose.onClick:RemoveAllListeners()
  end
  if self.rootNode then
    self.rootNode:SetActive(false)
  end
end

function UILangPanel:Destroy()
  self:Close()
  if self.rootNode then
    GameObject.Destroy(self.rootNode)
  end
  self.clickCallback = nil
  self.rootNode = nil
  self.langView = nil
  self.btnConfirm = nil
  self.btnClose = nil
  self.txtTitle = nil
  self.textTip = nil
  self.textBataTip = nil
  self.txtConfirm = nil
end

return UILangPanel
