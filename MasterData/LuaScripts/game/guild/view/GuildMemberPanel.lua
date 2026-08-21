
module("guild.GuildMemberPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("guild/GuildMemberPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0

isAdapta = 1--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(94544))
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
    self.tabClassDic[guild.GuildMemberType.Member] = guild.GuildMemberTabView 
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(guild.getGuildMemberList()) do
        table.insert(self.tabDataList, { type = v.page, content = { v.nomalLan }, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon })
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end


return _M