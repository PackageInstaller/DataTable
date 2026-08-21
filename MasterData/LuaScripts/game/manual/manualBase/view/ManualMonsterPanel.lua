--[[ 
-----------------------------------------------------
@filename       : ManualMonsterPanel
@Description    : 图鉴怪物面板
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualMonsterPanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(70004))
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
    for i, vo in ipairs(manual.getTabList()) do
        self.tabDataList[vo.page] = { type = vo.page, content = { vo.nomalLan }, nomalIcon = manual.getPageIcon(vo.page), selectIcon = manual.getPageIcon(vo.page) }
    end
    return self.tabDataList
end

function getTabClass(self)
    for _, vo in ipairs(manual.ManualManager:getMonsterTabList()) do
        self.tabClassDic[vo.type] = manual.ManualMonsterBaseView
    end
    return self.tabClassDic
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function updateNew(self)
    for _, vo in ipairs(manual.ManualManager:getMonsterTabList()) do
        if manual.ManualManager:getNewStateByType(vo.type) then
            self:addBubble(vo.type)
        else
            self:removeBubble(vo.type)
        end
    end
end

-- 点击菜单
function onClickMenuHandler(self, cusTabType)
    manual.ManualManager:setLastIndex(cusTabType)
    self:setType(cusTabType)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]