--[[ 
-----------------------------------------------------
@filename       : OtherRoleInfoView
@Description    : 查询他人信息
@date           : 2020-08-10 10:22:40
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.OtherRoleInfoView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/OtherRoleInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(1059, 558)
    --gs.TransQuick:UIPosX(self.gGroup, 40)
    --self:setTxtTitle('')
end

function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mGroupTotal = self:getChildTrans('GroupTotal')
    self.mGroupBtn = self:getChildGO('GroupBtn')
    self.mGroupContent = self:getChildGO('GroupContent')

    self.mBtnBlack = self:getChildGO('mBtnBlack')
    self.mBtnDel = self:getChildGO('mBtnDel')

    self.m_textPower = self:getChildGO("TextPower"):GetComponent(ty.Text)
    self.m_textPowerNum = self:getChildGO("TextPowerNum"):GetComponent(ty.Text)

    self.m_headNode = self:getChildTrans("HeadNode")
    self.m_imgTitleGo = self:getChildGO("ImgTitle")
    self.m_imgTitle = self.m_imgTitleGo:GetComponent(ty.AutoRefImage)
    self.m_textID = self:getChildGO("TextID"):GetComponent(ty.Text)
    self.m_btnIdCopy = self:getChildGO("ImgBtnCopy")
    self.m_textTitleLvl = self:getChildGO("TextTitleLvl"):GetComponent(ty.Text)
    self.m_textLvl = self:getChildGO("TextLvl"):GetComponent(ty.Text)
    self.m_textTitleHeroNum = self:getChildGO("TextTitleHeroNum"):GetComponent(ty.Text)
    self.m_textHeroNum = self:getChildGO("TextHeroNum"):GetComponent(ty.Text)

    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.m_btnModifyMark = self:getChildGO("BtnModifyMark")
    self.m_textAutograph = self:getChildGO("TextAutograph"):GetComponent(ty.Text)
    self.m_textTitleHeroShow = self:getChildGO("TextTitleHeroShow"):GetComponent(ty.Text)
    self.m_textTitleHeroShowEng = self:getChildGO("TextTitleHeroShowEng"):GetComponent(ty.Text)

    self.m_groupHero = self:getChildTrans("GroupHero")


    self.mNoAutoTxt = self:getChildGO("NoAutoTxt"):GetComponent(ty.Text)
    self.mMarksImg = self:getChildGO("MarksImg")
    self.mMarksTxt = self:getChildGO("MarksTxt"):GetComponent(ty.Text)

    self.mLanTextID = self:getChildGO("LanTextID"):GetComponent(ty.Text)

    self.mBtnChat = self:getChildGO("mBtnChat")

end

--激活
function active(self, args)
    super.active(self, args)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_REMARSK, self.__onClickMarkHandlersUpdate, self)
    --GameDispatcher:addEventListener(EventName.DEL_FRIEND_TO_BLACK,self.closeSelf,self)

    self.data = args
    self:upateInfo()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_REMARSK, self.__onClickMarkHandlersUpdate, self)
    --GameDispatcher:removeEventListener(EventName.DEL_FRIEND_TO_BLACK,self.closeSelf,self)

    if self.m_playerHeadGrid then
        self.m_playerHeadGrid:poolRecover()
    end
end

function closeSelf(self)
    self.onClickClose()
end

function initViewText(self)
    self.mLanTextID.text = _TT(25161) -- "指挥官编号:"

    self.m_textTitleLvl.text = _TT(25162)--"等级："
    self.m_textTitleHeroNum.text = _TT(25163)--"拥有战员："
    self.m_textTitleHeroShow.text = _TT(25103)--"战员展示"
    self.m_textTitleHeroShowEng.text = _TT(28055) --"//EXHIBITION"

    self.mNoAutoTxt.text = _TT(520)--"这家伙很懒，什么都没留下"
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnIdCopy, self.__onClickCopyIDHandler)
    self:addUIEvent(self.m_btnModifyMark, self.__onClickOpenMarkPanelHandler)
    self:addUIEvent(self.mBtnBlack, self.__onClickAddBlackHandler)
    self:addUIEvent(self.mBtnDel, self.__onClickDelFriendHandler)
    self:addUIEvent(self.mBtnChat, self.__onBtnChatHanlder)
end



-- 点击复制ID
function __onClickCopyIDHandler(self, args)
    gs.SdkManager:Copy(self.data.showId)
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104))--"复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

-- 打开备注界面
function __onClickOpenMarkPanelHandler(self)
    if not friend.FriendManager:checkIsFriend(self.data.id) then
        gs.Message.Show(_TT(25106))--"只有好友才能备注"
        return
    end
    GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_MARK_INFO, self.data.id)
end

-- 点击加入黑名单
function __onClickAddBlackHandler(self)
    UIFactory:alertMessge(_TT(25107), true, function() --"确定拉黑该玩家吗？"
        GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_ADD_REQ, self.data.id)
        self:onClickClose()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

