--[[ 
-----------------------------------------------------
@filename       : MailView
@Description    : 邮件
@date           : 2020-08-20 17:27:57
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.mail.view.MailView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('mail/MailView.prefab')
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShow3DBg = 1 --是否使用3D背景（0不开启 1开启同时会禁止UI背景图）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52009))
    self:setBg("common_bg_015.jpg", false)
end

function initData(self)
    self.gridList = {}
    self.showId = 0
    --选中的Index 默认选择第一个
    self.mSelcetIndex = 1
    --是否是按钮回调
    self.mIsBtnClick = false
    self.childShowId = 0
end

-- 初始化
function configUI(self)
    self.mImgNo = self:getChildGO("mImgNo")
    self.mFxBlack = self:getChildGO("mFxBlack")
    self.mFxYellow = self:getChildGO("mFxYellow")
    self.mGroupList = self:getChildGO("mGroupList")
    self.mBtnKeyDel = self:getChildGO('mBtnKeyDel')
    self.mBtnKeyGet = self:getChildGO('mBtnKeyGet')
    self.mTxtNo = self:getChildGO('mTxtNo'):GetComponent(ty.Text)
    self.mTxtSend = self:getChildGO("mTxtSend"):GetComponent(ty.Text)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(mail.MailItem)

    ---add
    self.mBtnGet = self:getChildGO('mBtnGet')
    self.mBtnCollection = self:getChildGO("mBtnCollection")
    self.mBtnCollectionList = self:getChildGO("mBtnCollectionList")
    self.gBtnClose = self:getChildGO("gBtnClose")
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.gBtnCloseAll = self:getChildGO("gBtnCloseAll")
    self.mScrollProps = self:getChildTrans('PropsContent')
    self.mScrollContent = self:getChildTrans('mScrollContent')
    self.mScrollContentRect = self:getChildGO('mScrollContent'):GetComponent(ty.ScrollRect)

    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO('mTxtTime'):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mBtnGetTxt = self:getChildGO("mBtnGetTxt"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text)
    self.mTxtContentLink = self:getChildGO("mTxtContent"):GetComponent(ty.TextMeshProLink)
    self.mTxtContentLink:SetEventCall(function(position, localPosition, linkIdStr, linkTextStr)
        notice.HrefUtil.commonNoticeDesLinkData(position, localPosition, linkIdStr, linkTextStr)
    end)
    self.mCollectionEff = self:getChildGO("mCollectionEff")
end

-- 激活
function active(self)
    mail.MailManager.mIsSort = true
    mail.MailManager:addEventListener(mail.MailManager.MAIL_UPDATE, self.onUpdateMailHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_EMIL_COLLECTION_EFF,self.onEffCollectionHandler,self)
    self:setData()
    self:showContent()
end
-- 非激活
function deActive(self)
    self.showId = 0
    self.childShowId = 0
    gs.TransQuick:LPosY(self:getChildTrans("list"), 0)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("list"))
    self:recoverAllGrid()
    mail.MailManager:checkFlag()
    note.NoteManager:dispatchEvent(note.NoteManager.DEL_TYPE_NOTE, note.NoteType.UNREAD_MAIL)
    mail.MailManager:removeEventListener(mail.MailManager.MAIL_UPDATE, self.onUpdateMailHandler, self)
    GameDispatcher:removeEventListener(EventName.SHOW_EMIL_COLLECTION_EFF,self.onEffCollectionHandler,self)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function onEffCollectionHandler(self,args)
    self.mCollectionEff:SetActive(false)
    self.mCollectionEff:SetActive(true)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnKeyGet, 403, "领取全部")
    self.mTxtNo.text = _TT(404)--"当前暂无邮件"
    self.mTxtTip.text = _TT(419)
    self.mTxtEmptyTip.text = _TT(404)--"当前暂无邮件"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnKeyDel, self.onKeyDelHandler)
    self:addUIEvent(self.mBtnKeyGet, self.onKeyGetHandler)
    self:addUIEvent(self.mBtnGet, self.onBtnGetHandler)
    self:addUIEvent(self.mBtnCollection,self.onBtnCollectionHandler)
    self:addUIEvent(self.mBtnCollectionList,self.onBtnCollectionListHandler)
end

function onBtnCollectionListHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_OPEN_COLLECTION_LIST)
end

--添加收藏邮件
function onBtnCollectionHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_MAIL_ADD_COLLECTION,self.childShowId)
end

function setMoneyBar(self)
end

function onAwradGet(self)
    GameDispatcher:dispatchEvent(EventName.MAIL_AWARD_REQ, { self.showId })
end

function onMailDel(self)
    GameDispatcher:dispatchEvent(EventName.MAIL_DEL_REQ, { self.showId })
    gs.Message.Show(_TT(405))
end

function setData(self)
    local list = mail.MailManager:getMailList()
    if #list <= 0 then
        self:changeShow(2)
    else
        if self.mScroller.Count<=0 then
            self.mScroller.DataProvider = list
        else
            self.mScroller:ReplaceAllDataProvider(list)
        end

        if self.childShowId == 0 then
            self.childShowId = list[1].id
        else
            if self.mIsBtnClick == false then
                self:onUpdateSelcetIndex(list)
            end
        end
        local toIndex=(self.mSelcetIndex>0) and self.mSelcetIndex-1 or self.mSelcetIndex
        self.mScroller:ScrollToImmediately(toIndex)
        self:changeShow(1)
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIL_CONTENT_PANEL,self.childShowId)
    end
end
-- 更新页面展示

