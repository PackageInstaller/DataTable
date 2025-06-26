--[[ 
-----------------------------------------------------
@filename       : FriendApplyView
@Description    : 好友申请
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.FriendApplyView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('friend/FriendApplyView.prefab')

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(25178))
    self:setSize(1120, 520)
end
-- 初始化数据
function initData(self)
    --虚拟列表初始高度
    self.mInitialHeight = 0
end

--只适配返回按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end
-- 初始化
function configUI(self)
    self.mImgNo = self:getChildGO('mImgNo')
    self.mBtnAllOK = self:getChildGO('mBtnAllOK')
    self.mBtnClose = self:getChildGO('mBtnClose')
    self.mBtnAllDel = self:getChildGO("mBtnAllDel")
    self.mBtnCloseAll = self:getChildGO('mBtnCloseAll')
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mTxtDel = self:getChildGO("mTxtDel"):GetComponent(ty.Text)
    self.mTxtAuto = self:getChildGO("mTxtAuto"):GetComponent(ty.Text)
    self.mAutoRect = self:getChildGO("mAuto"):GetComponent(ty.RectTransform)
    self.mScrollerRect = self:getChildGO('mScroller'):GetComponent(ty.RectTransform)
    self.mScroller = self:getChildGO('mScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(friend.FriendApplyItem)
end

function initViewText(self)
    self.mTxtDel.text = _TT(25173)
    self.mTxtEmptyTip.text = _TT(25133)
    self:setBtnLabel(self.mBtnAllOK, 25172, "一键通过")
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onCloseHandler)
    self:addUIEvent(self.mBtnCloseAll, self.onCloseAllHandler)
    self:addUIEvent(self.mBtnAllOK, self.onAllOkHandler)
    self:addUIEvent(self.mBtnAllDel, self.onAllDelHandler)
end

-- 激活dx
function active(self)
    super.active(self)
    self.mInitialHeight = self.mScrollerRect.rect.height
    GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_LIST_REQ)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_APPLY_UPDATE, self.onUpdateFriendHandler, self)
    self:updateView()
    friend.FriendManager:setIsOperation(false)
end
-- 非激活
function deActive(self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_APPLY_UPDATE, self.onUpdateFriendHandler, self)
    friend.FriendManager:setIsOperation(false)
    gs.TransQuick:SizeDelta02(self:getChildTrans("mScroller"), self.mInitialHeight)
end

-- 好友更新
function onUpdateFriendHandler(self)
    self:updateView()
    if self.mScroller.Count <= 0 and friend.FriendManager:getIsOperation() == true then
        self:onCloseHandler()
    end
end

function updateView(self)
    note.NoteManager:dispatchEvent(note.NoteManager.DEL_TYPE_NOTE, note.NoteType.FRIEND_APPLY)
    local list = friend.FriendManager:getApplyList()
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_FRIEND_APPLY_RED)
    self.mAutoRect.gameObject:SetActive(#list > 1)
    if #list > 1 then
        if self.mInitialHeight == self.mScrollerRect.rect.height then
            local height = self.mScrollerRect.rect.height - self.mAutoRect.rect.height
            gs.TransQuick:SizeDelta02(self:getChildTrans("mScroller"), height)
        end
    else
        gs.TransQuick:SizeDelta02(self:getChildTrans("mScroller"), self.mInitialHeight)
    end
    if #list <= 0 then
        self.mImgNo:SetActive(true)
        self.mBtnAllOK:SetActive(false)
    else
        self.mImgNo:SetActive(false)
        self.mBtnAllOK:SetActive(true)
    end
end

-- 一键同意
function onAllOkHandler(self)
    friend.FriendManager:setIsOneClick(true)
    local idList = friend.FriendManager:getApplyIdList()
    if #idList <= 0 then
        -- gs.Message.Show('没有好友申请')
        gs.Message.Show(_TT(25133))
        return
    end
    local list = {}
    for i, v in ipairs(idList) do
        local pt_friend_apply_reply = { friend_id = v, result = 1 }
        table.insert(list, pt_friend_apply_reply)
    end
    GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_REPLY, list)
    friend.FriendManager:setIsOperation(true)
end
-- 一键忽略
function onAllDelHandler(self)
    local idList = friend.FriendManager:getApplyIdList()
    if #idList <= 0 then
        -- gs.Message.Show('没有好友申请')
        gs.Message.Show(_TT(25133))
        return
    end
    local list = {}
    for i, v in ipairs(idList) do
        local pt_friend_apply_reply = { friend_id = v, result = 0 }
        table.insert(list, pt_friend_apply_reply)
    end
    GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_REPLY, list)
end
--返回上一级页面
function onCloseHandler(self)
    self:close()
end
--返回主页面
function onCloseAllHandler(self)
    super.closeAll(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]