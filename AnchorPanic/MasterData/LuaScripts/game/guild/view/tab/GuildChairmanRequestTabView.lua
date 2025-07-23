module("guild.GuildChairmanRequestTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("guild/tab/GuildChairmanRequestTabView.prefab")

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
    self.mLyScroller:SetItemRender(guild.GuildRequestItem)

    self.mBtnRequest = self:getChildGO("mBtnRequest")

    self.mEmptyInfo = self:getChildGO("mEmptyInfo")
    self.mTipsInfo = self:getChildGO("mTipsInfo")
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_REQUEST_PANEL,self.showPanel,self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_REQUEST_PANEL,self.showPanel,self)


    if (self.mLyScroller) then
        self.mLyScroller:CleanAllItem()
    end
end


function addAllUIEvent(self)
    --self:addUIEvent(self.mBtnRequest,self.onBtnRequestClick)
end

-- function onBtnRequestClick(self)
--     GameDispatcher:dispatchEvent(EventName.OPEN_REQUEST_SETTING_PANEL)
-- end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtNameTip"):GetComponent(ty.Text).text = _TT(48012)
    self:getChildGO("mTxtLvTip"):GetComponent(ty.Text).text = _TT(50047)
    self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text).text = _TT(94518)
    --self:getChildGO("mTxtRequest"):GetComponent(ty.Text).text = _TT(94542)
end

function showPanel(self)
    self.guildInfo = guild.GuildManager:getGuildInfo()
    local list = self.guildInfo.apply_list

    for i = 1,#list do
        if list[i] then
            list[i].tweenId = 2 + (i - 1) * 2.5
        end
    end

    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end

    self.mEmptyInfo:SetActive(#list == 0)
    self.mTipsInfo:SetActive(#list > 0)
end

return _M