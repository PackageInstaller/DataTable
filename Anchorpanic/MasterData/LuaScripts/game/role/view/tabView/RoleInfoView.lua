--[[-----------------------------------------------------
@filename       : RoleInfoView
@Description    : 玩家信息面板
@date           : 2022-05-25 11:15:40
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('role.RoleInfoView', Class.impl(TabSubView))
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/tab/RoleInfoView.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
end
--析构
function dtor(self)
end
-- 初始化数据
function initData(self)
    --背景数据列表
    self.mBgVoList = {}
    --战员卡片列表
    self.mHeroCardList = {}
    --是否是展示好友
    self.mIsShowFriend = false
    --当前背景索引
    self.mCurBgIndex = 0
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnNote = self:getChildGO('mBtnNote')
    self.mBtnCopy = self:getChildGO("mBtnCopy")
    self.mBtnGuild = self:getChildGO("mBtnGuild")
    self.mImgNote = self:getChildGO("mImgNote")
    self.mImgBarBg = self:getChildGO("mImgBarBg")
    self.mBtnDelect = self:getChildGO("mBtnDelect")
    self.mBtnChat = self:getChildGO("mBtnChat")
    self.mHeroList = self:getChildTrans("mHeroList")
    self.mHeadGrid = self:getChildTrans("mHeadGrid")
    self.mBtnAddBlack = self:getChildGO("mBtnAddBlack")
    self.mBtnChangeBg = self:getChildGO("mBtnChangeBg")
    self.mBtnHeroGroup = self:getChildGO("mBtnHeroGroup")
    self.mBtnSignature = self:getChildGO("mBtnSignature")
    self.mAimator = self.UIObject:GetComponent(ty.Animator)
    self.mHeroShowList = self:getChildTrans("mHeroShowList")
    self.mTxtUID = self:getChildGO("mTxtUID"):GetComponent(ty.Text)
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
    self.mTxtVersion = self:getChildGO("mTxtVersion"):GetComponent(ty.Text)
    self.mTxtHeroNum = self:getChildGO("mTxtHeroNum"):GetComponent(ty.Text)
    self.mTxtHeroSum = self:getChildGO("mTxtHeroSum"):GetComponent(ty.Text)
    self.mTxtBarValue = self:getChildGO("mTxtBarValue"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtCurLevel = self:getChildGO("mTxtCurLevel"):GetComponent(ty.Text)
    self.mTxtPlayerlv = self:getChildGO("mTxtPlayerlv"):GetComponent(ty.Text)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtLevelName = self:getChildGO("mTxtLevelName"):GetComponent(ty.Text)
    self.mTxtSignature = self:getChildGO("mTxtSignature"):GetComponent(ty.Text)
    self.mTxtTowerName = self:getChildGO("mTxtTowerName"):GetComponent(ty.Text)
    self.mTxtFashionPro = self:getChildGO("mTxtFashionPro"):GetComponent(ty.Text)
    self.mTxtPlayerName = self:getChildGO("mTxtPlayerName"):GetComponent(ty.Text)
    self.mTxtTowerStage = self:getChildGO("mTxtTowerStage"):GetComponent(ty.Text)
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)
    self.mImgContentBg = self:getChildGO("mImgContentBg"):GetComponent(ty.AutoRefImage)
    self.mTxtAchievementNum = self:getChildGO("mTxtAchievementNum"):GetComponent(ty.Text)
    self.mTxtAchievementSum = self:getChildGO("mTxtAchievementSum"):GetComponent(ty.Text)
    self.mTxtAchievementName = self:getChildGO("mTxtAchievementName"):GetComponent(ty.Text)
    self.mImgContentBg_1 = self:getChildGO("mImgContentBg_1"):GetComponent(ty.AutoRefImage)

    self.mTxtDoundlessName = self:getChildGO("mTxtDoundlessName"):GetComponent(ty.Text)
    self.mTxtDoundlessCity = self:getChildGO("mTxtDoundlessCity"):GetComponent(ty.Text)

    self.mBtnFight = self:getChildGO("mBtnFight")
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnChangeBg, 25188, "更换背景")
    self:setBtnLabel(self.mBtnHeroGroup, 41733, "助理组")
    self:setBtnLabel(self.mBtnAddBlack, 25177, "加入黑名单")
    self:setBtnLabel(self.mBtnDelect, 417, "删除")
    self.mTxtLevelName.text = _TT(25184)--主线进度
    self.mTxtHeroName.text = _TT(25187)--战员数量
    self.mTxtTowerName.text = _TT(25186)--边境映射
    self.mTxtAchievementName.text = _TT(25185)--成就进度
    self.mTxtDoundlessName.text = _TT(97004)
    self.mTxtFashionName.text = _TT(25225)
    self.mTxtProgress.text = _TT(25226)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnNote, self.onOpenNoteHandler)
    self:addUIEvent(self.mBtnChangeBg, self.onClickChangeBgHandler)
    self:addUIEvent(self.mBtnDelect, self.onDelectHandler)
    self:addUIEvent(self.mBtnSignature, self.onClickModifyAutographHandler)
    self:addUIEvent(self.mBtnAddBlack, self.onAddBlackHandler)
    self:addUIEvent(self.mBtnCopy, self.onClickCopyHandler)

    self:addUIEvent(self.mBtnFight, self.onClickFightHandler)

    self:addUIEvent(self.mBtnGuild, self.onClickGuildHandler)
    self:addUIEvent(self.mBtnChat, self.onBtnChatHanlder)
    self:addUIEvent(self.mBtnHeroGroup, self.onClickHeroGroupHandler)
