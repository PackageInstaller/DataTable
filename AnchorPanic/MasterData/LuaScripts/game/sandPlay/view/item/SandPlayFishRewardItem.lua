-- @FileName:   SandPlayFishRewardItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-20 14:48:32
-- @Copyright:   (LY) 2023 雷焰网络

module("sandPlay.SandPlayFishRewardItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)
    self.mTextNoGet = self:getChildGO("mTextNoGet"):GetComponent(ty.Text)
    self.mFishContent = self:getChildTrans("mFishContent")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mImgNoGet = self:getChildGO("mImgNoGet")
    self.mImgGeted = self:getChildGO("mImgGeted")

    self.mFishItem = self:getChildGO("mFishItem")
end

function setData(self, data)
    super.setData(self, data)

    self.mTextDesc.text = _TT(data.config.name)

    self:clearFish()
    local fish_list = self.data.config.fish_list
    for i = 1, #fish_list do
        local item = SimpleInsItem:create(self.mFishItem, self.mFishContent, "SandPlayFishingRewardFish_Item")
        item.mImgIcon = item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

        local fish_id = fish_list[i]
        local fishConfigVo = sandPlay.SandPlayManager:getFishConfigVo(fish_id)
        if fishConfigVo then
            item.mImgIcon:SetImg(fishConfigVo:getHeadPath())

            local fish_info = sandPlay.SandPlayManager:getFishingFishInfo(fish_id)
            item.mImgIcon:SetGray(fish_info.count <= 0)
        end

        table.insert(self.mFishItemList, item)
    end

    self:recoverAllGrid()
    local list = self.data.config.reward
    if not table.empty(list) then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({tid = vo[1], num = vo[2], parent = self.mAwardContent, showUseInTip = true})
            table.insert(self.mPropsGridList, propsGrid)
        end
    end

    self.mBtnGet:SetActive(self.data.getState == 0)
    self.mImgNoGet:SetActive(self.data.getState == 1)
    self.mImgGeted:SetActive(self.data.getState == 2)

    self.mTextNoGet.text = _TT(98967)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, function()
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_ONREQ_COLLECTAWARD, self.data.config.id)
    end)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    self:clearFish()
    self:recoverAllGrid()
end

function recoverAllGrid(self)
    if self.mPropsGridList then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

function clearFish(self)
    if self.mFishItemList then
        for k, v in pairs(self.mFishItemList) do
            v:recover()
        end
    end

    self.mFishItemList = {}
end

return _M
