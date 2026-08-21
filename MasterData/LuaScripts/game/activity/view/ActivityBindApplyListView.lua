--[[ 
-----------------------------------------------------
@Description    : 联结申请成员列表
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module('mainActivity.ActivityBindApplyListView', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("purchase/ActivityBindApplyListView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(41786))
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mPlayerHeadList = {}
    self.mMembersItemList = {}
end

-- 初始化
function configUI(self)
    self.mMemberItem = self:getChildGO("mMemberItem")
    self.mMembersScroll = self:getChildGO("mMembersScroll"):GetComponent(ty.ScrollRect)

    self.mMemberNo = self:getChildGO("mMemberNo")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(41788)
end

function active(self, args)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_JOINT_BIND_APPLY_LIST, self.showPanel, self)
   
    
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_JOINT_BIND_APPLY_LIST, self.showPanel, self)
   
    self:clearPlayerHeadList()
    self:clearMembersItemList()
end

function showPanel(self)

    self:clearPlayerHeadList()
    self:clearMembersItemList()

    self.membersList = activity.ActitvityExtraManager:getBindApplyList()
    self.mMemberNo:SetActive(#self.membersList == 0)

    for i = 1, #self.membersList do

        local item = SimpleInsItem:create(self.mMemberItem, self.mMembersScroll.content, "mJointMemberItem")
        local playerHead = PlayerHeadGrid:poolGet()
        playerHead:setData(self.membersList[i].avatar_id)
        playerHead:setHeadFrame(self.membersList[i].avatar_frame)
        playerHead:setParent(item:getChildTrans("mHeadPos"))
        playerHead:setScale(0.5)
        local playerId = self.membersList[i].player_id
        playerHead:setCallBack(self, function ()
            GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = playerId })
        end)
        table.insert(self.mPlayerHeadList, playerHead)

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.membersList[i].player_name
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361) .. self.membersList[i].player_lv
        item:getChildGO("mTxtUID"):GetComponent(ty.Text).text = _TT(41797) .. self.membersList[i].show_id

        item:getChildGO("mTxtReject"):GetComponent(ty.Text).text = _TT(10000234)
        item:getChildGO("mTxtAgree"):GetComponent(ty.Text).text = _TT(10000233)

        item:addUIEvent("mBtnReject", function()
            activity.ActitvityExtraManager:setLastJointPlayerId(self.membersList[i].player_id)
            GameDispatcher:dispatchEvent(EventName.REQ_JOINT_BIND_REJECT, {
                playerId = self.membersList[i].player_id
            })
        end)
        item:addUIEvent("mBtnAgree", function()
            activity.ActitvityExtraManager:setLastJointPlayerId(self.membersList[i].player_id)
            GameDispatcher:dispatchEvent(EventName.REQ_JOINT_BIND_AGREE, {
                playerId = self.membersList[i].player_id
            })
            self:close()
        end)

        table.insert(self.mMembersItemList, item)
    end
end

-- function __onClickHeadHandler(self,playerId)
--     GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = playerId })
-- end

function clearPlayerHeadList(self)
    for i = 1, #self.mPlayerHeadList do
        self.mPlayerHeadList[i]:poolRecover()
    end
    self.mPlayerHeadList = {}
end

function clearMembersItemList(self)
    for i = 1, #self.mMembersItemList do
        self.mMembersItemList[i]:poolRecover()
    end
    self.mMembersItemList = {}
end

return _M
