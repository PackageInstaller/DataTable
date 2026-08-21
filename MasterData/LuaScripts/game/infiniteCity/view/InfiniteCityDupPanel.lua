--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDupPanel
@Description    : 无限城活动副本页面
@date           : 2021-03-01 14:39:54
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityDupPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)

    self:setBg("common_bg_5.jpg", false)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mDupItemList = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mScollContent = self:getChildGO("Content")
    self.mScollContentTrans = self:getChildTrans("Content")
    self.mImgToucher = self:getChildGO('mImgToucher')
    self.mGroupInfo = self:getChildTrans("mGroupInfo")

    self.mBtnTrophy = self:getChildGO('mBtnTrophy')
    self.mBtnReset = self:getChildGO('mBtnReset')

    self.mImgSpecialTips = self:getChildGO('mImgSpecialTips')
    self.mTxtSpecialName = self:getChildGO('mTxtSpecialName'):GetComponent(ty.Text)
    self.mGroupPassTips = self:getChildGO('mGroupPassTips')
    self.mImgPass = self:getChildTrans('mImgPass')

    self.mTxtDeffTips1 = self:getChildGO("mTxtDeffTips1"):GetComponent(ty.Text)
    self.mTxtDeffTips2 = self:getChildGO("mTxtDeffTips2"):GetComponent(ty.Text)
    self.mTxtDeff = self:getChildGO("mTxtDeff"):GetComponent(ty.Text)
    self.mBtnChoose = self:getChildGO("mBtnChoose")
    self.mGroupDeff = self:getChildGO("mGroupDeff")
    self.mImgSelect = self:getChildTrans("mImgSelect")

    self.mBtnDeff1 = self:getChildGO("mBtnDeff1")
    self.mBtnDeff2 = self:getChildGO("mBtnDeff2")
    self.mBtnDeff3 = self:getChildGO("mBtnDeff3")
    self.mBtnDeff4 = self:getChildGO("mBtnDeff4")

    self:setGuideTrans("funcTips_infiniteCity_trophy", self.mBtnTrophy.transform)
    self:setGuideTrans("funcTips_infiniteCity_reset", self.mBtnReset.transform)

end

--激活
function active(self)
    super.active(self)
    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_INFINITECITY_DATA_UPDATE, self.updateView, self)
    GameDispatcher:addEventListener(EventName.OPEN_INFINITE_CITY_DUP_INFO_VIEW, self.onOpenDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_INFINITE_CITY_DUP_INFO_VIEW, self.onCloseDupInfoHandler, self)

    self:updateView()

    if infiniteCity.InfiniteCityManager.isSpecialOpen then
        self:showSpecialTips()
        infiniteCity.InfiniteCityManager.isSpecialOpen = false
    end
    if infiniteCity.InfiniteCityManager.isRoundEnd then
        self:setTimeout(1, function()
            self:showRoundEndTips()
        end)
        infiniteCity.InfiniteCityManager.isRoundEnd = false
    end

    if self.gInfoView then
        self.gInfoView:reShow()
    end
    self:updateChooseState()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_INFINITECITY_DATA_UPDATE, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.OPEN_INFINITE_CITY_DUP_INFO_VIEW, self.onOpenDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_INFINITE_CITY_DUP_INFO_VIEW, self.onCloseDupInfoHandler, self)
    LoopManager:removeFrameByIndex(self.frameId)
    self:clearItemList()
    -- infiniteCity.InfiniteCityManager.selectDisasterList = {}
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtDeffTips1.text = _TT(27162) --"不同难度只会影响最后灾害评分"
    self.mTxtDeffTips2.text = _TT(27163) --"所有难度共享一份奖励"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mScollContent, self.onScollContentClick)
    self:addUIEvent(self.mImgToucher, self.onCloseDupInfoHandler)
    self:addUIEvent(self.mBtnTrophy, self.onOpenTrophyShow)
    self:addUIEvent(self.mBtnReset, self.onResetHandler)
    self:addUIEvent(self.mImgSpecialTips, self.onCloseSpecialTips)
    self:addUIEvent(self.mGroupPassTips, self.onCloseRoundEndTips)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)

    self:addUIEvent(self.mGroupDeff, self.onShowDeffChoose)
    self:addUIEvent(self.mBtnChoose, self.onShowDeffChoose)
    self:addUIEvent(self.mBtnDeff1, self.onDeffChoose1)
    self:addUIEvent(self.mBtnDeff2, self.onDeffChoose2)
    self:addUIEvent(self.mBtnDeff3, self.onDeffChoose3)
    self:addUIEvent(self.mBtnDeff4, self.onDeffChoose4)
