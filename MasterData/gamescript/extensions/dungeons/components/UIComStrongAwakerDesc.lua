local UIComStrongAwakerDesc, Super = System.NewComponent("UIComStrongAwakerDesc", RelicClickTips)

function UIComStrongAwakerDesc:ctor(res, maskNode, awakerId)
  Super.ctor(self)
  self.ui = UI_Common_Popup_Tips_AwakerResource(res)
  self.maskNode = maskNode
  self.awakerId = awakerId
end

function UIComStrongAwakerDesc:_OnBindView()
  local awakerCfg = DT.AwakerConfig[self.awakerId]
  self.binder:SetActive(self.ui.Btn_Mask, true)
  self.binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnMaskClicked))
  self.binder:SetText(self.ui.Text_Title, LT.Text(awakerCfg.Name))
  self.binder:SetText(self.ui.Text_Desc, LT.Textf("EnhancedPrompt", awakerCfg.Name))
  self.binder:SetText(self.ui.Text_Desc_1, LT.Textf("EnhancedPrompt", awakerCfg.Name))
  self.binder:SetActive(self.ui.Text_Level, false)
  self.binder:SetActive(self.ui.Text_Desc_2, false)
  self.binder:SetActive(self.ui.Icon_StageChapter, false)
  self.binder:SetActive(self.ui.Text_Count, false)
  self.binder:SetImage(self.ui.Icon_Article, awakerCfg.Item_LittleIcon)
end

function UIComStrongAwakerDesc:OpenKeyWordTips()
end

return UIComStrongAwakerDesc
