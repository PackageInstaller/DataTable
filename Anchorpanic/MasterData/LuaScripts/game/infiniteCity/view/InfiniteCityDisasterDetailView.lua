--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDisasterDetailView
@Description    : ***
@date           : ***
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityDisasterDetailView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityDisasterDetailView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    -- 排序类型1-升序，2降序
    self.sortType = 2
end

-- 初始化
function configUI(self)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(infiniteCity.InfiniteCityDisasterDetailItem)

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnSort = self:getChildGO("mBtnSort")
    self.mImgArrow = self:getChildTrans("mImgArrow")
end

--激活
function active(self, args)
    super.active(self, args)

    self.mDupId = args
    self.mDupData = infiniteCity.InfiniteCityManager:getDupBaseData(self.mDupId)
    local list = self.mDupData:getDisasterList()

    self.disasterDataList = {}
    for i, v in ipairs(list) do
        local data = infiniteCity.InfiniteCityManager:getDisasterBaseData(v)
        table.insert(self.disasterDataList, data)
    end
    table.sort(self.disasterDataList, self.sortUp)


    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnSort, self.onClickSort)
end

function updateView(self)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = self.disasterDataList
    else
        self.mScroller:ReplaceAllDataProvider(self.disasterDataList)
    end
end

function updateSortBtn(self)
    if self.sortType == 2 then
        gs.TransQuick:SetRotation(self.mImgArrow, 0, 0, 0)
        self:setBtnLabel(self.mBtnSort, 27143, "升序")
    else
        gs.TransQuick:SetRotation(self.mImgArrow, 0, 0, 180)
        self:setBtnLabel(self.mBtnSort, 27144, "降序")
    end
end

function onClickSort(self)
    if self.sortType == 1 then
        self.sortType = 2
        table.sort(self.disasterDataList, self.sortUp)
    else
        self.sortType = 1
        table.sort(self.disasterDataList, self.sortDown)

    end
    self:updateSortBtn()
    self:updateView()
end

function sortUp(a, b)
    if a.lvl < b.lvl then
        return true
    elseif a.lvl < b.lvl then
        return false
    elseif a.id < b.id then
        return true
    else
        return false
    end
end

function sortDown(a, b)
    if a.lvl > b.lvl then
        return true
    elseif a.lvl < b.lvl then
        return false
    elseif a.id < b.id then
        return true
    else
        return false
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
