--[[ 
-----------------------------------------------------
@filename       : RankRewardItem
@Description    : 排行榜奖励item
@date           : 2021-08-17 15:31:53
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.rank.view.item.RankRewardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgIcon2 = self:getChildGO("mImgIcon2"):GetComponent(ty.AutoRefImage)
    self.mImgIconBg2 = self:getChildGO("mImgIconBg2"):GetComponent(ty.AutoRefImage)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.Content = self:getChildTrans("Content")

    self.mPropsGridList = {}
end

function setData(self, param)
    super.setData(self, param)

    local minRank = self.data.leftRank
    local maxRank = self.data.rightRank 
    local myRank = rank.RankManager:getMyRank() or 9999

    if minRank == maxRank then
        self.mImgIcon2:SetImg(string.format(UrlManager:getPackPath("rank/rank_icon_%s.png"), maxRank), false)
        self.mImgIconBg2.gameObject:SetActive(true)
        self.mImgIconBg2:SetImg(string.format(UrlManager:getPackPath("rank/rank_icon_bg_%s.png"), self.data.leftRank), true)
        self.mTxtRank.text = ""
    else
        self.mImgIcon2:SetImg(UrlManager:getPackPath("rank/rank_icon_4.png"), true)
        self.mImgIconBg2.gameObject:SetActive(false)
        if maxRank == 0 then
            self.mTxtRank.text = _TT(48027, minRank)
        else
            self.mTxtRank.text = minRank .. "-" .. maxRank
        end
    end

    if (minRank <= myRank and myRank <= maxRank) then

    end

    self:recoverAllGrid()
    local list = AwardPackManager:getAwardListById(self.data.rewards)
    for i, vo in ipairs(list) do
        local propsGrid = PropsGrid:create(self.Content, { vo.tid, vo.num }, 0.62)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function recoverAllGrid(self)
    for i = 1, #self.mPropsGridList do
        local propsGrid = self.mPropsGridList[i]
        propsGrid:poolRecover()
    end
    self.mPropsGridList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
