--[[ 
-----------------------------------------------------
@filename       : RankBaseItem
@Description    : 排行榜基础item
@date           : 2021-08-17 10:48:49
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.rank.view.item.RankBaseItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgColorBar = self:getChildGO("mImgColorBar"):GetComponent(ty.Image)
    self.mImgTitle = self:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage)
    self.mImgIconBg = self:getChildGO("mImgIconBg"):GetComponent(ty.AutoRefImage)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRank2 = self:getChildGO("mTxtRank2"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mGroupHead = self:getChildTrans("mGroupHead")
end

function setData(self, param)
    super.setData(self, param)

    if (not self.mPlayerHead) then
        self.mPlayerHead = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHead:setData(self.data.avatar)
    self.mPlayerHead:setHeadFrame(self.data.frame)
    self.mPlayerHead:setParent(self.mGroupHead)
    self.mPlayerHead:setCallBack(self, self.__onClickHeadHandler)
    if self.data.rank <= 3 then
        self.mImgIconBg:SetImg(UrlManager:getPackPath("rank/Infinitycity_icon_" .. self.data.rank .. ".png"), true)
        self.mImgIconBg.gameObject:SetActive(true)
        self.mTxtRank.text = self.data.rank
        self.mTxtRank2.text = ""
        local color = self.data.rank == 1 and "f7a04bff" or (self.data.rank == 2 and "45a5f5ff" or "68d7b3ff")
        self.mImgColorBar.color = gs.ColorUtil.GetColor(color)
        self.mImgColorBar.gameObject:SetActive(true)
    else
        self.mImgIconBg.gameObject:SetActive(false)
        self.mImgColorBar.gameObject:SetActive(false)
        self.mTxtRank.text = ""
        self.mTxtRank2.text = self.data.rank
        -- self.mPlayerHead:setIsShowFrame(false)
    end

    self.mTxtName.text = FilterWordUtil:filterTemp(self.data.playerName)
    self.mTxtScore.text = self:getScoreLab()
    self.mTxtDes.text = self.data.rankType == rank.RankConst.RANK_CYCLE and "评分：" or "层数："
    if self.data.titleId > 0 then
        self.mImgTitle.gameObject:SetActive(true)
        self.mImgTitle:SetImg(UrlManager:getPlayerTitleUrl(self.data.titleId), false)
    else
        self.mImgTitle.gameObject:SetActive(false)
    end

end

-- 排行值展示（Override）
function getScoreLab(self)
    if self.data.rankType == rank.RankConst.RANK_CYCLE then
        return self.data.rankVal
    elseif self.data.rankType == rank.RankConst.RANK_CLIMBTOWER then
        local dupVo = dup.DupClimbTowerManager:datas()[self.data.rankVal]
        return dupVo.layer
    else
        local dupVo = dup.DupClimbTowerManager:getDeepDupVo(self.data.rankVal)
        return dupVo.layer
    end
end

function __onClickHeadHandler(self, args)
    if self.data.playerId ~= "" then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.playerId })
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