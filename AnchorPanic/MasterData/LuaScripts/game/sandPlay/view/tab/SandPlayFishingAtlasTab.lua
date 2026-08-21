-- @FileName:   SandPlayFishingAtlasTab.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-21 10:35:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.sandPlay.view.SandPlayFishingAtlasTab", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("sandPlay/tab/SandPlayFishingAtlasTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    self.list = self:getChildTrans("list")
    self.mFishItem = self:getChildGO("mFishItem")
    self.mTextAtlasNum = self:getChildGO("mTextAtlasNum"):GetComponent(ty.Text)

    self.mImgTipsIcon = self:getChildGO("mImgTipsIcon"):GetComponent(ty.AutoRefImage)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)
    self.mText_Time = self:getChildGO("mText_Time"):GetComponent(ty.Text)
    self.mTextBait = self:getChildGO("mTextBait"):GetComponent(ty.Text)
    self.mTextFishNum = self:getChildGO("mTextFishNum"):GetComponent(ty.Text)
    self.mTextFishMinSize = self:getChildGO("mTextFishMinSize"):GetComponent(ty.Text)
    self.mTextFishMaxSize = self:getChildGO("mTextFishMaxSize"):GetComponent(ty.Text)
end

function active(self)
    self:refreshFishList()
end

function deActive(self)
    self:clearFishItem()
end

function initViewText(self)
    self.mTextTime.text = _TT(98328)
end

function addAllUIEvent(self)

end

function refreshFishList(self)
    self:clearFishItem()

    local fishList = sandPlay.SandPlayManager:getFishConfigDic()
    local data = {}
    local count, max_count = 0, 0
    for fish_id, fishConfig in pairs(fishList) do
        local fish_info = sandPlay.SandPlayManager:getFishingFishInfo(fishConfig.id)
        local _data = {config = fishConfig, info = fish_info}
        table.insert(data, _data)

        max_count = max_count + 1
        if fish_info.count > 0 then
            count = count + 1
        end
    end

    table.sort(data, function (a, b)
        return a.config.id < b.config.id
    end)

    for i = 1, #data do
        local item = SimpleInsItem:create(self.mFishItem, self.list, "SandPlayFishingAtlas_Item")
        item.mImgIcon = item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
        item.mImgSelect = item:getChildGO("mImgSelect")

        item.mImgIcon:SetImg(data[i].config:getHeadPath())

        item.mImgIcon:SetGray(data[i].info.count <= 0)

        item:addUIEvent(nil, function ()
            self:refreshSelect(data[i])
        end)

        self.mFishItemList[data[i].config.id] = item

    end

    self.mTextAtlasNum.text = _TT(98339) ..count .. "/" .. max_count

    self:refreshSelect(data[1])
end

function refreshSelect(self, fishData)
    for fishid, item in pairs(self.mFishItemList) do
        item.mImgSelect:SetActive(fishid == fishData.config.id)
    end

    self.mImgTipsIcon:SetImg(fishData.config:getBodyPath())
    self.mTextName.text = _TT(fishData.config.name)
    local timeStr = ""
    if fishData.config.appearing_timeType == 0 then
        timeStr = _TT(98323)
    elseif fishData.config.appearing_timeType == 1 then
        timeStr = _TT(98324)

    elseif fishData.config.appearing_timeType == 2 then
        timeStr = _TT(98325)

    elseif fishData.config.appearing_timeType == 3 then
        timeStr = _TT(98326)

    elseif fishData.config.appearing_timeType == 4 then
        timeStr = _TT(98327)
    end

    self.mText_Time.text = timeStr
    self.mTextBait.text = _TT(98329) .. _TT(fishData.config.likeBait)
    self.mTextFishNum.text = _TT(98330, fishData.info.count)
    self.mTextFishMinSize.text = _TT(98331, fishData.info.min_size * 0.01)
    self.mTextFishMaxSize.text = _TT(98332, fishData.info.max_size * 0.01)
end

function clearFishItem(self)
    if self.mFishItemList then
        for k, v in pairs(self.mFishItemList) do
            v:recover()
        end
    end

    self.mFishItemList = {}
end

return _M
