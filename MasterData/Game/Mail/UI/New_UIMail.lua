local New_UIMail = class("New_UIMail", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local MailEnum = require("Game.Mail.MailEnum")
local UINMailListItem = require("Game.Mail.UI.UINMailListItem")
local UINMailContent = require("Game.Mail.UI.UINMailContent")
local SkinEnum = require("Game.Skin.SkinEnum")
local _loadSenderPicFunc = {
  [MailEnum.SenderPicType.lPic] = function(self, picName, posList)
    self.resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(picName), function(prefab)
      DestroyUnityObject(self._senderPic)
      self._senderPic = prefab:Instantiate(self.ui.obj_HeroHolder)
      local commonPicCtrl = self._senderPic:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      if posList and 2 <= #posList then
        self._senderPic.transform.localPosition = Vector3.Temp(posList[1], posList[2], 0)
      end
    end)
  end,
  [MailEnum.SenderPicType.l2d] = function(self, picName, posList)
    self.resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(picName, SkinEnum.fromWhere.mail), function(prefab)
      DestroyUnityObject(self._senderPic)
      self._senderPic = prefab:Instantiate(self.ui.obj_HeroHolder)
      self._senderPic.transform:SetLayer(LayerMask.UI)
      local cs_CubismInterationController = self._senderPic.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
      if cs_CubismInterationController ~= nil then
        local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
        self.heroCubismInteration = HeroCubismInteration.New()
        self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, self.heroID, self.skinID, UIManager:GetUICamera(), false)
        self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
        local sortingOrder = self.ui.rootCanvas.sortingOrder
        local layerName = self.ui.rootCanvas.sortingLayerName
        self.heroCubismInteration:SetRenderControllerSetting(layerName, self.ui.heroCanvasGroup, sortingOrder, true)
        self.heroCubismInteration:SetL2DPosType("HeroList", false)
      end
      if posList and 2 <= #posList then
        self._senderPic.transform.localPosition = Vector3.Temp(posList[1], posList[2], 0)
      end
    end)
  end
}

function New_UIMail:OnInit()
  local layerName = self:GetWindowSortingLayer()
  self.ui.frameCanvas.sortingLayerName = layerName
  self.ui.rootCanvas.sortingLayerName = layerName
  self.mailDataList = {}
  self.mailItemDic = {}
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Mail, true)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.GetAllRewards)
  UIUtil.AddButtonListener(self.ui.btn_Delete, self, self.DeletAllReadedMail)
  UIUtil.AddButtonListener(self.ui.btn_treasureSelect, self, self.OnClickTreasureSelect)
  self._OnClickMailItem = BindCallback(self, self.OnClickMailItem)
  self.ui.loopList_mails.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loopList_mails.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.mailContent = UINMailContent.New()
  self.mailContent:Init(self.ui.detail)
  self._m_MailDiff = BindCallback(self, self.m_MailDiff)
  MsgCenter:AddListener(eMsgEventId.OnMailDiff, self._m_MailDiff)
  self._m_MailDelete = BindCallback(self, self.m_MailDelete)
  MsgCenter:AddListener(eMsgEventId.OnMailDelete, self._m_MailDelete)
  self.resloader = CS.ResLoader.Create()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
end

function New_UIMail:OnShow()
  base.OnShow(self)
  self.ctrl:OnMailUIShow(function()
    self:RefreshTreasureSelect(false)
  end)
end

function New_UIMail:RefreshMailList(dataList)
  local num = #dataList
  self.mailDataList = dataList
  if 0 < num then
    self.ui.empty:SetActive(false)
    self.ui.layoutGroup:SetActive(true)
    self.ui.btnGroup:SetActive(true)
    self.ui.loopList_mails.totalCount = num
    self.ui.loopList_mails:RefillCells()
  else
    self.ui.empty:SetActive(true)
    self.ui.layoutGroup:SetActive(false)
    self.ui.btnGroup:SetActive(false)
  end
  local isTreasure = self.ctrl:GetOnlyShowTreasureMail()
  local numLimit = isTreasure and ConfigData.game_config.MailTreasureCount or ConfigData.game_config.MailNumLimit
  self.ui.tex_Count:SetIndex(0, tostring(num), tostring(numLimit))
  if num == 0 then
    self.mailContent:UpdateContent()
  end
end

function New_UIMail:m_OnNewItem(go)
  local mailItem = UINMailListItem.New()
  mailItem:Init(go)
  mailItem:SetCallback(self._OnClickMailItem)
  self.mailItemDic[go] = mailItem
end

function New_UIMail:m_OnChangeItem(go, index)
  local mailItem = self.mailItemDic[go]
  if mailItem == nil then
    error("Can't find mailItem by gameObject")
    return
  end
  local mailData = self.mailDataList[index + 1]
  if mailData == nil then
    error("Can't find mailData by index, index = " .. tonumber(index))
  end
  mailItem:InitMailItem(mailData)
end

function New_UIMail:m_GetItemByData(data)
  for k, v in ipairs(self.mailDataList) do
    if v == data then
      local index = k - 1
      return self:m_GetItemGoByIndex(index)
    end
  end
