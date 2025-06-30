--[[ 
-----------------------------------------------------
@Description    : 联盟团战结算界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guildWar.GuildWarGuildResultPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarGuildResultPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- 初始化数据
function initData(self)
    self.itemList = {}
    self.mGroupItems = {}
    self.mSnList = {}
end

function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mGroupPlayback = self:getChildGO("mGroupPlayback")
    self.mWinInfo = self:getChildGO("mWinInfo")
    self.mLoseInfo = self:getChildGO("mLoseInfo")
    self.mDrawInfo = self:getChildGO("mDrawInfo")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCurPoint = self:getChildGO("mTxtCurPoint"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.mTxtLv2 = self:getChildGO("mTxtLv2"):GetComponent(ty.Text)
    self.mImgIcon2 = self:getChildGO("mImgIcon2"):GetComponent(ty.AutoRefImage)
    self.mTxtCurPoint2 = self:getChildGO("mTxtCurPoint2"):GetComponent(ty.Text)
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mBtnClose = self:getChildGO("mBtnClose")
end

function active(self, args)
    super.active(self, args)
    self.mLogInfo = args.log
    self.isCanClose = false

    self:showPanel()
    self:setTimeout(1.5, function()
        self.isCanClose = true
    end)
end

function deActive(self)
    super.deActive(self)
    self:clearSnList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTips.text = _TT(149157)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
    end
end

function showPanel(self)
    self.state = self.mLogInfo.result
    self.mWinInfo:SetActive(self.state == guildWar.ResultState.WIN)
    self.mLoseInfo:SetActive(self.state == guildWar.ResultState.LOSE)
    self.mDrawInfo:SetActive(self.state == guildWar.ResultState.DRAW)

    self.mTxtName.text = self.mLogInfo.self_name
    self.mTxtLv.text =_TT(1361).. self.mLogInfo.self_lv
    self.mImgIcon:SetImg(UrlManager:getIconPath(guild.GuildManager:getIconDataById(self.mLogInfo.self_icon).icon), false)
    self.mTxtCurPoint.text = _TT(149155) .. self.mLogInfo.self_day_point
    self.mTxtName2.text = self.mLogInfo.enemy_name
    self.mTxtLv2.text = _TT(1361) .. self.mLogInfo.enemy_lv
    self.mImgIcon2:SetImg(UrlManager:getIconPath(guild.GuildManager:getIconDataById(self.mLogInfo.enemy_icon).icon),
        false)
    self.mTxtCurPoint2.text = _TT(149155) .. self.mLogInfo.enemy_day_point
    self.mTxtPoint.text = _TT(149192,self.mLogInfo.old_point,self.mLogInfo.add_point) 
    self.mTxtRank.text = _TT(149159,self.mLogInfo.rank)
end

return _M
