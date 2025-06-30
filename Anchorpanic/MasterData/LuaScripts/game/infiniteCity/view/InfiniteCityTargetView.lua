--[[ 
-----------------------------------------------------
@filename       : InfiniteCityTargetView
@Description    : 无限城目标奖励
@date           : 2021-03-09 19:57:12
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityTargetView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityTargetView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(infiniteCity.InfiniteCityTargetItem)

    self.mGroupTree = self:getChildTrans("mGroupTree")

    self:setGuideTrans("funcTips_infiniteCity_tabar", self:getChildTrans("mGroupFuncTipsTabar"))
end

--激活
function active(self)
    super.active(self)

    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateView, self)

    self:updateTab()
    self:addBubble()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_TARGET_DATA_UPDATE, self.updateView, self)
    self.tabBar:reset()
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
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.InfiniteCityTarget })
end

function updateTab(self)
    local list = {}
    list[1] = { page = 1, nomalLan = _TT(27111), nomalLanEn = "" }--"每日目标"
    list[2] = { page = 2, nomalLan = _TT(27112), nomalLanEn = "" }--"活动目标"
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTargetItem"), self.mGroupTree, self.setPage, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(1)
end


function setPage(self, cusPage)
    self.curPage = cusPage
    local list = infiniteCity.InfiniteCityManager:getTargetListByType(self.curPage)
    self:showTargetList(list)
end

function updateView(self)
    local list = infiniteCity.InfiniteCityManager:getTargetListByType(self.curPage)

    self:showTargetList(list, true)

    self:addBubble()
end

function showTargetList(self, list, isUpdate)
    table.sort(list, self.sortFun)
    if not isUpdate or self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
end

function sortFun(a, b)
    local aMsg = infiniteCity.InfiniteCityManager:getTargetMsgData(a.id)
    local bMsg = infiniteCity.InfiniteCityManager:getTargetMsgData(b.id)

    if aMsg.state == 1 and bMsg.state ~= 1 then
        return true
    elseif aMsg.state ~= 1 and bMsg.state == 1 then
        return false
    else
        if aMsg.state < bMsg.state then
            return true
        elseif aMsg.state > bMsg.state then
            return false
        else
            if a.id < b.id then
                return true
            end
        end
    end
    return false
end

function addBubble(self)
    for i = 1, 2 do
        self.tabBar:removeBubble(i)
        local isFlag = infiniteCity.InfiniteCityManager:getRedFlag(i)
        if isFlag then
            self.tabBar:addBubble(i, 0, 9)
            break
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
