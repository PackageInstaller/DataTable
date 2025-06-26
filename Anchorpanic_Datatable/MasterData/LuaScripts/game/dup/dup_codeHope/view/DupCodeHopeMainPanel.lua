--[[
-----------------------------------------------------
@filename       : DupCodeHopeMainPanel
@Description    : 代号·希望副本页面
@date           : 2021年5月10日 14:42:50
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('dup.DupCodeHopeMainPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52086))
    self:setBg("dup_codeHope_bg_2.jpg", false, "dup")
    self:setUICode(LinkCode.ChellengeCodeHope)
end

--析构
function dtor(self)
end

function initTabBar(self)
end

function initData(self)
    super.initData(self)
    self.tabData = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mGroupTab = self:getChildTrans("mGroupTab")
    self.mTabBarNode = self:getChildTrans("mTabBarNode")
    self.mScroll1 = self:getChildGO("mScroll1")

    self.mBtnHidden = self:getChildGO("mBtnHidden")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mAwardGroup = self:getChildGO("mAwardGroup")
    self.mAwardGroupAni = self:getChildGO("mAwardGroup"):GetComponent(ty.Animator)

    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)

    self:setGuideTrans("guide_DupCodeHopeMainPanel_Tab", self:getChildTrans("mTabBarNode"))
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    dup.DupCodeHopeManager:addEventListener(dup.DupCodeHopeManager.EVENT_DUP_INFO_UPDATE, self.updateView, self)
    GameDispatcher:addEventListener(EventName.OPEN_CODE_HOPE_AWARD, self.onShowAward, self)

    self:setTabbar()
    self:updateTabRed()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    dup.DupCodeHopeManager:removeEventListener(dup.DupCodeHopeManager.EVENT_DUP_INFO_UPDATE, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.OPEN_CODE_HOPE_AWARD, self.onShowAward, self)

    self.curPage = nil

    self.mArcScroll:deActive()
    self.mArcScroll = nil
    self.mAwardGroup:SetActive(false)

    self:clearTabItem()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtAwardTips.text = _TT(165) .. ":"--"查看奖励"

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mBtnEnter, self.onEnter)
    self:addUIEvent(self.mBtnHidden, self.hiddenAwardShow)
end

function setTabbar(self)
    self:clearTabItem()
    local data = dup.DupCodeHopeManager:getBaseData()
    local list = {}
    for i = 1, table.nums(data) do
        table.insert(list, {page = i, nomalLanId = data[i].name, selectLanId = data[i].selectName})
    end
    table.sort(list, function(a, b)
        return a.page < b.page
    end)

    for i, v in ipairs(list) do
        local tabItem = dup.DupCodeHopeTabItem:poolGet()
        tabItem:setData(self.mTabBarNode, v, self.onClickTabPage, self)
        self.tabData[v.page] = tabItem
    end

    if not self.mArcScroll then
        self.mArcScroll = ArcScrollList:new()
        self.mArcScroll:init(self.mScroll1)
        self.mArcScroll:setRenerder(dup.DupCodeHopeLevelItem)
        self.mArcScroll:SetSelectEvent(function(index)
            self:setTabTag(index)
        end)
        self.mArcScroll:SetBottomDragEvent(function(index)
            index = index + 1
            if index < #list then
                self:messageoPage(index)
            end
        end)

    end
    self.mArcScroll:setData(list)

    local chapter = dup.DupCodeHopeManager:curChapter()
    self.mArcScroll:SetMaxIndex(chapter)

    self:onClickTabPage(chapter)
end

function clearTabItem(self)
    for k, item in pairs(self.tabData) do
        item:poolRecover()
    end
    self.tabData = {}
end
-- 设置tab
function onClickTabPage(self, cusPage)
    if not self:messageoPage(cusPage) then return end

    self:setTabTag(cusPage)
    self.mArcScroll:SelectIndex(cusPage)
end

function messageoPage(self, index)
    local isOpen = dup.DupCodeHopeManager:getChapterIsOpen(index)
    if not isOpen then
        gs.Message.Show(_TT(29101))
        return false
    end
    return true
end

function setTabTag(self, index)
    for i, item in pairs(self.tabData) do
        item:setSelect(false)
    end

    local tabItem = self.tabData[index]
    tabItem:setSelect(true)

    return true
end

function updateView(self)
    self:setTabbar()
    self:updateInfo()
    self:updateTabRed()
end

function updateInfo(self)

end

function updateTabRed(self)
    for chapter, tab in pairs(self.tabData) do
        local isFlag = dup.DupCodeHopeManager:getChapterFlag(chapter)
        tab:updateRed(isFlag)
    end
end

-- 探索度奖励展示
function onShowAward(self, data)
    self.mAwardGroup:SetActive(true)
    if (self.mAwardGroup.activeSelf == true) then
        self:recoverPropsList()
        self.mBtnHidden:SetActive(true)
        for _, vo in ipairs(data.propsList) do
            local count = vo.count and vo.count or vo.num
            local propsGrid = PropsGrid:createByData({tid = vo.tid, num = count, parent = self.mAwardContent, isTween = true, showUseInTip = false})
            table.insert(self.mPropsList, propsGrid)
        end
        self.mTxtCondition.text = data.tip
        self.mAwardGroupAni:SetTrigger("enter")
    end
end

function recoverPropsList(self)
    if self.mPropsList then
        for i = 1, #self.mPropsList do
            self.mPropsList[i]:poolRecover()
        end
    end
    self.mPropsList = {}
end

function hiddenAwardShow(self)
    if self.mAwardGroup.activeSelf == true then
        local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAwardGroupAni, "AwardGroup_Enter")
        self.mAwardGroupAni:SetTrigger("exit")
        self:addTimer(aniTime, aniTime, function()
            self:recoverPropsList()
            self.mAwardGroup:SetActive(false)
            self.mBtnHidden:SetActive(false)
        end)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