end

-- 设置货币栏
function setMoneyBar(self)
end

function onShowDeffChoose(self)
    if self.mGroupDeff.activeSelf then
        self.mGroupDeff:SetActive(false)
    else
        self.mGroupDeff:SetActive(true)

        if infiniteCity.InfiniteCityManager.hardLevel == 1 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff1.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 2 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff2.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 3 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff3.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 4 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff4.transform)
        end
        self:updateDeffBtn()
    end
end

function onDeffChoose1(self)
    infiniteCity.InfiniteCityManager.hardLevel = 1
    self:updateChooseState()
end

function onDeffChoose2(self)
    infiniteCity.InfiniteCityManager.hardLevel = 2
    self:updateChooseState()
end

function onDeffChoose3(self)
    infiniteCity.InfiniteCityManager.hardLevel = 3
    self:updateChooseState()
end

function onDeffChoose4(self)
    infiniteCity.InfiniteCityManager.hardLevel = 4
    self:updateChooseState()
end

function updateChooseState(self)
    -- local str = { "简单", "普通", "困难", "噩梦" }
    local langId = { 27158, 27159, 27160, 27161 }
    self:setBtnLabel(self.mBtnChoose, langId[infiniteCity.InfiniteCityManager.hardLevel])
    self.mGroupDeff:SetActive(false)

    -- self:updateLvAndScore()
    -- self:updateDisasterScore()
end

function updateDeffBtn(self)
    local hardLevel = infiniteCity.InfiniteCityManager.hardLevel
    local selectStr = "<color='#000000'>%s</color>"
    local nomalStr = "<color='#ffffff'>%s</color>"
    self:setBtnLabel(self.mBtnDeff1, nil, hardLevel == 1 and string.format(selectStr, _TT(27158)) or string.format(nomalStr, _TT(27158)))
    self:setBtnLabel(self.mBtnDeff2, nil, hardLevel == 2 and string.format(selectStr, _TT(27159)) or string.format(nomalStr, _TT(27159)))
    self:setBtnLabel(self.mBtnDeff3, nil, hardLevel == 3 and string.format(selectStr, _TT(27160)) or string.format(nomalStr, _TT(27160)))
    self:setBtnLabel(self.mBtnDeff4, nil, hardLevel == 4 and string.format(selectStr, _TT(27161)) or string.format(nomalStr, _TT(27161)))
end


function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.InfiniteCityDup })
end
-- 特殊副本开放通知
function showSpecialTips(self)
    local dupList = infiniteCity.InfiniteCityManager:getDupList()
    local dupDataVo = dupList[#dupList]
    if dupDataVo then
        self.mTxtSpecialName.text = dupDataVo.name
    end
    self.mImgSpecialTips.transform:SetParent(self.UIBaseTrans, false)
    self.mImgSpecialTips:SetActive(true)
end
function onCloseSpecialTips(self)
    self.mImgSpecialTips.transform:SetParent(self.UITrans, false)
    self.mImgSpecialTips:SetActive(false)
end
-- 轮次结束
function showRoundEndTips(self)
    self.mGroupPassTips.transform:SetParent(self.UIBaseTrans, false)
    self.mGroupPassTips:SetActive(true)

    gs.TransQuick:ScaleY(self.mImgPass, 0)
    self.passTween = self.mImgPass:DOScaleY(1, 0.1)
    self.passTween:OnComplete(function()
        self:setTimeout(2, function()
            self:onCloseRoundEndTips()
        end)
    end)
end

function onCloseRoundEndTips(self)
    self.passTween:Kill()
    self.passTween = nil
    gs.TransQuick:ScaleY(self.mImgPass, 1)
    self.passTween = self.mImgPass:DOScaleY(0, 0.1)
    self.passTween:OnComplete(function()
        self.mGroupPassTips:SetActive(false)
        self.mGroupPassTips.transform:SetParent(self.UITrans, false)
    end)
end

-- 打开战利品展示
function onOpenTrophyShow(self)
    if #infiniteCity.InfiniteCityManager:getOwnTrophyList() <= 0 then
        -- gs.Message.Show("未获得战利品")
        gs.Message.Show(_TT(27132))
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_TROPHY_SHOW_PANEL)
end

