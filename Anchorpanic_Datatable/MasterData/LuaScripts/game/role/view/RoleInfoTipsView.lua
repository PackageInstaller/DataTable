--[[ 
-----------------------------------------------------
@filename       : RoleInfoTipsView
@Description    : 非玩家信息面板弹窗
@date           : 2022-08-08 11:32:40
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('role.RoleInfoTipsView', Class.impl(View))
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/tab/RoleInfoTipsView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end
-- 初始化数据
function initData(self)
    --战员卡片列表
    self.mHeroCardList = {}
    --当前展示的id
    self.mCurShowId = 0
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnCopy = self:getChildGO("mBtnCopy")
    self.mBtnApply = self:getChildGO("mBtnApply")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnGuild = self:getChildGO("mBtnGuild")
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mHeadGrid = self:getChildTrans("mHeadGrid")
    self.mHeroList = self:getChildTrans("mHeroList")
    self.mBtnAddBlack = self:getChildGO("mBtnAddBlack")
    self.mFriendScroll = self:getChildGO("mFriendScroll")
    self.mTxtUID = self:getChildGO("mTxtUID"):GetComponent(ty.Text)
    self.mTxtHeroNum = self:getChildGO("mTxtHeroNum"):GetComponent(ty.Text)
    self.mTxtHeroSum = self:getChildGO("mTxtHeroSum"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtCurLevel = self:getChildGO("mTxtCurLevel"):GetComponent(ty.Text)
    self.mTxtPlayerlv = self:getChildGO("mTxtPlayerlv"):GetComponent(ty.Text)
    self.mTxtLevelName = self:getChildGO("mTxtLevelName"):GetComponent(ty.Text)
    self.mTxtTowerName = self:getChildGO("mTxtTowerName"):GetComponent(ty.Text)
    self.mTxtSignature = self:getChildGO("mTxtSignature"):GetComponent(ty.Text)
    self.mTxtPlayerName = self:getChildGO("mTxtPlayerName"):GetComponent(ty.Text)
    self.mTxtFashionPro = self:getChildGO("mTxtFashionPro"):GetComponent(ty.Text)
    self.mTxtTowerStage = self:getChildGO("mTxtTowerStage"):GetComponent(ty.Text)
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)
    self.mImgContentBg = self:getChildGO("mImgContentBg"):GetComponent(ty.AutoRefImage)
    self.mTxtAchievementNum = self:getChildGO("mTxtAchievementNum"):GetComponent(ty.Text)
    self.mTxtAchievementSum = self:getChildGO("mTxtAchievementSum"):GetComponent(ty.Text)
    self.mTxtAchievementName = self:getChildGO("mTxtAchievementName"):GetComponent(ty.Text)
    self.mTxtDoundlessName = self:getChildGO("mTxtDoundlessName"):GetComponent(ty.Text)
    self.mTxtDoundlessCity = self:getChildGO("mTxtDoundlessCity"):GetComponent(ty.Text)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtLevelName.text = _TT(25184)--主线进度
    self.mTxtHeroName.text = _TT(25187)--战员数量
    self.mTxtTowerName.text = _TT(25186)--边境映射
    self.mTxtAchievementName.text = _TT(25185)--成就进度
    self:setBtnLabel(self.mBtnApply, 25144, "申请")
    self.mTxtDoundlessName.text = _TT(97004)
    self.mTxtFashionName.text = _TT(25225)
    self.mTxtProgress.text = _TT(25226)

end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnCopy, self.onClickCopyHandler)
    self:addUIEvent(self.mBtnApply, self.onClickApplyHandler)
    self:addUIEvent(self.mBtnAddBlack, self.onClickBlackHandler)
    self:addUIEvent(self.mBtnGuild, self.onClickGuildHandler)
end

function onClickGuildHandler(self)
    if self.data.guildInfo.uid == "0" then
        gs.Message.Show(_TT(97053))
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_TIPS_PANEL, { guildInfo = self.data.guildInfo })
    end

end

--激活
function active(self, args)
    super.active(self, args)
    self.mCurShowId = args.id
    GameDispatcher:addEventListener(EventName.UPDATE_SHOWROLE_TIPS, self.updateBaseInfo, self)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_BLACK_UPDATE, self.updateBackState, self)
    self:updateBaseInfo()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SHOWROLE_TIPS, self.updateBaseInfo, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_BLACK_UPDATE, self.updateBackState, self)
    self:clearHeroCardList()
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

