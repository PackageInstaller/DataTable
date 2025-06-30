--[[ 
-----------------------------------------------------
@filename       : FriendRecommendView
@Description    : 好友推荐
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.FriendRecommendView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("friend/FriendRecommendView.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(25180))
    self:setSize(1120, 520)
end
--只适配返回按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end
--析构  
function dtor(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mIsBack = true
    self.mIsMagnify = true
end
-- 初始化
function configUI(self)
    self.mImgNo = self:getChildGO("mImgNo")
    self.mImgLine = self:getChildGO("mImgLine")
    self.mBtnClose = self:getChildGO('mBtnClose')
    self.mBtnCheck = self:getChildGO('mBtnCheck')
    self.mBtnCloseAll = self:getChildGO('mBtnCloseAll')
    self.mGroupRecommended = self:getChildGO('mGroupRecommended')
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mTxtDec = self:getChildGO("mTxtDec"):GetComponent(ty.Text)
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mInputTxt = self:getChildGO('mInputTxt'):GetComponent(ty.InputField)
    self.mQueryScroll = self:getChildGO('mQueryScroll'):GetComponent(ty.LyScroller)
    self.mQueryScroll:SetItemRender(friend.FriendQueryItem)
    self.mScroller = self:getChildGO('mScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(friend.FriendRecommendItem)
end


function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onCloseHandler)
    self:addUIEvent(self.mBtnCloseAll, self.onCloseAllHandler)
    self:addUIEvent(self.mBtnCheck, self.onCheckHandler)
end

--激活
function active(self)
    super.active(self)
    self.mImgNo:SetActive(true)
    self.mImgLine:SetActive(true)
    self.mGroupRecommended:SetActive(false)
    --GameDispatcher:dispatchEvent(EventName.FRIEND_RECOMMEND_LIST_REQ)
    local str = _TT(25136, #friend.FriendManager:getFriendList(), sysParam.SysParamManager:getValue(SysParamType.MAX_FRIEND_COUNT))
    self.mTxtDec.text = string.sub(str, 1, 15)
    self.mTxtCount.text = string.sub(str, 16, -1)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_QUERY_UPDATE, self.onQueryUpdateHandler, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnCheck)
    if self.mQueryScroll then
        self.mQueryScroll:CleanAllItem()
    end
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_QUERY_UPDATE, self.onQueryUpdateHandler, self)
    self.mInputTxt.onValueChanged:RemoveAllListeners()
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(25193)--“暂无申请信息”
end

-- 更新推荐列表
function updateRecommend(self, isInit)
    self.mGroupRecommended:SetActive(true)
    local list = friend.FriendManager:getRecommendList()
    self.mScroller.DataProvider = list
end
-- 推荐更新
function onRecommendUpdateHandler(self)
    self:updateRecommend()
end

-- 查找更新
function onQueryUpdateHandler(self)
    self:updateQuery()
end

-- 更新查询信息
function updateQuery(self)
    self.mImgNo:SetActive(false)
    self.mGroupRecommended:SetActive(false)
    local list = friend.FriendManager:getQueryList()
    if list[#list].id == "0" then
        gs.Message.Show(_TT(25148))
        self.mInputTxt.text = ""
        self.mImgNo:SetActive(true)
        self.mQueryScroll.gameObject:SetActive(false)
        return
    end
    self.mImgNo:SetActive(false)
    self.mQueryScroll.gameObject:SetActive(true)
    if self.mQueryScroll.Count <= 0 then
        self.mQueryScroll.DataProvider = list
    else
        self.mQueryScroll:ReplaceAllDataProvider(list)
    end
end

-- 查找好友
function onCheckHandler(self)
    local inputTxt = self.mInputTxt.text
    if inputTxt and inputTxt ~= '' then
        if #inputTxt < 7 then
            gs.Message.Show(_TT(25149))
            return
        end
        local showId = role.RoleManager:getRoleVo().showId
        if inputTxt == showId then
            gs.Message.Show(_TT(25150))
            return
        end
        GameDispatcher:dispatchEvent(EventName.FRIEND_FIND_REQ, inputTxt)
    else
        gs.Message.Show(_TT(25151))
    end
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