end

function New_UIMail:m_GetItemGoByIndex(index)
  local go = self.ui.loopList_mails:GetCellByIndex(index)
  if go ~= nil then
    return self.mailItemDic[go]
  end
  return nil
end

function New_UIMail:m_MailDiff(diffDatas, hasNew)
  if hasNew then
    self:RefreshMailList(self.ctrl:GetMailDataList())
  end
  for _, mailData in ipairs(diffDatas) do
    local mailItem = self:m_GetItemByData(mailData)
    if mailItem ~= nil then
      mailItem:InitMailItem(mailData)
      if self.lastSelectMailData == mailData then
        mailItem:OnCkilck()
      end
    end
  end
end

function New_UIMail:m_MailDelete(delete)
  if table.count(delete) > 0 then
    self:RefreshMailList(self.ctrl:GetMailDataList())
    if self.lastSelectMailData ~= nil and self.lastSelectMailData.isDeleted then
      self:OpenFirstMail()
    end
  end
end

function New_UIMail:OpenFirstMail()
  if #self.mailDataList > 0 then
    local firstMailData = self.mailDataList[1]
    if self.lastSelectMailData == firstMailData then
      return
    end
    local mailItem = self:m_GetItemByData(firstMailData)
    mailItem:OnCkilck(true)
  else
    self:ClearOldSenderPic()
  end
end

function New_UIMail:OnClickMailItem(mailData)
  if self.lastSelectMailData ~= nil and mailData ~= self.lastSelectMailData then
    self.lastSelectMailData.isSelected = false
    local lastSelectedItem = self:m_GetItemByData(self.lastSelectMailData)
    if lastSelectedItem ~= nil then
      lastSelectedItem:SetSelect(false)
    end
  end
  self.lastSelectMailData = mailData
  self:OpenMail(mailData)
end

function New_UIMail:OpenMail(mailData)
  self.ctrl:ReqMailRead(mailData.uid, function()
  end)
  self.mailContent:UpdateContent(mailData)
end

function New_UIMail:ClearOldSenderPic()
  if self._senderPic ~= nil then
    DestroyUnityObject(self._senderPic)
    self._senderPic = nil
  end
end

function New_UIMail:RefreshSenderPic(mailData)
  self:ClearOldSenderPic()
  local mailNpicCfg = mailData:GetSenderPic()
  if mailNpicCfg == nil then
    return
  end
  local picName = mailNpicCfg.file
  local senderPicType = MailEnum.SenderPicType.lPic
  if mailNpicCfg.skin_id > 0 then
    local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local resModelCfg = skinCtrl:GetResModel(mailNpicCfg.hero_id, mailNpicCfg.skin_id)
    senderPicType = 0 < mailNpicCfg.skin_type and MailEnum.SenderPicType.l2d or MailEnum.SenderPicType.lPic
    picName = resModelCfg.src_id_pic
  end
  if picName ~= nil and _loadSenderPicFunc[senderPicType] ~= nil then
    _loadSenderPicFunc[senderPicType](self, picName, mailNpicCfg.BG_pos)
  end
end

function New_UIMail:OnClickTreasureSelect()
  local isOn = not self.ctrl:GetOnlyShowTreasureMail()
  self:RefreshTreasureSelect(isOn)
end

function New_UIMail:RefreshTreasureSelect(isOn)
  if isOn then
    self.ui.img_treasureSelect:SetIndex(1)
  else
    self.ui.img_treasureSelect:SetIndex(0)
  end
  self.ctrl:SetOnlyShowTreasureMail(isOn)
  if self.lastSelectMailData then
    self.lastSelectMailData.isSelected = false
  end
  self.lastSelectMailData = nil
  self:RefreshMailList(self.ctrl:GetMailDataList())
  self:OpenFirstMail()
end

function New_UIMail:GetAllRewards()
  self.ctrl:ReqOneClickPickUp()
end

function New_UIMail:DeletAllReadedMail()
  AudioManager:PlayAudioById(1057)
  self.ctrl:ReqOneClickDelete()
end

function New_UIMail:SetUIMailHideCallback(callback)
  self.__hideCallback = callback
end

function New_UIMail:OnHide()
  self:OnCloseWin()
  if self.__hideCallback ~= nil then
    self.__hideCallback()
  end
  base.OnHide(self)
end

function New_UIMail:BackAction()
  self.mailContent:Delete()
  self:Delete()
end

function New_UIMail:OnClickReturn()
  UIUtil.OnClickBackByUiTab(self)
end

function New_UIMail:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnMailDiff, self._m_MailDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnMailDelete, self._m_MailDelete)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self._senderPic ~= nil then
    DestroyUnityObject(self._senderPic)
    self._senderPic = nil
  end
  if self.lastSelectMailData ~= nil then
    self.lastSelectMailData.isSelected = false
  end
  self.mailContent:Delete()
  self.ctrl:OnMailUIHide()
  base.OnDelete(self)
end

return New_UIMail
