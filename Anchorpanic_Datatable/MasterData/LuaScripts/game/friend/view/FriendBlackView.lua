--[[   
     好友黑名单界面
]]
module('game.friend.view.FriendBlackView', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('friend/FriendBlackView.prefab')

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(25179))
    self:setSize(1120, 520)
end
--只是适配返回按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end

-- 初始化
function configUI(self)
    self.mScroller = self:getChildGO('mScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(friend.FriendBlackItem)
    self.mBtnClose = self:getChildGO('mBtnClose')
    self.mBtnCloseAll = self:getChildGO('mBtnCloseAll')
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mImgNo = self:getChildGO('mImgNo')
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onCloseHandler)
    self:addUIEvent(self.mBtnCloseAll, self.onCloseAllHandler)
end
-- 激活
function active(self)
    super.active(self)
    self:updateView()
    GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_LIST_REQ)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_BLACK_UPDATE, self.onUpdateHandler, self)
end
-- 非激活
function deActive(self)
    super.deActive(self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_BLACK_UPDATE, self.onUpdateHandler, self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(25192)
end

function updateView(self)
    self.mScroller:CleanAllItem()
    local list = friend.FriendManager:getBlackList()
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    if #list <= 0 then
        self.mImgNo:SetActive(true)
    else
        self.mImgNo:SetActive(false)
    end
end

function onUpdateHandler(self)
    self:updateView()
end
--删除黑名单玩家
function onClear(self)
    local list = friend.FriendManager:getBlackList()

    if #list <= 0 then
        -- gs.Message.Show('黑名单没有玩家')
        gs.Message.Show(_TT(25134))
        return
    end
    -- 确定一键移除所有黑名单玩家吗？
    UIFactory:alertMessge(_TT(25135), true, function()
        GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_DEL_REQ, "0")
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
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