--更新左侧好友面板
function updateBaseInfo(self)
    if role.RoleManager:getOtherInfo() then
        self.data = role.RoleManager:getOtherInfo()
        if friend.FriendManager:checkIsBackFriend(self.data.id) == true then
            self:setBtnLabel(self.mBtnAddBlack, 40060, "移除")
        else
            self:setBtnLabel(self.mBtnAddBlack, 25177, "拉黑")
        end
        self.mBtnApply:SetActive(self.data.id ~= role.RoleManager:getRoleVo().playerId)
        self.mBtnAddBlack:SetActive(self.data.id ~= role.RoleManager:getRoleVo().playerId)
        self.mTxtSignature.text = FilterWordUtil:filterTemp(self.data:getAutograph())
        self.mTxtPlayerName.text = FilterWordUtil:filterTemp(self.data:getPlayerName())
        self.mTxtGuildName.text = FilterWordUtil:filterTemp(self.data.guildInfo.uid == "0" and _TT(97053) or self.data.guildInfo.name)
        self.mTxtDoundlessCity.text = doundless.getCityEasyName(self.data.cityId)
        self.mTxtAchievementNum.text = self.data:getAchievementNum()
        self.mTxtHeroNum.text = self.data:getHeroNum()
        self.mTxtHeroSum.text = "/" .. hero.HeroManager:getHeroListNum()
        self.mTxtCurLevel.text = self.data:getMainStage()
        self.mTxtFashionPro.text = _TT(45013, self.data:getFashionNum(), #fashion.FashionManager:getAllFashionListByType(fashion.Type.CLOTHES))
        self.mImgContentBg:SetImg(self.data:getBackGround(), false)
        self.mTxtTowerStage.text = self.data:getTowerStage()
        self.mTxtAchievementSum.text = "/" .. task.AchievementManager:getAchievementConfigPointNum(nil)
        if (not self.mPlayerHeadGrid) then
            self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
        end
        self.mPlayerHeadGrid:setData(self.data:getAvatarId(), false)
        self.mPlayerHeadGrid:setHeadFrame(self.data:getAvatarFrameId())
        self.mPlayerHeadGrid:setLvl(self.data:getPlayerLvl())
        self.mPlayerHeadGrid:setParent(self.mHeadGrid)
        self.mPlayerHeadGrid:setScale(0.85)
        self:onUpdateShowHeroListHandler()
        self.mTxtPlayerlv.text = self.data:getPlayerLvl()
        self.mTxtUID.text = _TT(25219, self.data.showId)
    end
end

-- 更新英雄展示格子
function onUpdateShowHeroListHandler(self)
    local showHeroList = self.data:getShowHeroList()
    self:clearHeroCardList()
    for i = 1, 5 do
        self:getChildGO("mImgNoShow" .. i):SetActive(i > #showHeroList)
    end
    for i, heroVo in ipairs(showHeroList) do
        if heroVo then
            local heroHeadGrid = HeroHeadAddGrid:poolGet()
            heroHeadGrid:setData(heroVo)
            heroHeadGrid:setScale(1)
            heroHeadGrid:setParent(self.mHeroList)
            heroHeadGrid:setClickEnable(true)
            heroHeadGrid:setCallBack(self, self.onClickOpenHeroInfoHandler)
            table.insert(self.mHeroCardList, heroHeadGrid)
        end
    end
end
--更新拉黑后的状态
function updateBackState(self)
    if friend.FriendManager:checkIsBackFriend(self.data.id) == true then
        self:setBtnLabel(self.mBtnAddBlack, 40060, "移除")
    else
        self:setBtnLabel(self.mBtnAddBlack, 25177, "拉黑")
    end
end

-- 复制ID
function onClickCopyHandler(self)
    gs.SdkManager:Copy(self.data.showId)
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104))--"复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

--打开战员信息面板
function onClickOpenHeroInfoHandler(self, heroVo)
    if heroVo then
        GameDispatcher:dispatchEvent(EventName.SHOW_SINGLE_HERO_INFO, { heroVo = heroVo })
    end
end

--申请好友
function onClickApplyHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.FRIEND_ADD_REQ, self.data.id)
    end
end
--拉黑好友
function onClickBlackHandler(self)
    if self.data then
        if friend.FriendManager:checkIsBackFriend(self.data.id) == true then
            GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_DEL_REQ, self.data.id)
        else
            GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_ADD_REQ, self.data.id)
        end
    end
end

--清除背景 
function clearHeroCardList(self)
    if self.mHeroCardList then
        for _, item in pairs(self.mHeroCardList) do
            item:poolRecover()
        end
        self.mHeroCardList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]