end

function onClickFightHandler(self)
    --local data = self.data
    fight.FightManager:reqBattleEnter(PreFightBattleType.Friend, self.data.id)
    --formation.checkFormationFight(PreFightBattleType.Friend, nil,self.data.id, nil, nil, nil)
end

-- 点击聊天
function onBtnChatHanlder(self)
    if not friend.FriendManager:checkIsFriend(self.data.id) then
        gs.Message.Show(_TT(25169))--"只有好友才能备注"
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_PRIVATE_CHAT_PANEL, self.data.id)

end

function onClickGuildHandler(self)
    if self.mIsShowFriend then
        if self.data.guildInfo.uid == "0" then
            gs.Message.Show(_TT(97053))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_TIPS_PANEL, { guildInfo = self.data.guildInfo })
        end
    end
end
--激活
function active(self, args)
    super.active(self, args)
    if args.isShowFriend == nil then
        self.data = role.RoleManager:getPersonalInfoList()
        self.mIsShowFriend = false
    else
        self.data = role.RoleManager:getOtherInfo()
        self.mIsShowFriend = true
    end
    --self.mBtnNote:SetActive(self.mIsShowFriend ~= true)
    self.mBtnChat:SetActive(self.mIsShowFriend == true and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FRIEND_CHAT, false))

    self.mBtnFight:SetActive(self.mIsShowFriend == true)
    self.mImgNote:SetActive(self.mBtnNote.activeSelf == true)
    self.mAimator:Play("RoleInfoView_Enter")
    self.mAimator.enabled = false
    self.mAimator:Update(0)
    gs.DT.DOTween:Sequence():AppendInterval(0):AppendCallback(function()
        self.mAimator.enabled = true
    end):Play()
    GameDispatcher:addEventListener(EventName.CLOSE_PREVIEW_BG, self.onCloseBgHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ROLE_INFO_VIEW, self.updateBaseInfo, self)
    GameDispatcher:addEventListener(EventName.UPDATE_PREVIEW_BG, self.onPreviewBgHandler, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateBgBubble, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_NAME, self.onUpdateNameHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.onUpdateHeadHandler, self)
    decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateBubble, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.onUpdateHeadHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AUTOGRAPH, self.onUpdateAutographHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_SHOW_HERO_LIST, self.onUpdateShowHeroListHandler, self)
    self.mBtnChangeBg:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_TITLE, false) == true)
    self.mBtnChangeBg:SetActive(self.mIsShowFriend ~= true)
    self.mBtnHeroGroup:SetActive(self.mIsShowFriend ~= true and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_GURAD_GROUP, false))
    self:updateBgBubble()
    self:updateBaseInfo()
    MoneyManager:setMoneyTidList()
    if role.RoleManager:getBgIsOpen() == true then
        self:onClickChangeBgHandler()
    end

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.CLOSE_PREVIEW_BG, self.onCloseBgHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROLE_INFO_VIEW, self.updateBaseInfo, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_PREVIEW_BG, self.onPreviewBgHandler, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateBgBubble, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_NAME, self.onUpdateNameHandler, self)
    decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateBubble, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.onUpdateHeadHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.onUpdateHeadHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AUTOGRAPH, self.onUpdateAutographHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_SHOW_HERO_LIST, self.onUpdateShowHeroListHandler, self)
    RedPointManager:remove(self.mBtnChangeBg.transform)
    MoneyManager:setMoneyTidList({})
    if self.mPlayerHeadGrid then
        RedPointManager:remove(self.mHeadGrid)
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

