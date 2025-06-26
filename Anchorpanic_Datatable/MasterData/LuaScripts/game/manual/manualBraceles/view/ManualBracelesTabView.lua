module("manual.ManualBracelesTabView", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualMonsterPanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("烙痕")
    self:setBg("manual_bg.jpg", false, "manual")
    self:setUICode(LinkCode.Manual)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end
-- 初始化
function configUI(self)
    super.configUI(self)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    self:updateNew()
end
-- 非激活
function deActive(self)
    super.deActive(self)
    self.curPage = nil
end

function getTabDatas(self)
    self.tabDataList = {}
    for i, vo in ipairs(manual.getTabList(manual.ManualType.SolderingMark)) do
        self.tabDataList[vo.page] = { type = vo.page, content = { vo.nomalLan }, nomalIcon = manual.getPageIcon(vo.page), selectIcon = manual.getPageIcon(vo.page), colorType = vo.type }
    end
    return self.tabDataList
end

function getTabClass(self)
    for _, vo in ipairs(manual.getTabList(manual.ManualType.SolderingMark)) do
        self.tabClassDic[vo.page] = manual.ManualBracelesTabSubView
    end
    return self.tabClassDic
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function setType(self, cusTabType)
    manual.ManualManager:setLastIndex(cusTabType)
    super.setType(self, cusTabType)
end

function updateNew(self)
    for _, vo in ipairs(manual.getTabList(manual.ManualType.SolderingMark)) do
        if manual.ManualManager:getBracelesNewStateByType(vo.colorType) then
            self:addBubble(vo.page)
        else
            self:removeBubble(vo.page)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]