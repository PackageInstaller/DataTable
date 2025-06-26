module('braceletsCommunicate.BraceletsCommunicateTargetItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgHeadBgPublic = self:getChildGO("mImgHeadBgPublic")
    self.mImgHeadBg = self:getChildGO("mImgHeadBg")
    self.mBgPublic = self.mImgHeadBgPublic:GetComponent(ty.Image)
    self.mImgHeadPublic = self:getChildGO("mImgHeadPublic"):GetComponent(ty.Image)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mTxtChatName = self:getChildGO("mTxtChatName"):GetComponent(ty.Text)
    self.mImgFavor = self:getChildGO("mImgFavor")
    self.mTxtFavorLv = self:getChildGO("mTxtFavorLv"):GetComponent(ty.Text)
    self.mTxtSimpleMessage = self:getChildTrans("mTxtSimpleMessage"):GetComponent(ty.Text)
    self:addOnClick(self:getChildGO("mClickArea"), self.onClickItem)
    self.mRedType1 = self:getChildGO("mRedType1")
    self.mRedType2 = self:getChildGO("mRedType2")
end

function setData(self, param)
    super.setData(self, param)
    self:updateView()
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_TARGET_INFO, self.refreshInfo, self)
end

function refreshInfo(self, targetId)
    if targetId == self.data.targetId then 
        self:updateView()
    end
end

function updateView(self)
    local isSelect = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget() == self.data.targetId
    self.mImgSelect:SetActive(isSelect)
    local color = isSelect and "ffffffff" or "202226ff"
    self.mTxtChatName.color = gs.ColorUtil.GetColor(color)

    self.mImgHeadBg:SetActive(self.data.type == 1)
    self.mImgHeadBgPublic:SetActive(self.data.type == 2)
    if(self.data.type == 1) then 
        self.mTxtChatName.text = hero.HeroManager:getHeroVoByTid(self.data.heroList[1]).name
        self.mImgHead:SetImg(UrlManager:getHeroHeadUrl(self.data.heroList[1]), true)
    else
        self.mTxtChatName.text = self.data.name
        if isSelect then 
            self.mBgPublic.color = gs.ColorUtil.GetColor("333f54ff")
            self.mImgHeadPublic.color = gs.ColorUtil.GetColor("c6d4e1ff")
        else
            self.mBgPublic.color = gs.ColorUtil.GetColor("c4cddaff")
            self.mImgHeadPublic.color = gs.ColorUtil.GetColor("7a8290ff")
        end
    end
    local msgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(self.data.targetId)
    local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
    local nowTalkVo = self.data:getTalkVo(newestSegId, newestTalkId)
    local hasRead = braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(self.data.targetId)
    if (nowTalkVo.nextId[1] ~= 0 or not hasRead) and not isSelect then 
        self.mRedType1:SetActive(nowTalkVo.talkId == 1)
        self.mRedType2:SetActive(nowTalkVo.talkId ~= 1)
    else
        self.mRedType1:SetActive(false)
        self.mRedType2:SetActive(false)
    end
    local txt = ""
    local targetIndex = 1
    if (not hasRead and nowTalkVo.reward == 0) or (index == 2) then   --未读且有无奖励/对话结束
        targetIndex = 2
    end

    local talkList = msgVo:getTalkList(newestSegId)
    for i = targetIndex, #talkList do 
        local talkId = talkList[i]
        if self.data:getTalkMsg(newestSegId, talkId) ~= "" then 
            txt = string.substitute(self.data:getTalkMsg(newestSegId, talkId), role.RoleManager:getRoleVo():getPlayerName()) 
            break
        end
    end
    if string.find(txt, ".png") ~= nil then 
        txt = "[图片]"
    end
    gs.TextExtension.SetTextWithElipsis(self.mTxtSimpleMessage, txt)
end

function onClickItem(self)
    GameDispatcher:dispatchEvent(EventName.CHANGE_COMMUNICATE_TARGET, self.data.targetId)
end

function deActive(self)
    super.deActive(self)
    RedPointManager:remove(self.UITrans)
    GameDispatcher:removeEventListener(EventName.UPDATE_TARGET_INFO, self.refreshInfo, self)
end

return _M