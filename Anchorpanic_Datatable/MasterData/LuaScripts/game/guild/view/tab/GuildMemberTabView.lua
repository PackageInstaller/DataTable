module("guild.GuildMemberTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildMemberTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(guild.GuildMemberItem)

    self.mBtnQuit  = self:getChildGO("mBtnQuit")
end




function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MEMBER_PANEL,self.showPanel,self)
    
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MEMBER_PANEL,self.showPanel,self)
    
    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
end


function addAllUIEvent(self)
    self:addUIEvent(self.mBtnQuit,self.onBtnQuitClick)
end

function onBtnQuitClick(self)

    if guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94595))
        return
    end

    if guild.GuildManager:getIsJoinGuildWar() then
        gs.Message.Show(_TT(149195))
        return
    end

    UIFactory:alertMessge(_TT(94527), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_LEAVE_GUILD)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtNameTip"):GetComponent(ty.Text).text = _TT(48012)
    self:getChildGO("mTxtPostsTip"):GetComponent(ty.Text).text = _TT(94541)
    self:getChildGO("mTxtTimeTip"):GetComponent(ty.Text).text = _TT(94540)
    self:getChildGO("mTxtActiveTip"):GetComponent(ty.Text).text = _TT(94539)

    self:getChildGO("mTxtQuit"):GetComponent(ty.Text).text = _TT(94543)
end


function showPanel(self)
    self.guildInfo = guild.GuildManager:getGuildInfo()
    local list = self.guildInfo.members

    for i = 1,#list do
        list[i].tweenId = 2 + (i - 1) * 2.5
    end

    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

return _M