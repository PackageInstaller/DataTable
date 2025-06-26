-- @FileName:   GuildBossSeasonAwardItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-08 17:03:39
-- @Copyright:   (LY) 2023 雷焰网络

module("guild.GuildBossSeasonAwardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)

    self.mPropsGridList = {}
end

function setData(self, param)
    super.setData(self, param)

    self:recoverAllGrid()
    local list = self.data:getAwardlist()
    if not table.empty(list) then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.mContent, scale = 0.63, showUseInTip = true})
            table.insert(self.mPropsGridList, propsGrid)
        end
    end

    local isOne = self.data.minRank == self.data.maxRank
    self.mGroupRank:SetActive(isOne)
    self.mTxtRank.gameObject:SetActive(not isOne)

    if isOne then
        self.mTxtRankBig.text = self.data.minRank

        for i = 1, 3 do
            self:getChildGO("mTop" .. i):SetActive(self.data.minRank == i and self.data.maxRank == i)
        end

        local color
        if self.data.minRank == 1 then
            color = "ffc66dff"
        elseif self.data.minRank == 2 then
            color = "D376f9ff"
        elseif self.data.minRank == 3 then
            color = "6dbcffff"
        end

        self.mImgColor.color = gs.ColorUtil.GetColor(color)
    else
        if self.data.maxRank > 0 then
            self.mTxtRank.text = string.format("%s ~ %s", self.data.minRank, self.data.maxRank)
        else
            self.mTxtRank.text = string.format("%s~", self.data.minRank)
        end
    end
end

function recoverAllGrid(self)
    if self.mPropsGridList then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M