-- 点击删除好友
function __onClickDelFriendHandler(self)
    if friend.FriendManager:checkIsFriend(self.data.id) then
        UIFactory:alertMessge(_TT(25108), true, function() --确定删除该好友吗？
            GameDispatcher:dispatchEvent(EventName.FRIEND_DEL_REQ, self.data.id)
            self:onClickClose()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
    else
        GameDispatcher:dispatchEvent(EventName.FRIEND_ADD_REQ, self.data.id)
        self:onClickClose()
    end
end

-- 点击聊天
function __onBtnChatHanlder(self)
    if not friend.FriendManager:checkIsFriend(self.data.id) then
        gs.Message.Show(_TT(25169))--"只有好友才能备注"
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_PRIVATE_CHAT_PANEL, self.data.id)

end

-- 备注更新
function __onClickMarkHandlersUpdate(self, cusId)
    if self.data and cusId == self.data.id then
        self:upateInfo()
    end
end

-- 更新信息
function upateInfo(self)
    if not self.data then
        self:close()
        return
    end

    self.mTxtName.text = FilterWordUtil:filterTemp(self.data.name)
    local friendVo = friend.FriendManager:getFriendVo(self.data.id)
    if (friendVo) then
        self.mBtnDel.transform:Find("Image"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("role/role_19.png"), true)
        self:setBtnLabel(self.mBtnDel, nil, _TT(25109))--"删除好友"
        self.m_btnModifyMark:SetActive(true)

        if friendVo.marks and friendVo.marks ~= "" then
            -- local mark = string.len(friendVo.marks) > 18 and string.sub(friendVo.marks, 1, 18) .. "..." or friendVo.marks
            local mark = string.omit(friendVo.marks, 6)
            --self.mTxtName.text = self.data.name .. HtmlUtil:colorAndSize(string.format('(%s)', mark), "7f868bff", 16)
            self.mMarksTxt.text = mark
            self.mMarksImg:SetActive(true)
            -- self.mTxtName:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()--立即生效 立即刷新
        else
            self.mMarksImg:SetActive(false)
            self.mMarksTxt.text = ""
        end
    else
        self.mBtnDel.transform:Find("Image"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("role/role_16.png"), true)
        self:setBtnLabel(self.mBtnDel, nil, _TT(25110))--"添加好友"
        self.m_btnModifyMark:SetActive(false)
        self.mMarksImg:SetActive(false)
    end

    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.m_playerHeadGrid:setData(self.data.avatar)
    self.m_playerHeadGrid:setHeadFrame(self.data.avatarFrame)
    self.m_playerHeadGrid:setParent(self.m_headNode)
    self.m_playerHeadGrid:setScale(1)
    -- self.m_playerHeadGrid:setLvl(roleVo:getPlayerLvl())
    self.m_playerHeadGrid:setLvl(nil)
    self.m_playerHeadGrid:setClickEnable(false)

    local signature = _TT(25101)--"这家伙很懒，什么都没留下"

    if (self.data.signature == "" or self.data.signature == _TT(25101)) then
        self.m_textAutograph.text = ""
        self.mNoAutoTxt.gameObject:SetActive(true)
    else
        self.m_textAutograph.text = self.data.signature
        self.mNoAutoTxt.gameObject:SetActive(false)
    end

    --self.m_textAutograph.text = self.data.signature == "" and signature or self.data.signature
    self.m_textID.text = self.data.showId
    self.m_textLvl.text = self.data.lvl
    self.m_textHeroNum.text = self.data.heroNum
    self.m_textPowerNum.text = self.data.power

    self:updateTitle()
    self:updateShowHeroList()

    ---------------------------------------------- 还没换界面，先屏蔽 ----------------------------------------------
    --self.m_btnModifyMark:SetActive(false)
    ---------------------------------------------- 还没换界面，先屏蔽 ----------------------------------------------
end

-- 更新称号
function updateTitle(self)
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.data.playerTitle)
    if (titleDataRo) then
        self.m_imgTitleGo:SetActive(true)
        self.m_imgTitle:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.m_imgTitleGo:SetActive(false)
    end
end

function __resetShowList(self)
    if (table.empty(self.m_heroCardDic)) then
        self.m_heroCardDic = {}
        for pos = 1, role.RoleManager.heroShowNum do
            local item = role.OtherRoleShowHeroItem.new()
            item:setBaseData(pos, true, self, self.__onClickShowGridHandler, item)
            item:setParentTrans(self.m_groupHero)
            item:resetState()
            self.m_heroCardDic[pos] = item
        end
    else
        for pos, item in pairs(self.m_heroCardDic) do
            item:resetState()
        end
    end
end

-- 更新英雄展示格子
function updateShowHeroList(self, args)
    self:__resetShowList()

    local showHeroList = self.data.heroList
    for i = 1, #showHeroList do
        local heroPosVo = showHeroList[i]
        local item = self.m_heroCardDic[heroPosVo.showPos]
        item:setData(heroPosVo)
    end
end

function __onClickShowGridHandler(self, item)
    local heroVo = item:getData()
    if heroVo then
        GameDispatcher:dispatchEvent(EventName.SHOW_SINGLE_HERO_INFO, { heroVo = heroVo })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]