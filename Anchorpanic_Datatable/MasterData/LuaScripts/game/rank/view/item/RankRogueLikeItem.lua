--[[ 
-----------------------------------------------------
@filename       : RankBaseItem
@Description    : 排行榜基础item
@date           : 2021-08-17 10:48:49
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.rank.view.item.RankRogueLikeItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    -- self.mImgFrame = self:getChildGO("mImgFrame"):GetComponent(ty.Image)
    -- self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.Image)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgTitle = self:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage)
    self.mImgIconBg = self:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)

    self.mGroupHead = self:getChildTrans("mGroupHead")
end

function setData(self, param)
    super.setData(self, param)

    if self.data.rank <= 3 then
        -- self.mImgIcon.gameObject:SetActive(true)
        self.mImgIcon:SetImg(string.format(UrlManager:getPackPath("rank/rank_icon_%s.png"), self.data.rank), true)
        self.mImgIconBg.gameObject:SetActive(true)
        self.mImgIconBg:SetImg(string.format(UrlManager:getPackPath("rank/rank_icon_bg_%s.png"), self.data.rank), true)
        self.mTxtRank.text = ""
    else
        self.mImgIcon:SetImg(UrlManager:getPackPath("rank/rank_icon_4.png"), true)
        self.mImgIconBg.gameObject:SetActive(false)
        -- self.mImgIcon.gameObject:SetActive(false)
        self.mTxtRank.text = self.data.rank
    end

    self.mTxtName.text = self.data.playerName
    self.mTxtScore.text = self:getScoreLab()

    if self.data.titleId > 0 then
        self.mImgTitle.gameObject:SetActive(true)
        self.mImgTitle:SetImg(UrlManager:getPlayerTitleUrl(self.data.titleId), false)
    else
        self.mImgTitle.gameObject:SetActive(false)
    end

    if (not self.mPlayerHead) then
        self.mPlayerHead = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHead:setData(self.data.avatar)
    self.mPlayerHead:setHeadFrame(self.data.frame)
    self.mPlayerHead:setParent(self.mGroupHead)
    self.mPlayerHead:setScale(0.5)
    self.mPlayerHead:setCallBack(self, self.__onClickHeadHandler)
end

-- 排行值展示（Override）
function getScoreLab(self)
    return self.data.rankVal
end

function __onClickHeadHandler(self, args)
    if (not self.data.isRobot) then
        GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_ROLE_INFO, self.data.playerId)
    end
end

function deActive(self)
    super.deActive(self)
    if (self.mPlayerHead) then
        self.mPlayerHead:poolRecover()
        self.mPlayerHead = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