--更新左侧好友面板
function updateBaseInfo(self, data)
    if not data then
        if self.mIsShowFriend == false then
            self.data = role.RoleManager:getPersonalInfoList()
        else
            self.data = role.RoleManager:getOtherInfo()
        end
    else
        self.data = data
    end
    self.mBtnDelect:SetActive(self.mIsShowFriend == true)
    self.mBtnAddBlack:SetActive(self.mIsShowFriend == true)
    self.mImgBarBg:SetActive(self.mIsShowFriend == false)
    self.mTxtPlayerlv.text = self.data:getPlayerLvl()
    self.mTxtSignature.text = self.data:getAutograph()

    if self.data.remarks == "" then
        self.mTxtPlayerName.text = self.data:getPlayerName()
    else
        self.mTxtPlayerName.text = self.data.remarks .. "<size=22>(" .. self.data:getPlayerName() .. ")</size>"
    end
    self.mTxtAchievementNum.text = self.data:getAchievementNum()
    self.mTxtHeroNum.text = self.data:getHeroNum()
    self.mTxtHeroSum.text = hero.HeroManager:getHeroListNum()
    self.mTxtCurLevel.text = self.data:getMainStage()
    self.mImgContentBg:SetImg(self.data:getBackGround(), false)
    self.mTxtTowerStage.text = self.data:getTowerStage()
    self.mTxtFashionPro.text = _TT(45013, self.data:getFashionNum(), #fashion.FashionManager:getAllFashionListByType(fashion.Type.CLOTHES))
    self.mTxtAchievementSum.text = task.AchievementManager:getAchievementConfigPointNum(nil)

    if self.mIsShowFriend then
        self.mTxtGuildName.text = self.data.guildInfo.uid == "0" and _TT(97053) or self.data.guildInfo.name
    else
        self.mTxtGuildName.text = guild.GuildManager:getJoinGuilded() and guild.GuildManager:getGuildInfo().name or _TT(97053)
    end
    self.mTxtDoundlessCity.text = doundless.getCityEasyName(self.data.cityId)

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGrid, self.data:getAvatarId(), 1, false)
    end
    self.mPlayerHeadGrid:setHeadFrame(self.data:getAvatarFrameId())
    self.mPlayerHeadGrid:setLvl(self.data:getPlayerLvl())
    RedPointManager:remove(self.mHeadGrid)
    if self.mIsShowFriend == true then
        self.mTxtVersion.text = ""
    else
        local roleVo = role.RoleManager:getRoleVo()
        self.mImgBar.fillAmount = roleVo:getPlayerExp() / roleVo:getPlayerMaxExp()
        self.mTxtBarValue.text = _TT(45013, roleVo:getPlayerExp(), roleVo:getPlayerMaxExp())
        self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadViewHandler)
        local serverVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.VersionKey)
        local serverVersionStr = download.ResDownLoadManager:getVersionStr(serverVersion)
        local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
        local serverProVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ProVersionKey)
        local serverArtVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.ArtVersionKey)
        self.mTxtVersion.text = web.getFormatVersion(prefixVersion, serverVersionStr, serverProVersion, serverArtVersion)
    end

    self:updateBubble()
    self:onUpdateShowHeroListHandler()
    self.mTxtUID.text = _TT(25219, self.data.showId)

end
-- 更新个性签名
function onUpdateAutographHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
end
-- 更新名字
function onUpdateNameHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
end
-- 更新称号
function onUpdateTitleHandler(self)
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.data:getTitleId())
    if (titleDataRo) then
        self.mImgTitleGo:SetActive(true)
        self.mImgTitle:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleGo:SetActive(false)
    end
