module('subPack.SubDownLoadPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("subPack/SubDownLoadPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1000, 540)
    self:setTxtTitle("资源下载中心")
end

-- 初始化数据
function initData(self)
    self.mTabItemList = {}
    self.mSelectTagIndex = nil
end

-- 初始化
function configUI(self)
    self.mRectContent = self:getChildGO("Content"):GetComponent(ty.RectTransform)
    self.mSubDownLoadTabItem = self:getChildGO("SubDownLoadTabItem")

    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(subPack.SubDownLoadItem)

    self.mBtnAwardPreview = self:getChildGO("mBtnAwardPreview")
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:udpateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearTabItemList()
end

function initViewText(self)
    -- self.mTxtEmptyTip.text = _TT(566) --"暂无记录"
    self:setBtnLabel(self.mBtnAwardPreview, 0, "奖励预览")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAwardPreview, self.openPreviewAwardPanel)
end

function udpateView(self)
    self:clearTabItemList()
    
    self.mFormatAssetDic = {}
    self.mFormatAssetIndexList = {}
    local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
    for moduleType in pairs(assetsDic) do
        local data = assetsDic[moduleType]
        if (data.tag_index > 0) then
            if(not self.mFormatAssetDic[data.tag_index])then
                self.mFormatAssetDic[data.tag_index] = {}
                table.insert(self.mFormatAssetIndexList, data.tag_index)
            end
            table.insert(self.mFormatAssetDic[data.tag_index], data)
        end
    end

    for i = 1, #self.mFormatAssetIndexList do
        local tag_index = self.mFormatAssetIndexList[i]
        for moduleType in pairs(assetsDic) do
            local data = assetsDic[moduleType]
            if (data.tag_index == tag_index) then
                local item = SimpleInsItem:create(self.mSubDownLoadTabItem, self.mRectContent)
                item:getChildGO("mTxtTip"):GetComponent(ty.Text).text = data.tag_title
                item:addUIEvent(nil, function()
                    self:updateScrollView(data.tag_index)
                end)
                table.insert(self.mTabItemList, {tag_index = tag_index, item = item})

                if(not self.mSelectTagIndex)then
                    self:updateScrollView(data.tag_index)
                end
                break
            end
        end
    end
end

function updateScrollView(self, tag_index)
    self.mSelectTagIndex = tag_index
    -- 页签选中状态
    for _, itemData in pairs(self.mTabItemList) do
        itemData.item:getChildGO("mImgBg"):SetActive(itemData.tag_index == tag_index)
    end

    local dataList = self.mFormatAssetDic[tag_index]
    if(dataList and #dataList > 0)then
        self.mScroller.DataProvider = dataList
    else
        self.mScroller.DataProvider = {}
    end
end

function clearTabItemList(self)
    for _, itemData in pairs(self.mTabItemList) do
        itemData.item:poolRecover()
    end
    self.mTabItemList = {}
    self.mSelectTagIndex = nil
end

function openPreviewAwardPanel(self)
    local giftId = sysParam.SysParamManager:getValue(SysParamType.DOWN_LOAD_GIFT_ID)
    GameDispatcher:dispatchEvent(EventName.OPEN_SUB_DOWNLOAD_AWARD_PANEL, { giftId = giftId, title = 341 })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
