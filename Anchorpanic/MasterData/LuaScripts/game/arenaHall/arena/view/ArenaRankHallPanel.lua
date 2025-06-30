--[[ 
-----------------------------------------------------
@filename       : ***
@Description    : ***
@date           : ***
@Author         : sllive
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('arena.ArenaRankHallPanel', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaRankHallPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("common_bg_4108.jpg", false)
end
--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function initTabBar(self)
end

-- 初始化
function configUI(self)
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnReward = self:getChildGO("mBtnReward")
    self.mImgSelect = self:getChildTrans("mImgSelect")
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList[1] = TabData:poolGet():setData(178, 70, { arena.getRanHallTabName(arena.RankHallTabType.RANK_LIST), _TT(164) }, "common_2201.png", "common_3219.png", 24, nil, arena.RankHallTabType.RANK_LIST, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40}, { 25, 0, 0, 15, 25, 0, 0, 40})
    self.tabDataList[2] = TabData:poolGet():setData(178, 70, { arena.getRanHallTabName(arena.RankHallTabType.RANK_AWARD), _TT(166) }, "common_2201.png", "common_3219.png", 24, nil, arena.RankHallTabType.RANK_AWARD, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40}, { 25, 0, 0, 15, 25, 0, 0, 40})
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[arena.RankHallTabType.RANK_LIST] = arena.ArenaRankPanel
    self.tabClassDic[arena.RankHallTabType.RANK_AWARD] = arena.ArenaAwardPanel
    return self.tabClassDic
end

function setMoneyBar(self)
    
end

--激活
function active(self)
    super.active(self)
    self.curView = 1
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    -- MoneyManager:setMoneyTidList()
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
    -- self:addUIEvent(self.aa,self.onClick)

    self:addUIEvent(self.mBtnRank, self.onClickRank)
    self:addUIEvent(self.mBtnReward, self.onClickReward)
end

function isHorizon(self)
    return false
end

function onClickRank(self)
    if self.curView == 1 then
        return
    end
    self.curView = 1
    self:changeView()
end

function onClickReward(self)
    if self.curView == 2 then
        return
    end
    self.curView = 2
    self:changeView()
end

function changeView(self)
    if self.curView == 1 then
        self:setType(arena.RankHallTabType.RANK_LIST)
        self:doTween(self.mBtnRank.transform.anchoredPosition.x)
    else
        self:setType(arena.RankHallTabType.RANK_AWARD)
        self:doTween(self.mBtnReward.transform.anchoredPosition.x)
    end
end

function doTween(self, lposX)
    TweenFactory:move2PosXEx(self.mImgSelect, lposX, 0.3)
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    if (self.curPage == cusTabType) then
        self:subActive()
        return
    end

    self:setPage(cusTabType)
    local instance = self:getClassInsByType(cusTabType)
    for type, classIns in pairs(self.m_classInsDic) do
        if (type ~= cusTabType) then
            if (not classIns:getIsCache()) then
                classIns:setUICache(false)
                classIns:__deActive()
            end
        end
    end
    if cusArgs then
        self.args[self.curPage] = cusArgs
    elseif not self.args[self.curPage] then
        self.args[self.curPage] = self:getActiveArgs()
    end
    -- if (not instance:getActive()) then
    instance:setUICache(true)
    instance:__active(self.args[self.curPage])
    -- end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