end
-- 更新头像和头像框
function onUpdateHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
end
-- 预览背景效果
function onPreviewBgHandler(self, iconIndex)
    self.mImgContentBg_1.gameObject:SetActive(true)
    if self.mCurBgIndex ~= iconIndex then
        if self.mCurBgIndex ~= 0 then
            if self.loopSn then
                self:removeTimerByIndex(self.loopSn)
                self.loopSn = nil
                self.mImgContentBg:SetImg(UrlManager:getBgPath("friend/bigBg/friend_bg_" .. self.mCurBgIndex .. ".jpg"), false)
            end
        end
        self.loopSn = self:addTimer(0.8, 1, function()
            self.mImgContentBg:SetImg(UrlManager:getBgPath("friend/bigBg/friend_bg_" .. iconIndex .. ".jpg"), false)
        end)
        self.mCurBgIndex = iconIndex
    end
    self.mImgContentBg_1:SetImg(UrlManager:getBgPath("friend/bigBg/friend_bg_" .. iconIndex .. ".jpg"), false)
    self.mImgContentBg_1.gameObject:GetComponent(ty.UIDoTween):EndTween()
    self.mImgContentBg_1.gameObject:GetComponent(ty.UIDoTween):BeginTween()
    self:updateBubble()
end

function updateBgBubble(self)
    local bubble = decorate.DecorateManager:updateBgReadRed()
    if bubble then
        RedPointManager:add(self.mBtnChangeBg.transform, nil, 25.5, 14)
    else
        RedPointManager:remove(self.mBtnChangeBg.transform)
    end
end
-- 关闭背景界面
function onCloseBgHandler(self)
    self.mBtnChangeBg:SetActive(true)
    self.mBtnHeroGroup:SetActive(true)
    if self.loopSn then
        self:removeTimerByIndex(self.loopSn)
        self.loopSn = nil
    end
    self.mImgContentBg:SetImg(self.data:getBackGround(), false)
    self.mImgContentBg_1.gameObject:SetActive(false)
end

--个人主页信息展示战员
function resetShowList(self)
    if (table.empty(self.mHeroHeadDic)) then
        self.mHeroHeadDic = {}
        for pos = 1, role.RoleManager.heroShowNum do
            local item = role.RoleShowHeroItem.new()
            item:setBaseData(pos, false, self, self.onClickShowGridHandler, item)
            item:setParentTrans(self.mHeroList)
            item:resetState()
            self.mHeroHeadDic[pos] = item
        end
    else
        for pos, item in pairs(self.mHeroHeadDic) do
            item:resetState()
        end
    end
end

-- 更新英雄展示格子
function onUpdateShowHeroListHandler(self)
    local showHeroList = self.data:getShowHeroList()
    for i = 1, 5 do
        self:getChildGO("mImgNoShow" .. i):SetActive(i > #showHeroList)
    end
    if self.mIsShowFriend == true then
        self:clearHeroCardList()
        for i, heroVo in ipairs(showHeroList) do
            if heroVo then
                local heroHeadGrid = HeroHeadAddGrid:poolGet()
                heroHeadGrid:setData(heroVo)
                heroHeadGrid:setScale(1)
                heroHeadGrid:setParent(self.mHeroShowList)
                heroHeadGrid:setClickEnable(true)
                heroHeadGrid:setCallBack(self, self.onClickOpenHeroInfoHandler)

                table.insert(self.mHeroCardList, heroHeadGrid)
            end
        end
    else
        self:resetShowList()
        for i = 1, #showHeroList do
            local item = self.mHeroHeadDic[i]
            local heroVo = hero.HeroManager:getHeroVo(showHeroList[i].hero_id)
            item:setData(heroVo)
        end
    end
end

-- 看板娘值班组
function onClickHeroGroupHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_GROUP_PANEL)
end

--更换背景
function onClickChangeBgHandler(self)
    if self.mIsShowFriend == false then
        self.mBtnChangeBg:SetActive(false)
        self.mBtnHeroGroup:SetActive(false)
        GameDispatcher:dispatchEvent(EventName.OPEN_SHOWROLE_BG_VIEW)
    end
