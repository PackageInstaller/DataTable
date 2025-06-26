--[[
-----------------------------------------------------
@filename       : NavigationLink
@Description    : 导航栏
@date           : 2023-02-07 11:35:43
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.link.view.NavigationLink', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/NavigationLink.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构
function dtor(self)
end

function initData(self)
    self.mBtnList = {}
end

-- 初始化
function configUI(self)
    self.mGroupClose = self:getChildGO("mGroupClose")
    self.mBtnMainUI = self:getChildGO("mBtnMainUI")
    self.mBtnRecruit = self:getChildGO("mBtnRecruit")
    self.mGroupBtn = self:getChildTrans("mGroupBtn")

    self:setGuideTrans("funcTips_guide_NavigationLink_BtnMainUI", self.mBtnMainUI.transform)
    self:setGuideTrans("funcTips_guide_NavigationLink_BtnRecruit", self.mBtnRecruit.transform)
end

--激活
function active(self)
    super.active(self)
    if self.isOpen then
        self:onClickClose()
        return
    end
    self.isOpen = true
    self.mGroupClose:SetActive(true)
    self:updateView()
    self:addOnClick(self.mGroupClose, self.onClickClose)

    TweenFactory:move2LPosX(self:getChildTrans("mGroup"), 240, 0.2)
    TweenFactory:canvasGroupAlphaTo(self:getChildTrans("mGroup"):GetComponent(ty.CanvasGroup), 0, 1, 0.2)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.isOpen = false
    self:removeOnClick(self.mGroupClose)
    self:recoverBtnList()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onClickClose(self)
    self.mGroupClose:SetActive(false)
    TweenFactory:move2LPosX(self:getChildTrans("mGroup"), -300, 0.2)
    TweenFactory:canvasGroupAlphaTo(self:getChildTrans("mGroup"):GetComponent(ty.CanvasGroup), 1, 0, 0.2)
    self:deActive()
end

function updateView(self)
    self:recoverBtnList()
    local list = link.LinkManager:getNavigationList()
    table.sort(list, function(a, b)
        if a.id < b.id then
            return true
        end
    end)

    local redFlagDic = mainui.MainUIManager:getRedFlag()
    for i, v in ipairs(list) do
        if v.id == 1 then
            -- 主页
            self:setBtnLabel(self.mBtnMainUI, v.linkName, "主页")
            self:addOnClick(self.mBtnMainUI, function()
                self:onLinkController(v.linkId)
            end)

            self:setGuideTrans("funcTips_guide_NavigationLink_BtnItem" .. v.linkId, self.mBtnMainUI.transform)
        elseif v.id == 2 then
            -- 招募
            if funcopen.FuncOpenManager:isOpen(v.funcOpenId, false) then
                self:setBtnLabel(self.mBtnRecruit, v.linkName, "链接检索")
                self:addOnClick(self.mBtnRecruit, function()
                    self:onLinkController(v.linkId)
                end)
                self.mBtnRecruit:SetActive(true)
                self:updateBubble(self.mBtnRecruit, redFlagDic[v.funcOpenId], 182, 15)

                self:setGuideTrans("funcTips_guide_NavigationLink_BtnItem" .. v.linkId, self.mBtnRecruit.transform)
            else
                self.mBtnRecruit:SetActive(false)
            end
        else
            if funcopen.FuncOpenManager:isOpen(v.funcOpenId, false) then
                local item = SimpleInsItem:create(self:getChildGO("GroupBtnItem"), self.mGroupBtn, "NavigationLinkItem")

                self:setGuideTrans("funcTips_guide_NavigationLink_BtnItem" .. v.funcOpenId, item:getTrans())
                item:setText("mTxtName", v.linkName)
                item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("navigation/navigation_icon_0%s.png", v.iconId)), true)
                item:addUIEvent(nil, function()
                    self:onLinkController(v.linkId)
                end)
                self:updateBubble(item:getGo(), redFlagDic[v.funcOpenId], 80, 33)

                table.insert(self.mBtnList, item)
            end
        end
    end
end
-- 回收项
function recoverBtnList(self)
    if self.mBtnList then
        for i, v in pairs(self.mBtnList) do
            RedPointManager:remove(v:getGo().transform)
            v:poolRecover()
        end
    end
    self.mBtnList = {}

    RedPointManager:remove(self.mBtnRecruit.transform)
    self:removeOnClick(self.mBtnMainUI)
    self:removeOnClick(self.mBtnRecruit)

end

-- 更新红点
function updateBubble(self, btn, state, x, y)
    if state then
        RedPointManager:add(btn.transform, nil, x, y)
    else
        RedPointManager:remove(btn.transform)
    end
end

-- 注册页面的关闭所有方法
function setCloseAllCall(self, closeAllCall, closeAllCallThis)
    self.closeAllCall = closeAllCall
    self.closeAllCallThis = closeAllCallThis
end

-- 打开对应的UI
function onLinkController(self, linkId)
    if linkId == LinkCode.MainUI then
        -- 返回主页使用页面自己的关闭所有方法

        if self.closeAllCall then
            self.closeAllCall(self.closeAllCallThis)
        end
    else
        self:onClickClose()

        if gs.PopPanelManager.openUICode == linkId then
            logInfo("=========该UIcode已处于打开状态，故不做处理=========")
            return
        end

        GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
        if map.MapLoader:getCurSceneType() == MAP_TYPE.MAIN_CITY then
            -- 在主页的直接处理
            if self.closeAllCall then
                self.closeAllCall(self.closeAllCallThis)
            end
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = linkId})
        else
            self.mLinkId = linkId

            -- 在其他场景的需要等主场景加载完成才操作
            if self.closeAllCall then
                self.closeAllCall(self.closeAllCallThis)
            end
        end
    end
end

function onCloseAllFinish(self)
    if self.mLinkId ~= nil and self.mLinkId > 0 then
        mainui.MainUIManager:setWaitOpenUIcode(self.mLinkId)
        self.mLinkId = 0
    end
end

return _M
