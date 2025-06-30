module("game.mail.view.MailCollectionView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mail/MailCollectionView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(110501))
    self:setSize(1120, 520)
end

function initData(self)
    self.gridList = {}
end

function configUI(self)
    super.configUI(self)

    self.mImgNo = self:getChildGO("mImgNo")
    self.mImgInfo = self:getChildGO("mImgInfo")

    self.mLeftScroller = self:getChildGO("mLeftScroller"):GetComponent(ty.LyScroller)
    self.mLeftScroller:SetItemRender(mail.MailCollectionItem)

    self.mScrollProps = self:getChildTrans('PropsContent')
    self.mScrollContent = self:getChildTrans('mScrollContent')
    self.mScrollContentRect = self:getChildGO('mScrollContent'):GetComponent(ty.ScrollRect)

    self.mScrollContent = self:getChildTrans('mScrollContent')
    self.mScrollContentRect = self:getChildGO('mScrollContent'):GetComponent(ty.ScrollRect)

    self.mTxtSend = self:getChildGO("mTxtSend"):GetComponent(ty.Text)
    --self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO('mTxtTime'):GetComponent(ty.Text)
    self.mTxtRightTitle = self:getChildGO('mTxtRightTitle'):GetComponent(ty.Text)
    --self.mBtnGetTxt = self:getChildGO("mBtnGetTxt"):GetComponent(ty.Text)
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.TMP_Text)
    self.mTxtContentLink = self:getChildGO("mTxtContent"):GetComponent(ty.TextMeshProLink)
    self.mTxtContentLink:SetEventCall(function(position, localPosition, linkIdStr, linkTextStr)
        notice.HrefUtil.commonNoticeDesLinkData(position, localPosition, linkIdStr, linkTextStr)
    end)

    self.mBtnDelect = self:getChildGO("mBtnDelect")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDelect, self.onBtnDelectHandler)
end

function onBtnDelectHandler(self)
    UIFactory:alertMessge(_TT(110502), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_DELECT_MAIL_COLLECTION,self.childShowId)
    end, _TT(1), nil, true, function()
    end, _TT(2), _TT(5))
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_COLLECTION_ITEM,self.updateCollectionItem,self)
    GameDispatcher:addEventListener(EventName.UPDATE_COLLECTION_PANEL,self.updateCollectionPanel,self)
    
    self.mMsgData = args
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    
    GameDispatcher:removeEventListener(EventName.UPDATE_COLLECTION_ITEM,self.updateCollectionItem,self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COLLECTION_PANEL,self.updateCollectionPanel,self)
    self:recoverAllGrid()
    if self.mLeftScroller then
        self.mLeftScroller:CleanAllItem()
    end
end

function updateCollectionPanel(self,msg)
    for i = #self.mailList,1,-1 do
        local index = table.indexof01(msg.mail_id_list,self.mailList[i].id) 
        if index > 0 then
            table.remove(self.mailList,i)
        end
    end

    if #self.mailList > 0 then
        self.mLeftScroller:ReplaceAllDataProvider(self.mailList)
        self:updateCollectionItem(self.mailList[1].id)
    else
        self.mImgNo:SetActive(true)
        self.mImgInfo:SetActive(false)
    end
end

function showPanel(self)
    self.mImgNo:SetActive(#self.mMsgData.mail_list == 0)
    self.mImgInfo:SetActive(#self.mMsgData.mail_list > 0)

    if #self.mMsgData.mail_list > 0 then
        self.mailList = {}
        for _, v in ipairs(self.mMsgData.mail_list) do
            local mailVo = LuaPoolMgr:poolGet(mail.MailVo)
            mailVo:setData(v)
            mailVo.isSelect = false
            table.insert(self.mailList, mailVo)
        end
        self.mailList[1].isSelect = true
        self.mLeftScroller.DataProvider = self.mailList

        self.childShowId = self.mailList[1].id
        self:showContent()
    end

end

function updateCollectionItem(self,id)
    self.childShowId = id

    for i = 1, #self.mailList do
        self.mailList[i].isSelect = self.mailList[i].id == id
    end
    self.mLeftScroller:ReplaceAllDataProvider(self.mailList)
    self:showContent()
end

function getSelectMailVo(self,id)
    for i = 1, #self.mailList do
        if self.mailList[i].id == id then
            return self.mailList[i]
        end
    end
    return nil
end

function showContent(self)
    self:recoverAllGrid()
    self.mScrollContentRect.verticalNormalizedPosition = 1
    if self.childShowId == 0 then
        return
    end
    local vo = self:getSelectMailVo(self.childShowId)
    if vo == nil then
        return
    end
    --self.mBtnCollection:SetActive(vo.isCollection)
    self.mTxtSend.text = vo.callName
    self.mTxtRightTitle.text = vo.title
    self.mTxtContent.text = vo.content
    self.mTxtName.text = vo.sendName
    self.mTxtTime.text = ""
    --self.mTxtTime.text = vo:getFormatTimeBySeconds()
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
    end
end

function recoverAllGrid(self)
    for i = 1, #self.gridList do
        self.gridList[i]:poolRecover()
    end
    self.gridList = {}
end

return _M