function onResetHandler(self)
    -- 是否重置关卡？（关卡首领将随机生成，已获得的战利品也将重置）
    UIFactory:alertMessge(_TT(27133), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_CITY_RESET)
        self:onCloseDupViewHandler()
    end, _TT(1), nil, true, nil, _TT(2))
end

function onScollContentClick(self)
    self:onCloseDupInfoHandler()
end

function onOpenDupInfoHandler(self, cusDupId)
    self:__onOpenDupInfoHandler(cusDupId)
    -- self:scollToItem(true)
    local dupList = infiniteCity.InfiniteCityManager:getDupList()
    for i = 1, #dupList do
        local dupDataVo = dupList[i]
        if dupDataVo.id == cusDupId then
            local item = self.mDupItemList[i]
            self:onScollTo(item, i, true)
            break
        end
    end
end
function onCloseDupInfoHandler(self)
    self:onCloseDupViewHandler()
    -- self:scollToItem(false)
end

-- 副本信息
function __onOpenDupInfoHandler(self, cusDupId)
    if self.gInfoView == nil then
        self.gInfoView = UI.new(infiniteCity.InfiniteCityDupInfoView)
    end
    self.gInfoView:show(self.mGroupInfo, cusDupId)
    self.mImgToucher:SetActive(true)
end
-- 关闭副本详情
function onCloseDupViewHandler(self)
    if self.gInfoView then
        self.gInfoView:destroy()
        self.gInfoView = nil
    end
    self.mImgToucher:SetActive(false)
end

function updateView(self)
    self:showDupList()
end

function showDupList(self)
    self:clearItemList()
    local dupList = infiniteCity.InfiniteCityManager:getDupList()
    local h = 0
    for i = 1, #dupList do
        local dupDataVo = dupList[i]
        -- if dupDataVo.isPass == 1 or dupDataVo.id == infiniteCity.InfiniteCityManager:getCurDupId() then
            local item = infiniteCity.InfiniteCitydupItem:poolGet()
            item:setData(self.mScollContentTrans, dupDataVo)
            table.insert(self.mDupItemList, item)
        -- end
    end
    self:scollToItem()
end

function clearItemList(self)
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        item:poolRecover()
    end
    self.mDupItemList = {}
end

function scollToItem(self, isShowInfo)
    local curDupId = infiniteCity.InfiniteCityManager:getCurDupId()
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        if curDupId == item:getData().id or (curDupId == 0 and i == #self.mDupItemList) then
            self:onScollTo(item, i, isShowInfo)
            break
        end
    end
end

function onScollTo(self, item, index, isShowInfo)
    local scollTo = function()
        if not item.UITrans then
            return
        end
        if self.mScollContentTrans.rect.size.x >= self.mScrollView.rect.size.x then
            local posX = -(item.UITrans.anchoredPosition.x - self.mScrollView.rect.size.x / (isShowInfo and 4 or 2))
            posX = math.min(posX, 0)
            posX = -math.min(math.abs(posX), self.mScollContentTrans.sizeDelta.x)
            TweenFactory:move2LPosX(self.mScollContentTrans, posX, 0.1 * index)
        end
    end
    self.frameId = LoopManager:addFrame(3, 1, self, scollTo)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
