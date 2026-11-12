local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharPlotCtrl = class("CharPlotCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharPlotCtrl._mapNodeConfig = {
  got_fullscreen_blur_blue = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "GameObject"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Title"
  },
  txtTitleAvgReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_BaseInfo"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_CloseAvgRoot"
  },
  goMainLineAvgRoot = {
    sNodeName = "goMainLineAvgRoot",
    sComponentName = "GameObject"
  },
  anit_window_01 = {
    sNodeName = "t_window_01",
    sComponentName = "Animator"
  },
  imgAVGLevelIcon = {
    sNodeName = "imgAVGLevelIcon",
    sComponentName = "Image"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseAvgRoot"
  },
  btnCancel = {
    sNodeName = "btnCancel",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseAvgRoot"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Cancel"
  },
  mainLineAvgBtn = {
    sNodeName = "mainLineAvgBtn",
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnterPlot"
  },
  mainLineAvgBtnTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Goto"
  },
  avgItemBtn1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  tcAvgItem1 = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtmainLineAvgLvName = {
    sNodeName = "mainLineAvgLvName",
    sComponentName = "TMP_Text"
  },
  txtmainLineAvgLvDes = {
    sNodeName = "mainLineAvgLvDes",
    sComponentName = "TMP_Text"
  },
  txtmainLineAvgLvNum = {
    sNodeName = "mainLineAvgLvNum",
    sComponentName = "TMP_Text"
  }
}
CharPlotCtrl._mapEventConfig = {}

function CharPlotCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.plotData = tbParam[1]
  self.tbReward = tbParam[2]
  self.curSelectIndex = tbParam[3]
  self.curPlotIndex = tbParam[4]
end

function CharPlotCtrl:OnEnable()
  self._mapNode.got_fullscreen_blur_blue:SetActive(true)
  self._mapNode.goMainLineAvgRoot:SetActive(true)
  self._mapNode.anit_window_01:Play("t_window_04_t_in")
  local data = self.plotData
  local rewardData = self.tbReward[self.curSelectIndex]
  NovaAPI.SetTMPText(self._mapNode.txtmainLineAvgLvName, data.Name)
  NovaAPI.SetTMPText(self._mapNode.txtmainLineAvgLvDes, data.Desc)
  if data.PlotType == GameEnum.CharPlotType.CharPlot then
    NovaAPI.SetTMPText(self._mapNode.txtmainLineAvgLvNum, orderedFormat(ConfigTable.GetUIText("Plot_Index"), self.curPlotIndex))
  elseif data.PlotType == GameEnum.CharPlotType.SkinPlot then
    local nSkinId = data.UnlockSkinId
    local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
    if mapSkinCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtmainLineAvgLvNum, orderedFormat(ConfigTable.GetUIText("Skin_Plot_Index"), mapSkinCfg.Name, self.curPlotIndex))
    else
      NovaAPI.SetTMPText(self._mapNode.txtmainLineAvgLvNum, orderedFormat(ConfigTable.GetUIText("Plot_Index"), self.curPlotIndex))
    end
  end
  self:SetPngSprite(self._mapNode.imgAVGLevelIcon, data.PicSource)
  self._mapNode.tcAvgItem1:SetItem(rewardData.nId, nil, nil, nil, rewardData.bReceive, not rewardData.bReceive)
end

function CharPlotCtrl:OnDisable()
end

function CharPlotCtrl:OnBtnClick_CloseAvgRoot()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharPlot)
end

function CharPlotCtrl:OnBtnClick_EnterPlot()
  self._mapNode.goMainLineAvgRoot:SetActive(false)
  self._mapNode.got_fullscreen_blur_blue:SetActive(false)
  self:AddTimer(0, 1, function()
    EventManager.Hit("Enter_CharPlot")
  end)
end

function CharPlotCtrl:OnBtnClick_Reward(btn)
  if self.tbReward ~= nil then
    local nTid = self.tbReward[self.curSelectIndex].nId
    UTILS.ClickItemGridWithTips(nTid, btn.transform, false, true, false)
  end
end

return CharPlotCtrl
