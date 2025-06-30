--[[ 
-----------------------------------------------------
@filename       : WelfareOptPanel
@Description    : 福利相关页面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.WelfareOptPanel", Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("welfareOpt/WelfareOptPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52015))
    self:setBg("common_bg_017.jpg", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

function getTabViewParent(self)
    return self:getChildTrans("ViewContent")
end

-- 初始化
function configUI(self)
    super.configUI(self)
end

function getTabDatas(self)
    self.tabDataList = {}
    local list = welfareOpt.WelfareOptConst:getTabList()
    for _, vo in pairs(list) do
        table.insert(self.tabDataList, { type = vo.page, content = { vo.nomalLan }, nomalIcon = vo.nomalIcon, selectIcon = vo.nomalIcon })
    end
    return self.tabDataList
end

--激活
function active(self, args)
    super.active(self, args)
    welfareOpt.WelfareOptOpenBetaManager:addEventListener(welfareOpt.WelfareOptOpenBetaManager.ON_FIVE_RESET, self.close, self)
    -- if args.subType then
    --     self:setPage(args.subType)
    -- end
    self:updateTabRed(nil)
    self:updateGuide()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    welfareOpt.WelfareOptOpenBetaManager:removeEventListener(welfareOpt.WelfareOptOpenBetaManager.ON_FIVE_RESET, self.close, self)
    -- GameDispatcher:removeEventListener(EventName.UPDATE_WELFAREOPT_FLAG, self.__onUpdateWelfareOptFlagHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
end

function setTabBar(self)
    if #self:getTabDataList() <= 0 then
        return
    end
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self:getChildTrans("TabBarNode"), self.onClickMenuHandler, self, nil, "TabViewTabBar")
    self.tabBar:setData(self:getTabDataList())
end

function addBubble(self, tabType, x, y)
    self.tabBar:addBubble(tabType, x or 90, y or 20)
end

function updateTabImg(self)
    for id, _ in pairs(self.tabBar.btnMap) do
        local item = self.tabBar.btnMap[id]
        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(
        UrlManager:getPackPath("welfareOpt/welfareOpt_icon_" .. id .. ".png"),
        false
        )
    end
end

function updateGuide(self)
    for type, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_WelfareOpt_" .. type, item:getChildTrans("mBtnNomal"))
    end
end

function updateTabRed(self, index)
    if index == nil then
        for id, _ in pairs(self.tabBar.btnMap) do
            self:updateBubbleView(id)
        end
    else
        if self.tabBar.btnMap[index] == nil then
            return
        end
        self:updateBubbleView(index)
    end
end

function updateBubbleView(self, index)
    local isBubble = welfareOpt.WelfareOptManager:getRedData(index)
    if (isBubble) then
        self:addBubble(index, 95, 14)
    else
        self:removeBubble(index)
    end
end

function setPage(self, cusType)
    super.setPage(self, cusType)
    -- if cusType == welfareOpt.WelfareOptConst.WELFAREOPT_NOVICEGOAL then
    --     self:setBg("WelfareOptNovice_bg.png", false, "welfareOpt")
    if cusType == welfareOpt.WelfareOptConst.WELFAREOPT_SIGN then
        self:setBg("welfareOptSignBg_01.jpg", false, "welfareOpt")
    elseif cusType == welfareOpt.WelfareOptConst.WELFAREOPT_SEVENLOADING then
        self:setBg("sevenDayLogin_bg.png", false, "welfareOpt")
    elseif cusType == welfareOpt.WelfareOptConst.WELFAREOPT_UP then
        self:setBg("activity_up_bg.jpg", false, "mainActivity")
    elseif cusType == welfareOpt.WelfareOptConst.WELFAREOPT_RAFFLE then
        self:setBg("raffle_1.jpg", false, "welfareOpt")
    elseif cusType == welfareOpt.WelfareOptConst.WELFAREOPT_HOLIDAY then
        self:setBg("holiday_bg.jpg", false, "holiday")
    elseif cusType == welfareOpt.WelfareOptConst.WELFAREOPT_TAPTAP then
       self:setBg("taptap_bg_01.jpg", false, "taptap")
    end
end

function getTabClass(self)
    local list = welfareOpt.WelfareOptConst:getTabList()
    for _, vo in pairs(list) do
        self.tabClassDic[vo.page] = vo.view
    end
    return self.tabClassDic
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]