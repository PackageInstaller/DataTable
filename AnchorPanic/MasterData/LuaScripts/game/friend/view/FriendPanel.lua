--[[ 
-----------------------------------------------------
@filename       : FriendPanel
@Description    : 好友主页
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.FriendPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("friend/FriendPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1500, 800)
    self:setTxtTitle(_TT(52007))
    self:setBg("friend_bg_0.jpg", false, "friend/bigBg")
end
--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    self.mBgList = {}
    self.mRoleInfoView = nil
end
-- 初始化
function configUI(self)
    self.mTxtCount = self:getChildGO('mTxtCount'):GetComponent(ty.Text)
    self.mTxtDec = self:getChildGO("mTxtDec"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO('mScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(friend.FriendItem)
    self.mImgNo = self:getChildGO('mImgNo')
    self.mBtnBlack = self:getChildGO("mBtnBlack")
    self.mBtnApply = self:getChildGO("mBtnApply")
    self.mBtnRecommend = self:getChildGO("mBtnRecommend")
    self.mTxtNo = self:getChildGO("mTxtNo"):GetComponent(ty.Text)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtEmptyTip.text = _TT(25191)
    self.mTxtNo.text = _TT(25191)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnBlack, self.onOpenBlackViewHandler)
    self:addUIEvent(self.mBtnApply, self.onOpenApplyViewHandler)
    self:addUIEvent(self.mBtnRecommend, self.onOpenRecommendViewHandler)
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    friend.FriendManager:setIsFristInit(true)
    GameDispatcher:dispatchEvent(EventName.FRIEND_LIST_REQ)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_CHECK_INFO, self.updateFriendInfo, self)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_UPDATE, self.onUpdateFriendHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FRIEND_APPLY_RED, self.updateApplyRed, self)
    self:updateApplyRed()
    self.mTxtCount.text = _TT(45013, 0, sysParam.SysParamManager:getValue(SysParamType.MAX_FRIEND_COUNT))
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_CHECK_INFO, self.updateFriendInfo, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_UPDATE, self.onUpdateFriendHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FRIEND_APPLY_RED, self.updateApplyRed, self)
    if self.mRoleInfoView then
        self.mRoleInfoView:destroy()
        self.mRoleInfoView = nil
    end
    friend.FriendManager:setCurFriendId(0)
    friend.FriendManager:setIsOneClick(false)
    MoneyManager:setMoneyTidList()
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
    RedPointManager:remove(self.mBtnApply.transform)
    
    -- 被动删除无事件通知过来，所以每次关闭后都检测一次红点
    friend.FriendManager:checkFlag()
end

function setData(self)
    local list = friend.FriendManager:getFriendList()
    --self.gImgBg:SetActive(#list <= 0)
    if #list <= 0 then
        if self.mRoleInfoView then
            self.mRoleInfoView:destroy()
            self.mRoleInfoView = nil
        end
    else
        if friend.FriendManager:getCurFriendId() == 0 or friend.FriendManager:getIsOneClick() == true then
            friend.FriendManager:setCurFriendId(friend.FriendManager:getFriendList()[1].id)
        end
    end

    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    self:getChildGO("mImgNoRight"):SetActive(#list <= 0)
    self.mImgNo:SetActive(false)
    local str = _TT(25136, #list, sysParam.SysParamManager:getValue(SysParamType.MAX_FRIEND_COUNT))
    self.mTxtDec.text = string.sub(str, 1, 15)
    self.mTxtCount.text = string.sub(str, 16, -1)
end

--更新左侧好友面板
function updateFriendInfo(self)
    local list = friend.FriendManager:getFriendList()
    if(#list > 0)then
        local otherData = role.RoleManager:getOtherInfo()
        if otherData and friend.FriendManager:getCurFriendId() == otherData.id then
            otherData.isShowFriend = true
            if self.mRoleInfoView then
                self.mRoleInfoView:updateBaseInfo(otherData)
            else
                self.mRoleInfoView = role.RoleInfoView.new()
                self.mRoleInfoView:active(otherData)
                self.mRoleInfoView:addAllUIEvent()
                self.mRoleInfoView:initViewText()
                self.mRoleInfoView:setParentTrans(self:getChildTrans("mRoleInfoTrans"))
            end
        end
    end
end
-- 好友更新
function onUpdateFriendHandler(self)
    self:setData()
end

function updateApplyRed(self)
    local friendApplyList = friend.FriendManager:getApplyIdList()
    if #friendApplyList > 0 then
        RedPointManager:add(self.mBtnApply.transform, nil, 23, 22)
    else
        RedPointManager:remove(self.mBtnApply.transform)
    end
end

--打开黑名单页面
function onOpenBlackViewHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_BLACK_PANEL)
end
--打开好友申请页面
function onOpenApplyViewHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_APPLY_PANEL)
end
--打开好友搜索页面
function onOpenRecommendViewHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_RECOMMEND_PANEL)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]