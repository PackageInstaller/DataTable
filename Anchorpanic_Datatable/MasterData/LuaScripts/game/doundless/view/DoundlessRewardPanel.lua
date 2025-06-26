module("doundless.DoundlessRewardPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("doundless/DoundlessAwardPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("奖励")
    self:setBg("guild_bg_blur.jpg", false, "guild")
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
    MoneyManager:setMoneyTidList({ })
end

function getTabClass(self)
    self.tabClassDic[doundless.WarType.Low] = doundless.DoundlessLowRankTabView
    self.tabClassDic[doundless.WarType.Middle] = doundless.DoundlessMiddleRankTabView
    self.tabClassDic[doundless.WarType.Hight] = doundless.DoundlessHighRankTabView
    self.tabClassDic[doundless.WarType.Promote] = doundless.DoundlessPromoteTabView
    self.tabClassDic[doundless.WarType.Warup] = doundless.DoundlessWarupgradeTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(doundless.getDoundlessRewardList()) do
        table.insert(self.tabDataList, {type = v.page, content = {v.nomalLan}, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon})
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

return _M