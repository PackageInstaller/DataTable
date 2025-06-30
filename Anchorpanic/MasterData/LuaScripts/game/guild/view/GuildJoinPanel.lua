
module("guild.GuildJoinPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("guild/GuildJoinPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("联盟")
    self:setBg("guild_bg_blur.jpg", false, "guild")

end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.showTabType = 2
end

function setTabBar(self)
    super.setTabBar(self)

    self:setGuideTrans("funcTips_guide_GuildJoinTabItem_1", self.tabBar:getItemByPage(1).m_trans)
    self:setGuideTrans("funcTips_guide_GuildJoinTabItem_2", self.tabBar:getItemByPage(2).m_trans)
end

-- 初始化
function configUI(self)
    super.configUI(self)
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.WAIT_GUILD_APPLY,self.onWaitHandler,self)
    MoneyManager:setMoneyTidList({ })

end

function getTabClass(self)
    self.tabClassDic[guild.GuildJoinType.Join] = guild.GuildJoinTabView
    self.tabClassDic[guild.GuildJoinType.Create] = guild.GuildCreateTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(guild.getGuildJoinList()) do
        table.insert(self.tabDataList, {type = v.page, content = {v.nomalLan}, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon})
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.WAIT_GUILD_APPLY,self.onWaitHandler,self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })

end

function onWaitHandler(self,args)
    if args.guild_info.uid ~= "0" then
        self:close()
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
    end
end

return _M

