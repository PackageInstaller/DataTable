local UIEventWeChat = class("UIEventWeChat", UIBaseWindow)
local base = UIBaseWindow
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local UIItemPool = require("Game.CommonUI.UIItemPool")
local UINEventWeChatItem = require("Game.EventNoviceSign.UI.UINEventWeChatItem")
local UIEventWeChatExternalJumpItem = require("Game.EventNoviceSign.UI.UIEventWeChatExternalJumpItem")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local buriedPointIdList = {
  1024,
  1025,
  1026,
  1027
}

function UIEventWeChat:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.itemPool = UIItemPool.New(UINEventWeChatItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.externalJumpItemPool = UIItemPool.New(UIEventWeChatExternalJumpItem, self.ui.externalJumpItem)
  self.ui.externalJumpItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_GetReward, self, self.GetRewardClicked)
  UIUtil.AddButtonListener(self.ui.btn_CopyKey, self, self.CopyKeyClicked)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickInfo)
  UIUtil.AddButtonListener(self.ui.btn_QRCode, self, self.QRCodeClicked)
  self.WechatUpdata = BindCallback(self, self.__WechatUpdata)
  MsgCenter:AddListener(eMsgEventId.WechatUpdata, self.WechatUpdata)
end

function UIEventWeChat:InitWeChat(id)
  self.actId = id
  self.data = ConfigData.wechat_activity[id]
  self.actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if self.actFrameCtr == nil then
    error("微信关注活动页面获取不到活动控制器！")
  end
  self.states = self.actFrameCtr.wechatActivityElems[self.actId]
  self.itemPool:HideAll()
  for k, v in pairs(self.data.awardIds) do
    local item = self.itemPool:GetOne()
    local itemCfg = ConfigData.item[v]
    local itemNums = self.data.awardCounts[k]
    item:InitWeChatItem(itemCfg, v, itemNums, self.resloader)
  end
  self:RefreshQQGroupInfo(self.actId)
  self.ui.tex_Key.text = self.states.token
  self:RefreshNoviceSign()
  local actData = self.actFrameCtr:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Tickets, id)
  self._actData = actData
  self.ui.tex_Title.text = actData.name
  self._actName = actData.name
  DestroyUnityObject(self.bigImgGo)
  self.bigImgGo = nil
  local resPath = PathConsts:GetCharacterBigImgPrefabPath(self.data.res_name)
  self.resloader:LoadABAssetAsync(resPath, function(prefab)
    if IsNull(prefab) then
      return
    end
    self.bigImgGo = prefab:Instantiate(self.ui.heroHolder)
    local commonPicCtrl = self.bigImgGo:FindComponent(eUnityComponentID.CommonPicController)
    if commonPicCtrl ~= nil then
      commonPicCtrl:SetPosType("EventWeChat")
    else
      error("CommonPicController MISS , path: " .. resPath)
    end
  end)
  local endTime = actData:GetActivityEndTime()
  if endTime < 0 then
    self.ui.tex_TimeTips.transform.parent.gameObject:SetActive(false)
    return
  else
    self.ui.tex_TimeTips.transform.parent.gameObject:SetActive(true)
    self:_UpdEndTime()
    TimerManager:StopTimer(self.__endTimer)
    self.__endTimer = TimerManager:StartTimer(2, self._UpdEndTime, self, false)
  end
end

function UIEventWeChat:_UpdEndTime()
  local endTime = self._actData:GetActivityEndTime()
  local lastTime = math.max(math.floor(endTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(lastTime, false, true)
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_TimeTips:SetIndex(0, tostring(d), tostring(h), tostring(m))
end

function UIEventWeChat:GetRewardClicked()
  local actFrameCtr = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameCtr:CS_ACTIVITY_Wechat_Follow_Take(self.actId, BindCallback(self, self.RewardClickedBack))
end

function UIEventWeChat:RewardClickedBack()
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(self.data.awardIds, self.data.awardCounts):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true)
    window:AddAndTryShowReward(CRData)
  end)
end

function UIEventWeChat:__WechatUpdata()
  self.states = self.actFrameCtr.wechatActivityElems[self.actId]
  self:RefreshNoviceSign()
end

function UIEventWeChat:RefreshNoviceSign()
  if self.states.followed == false then
    self.ui.btn_CantGetReward:SetActive(true)
    self.ui.tex_CantGetReward:SetIndex(0)
    self.ui.btn_GetReward.gameObject:SetActive(false)
  elseif self.states.followed == true and self.states.redeemed == true then
    self.ui.btn_CantGetReward:SetActive(true)
    self.ui.tex_CantGetReward:SetIndex(1)
    self.ui.btn_GetReward.gameObject:SetActive(false)
  else
    self.ui.btn_CantGetReward:SetActive(false)
    self.ui.btn_GetReward.gameObject:SetActive(true)
  end
  if self.states.redeemed == false then
    self:RefreshItem(false)
  else
    self:RefreshItem(true)
  end
end

function UIEventWeChat:CopyKeyClicked()
  CS.UnityEngine.GUIUtility.systemCopyBuffer = self.ui.tex_Key.text
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

function UIEventWeChat:RefreshItem(hasGet)
  for i, v in ipairs(self.itemPool.listItem) do
    v:RefreshItem(hasGet)
  end
end

function UIEventWeChat:RefreshQQGroupInfo(activityId)
  local InfoList = ConfigData.wechat_activity_qq_jump[activityId]
  self.externalJumpItemPool:HideAll()
  for index, info in ipairs(InfoList) do
    if info.is_show then
      local item = self.externalJumpItemPool:GetOne()
      local isShow = info.is_show
      local qqGroupNumerStr = LanguageUtil.GetLocaleText(info.qq_des)
      local jumpLinkStr = LanguageUtil.GetLocaleText(info.jump_des)
      item:InitUIEventWeChatExternalJumpItem(isShow, qqGroupNumerStr, jumpLinkStr, buriedPointIdList[index])
    end
  end
end

function UIEventWeChat:OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventWeChatInformation, function(window)
    window:InitWeChatInfo(self._actName)
  end)
end

function UIEventWeChat:QRCodeClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventWeChatViewQRCode)
end

function UIEventWeChat:SetCloseCallback(callback)
end

function UIEventWeChat:OnDelete()
  self.itemPool:DeleteAll()
  self.itemPool = nil
  self.externalJumpItemPool:DeleteAll()
  self.externalJumpItemPool = nil
  DestroyUnityObject(self.bigImgGo)
  self.bigImgGo = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.WechatUpdata, self.WechatUpdata)
  TimerManager:StopTimer(self.__endTimer)
  base.OnDelete(self)
end

return UIEventWeChat