function changeShow(self, cusType)
    -- 当前展示的页面类型1列表 2空
    self.mGroupList:SetActive(cusType == 1)
    self.mGroupInfo:SetActive(cusType == 1)
    self.mImgNo:SetActive(cusType ~= 1)
    self.mBtnKeyDel:SetActive(cusType == 1)
    self.mBtnKeyGet:SetActive(cusType == 1)
    if cusType ~= 1 then
        self.childShowId = 0
        self.showId = 0
    end
end
--选中逻辑
function onUpdateSelcetIndex(self, list)
    if not list[self.mSelcetIndex] and self.mSelcetIndex > 1 then
        self.mSelcetIndex = self.mSelcetIndex - 1
    end
    if list[self.mSelcetIndex] and self.childShowId ~= list[self.mSelcetIndex].id then
        self.childShowId = list[self.mSelcetIndex].id
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_MAIL_CONTENT_PANEL,self.childShowId)
end

function onKeyDelHandler(self)
    local list = mail.MailManager:getKeyDelIdList()
    if #list <= 0 then
        gs.Message.Show(_TT(420))--无可删除邮件
        return
    end
    UIFactory:alertMessge(_TT(407), true, function()
        GameDispatcher:dispatchEvent(EventName.MAIL_DEL_REQ, list)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

function onKeyGetHandler(self)
    local list = mail.MailManager:getKeyAwardIdList()
    if #list <= 0 then
        gs.Message.Show(_TT(408))
        return
    end
    GameDispatcher:dispatchEvent(EventName.MAIL_AWARD_REQ, list)
end

-- 邮件更新
function onUpdateMailHandler(self)
    self.mIsBtnClick = false
    self:setData()
    self:showContent()
end

function updateInfo(self, id)
    self.childShowId = id
    self.mIsBtnClick = true
    mail.MailManager:checkFlag()
    self:showContent()
end

-- 展示邮件内容
function showContent(self)
    self:recoverAllGrid()
    local list = mail.MailManager:getMailList()
    for i, v in pairs(list) do
        if v.id==self.childShowId then
            self.mSelcetIndex=i
            break
        end
    end
    self.mScrollContentRect.verticalNormalizedPosition = 1
    if self.childShowId == 0 then
        return
    end
    local vo = mail.MailManager:getMailVoById(self.childShowId)
    if vo == nil then
        return
    end
    
    self.mBtnCollection:SetActive(vo.isCollection)
    self.mTxtSend.text = vo.callName
    self.mTxtTitle.text = vo.title
    self.mTxtContent.text = vo.content
    self.mTxtName.text = vo.sendName
    self.mTxtTime.text = vo:getFormatTimeBySeconds()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtContent.transform) --立即刷新
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mScrollContent) --立即刷新
    self.mFxBlack:SetActive(true)
    self.mFxYellow:SetActive(false)
    if vo:getHasAward() then
        table.sort(vo.awardList, function(v1, v2)
            local v1vo = props.PropsManager:getTypePropsVoByTid(v1.tid)
            local v2vo = props.PropsManager:getTypePropsVoByTid(v2.tid)
            if (v1vo.color == v2vo.color) then
                if (v1.tid == v2.tid) then
                    return false
                end
                return v1.tid > v2.tid
            else
                return v1vo.color > v2vo.color
            end
        end)
        for k, propsVo in pairs(vo.awardList) do
            local grid = PropsGrid:createByData({ parent = self.mScrollProps, tid = propsVo.tid, num = propsVo.num or propsVo.count, scale = 1, showUseInTip = true })
            grid:setIsShowCount(true)
            grid:setHasRec(vo.state == 2)
            grid:setIconGray(vo.state == 2)
            table.insert(self.gridList, grid)
        end
        self.mFxBlack:SetActive(vo.state == 2)
        self.mFxYellow:SetActive(vo.state ~= 2)
        if (vo.state == 2) then
            self.mBtnGetTxt.text = _TT(417)--删除
            self.mBtnGetTxt.color = gs.ColorUtil.GetColor("ffffffff")
            self.mBtnGet:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0162.png"), false)
        else
            self.mBtnGetTxt.text = _TT(412)--领取
            self.mBtnGetTxt.color = gs.ColorUtil.GetColor("202226ff")
            self.mBtnGet:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0163.png"), false)
        end
    else
        self.mBtnGetTxt.text = _TT(417)--删除
        self.mBtnGetTxt.color = gs.ColorUtil.GetColor("ffffffff")
        self.mBtnGet:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0162.png"), false)
    end

    if vo.state == 0 then
        -- 已读
        GameDispatcher:dispatchEvent(EventName.MAIL_READ_REQ, { vo.id })
    end
end

function onBtnGetHandler(self)
    local vo = mail.MailManager:getMailVoById(self.childShowId)

    local function reqCall()
        GameDispatcher:dispatchEvent(EventName.MAIL_DEL_REQ, { self.childShowId })
        local list = mail.MailManager:getMailList()
        local openIndex = 0
        for k, v in pairs(list) do
            if (v.id > self.childShowId) then
                openIndex = v.id
                break
            elseif (v.id ~= self.childShowId) then
                openIndex = v.id
            end
        end
        gs.Message.Show(_TT(405))
        self.childShowId = openIndex
    end
    if vo:getHasAward() and vo.state ~= 2 then
        GameDispatcher:dispatchEvent(EventName.MAIL_AWARD_REQ, { self.childShowId })
    else
        if vo.isCollection then
            UIFactory:alertMessge(_TT(423), true, function()
                reqCall()
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        else
            reqCall()
        end
    end
end

--文本处理
function TextProcessing(self, content, ...)
    local cnt = select("#", ...)
    if cnt > 0 then
        return string.substitute(content, ...)
    else
        return content
    end
end

function recoverAllGrid(self)
    for i = 1, #self.gridList do
        self.gridList[i]:poolRecover()
    end
    self.gridList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]