end
--打开战员信息面板
function onClickOpenHeroInfoHandler(self, heroVo)
    if heroVo then
        GameDispatcher:dispatchEvent(EventName.SHOW_SINGLE_HERO_INFO, { heroVo = heroVo })
    end
end

--打开修改备注面板
function onOpenNoteHandler(self)
    if self.mIsShowFriend then
        if not friend.FriendManager:checkIsFriend(self.data.id) then
            gs.Message.Show(_TT(25106))--"只有好友才能备注"
            return
        end
        role.RoleManager:setInputText(self.data:getPlayerName())
        GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_MARK_INFO, self.data.id)
    else
        role.RoleManager:setInputText(self.data:getPlayerName())
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_MODIFY_NAME_PANEL)
    end
end
-- 复制ID
function onClickCopyHandler(self)
    if self.mIsShowFriend ~= true then
        local roleVo = role.RoleManager:getRoleVo()
        gs.SdkManager:Copy(roleVo.showId)
    else
        gs.SdkManager:Copy(self.data.showId)
    end
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104))--"复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end
-- 点击修改签名
function onClickModifyAutographHandler(self)
    if self.mIsShowFriend == false then
        role.RoleManager:setInputText(self.data:getAutograph())
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_MODIFY_AUTOGRAPH_PANEL)
    end
end
-- 打开个性头像页面
function onClickHeadViewHandler(self)
    if self.mIsShowFriend == false then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_HEAD_VIEW)
    end
end
-- 点击英雄展示空格子
function onClickShowGridHandler(self, item)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_SELECT_HERO_PANEL, { pos = item:getPos(), heroId = item:getData() and item:getData().id or nil })
end
--删除好友
function onDelectHandler(self)
    if self.mIsShowFriend then
        local showIndex = 0
        if #friend.FriendManager:getFriendList() > 0 then
            for i, v in ipairs(friend.FriendManager:getFriendList()) do
                if self.data.id == v.id then
                    showIndex = i
                    break
                end
            end
        end
        UIFactory:alertMessge(_TT(25108), true, function() --确定删除该好友吗？
            if #friend.FriendManager:getFriendList() >= 1 then
                if showIndex > 1 then
                    friend.FriendManager:setCurFriendId(friend.FriendManager:getFriendList()[showIndex - 1].id)
                else
                    friend.FriendManager:setCurFriendId(0)
                end
            end
            GameDispatcher:dispatchEvent(EventName.FRIEND_DEL_REQ, self.data.id)
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
    end
end

--加入黑名单
function onAddBlackHandler(self)
    if self.mIsShowFriend then
        local showIndex = 0
        if #friend.FriendManager:getFriendList() > 0 then
            for i, v in ipairs(friend.FriendManager:getFriendList()) do
                if self.data.id == v.id then
                    showIndex = i
                    break
                end
            end
        end
        if friend.FriendManager:checkIsFriend(self.data.id) then
            UIFactory:alertMessge(_TT(25107), true, function()
                if #friend.FriendManager:getFriendList() >= 1 then
                    if showIndex > 1 then
                        friend.FriendManager:setCurFriendId(friend.FriendManager:getFriendList()[showIndex - 1].id)
                    elseif showIndex == 1 then
                        friend.FriendManager:setCurFriendId(0)
                    end
                end
                GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_ADD_REQ, self.data.id)
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
        end

    end
end
--获取头像和头像框列表
function onDecorateListUpdateHandler(self, args)
    if args.moduleType == decorate.ModuleType.HEAD then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_ROLE_HEAD_LIST)
    elseif args.moduleType == decorate.ModuleType.HEAD_FRAME then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_ROLE_HEAD_FRAME_LIST)
    end
end
--更新红点
function updateBubble(self)
    if self.mIsShowFriend == false then
        if decorate.DecorateManager:isBubble() == true then
            RedPointManager:add(self.mHeadGrid, nil, 49, 50)
        else
            RedPointManager:remove(self.mHeadGrid)
        end
    end

    if self.mIsShowFriend then
        local friendVo = friend.FriendManager:getFriendVo(self.data.id)
        if friendVo and friendVo.newMessge > 0 then
            RedPointManager:add(self.mBtnChat.transform, nil, 83, 19)
        else
            RedPointManager:remove(self.mBtnChat.transform)
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